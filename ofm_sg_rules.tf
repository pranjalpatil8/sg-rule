
# Middleware-Production-LoadBalancer-sg

# Egress traffic from Sonarqube Server to ALB
resource "aws_security_group_rule" "egress-sonarqubeserver-ALB" {
    description      = "Egress traffic from Sonarqube server to ALB"

    type             = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-LoadBalancer-sg.id
}

# Egress traffic from Jenkins Server to ALB
resource "aws_security_group_rule" "egress-Jenkinsserver-ALB" {
    description      = "Egress traffic from jenkins to ALB"

    type             = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id =  aws_security_group.Middleware-Production-Jenkins-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-LoadBalancer-sg.id
}




#---------------------------------------------------------------------------------------#

# Middleware-Production-Bastion-Host-sg

#----------------------------------------------------------------#
# Egress Traffic from Bastion to Jenkins-agent
resource "aws_security_group_rule" "egress-Bastion-jenkins-agent" {
    description      = "Egress traffic from Bastion to Agent Server"

    type             = "egress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-Bastion-Host-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Jenkins-agent-sg.id
}

# Ingress from Bastion to JenkinsServer
resource "aws_security_group_rule" "ingress-Bastion-Jenkinserver" {
    description      = "Ingress from Bastion to JenkinsServer"
    type             = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_group_id =  aws_security_group.Middleware-Production-Jenkins-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Bastion-Host-sg.id
}


# Egress Traffic from Bastion to Sonarqube
resource "aws_security_group_rule" "egress-Bastion-Sonarqubeserver" {
    description      = "Egress traffic from Bastion to Sonarqube Server"

    type             = "egress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-Bastion-Host-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
}

#-----------------------------------------------------------------------------#

# Middleware-Production-Jenkins-agent-sg

# Ingress traffic to Jenkins Agent from Sonarqube server

resource "aws_security_group_rule" "ingress-Sonarqube-Jenkinsagent" {
    description      = "ingress traffic from Sonarqube to Jenkinsagent"

    type             = "ingress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Jenkins-agent-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
}

# Ingress Traffic from Jenkins Server to agent
resource "aws_security_group_rule" "ingress-Jenkinsserver-Agent" {
    description      = "Ingress traffic from Jenkins Server to Agent"

    type             = "ingress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Jenkins-agent-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
}





# Ingress from Bastion to Jenkins Agent
resource "aws_security_group_rule" "ingress-Bastion-jenkins-agent" {
    description      = "Ingress traffic from Bastion to Jenkinsagent"

    type             = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-Jenkins-agent-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Bastion-Host-sg.id
}

# Egress from Jenkins agent to Jenkins Master
resource "aws_security_group_rule" "egress-agent-Jenkinsserver" {
    description      = "Egress traffic from Jenkins agent to Jenkins server"

    type             = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Jenkins-agent-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
}



#------------------------------------------------------------

# Middleware-Production-Jenkins-sg

# Ingress from Bastion to JenkinsServer
resource "aws_security_group_rule" "ingress-Bastion-JenkinserverJenkins Server" {
    description      = "Ingress from Bastion to JenkinsServer"
    type             = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_group_id =  aws_security_group.Middleware-Production-Jenkins-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Bastion-Host-sg.id
}

# Ingress Traffic from ALB to Jenkins Server
resource "aws_security_group_rule" "ingress-ALB-Jenkinsserver8080" {
    description      = "Ingress traffic from ALB to Jenkins server8080"

    type             = "ingress"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-LoadBalancer-sg.id
}

# Ingress traffic from Sonarqube server to Jenkins Server 
resource "aws_security_group_rule" "ingress-Sonarqube-Jenkinsserver" {
    description      = "ingress traffic from Sonarqube to Jenkinsserver"

    type             = "ingress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
}

# Ingress Traffic from Jenkins agent to Jenkins Server
resource "aws_security_group_rule" "ingress-JenkinsAgent-Jenkins Server" {
    description      = "Ingress traffic from Jenkins agent to Jenkins Server"

    type             = "ingress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Jenkins-agent-sg.id
}

# Egress Traffic from Jenkins server to EFS
resource "aws_security_group_rule" "egress-EFS-Jenkinsserver" {
    description      = "Egress traffic from Jenkins to EFS server"
    type             = "egress"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-EFS-sg.id
}

# Egress Traffic from Jenkins server to Internet
resource "aws_security_group_rule" "Egress-Jenkins-Server" {
    description      = "Egres from Jenkins to Internet" 
    type             = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id =  aws_security_group.Middleware-Production-Jenkins-sg.id
    cidr_blocks       = ["0.0.0.0/0"]
}

# Egress Traffic from Load Balancer to Jenkins Server
resource "aws_security_group_rule" "Egress-LB-JenkinServer" {
    description      = "Egress traffic from ALB to JenkinsServer"
    type             = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id =  aws_security_group.Middleware-Production-LoadBalancer-sg.id

    source_security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
}

#-----------------------------------------------------------#

#Middleware-Production-Sonarqube-sg

# Ingress from ALB to Sonarqube Server
resource "aws_security_group_rule" "ingress-ALB-Sonarqubeserver9000" {
    description      = "Ingress traffic from ALB to sonarqube server9000"

    type             = "ingress"
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-LoadBalancer-sg.id
}

# Ingress from Bastion to Sonarqube server
resource "aws_security_group_rule" "ingress-Bastion-Sonarqubeserver" {
    description      = "Ingress from Bastion to Sonarqube Server"
    type             = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Bastion-Host-sg.id
}

# Ingress from Jenkins server to Sonarqube
resource "aws_security_group_rule" "ingress-jenkinsserver-Sonarqube" {
    description      = "ingress traffic from Jenkins Server to Sonarqube"

    type             = "ingress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
}

# Ingress traffic from Jenkins agent to Sonarqube Server
resource "aws_security_group_rule" "ingress-agent-sonarqube" {
    description      = "ingress traffic from agent to Sonarqube"

    type             = "ingress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Jenkins-agent-sg.id
}


# Egress traffic to ALB from Sonarqube Server 
resource "aws_security_group_rule" "egress-sonarqubeserver-ALB" {
    description      = "Egress traffic to ALB from Sonarqube server "

    type             = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-LoadBalancer-sg.id
}

#---------------------------------------------------------------------------------------#


#-------------------------------------------
## Middleware-Production-PostgresRDS-sg

# Ingress from Sonarqube server to RDS
# resource "aws_security_group_rule" "ingress-Sonrqubeserver-RDS" {
#     description      = "Ingress traffic from Sonarqube to RDS"

#     type             = "ingress"
#     from_port        = 5432
#     to_port          = 5432
#     protocol         = "tcp"
#     security_group_id = aws_security_group.Middleware-Production-PostgresRDS-sg.id
#     source_security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
# }

# # Egress from RDS to Sonarqube Server
# resource "aws_security_group_rule" "egress-RDS-Sonaqubeserver" {
    
#     description      = "Egress traffic from RDS to Sonarqube"

#     type             = "egress"
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     security_group_id = aws_security_group.Middleware-Production-PostgresRDS-sg.id
#     source_security_group_id = aws_security_group.Middleware-Production-Sonarqube-sg.id
# }
#-------------------------------------------------#


# Middleware-Production-Redis-sg

# Ingress traffic from Kubernetes to redis
# resource "aws_security_group_rule" "ingress-kubernetes-redis" {
#     description      = "ingress traffic from Kubernetes to Redis"

#     type             = "ingress"
#     from_port        = 6379
#     to_port          = 6379
#     protocol         = "tcp"
#     security_group_id = aws_security_group.Middleware-Production-Redis-sg.id
#     source_security_group_id = aws_security_group.Middleware-EKS-Securitygroup.id
# }

# Ingress traffic from Bastion Host to redis
resource "aws_security_group_rule" "ingress-Bastion Host-redis" {
    description      = "ingress traffic from Bastion Host to Redis"

    type             = "ingress"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-Redis-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Bastion-Host-sg.id
}
#-----------------------------

# Middleware-Production-EFS-sg 

# Ingress traffic from Internet to Jenkins server
resource "aws_security_group_rule" "ingress-EFS-Jenkinsserver" {
    description      = "Ingress traffic from Internet to Jenkins server"

    type             = "ingress"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_group_id = aws_security_group.Middleware-Production-EFS-sg.id
    source_security_group_id = aws_security_group.Middleware-Production-Jenkins-sg.id
}

# There is no egress traffic

