FROM frolvlad/alpine-java 
LABEL maintainer="Narayan Punekar"
LABEL description="This Dockerfile installs MavenEnterpriseAppOne"
COPY ./MavenEnterpriseAppOne-ear/target/MavenEnterpriseAppOne-ear-1.0-SNAPSHOT.ear EnterpriseAppOne.ear  
ENTRYPOINT ["java", "-jar", "EnterpriseAppOne.ear"] 
