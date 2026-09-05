FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build && npm i -g supergateway
CMD supergateway --stdio "node dist/index.js" \
    --outputTransport streamableHttp \
    --streamableHttpPath "$MCP_PATH" --healthEndpoint /healthz --port 8000
