Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41B1D132C4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 115B888FB3;
	Mon,  4 Nov 2024 14:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MhwRne9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7DA88F4E; Mon,  4 Nov 2024 14:40:12 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1350388D3C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83ab21c26f1so173367739f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727608; x=1731332408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UcMZ+oSWwVo4Ac6irP4BnEw8/xOSiR6TBV/JbJptv+Q=;
 b=MhwRne9XHInX7fwVs1pBGx60+HGU70HdiCT4sfixolYX9rS29bk0DFDZ+B3Ewf1o+k
 KTuu7fDdhlu9xKrTXuhMduR9XTty22p1bbqd/Ad344x6keuWJ/BujxegZPruLd3q3K5Q
 nK4b2556cdrk151AjIRPOlsO73Yu/nrJH25E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727608; x=1731332408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcMZ+oSWwVo4Ac6irP4BnEw8/xOSiR6TBV/JbJptv+Q=;
 b=XHjxwAcT1jhjz+1b78rwDkTQkLHIJooW2Znf3d7cTazcX69lcFYVXpRsSBO0r25ENj
 GrZ3HY/kFTPAM/wIppeFz1eIpu9ijGg8cNI3dMInUYOd6LdhkxrY+4XAhv92ioxjeH36
 v3fFGy1WDko4lbyg44RVeZcx9mhdN8++ifFkw6DcyTVZWjDyrTtSJnOTPOqW+xqiXxke
 qOigZZCDZ30T804DGbTP7piIGzUEGyfTjctgppSwPTzFV3075ZfRqni8DFIf8COaAvdw
 CtidC5N3/qfSjqew+VOCQygHkvZzXBnvn9467MhttFO/IHPN8YTeogzZSKxA9E+AshHU
 MkLA==
X-Gm-Message-State: AOJu0Yw3k9mRprpue8fXWBfHFJtZvOaf1AxBN+ArfHfHL65kR52CcJZh
 ytxjP5HK26v57Qaw1+dIrQoFNkrRQ3r9eHNJPQypAjQnl2cr9KKps5hISOKOLSQipHj0nQt/+Qg
 =
X-Google-Smtp-Source: AGHT+IGEX1cMpUhDvQ1GoonaFaN4pv007CIX53mYxc1yvCW3HDmpMGVmE2G0/kBByuC+9kspDvab7g==
X-Received: by 2002:a05:6602:3d3:b0:83a:b2c1:8b40 with SMTP id
 ca18e2360f4ac-83b567990c5mr2080209039f.13.1730727608272; 
 Mon, 04 Nov 2024 05:40:08 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/9] docker: Adjust packages for arm64
Date: Mon,  4 Nov 2024 06:39:48 -0700
Message-Id: <20241104133954.840994-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104133954.840994-1-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
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

 tools/docker/Dockerfile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index c9d794082c8..c4c3dc5a901 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -39,7 +39,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
 RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
 
 # Update and install things from apt now
-RUN apt-get update && apt-get install -y \
+RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
+		EXTRA_PACKAGES="grub-efi-arm64-bin linux-image-generic"; \
+	else \
+		EXTRA_PACKAGES="grub-efi-amd64-bin grub-efi-ia32-bin libc6-i386 linux-image-kvm"; \
+	fi; \
+	apt-get update && apt-get install -y \
 	automake \
 	autopoint \
 	bc \
@@ -65,13 +70,10 @@ RUN apt-get update && apt-get install -y \
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
@@ -89,7 +91,6 @@ RUN apt-get update && apt-get install -y \
 	libtool \
 	libudev-dev \
 	libusb-1.0-0-dev \
-	linux-image-kvm \
 	lzma-alone \
 	lzop \
 	mount \
@@ -126,6 +127,7 @@ RUN apt-get update && apt-get install -y \
 	xilinx-bootgen \
 	xxd \
 	zip \
+	${EXTRA_PACKAGES} \
 	&& rm -rf /var/lib/apt/lists/*
 
 # Make kernels readable for libguestfs tools to work correctly
-- 
2.34.1

