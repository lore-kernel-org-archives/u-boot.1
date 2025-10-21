Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEB8CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 15:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B468323A;
	Tue, 21 Oct 2025 17:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EfVh9UTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C330833F6; Tue, 21 Oct 2025 17:35:01 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4375800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 17:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4e8b4e4ce70so342911cf.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761060897; x=1761665697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWsr38KzvwHFcqHNACtSVEuGSMg3Ux0NFI9GnqgNPwc=;
 b=EfVh9UTYzLTEEOgMbfXsbWkdNeTbePrr4jRl3RkKDNWyVtDh8O7wbSFrIlWSCigcgv
 2f1azb8yxTPTvNtaCyrLmXHuj6b3U+Ku2lju7czff5FWboFBlONWZj73WjM8HCpiqlUO
 DYskC5V+5lMfGYdox6ftyweyQnlB7ZbwnLsnfTHqeV5lm/FlvUaj/8V1xE3eo+rVgwT+
 q6eR0hgmBe7lYngoCwENdRXXYhpajAa/xHCfjBULxmZNWLk+kLq1gzYHq5+GV02nptfN
 AtvBC+oPHFHJF7a++qRV+7qWxn2EmOsCmDoFbKzrLSCbvRDUAePI6ZnoGAu1iJD2NhT9
 RZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060897; x=1761665697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWsr38KzvwHFcqHNACtSVEuGSMg3Ux0NFI9GnqgNPwc=;
 b=tuoh3bjCkdZFguefF5BSUGy08MoMUkJBhX7+1bgMIxXZSXR1mu3rYk7cO7MgTgcl1Z
 PWUk2zdDWRME3B+vhDGGibFYi8RRoL8GQzT7a41LvMkTBjjFWpiiFIxFAzZuNsQko/uE
 IrKdRN8VmgapbQcWkoYnnqMeTpHA3hw8CfkaLUJV0j6NM4B3zB0HqUe/cGIvqkropMdo
 r17Kw9jKX1o+zarSYCVV4CI+FMZKj+IUFjmKdu06aI7wPgUVhLwUqg85dC8WADRcHDb4
 +AA6VrAjTLIWIdglOuPzpenFJ5T61EVE5NIMLE5x2wRV+OVKUwpXQGmRvj8N5URtIT7K
 tCsQ==
X-Gm-Message-State: AOJu0YxR86eUpUrQoxW1ZIrhFrXRf44Rsgal77qq0vYm87ll+59vGnBT
 3xQJzzMawOwbjH4x38XvMtQ1fGatAi19N+v/Lx3VDU16orYBCTRLJlmScU9FB1cD39ocPkfNsLe
 4S7xo
X-Gm-Gg: ASbGncu65InhxrGFRFXJDpvGBeOkIxBdApHQoMU9FIb7KiEoXicYPquluZZ9C0wDMDB
 ohJgMXXO/FdS6aUCytx9whSSuSv7f+o7U2KZWJA9V/bGAGPl7yoq/G9B7hOp2u72UE0hTtlXeLw
 Bl3V+7wgHpD+EnhsITJhRlTgXoq8IRnEOGe3qA914ufFxnfMvgV8V9BV0aWsnc7Kbu/sOG0Arpg
 AUChKeJLnR/2glbZhJH7jC0N3ETpIF99fYPtwlzeDdBtttizBbdiyjQ8lpiLfMKPQ419XJnqtcB
 rnz0DiXuMekq7qt+2dQ53jit73eEeg/NCXuaObm6YWbhHbl8auRIo9B+cxafV0w6QslqdyZIhOu
 25vLxyqILMgyWNaKxvPBEtTeY9uRgvkBPgPgWmm/JZiYny6J3sIe6gpaum8kglISNd0NvpnYLf3
 rgPnlrj6DshY7ptD1YAIOhyD+JIo0Z74TeKADboQ==
X-Google-Smtp-Source: AGHT+IHJQ4CPF8udIIRajB/EdAXyKDGKc4HmNfDmvyJHOqWZsUnvlLPVMxP+zsAU+A46sHwziInx2Q==
X-Received: by 2002:a05:622a:2c7:b0:4e0:3486:8873 with SMTP id
 d75a77b69052e-4e89d414c8fmr196324461cf.75.1761060897003; 
 Tue, 21 Oct 2025 08:34:57 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cf58e7bfsm777910085a.50.2025.10.21.08.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:34:56 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v5 1/5] docker: add OP-TEE and TF-A build for testing Firmware
 Handoff
Date: Tue, 21 Oct 2025 08:34:33 -0700
Message-Id: <20251021153443.219326-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021153443.219326-1-raymond.mao@linaro.org>
References: <20251021153443.219326-1-raymond.mao@linaro.org>
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
Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
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
Changes in V5:
- Add '--depth=1' and '--branch' when cloning OP-TEE, MbedTLS and TF-A.

 tools/docker/Dockerfile | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5b4c75f8400..3286b2ba6b2 100644
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
@@ -227,10 +229,22 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build fiptool
-RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
+# Build OP-TEE for qemu_arm64
+RUN git clone --depth=1 --branch 4.7.0 https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
+	cd /tmp/optee_os/ && \
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
+RUN git clone --depth=1 --branch mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
+RUN git clone --depth=1 --branch v2.13.0 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
 	cd /tmp/tf-a/ && \
-	git checkout v2.12.0 && \
 	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
 		PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
 	mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
@@ -243,6 +257,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
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

