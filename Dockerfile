FROM python:3.9-slim

#Create a working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY service/ ./service

#switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]