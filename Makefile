# Docker Management Makefile
# This Makefile provides commands to easily manage Docker containers 
# defined in local.yml

.PHONY: up down restart ps logs clean help

# Default action when just 'make' is run
.DEFAULT_GOAL := help

# Start all containers in detached mode
up:
	docker-compose -f dev-docker/local.yml up -d

# Start all containers with logs visible
up-logs:
	docker-compose -f dev-docker/local.yml up

# Stop all containers
down:
	docker-compose -f dev-docker/local.yml down

# Restart all containers
restart:
	docker-compose -f dev-docker/local.yml restart

# Show running containers
ps:
	docker-compose -f dev-docker/local.yml ps

# View logs from all containers
logs:
	docker-compose -f dev-docker/local.yml logs

# Follow logs from all containers
logs-follow:
	docker-compose -f dev-docker/local.yml logs -f

# Show logs for a specific service
# Usage: make logs-service SERVICE=postgres
logs-service:
	docker-compose -f dev-docker/local.yml logs $(SERVICE)

# Follow logs for a specific service
# Usage: make logs-service-follow SERVICE=postgres
logs-service-follow:
	docker-compose -f dev-docker/local.yml logs -f $(SERVICE)

# Execute a command in a container
# Usage: make exec SERVICE=postgres CMD=psql
exec:
	docker-compose -f dev-docker/local.yml exec $(SERVICE) $(CMD)

# Shell into a container
# Usage: make shell SERVICE=postgres
shell:
	docker-compose -f dev-docker/local.yml exec $(SERVICE) sh

# Destroy containers, volumes, and networks
clean:
	docker-compose -f dev-docker/local.yml down -v

# Clean volumes but keep images
clean-volumes:
	docker-compose -f dev-docker/local.yml down -v

# Rebuild containers
rebuild:
	docker-compose -f dev-docker/local.yml up -d --build

# Display this help message
help:
	@echo "Available commands:"
	@echo "  make up                   - Start all containers in detached mode"
	@echo "  make up-logs              - Start all containers with logs visible"
	@echo "  make down                 - Stop all containers"
	@echo "  make restart              - Restart all containers"
	@echo "  make ps                   - Show running containers"
	@echo "  make logs                 - View logs from all containers"
	@echo "  make logs-follow          - Follow logs from all containers"
	@echo "  make logs-service         - Show logs for a specific service (use SERVICE=...)"
	@echo "  make logs-service-follow  - Follow logs for a specific service (use SERVICE=...)"
	@echo "  make exec                 - Execute a command in a container (use SERVICE=... CMD=...)"
	@echo "  make shell                - Shell into a container (use SERVICE=...)"
	@echo "  make clean                - Destroy containers, volumes, and networks"
	@echo "  make clean-volumes        - Clean volumes but keep images"
	@echo "  make rebuild              - Rebuild containers"
	@echo ""
	@echo "Examples:"
	@echo "  make logs-service SERVICE=postgres"
	@echo "  make exec SERVICE=postgres CMD='psql -U postgres -d crm_db'"
	@echo "  make shell SERVICE=postgres"