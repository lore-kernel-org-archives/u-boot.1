Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10AFC52D71
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 21:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D8F8867B;
	Mon,  5 Aug 2024 23:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ABVGEf4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994EA8890F; Mon,  5 Aug 2024 23:25:24 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1A58862E
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 23:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-368440b073bso117013f8f.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722893122; x=1723497922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YPIRLw6ahQayeto4/7QIWYAd64IGXdnbDE8t3BIoVc=;
 b=ABVGEf4S3eOTzgwVqsatjz629W66Hc49QQwan0pCBrYMWfscd1ntmuh3RFfoIx6tKM
 DDdvfRB5Odcr/UQBbR7riIcecm43M9iY9R1EsaVM/+juPCOgMpATEIS1TF3tgAUEjMLu
 T6C3zMwxamusa3PwUpPJ9DkFsFIsw/QCeX5xDORmyY8mzChgZRDQfBKDMyNRDsfuTVTu
 CCoocX+kzA8o971qHyNvCvcFa6YijxF9QaNYKJ/nsSG/1O/boS7PvW8hbcP8JihtdQe2
 YBiILBtID8C++KNW+pAscctI7Bung29rfIQghVCm8b4ZzGPgjBDkhRcfQVur7lyL+SKK
 t/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722893122; x=1723497922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YPIRLw6ahQayeto4/7QIWYAd64IGXdnbDE8t3BIoVc=;
 b=RJp8GXn6m5XITJvG2yi8OuHNZ1MS3Mll4iTMbAlddd+13KK9iVn6Okrvs+JEasg0ib
 NCUWdrzqxpAxV3OON5VHQ4LYWB9paAdSN4584hv8/jh8QM+/6MwDOrBkM+sTNc1HHaHE
 hC4v5aiscwks1pc0njs50v2ybsXxHDob0xGlR9tdJQMtEXuBbgs8CYtPPXmTu9bsb+Ae
 H+5r51BVRur4Rag9lcbxiLMsdx18VQ48Ew1tzSWUznk9c/B2WnWcOCxzixOce/kUASso
 WH3l7kLU22l2SRxH9db50YBFa3VZidRLsw8c7okTWPaZRCxaEmB7+xDV0nXMx1hlZt4M
 9XEQ==
X-Gm-Message-State: AOJu0Yx/uoCXCYtp43KtEzTxMuexIKd3ivEEOyHaQgInoE/zkKPSa1O9
 YIjyid/Jpu5dK61cRae98BSCxh4KYZofkeLwyxX7mmasFGXb83k2HflseA==
X-Google-Smtp-Source: AGHT+IGzWuzOa2ioomdqe8FIPFJNpEfaOi7eyPJTAqr0AFCea5U1CovlZ5jvelMy60LUj9Te2/RhxQ==
X-Received: by 2002:a5d:5f44:0:b0:366:e9f5:781b with SMTP id
 ffacd0b85a97d-36bbbe75257mr11182182f8f.21.1722893121998; 
 Mon, 05 Aug 2024 14:25:21 -0700 (PDT)
Received: from p1g2.lan ([2001:861:3201:3d10:ab7b:e9dd:27f4:647d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c33bsm11018351f8f.22.2024.08.05.14.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 14:25:21 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH v2 4/5] mach-imx: Add i.MX 8ULP binman support
Date: Mon,  5 Aug 2024 23:25:10 +0200
Message-ID: <20240805212511.653667-5-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805212511.653667-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805212511.653667-1-bisson.gary@gmail.com>
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

- Re-use i.MX 93 Makefile target as similar boot process
- Create imx8ulp-u-boot.dtsi for binman image architecture
- Create both SPL and U-Boot containers configuration

Key differences between the 93 and 8ULP SPL container are:
- No LPDDR training library needed for 8ULP
- 8ULP requires a uPower binary (RISC-V core) for power management
- 8ULP also requires a M33 binary to work properly

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8ulp-u-boot.dtsi        | 63 +++++++++++++++++++++++++
 arch/arm/mach-imx/Makefile              |  4 +-
 arch/arm/mach-imx/imx8ulp/container.cfg |  7 +++
 arch/arm/mach-imx/imx8ulp/imximage.cfg  |  9 ++++
 4 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/imx8ulp-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx8ulp/container.cfg
 create mode 100644 arch/arm/mach-imx/imx8ulp/imximage.cfg

diff --git a/arch/arm/dts/imx8ulp-u-boot.dtsi b/arch/arm/dts/imx8ulp-u-boot.dtsi
new file mode 100644
index 00000000000..30baaeff8ef
--- /dev/null
+++ b/arch/arm/dts/imx8ulp-u-boot.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifdef CONFIG_BINMAN
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&binman {
+	u-boot-spl-ddr {
+		align = <4>;
+		align-size = <4>;
+		filename = "u-boot-spl-ddr.bin";
+		pad-byte = <0xff>;
+
+		u-boot-spl {
+			align-end = <4>;
+			filename = "u-boot-spl.bin";
+		};
+	};
+
+	spl {
+		filename = "spl.bin";
+
+		mkimage {
+			args = "-n spl/u-boot-spl.cfgout -T imx8image -e 0x22020000";
+
+			blob {
+				filename = "u-boot-spl-ddr.bin";
+			};
+		};
+	};
+
+	u-boot-container {
+		filename = "u-boot-container.bin";
+
+		mkimage {
+			args = "-n u-boot-container.cfgout -T imx8image -e 0x0";
+
+			blob {
+				filename = "u-boot.bin";
+			};
+		};
+	};
+
+	imx-boot {
+		filename = "flash.bin";
+		pad-byte = <0x00>;
+
+		spl: blob-ext@1 {
+			filename = "spl.bin";
+			offset = <0x0>;
+			align-size = <0x400>;
+			align = <0x400>;
+		};
+
+		uboot: blob-ext@2 {
+			filename = "u-boot-container.bin";
+		};
+	};
+};
+#endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index ef0caed3f7f..b311d176d64 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -129,7 +129,7 @@ DEPFILE_EXISTS := $(shell $(CPP) $(cpp_flags) -x c -o u-boot-dtb.cfgout $(srctre
 else ifeq ($(CONFIG_ARCH_IMX8M), y)
 IMAGE_TYPE := imx8mimage
 DEPFILE_EXISTS := 0
-else ifeq ($(CONFIG_ARCH_IMX9), y)
+else ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 IMAGE_TYPE := imx8image
 DEPFILE_EXISTS := 0
 else
@@ -215,7 +215,7 @@ flash.bin: spl/u-boot-spl.bin FORCE
 endif
 endif
 
-ifeq ($(CONFIG_ARCH_IMX9), y)
+ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
 quiet_cmd_imx9_check = CHECK    $@
 cmd_imx9_check = $(srctree)/tools/imx9_image.sh $@
diff --git a/arch/arm/mach-imx/imx8ulp/container.cfg b/arch/arm/mach-imx/imx8ulp/container.cfg
new file mode 100644
index 00000000000..029b79128c8
--- /dev/null
+++ b/arch/arm/mach-imx/imx8ulp/container.cfg
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+BOOT_FROM SD 0x400
+SOC_TYPE ULP
+CONTAINER
+IMAGE A35 bl31.bin 0x20040000
+IMAGE A35 u-boot.bin CONFIG_TEXT_BASE
diff --git a/arch/arm/mach-imx/imx8ulp/imximage.cfg b/arch/arm/mach-imx/imx8ulp/imximage.cfg
new file mode 100644
index 00000000000..a55359fee23
--- /dev/null
+++ b/arch/arm/mach-imx/imx8ulp/imximage.cfg
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+BOOT_FROM SD 0x400
+SOC_TYPE ULP
+APPEND mx8ulpa2-ahab-container.img
+CONTAINER
+IMAGE PWR upower.bin
+IMAGE M40 m33_image.bin 0x1ffc2000
+IMAGE A35 u-boot-spl-ddr.bin 0x22020000
-- 
2.43.0

