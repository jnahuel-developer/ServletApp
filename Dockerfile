# Etapa 1: Construcción con Maven
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY . .  
RUN mvn clean package -DskipTests  

# Verifica si el archivo WAR realmente existe
RUN ls -l /app/target/

# Etapa 2: Contenedor final con Tomcat
FROM tomcat:9.0
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ServletApp.war
EXPOSE 8080
CMD ["catalina.sh", "run"]