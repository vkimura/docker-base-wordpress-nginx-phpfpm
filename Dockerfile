# Base-Image
FROM ubuntu:22.04

# Install Packages
RUN apt-get update && apt-get install -y \
    nginx \
    php-fpm \
    php-gd \
    php-mysqli \
    php-pdo \
    php-zip \
    php-opcache \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    curl \
    unzip \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Nginx Config
COPY nginx.conf /etc/nginx/nginx.conf

# WordPress
WORKDIR /var/www/html
RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -zxvf latest.tar.gz \
    && rm latest.tar.gz \
    && chown -R www-data:www-data wordpress

# Starting Script
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Port
EXPOSE 80

# Start
CMD ["/usr/local/bin/start.sh"]
