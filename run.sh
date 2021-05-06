#!/bin/sh

CONF_FILE=/etc/nginx/nginx.conf

# Get environment variables to show up in SSH session
eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)

sed -i "s/#LISTEN_PORT#/${LISTEN_PORT}/" ${CONF_FILE}

exec /usr/sbin/sshd &
php-fpm -d variables_order="EGPCS" && exec nginx -g "daemon off;"