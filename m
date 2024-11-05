Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E12D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33DF3891F4;
	Tue,  5 Nov 2024 17:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K7snE2/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6087089025; Tue,  5 Nov 2024 17:07:58 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DD089208
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a6bdc8f7a1so12880215ab.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822872; x=1731427672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPX6yYyZLcHsMVj8Ozg6h7kidfyRQc+RW5rBPIXA9C8=;
 b=K7snE2/HnOU/b3kh/JTB9f8UUTKXQMANqUWxXKYSVma5JeAaUaFg7V45kA2YNfzoUP
 JsLE7df4uSV0xae7ef2bdhN5uXeU36hHxOqs2KlLLtFr55lRO8jXpa8GGa9RJYFmdbIv
 h0SCHmECNsxMW8Mgz9HBq/Z/kIF+83XDTXbiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822872; x=1731427672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tPX6yYyZLcHsMVj8Ozg6h7kidfyRQc+RW5rBPIXA9C8=;
 b=oHg4NDqjpf/ybxCo77KnpIHWSAjCKhYli9nJEpDxey8wJTZ0wIpketMofRXhZ5dHMX
 jrFmnAZ/sLsb04h25N4n63sd6nKpuOluyind4kXkyaHNaOnHR4KhwoD+B/GNU+0DXuVh
 E9oyDq6VGzPggN7iD5F9MsJm7DZPi0CmLCqzHpN/mS3GvYil75TYVowYEu1CGvD6AIPX
 Rz4i700B7MVEqa1UKxkuPBhCTtYvPpbRyDZHieHa5fNPxq38M4jK23yRO7m/jYbfQ2yA
 qdXTZxHfAVYmt5/hwUiPO1uhfYylO014kmp+OTCVZAM6s/vR5xKWhbIzbPimSOwzZ92/
 d9DQ==
X-Gm-Message-State: AOJu0Yy5UX8w7hLiiuaKyI828RVU1hRXE7ayKuY4LyXDWcHuBFASdgJp
 SURNg4g505TLU1SUoXPVEd18CI6Xp3NhmN3HSYbBgliVmtwcqx+ybX6EG3i9ItA4oKQICD9WEYY
 =
X-Google-Smtp-Source: AGHT+IF5o9AuBnxaWys65VpPpxbebm5a8oxa7LxpeRX0+zQHpVk/yzUWXUmogVz09/FPwes1PJCDpg==
X-Received: by 2002:a05:6e02:152:b0:3a6:ac4e:2659 with SMTP id
 e9e14a558f8ab-3a6ac4e280dmr134037805ab.6.1730822872313; 
 Tue, 05 Nov 2024 08:07:52 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:07:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 3/9] docker: Support building for multiple architectures
Date: Tue,  5 Nov 2024 09:07:32 -0700
Message-Id: <20241105160738.3795497-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105160738.3795497-1-sjg@chromium.org>
References: <20241105160738.3795497-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add instructions on how to build the file for multiple architectures.
Add a message indicating what is happening.

Update the documentation as well. Drop the 'sudo' since these should not
be needed if Docker is correctly configured.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update docs also
- Add comments to the ARG variables

 doc/build/docker.rst    | 16 +++++++++++++---
 tools/docker/Dockerfile | 12 ++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 45659b3b89d..b854fad43a9 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -1,14 +1,24 @@
 GitLab CI / U-Boot runner container
 ===================================
 
-In order to have a reproducible and portable build environment for CI we use a container for building in.  This means that developers can also reproduce the CI environment, to a large degree at least, locally.  This file is located in the tools/docker directory.  To build the image yourself
+In order to have a reproducible and portable build environment for CI we use a container for building in.  This means that developers can also reproduce the CI environment, to a large degree at least, locally.  This file is located in the tools/docker directory.
+
+The docker image supports both amd64 and arm64. Ensure that the
+'docker-buildx' Debian package is installed (or the equivalent on another
+distribution).
+
+Building is currently only supports on an amd64 machine (i.e. 64-bit x86). While
+both amd64 and arm64 happen in parallel, the arm64 part will take considerably
+longer as it must use QEMU to emulate the arm64 code.
+
+To build the image yourself::
 
 .. code-block:: bash
 
-    sudo docker build -t your-namespace:your-tag .
+    docker buildx build --platform linux/arm64/v8,linux/amd64 -t your-namespace:your-tag .
 
 Or to use an existing container
 
 .. code-block:: bash
 
-    sudo docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
+    docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 967ac89fbde..540718df062 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,6 +2,9 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
+# Build with (for example):
+# docker buildx build --platform linux/arm64/v8,linux/amd64 --tag sjg20/u-boot-gitlab-ci-runner-multiarch:jammy-20240808-03Nov2024 .
+
 FROM ubuntu:jammy-20240808
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
@@ -9,6 +12,15 @@ LABEL org.opencontainers.image.description=" This image is for building U-Boot i
 # Make sure apt is happy
 ENV DEBIAN_FRONTEND=noninteractive
 
+# Used by docker to set the target platform: valid values are linux/arm64/v8
+# and linux/amd64
+ARG TARGETPLATFORM
+
+# Used by docker to set the build platform: the only valid value is linux/amd64
+ARG BUILDPLATFORM
+
+RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
+
 # Add LLVM repository
 RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib/apt/lists/*
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
-- 
2.34.1

