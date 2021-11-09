node('build') {    
    git poll: true, url:'https://github.com/kimkangbo/test.git'
    withCredentials([[$class: 'UsernamePasswordMultiBinding',
        credentialsId: 'docker-hub',
        usernameVariable: 'DOCKER_USER_ID',
        passwordVariable: 'DOCKER_USER_PASSWORD']]) {
        stage('Pull') {
            git 'https://github.com/kimkangbo/test.git'
        }
        stage('Static Analysis') {
            try {
               sh(script: 'pylint app.py')
            } catch (e) {
               sh(script: 'echo Static Analysis failed. Check codes')
            }   
        }
        stage('Build') {
            sh(script: 'docker-compose build app')
        }
        stage('Tag') {
            sh(script: '''docker tag ${DOCKER_USER_ID}/ubuntu_flask ${DOCKER_USER_ID}/ubuntu_flask:${BUILD_NUMBER}''') 
        }
        stage('Push') {
            sh(script: 'docker login -u ${DOCKER_USER_ID} -p ${DOCKER_USER_PASSWORD}')
            sh(script: 'docker push ${DOCKER_USER_ID}/ubuntu_flask:${BUILD_NUMBER}')
            sh(script: 'docker push ${DOCKER_USER_ID}/ubuntu_flask:latest')
        }
    }
}

node('deploy') {    
    git poll: true, url:'https://github.com/kimkangbo/test.git'
    withCredentials([[$class: 'UsernamePasswordMultiBinding',
        credentialsId: 'docker-hub',
        usernameVariable: 'DOCKER_USER_ID',
        passwordVariable: 'DOCKER_USER_PASSWORD']]) {    
        stage('Deploy') {
            git 'https://github.com/kimkangbo/test.git'	
            sh(script: 'docker-compose up -d production')
        }
    }
}
