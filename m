Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2091BD2D8FA
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 10:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51FC84006;
	Tue, 27 Jan 2026 11:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H3jyY/Xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F142A83FFF; Tue, 27 Jan 2026 11:53:06 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A9783FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so54085765ad.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769511181; x=1770115981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfBnQ9g2hhvSw1olPldALATD2B4Ap+MhIS3IQT8g344=;
 b=H3jyY/XrpH+6USxhgte2DrWd0i8yjUXjjNytnkPSw4Tm4XPcPi9GgoGTw9LsfPJ30b
 N0Vu3vZUuPp3mZdDRPk5/VkkaHbyj77xxLK+nSKJjlQgRDcc91g55akQJf4n+BFh9ghi
 xsVwSBZ5goIYViNHBCLNvoBIZcSAxAeOPE1oQ+fguMxp3+NNb7I5CTM1y/JBRdeQryuT
 DtIAyL0OYUT7KGuLfYBmRO0NiVqQNTLrvyhD6BTuiJoEv0HF/pqZHDwEgxd8qAjINrnl
 Ogk0fFkYSAX96+9gY/nQ5mvCrCCzKMbraMBs+PP4i2LPa2rOirW41rqKdJJsxAL2lm2V
 uPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511181; x=1770115981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tfBnQ9g2hhvSw1olPldALATD2B4Ap+MhIS3IQT8g344=;
 b=rTkVCgEm6cc3O2fTPb11i8LGJxkZGqHYd4/Ta0Z1qxralayD65MWkYtk1nHW1asJGe
 1yugzcOcQ2O61TN4Kf7wCMqgDo0XIa0+U8Qo1b8N2pUrJ5OJ6KdsCcbK/e1y18cdvYty
 2SVpSsg7BcrVQTeA22x4hQskrhw5jSDXiYY7pR9UFsUmkmeB0U/EJAVXKWlJ7WFG3x7f
 K1mW3WD+yjs7bDBbBbEZCvFemR3Ln+RUM/gFQv8Sb1ACNIAbBLj9nT6vQ6QycEmhrF04
 nv4VPnZvRoNsZFmxCmGvJfjwf0Tn0amsVAZ/1JMwX413tcubQlYdgeSbOMP4YzibBBNO
 pILQ==
X-Gm-Message-State: AOJu0Yxq9m7Usc1LkHRwL0VAVO3ukEI3CZS3RolutKZlcqOjZAluD1tG
 e/XoYCe5t1ofZat1C5r2UylLD+owtfG2/8uNEpPcYL8YWlaOzQs+skt2I7lugiQL
X-Gm-Gg: AZuq6aIBD4b3uUGIOYnrokHXlRd8ruiFCJPU+/dp0FC9HXuf9wvKsyFo2yEjPZoHHlj
 6faqbjRqdT2tUWc8fqD2QLoctZjn0iiIH0JVtgzGJ4jyvHPvJgFbzBzyWDwA6Gekgve4zS1dSiR
 p+RixMNCKx0WN9fCrYzas/kx7pEI4uHiuY9Wfsm8ganNOcuM3HOIlx2ehTpN4Eba5EGoBHnqZFA
 /SDgsJnx6683sgUVtjU0RYP95UaQvGJ0nU04A2PUk3wVpQ4d9niBSVZI3lP8sU4RuRW4rkvl6QA
 y3UMrS8myaD5lz7SOYAqsH1xXN2BttRoxkbajoclUOOtuDBHEO3tXEL5OPhNVD/KQtTJ4ltxTkn
 hTV/2oDZC7+mhjqhConJ/nY2GlByLhMGFE/ulx2ReiaJ/cN1zf/weNlWF0bvCKSj2J9HLB1h8lI
 T6/a2foLAby8V05B7fWXtDfv//ecDKPcUJ
X-Received: by 2002:a17:902:ce83:b0:2a1:e19:ff5 with SMTP id
 d9443c01a7336-2a870e19191mr13478685ad.38.1769511181059; 
 Tue, 27 Jan 2026 02:53:01 -0800 (PST)
Received: from intel-VirtualBox.. ([185.213.82.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fd929asm115094775ad.90.2026.01.27.02.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 02:53:00 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>
Subject: [PATCH v4 1/2] Add CoreCourse socfpga Board AC501
Date: Tue, 27 Jan 2026 18:52:51 +0800
Message-Id: <20260127105252.4714-2-briansune@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127105252.4714-1-briansune@gmail.com>
References: <20260127105252.4714-1-briansune@gmail.com>
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

CoreCourse Altera GEN5 Cyclone V board
do support different size and formfactor.
Now introducing AC501 C5 to mainstream u-boot
This is a UBGA-484 based board with basic
feature. More info on [1]

[1] https://corecourse.cn/forum.php?mod=viewthread&tid=27704&highlight=AC501

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  85 +++
 .../dts/socfpga_cyclone_ac501soc-u-boot.dtsi  |  44 ++
 arch/arm/mach-socfpga/Kconfig                 |   7 +
 board/corecourse/ac501soc/MAINTAINERS         |   6 +
 board/corecourse/ac501soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
 board/corecourse/ac501soc/qts/pinmux_config.h | 222 ++++++
 board/corecourse/ac501soc/qts/pll_config.h    |  86 +++
 board/corecourse/ac501soc/qts/sdram_config.h  | 349 +++++++++
 configs/socfpga_ac501soc_defconfig            |  85 +++
 10 files changed, 1549 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi
 create mode 100644 board/corecourse/ac501soc/MAINTAINERS
 create mode 100644 board/corecourse/ac501soc/qts/iocsr_config.h
 create mode 100644 board/corecourse/ac501soc/qts/pinmux_config.h
 create mode 100644 board/corecourse/ac501soc/qts/pll_config.h
 create mode 100644 board/corecourse/ac501soc/qts/sdram_config.h
 create mode 100644 configs/socfpga_ac501soc_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3cd762977cb..2210b44f9bf 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -469,6 +469,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_cyclone5_socrates.dtb			\
 	socfpga_cyclone5_sr1500.dtb			\
 	socfpga_cyclone5_vining_fpga.dtb		\
+	socfpga_cyclone5_ac501soc.dtb			\
 	socfpga_n5x_socdk.dtb				\
 	socfpga_stratix10_socdk.dtb
 
diff --git a/arch/arm/dts/socfpga_cyclone5_ac501soc.dts b/arch/arm/dts/socfpga_cyclone5_ac501soc.dts
new file mode 100644
index 00000000000..0b32a574086
--- /dev/null
+++ b/arch/arm/dts/socfpga_cyclone5_ac501soc.dts
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025, Brian Sune
+ *
+ * based on socfpga_cyclone5_socdk.dts
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "CoreCourse AC501SoC";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 = &gmac1;
+		udc0 = &usb1;
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+};
+
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+
+	rxd0-skew-ps = <420>;
+	rxd1-skew-ps = <420>;
+	rxd2-skew-ps = <420>;
+	rxd3-skew-ps = <420>;
+	txen-skew-ps = <0>;
+	txc-skew-ps = <1860>;
+	rxdv-skew-ps = <420>;
+	rxc-skew-ps = <1680>;
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&porta {
+	bank-name = "porta";
+};
+
+&portb {
+	bank-name = "portb";
+};
+
+&portc {
+	bank-name = "portc";
+};
+
+&mmc0 {
+	status = "okay";
+	bootph-all;
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&uart0 {
+	clock-frequency = <100000000>;
+	bootph-all;
+};
+
+&watchdog0 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi b/arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi
new file mode 100644
index 00000000000..8d2caf69dd1
--- /dev/null
+++ b/arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright Altera Corporation (C) 2015
+ * Copyright (c) 2018 Simon Goldschmidt
+ */
+
+#include "socfpga-common-u-boot.dtsi"
+
+/{
+	aliases {
+		udc0 = &usb1;
+	};
+};
+
+&watchdog0 {
+	status = "disabled";
+};
+
+&mmc {
+	bootph-all;
+};
+
+&uart0 {
+	clock-frequency = <100000000>;
+	bootph-all;
+};
+
+&uart1 {
+	clock-frequency = <100000000>;
+};
+
+&porta {
+	bank-name = "porta";
+};
+
+&portb {
+	bank-name = "portb";
+};
+
+&portc {
+	bank-name = "portc";
+};
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..1a0fcd64296 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -239,6 +239,10 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
 	bool "Terasic SoCkit (Cyclone V)"
 	select TARGET_SOCFPGA_CYCLONE5
 
+config TARGET_SOCFPGA_CORECOURSE_AC501SOC
+	bool "CoreCourse AC501SoC (Cyclone V)"
+	select TARGET_SOCFPGA_CYCLONE5
+
 endchoice
 
 config SYS_BOARD
@@ -263,6 +267,7 @@ config SYS_BOARD
 	default "sr1500" if TARGET_SOCFPGA_SR1500
 	default "stratix10-socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
+	default "ac501soc" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
 
 config SYS_VENDOR
 	default "intel" if TARGET_SOCFPGA_AGILEX7M_SOCDK
@@ -284,6 +289,7 @@ config SYS_VENDOR
 	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_NANO
 	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
 	default "terasic" if TARGET_SOCFPGA_TERASIC_SOCKIT
+	default "corecourse" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
 
 config SYS_SOC
 	default "socfpga"
@@ -310,5 +316,6 @@ config SYS_CONFIG_NAME
 	default "socfpga_sr1500" if TARGET_SOCFPGA_SR1500
 	default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
+	default "socfpga_ac501soc" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
 
 endif
diff --git a/board/corecourse/ac501soc/MAINTAINERS b/board/corecourse/ac501soc/MAINTAINERS
new file mode 100644
index 00000000000..1feac0c0584
--- /dev/null
+++ b/board/corecourse/ac501soc/MAINTAINERS
@@ -0,0 +1,6 @@
+SOCFPGA BOARD
+M:	Brian Sune <briansune@gmail.com>
+S:	Maintained
+F:	board/corecourse/ac501soc/
+F:	include/configs/socfpga_ac501soc.h
+F:	configs/socfpga_ac501soc_defconfig
diff --git a/board/corecourse/ac501soc/qts/iocsr_config.h b/board/corecourse/ac501soc/qts/iocsr_config.h
new file mode 100644
index 00000000000..cce43c54377
--- /dev/null
+++ b/board/corecourse/ac501soc/qts/iocsr_config.h
@@ -0,0 +1,664 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2022 Intel Corporation <www.intel.com>
+ *
+ */
+/*
+ * Altera SoCFPGA IOCSR configuration
+ */
+
+#ifndef __SOCFPGA_IOCSR_CONFIG_H__
+#define __SOCFPGA_IOCSR_CONFIG_H__
+
+#define CFG_HPS_IOCSR_SCANCHAIN0_LENGTH	764
+#define CFG_HPS_IOCSR_SCANCHAIN1_LENGTH	1719
+#define CFG_HPS_IOCSR_SCANCHAIN2_LENGTH	955
+#define CFG_HPS_IOCSR_SCANCHAIN3_LENGTH	16766
+
+const unsigned long iocsr_scan_chain0_table[] = {
+	0x00000000,
+	0x00000000,
+	0x0FF00000,
+	0xC0000000,
+	0x0000003F,
+	0x00008000,
+	0x00060180,
+	0x18060000,
+	0x18000000,
+	0x00018060,
+	0x00000000,
+	0x00004000,
+	0x000300C0,
+	0x0C030000,
+	0x0C000000,
+	0x00000030,
+	0x0000C030,
+	0x00002000,
+	0x00018060,
+	0x06018000,
+	0x06000000,
+	0x00000018,
+	0x00006018,
+	0x00001000,
+};
+
+const unsigned long iocsr_scan_chain1_table[] = {
+	0x000C0300,
+	0x300C0000,
+	0x300000C0,
+	0x000000C0,
+	0x000300C0,
+	0x80008000,
+	0x0000007F,
+	0x0001FE00,
+	0x07F80000,
+	0xE0000000,
+	0x0000001F,
+	0x00004000,
+	0x000300C0,
+	0x0C030000,
+	0x0C000000,
+	0x00000030,
+	0x0000C030,
+	0x00002000,
+	0x00018060,
+	0x00007F80,
+	0x01FE0000,
+	0xF8000000,
+	0x00000007,
+	0x00001000,
+	0x0000C030,
+	0x0300C000,
+	0x00000000,
+	0x00000010,
+	0x0000300C,
+	0x00000800,
+	0x00000000,
+	0x00000000,
+	0x01800000,
+	0x00000006,
+	0x00002000,
+	0x00000400,
+	0x00000000,
+	0x00C03000,
+	0x00000003,
+	0x00000000,
+	0x00000000,
+	0x00000200,
+	0x00601806,
+	0x00000000,
+	0x80600000,
+	0x80000601,
+	0x00000601,
+	0x00000100,
+	0x00300C03,
+	0xC0300C00,
+	0xC0300000,
+	0xC0000300,
+	0x000C0300,
+	0x00000080,
+};
+
+const unsigned long iocsr_scan_chain2_table[] = {
+	0x300C0300,
+	0x00000000,
+	0x0FF00000,
+	0x00000000,
+	0x0C0300C0,
+	0x00008000,
+	0x18060180,
+	0x18060000,
+	0x18000000,
+	0x00018060,
+	0x00018060,
+	0x00004000,
+	0x200300C0,
+	0x0C030000,
+	0x00000030,
+	0x00000000,
+	0x0300C030,
+	0x00002000,
+	0x10018060,
+	0x00000000,
+	0x06000000,
+	0x00010018,
+	0x01806018,
+	0x00001000,
+	0x0000C030,
+	0x00000000,
+	0x03000000,
+	0x0000800C,
+	0x00C0300C,
+	0x00000800,
+};
+
+const unsigned long iocsr_scan_chain3_table[] = {
+	0x0C420D80,
+	0x082000FF,
+	0x0A804001,
+	0x07900000,
+	0x08020000,
+	0x00100000,
+	0x0A800000,
+	0x07900000,
+	0x08020000,
+	0x00100000,
+	0xC8800000,
+	0x00003001,
+	0x00C00722,
+	0x00000000,
+	0x00000021,
+	0x82000004,
+	0x05400000,
+	0x03C80000,
+	0x04010000,
+	0x00080000,
+	0x05400000,
+	0x03C80000,
+	0x05400000,
+	0x03C80000,
+	0xE4400000,
+	0x00001800,
+	0x00600391,
+	0x800E4400,
+	0x00000001,
+	0x40000002,
+	0x02A00000,
+	0x01E40000,
+	0x02A00000,
+	0x01E40000,
+	0x02A00000,
+	0x01E40000,
+	0x02A00000,
+	0x01E40000,
+	0x72200000,
+	0x80000C00,
+	0x003001C8,
+	0xC0072200,
+	0x1C880000,
+	0x20000300,
+	0x00040000,
+	0x50670000,
+	0x00000010,
+	0x24590000,
+	0x00001000,
+	0xA0000034,
+	0x0D000001,
+	0xC0680A28,
+	0x41034030,
+	0x02081A00,
+	0x80A280D0,
+	0x34030C06,
+	0x01A02490,
+	0x280D0000,
+	0x30C0680A,
+	0x00410340,
+	0xD000001A,
+	0x0680A280,
+	0x10040000,
+	0x00200000,
+	0x10040000,
+	0x00200000,
+	0x15000000,
+	0x0F200000,
+	0x15000000,
+	0x0F200000,
+	0x01FE0000,
+	0x00000000,
+	0x01800E44,
+	0x00391000,
+	0x007F8006,
+	0x00000000,
+	0x0A800001,
+	0x07900000,
+	0x0A800000,
+	0x07900000,
+	0x0A800000,
+	0x07900000,
+	0x08020000,
+	0x00100000,
+	0xC8800000,
+	0x00003001,
+	0x00C00722,
+	0x00000FF0,
+	0x72200000,
+	0x80000C00,
+	0x05400000,
+	0x02480000,
+	0x04000000,
+	0x00080000,
+	0x05400000,
+	0x03C80000,
+	0x05400000,
+	0x03C80000,
+	0x6A1C0000,
+	0x00001800,
+	0x00600391,
+	0x800E4400,
+	0x1A870001,
+	0x40000600,
+	0x02A00040,
+	0x01E40000,
+	0x02A00000,
+	0x01E40000,
+	0x02A00000,
+	0x01E40000,
+	0x02A00000,
+	0x01E40000,
+	0x72200000,
+	0x80000C00,
+	0x003001C8,
+	0xC0072200,
+	0x1C880000,
+	0x20000300,
+	0x00040000,
+	0x50670000,
+	0x00000010,
+	0x24590000,
+	0x00001000,
+	0xA0000034,
+	0x0D000001,
+	0xC0680A28,
+	0x49034030,
+	0x12481A02,
+	0x80A280D0,
+	0x34030C06,
+	0x01A00040,
+	0x280D0002,
+	0x30C0680A,
+	0x02490340,
+	0xD012481A,
+	0x0680A280,
+	0x10040000,
+	0x00200000,
+	0x10040000,
+	0x00200000,
+	0x15000000,
+	0x0F200000,
+	0x15000000,
+	0x0F200000,
+	0x01FE0000,
+	0x00000000,
+	0x01800E44,
+	0x00391000,
+	0x007F8006,
+	0x00000000,
+	0x99300001,
+	0x34343400,
+	0xAA0D4000,
+	0x01C3A800,
+	0xAA0D4000,
+	0x01C3A800,
+	0xAA0D4000,
+	0x01C3A800,
+	0x00040100,
+	0x00000800,
+	0x00000000,
+	0x00001208,
+	0x00482000,
+	0x01000000,
+	0x00000000,
+	0x00410482,
+	0x0006A000,
+	0x0001B400,
+	0x00020000,
+	0x00000400,
+	0x0002A000,
+	0x0001E400,
+	0x5506A000,
+	0x00E1D400,
+	0x00000000,
+	0xC880090C,
+	0x00003001,
+	0x90400000,
+	0x00000000,
+	0x2020C243,
+	0x2A835000,
+	0x0070EA00,
+	0x2A835000,
+	0x0070EA00,
+	0x2A835000,
+	0x0070EA00,
+	0x00010040,
+	0x00000200,
+	0x00000000,
+	0x00000482,
+	0x00120800,
+	0x00002000,
+	0x80000000,
+	0x00104120,
+	0x00000200,
+	0xAC0D5F80,
+	0xFFFFFFFF,
+	0x14F3690D,
+	0x1A041414,
+	0x00D00000,
+	0x14864000,
+	0x69A47A05,
+	0xF228A3D9,
+	0xF4D1451E,
+	0x0352D348,
+	0x821A0000,
+	0x0000D000,
+	0x05140680,
+	0xD969A47A,
+	0x1EF228A3,
+	0x48F4D145,
+	0x00035292,
+	0x00080200,
+	0x00001000,
+	0x00080200,
+	0x00001000,
+	0x000A8000,
+	0x00075000,
+	0x541A8000,
+	0x03875001,
+	0x0000FF00,
+	0x00000000,
+	0x0080C000,
+	0x41000000,
+	0x00003FC2,
+	0x00820000,
+	0xAA0D4000,
+	0x01C3A800,
+	0xAA0D4000,
+	0x01C3A800,
+	0xAA0D4000,
+	0x01C3A800,
+	0x00040100,
+	0x00000800,
+	0x00000000,
+	0x00001208,
+	0xF8482000,
+	0x00000007,
+	0x00000000,
+	0x00410482,
+	0x0006A000,
+	0x0001B400,
+	0x00020000,
+	0x00000400,
+	0x00020080,
+	0x00000400,
+	0x5506A000,
+	0x00E1D400,
+	0x00000000,
+	0x0000090C,
+	0x00000010,
+	0x90400000,
+	0x00000000,
+	0x2020C243,
+	0x2A835000,
+	0x0070EA00,
+	0x2A835000,
+	0x0070EA00,
+	0x2A835000,
+	0x0070EA00,
+	0x00015000,
+	0x0000F200,
+	0x00000000,
+	0x00000482,
+	0x00120800,
+	0x00600391,
+	0x80000000,
+	0x00104120,
+	0x00000200,
+	0xAC0D5F80,
+	0xFFFFFFFF,
+	0x14F3690D,
+	0x1A041414,
+	0x00D00000,
+	0x04864000,
+	0x69A47A01,
+	0xF228A3D9,
+	0xF4D1451E,
+	0x0352D348,
+	0x821A028A,
+	0x0000D000,
+	0x00000680,
+	0xD559647A,
+	0x1EF228A3,
+	0x48F4D145,
+	0x000352D3,
+	0x00080200,
+	0x00001000,
+	0x00080200,
+	0x00001000,
+	0x000A8000,
+	0x00075000,
+	0x541A8000,
+	0x03875001,
+	0x0000FF00,
+	0x00000000,
+	0x0080C000,
+	0x41000000,
+	0x00003FC2,
+	0x00820000,
+	0xAA0D4000,
+	0x01C3A800,
+	0xAA0D4000,
+	0x01C3A800,
+	0xAA0D4000,
+	0x01C3A800,
+	0x00040100,
+	0x00000800,
+	0x00000000,
+	0x00001208,
+	0xF8482000,
+	0x00000007,
+	0x00000000,
+	0x00410482,
+	0x0006A000,
+	0x0001B400,
+	0x00020000,
+	0x00000400,
+	0x0002A000,
+	0x0001E400,
+	0x5506A000,
+	0x00E1D400,
+	0x00000000,
+	0xC880090C,
+	0x00003001,
+	0x90400000,
+	0x00000000,
+	0x2020C243,
+	0x2A835000,
+	0x0070EA00,
+	0x2A835000,
+	0x0070EA00,
+	0x2A835000,
+	0x0070EA00,
+	0x00010040,
+	0x00000200,
+	0x00000000,
+	0x00000482,
+	0xFE120800,
+	0x00000001,
+	0x80000000,
+	0x00104120,
+	0x00000200,
+	0xAC0D5F80,
+	0xFFFFFFFF,
+	0x14F3690D,
+	0x1A041414,
+	0x00D00000,
+	0x14864000,
+	0x59647A05,
+	0xF228A3D5,
+	0xF4D1451E,
+	0x03429248,
+	0x821A0000,
+	0x0000D000,
+	0x00000680,
+	0xD969A47A,
+	0x1EF228A3,
+	0x48F4D145,
+	0x00034AD3,
+	0x00080200,
+	0x00001000,
+	0x00080200,
+	0x00001000,
+	0x000A8000,
+	0x00075000,
+	0x541A8000,
+	0x03875001,
+	0x0000FF00,
+	0x00000000,
+	0x0080C000,
+	0x41000000,
+	0x00003FC2,
+	0x00820000,
+	0xAA0D4000,
+	0x01C3A800,
+	0xAA0D4000,
+	0x01C3A800,
+	0xAA0D4000,
+	0x01C3A800,
+	0x00040100,
+	0x00000800,
+	0x00000000,
+	0x00001208,
+	0xF8482000,
+	0x00000007,
+	0x00000000,
+	0x00410482,
+	0x0006A000,
+	0x0001B400,
+	0x00020000,
+	0x00000400,
+	0x00020080,
+	0x00000400,
+	0x5506A000,
+	0x00E1D400,
+	0x00000000,
+	0x00FF090C,
+	0x00000000,
+	0x90400000,
+	0x00000000,
+	0x2020C243,
+	0x2A835000,
+	0x0070EA00,
+	0x2A835000,
+	0x0070EA00,
+	0x2A835000,
+	0x0070EA00,
+	0x00010040,
+	0x00000200,
+	0x00000000,
+	0x00000482,
+	0x00120800,
+	0x00400000,
+	0x80000000,
+	0x00104120,
+	0x00000200,
+	0xAC0D5F80,
+	0xFFFFFFFF,
+	0x14F1690D,
+	0x1A041414,
+	0x00D00000,
+	0x14864000,
+	0x69A47A05,
+	0xF228A3D9,
+	0xF4D1451E,
+	0x0352D348,
+	0x821A0000,
+	0x0000D000,
+	0x00000680,
+	0xD969A47A,
+	0x1EF228A3,
+	0x48F4D145,
+	0x00035292,
+	0x00080200,
+	0x00001000,
+	0x00080200,
+	0x00001000,
+	0x000A8000,
+	0x00075000,
+	0x541A8000,
+	0x03875001,
+	0x0000FF00,
+	0x00000000,
+	0x0080C000,
+	0x41000000,
+	0x00003FC2,
+	0x00820000,
+	0x00489800,
+	0x801A1A1A,
+	0x00000200,
+	0x80000004,
+	0x00000200,
+	0x80000004,
+	0x00000200,
+	0x80000004,
+	0x00000200,
+	0xC0000004,
+	0x0000003F,
+	0x0000FF00,
+	0x03FC0000,
+	0xF0000000,
+	0x0000000F,
+	0x40002000,
+	0x00000100,
+	0x40000002,
+	0x00000100,
+	0x40000002,
+	0x00000100,
+	0x40000002,
+	0x00000100,
+	0xE0000002,
+	0x0000001F,
+	0x00007F80,
+	0x01FE0000,
+	0xF8000000,
+	0x00000007,
+	0x20001000,
+	0x00000080,
+	0x20000001,
+	0x00000080,
+	0x20000001,
+	0x00000080,
+	0x20000001,
+	0x00000080,
+	0xF0000001,
+	0x0000000F,
+	0x00003FC0,
+	0x00FF0000,
+	0xFC000000,
+	0x00000003,
+	0x00000800,
+	0xC0000001,
+	0x00041419,
+	0x40000000,
+	0x04000816,
+	0x000D0000,
+	0x00006800,
+	0x00000340,
+	0xD000001A,
+	0x06800000,
+	0x00340000,
+	0x0001A000,
+	0x00000D00,
+	0x40000068,
+	0x1A000003,
+	0x00D00000,
+	0x00068000,
+	0x00003400,
+	0x000001A0,
+	0x00000401,
+	0x00000008,
+	0x00000401,
+	0x00000008,
+	0x00000401,
+	0x00000008,
+	0x00000401,
+	0x80000008,
+	0x0000007F,
+	0x0001FE00,
+	0x07F80000,
+	0xE0000000,
+	0x0000001F,
+	0x00004000,
+};
+
+
+
+#endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/corecourse/ac501soc/qts/pinmux_config.h b/board/corecourse/ac501soc/qts/pinmux_config.h
new file mode 100644
index 00000000000..462cde84565
--- /dev/null
+++ b/board/corecourse/ac501soc/qts/pinmux_config.h
@@ -0,0 +1,222 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2022 Intel Corporation <www.intel.com>
+ *
+ */
+/*
+ * Altera SoCFPGA PinMux configuration
+ */
+
+#ifndef __SOCFPGA_PINMUX_CONFIG_H__
+#define __SOCFPGA_PINMUX_CONFIG_H__
+
+const u8 sys_mgr_init_table[] = {
+	0, /* EMACIO0 */
+	2, /* EMACIO1 */
+	2, /* EMACIO2 */
+	2, /* EMACIO3 */
+	2, /* EMACIO4 */
+	2, /* EMACIO5 */
+	2, /* EMACIO6 */
+	2, /* EMACIO7 */
+	2, /* EMACIO8 */
+	0, /* EMACIO9 */
+	2, /* EMACIO10 */
+	2, /* EMACIO11 */
+	2, /* EMACIO12 */
+	2, /* EMACIO13 */
+	0, /* EMACIO14 */
+	0, /* EMACIO15 */
+	0, /* EMACIO16 */
+	0, /* EMACIO17 */
+	0, /* EMACIO18 */
+	0, /* EMACIO19 */
+	3, /* FLASHIO0 */
+	0, /* FLASHIO1 */
+	3, /* FLASHIO2 */
+	3, /* FLASHIO3 */
+	0, /* FLASHIO4 */
+	0, /* FLASHIO5 */
+	0, /* FLASHIO6 */
+	0, /* FLASHIO7 */
+	0, /* FLASHIO8 */
+	3, /* FLASHIO9 */
+	3, /* FLASHIO10 */
+	3, /* FLASHIO11 */
+	0, /* GENERALIO0 */
+	1, /* GENERALIO1 */
+	1, /* GENERALIO2 */
+	1, /* GENERALIO3 */
+	1, /* GENERALIO4 */
+	1, /* GENERALIO5 */
+	1, /* GENERALIO6 */
+	1, /* GENERALIO7 */
+	1, /* GENERALIO8 */
+	3, /* GENERALIO9 */
+	3, /* GENERALIO10 */
+	3, /* GENERALIO11 */
+	3, /* GENERALIO12 */
+	0, /* GENERALIO13 */
+	0, /* GENERALIO14 */
+	1, /* GENERALIO15 */
+	1, /* GENERALIO16 */
+	1, /* GENERALIO17 */
+	1, /* GENERALIO18 */
+	0, /* GENERALIO19 */
+	0, /* GENERALIO20 */
+	0, /* GENERALIO21 */
+	0, /* GENERALIO22 */
+	0, /* GENERALIO23 */
+	0, /* GENERALIO24 */
+	0, /* GENERALIO25 */
+	0, /* GENERALIO26 */
+	0, /* GENERALIO27 */
+	0, /* GENERALIO28 */
+	0, /* GENERALIO29 */
+	0, /* GENERALIO30 */
+	0, /* GENERALIO31 */
+	2, /* MIXED1IO0 */
+	2, /* MIXED1IO1 */
+	2, /* MIXED1IO2 */
+	2, /* MIXED1IO3 */
+	2, /* MIXED1IO4 */
+	2, /* MIXED1IO5 */
+	2, /* MIXED1IO6 */
+	2, /* MIXED1IO7 */
+	2, /* MIXED1IO8 */
+	2, /* MIXED1IO9 */
+	2, /* MIXED1IO10 */
+	2, /* MIXED1IO11 */
+	2, /* MIXED1IO12 */
+	2, /* MIXED1IO13 */
+	0, /* MIXED1IO14 */
+	0, /* MIXED1IO15 */
+	0, /* MIXED1IO16 */
+	0, /* MIXED1IO17 */
+	0, /* MIXED1IO18 */
+	0, /* MIXED1IO19 */
+	0, /* MIXED1IO20 */
+	0, /* MIXED1IO21 */
+	0, /* MIXED2IO0 */
+	0, /* MIXED2IO1 */
+	0, /* MIXED2IO2 */
+	0, /* MIXED2IO3 */
+	0, /* MIXED2IO4 */
+	0, /* MIXED2IO5 */
+	0, /* MIXED2IO6 */
+	0, /* MIXED2IO7 */
+	0, /* GPLINMUX48 */
+	0, /* GPLINMUX49 */
+	0, /* GPLINMUX50 */
+	0, /* GPLINMUX51 */
+	0, /* GPLINMUX52 */
+	0, /* GPLINMUX53 */
+	0, /* GPLINMUX54 */
+	0, /* GPLINMUX55 */
+	0, /* GPLINMUX56 */
+	0, /* GPLINMUX57 */
+	0, /* GPLINMUX58 */
+	0, /* GPLINMUX59 */
+	0, /* GPLINMUX60 */
+	0, /* GPLINMUX61 */
+	0, /* GPLINMUX62 */
+	0, /* GPLINMUX63 */
+	0, /* GPLINMUX64 */
+	0, /* GPLINMUX65 */
+	0, /* GPLINMUX66 */
+	0, /* GPLINMUX67 */
+	0, /* GPLINMUX68 */
+	0, /* GPLINMUX69 */
+	0, /* GPLINMUX70 */
+	1, /* GPLMUX0 */
+	1, /* GPLMUX1 */
+	1, /* GPLMUX2 */
+	1, /* GPLMUX3 */
+	1, /* GPLMUX4 */
+	1, /* GPLMUX5 */
+	1, /* GPLMUX6 */
+	1, /* GPLMUX7 */
+	1, /* GPLMUX8 */
+	1, /* GPLMUX9 */
+	1, /* GPLMUX10 */
+	1, /* GPLMUX11 */
+	1, /* GPLMUX12 */
+	1, /* GPLMUX13 */
+	1, /* GPLMUX14 */
+	1, /* GPLMUX15 */
+	1, /* GPLMUX16 */
+	1, /* GPLMUX17 */
+	1, /* GPLMUX18 */
+	1, /* GPLMUX19 */
+	1, /* GPLMUX20 */
+	1, /* GPLMUX21 */
+	1, /* GPLMUX22 */
+	1, /* GPLMUX23 */
+	1, /* GPLMUX24 */
+	1, /* GPLMUX25 */
+	1, /* GPLMUX26 */
+	1, /* GPLMUX27 */
+	1, /* GPLMUX28 */
+	1, /* GPLMUX29 */
+	1, /* GPLMUX30 */
+	1, /* GPLMUX31 */
+	1, /* GPLMUX32 */
+	1, /* GPLMUX33 */
+	1, /* GPLMUX34 */
+	1, /* GPLMUX35 */
+	1, /* GPLMUX36 */
+	1, /* GPLMUX37 */
+	1, /* GPLMUX38 */
+	1, /* GPLMUX39 */
+	1, /* GPLMUX40 */
+	1, /* GPLMUX41 */
+	1, /* GPLMUX42 */
+	1, /* GPLMUX43 */
+	1, /* GPLMUX44 */
+	1, /* GPLMUX45 */
+	1, /* GPLMUX46 */
+	1, /* GPLMUX47 */
+	1, /* GPLMUX48 */
+	1, /* GPLMUX49 */
+	1, /* GPLMUX50 */
+	1, /* GPLMUX51 */
+	1, /* GPLMUX52 */
+	1, /* GPLMUX53 */
+	1, /* GPLMUX54 */
+	1, /* GPLMUX55 */
+	1, /* GPLMUX56 */
+	1, /* GPLMUX57 */
+	1, /* GPLMUX58 */
+	1, /* GPLMUX59 */
+	1, /* GPLMUX60 */
+	1, /* GPLMUX61 */
+	1, /* GPLMUX62 */
+	1, /* GPLMUX63 */
+	1, /* GPLMUX64 */
+	1, /* GPLMUX65 */
+	1, /* GPLMUX66 */
+	1, /* GPLMUX67 */
+	1, /* GPLMUX68 */
+	1, /* GPLMUX69 */
+	1, /* GPLMUX70 */
+	0, /* NANDUSEFPGA */
+	0, /* UART0USEFPGA */
+	0, /* RGMII1USEFPGA */
+	0, /* SPIS0USEFPGA */
+	0, /* CAN0USEFPGA */
+	0, /* I2C0USEFPGA */
+	0, /* SDMMCUSEFPGA */
+	0, /* QSPIUSEFPGA */
+	0, /* SPIS1USEFPGA */
+	0, /* RGMII0USEFPGA */
+	0, /* UART1USEFPGA */
+	0, /* CAN1USEFPGA */
+	0, /* USB1USEFPGA */
+	0, /* I2C3USEFPGA */
+	0, /* I2C2USEFPGA */
+	0, /* I2C1USEFPGA */
+	0, /* SPIM1USEFPGA */
+	0, /* USB0USEFPGA */
+	0 /* SPIM0USEFPGA */
+};
+#endif /* __SOCFPGA_PINMUX_CONFIG_H__ */
diff --git a/board/corecourse/ac501soc/qts/pll_config.h b/board/corecourse/ac501soc/qts/pll_config.h
new file mode 100644
index 00000000000..88e0b2a3776
--- /dev/null
+++ b/board/corecourse/ac501soc/qts/pll_config.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2022 Intel Corporation <www.intel.com>
+ */
+/*
+ * Altera SoCFPGA Clock and PLL configuration
+ */
+
+#ifndef __SOCFPGA_PLL_CONFIG_H__
+#define __SOCFPGA_PLL_CONFIG_H__
+
+#define CFG_HPS_DBCTRL_STAYOSC1 1
+
+#define CFG_HPS_MAINPLLGRP_VCO_DENOM 0
+#define CFG_HPS_MAINPLLGRP_VCO_NUMER 63
+#define CFG_HPS_MAINPLLGRP_MPUCLK_CNT 0
+#define CFG_HPS_MAINPLLGRP_MAINCLK_CNT 0
+#define CFG_HPS_MAINPLLGRP_DBGATCLK_CNT 0
+#define CFG_HPS_MAINPLLGRP_MAINQSPICLK_CNT 511
+#define CFG_HPS_MAINPLLGRP_MAINNANDSDMMCCLK_CNT 511
+#define CFG_HPS_MAINPLLGRP_CFGS2FUSER0CLK_CNT 15
+#define CFG_HPS_MAINPLLGRP_MAINDIV_L3MPCLK 1
+#define CFG_HPS_MAINPLLGRP_MAINDIV_L3SPCLK 1
+#define CFG_HPS_MAINPLLGRP_MAINDIV_L4MPCLK 1
+#define CFG_HPS_MAINPLLGRP_MAINDIV_L4SPCLK 1
+#define CFG_HPS_MAINPLLGRP_DBGDIV_DBGATCLK 0
+#define CFG_HPS_MAINPLLGRP_DBGDIV_DBGCLK 1
+#define CFG_HPS_MAINPLLGRP_TRACEDIV_TRACECLK 0
+#define CFG_HPS_MAINPLLGRP_L4SRC_L4MP 1
+#define CFG_HPS_MAINPLLGRP_L4SRC_L4SP 1
+
+#define CFG_HPS_PERPLLGRP_VCO_DENOM 0
+#define CFG_HPS_PERPLLGRP_VCO_NUMER 39
+#define CFG_HPS_PERPLLGRP_VCO_PSRC 0
+#define CFG_HPS_PERPLLGRP_EMAC0CLK_CNT 511
+#define CFG_HPS_PERPLLGRP_EMAC1CLK_CNT 3
+#define CFG_HPS_PERPLLGRP_PERQSPICLK_CNT 511
+#define CFG_HPS_PERPLLGRP_PERNANDSDMMCCLK_CNT 4
+#define CFG_HPS_PERPLLGRP_PERBASECLK_CNT 4
+#define CFG_HPS_PERPLLGRP_S2FUSER1CLK_CNT 511
+#define CFG_HPS_PERPLLGRP_DIV_USBCLK 0
+#define CFG_HPS_PERPLLGRP_DIV_SPIMCLK 0
+#define CFG_HPS_PERPLLGRP_DIV_CAN0CLK 4
+#define CFG_HPS_PERPLLGRP_DIV_CAN1CLK 1
+#define CFG_HPS_PERPLLGRP_GPIODIV_GPIODBCLK 6249
+#define CFG_HPS_PERPLLGRP_SRC_SDMMC 2
+#define CFG_HPS_PERPLLGRP_SRC_NAND 2
+#define CFG_HPS_PERPLLGRP_SRC_QSPI 1
+
+#define CFG_HPS_SDRPLLGRP_VCO_DENOM 0
+#define CFG_HPS_SDRPLLGRP_VCO_NUMER 31
+#define CFG_HPS_SDRPLLGRP_VCO_SSRC 0
+#define CFG_HPS_SDRPLLGRP_DDRDQSCLK_CNT 1
+#define CFG_HPS_SDRPLLGRP_DDRDQSCLK_PHASE 0
+#define CFG_HPS_SDRPLLGRP_DDR2XDQSCLK_CNT 0
+#define CFG_HPS_SDRPLLGRP_DDR2XDQSCLK_PHASE 0
+#define CFG_HPS_SDRPLLGRP_DDRDQCLK_CNT 1
+#define CFG_HPS_SDRPLLGRP_DDRDQCLK_PHASE 4
+#define CFG_HPS_SDRPLLGRP_S2FUSER2CLK_CNT 5
+#define CFG_HPS_SDRPLLGRP_S2FUSER2CLK_PHASE 0
+
+#define CFG_HPS_CLK_OSC1_HZ 25000000
+#define CFG_HPS_CLK_OSC2_HZ 25000000
+#define CFG_HPS_CLK_F2S_SDR_REF_HZ 0
+#define CFG_HPS_CLK_F2S_PER_REF_HZ 0
+#define CFG_HPS_CLK_MAINVCO_HZ 1600000000
+#define CFG_HPS_CLK_PERVCO_HZ 1000000000
+#define CFG_HPS_CLK_SDRVCO_HZ 800000000
+#define CFG_HPS_CLK_EMAC0_HZ 1953125
+#define CFG_HPS_CLK_EMAC1_HZ 250000000
+#define CFG_HPS_CLK_USBCLK_HZ 200000000
+#define CFG_HPS_CLK_NAND_HZ 50000000
+#define CFG_HPS_CLK_SDMMC_HZ 200000000
+#define CFG_HPS_CLK_QSPI_HZ 3125000
+#define CFG_HPS_CLK_SPIM_HZ 200000000
+#define CFG_HPS_CLK_CAN0_HZ 12500000
+#define CFG_HPS_CLK_CAN1_HZ 100000000
+#define CFG_HPS_CLK_GPIODB_HZ 32000
+#define CFG_HPS_CLK_L4_MP_HZ 100000000
+#define CFG_HPS_CLK_L4_SP_HZ 100000000
+
+#define CFG_HPS_ALTERAGRP_MPUCLK 1
+#define CFG_HPS_ALTERAGRP_MAINCLK 3
+#define CFG_HPS_ALTERAGRP_DBGATCLK 3
+
+#endif /* __SOCFPGA_PLL_CONFIG_H__ */
diff --git a/board/corecourse/ac501soc/qts/sdram_config.h b/board/corecourse/ac501soc/qts/sdram_config.h
new file mode 100644
index 00000000000..43cf307847e
--- /dev/null
+++ b/board/corecourse/ac501soc/qts/sdram_config.h
@@ -0,0 +1,349 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2022 Intel Corporation <www.intel.com>
+ *
+ */
+/*
+ * Altera SoCFPGA SDRAM configuration
+ *
+ */
+
+#ifndef __SOCFPGA_SDRAM_CONFIG_H__
+#define __SOCFPGA_SDRAM_CONFIG_H__
+
+/* SDRAM configuration */
+#define CFG_HPS_SDR_CTRLCFG_CPORTRDWR_CPORTRDWR		0x5A56A
+#define CFG_HPS_SDR_CTRLCFG_CPORTRMAP_CPORTRMAP		0xB00088
+#define CFG_HPS_SDR_CTRLCFG_CPORTWIDTH_CPORTWIDTH		0x44555
+#define CFG_HPS_SDR_CTRLCFG_CPORTWMAP_CPORTWMAP		0x2C011000
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_ADDRORDER		0
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_DQSTRKEN			0
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_ECCCORREN		0
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_ECCEN			0
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_MEMBL			8
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_MEMTYPE			2
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_NODMPINS			0
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_REORDEREN		1
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_STARVELIMIT		10
+#define CFG_HPS_SDR_CTRLCFG_CTRLWIDTH_CTRLWIDTH		2
+#define CFG_HPS_SDR_CTRLCFG_DRAMADDRW_BANKBITS		3
+#define CFG_HPS_SDR_CTRLCFG_DRAMADDRW_COLBITS		10
+#define CFG_HPS_SDR_CTRLCFG_DRAMADDRW_CSBITS			1
+#define CFG_HPS_SDR_CTRLCFG_DRAMADDRW_ROWBITS		15
+#define CFG_HPS_SDR_CTRLCFG_DRAMDEVWIDTH_DEVWIDTH		8
+#define CFG_HPS_SDR_CTRLCFG_DRAMIFWIDTH_IFWIDTH		32
+#define CFG_HPS_SDR_CTRLCFG_DRAMINTR_INTREN			0
+#define CFG_HPS_SDR_CTRLCFG_DRAMODT_READ			0
+#define CFG_HPS_SDR_CTRLCFG_DRAMODT_WRITE			1
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_AL			0
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TCL			11
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TCWL			8
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TFAW			12
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TRFC			104
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TRRD			3
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TRCD		6
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TREFI		3120
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TRP		6
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TWR		6
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TWTR		4
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TCCD			4
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TMRD			4
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TRAS			14
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TRC			20
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TRTP			3
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING4_PWRDOWNEXIT		3
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING4_SELFRFSHEXIT		512
+#define CFG_HPS_SDR_CTRLCFG_EXTRATIME1_CFG_EXTRA_CTL_CLK_RD_TO_WR 2
+#define CFG_HPS_SDR_CTRLCFG_EXTRATIME1_CFG_EXTRA_CTL_CLK_RD_TO_WR_BC 2
+#define CFG_HPS_SDR_CTRLCFG_EXTRATIME1_CFG_EXTRA_CTL_CLK_RD_TO_WR_DIFF_CHIP 2
+#define CFG_HPS_SDR_CTRLCFG_FIFOCFG_INCSYNC			0
+#define CFG_HPS_SDR_CTRLCFG_FIFOCFG_SYNCMODE			0
+#define CFG_HPS_SDR_CTRLCFG_FPGAPORTRST			0x0
+#define CFG_HPS_SDR_CTRLCFG_LOWPWREQ_SELFRFSHMASK		3
+#define CFG_HPS_SDR_CTRLCFG_LOWPWRTIMING_AUTOPDCYCLES	0
+#define CFG_HPS_SDR_CTRLCFG_LOWPWRTIMING_CLKDISABLECYCLES	8
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_0_THRESHOLD1_31_0	0x20820820
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_1_THRESHOLD1_59_32	0x8208208
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_1_THRESHOLD2_3_0	0
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_2_THRESHOLD2_35_4	0x41041041
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_3_THRESHOLD2_59_36	0x410410
+#define CFG_HPS_SDR_CTRLCFG_MPPRIORITY_USERPRIORITY		0x0
+#define CFG_HPS_SDR_CTRLCFG_MPTHRESHOLDRST_0_THRESHOLDRSTCYCLES_31_0 0x01010101
+#define CFG_HPS_SDR_CTRLCFG_MPTHRESHOLDRST_1_THRESHOLDRSTCYCLES_63_32 0x01010101
+#define CFG_HPS_SDR_CTRLCFG_MPTHRESHOLDRST_2_THRESHOLDRSTCYCLES_79_64 0x0101
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_0_STATICWEIGHT_31_0	0x21084210
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_1_STATICWEIGHT_49_32	0x10441
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_1_SUMOFWEIGHT_13_0	0x78
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_2_SUMOFWEIGHT_45_14	0x0
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_3_SUMOFWEIGHT_63_46	0x0
+#define CFG_HPS_SDR_CTRLCFG_PHYCTRL_PHYCTRL_0		0x200
+#define CFG_HPS_SDR_CTRLCFG_PORTCFG_AUTOPCHEN		0
+#define CFG_HPS_SDR_CTRLCFG_RFIFOCMAP_RFIFOCMAP		0x760210
+#define CFG_HPS_SDR_CTRLCFG_STATICCFG_MEMBL			2
+#define CFG_HPS_SDR_CTRLCFG_STATICCFG_USEECCASDATA		0
+#define CFG_HPS_SDR_CTRLCFG_WFIFOCMAP_WFIFOCMAP		0x980543
+
+/* Sequencer auto configuration */
+#define RW_MGR_ACTIVATE_0_AND_1	0x0D
+#define RW_MGR_ACTIVATE_0_AND_1_WAIT1	0x0E
+#define RW_MGR_ACTIVATE_0_AND_1_WAIT2	0x10
+#define RW_MGR_ACTIVATE_1	0x0F
+#define RW_MGR_CLEAR_DQS_ENABLE	0x49
+#define RW_MGR_GUARANTEED_READ	0x4C
+#define RW_MGR_GUARANTEED_READ_CONT	0x54
+#define RW_MGR_GUARANTEED_WRITE	0x18
+#define RW_MGR_GUARANTEED_WRITE_WAIT0	0x1B
+#define RW_MGR_GUARANTEED_WRITE_WAIT1	0x1F
+#define RW_MGR_GUARANTEED_WRITE_WAIT2	0x19
+#define RW_MGR_GUARANTEED_WRITE_WAIT3	0x1D
+#define RW_MGR_IDLE	0x00
+#define RW_MGR_IDLE_LOOP1	0x7B
+#define RW_MGR_IDLE_LOOP2	0x7A
+#define RW_MGR_INIT_RESET_0_CKE_0	0x6F
+#define RW_MGR_INIT_RESET_1_CKE_0	0x74
+#define RW_MGR_LFSR_WR_RD_BANK_0	0x22
+#define RW_MGR_LFSR_WR_RD_BANK_0_DATA	0x25
+#define RW_MGR_LFSR_WR_RD_BANK_0_DQS	0x24
+#define RW_MGR_LFSR_WR_RD_BANK_0_NOP	0x23
+#define RW_MGR_LFSR_WR_RD_BANK_0_WAIT	0x32
+#define RW_MGR_LFSR_WR_RD_BANK_0_WL_1	0x21
+#define RW_MGR_LFSR_WR_RD_DM_BANK_0	0x36
+#define RW_MGR_LFSR_WR_RD_DM_BANK_0_DATA	0x39
+#define RW_MGR_LFSR_WR_RD_DM_BANK_0_DQS	0x38
+#define RW_MGR_LFSR_WR_RD_DM_BANK_0_NOP	0x37
+#define RW_MGR_LFSR_WR_RD_DM_BANK_0_WAIT	0x46
+#define RW_MGR_LFSR_WR_RD_DM_BANK_0_WL_1	0x35
+#define RW_MGR_MRS0_DLL_RESET	0x02
+#define RW_MGR_MRS0_DLL_RESET_MIRR	0x08
+#define RW_MGR_MRS0_USER	0x07
+#define RW_MGR_MRS0_USER_MIRR	0x0C
+#define RW_MGR_MRS1	0x03
+#define RW_MGR_MRS1_MIRR	0x09
+#define RW_MGR_MRS2	0x04
+#define RW_MGR_MRS2_MIRR	0x0A
+#define RW_MGR_MRS3	0x05
+#define RW_MGR_MRS3_MIRR	0x0B
+#define RW_MGR_PRECHARGE_ALL	0x12
+#define RW_MGR_READ_B2B	0x59
+#define RW_MGR_READ_B2B_WAIT1	0x61
+#define RW_MGR_READ_B2B_WAIT2	0x6B
+#define RW_MGR_REFRESH_ALL	0x14
+#define RW_MGR_RETURN	0x01
+#define RW_MGR_SGLE_READ	0x7D
+#define RW_MGR_ZQCL	0x06
+
+/* Sequencer defines configuration */
+#define AFI_CLK_FREQ	401
+#define AFI_RATE_RATIO	1
+#define CALIB_LFIFO_OFFSET	12
+#define CALIB_VFIFO_OFFSET	10
+#define ENABLE_SUPER_QUICK_CALIBRATION	0
+#define IO_DELAY_PER_DCHAIN_TAP	25
+#define IO_DELAY_PER_DQS_EN_DCHAIN_TAP	25
+#define IO_DELAY_PER_OPA_TAP	312
+#define IO_DLL_CHAIN_LENGTH	8
+#define IO_DQDQS_OUT_PHASE_MAX	0
+#define IO_DQS_EN_DELAY_MAX	31
+#define IO_DQS_EN_DELAY_OFFSET	0
+#define IO_DQS_EN_PHASE_MAX	7
+#define IO_DQS_IN_DELAY_MAX	31
+#define IO_DQS_IN_RESERVE	4
+#define IO_DQS_OUT_RESERVE	4
+#define IO_IO_IN_DELAY_MAX	31
+#define IO_IO_OUT1_DELAY_MAX	31
+#define IO_IO_OUT2_DELAY_MAX	0
+#define IO_SHIFT_DQS_EN_WHEN_SHIFT_DQS	0
+#define MAX_LATENCY_COUNT_WIDTH	5
+#define READ_VALID_FIFO_SIZE	16
+#define REG_FILE_INIT_SEQ_SIGNATURE	0x555504b5
+#define RW_MGR_MEM_ADDRESS_MIRRORING	0
+#define RW_MGR_MEM_DATA_MASK_WIDTH	4
+#define RW_MGR_MEM_DATA_WIDTH	32
+#define RW_MGR_MEM_DQ_PER_READ_DQS	8
+#define RW_MGR_MEM_DQ_PER_WRITE_DQS	8
+#define RW_MGR_MEM_IF_READ_DQS_WIDTH	4
+#define RW_MGR_MEM_IF_WRITE_DQS_WIDTH	4
+#define RW_MGR_MEM_NUMBER_OF_CS_PER_DIMM	1
+#define RW_MGR_MEM_NUMBER_OF_RANKS	1
+#define RW_MGR_MEM_VIRTUAL_GROUPS_PER_READ_DQS	1
+#define RW_MGR_MEM_VIRTUAL_GROUPS_PER_WRITE_DQS	1
+#define RW_MGR_TRUE_MEM_DATA_MASK_WIDTH	4
+#define TINIT_CNTR0_VAL	99
+#define TINIT_CNTR1_VAL	32
+#define TINIT_CNTR2_VAL	32
+#define TRESET_CNTR0_VAL	99
+#define TRESET_CNTR1_VAL	99
+#define TRESET_CNTR2_VAL	10
+
+/* Sequencer ac_rom_init configuration */
+const u32 ac_rom_init[] = {
+	0x20700000,
+	0x20780000,
+	0x10080471,
+	0x10080570,
+	0x10090006,
+	0x100a0218,
+	0x100b0000,
+	0x10380400,
+	0x10080469,
+	0x100804e8,
+	0x100a0006,
+	0x10090218,
+	0x100b0000,
+	0x30780000,
+	0x38780000,
+	0x30780000,
+	0x10680000,
+	0x106b0000,
+	0x10280400,
+	0x10480000,
+	0x1c980000,
+	0x1c9b0000,
+	0x1c980008,
+	0x1c9b0008,
+	0x38f80000,
+	0x3cf80000,
+	0x38780000,
+	0x18180000,
+	0x18980000,
+	0x13580000,
+	0x135b0000,
+	0x13580008,
+	0x135b0008,
+	0x33780000,
+	0x10580008,
+	0x10780000
+};
+
+/* Sequencer inst_rom_init configuration */
+const u32 inst_rom_init[] = {
+	0x80000,
+	0x80680,
+	0x8180,
+	0x8200,
+	0x8280,
+	0x8300,
+	0x8380,
+	0x8100,
+	0x8480,
+	0x8500,
+	0x8580,
+	0x8600,
+	0x8400,
+	0x800,
+	0x8680,
+	0x880,
+	0xa680,
+	0x80680,
+	0x900,
+	0x80680,
+	0x980,
+	0xa680,
+	0x8680,
+	0x80680,
+	0xb68,
+	0xcce8,
+	0xae8,
+	0x8ce8,
+	0xb88,
+	0xec88,
+	0xa08,
+	0xac88,
+	0x80680,
+	0xce00,
+	0xcd80,
+	0xe700,
+	0xc00,
+	0x20ce0,
+	0x20ce0,
+	0x20ce0,
+	0x20ce0,
+	0xd00,
+	0x680,
+	0x680,
+	0x680,
+	0x680,
+	0x60e80,
+	0x61080,
+	0x61080,
+	0x61080,
+	0xa680,
+	0x8680,
+	0x80680,
+	0xce00,
+	0xcd80,
+	0xe700,
+	0xc00,
+	0x30ce0,
+	0x30ce0,
+	0x30ce0,
+	0x30ce0,
+	0xd00,
+	0x680,
+	0x680,
+	0x680,
+	0x680,
+	0x70e80,
+	0x71080,
+	0x71080,
+	0x71080,
+	0xa680,
+	0x8680,
+	0x80680,
+	0x1158,
+	0x6d8,
+	0x80680,
+	0x1168,
+	0x7e8,
+	0x7e8,
+	0x87e8,
+	0x40fe8,
+	0x410e8,
+	0x410e8,
+	0x410e8,
+	0x1168,
+	0x7e8,
+	0x7e8,
+	0xa7e8,
+	0x80680,
+	0x40e88,
+	0x41088,
+	0x41088,
+	0x41088,
+	0x40f68,
+	0x410e8,
+	0x410e8,
+	0x410e8,
+	0xa680,
+	0x40fe8,
+	0x410e8,
+	0x410e8,
+	0x410e8,
+	0x41008,
+	0x41088,
+	0x41088,
+	0x41088,
+	0x1100,
+	0xc680,
+	0x8680,
+	0xe680,
+	0x80680,
+	0x0,
+	0x8000,
+	0xa000,
+	0xc000,
+	0x80000,
+	0x80,
+	0x8080,
+	0xa080,
+	0xc080,
+	0x80080,
+	0x9180,
+	0x8680,
+	0xa680,
+	0x80680,
+	0x40f08,
+	0x80680
+};
+
+#endif /* __SOCFPGA_SDRAM_CONFIG_H__ */
diff --git a/configs/socfpga_ac501soc_defconfig b/configs/socfpga_ac501soc_defconfig
new file mode 100644
index 00000000000..09f8ea2e611
--- /dev/null
+++ b/configs/socfpga_ac501soc_defconfig
@@ -0,0 +1,85 @@
+CONFIG_ARM=y
+CONFIG_SYS_L2_PL310=y
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x4400
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_ac501soc"
+CONFIG_DM_RESET=y
+CONFIG_SPL_STACK=0x0
+CONFIG_SPL_TEXT_BASE=0xFFFF0000
+CONFIG_TARGET_SOCFPGA_CORECOURSE_AC501SOC=y
+CONFIG_SPL_FS_FAT=y
+# CONFIG_SPL_SPI is not set
+CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run fatscript;bridge enable; run distro_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_ac501soc.dtb"
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
+CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CLOCKS=y
+CONFIG_SPL_PAD_TO=0x10000
+CONFIG_SPL_NO_BSS_LIMIT=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
+CONFIG_CMD_UBI=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_DFU_MMC=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
+CONFIG_DWAPB_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_DW=y
+CONFIG_SYS_MMC_MAX_BLK_COUNT=256
+CONFIG_MMC_DW=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MII=y
+CONFIG_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_DESIGNWARE_SPI=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="altera"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+# CONFIG_SPL_WDT is not set
+CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_CMD_C5_PL330_DMA=y
+CONFIG_NET_RANDOM_ETHADDR=y
-- 
2.34.1

