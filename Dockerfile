FROM wordpress:php8.0-fpm-alpine

WORKDIR /tmp/
RUN set -xe; \
  apk --no-cache update && apk --no-cache upgrade \
  && apk add --no-cache --virtual .build-deps ${PHPIZE_DEPS} \
  && pecl install redis \
  && docker-php-ext-enable redis  \
  # Cleanup build deps
  && apk del .build-deps \
  && rm -rf /tmp/* /var/cache/apk/*

