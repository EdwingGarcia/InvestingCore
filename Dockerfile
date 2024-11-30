# Usa una imagen base con Maven y OpenJDK 17
FROM maven:3.8.6-openjdk-17-slim AS builder

# Establece el directorio de trabajo
WORKDIR /Inversiones

# Copia los archivos del proyecto al contenedor
COPY . /Inversiones

# Ejecuta el build con Maven
RUN mvn clean package -DskipTests

# Usa una imagen más ligera para correr la aplicación
FROM openjdk:17-jre-slim

# Copia el archivo JAR generado
COPY --from=builder /Inversiones/target/Inversiones-0.0.1-SNAPSHOT.jar /Inversiones.jar

# Define el comando para ejecutar la app
ENTRYPOINT ["java", "-jar", "/Inversiones.jar"]
