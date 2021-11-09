FROM python:3
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
RUN apt-get update
RUN apt-get -y install pylint
COPY . .
EXPOSE 5000
CMD [ "python3", "app.py" ]
