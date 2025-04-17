Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D84C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5EFA83086;
	Thu, 17 Apr 2025 20:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I6jJXZ/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C2FA8319F; Thu, 17 Apr 2025 20:17:18 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D16F783145
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so3714515ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913833; x=1745518633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4F/rQc0pSicliNcOv5rUXQ5RIMdbnc0VnJVgOnc24EQ=;
 b=I6jJXZ/DYM5z326Kfyw8m8xvV/ZyucrLsZMDbWu0ZUtR6waioHnHxClw+egow561WG
 uganLw0760dw3MUyIzFnLucz9A4auwkIepSiNIbH0gOA+o7G/ennxjNGBqHuCqoIONVH
 60vTz7ts/q7JHU8yIUGH+ScfyPMIC+9RQklP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913833; x=1745518633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4F/rQc0pSicliNcOv5rUXQ5RIMdbnc0VnJVgOnc24EQ=;
 b=CVoaykalh24ZWsGu/6vAZnDRpH4UJ8uZNkpyBW0tJkiUmdauA6185urrUCJN78O1zZ
 JgEQXMxSVR17qmJigmHu3LsdG/qKlRXCgEaRk0FcpBAsr18nauHWl7pq6sZ5xFwL717V
 K2qaX8kqeWaYqJw5L16ZH5DNOTkH8tPoVqcP4QF8H2xl7ZGg7yjz1M0KzrhwLiEOcy3L
 XY8AD6Xfc+ZjOlu3z1+3KLyL60GtbSmiMLx7hfMyEBM4tap01VY7cmFF15lS1bFudmdl
 5N3X/bdkjuCS3MR/1nhmyl0gMfIfkhuDzUT6+UGKXwPtO9AL8zUxN3QiEhvo/T2G6HUX
 NDxg==
X-Gm-Message-State: AOJu0YzlNb0Oj6EFYdZww69BUvRqWV9X9xOOzOvvdoiVlM+592ByWU99
 VQ9uongzbKFXtultSMcYmbV/F3vJEX9TXUp3HX7k5j9onztS9f6CaUCU+eJkvVaC+HesyM4BYMI
 =
X-Gm-Gg: ASbGncvIa3EE4rAZcss7dJEaML/LY9MHGNiQXi4pSuR4kQPa7yX0l7443aPqAW9tZGK
 o2vaZbytWHlKLMdEC4Oifk77HrSqGB/R56pg+NP1iz+jDrZ0X29FYKkk8U1wbZr/jv1VcpDiLAW
 DRk8K05J2MAaMf6k8SKraUlNw4yG7GdS8LiJWjO98KHZ4vOUDbN22DkpfosnCXNDU3Sk1j6K9oK
 PitWlFYDBoiInzo8h2vov7OlUeQAba16z/1WcPXSnHh7CFFVSk8hGW2t/H9eIFRpr9zHoaHfdnG
 rPzwHAvyTmrTaKgJkvp+z1OaVugSLqnU3T5Kv5n9a+FELL594BuOK+gFsKHHSvp8PDY/6luhvFE
 GY6CvLyDd04Kv
X-Google-Smtp-Source: AGHT+IH+F9RUfI7uWvMa48NCTON8Pvaqy9tbKDdKjvIxS8MgM941SYQhPsRk4oPDm9HdY8qiXKZ4Iw==
X-Received: by 2002:a92:ca48:0:b0:3d0:47cf:869c with SMTP id
 e9e14a558f8ab-3d8942886e8mr648015ab.19.1744913833587; 
 Thu, 17 Apr 2025 11:17:13 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v3 17/22] passage: Add a qemu test for ARM
Date: Thu, 17 Apr 2025 12:15:59 -0600
Message-ID: <20250417181613.1355024-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

