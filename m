Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D032C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6892D8295C;
	Sat, 10 May 2025 15:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CrYfNZfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327B782C15; Sat, 10 May 2025 15:44:16 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4701282952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ace3b03c043so481033866b.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884653; x=1747489453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKn/58Ok4r3Ckp32k8mLd7cKISiLcFO5N+GWLJKqEC0=;
 b=CrYfNZfsvwil2p8aB7ZwAEKafomoOR0sGl14AbRRTzR7PfBUChVFnGhbvqwCG9kl8s
 /Sne7QFbZx7uN0UhW7qfZpSzQmWMXrXJuUt0DAqiXdhNKlAzwX9Bv/nf0IDPxJUHQb3c
 MayivN4f4R0oogrJMrzQ8nsXYzI1FT7yKiWJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884653; x=1747489453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKn/58Ok4r3Ckp32k8mLd7cKISiLcFO5N+GWLJKqEC0=;
 b=v7uQbB6Te8B311cknuCbsSDtPrEyX2WELxC1suV2vHT0fzXZGJoVRS7zHLto0JnNUH
 wfeuc1326csb0MRWTIUGEiYtCw4GoVaVED+1gdfGVK8Pbxe1m2HCA4dCu+feHjP4Rlny
 nma2vvFkKZuq838Syp3pYXoQUMW6pzoXEMw5AWH6cgVJjiz19dVc7nFlJnTnrv6IFUbG
 8l0Frsr5j1IyTVGmK8i3wN4EYDMN8smocgyW3jvM1/oDNUMOe9ysFiZhubRF6x0BJ3iS
 bKy2/G20t6bT4ryiO1O7i1QDR7Y+6rKAjVNLWc7mYxg81ft12xEpnKSWcwKVrGxv15Yn
 YAMA==
X-Gm-Message-State: AOJu0YxA8Xuk2Fvyv6xbcgePb71nyZJncoFeFNdcZmKYjUSBGvz8afCf
 MfmyNwa/x+PVHjJDQbPu95noOsQe/sgJFZAruBIN6XQd1VQPY464AjMDAhy2xMLUYor6hNIYGCC
 fVgHgqPyhIA==
X-Gm-Gg: ASbGnctz0zK0R63HErLEh/Vsx42OBzf3NtSp9j5TSOihGhL2Fk/jfiC7+Fnpfw7ENBH
 ICjeK/C+xr7pO1XbdGfsiyBifYn8YZT1tY6ngWodXiws/sWeZ1yRgG5IhGMmLfIxHfN3z6uhMEo
 fQDEBAvl4PMKF2ySVPg5KvPkpVpqvgioRgYUmr65qTrozSWbOptbaIne7Ia5KUeB4pJQLKNwmy1
 0oSYt/g+/uZFHcWmLrNKSIftHSXFZUcotlukuuf+YMAxvNjtBfRlLwfzdXfREsQi3NqMe7Z7U2d
 g33EGzBtHi1gYWPtlw3UGOXHokvDaqoFHnnizu6BAXj/vx3IDFE5daH3oxctKWwqNPHy1xh17VL
 rdm0=
X-Google-Smtp-Source: AGHT+IFQpqhaHziOaYKWHTQP6ATy198CEP8PshZgje1GT9aapTbE1DvIbPfCCOpsG2czfV2IViKoLA==
X-Received: by 2002:a17:907:84c:b0:ad1:8f1f:6961 with SMTP id
 a640c23a62f3a-ad2191405e9mr609991366b.43.1746884652745; 
 Sat, 10 May 2025 06:44:12 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v4 17/22] passage: Add a qemu test for ARM
Date: Sat, 10 May 2025 15:42:15 +0200
Message-ID: <20250510134253.1581164-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

Check that the standard passage works on ARM, by setting it up in SPL
and making sure that it comes through correctly in U-Boot proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add conditions to avoid enaling the test on qemu_arm_sbsa
- Add support for a 64-bit test also

Changes in v2:
- Add a devicetree for qemu-arm so that qemu_arm_spl can work

 configs/qemu_arm64_spl_defconfig |  5 +++++
 configs/qemu_arm_spl_defconfig   |  6 ++++++
 test/py/tests/test_passage.py    | 13 +++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 test/py/tests/test_passage.py

diff --git a/configs/qemu_arm64_spl_defconfig b/configs/qemu_arm64_spl_defconfig
index a9ed47c8d3b..60651f80938 100644
--- a/configs/qemu_arm64_spl_defconfig
+++ b/configs/qemu_arm64_spl_defconfig
@@ -33,6 +33,10 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_PASSAGE=y
+CONFIG_BLOBLIST_SIZE=0x4000
+CONFIG_SPL_BLOBLIST_ALLOC=y
+CONFIG_PASSAGE_IN=y
 CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SEPARATE_BSS is not set
@@ -47,6 +51,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_PASSAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SPL_DM=y
diff --git a/configs/qemu_arm_spl_defconfig b/configs/qemu_arm_spl_defconfig
index 9c4408dc73c..cf8ac703577 100644
--- a/configs/qemu_arm_spl_defconfig
+++ b/configs/qemu_arm_spl_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-arm"
 CONFIG_TARGET_QEMU_ARM_32BIT_SPL=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x9000
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x40200000
 CONFIG_DEBUG_UART_BASE=0x9000000
@@ -34,6 +35,10 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_PASSAGE=y
+CONFIG_BLOBLIST_SIZE=0x4000
+CONFIG_SPL_BLOBLIST_ALLOC=y
+CONFIG_PASSAGE_IN=y
 CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
@@ -44,6 +49,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_PASSAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SPL_DM=y
diff --git a/test/py/tests/test_passage.py b/test/py/tests/test_passage.py
new file mode 100644
index 00000000000..4d95287fe55
--- /dev/null
+++ b/test/py/tests/test_passage.py
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2021 Google LLC
+
+import pytest
+
+@pytest.mark.buildconfigspec('qemu_manual_dtb')
+@pytest.mark.buildconfigspec('arm')
+@pytest.mark.buildconfigspec('of_passage')
+def test_passage(ubman):
+    """Test that the standard passage on ARM from SPL to U-Boot works."""
+
+    response = ubman.run_command('bdinfo')
+    assert 'devicetree  = passage' in response
-- 
2.43.0

