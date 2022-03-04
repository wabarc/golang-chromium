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
  && apk add --no-cache dumb-init dbus curl make gcc g++ linux-headers binutils-gold gnupg libstdc++ nss chromium \
  && apk add --no-cache git vim tor wget ca-certificates libressl freetype ttf-freefont font-noto-emoji font-noto-cjk \
  && apk add --no-cache ffmpeg libwebp-dev youtube-dl you-get xvfb dbus-x11 \
  \
  && ln -sf /usr/bin/chromium-browser /usr/bin/chromium \
  && ln -sf /usr/bin/chromium-browser /usr/bin/chrome \
  \
  # Cleanup
  && rm -rf /var/cache/apk/* /usr/share/man /tmp/*

ENTRYPOINT ["/usr/bin/dumb-init"]
