# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /react-docker-app

COPY mvnw .          
COPY .mvn/ .mvn
COPY pom.xml ./
COPY src ./src

# Give execute permission for mvnw
RUN chmod +x mvnw

RUN ./mvnw clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk

WORKDIR /react-docker-app
COPY --from=builder /react-docker-app/target/*.jar app.jar

EXPOSE 6004

ENTRYPOINT ["java", "-jar", "app.jar"]
