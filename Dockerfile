FROM alpine:3.8

ARG UID=1000
ARG GID=1000

RUN addgroup -g $GID rtorrent && \
adduser -h /rtorrent -D -u $UID -G rtorrent -s /bin/sh rtorrent && \
apk add --no-cache --update supervisor nginx rtorrent php7-fpm php7 php7-json \
mediainfo curl unzip unrar ffmpeg && \
adduser nginx rtorrent && \
mkdir -p /etc/supervisor.d /rutorrent /run/nginx && \
chown -R rtorrent:rtorrent /rutorrent && \
rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf \
/etc/php7/php-fpm.conf /etc/php7/php-fpm.d/*

COPY supervisord.conf /etc/supervisor.d/rtorrent.ini

COPY nginx.conf /etc/nginx/nginx.conf

COPY rutorrent.conf /etc/nginx/conf.d/rutorrent.conf

COPY php-fpm.conf /etc/php7/php-fpm.conf

USER rtorrent

COPY .rtorrent.rc /rtorrent/.rtorrent.rc

RUN mkdir ~/watch ~/downloads ~/log ~/.session

EXPOSE 80 6881 49164-49174

USER root

WORKDIR /etc

CMD [ "supervisord" ]