# Étape 1 : Utiliser une image Maven pour compiler l'application
FROM maven:3.9.5-eclipse-temurin-17 as build

# Définir le répertoire de travail pour la compilation
WORKDIR /app

# Copier tous les fichiers nécessaires pour la construction Maven
COPY . .

# Compiler le projet en générant un fichier .war
RUN mvn clean package -DskipTests

# Étape 2 : Utiliser une image Tomcat pour exécuter l'application
FROM tomcat:9.0-jdk17

# Copier le fichier .war dans le répertoire webapps de Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/app.war

# Exposer le port 8080
EXPOSE 8080

# Démarrer Tomcat
CMD ["catalina.sh", "run"]
