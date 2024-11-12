Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAD5D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5F989468;
	Tue, 12 Nov 2024 15:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IxE6lq93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37398943F; Tue, 12 Nov 2024 15:11:20 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B698944B
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83aa3ced341so212639339f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420676; x=1732025476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPtKND5VfOaQX5F+AetuAfaHyvQgHWYUO8/YhNNL0Zw=;
 b=IxE6lq93YpUVOBBKdW/2pW01EY8Up+TV5DEsdoKazTJdlXg4T08BkNundSfHG4lWVR
 BeieGOILOWURF97vQWa1x7eAidZDYj3q07MwlXVL9KTb+qblr5QR7gj2kDaXU2m1ZRNU
 sf9hQsQ72NiyRTg6xA6cmEg6Fwu3kJOIL3D9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420676; x=1732025476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPtKND5VfOaQX5F+AetuAfaHyvQgHWYUO8/YhNNL0Zw=;
 b=BXQillYrKSf5zlbyobEocMPfHoRKE3caoib5EoMCITrlHEt36RoIK+AKe/0yEkOM82
 fEfxLwNxWHCk3ILN0SJudFivVjvh1DiAukBZp5hb+xpGauD00lGiTYq1ZRKnUmZym9y6
 Vx/La5agP8XS3+XyO/VqCN/Soe0jsJndz9j+pRQUZrxPVNCEN4QFqQdetLl/d7FJe8uZ
 PRCLt0QQUFIuabbwKqvObzOyfMb5JiEeN+nRswpOU1wnoagID8lTXX3o6cOPSzGUGLi5
 wFGeRc190xCjMvPcfUPegVVAlN08JUXMXXcLW8ZcniaTlV9nbu4z/1T3T1S5kDa/RrX+
 eU5A==
X-Gm-Message-State: AOJu0Yy37eQHJun6sn3I7mlS4ISGOwTekwAHEM5H+4trxqoHCUdxr3bO
 Ey8jYESb16N67bPzj2M5LgmIBi+D7IN4VDsYcboRf3iRUdSm8XtSR2KGMJge1Cr2c5YZvSkF1Dc
 =
X-Google-Smtp-Source: AGHT+IGVwO1C8yP3DdWbNe25zO1kZzU6sRB9ghWvCCCzHqlxCCLENVDmokmC09FiLcIKToKqgOomQQ==
X-Received: by 2002:a05:6602:3fd0:b0:83a:639b:bc44 with SMTP id
 ca18e2360f4ac-83e03289e44mr1917993739f.3.1731420676225; 
 Tue, 12 Nov 2024 06:11:16 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 3/9] docker: Support building for multiple architectures
Date: Tue, 12 Nov 2024 07:10:59 -0700
Message-Id: <20241112141105.640189-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141105.640189-1-sjg@chromium.org>
References: <20241112141105.640189-1-sjg@chromium.org>
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
index 45659b3b89d..b8fd12ead71 100644
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
+    docker buildx create --name multiarch --driver docker-container --use
+
+Building is supported on both amd64 (i.e. 64-bit x86) and arm64 machines. While
+both amd64 and arm64 happen in parallel, the non-native part will take
+considerably longer as it must use QEMU to emulate the foreign code.
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

