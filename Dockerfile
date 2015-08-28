FROM heroku/cedar:14

RUN mkdir -p /app/user/bin && \
    mkdir -p /app/.cache/gotools && \
    mkdir -p /app/.profile.d

WORKDIR /app/user

ENV CADDYVERSION v0.7.5
ENV STACK cedar-14
ENV HOME /app/user
ENV PATH $HOME/bin:$PATH

RUN curl -s --retry 3 -L https://github.com/mholt/caddy/releases/download/$CADDYVERSION/caddy_linux_amd64.tar.gz | tar zxf - -C $HOME/bin caddy

COPY Procfile /app/user/Procfile
COPY run /app/user/bin/run
RUN chmod a+x /app/user/bin/run

ONBUILD COPY . /app/user
