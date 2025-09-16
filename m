Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA54CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D0A8329B;
	Tue, 16 Sep 2025 18:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lUllU/v+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC957832DA; Tue, 16 Sep 2025 18:14:44 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7341C8329B
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-89366d35b81so179495139f.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758039281; x=1758644081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amR3+XqRrta/RXkdPEF2PrnyTFEDkklpeLyUws876Ks=;
 b=lUllU/v+2ws8F0+MKsUj9LH+77E2TUrYiNEMJpQlh1ACpHopjprtH8QiSZK8THSKcl
 Ampkp98bPErxXyXArHwS6DX8NpBvq1a+Dv5hOhrOyiLzUKXwwwI9EQOUhQIME2tfo3vD
 bXQ5JQho0afudtpfH+crUwF4sbJHVqQYppOu6TG18e8vaOQsZXA95b773e8jBtlLECI4
 /cYVx+W0/9PM2CPgYyoqF4j9uqRTiGrPfwSMXZNr4NrA4paTljUdeYI1fSnbDdIDhZoq
 912+eGdvK6pGucphKHJe7mTBrxj0YLoL9tE1+GsPKnpjGhkWca8F3AQNLivuPg432Izk
 B0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039281; x=1758644081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amR3+XqRrta/RXkdPEF2PrnyTFEDkklpeLyUws876Ks=;
 b=BIAFb0Kk0/GSr0GrhT9JVB3uvRQtVb54kgYkxAgeFKLzWN0sOiOH0zr/7ANsQSnM8X
 nSlwnBe8N7D+TSROsFkOXqUNVyBfiDwznPXxxRnd8Ije/mmCzEyA7fV88KrrYszGwWl7
 au/GZnd6DAX4mEb8tacW0EkhVMBFDuKUdzIiIVa2OoNhw9yTFum8l4pB+1ldogC5Mhp+
 ioyiJjI7V69g2Cb6YMKX6qi9U869jMfSGSa89o3f+YvYuTtMq36ujZi6dxlezx4YPtbZ
 Ir3eSOGP0BXv6LvwP6wPwJAn84IeNynkALY3byB1XtC31NnF9cJpCmyuyK87GC2hLjSB
 KLNQ==
X-Gm-Message-State: AOJu0YyQdxI8OAGq+4hYcFdBnfOgprk9QguPybl9jnJa7FbKpID6AqYu
 rNUjoRrxmbjGWq5ttEzgtVTAfk5FFuyL2M/RD/q+2UmuL5Z5qxSEh3N2FPLevfrRXn59bCIi0hZ
 yG0Ya
X-Gm-Gg: ASbGncsGn4K+PxaHHqNMRHzQFh4Xkv2BnoLE5VMt95sPVMb37+po4TZjYR2h4pu9vXC
 NatuNiis0TuWigzt0rooGtraDsVgRjRvIdFzS34CjFFHgmQalTtK3uPzipPMu4OkbDCdYOsWzDH
 s6T9SbRZlkyecPombGXonFvBk4AqW7lsV/I4oJbxSya9dA37whPbtCpCvJ+IMjjGzalKiDWKXTK
 1xrULYDfCyfwjQV3bwXCnUOp3wZTpy4MoTWIWngZJWM0wOfcr3e7J2NBid6pD2jbn9s3pJ5HAjb
 f2Lo4BfjokHe0Ki22HG5FcYqUFSwxUM0qpK77EqTk0Nh6r1+rUVBqikLmTIZk2KqKGzdal1gMpi
 2298zDNtvxuBSW2qHX/5ExTEOBSEYRcxGNp3hINmnXta0/9w2o4H2vocXWHu+SgJIwzACJx8oBY
 Qp1XyHA9Q+Og==
X-Google-Smtp-Source: AGHT+IELN4WXltN5tG50cToQdaQVUQZBwmJTE9lU9p3xB6h5sPH0TR1wuaobyzsJzJANz9BQRCw8rQ==
X-Received: by 2002:a05:6e02:1a06:b0:424:16de:547d with SMTP id
 e9e14a558f8ab-42416de547fmr1989875ab.9.1758039280713; 
 Tue, 16 Sep 2025 09:14:40 -0700 (PDT)
Received: from ubuntu.localdomain (209-227-169-220.cpe.distributel.net.
 [209.227.169.220]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41f0ea1bdaasm68433615ab.39.2025.09.16.09.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:14:40 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 1/5] docker: add OP-TEE build for testing Firmware Handoff
Date: Tue, 16 Sep 2025 09:14:17 -0700
Message-Id: <20250916161426.32259-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916161426.32259-1-raymond.mao@linaro.org>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
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

Fetch OP-TEE (4.7.0) and build it with Firmware Handoff enabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 tools/docker/Dockerfile | 77 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5b4c75f8400..02a8a2fb37c 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -54,6 +54,83 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
 		wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz; \
 	fi
 
+# Build OP-TEE
+RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
+    --mount=type=cache,target=/var/lib/apt,sharing=locked \
+    apt-get update && apt-get install -y \
+	adb \
+	acpica-tools \
+	autoconf \
+	automake \
+	bc \
+	bison \
+	build-essential \
+	ccache \
+	cpio \
+	cscope \
+	curl \
+	device-tree-compiler \
+	e2tools \
+	expect \
+	fastboot \
+	flex \
+	ftp-upload \
+	gdisk \
+	git \
+	libgnutls28-dev \
+	libattr1-dev \
+	libcap-ng-dev \
+	libfdt-dev \
+	libftdi-dev \
+	libglib2.0-dev \
+	libgmp3-dev \
+	libhidapi-dev \
+	libmpc-dev \
+	libncurses5-dev \
+	libpixman-1-dev \
+	libslirp-dev \
+	libssl-dev \
+	libtool \
+	libusb-1.0-0-dev \
+	make \
+	mtools \
+	netcat \
+	ninja-build \
+	python3-cryptography \
+	python3-pip \
+	python3-pyelftools \
+	python3-serial \
+	python3-tomli \
+	python-is-python3 \
+	rsync \
+	swig \
+	unzip \
+	uuid-dev \
+	wget \
+	xdg-utils \
+	xsltproc \
+	xterm \
+	xz-utils \
+	zlib1g-dev
+
+RUN git clone https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
+	cd /tmp/optee_os/ && \
+	git checkout 4.7.0 && \
+	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		CROSS_COMPILE_core=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		CROSS_COMPILE32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
+		CROSS_COMPILE_ta_arm32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
+		CROSS_COMPILE_ta_arm64=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		ARCH=arm \
+		CFG_ARM64_core=y \
+		CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y \
+		PLATFORM=vexpress-qemu_armv8a CFG_RPMB_FS=y \
+		CFG_RPMB_FS_DEV_ID=0 CFG_CORE_HEAP_SIZE=524288 CFG_RPMB_WRITE_KEY=y \
+		CFG_CORE_HEAP_SIZE=524288 CFG_CORE_DYN_SHM=y CFG_RPMB_TESTKEY=y \
+		CFG_RPMB_WRITE_KEY=1 \
+		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
+		CFG_TEE_CORE_LOG_LEVEL=4 CFG_TEE_TA_LOG_LEVEL=1 DEBUG=y
+
 # Update and install things from apt now
 RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
     --mount=type=cache,target=/var/lib/apt,sharing=locked \
-- 
2.25.1

