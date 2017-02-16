FROM drupal:7

#needed for drush to talk to db
RUN apt-get update && apt-get install -y mysql-client

RUN curl -sS https://getcomposer.org/installer | php && \
	mv composer.phar /usr/local/bin/composer && \
	ln -s /usr/local/bin/composer /usr/bin/composer && \
	echo "deb http://httpredir.debian.org/debian jessie main contrib" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get install git -y && \
	git clone --depth 1 https://github.com/drush-ops/drush.git /usr/local/src/drush && \
	ln -s /usr/local/src/drush/drush /usr/bin/drush && \
	cd /usr/local/src/drush && composer install
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini
    
#Current LII conventions	
RUN mkdir -p /usr/local/projects
RUN mkdir -p /var/data/json
RUN mkdir -p /var/www/html/ajax



