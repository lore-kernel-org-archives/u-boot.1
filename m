Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD4ACAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F28283321;
	Tue, 16 Sep 2025 18:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="McvRG8pU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BADE483323; Tue, 16 Sep 2025 18:14:52 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4AF83321
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-423394b393eso91905ab.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758039288; x=1758644088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vn2dZ4Ncyruef5vEN0NZpmbNju8b5s7fZhmLPXHdhv0=;
 b=McvRG8pUMAym1rUC5iUXYU8n61Om7PSmxP5nm/CRv7t7fSWS56IGMOd2UVCnSgsI8l
 P/wu53x0gK7hEvEkgIAM8mhcW22tZB8/y+jZKrHDUOqXO23wP9lsOMDVCFmYohdyIoCT
 mw/2P1DWB6uYsXXdCw0dgYTjNNr7E80VB+2sPvx2rZAgtjFe9JDmTqQqWTDxsipvOD3R
 x4K4XvQinAw/453Xipj7RRa+F+6OlPTdlpssI3RxWxwuCKDdIL1ukPf3fkGwu1CQSxAR
 YJ0hhUiHrKrCA7+dA03GZ+vkVuxGG8hGZVXo7829sUP1deC/vm9G51sICRjR6WOCjyuY
 Xrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039288; x=1758644088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vn2dZ4Ncyruef5vEN0NZpmbNju8b5s7fZhmLPXHdhv0=;
 b=ulkMOKBzLyn+CaWj52mgoZ87HSDgfnwVNISX/7FDlCYFeuhaE+RPkRtyx9Xk59NfMO
 y9ItaGGvevuV20KDB+X+XRuw9n+cAYjE+3mGJ7qQvnt9cHDDBclEtcWTMx0UUMdaZPP6
 EyN9yFUVebAQw7SlJkFhwFZnFegkcZkgLZy1aii3ly6VDTo7lk40cNZKwB1fhny6qhXe
 yic7+ZfvkgMeTWvSFisivU5Bf1TyXDLisDjnymmxcpieri6cjZpEzDFTSu1IW2nA5QJ8
 1ThzR5UIItZYfNlwN6YhmV/ybwKJN++0vFXigbKf96iFFydTU/gpvcW/4WKHClsL4UMB
 E07A==
X-Gm-Message-State: AOJu0YwuJGsyrqdkwkWO7qij7aOVdaoiD2cqEFQM0l/Q4jKoIAnXRBAz
 +kgXv7Bs7UliOe3OmHFXmrzrPf0uimrrP89iBWlR6s83bO3cCo1S5+3Dtbgjg3c+EHNPjLti+Vh
 MhH6M
X-Gm-Gg: ASbGncty5bs3ovVeNg6flCCdX+T/KTgfIPWLsMhLPuRu/Ly3z7suibhhfZ3433sB87e
 yrMM/S1s0XyUPuAXLytzFTZVZh1hv8fM+qHDTFVO7W5+FZVUNBie0YUhcph4GVk3oJ8N7XdhMIJ
 g76oetmMlgkZ9KY1ZmD1n9soPsvi4gOH9l02h2lpKrCi+1f4yqOFsGZg8S17fvaQCvOXrFSy2rS
 KN2HIROR7ziedrejzCNamiOAj9RQJXegNCZZ4n9YDMl3aiT1wkV2Hb+Sp5vOGZPPZz+/PgzCnT7
 B7BH3cX9Di5YGrb8KxDTE8KJ349yEcotLCURTm3C0qUwwIAiE5MK+SncGo+lSj53wQ8bgz0hBbf
 1gr/1bO9NrEeWloa2HCyyW7kSa4d0IQe6EHgVRXXCUUqxBOeGgjMBrvRJinn0M5gXrEp4fjr7Zy
 GfuzK8JGmtxg==
X-Google-Smtp-Source: AGHT+IHbg/upbI1veJiG6R1tnAOAqzBKxjhFUEHNBdW7rdY5yUm+QGxaebN3pIi9wA06HCWG3pbx2A==
X-Received: by 2002:a92:cdaa:0:b0:423:2666:4687 with SMTP id
 e9e14a558f8ab-424114a7167mr24697745ab.15.1758039288496; 
 Tue, 16 Sep 2025 09:14:48 -0700 (PDT)
Received: from ubuntu.localdomain (209-227-169-220.cpe.distributel.net.
 [209.227.169.220]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41f0ea1bdaasm68433615ab.39.2025.09.16.09.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:14:47 -0700 (PDT)
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
Subject: [PATCH 2/5] ci: add post-buildman script to build TF-A
Date: Tue, 16 Sep 2025 09:14:18 -0700
Message-Id: <20250916161426.32259-3-raymond.mao@linaro.org>
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

Add a script which is running after buildman to fetch TF-A (v2.13.0)
with MbedTLS (v3.6) and build 'flash.bin', linking built U-Boot as
BL33 and OP-TEE as BL32, with both Firmware Handoff and Measured Boot
enabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 .azure-pipelines.yml               |  1 +
 .gitlab-ci.yml                     |  1 +
 tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100755 tools/post_build_tfa_fw_handoff.sh

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 8209d2b329c..eb547606ddd 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -290,6 +290,7 @@ stages:
           cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_riscv64.efi
           cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm64.efi
           cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.efi
+          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAVIS_BUILD_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
           # create sdcard / spi-nor images for sifive unleashed using genimage
           if [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
               mkdir -p root;
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 85401d3e09b..61e4af96c9a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -79,6 +79,7 @@ stages:
     - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_riscv64.efi
     - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm64.efi
     - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.efi
+    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} ${TEST_PY_BD} ${TEST_PY_ID}
     # create sdcard / spi-nor images for sifive unleashed using genimage
     - if [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
         mkdir -p root;
diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_build_tfa_fw_handoff.sh
new file mode 100755
index 00000000000..f876db593ba
--- /dev/null
+++ b/tools/post_build_tfa_fw_handoff.sh
@@ -0,0 +1,87 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2025 Linaro Limited
+# Author: Raymond Mao <raymond.mao@linaro.org>
+#
+# CI Post-buildman script for building TF-A 'flash.bin' with Measured
+# Boot and Firmware Handoff enabled.
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} \
+#     ${TEST_PY_BD} ${TEST_PY_ID}
+#
+# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and copied
+# to /tmp.
+
+set -e
+
+BUILDMAN_OUT_DIR=$(realpath "$1")
+BOARD=$2
+ID=$4
+echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID: $ID"
+
+# U-Boot binary generated by buildman
+BL33_BIN=${BUILDMAN_OUT_DIR}/u-boot.bin
+# Path to the toolchain file that generated by buildman
+TOOLCHAIN_INFO_FILE=${BUILDMAN_OUT_DIR}/toolchain
+
+MBEDTLS_DIR=/tmp/mbedtls
+TFA_DIR=/tmp/tfa-fh
+OPTEE_DIR=/tmp/optee_os
+OPTEE_OUT_DIR=${OPTEE_DIR}/out/arm-plat-vexpress/core
+BL32_BIN=${OPTEE_OUT_DIR}/tee-header_v2.bin
+BL32_EXTRA1_BIN=${OPTEE_OUT_DIR}/tee-pager_v2.bin
+BL32_EXTRA2_BIN=${OPTEE_OUT_DIR}/tee-pageable_v2.bin
+
+if [[ "$BOARD" != "qemu_arm64" || "$ID" != "fw_handoff_tfa_optee" ]]; then
+    exit 0
+fi
+
+if [ -f "$TOOLCHAIN_INFO_FILE" ]; then
+  # Extract path and cross prefix of the toolchain
+  TOOLCHAIN_PATH=$(grep '^path ' "$TOOLCHAIN_INFO_FILE" | cut -d' ' -f2)
+  TOOLCHAIN_PREFIX=$(grep '^cross ' "$TOOLCHAIN_INFO_FILE" | cut -d' ' -f2)
+  TOOLCHAIN_NAME="${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}"
+  echo "Extracted toolchain: $TOOLCHAIN_NAME"
+else
+  echo "ERROR: toolchain info file not found!"
+  exit 1
+fi
+
+# Set the same toolchain used by buildman for building
+CROSS="CROSS_COMPILE=$TOOLCHAIN_NAME"
+
+# Get TF-A (v2.13.0) and MbedTLS (v3.6)
+git clone --depth=1 --branch mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git ${MBEDTLS_DIR}
+git clone --depth=1 --branch v2.13.0 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git ${TFA_DIR}
+
+make -C ${TFA_DIR} \
+  ${CROSS} \
+  PLAT=qemu \
+  BL33=${BL33_BIN} \
+  BL32=${BL32_BIN} \
+  BL32_EXTRA1=${BL32_EXTRA1_BIN} \
+  BL32_EXTRA2=${BL32_EXTRA2_BIN} \
+  BL32_RAM_LOCATION=tdram SPD=opteed \
+  TRANSFER_LIST=1 E=0 \
+  TRUSTED_BOARD_BOOT=1 \
+  GENERATE_COT=1 \
+  CREATE_KEYS=1 \
+  DECRYPTION_SUPPORT=aes_gcm \
+  ENCRYPT_BL31=1 \
+  ENCRYPT_BL32=1 \
+  ENABLE_STACK_PROTECTOR=strong \
+  KEY_ALG=rsa \
+  KEY_SIZE=4096 \
+  MEASURED_BOOT=1 \
+  EVENT_LOG_LEVEL=10 \
+  KEY_ALG=rsa \
+  MBOOT_EL_HASH_ALG=sha256 \
+  MBEDTLS_DIR=${MBEDTLS_DIR} \
+  all fip
+
+TFA_OUT_DIR=${TFA_DIR}/build/qemu/release
+dd if=${TFA_OUT_DIR}/bl1.bin of=${TFA_OUT_DIR}/flash.bin bs=4096 conv=notrunc
+dd if=${TFA_OUT_DIR}/fip.bin of=${TFA_OUT_DIR}/flash.bin seek=64 bs=4096 conv=notrunc
+cp ${TFA_OUT_DIR}/bl1.bin ${TFA_OUT_DIR}/fip.bin ${TFA_OUT_DIR}/flash.bin /tmp/
-- 
2.25.1

