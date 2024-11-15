Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7331BD6DDFA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09AD8935E;
	Fri, 15 Nov 2024 14:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ne6xtNRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B5F8935E; Fri, 15 Nov 2024 14:48:20 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1011188B6D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83ab00438acso51068539f.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731678496; x=1732283296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7KvZevY/4R5NEXZXzNfaFdgzOePTc1RGa0JRnZSRJQ=;
 b=Ne6xtNRofzZORuJZyNsqegPzfU5mWUcoFPHF2b8pSlK7qekokdtUGvybdb+kyaScEc
 f0aM8AjcFzB5FvRxhY9HAcX1ttxi7H6WQtboL00kerCceSZwnzBxk8VQvJRUovw60w0B
 vV1OVDv9O1Grznk9MWcwVsomreW3S/wPT/+os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731678496; x=1732283296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7KvZevY/4R5NEXZXzNfaFdgzOePTc1RGa0JRnZSRJQ=;
 b=gN1Ky1aEri38JSqEt3JjQEyhHicrVRu4oJN+p/GynHvFJhHsjmIdU401YCBJ8Q3Ebv
 oLqjqAQv8rOjQB9Oi8zwqBSIePGEGB3r//ydaLgbbiDkUAICEnn7RPbeXsoAAk1Sucej
 f/IueKj8xDhK9G1MkW3KuJw2d17Eg+u8GvSWodiU3Z8eCR5cZr/MN+hc7W0lVXuDdDd1
 3NClGGYeuj4hwggsDK51Eqyh7MzkshG83J1pUCoV9rlTDZXqFATdGompEDpxJbZo9vMY
 9rlzP47UDuauat8AeHn++hCXCHUQvaCicUljTME3x5+P84OM96iTYpL26hCnx/h9oRtK
 pSWQ==
X-Gm-Message-State: AOJu0YxpIrmzt+aS1IyF0lYTiSfMeKrSc5p/2zSa0SzImFVcd0H7W0jP
 j1qK9ySOYDnkjP3DjWQik3pivS99MU9MTXYPkjir8y18K6f3d5zpsKElMD6W6swMwzKN95yVM1k
 =
X-Google-Smtp-Source: AGHT+IE3UGPrUqDXIWJevIbHHg+mT9N9NdPq8n283iFfh8I4+8blERx2dCae/pWZsMitHoPX5hOt2w==
X-Received: by 2002:a05:6602:160e:b0:7f6:8489:2679 with SMTP id
 ca18e2360f4ac-83e6c1d881bmr236679339f.8.1731678496253; 
 Fri, 15 Nov 2024 05:48:16 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df91554sm34118439f.9.2024.11.15.05.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:48:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v5 1/6] docker: Support building for multiple architectures
Date: Fri, 15 Nov 2024 06:48:02 -0700
Message-Id: <20241115134807.3068947-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115134807.3068947-1-sjg@chromium.org>
References: <20241115134807.3068947-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v5:
- Drop the comment in the gitlab file
- Add back a final missing sudo

Changes in v4:
- Leave the 'sudo' in

Changes in v3:
- Move ARGs to the top
- Revise documentation to explain a common error and building on arm64

Changes in v2:
- Update docs also
- Add comments to the ARG variables

 doc/build/docker.rst    | 23 +++++++++++++++++++++--
 tools/docker/Dockerfile |  9 +++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 45659b3b89d..5896dd5ac4a 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -1,11 +1,30 @@
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
 
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 967ac89fbde..15e2a5c98d6 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -6,9 +6,18 @@ FROM ubuntu:jammy-20240808
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

