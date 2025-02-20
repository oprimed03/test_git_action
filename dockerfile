FROM ubuntu:22.04

RUN apt-get clean

# 시스템 패키지 업데이트 및 Python 3.10 설치
RUN apt-get update && apt-get install -y \
    pkg-config \
    libmysqlclient-dev \
    python3-dev \
    build-essential \
    software-properties-common \
    git \
    openssh-client \
    python3.10 \
    python3.10-dev \
    python3.10-distutils \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Python 3.10을 기본 python 명령어로 설정
RUN ln -s /usr/bin/python3.10 /usr/bin/python
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py && rm get-pip.py

# pip 최신 버전으로 업데이트
RUN python -m pip install --upgrade pip

# # 1. Python 3.10 기반 이미지 사용
# FROM python:3.10

# 2. 작업 디렉토리 설정
WORKDIR /app

# 3. 현재 폴더의 모든 파일을 컨테이너 내부로 복사
COPY . .

# 4. 필요한 패키지 설치
RUN pip install --no-cache-dir -r requirements.txt

# 5. 컨테이너 시작 시 실행할 명령어 설정
CMD ["python", "manage.py", "runserver"]
