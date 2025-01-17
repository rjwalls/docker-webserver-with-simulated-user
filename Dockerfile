FROM ubuntu/apache2 

RUN apt-get update \
    && apt-get -y install python3-dev python3-pip \
    && apt-get clean

RUN pip3 install selenium \
    && apt-get install -y wget \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
     | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" \ 
    >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install google-chrome-stable -y

# RJW: This will download a version 95.0.4638.69 of chromedriver. The chromedriver
# version (likely) needs to match the version of chrome installed above.
RUN apt-get install -y unzip \
    && wget -q -O /chromedriver.zip https://chromedriver.storage.googleapis.com/95.0.4638.69/chromedriver_linux64.zip \
    && unzip -qq -d/ /chromedriver.zip chromedriver \
    && rm /chromedriver.zip 

COPY startup.sh /
COPY run_user.py /
COPY html /var/www/html/

RUN chmod 755 /startup.sh
RUN chmod 755 /chromedriver

EXPOSE 80
CMD ./startup.sh
