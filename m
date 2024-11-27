Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A62D6ACF7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBA189817;
	Wed, 27 Nov 2024 18:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ADo9z2Rd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B3A896DC; Wed, 27 Nov 2024 18:23:09 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0C4897E8
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d40bdbb59dso86926d6.3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728184; x=1733332984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wexM5h4hYWUtNGORvMUiRfWBed9uzLUYrA7wwdjbd5g=;
 b=ADo9z2RdOWdOvFt5GNKZkkffr0tOR5FdMsF5pggCqOWckXNZ6UkdG0115aW2Of1PDb
 2FnkkfK5gVgLbWsPyytOOyHer2iR6tYq0awM+6071oGalkl8YiVnrLQgf4Gd0CiuA7FG
 Ht4x2vTTRcz+XHz9Talb4CjuQsCA9xpBFFxwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728184; x=1733332984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wexM5h4hYWUtNGORvMUiRfWBed9uzLUYrA7wwdjbd5g=;
 b=D6Y05u6y4eSS0QMKhDbn+CVitKjPFbWnwA8M4tM4uvCZ6z3NKwFucX2vQV9BeRckC8
 VQyK0bn53ZUzajfbYtqLSGh4dCC1FKXW6ybov+AimnrhmQk6ePVV1p7Lh00rM8ecAXXP
 P9kBc78JuHSSbvJEriTwu7rCA6vX+LduVBoUgbUgG+NLP80rv7Pti9+SbmZ+lY6ZIQ6F
 52EjYNzEeTOFSv15KlVrVRayFAGySDuY8UkWBeMCjHFEG2Tf/UDst07UjSJMNBVpvKGm
 nq+UHcityCJp55PcpfLnVnzyre5uRbnxLCgWviXJUuFT6uC+pNNN5rPuQ1bEtyv3hH8c
 f+eg==
X-Gm-Message-State: AOJu0YyTc5iyY56cAEB30Pw6BAvM0nUfbEx7QaKeljKZmoxSQRgGwIke
 aBivfbwzMkWo6BnBuY8eRJKEjZte/vUzojXHM3KgXGUXBFIztoYu3o3uz+0RuIVLZyggzhd4pGs
 cFKY=
X-Gm-Gg: ASbGnctRYN+kRAj4UWbmoTQ35F531hbzOvsvLNTzAvc6ub+5HqnGAZ5uRQ5i7YuBhgW
 TQfm60cA0L7mxMSNCK2q0q0/SxVftEM6LMh5yTGXP/hdLiU52H2+udBZZkaz3tcs3QgCFe7syPx
 9uW9p24gxakJoFYjSnFiJPqhkUgyl+FtEMycM2TI2vq/JHQgjiShWZrKt03nf8OYQD+ygFUSRLr
 ZFRy6vsxaYz3Dc2gnf7dbXrcJzzHja/l+Vh2m1vTRx2HXEe0XIC1MP7tantFPlUjZBxSMpK
X-Google-Smtp-Source: AGHT+IHf1bbSPmO20uSQ8RJInBLr5uUETlN09iBNtl4NW7YqTNahUGeqcQwAip147TUwrgbjCp0zwg==
X-Received: by 2002:a05:6214:4018:b0:6d4:36ff:435a with SMTP id
 6a1803df08f44-6d864d51c27mr40611636d6.23.1732728183069; 
 Wed, 27 Nov 2024 09:23:03 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:23:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 08/12] docker: Support building for multiple architectures
Date: Wed, 27 Nov 2024 11:17:26 -0600
Message-ID: <20241127172247.1488685-9-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Add instructions on how to build the file for multiple architectures.
Add a message indicating what is happening.

Update the documentation as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- None
---
 doc/build/docker.rst    | 23 +++++++++++++++++++++--
 tools/docker/Dockerfile |  9 +++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 45659b3b89dc..5896dd5ac4a6 100644
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
index bc8d1ebbb1e8..43cd37070e48 100644
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
 RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
     --mount=type=cache,target=/var/lib/apt,sharing=locked \
-- 
2.43.0

