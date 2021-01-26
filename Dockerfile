FROM golang:1-alpine

ENV CHROME_BIN="/usr/bin/chromium-browser"

RUN set -x \
  && apk update \
  && apk upgrade \
  # replacing default repositories with edge ones
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  \
  # Add the packages
  && apk add --no-cache dumb-init curl make gcc g++ linux-headers binutils-gold gnupg libstdc++ nss chromium \
  && apk add --no-cache git vim \
  \
  # Cleanup
  && rm -rf /var/cache/apk/* /usr/share/man /tmp/*

ENTRYPOINT ["/usr/bin/dumb-init"]
