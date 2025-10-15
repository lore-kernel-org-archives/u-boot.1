Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119D3CCD192
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990C5834D4;
	Wed, 15 Oct 2025 16:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FZjWfUqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8946835A2; Wed, 15 Oct 2025 16:19:15 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B45800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-87bb66dd224so82172196d6.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760537952; x=1761142752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvVy3rTn28Eyx4qeIoQEjJx1coEKmIqCOaNEC4twT04=;
 b=FZjWfUqsHBQ7d4JYc2WwYVACxBxPjifnoOiC+LVpriDgNGPWRnfG5+NPC7RPcz7q1Q
 CH2wdrWijXIJxs4+H35Yl/78uE73oqOq34QfxY5dFIA7Gx+sTg1PV3IDo1zeFvNhxGTU
 7oBY6JSTPHt36NmqafgivaBhpMNpYyAGN1aY4mTIvDYPAHktCqMwdkZ4VjNYMjvGqkUn
 G5PqTF+9kh5HjWrxC5Z4kFU+1CrHAFP9qqjljeF9cUeQZoTzIEiA5aVYNukMZe2lwiiz
 7w7q51sMHnlJgvyY0pEKLnpVKuWDKawfv0uEpy36Bj4nLIZKBPwa2L4vH+Kuy7eVl1B8
 30Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760537952; x=1761142752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvVy3rTn28Eyx4qeIoQEjJx1coEKmIqCOaNEC4twT04=;
 b=czyeIGRXx5EBEhKGk1QwyDNfstPfS9IQaKnBzV4pQADnCqTm7tDaRwtlSvPQfj7hWA
 CUpdI1sILC/EeJmFyC9yltFdCP4zNx/PKgjIDRU6mekG3c/mACXfz/6Z9xz/Fz1f5ySq
 KIWPUSI48vbZfok/4Jjxy3MUcBbjKywptWONB/hMWwDoLcRdfWgIeLoKclZjAYPfgq4J
 Q9+8cCMc/eRReBZdRxI9VHOzz2pLuteQNziO38CSUs7zgOUwngmf8+C9lbRQzO/f35K/
 k8hvlVhshqHhrDJyUTY06TRnWuOpP/fnfxXS39yU44hG5LaALQWP0lSLP5iJkCMEgQNZ
 vbQg==
X-Gm-Message-State: AOJu0YzTx6CDxvyMo4vboSo3F9cMf2xXEoaHS+EYdtGtxFsZclL+9zhR
 sUwrrT7wQg25hRsPyqN1jm+PtSUHzVR1kRvImye/KhrS+MZevurXfeDFRqqHpBcbZ4pPeEKOfoy
 tSYtO
X-Gm-Gg: ASbGncv5Xhzc1E1kmgJosIszD9zgJeLVYt7F8l74EuKG9NZIE67BRKwOQ2NkDb+MimE
 Nr8G6ik5jok5rTb5BougZYWBQZzkDmkL+EatKluFgNPUDOQo4i5AXwmZ06E5SM9iv8Ngnm3BUth
 pODoWutC/ZV3Y4aCWBGTmEwogcKj395sI60EcvHTrhLrRFs6Q+6eGol90naX2aCkn4SeUd4sLgc
 02JYMU5ERFqpQugLC2KInvrMH1PGwJleizrjIiTPlhs6YrxsyqiZ4t8zWRyXTNyp2bfunszXDpD
 U09Hbvytuz+IGfZX8W2rb8zSdSJFtWwpVeHYv5bQTuw73TGB8irw3UlefUU7SyF93Tcjpy3lQCa
 C/7KkYQn56Wvzcun6mfUHniP554aQhW2/Vi+SQO06OGkw4kOXCwnxe8hL+BCpUluTVSyczuZyT4
 ts7bE=
X-Google-Smtp-Source: AGHT+IE4DJDegtL8K+vRoFKKGKnVtjmwTDhiY1889p5OyJHc8ny2LDNpePlq6qTc23lwFqWFPICPWA==
X-Received: by 2002:a05:6214:c8b:b0:81c:cd18:45af with SMTP id
 6a1803df08f44-87b21065c1bmr339043616d6.17.1760537951751; 
 Wed, 15 Oct 2025 07:19:11 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0120c20esm19337466d6.5.2025.10.15.07.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:19:11 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 1/6] docker: add OP-TEE and TF-A build for testing Firmware
 Handoff
Date: Wed, 15 Oct 2025 07:18:45 -0700
Message-Id: <20251015141856.4168612-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251015141856.4168612-1-raymond.mao@linaro.org>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
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
Changes in V3:
- Clean-up of OP-TEE deps.
Changes in V4:
- Minimize OP-TEE build options.

 tools/docker/Dockerfile | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5b4c75f8400..73c1589e260 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -122,8 +122,10 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python-is-python3 \
 	python2.7 \
 	python3 \
+	python3-cryptography \
 	python3-dev \
 	python3-pip \
+	python3-pyelftools \
 	python3-sphinx \
 	python3-tomli \
 	python3-venv \
@@ -227,10 +229,24 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build fiptool
+# Build OP-TEE for qemu_arm64
+RUN git clone https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
+	cd /tmp/optee_os/ && \
+	git checkout 4.7.0 && \
+	make CROSS_COMPILE32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
+		CROSS_COMPILE64=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y \
+		PLATFORM=vexpress-qemu_armv8a CFG_RPMB_FS=y \
+		CFG_RPMB_WRITE_KEY=y CFG_RPMB_TESTKEY=y \
+		CFG_CORE_HEAP_SIZE=524288 \
+		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
+		CFG_TEE_CORE_LOG_LEVEL=2
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
@@ -243,6 +259,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
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

