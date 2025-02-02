#
# Cassandra Reaper Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV REAPER_VERSION=3.8.0
ENV REAPER_HOME=/opt/cassandra-reaper

# Update & install packages
RUN apt-get update && apt-get install -y wget default-jdk

# Téléchargez et extrayez Cassandra Reaper
RUN mkdir -p $REAPER_HOME && \
    cd /tmp/ && \
    wget https://github.com/thelastpickle/cassandra-reaper/releases/download/${REAPER_VERSION}/reaper_${REAPER_VERSION}_all.deb && \
    dpkg -i reaper_${REAPER_VERSION}_all.deb

# Copiez le fichier de configuration
COPY cassandra-reaper.yaml $REAPER_HOME/config/cassandra-reaper.yaml

# Définissez le répertoire de travail
WORKDIR $REAPER_HOME

# Exposez le port de Cassandra Reaper
EXPOSE 8080

# Démarrez Cassandra Reaper lors du démarrage du conteneur
CMD java -jar /usr/share/cassandra-reaper/cassandra-reaper-${REAPER_VERSION}.jar server /opt/cassandra-reaper/config/cassandra-reaper.yaml
