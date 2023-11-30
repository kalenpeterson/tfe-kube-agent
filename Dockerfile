# Start with base Image
FROM docker.io/alpine:3.18

# Set ENV Vars
ENV TF_AGENT_VERSION=1.14.1

# Switch to root for Installs
USER 0

# Update packages
RUN apk update && apk upgrade

# Set tfc user
RUN addgroup --system tfc-agent && adduser --system tfc-agent tfc-agent
USER tfc-agent
WORKDIR /home/tfc-agent

# Download the TFC Agent
ADD --chown=tfc-agent https://releases.hashicorp.com/tfc-agent/${TF_AGENT_VERSION}/tfc-agent_${TF_AGENT_VERSION}_linux_amd64.zip ./install.zip

# Install the tfc Agent
RUN unzip ./install.zip && \
    rm -f ./install.zip

ENTRYPOINT /home/tfc-agent/tfc-agent -name ${HOSTNAME}
