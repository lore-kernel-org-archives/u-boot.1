Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA97C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 056CE838A0;
	Tue, 22 Jul 2025 17:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n/12uoJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29261838BA; Tue, 22 Jul 2025 17:35:18 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29FF28388E
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so62266285e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198515; x=1753803315; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dZvQur3OH0IJYOi9s7wkTqpMWZXImGVZFQeMlBsFF2g=;
 b=n/12uoJrZJ6ECgGRp1ZHvKUnyEQEiXNfga+Vy72Zt+btQOzO1U6wWLeMviKR18U3WN
 nxQCCXUdiouW4H738EcyiSRXqTDUOw0Gt3XISobJ82u6jLlg5woONf9ucIAFy8P5FF9j
 4RuOiqTIpZe0+lus9uRRq1mnjDYwZ126nnyMCG1qCVAFgaZzLSeDrDt6TudF7tJpyhsQ
 nGVkWVMM3YPQCjeadUra/3KEy8VbL8SkZL2sJDsNmqOcZSSAgYHokTeZ6N8jZ3ZInfZi
 DYvzUIx+Q64ePbkWzBefqNu8AhE5DL9RYQ7g9SWmudNVsZEdvVqwAX3hEYeebm8R3Gwg
 ezUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198515; x=1753803315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZvQur3OH0IJYOi9s7wkTqpMWZXImGVZFQeMlBsFF2g=;
 b=jqw5l4TaV5p9BPjulXTCXBpBGsji9Hg+P9jzzHlB52NbhEv2BTS/5AVawXoCfrery4
 veXRbn2Qxe0pTt0cay0Mb1bDd3ovFdw0NM8Ij+xtoQJO7mpzxZenACPWIC8sZw1MpWYK
 C2doktnqf1cSapo/pp6nyd2Ra+sVUU1XWN8FnXj0vGM5ltdj8pj7Qg+zdgRJ2C0yi+Ih
 AqckrikJgtJwzjtBuouc1fQaTxd0GVyL71sqICsaLBvhnyMXFaTIBeqX+w+8xuKhBvn7
 qmIsrsL5rUbrcn7uW/2NADF5Wpq9o2re5xrjeA15sezuLaFplaBm5Ojn3YPoX3rnBocV
 WFXQ==
X-Gm-Message-State: AOJu0YzNXjjrTLxqZAImzPuuOS7/PCFEk9rSUyqCWQTAw26tClmZqT/B
 ITTuC1FJ0SPqOFGvTNwFVk4MATDDlygBHeIV+Rh45j4DKj0Akhe7g0rye378URjmcDk=
X-Gm-Gg: ASbGncvMFPDcHFjuVQHs69T+HvuK0Q5BMc86oTuE3/QODmwI2LlhyGfiMLLjd9XjPGc
 XvA74o2Drwmn5jJPxChhqjBC6MU3XF+4199svimOqXKXo3DjH01OZKIXQ/Or5/Ngs1bsnFD1KLQ
 ycyERUke9VopCSKBTbc1RlxwMSMFMEyWbeMPmhV6BdAXjvi4i8y06Z2XuVV9S5Xkqqkdsud0HYH
 YwTKIEUmSzjIUTF9GfchfH+wvOdhlzG4VqFffIeBSAnDNZ4RBKX5nP7XyWHhpDqySw6yoX0igvb
 gNrupDVcp2+3oWzeKLcbXTAZ9UricBqyqHPr5zOS3PoX9KbGTmMxvyt8iyX48KuL1iIWIlW/5g4
 KAmqob2AIk0tWv8lnk7P8Us0rq9665qFsiKWAztL+vMJuKzccUnP8wiJ3T8tWeAsULg==
X-Google-Smtp-Source: AGHT+IEXoivTcHWK2yFYP0b7KDJAw+DTJfDLYmiuMyJD3aeibYjB7v0mP+w7o3FRh3lySAxCvam7iA==
X-Received: by 2002:a05:600c:8b73:b0:456:1204:e7e6 with SMTP id
 5b1f17b1804b1-4562e38a085mr241638805e9.11.1753198515495; 
 Tue, 22 Jul 2025 08:35:15 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:14 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Date: Tue, 22 Jul 2025 17:34:57 +0200
Subject: [PATCH v5 7/8] qualcomm: use mkmbn via binman and stop creating
 ELF files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-7-df143f1247fc@linaro.org>
References: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
In-Reply-To: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4568;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=MKzOG52CLf09lQGlefaoVKZ8h3sfRHQoLU8iGQ6+Hpg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69Sv23kh5lLLK4d60iaz7ll47qrZ4tdeZ0ktLG2x2i
 4Qvn/nes6OUhUGQg0FWTJFF/MQyy6a1l+01ti+4ADOHlQlkCAMXpwBMJLSOkaFzipL78tN3b9w7
 GWFQZl/Bz73Xz/1Fe02eoQ9PAH/GCXaG/8k+6/6+M2ldoHvXZdE5ucNtx5ytfwgc9ZM+Feure3H
 HGxkA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Casey Connolly <casey.connolly@linaro.org>

Remove the load address and REMAKE_ELF from Qualcomm defconfigs. This
information is now encoded in a table in mkmbn.py.

Add a new qcom-binman.dts file to configure binman to build a u-boot.mbn
file.

mkmbn.py is now run by binman during the build process and will emit an
MBN file for supported boards with the appropriate signatures.

This removes the need for additional processing of the image in most
cases.

To avoid having to explicitly disable BINMAN_FDT in all qcom defconfigs,
make it depend on !ARCH_SNAPDRAGON.

We also duplicate the BINMAN_DTB node in mach-snapdragon/kconfig to set
the default path to the qcom binman dtb for configuring binman.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/dts/qcom-binman.dts       | 16 ++++++++++++++++
 arch/arm/mach-snapdragon/Kconfig   |  4 ++++
 configs/qcm6490_defconfig          |  4 ----
 configs/qcom_ipq9574_mmc_defconfig |  1 -
 configs/qcs9100_defconfig          |  3 ---
 lib/Kconfig                        |  2 +-
 7 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9ed55e6cfacd..1ac94a4ab420 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1122,8 +1122,9 @@ config ARCH_RENESAS
 
 config ARCH_SNAPDRAGON
 	bool "Qualcomm Snapdragon SoCs"
 	select ARM64
+	select BINMAN
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
 	select DM_RESET
diff --git a/arch/arm/dts/qcom-binman.dts b/arch/arm/dts/qcom-binman.dts
new file mode 100644
index 000000000000..da5d4a23d2fa
--- /dev/null
+++ b/arch/arm/dts/qcom-binman.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2025, Linaro Ltd.
+ *
+ * Casey Connolly <casey.connolly@linaro.org>
+ */
+
+/* Configure binman to build a u-boot.mbn */
+/dts-v1/;
+/{
+	binman {
+		u-boot-mbn {
+
+		};
+	};
+};
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fcef..5d734e09570c 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -44,5 +44,9 @@ config SYS_CONFIG_NAME
 	  This option contains information about board configuration name.
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config BINMAN_DTB
+	string "binman DTB description"
+	default "./arch/arm/dts/qcom-binman.dtb"
+
 endif
diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaecb..63daa74a451a 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -7,9 +7,5 @@
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
 
-# Address where U-Boot will be loaded
-CONFIG_TEXT_BASE=0x9fc00000
-CONFIG_REMAKE_ELF=y
-
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 720220dc98a8..02ffaf97b624 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -11,9 +11,8 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
 CONFIG_SYS_LOAD_ADDR=0x50000000
 CONFIG_DEBUG_UART_BASE=0x78b1000
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 # CONFIG_BOOTSTD is not set
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 216dfa3211ec..e1f6d6fdf00e 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -4,11 +4,8 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
 
-# Address where U-Boot will be loaded
-CONFIG_TEXT_BASE=0xaf000000
-CONFIG_REMAKE_ELF=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
 CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_SCSI_ENV_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
diff --git a/lib/Kconfig b/lib/Kconfig
index 6a89f797beff..443363f889b6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -36,9 +36,9 @@ config BCH
 	  hardware engine required for BCH ECC correction.
 
 config BINMAN_FDT
 	bool "Allow access to binman information in the device tree"
-	depends on BINMAN && DM && OF_CONTROL
+	depends on BINMAN && DM && OF_CONTROL && !ARCH_SNAPDRAGON
 	default y if OF_SEPARATE || OF_EMBED
 	help
 	  This enables U-Boot to access information about binman entries,
 	  stored in the device tree in a binman node. Typical uses are to

-- 
2.50.1

