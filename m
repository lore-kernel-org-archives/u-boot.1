Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D89D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537368944F;
	Tue, 12 Nov 2024 15:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JskV5JWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C6F8943F; Tue, 12 Nov 2024 15:11:23 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC2089459
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83ab694ebe5so221756639f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420678; x=1732025478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8KYMf1OGVkuejF+Xja0ZzGTLvaIRigLbVU1Pj9rW/c=;
 b=JskV5JWDrNBxvdITREzUIvM+huXF4uNyrGZTSzcz8aE6mSlz/T2+fhlqp12i9OLarc
 6hApUF2q0BtY5DKt0OnWW1KV8RItF4vr8nw/yqnNhRbyMpyIoTvPKTQ5MlMEe1+4MtW/
 C8Yb4e1Mq4nFJQF0EAGrNqCgLrX7OxnpErHzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420678; x=1732025478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8KYMf1OGVkuejF+Xja0ZzGTLvaIRigLbVU1Pj9rW/c=;
 b=sZlN5IsV4qKvYhpyJC2hiP7zI1ZPp3SzQ64pzu5DaA6eTSywFZ+HjEnhcP96f9nOyw
 OKohTFcwcsvtxge56liLYyyTsvBGy/cazDO1qvVXVoCmM8RYrkSulffOMp+pI7iSqs+b
 YN1h6aPnWsqY9070tMb6A0e8Xk+j2tkHVcckw6NJUfW1BhCJwRTHhA/2Rz2WNDCATjhZ
 rpQROk37APGuNNwO1Jj6/V4XzONuk6Z+0UpXgbIPB6c6ZFx2835sewbNnyX/Zf59GE/M
 umSUSVVludQAtZqzzk3/o4HQQVbUwbcshw8PT3t43dzaWgwnJuZ28eUN58UebOq7asA+
 sOLw==
X-Gm-Message-State: AOJu0YwJPNfwuzQ+qPnFECR6ZuCSocIB911jEJ1G9Zni2uAu7adaCoAW
 EhIO7wDTaBUOqInOj6JpdxuBjhWJLxgnxvi8ceZgzWdn2n8R6O89hF2aOydS73BBPJudpt6OvF0
 =
X-Google-Smtp-Source: AGHT+IEcM3Tz4UGWN6WdVaiEwxcpdcOBYEwgQUgwfjRtfObtuJdvkHIKcPrLNaDQ+YkvtLcDhRnvsg==
X-Received: by 2002:a05:6602:2dd3:b0:82a:3552:6b26 with SMTP id
 ca18e2360f4ac-83e033704b2mr1318880739f.15.1731420678044; 
 Tue, 12 Nov 2024 06:11:18 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 4/9] docker: Adjust packages for arm64
Date: Tue, 12 Nov 2024 07:11:00 -0700
Message-Id: <20241112141105.640189-5-sjg@chromium.org>
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

The package names are slightly different for arm64 and we don't seem to
have a linux-image-kvm package. Provide some extra ones for x86

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

