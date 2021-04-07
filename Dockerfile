FROM maven:3.6.3-openjdk-11-slim as builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ /app/src/
RUN mvn package
FROM adoptopenjdk/openjdk11:jre-11.0.8_10-alpine
COPY --from=builder /app/target/*.jar /thret-blog.jar
CMD ["java", "-jar", "/thret-blog.jar"]
