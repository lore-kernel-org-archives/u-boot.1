Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69325C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF36083ACD;
	Wed, 28 May 2025 14:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C/jknHOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496F783ABF; Wed, 28 May 2025 14:34:00 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1679C8004F
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72fffa03ac6so2451590a34.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435636; x=1749040436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uaY/MfrPsxSmgja2oOswi7OR1hHogJ3ruaRUjBYV76w=;
 b=C/jknHOX/kbg0zIA3yrxHE5WAQoDuC0CkKwyrSOOkz+1WDNGfci0hErRT9yDugZy/E
 l6I44TsiiowVSc8g5yQkGzrGta0DQSOwplEn81fMikcOjSuSwxWcrjLLpzEAPctxWqoB
 oUbukTxx6A7qEHFsR7b5gdmht4t3bZHW6DFrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435636; x=1749040436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uaY/MfrPsxSmgja2oOswi7OR1hHogJ3ruaRUjBYV76w=;
 b=JAU5pGFZdp7xe/1FYOC9n/vKhJwkEoxg0nIIxpDunzM0oC+0hkUjtD9Ddd2T687x0J
 rE+qIKiqez9qqBLvE9JQC6ifnM3g/gFfurmwSWWRG4l2H9JA1KnhUJH2cLboIP4ORz7M
 8YkL0sz7kDMnh/wLtCmclOlrnK5JiNicg/TAI+zCG0LBUl/H9MvEpwIQZ8aogmyEzTKb
 tk38GPmY71MqowILaPdyFeNBfb9cgk4SHVVInbRjIr+2/4CoQYHP/CNQMftah7DgxtOI
 IFBse52i12jqQsPSGAXpxNkPUxfVaJXfN81FeZgWzYf8FC6ym2KALq/4C1rQCQK0ZRE/
 5GIA==
X-Gm-Message-State: AOJu0YxbIZGJ401d7pV7K8Rozcn6YzRRoC+fxMy5U9W9/FipcCz2Kk4R
 fPTVfx2ZEZWCLTlqrpeJP8ERz39o5PQXjpDYpxXMaGrdBlvCrXGsQs6AjVaupz6FfW7334qWxN5
 WDzg8U63B
X-Gm-Gg: ASbGncucfgjOJ8i8sdxEoRjqwmcEzRHgm+IitPSmOEDYAPqLwnCoKlraTVf9cPsZVZ/
 gNDquKIt9evgTrCcJXxUT95d8xLHeuKs9wCwjq4syMGK8A0Xzsj6/tb2mQhjPQD+ufwkh0oVI4j
 CVE9rVVCCdAQOCWjCOm6IRHfOIQBBCy0AgYkF113sBiX6t+O9euX7HvBDBFCn+StM7bWveZ+VVT
 MpfojxAfB5EHDLj6TBmg7I2f4kWo/3Oj9XbuMnJEBJAEDF7FQUbDqm1cu100kZbrLkbi3GJX7rK
 jhA9hwJGDLyWg9eIzNCpZF4IwHDZSWNSQCYZB+s38JLWPd6mQwy2jAEYDBoYTvGNny9UWbA3xMz
 sH7tkqJLdadH6
X-Google-Smtp-Source: AGHT+IE1ZaGyTVape/CxK9uwMNsg/OdZHOnONLZQ4TDW9H9pL0rlQxjli5GTG+qNHk0CxebXL3JybQ==
X-Received: by 2002:a05:6808:6f87:b0:402:2a3:57ea with SMTP id
 5614622812f47-40664803bbamr1069991b6e.18.1748435635702; 
 Wed, 28 May 2025 05:33:55 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v5 20/25] passage: Add a qemu test for ARM
Date: Wed, 28 May 2025 06:32:22 -0600
Message-ID: <20250528123236.1138632-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

Changes in v5:
- Enable the test for any board which uses OF_PASSAGE

Changes in v3:
- Add conditions to avoid enaling the test on qemu_arm_sbsa
- Add support for a 64-bit test also

Changes in v2:
- Add a devicetree for qemu-arm so that qemu_arm_spl can work

 configs/qemu_arm64_spl_defconfig |  5 +++++
 configs/qemu_arm_spl_defconfig   |  6 ++++++
 test/py/tests/test_passage.py    | 11 +++++++++++
 3 files changed, 22 insertions(+)
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
index 00000000000..2cb3ddd253a
--- /dev/null
+++ b/test/py/tests/test_passage.py
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2021 Google LLC
+
+import pytest
+
+@pytest.mark.buildconfigspec('of_passage')
+def test_passage(ubman):
+    """Test that the standard passage on ARM from SPL to U-Boot works."""
+
+    response = ubman.run_command('bdinfo')
+    assert 'devicetree  = passage' in response
-- 
2.43.0

