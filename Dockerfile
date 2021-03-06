FROM ubuntu:latest

EXPOSE 80

# update and upgrade packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install mysql-server apache2 php5 php5-gd texlive-latex-recommended php5-imap unzip wget php5-mysql -y
RUN apt-get clean

RUN mkdir /var/lib/kOOL && cd /var/lib/kOOL && wget http://www.churchtool.org/fileadmin/user_upload/packages/kOOL_source_R45.zip && unzip kOOL_source_R45.zip
RUN cd /var/lib/kOOL && wget https://github.com/smarty-php/smarty/archive/v2.6.28.zip && unzip v2.6.28.zip
RUN mkdir /var/www/html/kOOL && cp /var/lib/kOOL/lib/install/kOOL_setup.sh /var/www/html/kOOL && cd /var/www/html/kOOL && bash ./kOOL_setup.sh

RUN mkdir /data

ADD ko-config.php /var/www/html/kOOL/config/ko-config.php
ADD setup.sh /var/lib/kOOL/setup.sh
RUN chmod 755 /var/lib/kOOL/setup.sh
ADD startup.sh /var/lib/kOOL/startup.sh
RUN chmod 755 /var/lib/kOOL/startup.sh

CMD ["/var/lib/kOOL/startup.sh"]
