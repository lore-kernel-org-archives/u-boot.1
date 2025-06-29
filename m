Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214A0C7EE39
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 10:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E8582ADA;
	Sun, 29 Jun 2025 12:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="koWG1vRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60AD81FEE; Sun, 29 Jun 2025 12:57:52 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B7F82E5A
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 12:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-553b5165cf5so4624834e87.0
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194661; x=1751799461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ypS+N78F4yq06eSAA9LFatKkT5qmXLjtywn5021018=;
 b=koWG1vRYXjqS3nHMVfWInpOSvZLPEL6x8HAXSEpFTqNQaGrBijsiywP8yHyZcqAgKv
 GRrMfOW1cn6wAWCxdj/nWiapZY72XZwBiLYEi3N0eipG36xk4DEeZfmsmHkitoSxoNPc
 tSSxKCuowGSyu6ZRsecJnRro++aXpN5AqsJeoIGobUmK/Z6Z2aZqheoh+VgiwRiokEtW
 Cq8YNmPqpBS7oG8Hf80rRcwPy1dC1mrC6/KMFEVN5ehslBJNVgH6/1lXAD+w70fB1ouB
 UP1fB2RfIScO7bWLSAotZR70uCB042lhmMFByKUhLwRdhsdl/PNyICHHkdqwHoiaeSUx
 WxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194661; x=1751799461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ypS+N78F4yq06eSAA9LFatKkT5qmXLjtywn5021018=;
 b=nTT8tKS+1fa3K/1LXvxJYAOFmnF8T4sobp3x9iR9Mhlh7vaqhiHM3ppVZYK2eHLgNG
 Ghv+0lX2s0O/XZkNCXsX07BUVjA93gkgYKl4rOyzK6ejBIatCf+sLa/4RYWvcqRHoOd1
 PZmX9dAbqQvMWcsgzwnDct4sXSSN6cKjjP3iw7cBrYoq5YcYP8Cr6J382EDPUwRpmQgH
 hMND1ZJ4k8Qx+5a4iIUj8W7kyWik/QaipCcFEWN8nCLgtIr9uruCSw0VxXOMi38Fxp3o
 IsLdq4daz3vkDZJgMug4rsX6OxP2iGWHsxNk7rVbGk1PuRF2HL8akHrUfrCB2C+4AQot
 0MMA==
X-Gm-Message-State: AOJu0YxAdFY/SBDUIHK/W0WDOhOaAlBd3dKSWlOsS1/OcdSIWvEBFVT6
 kcsSikbwF9rU9OGQx8e+oolALqXwNpFdEEPrlNVK7l+21WVZRtH0cIKw
X-Gm-Gg: ASbGnctNw18aS0gKfSlU/27WFxmMUUr6EqWekySKeWg8aaJgqFCkLFIqVCe1JQMEU9T
 z7atf0bjzhReAloRYh7NvPYxPM6XSGDgu4wGyfmzr5ZtVHxuHLY27FuPMYSX4Sb1RG+ifdm74gL
 VwPGHt/ddRVqI2dWcuXOu1L3tS/wmmu5uiFaYLuQJ/a/rDZU+vLSqARnMAeYyaHXKt3khvgah5A
 0E1QYRH24sCSineVGCPYFL8GNw7Ma609VpbyUyeQcHvS/50P5B1lsnFckkUQH+/6Y2+nexQkIOU
 pK97UsrItPFvRQVjm7LLTxAg9f+Yy/CEvuqaCacfWbOgjz+na7PcEQ==
X-Google-Smtp-Source: AGHT+IHRKXjP/PXCEjE+VWQWr5vwkWD2mFvhKt///zre76LBTwM4oW9QqJ8oMaI2ySZ+zS7JF0W4Yg==
X-Received: by 2002:a05:6512:3e0b:b0:54a:cc76:1676 with SMTP id
 2adb3069b0e04-5550ba27be5mr3125017e87.44.1751194660814; 
 Sun, 29 Jun 2025 03:57:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24d32esm1092514e87.69.2025.06.29.03.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 03:57:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heiko Schocher <hs@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ion Agorria <ion@agorria.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wang Jie <dave.wang@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/4] test: dm: add AES engine test
Date: Sun, 29 Jun 2025 13:57:11 +0300
Message-ID: <20250629105711.24687-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250629105711.24687-1-clamor95@gmail.com>
References: <20250629105711.24687-1-clamor95@gmail.com>
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

Create a basic test suit for AES DM uclass that covers all available
operations.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/sandbox/dts/test.dts          |  4 +++
 configs/sandbox64_defconfig        |  2 ++
 configs/sandbox_defconfig          |  2 ++
 configs/sandbox_flattree_defconfig |  3 ++
 test/dm/Makefile                   |  1 +
 test/dm/aes.c                      | 57 ++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+)
 create mode 100644 test/dm/aes.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 7026c73bc69..bb696c5ef7f 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -2150,6 +2150,10 @@
 			};
 		};
 	};
+
+	aes-engine {
+		compatible = "software-aes-engine";
+	};
 };
 
 #include "sandbox_pmic.dtsi"
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 34e89bf6b3e..8fdc581c205 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -137,6 +137,8 @@ CONFIG_CLK_K210=y
 CONFIG_CLK_K210_SET_RATE=y
 CONFIG_SANDBOX_CLK_CCF=y
 CONFIG_CPU=y
+CONFIG_DM_AES=y
+CONFIG_AES_SOFTWARE=y
 CONFIG_DM_DEMO=y
 CONFIG_DM_DEMO_SIMPLE=y
 CONFIG_DM_DEMO_SHAPE=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 4f6943d1a4b..602397430f0 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -186,6 +186,8 @@ CONFIG_CLK_K210_SET_RATE=y
 CONFIG_SANDBOX_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_CPU=y
+CONFIG_DM_AES=y
+CONFIG_AES_SOFTWARE=y
 CONFIG_DM_DEMO=y
 CONFIG_DM_DEMO_SIMPLE=y
 CONFIG_DM_DEMO_SHAPE=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 67c0ed7353e..317d7dc9c20 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -75,6 +75,7 @@ CONFIG_CMD_QFW=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_AES=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_TPM_TEST=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -115,6 +116,8 @@ CONFIG_CLK_K210=y
 CONFIG_CLK_K210_SET_RATE=y
 CONFIG_SANDBOX_CLK_CCF=y
 CONFIG_CPU=y
+CONFIG_DM_AES=y
+CONFIG_AES_SOFTWARE=y
 CONFIG_DM_DEMO=y
 CONFIG_DM_DEMO_SIMPLE=y
 CONFIG_DM_DEMO_SHAPE=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 917dafe7d22..d15859eca30 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -29,6 +29,7 @@ obj-(CONFIG_DM_GPIO) += gpio.o
 obj-y += irq.o
 endif
 obj-$(CONFIG_ADC) += adc.o
+obj-$(CONFIG_AES_SOFTWARE) += aes.o
 obj-$(CONFIG_SOUND) += audio.o
 obj-$(CONFIG_AXI) += axi.o
 obj-$(CONFIG_BLK) += blk.o
diff --git a/test/dm/aes.c b/test/dm/aes.c
new file mode 100644
index 00000000000..702e4db2b35
--- /dev/null
+++ b/test/dm/aes.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the driver model AES API
+ *
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <dm/test.h>
+#include <uboot_aes.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define AES128_KEYSIZE		128
+
+static int dm_test_aes(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 test_key[AES128_KEY_LENGTH] = { 0x63, 0x68, 0x69, 0x63, 0x6b, 0x65, 0x6e, 0x20,
+					   0x74, 0x65, 0x72, 0x69, 0x79, 0x61, 0x6b, 0x69 };
+	u8 test_iv[AES128_KEY_LENGTH] = { 0 };
+
+	u8 test_input[AES_BLOCK_LENGTH] = { 0x49, 0x20, 0x77, 0x6f, 0x75, 0x6c, 0x64, 0x20,
+					    0x6c, 0x69, 0x6b, 0x65, 0x20, 0x74, 0x68, 0x65 };
+	u8 exp_output[AES_BLOCK_LENGTH] = { 0x97, 0x68, 0x72, 0x68, 0xd6, 0xec, 0xcc, 0xc0,
+					    0xc0, 0x7b, 0x25, 0xe2, 0x5e, 0xcf, 0xe5, 0x84 };
+	u8 exp_cmac[AES_BLOCK_LENGTH] = { 0xfc, 0x89, 0x20, 0xc8, 0x46, 0x97, 0xb1, 0x3d,
+					  0x31, 0x2c, 0xc2, 0x49, 0x5c, 0x5a, 0x0b, 0x9f };
+	u8 test_output[AES_BLOCK_LENGTH];
+
+	ut_assertok(uclass_first_device_err(UCLASS_AES, &dev));
+
+	/* software AES exposes 2 key slots */
+	ut_asserteq(2, dm_aes_get_available_key_slots(dev));
+
+	ut_assertok(dm_aes_select_key_slot(dev, AES128_KEYSIZE, 0));
+	ut_assertok(dm_aes_set_key_for_key_slot(dev, AES128_KEYSIZE, test_key, 0));
+
+	ut_assertok(dm_aes_ecb_encrypt(dev, test_input, test_output, 1));
+	ut_assertok(memcmp(exp_output, test_output, 16));
+
+	ut_assertok(dm_aes_ecb_decrypt(dev, test_output, test_output, 1));
+	ut_assertok(memcmp(test_input, test_output, 16));
+
+	ut_assertok(dm_aes_cbc_encrypt(dev, test_iv, test_input, test_output, 1));
+	ut_assertok(memcmp(exp_output, test_output, 16));
+
+	ut_assertok(dm_aes_cbc_decrypt(dev, test_iv, test_output, test_output, 1));
+	ut_assertok(memcmp(test_input, test_output, 16));
+
+	ut_assertok(dm_aes_cmac(dev, test_input, test_output, 1));
+	ut_assertok(memcmp(exp_cmac, test_output, 16));
+
+	return 0;
+}
+
+DM_TEST(dm_test_aes, UTF_SCAN_FDT);
-- 
2.48.1

