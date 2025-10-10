Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF90CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41DF8445C;
	Fri, 10 Oct 2025 16:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kxUwUlnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADCA84589; Fri, 10 Oct 2025 16:45:38 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D874A84258
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-78f30dac856so22988536d6.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107534; x=1760712334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLgv++5rWj4G+GOrgRnT6NUb/t64WZLt7NdVU4HcEPQ=;
 b=kxUwUlnC5KvdUA6xCDcByZMahZLdCA2OJM4brf/7D3dXQVe/BXSeolyZ9DCgX/ZpaH
 Gb1sq6TKpxTE6uk2GNP47psPYuEqJuB2YXzWfFJY/VNlWiXrMF5WwU5u1xxI0Fvz45zr
 3nHg6605XLXMAF+86n8n4k6RKzSYPglyU0P2reIUzf0EQXKsuPk45dPyEpQj3+jEPcmV
 BvJ3gK/nMZmEVEkVa948qxuLyUdunTu+T9JFk+XtUBPnmCiHAAhIixabQCJF33dTJMe9
 ynKvaNpADe2QYKPc6GtzeFLpYeuw9PEPiPOXkMr0oolusQEdIjxhZOEnMfN4rznq0/mA
 hU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107534; x=1760712334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLgv++5rWj4G+GOrgRnT6NUb/t64WZLt7NdVU4HcEPQ=;
 b=FYbZv/AzuNy9rZjuGoqkhdPcnEMwxZnFhMkvlN+ILh1+IdsqVjNUuB8DHlZyW+uQbF
 B9zc32KvBqyMfW4VVuvOvABKjKXDz6cBvdwYjSI7JGJryUjokcT/dDFI7IPHsDzrLpqN
 R3uAbMRBafjn/MQernUWg8+acmXH5IivfB/bdnJczEnGVvRCTnSoEOdE8cX4KbSFsXgM
 UP3JTJymGrgoZgluQSvsvYs9igMXs+BfnwIiSXwe5nGcKpVZo1XBhvNP1y5hJuNwbISF
 892PdfTqoHiydqL+tMHqOkfbJ3ooS02re6NQr2pjixaluDyYb67QnWErpnvUehApSvHq
 CqEQ==
X-Gm-Message-State: AOJu0YwHCOI1u0t8FF5iTeLiRyJhP6K43JXimiPcW6/Hk1vzdDC3E9FA
 htkIPUeaMswOFE2mSx3tqfi+tuWZwG4qYjz7H3LkPamMEsfNm91kuBmGbQca0x/bmWzl7JSbe1o
 7RbJy
X-Gm-Gg: ASbGncudkHGAQXERF6yVtKPWPrl9NHm1FQ5u0/fyL04DPUPXDg4EYRi2UArtHjf/YdR
 QMoyzZ3M4GBt9ylbWoEdfvFIsyFvRNqXUgXQbg4OQEqWZx0PxoaHbOZAwMsRWY+Er6PiluBoVo2
 oaXjkjII0u+28VpZWZ3V/E9PzM2TVNF1Hb2ZJAKwEnHPm9Mp6V3vWEcehVXfFw4FYDaFJVbweoX
 WewJupn3ADZoSM7v0Ym5ebT5kPoEUtJmuIAYbX5JPeKM0MCLo51/QK5tN9ZSWfq+8q44nyDt0uR
 y+mbia/UErIIVO57dvLNkcUPKFtKVNJah7n7cq55oO0Mp7N4fOXyvpVDa0Pfa6+/hfLn2IewCs6
 quL0gz3TR6bgF+OboFge8ocJ1cmXWvxJoi7WneQPaQDJfvYAZ4ly+zdoQD0A7XWLdCroriQj/Z/
 j5jiA=
X-Google-Smtp-Source: AGHT+IG4A9+gsGm5vsryunED/8HX05wPCOdkWZs5U48LID2rnsbryxAA4v+g8rUjIOQI8FNFgx4fdw==
X-Received: by 2002:a05:6214:5012:b0:879:db53:df0 with SMTP id
 6a1803df08f44-87b2efe7106mr145040656d6.46.1760107534081; 
 Fri, 10 Oct 2025 07:45:34 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm17686306d6.17.2025.10.10.07.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:45:33 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 1/6] docker: add OP-TEE and TF-A build for testing Firmware
 Handoff
Date: Fri, 10 Oct 2025 07:45:05 -0700
Message-Id: <20251010144517.3573014-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251010144517.3573014-1-raymond.mao@linaro.org>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
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

 tools/docker/Dockerfile | 44 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5b4c75f8400..51d07b1482c 100644
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
@@ -227,10 +229,30 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
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
@@ -243,6 +265,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
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

