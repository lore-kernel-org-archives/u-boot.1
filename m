Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BF1CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0551183885;
	Fri,  3 Oct 2025 21:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JczQLoqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD22A8387E; Fri,  3 Oct 2025 21:22:49 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D97C08386F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-9335a918867so209128439f.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519365; x=1760124165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BV/3wIlRhQvBQXDl/Srll6Ouy5B4/k6M9EkOTYVWblg=;
 b=JczQLoqQSvh+JmqjZM1368annTHwkQt20vMhr8xn3AM7mCB5GCxAVjfDFc9xmS0rKH
 NsCRAP+g1jeKMUz+IInMbQQd1+y+kjZ8RpwfWz/F/I35jhm1Gmhnhmc/JzDibceX/bMH
 kB12eua0lV6bo7anoDRM9hyASsuCTYzu1AkUx/Z3vKe7F1iQUs6eAXcQY7t+pqUda171
 CMXnfSAnUZktqEhSvTCdY7viLVuhcUQ0Gm2W68L/AHyLpi1BZa8r4f/t2aSGqCtWt/Bl
 F6zrbBKwrkCRevB4TTSuSdift0x1SKpjsmR+LAG8G5ynpM5CMg8ZvMNrqHFkDENYDhA3
 I50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519365; x=1760124165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BV/3wIlRhQvBQXDl/Srll6Ouy5B4/k6M9EkOTYVWblg=;
 b=XKqhp45e7PYiQAM10KWX9rLlkDZk5Y9TW3oZg8nB3fCxAPNg/moQn55HkYOqqSCzgr
 YDJOxfqA601rXgw6szOSNVoiE2PNi5VPgrNPiRw844ClM+7fOhF5RvLYHKoqiCHG2m4G
 860pomvvNgYIf+piQnPSFryqBy0bVMdjYsZ5XjSFhda/gal83SIINB9GZhbE1r3k7nYL
 8wWvvVq3ZkkH30Wz59d3Unf1mrNR1htVd0ERiVPmC5dc/F7WcFFHzpdwC0U0M198s2Yp
 2E6oU9HOHQOfvhRzZdpRT4A7NwQVgv4FHs7zNJp5rpeAw9m3wh8YHXMYVbARuDB2+4IR
 1hQw==
X-Gm-Message-State: AOJu0Yx3rNcZuH0vxSjGH8xV6k//D80mpNJAQEb2DQubHqbTMrGMvGn0
 31/eU1KlrB3FgSms1k6/C1PfZVzOUp9aeuvnzFLoXZa9eFH4ayDujnGKFUiA2oN5UCvptGdwSrT
 opLBq
X-Gm-Gg: ASbGnctL1rsoINGhTl9y4Ap8hVNMXHiZLGEeku8Rzg4mWG0p8w2zrQ5rbU9XEguEZG0
 R37N9jRhfE1dWnEuDDVy5GB1d6rXTkDDUfymGCxWYT5pXHCY9+A0k0NBmF6VhuxJpq0LSWD5kCE
 b2YKVb3ksVp+pR2ROt6d9vzH8Zs4XpL6QELrCfexZlTq4dAB809RAkBosBhwkn8sSBTjQggfvnc
 mn7gXfX2+Yy/jG8EHWGHKBWQwH6Odnbyfm0xzfJn1WBmc0gW4g9PsOBTN7ykJlmA/9d5BIL+XrG
 uLz86xLTdcs0+rjhc+taz0BOzplHuE3BbweRp/Lu85T7+gT96dCWi6dsM2DQNdlNFxYwW0WXo3I
 /Osi1FWiTzTqhwjSGdOeTF5YY4xDQtUHyfsjZDxBmObkxm0wJk2V5bMfW5NlHdv9ujmgVyM6umQ
 ==
X-Google-Smtp-Source: AGHT+IEJhPMiE/D0/Slftk+SkG/uk1OjCwz8sXnxhneBDL4lki4E9zMFoX3RLsHiixfSk6UGG0jXMA==
X-Received: by 2002:a05:6602:2b84:b0:887:6113:3d95 with SMTP id
 ca18e2360f4ac-93b969580e0mr611391739f.7.1759519365164; 
 Fri, 03 Oct 2025 12:22:45 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7d81bf16sm208975239f.4.2025.10.03.12.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:22:44 -0700 (PDT)
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
Subject: [PATCH v2 1/5] docker: add OP-TEE and TF-A build for testing Firmware
 Handoff
Date: Fri,  3 Oct 2025 12:22:15 -0700
Message-Id: <20251003192222.767882-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003192222.767882-1-raymond.mao@linaro.org>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
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

Fetch OP-TEE (4.7.0), TF-A (v2.13.0), MbedTLS (v3.6) and build
bl1 and fip with both Firmware Handoff and Measured Boot enabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in V2:
- Move OP-TEE dependencies into the common group.
- Fetch MbedTLS/TF-A and build bl1/fip in dockerfile instead of
  post-buildman script.
- Remove Trust Boot related build options.

 tools/docker/Dockerfile | 74 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5b4c75f8400..0a213a7a61e 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -58,6 +58,9 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
 RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
     --mount=type=cache,target=/var/lib/apt,sharing=locked \
     apt-get update && apt-get install -y \
+	adb \
+	acpica-tools \
+	autoconf \
 	automake \
 	autopoint \
 	bc \
@@ -65,21 +68,26 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	bison \
 	build-essential \
 	byacc \
+	ccache \
 	cgpt \
 	clang-18 \
 	coreutils \
 	cpio \
+	cscope \
 	curl \
 	device-tree-compiler \
 	dosfstools \
 	e2fsprogs \
+	e2tools \
 	efitools \
 	erofs-utils \
 	exfatprogs \
 	expect \
 	fakeroot \
+	fastboot \
 	fdisk \
 	flex \
+	ftp-upload \
 	gawk \
 	gdisk \
 	gettext \
@@ -92,11 +100,20 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	imagemagick \
 	inetutils-telnet \
 	iputils-ping \
+	libattr1-dev \
+	libcap-ng-dev \
 	libconfuse-dev \
+	libfdt-dev \
+	libftdi-dev \
 	libgit2-dev \
 	libjson-glib-dev \
+	libglib2.0-dev \
+	libgmp3-dev \
 	libgnutls28-dev \
 	libgnutls30 \
+	libhidapi-dev \
+	libmpc-dev \
+	libncurses5-dev \
 	libpixman-1-dev \
 	libpython3-dev \
 	libsdl1.2-dev \
@@ -110,9 +127,11 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	lz4 \
 	lzma-alone \
 	lzop \
+	make \
 	mount \
 	mtd-utils \
 	mtools \
+	netcat \
 	net-tools \
 	ninja-build \
 	openssl \
@@ -122,12 +141,16 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python-is-python3 \
 	python2.7 \
 	python3 \
+	python3-cryptography \
 	python3-dev \
 	python3-pip \
+	python3-pyelftools \
+	python3-serial \
 	python3-sphinx \
 	python3-tomli \
 	python3-venv \
 	rpm2cpio \
+	rsync \
 	sbsigntool \
 	socat \
 	softhsm2 \
@@ -136,13 +159,20 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	sudo \
 	swig \
 	texinfo \
+	unzip \
 	util-linux \
 	uuid-dev \
 	vboot-kernel-utils \
 	vboot-utils \
+	wget \
+	xdg-utils \
 	xilinx-bootgen \
+	xsltproc \
+	xterm \
 	xxd \
-	zip
+	xz-utils \
+	zip \
+	zlib1g-dev
 
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
 RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
@@ -227,10 +257,30 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build fiptool
+# Build OP-TEE for qemu_arm64
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
+# Build fiptool, bl1 and fip for fvp and qemu_arm64
+RUN git clone --branch mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
 RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
 	cd /tmp/tf-a/ && \
-	git checkout v2.12.0 && \
+	git checkout v2.13.0 && \
 	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
 		PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
 	mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
@@ -243,6 +293,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
 	mkdir -p /opt/tf-a/vexpress_fvp_bloblist && \
 	cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
 		/opt/tf-a/vexpress_fvp_bloblist/ && \
+	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		PLAT=qemu \
+		BL33=/dev/null \
+		BL32=/tmp/optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin \
+		BL32_EXTRA1=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin \
+		BL32_EXTRA2=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin \
+		BL32_RAM_LOCATION=tdram SPD=opteed \
+		TRANSFER_LIST=1 E=0 \
+		MEASURED_BOOT=1 \
+		EVENT_LOG_LEVEL=10 \
+		MBOOT_EL_HASH_ALG=sha256 \
+		MBEDTLS_DIR=/tmp/mbedtls \
+		-j$(nproc) all fip && \
+	mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
+	cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
+		/opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
+	rm -rf /tmp/optee_os && \
+	rm -rf /tmp/mbedtls && \
 	rm -rf /tmp/tf-a
 
 # Download the Arm Architecture FVP platform. This file is double compressed.
-- 
2.25.1

