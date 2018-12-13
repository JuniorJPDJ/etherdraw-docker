FROM node:alpine

# Get Etherdraw's other dependencies
#RUN apt-get install -y git-core libpango1.0-dev build-essential supervisor 
RUN apk update && apk upgrade && apk add git supervisor alpine-sdk pango

# Grab the latest Git version
RUN cd /opt && git clone https://github.com/JohnMcLear/draw.git etherdraw

# Install node dependencies
RUN /opt/etherdraw/bin/installDeps.sh

# Add conf files
ADD supervisor.conf /etc/supervisor/supervisor.conf
ADD settings.json /opt/etherdraw/settings.json

EXPOSE 9002
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf", "-n"]
