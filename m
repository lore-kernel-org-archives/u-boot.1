Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF19CD2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829E1891D1;
	Tue,  5 Nov 2024 17:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QWAN5wkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76968917B; Tue,  5 Nov 2024 17:08:03 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3E8891D2
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8377fd760b0so208075639f.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822875; x=1731427675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2O+2Vb3tgSO1VPiEWlpJ5/OzhTXqtiuniFf7esntAU=;
 b=QWAN5wkIE63ymayODbzgWrH46ESgVNseT0XqiSdQyo0HKuNJwj6OUJyZJ9qDR2CCAb
 u33c0VdLpBvDwtJ8rTs05pToy1pk3cHimC/f77jbGibpuho05f8ouWu5b5v5sqv+26YG
 T4uj3D8hDsoLfiF/Axh4WuQZuvoRXhgN/Yn70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822875; x=1731427675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2O+2Vb3tgSO1VPiEWlpJ5/OzhTXqtiuniFf7esntAU=;
 b=XXwE9bQ6dXYKv+j/Qh/K05YyCeU0lrQlgGdNuSngTPZmS3hLFLaLYt1Iif2WZ1sUqE
 TgYVzca7yPC2uUy2eoYdcvF1lLnue7ZDk4MZLGA+VPy4KoWeq2k2mwLoVe6jxGIgdMO8
 5WwIFf/LRl7d2fz+nad3E3/jxZbkj+fDzlhfAqXBM6Az5JFNsObRqG1lsYFXrTAlF0Jo
 Q4JKTeB7FioS/jX9/azKnYoa1pnQJTwR7HlJiyZpPqF1qLaOq8+DlROizikhv0ELi+ba
 ni1mNOCLmpqs1YwT6Y7E6nLzq2DHJpq70pxS8HFuQXeWYqeIRAxnhBq1638WR+dktTBF
 NkDQ==
X-Gm-Message-State: AOJu0Yze2lTJPvoLI4uln2un4q4/zje0kW5dmXSpYcXLn0uItZ3Z5FWG
 RySKJpxmS26hzlelup1Si62YZSLFYe/XAhF0gY7zhGyYKQFKo5Xa52cwS38InG2HlJgcRqHnduc
 =
X-Google-Smtp-Source: AGHT+IEy13McK8jjsddbO0SZ15VZRo+tlvVRR7YS1XjwX+3hqHr5Jnpuj1hYb/ym3jHX2/u3xP90hA==
X-Received: by 2002:a92:c246:0:b0:3a0:8d2f:2914 with SMTP id
 e9e14a558f8ab-3a4ed2fe5f9mr369393595ab.23.1730822875019; 
 Tue, 05 Nov 2024 08:07:55 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:07:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/9] docker: Adjust packages for arm64
Date: Tue,  5 Nov 2024 09:07:33 -0700
Message-Id: <20241105160738.3795497-5-sjg@chromium.org>
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

The package names are slightly different for arm64 and we don't seem to
have a linux-image-kvm package. Provide a different set for arm64

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Swap order so that amd64 is the exception

 tools/docker/Dockerfile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 540718df062..84661b036c6 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -44,7 +44,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
 RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
 
 # Update and install things from apt now
-RUN apt-get update && apt-get install -y \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+		EXTRA_PACKAGES="grub-efi-amd64-bin grub-efi-ia32-bin libc6-i386 linux-image-kvm"; \
+	else \
+		EXTRA_PACKAGES="grub-efi linux-image-generic"; \
+	fi; \
+	apt-get update && apt-get install -y \
 	automake \
 	autopoint \
 	bc \
@@ -70,13 +75,10 @@ RUN apt-get update && apt-get install -y \
 	gnu-efi \
 	gnutls-dev \
 	graphviz \
-	grub-efi-amd64-bin \
-	grub-efi-ia32-bin \
 	help2man \
 	iasl \
 	imagemagick \
 	iputils-ping \
-	libc6-i386 \
 	libconfuse-dev \
 	libgit2-dev \
 	libjson-glib-dev \
@@ -94,7 +96,6 @@ RUN apt-get update && apt-get install -y \
 	libtool \
 	libudev-dev \
 	libusb-1.0-0-dev \
-	linux-image-kvm \
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

