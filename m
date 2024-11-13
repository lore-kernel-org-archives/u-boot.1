Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6853CD637A9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B7A89386;
	Wed, 13 Nov 2024 19:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m1uqYc+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F28589386; Wed, 13 Nov 2024 19:54:00 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D51E88DDA
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a3a5cd2a3bso30119645ab.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524036; x=1732128836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uq+nvtieU4uKeLPHp5mDM+QzAvxsqZBzL9ntuXyhv5g=;
 b=m1uqYc+KJuy28x/IvoCAghHDAIVYm8eYBNIpzDOLFuJEgNFF+JtCwFVOnc8RxEWv48
 /RBf5KwSPyiRwJWWPX2PXP8FULT0zaVfTMOmncCv4l8etkqdoMY1C7Hx5hQSYGRSHgjV
 rx9lxWlJvU1ooZl1Cvmm9XnNSSg38noui5z4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524036; x=1732128836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uq+nvtieU4uKeLPHp5mDM+QzAvxsqZBzL9ntuXyhv5g=;
 b=MbVdofVuC0yNJsQdLiTCp4HDhhlWlpmG2UrozmfW11bcBiuULLwSminVCo0b+cpU8C
 xTYSW5MZgorfnjvmnFQTAm9EEHkfgyE9XUHaT006Co/FXbHOlh1L8WpPJr6s3NIFinKs
 Fw3m40WaUMemj3PXTSBaZ1tvSYYrgz7kC5lz7Fcind7jdg3ATfjU1WpCcGelWDcnwtLq
 r11DQUuAD8lzd24vwECu4d2S9EwPSIRoZDsgok51L3lqq0XKoVJCDK1AMPy+oAZqZcQv
 FvA03m9nOc3LFwYjeWWgCjMMdo+OtXyHkvEo3XgBZpWyU6PpwLAhXku4Z0DFcowe/u6A
 wmjg==
X-Gm-Message-State: AOJu0YxS17t+JPX0OWAuMtkDzFqHHZ+NJ6F7CV184vZgSO7s3tR681sA
 171OORJRAIEZvVmelcW+lBCPErWUBMqjzAqJr2Fg4KUp6b/G1MReghSMGb118vko8Y2gQ09LzrI
 =
X-Google-Smtp-Source: AGHT+IEh35VrKahDF0XtyVKUz0d+gA3TK0jvTeqL0J2q73D04UguRlmVr1M9fC+wPbs+5U5q0wq3YQ==
X-Received: by 2002:a92:2909:0:b0:3a7:15aa:4169 with SMTP id
 e9e14a558f8ab-3a715aa423emr38123485ab.23.1731524035698; 
 Wed, 13 Nov 2024 10:53:55 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:53:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v4 3/9] docker: Support building for multiple architectures
Date: Wed, 13 Nov 2024 11:53:34 -0700
Message-Id: <20241113185340.1661198-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113185340.1661198-1-sjg@chromium.org>
References: <20241113185340.1661198-1-sjg@chromium.org>
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

Update the documentation as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Leave the 'sudo' in

Changes in v3:
- Move ARGs to the top
- Revise documentation to explain a common error and building on arm64

Changes in v2:
- Update docs also
- Add comments to the ARG variables

 doc/build/docker.rst    | 25 ++++++++++++++++++++++---
 tools/docker/Dockerfile | 12 ++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 45659b3b89d..95ae394c563 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -1,14 +1,33 @@
 GitLab CI / U-Boot runner container
 ===================================
 
-In order to have a reproducible and portable build environment for CI we use a container for building in.  This means that developers can also reproduce the CI environment, to a large degree at least, locally.  This file is located in the tools/docker directory.  To build the image yourself
+In order to have a reproducible and portable build environment for CI we use a container for building in.  This means that developers can also reproduce the CI environment, to a large degree at least, locally.  This file is located in the tools/docker directory.
+
+The docker image supports both amd64 and arm64. Ensure that the
+'docker-buildx' Debian package is installed (or the equivalent on another
+distribution).
+
+You will need a multi-platform container, otherwise this error is shown::
+
+    ERROR: Multi-platform build is not supported for the docker driver.
+    Switch to a different driver, or turn on the containerd image store, and try again.
+
+You can add one with::
+
+    sudo docker buildx create --name multiarch --driver docker-container --use
+
+Building is supported on both amd64 (i.e. 64-bit x86) and arm64 machines. While
+both amd64 and arm64 happen in parallel, the non-native part will take
+considerably longer as it must use QEMU to emulate the foreign code.
+
+To build the image yourself::
 
 .. code-block:: bash
 
-    sudo docker build -t your-namespace:your-tag .
+    sudo docker buildx build --platform linux/arm64/v8,linux/amd64 -t your-namespace:your-tag .
 
 Or to use an existing container
 
 .. code-block:: bash
 
-    sudo docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
+    docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 967ac89fbde..7f4b17ab0a4 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,13 +2,25 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
+# Build with (for example):
+# docker buildx build --platform linux/arm64/v8,linux/amd64 --tag sjg20/u-boot-gitlab-ci-runner-multiarch:jammy-20240808-03Nov2024 .
+
 FROM ubuntu:jammy-20240808
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
+# Used by docker to set the target platform: valid values are linux/arm64/v8
+# and linux/amd64
+ARG TARGETPLATFORM
+
+# Used by docker to set the build platform: the only valid value is linux/amd64
+ARG BUILDPLATFORM
+
 # Make sure apt is happy
 ENV DEBIAN_FRONTEND=noninteractive
 
+RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
+
 # Add LLVM repository
 RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib/apt/lists/*
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
-- 
2.34.1

