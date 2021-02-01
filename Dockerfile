
#
# Build
#
FROM maven:3.6.3-openjdk-14 AS build

COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:14-jdk-slim
COPY --from=build /home/app/target/order-service-1.0.0.jar /usr/local/lib/app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]