pipeline {
    agent any  
    options { timeout(time: 30) }
    stages {
        stage("Stage One") {
            steps {
                sleep 30
            }
        }
        stage("Stage Two") {
            steps {
                echo 'Step 1. Hello World'
            }
        }
        stage("Checkout") {
            steps {
                echo 'git url: https://github.com/narayanpunekar/EnterpriseAppOne.git'
                git url: 'https://github.com/narayanpunekar/EnterpriseAppOne.git'
            }
        }
        stage("Compile") {
            steps {
                sh "/var/jenkins_home/tools/hudson.tasks.Maven_MavenInstallation/maven363/bin/mvn clean compile"
            }
        }
		stage("Package") {
            steps {
                sh "/var/jenkins_home/tools/hudson.tasks.Maven_MavenInstallation/maven363/bin/mvn package"
            }
		}
		stage("Docker build") {
			steps {
				sh "docker build -f ExecDockerfile -t npunekar/messages-enterprise-app ."
			}
		}
		stage("Docker push") {
			steps {
				sh "cat ./password | docker login --username npunekar --password-stdin"  
				sh "docker push npunekar/messages-enterprise-app"
				sh "docker logout" 
			}
		}
		stage("Deploy to staging") {
			steps { 
				//sh "docker container rm -f messages-enterprise-app" 
				sh "docker rmi \$(docker images -f \"dangling=true\" -q)" 
				sh "docker run -d -p 9090:8080 -e JAVA_OPTS='-Xms512M -Xmx1024M' --name messages-enterprise-app npunekar/messages-enterprise-app"
			}
		}
    }
    post {
        always {
            mail to: 'narayan.v.punekar@gmail.com',
            subject: "Completed Pipeline: ${currentBuild.fullDisplayName}", 
            body: "Build completed, ${env.BUILD_URL}"
        }
    }
} 

