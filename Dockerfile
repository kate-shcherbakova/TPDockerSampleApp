# specify the base image
FROM ubuntu

# set the working directory
WORKDIR /app
# copy application files to the container
COPY . /app

# specify dependencies
RUN apt-get update && apt-get install -y openjdk-8-jdk && apt-get install -y maven && apt-get install -f libpng16-16

RUN mvn install:install-file -Dfile=./lib/opencv-3410.jar -DgroupId=org.opencv -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar
RUN mvn package

EXPOSE 8081

# specify default executable
ENTRYPOINT ["java","-Djava.library.path=lib/ubuntuupperthan18/","-jar", "target/fatjar-0.0.1-SNAPSHOT.jar"]