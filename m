Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45944D637A9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A50A98931D;
	Wed, 13 Nov 2024 19:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jKC8LYFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5797E8936F; Wed, 13 Nov 2024 19:54:03 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C25D788216
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a6bfc1dc8eso26747685ab.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524038; x=1732128838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIP5+v4nevhOp8XUafozU4jwBnoN0fRKua85r3rxxps=;
 b=jKC8LYFEfSGzNqmoPp41FtaVDzM0UYswEwuujnyQAkgBjCW97cu9BS4nmP43F2ymPZ
 yUjhwzfBwJzNsgEQumQeZp/AykfTOqumAS+CEj2NSk34lLA2CMNQPv0WG5I/I/zmDVkn
 rqJF2JJBZMbqWJnc6mtJtQC2ymlVThMKsWGDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524038; x=1732128838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIP5+v4nevhOp8XUafozU4jwBnoN0fRKua85r3rxxps=;
 b=Fr2Xe+SSVsxIENSg/9iu3zNwNAbzk8zXVaWYYTl9nLn8Ay8PsSJHqSX30Cv5AFHVq0
 /5U2fg6BGxC5ccPRevRXo3f97LRY/FLDtQw2uHYb8I3ePHk96sCuZsT9hUiSjNHuwD7z
 urZET9fh8RkIEwxbGzq76RQxk+JK8e9VXEfnBnEYpOlOerjhY2kR6/nj3TAvv82DcyGS
 WpbzkALfx49F3i+Hp1MaBBav7AGGEL/Ht9ndN3WpZp1G9CTDJuflq8+m+MarQjEMbkQR
 1qICGQUyBeuKs7HAGaXr8yxeOk8RnZ+YmT+fWplIudv/Cy75MN8ZhBLWiXWeDOOpAYxC
 4TxQ==
X-Gm-Message-State: AOJu0YzPpE93mldUIKbCLJV7Ge9fvezn6e4iugf+nYzxCLDbTkEljdoY
 s3jf5bcT4Y6Tx8yDwZW07EqRHoIyWof6C1EXdpb0jldikIbe4OYdPHfPAL2owwQTX1mPpXLQS/M
 =
X-Google-Smtp-Source: AGHT+IHM5ZQC32KRm3D0JkZzX0LN8Fo5QrqubGZ2aDzvf9cYDwVJ/tZcrJdW7ph2pU8kOl4Buo7h9g==
X-Received: by 2002:a05:6e02:1886:b0:3a4:e75c:c9d5 with SMTP id
 e9e14a558f8ab-3a6f18d894cmr197604305ab.0.1731524038479; 
 Wed, 13 Nov 2024 10:53:58 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:53:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 4/9] docker: Adjust packages for arm64
Date: Wed, 13 Nov 2024 11:53:35 -0700
Message-Id: <20241113185340.1661198-5-sjg@chromium.org>
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

The package names are slightly different for arm64 and we don't seem to
have a linux-image-kvm package. Provide some extra ones for x86

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v3)

Changes in v3:
- Use grub-efi and linux-image-generic for both archs

Changes in v2:
- Swap order so that amd64 is the exception

 tools/docker/Dockerfile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 7f4b17ab0a4..fd4835e9562 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -44,7 +44,10 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
 RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
 
 # Update and install things from apt now
-RUN apt-get update && apt-get install -y \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+		EXTRA_PACKAGES="grub-efi-ia32-bin libc6-i386"; \
+	fi; \
+	apt-get update && apt-get install -y \
 	automake \
 	autopoint \
 	bc \
@@ -70,13 +73,11 @@ RUN apt-get update && apt-get install -y \
 	gnu-efi \
 	gnutls-dev \
 	graphviz \
-	grub-efi-amd64-bin \
-	grub-efi-ia32-bin \
+	grub-efi \
 	help2man \
 	iasl \
 	imagemagick \
 	iputils-ping \
-	libc6-i386 \
 	libconfuse-dev \
 	libgit2-dev \
 	libjson-glib-dev \
@@ -94,7 +95,7 @@ RUN apt-get update && apt-get install -y \
 	libtool \
 	libudev-dev \
 	libusb-1.0-0-dev \
-	linux-image-kvm \
+	linux-image-generic \
 	lzma-alone \
 	lzop \
 	mount \
@@ -131,6 +132,7 @@ RUN apt-get update && apt-get install -y \
 	xilinx-bootgen \
 	xxd \
 	zip \
+	${EXTRA_PACKAGES} \
 	&& rm -rf /var/lib/apt/lists/*
 
 # Make kernels readable for libguestfs tools to work correctly
-- 
2.34.1

