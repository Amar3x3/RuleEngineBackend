# Use an official OpenJDK runtime as a parent image
#FROM openjdk:17-jdk-alpine
FROM maven:3.8.5-openjdk-17 AS Build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build target/RuleEngineBackend-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080

# Command to run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
# Set the working directory inside the container
#WORKDIR /app
#
## Copy the Maven build output (JAR file) from the target directory
#COPY target/RuleEngineBackend-0.0.1-SNAPSHOT.jar app.jar
#
#
#
#
## Expose the port the Spring Boot app runs on (8080 by default)
#EXPOSE 8080
#
## Command to run the Spring Boot app
#ENTRYPOINT ["java", "-jar", "app.jar"]
