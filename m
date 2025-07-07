Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64087C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F6B83208;
	Mon,  7 Jul 2025 17:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="qWUyWV7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66100830E4; Mon,  7 Jul 2025 13:41:21 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62AC8305C
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2768a2b95=Varshini.Rajendran@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751888479; x=1783424479;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xg2IOuKz+6/C6YgvDI3pL4z7AoAcUhn8+sekZL6O2uA=;
 b=qWUyWV7ntENDnQF8Vt1HX+TU8Hcwi0iN7gT8TvA6BWy2CKkp91rRb6X9
 yThi2XfKbvwNUPRDCrB+mcPS7gI3bi6D4u65MLNWXGY8ZDsPaS0hBR5OZ
 QiSnekey80FlejDOAiutdGCtXitkdgnEcQ4fj2HHwZo8Ak3fjHvS8ZwJE
 E0nf/g5M0hwD4dIQnlK7fK0daZDykHldXPmh1ZZ4G+XbKXDapmtjwlDhP
 mh6h/7P6GJ/yk6Tqco44DLAMTUTdEo4cDr5/6IjpuLbs4wyF7PkyMALON
 CaWgFgQhiXg8KAOO8jv+J8dFDMjoKVjdlxx2EhTItdBxmw9UzN36tea/+ w==;
X-CSE-ConnectionGUID: LBkP3QRmRGWUEGXwb57BBw==
X-CSE-MsgGUID: L+I+VyLcSAuU0kiA6lbATw==
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="44271993"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Jul 2025 04:41:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 04:40:59 -0700
Received: from che-dk-mpulab01.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 7 Jul 2025 04:40:56 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <Ryan.Wanner@microchip.com>,
 <manikandan.m@microchip.com>, <nicolas.ferre@microchip.com>,
 <sjg@chromium.org>, <varshini.rajendran@microchip.com>,
 <balamanikandan.gunasundar@microchip.com>, <u-boot@lists.denx.de>
Subject: [PATCH 3/6] ARM: mach-at91: add support for new SoC sama7d65
Date: Mon, 7 Jul 2025 17:04:52 +0530
Message-ID: <20250707113452.4132323-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
References: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 07 Jul 2025 17:54:47 +0200
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add support for new SoC sama7d65.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/mach-at91/Kconfig                  |   5 +
 arch/arm/mach-at91/armv7/Makefile           |   1 +
 arch/arm/mach-at91/armv7/sama7d65_devices.c |  31 ++++++
 arch/arm/mach-at91/include/mach/hardware.h  |   2 +
 arch/arm/mach-at91/include/mach/sama7d65.h  | 107 ++++++++++++++++++++
 5 files changed, 146 insertions(+)
 create mode 100644 arch/arm/mach-at91/armv7/sama7d65_devices.c
 create mode 100644 arch/arm/mach-at91/include/mach/sama7d65.h

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index d21534ce883..cc9ed89e544 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -52,6 +52,11 @@ config SAMA7G5
 	select CPU_V7A
 	select AT91RESET_EXTRST
 
+config SAMA7D65
+	bool
+	select CPU_V7A
+	select AT91RESET_EXTRST
+
 config SAMA5D2
 	bool
 	select CPU_V7A
diff --git a/arch/arm/mach-at91/armv7/Makefile b/arch/arm/mach-at91/armv7/Makefile
index 6da1cdffef6..4303a60e0e3 100644
--- a/arch/arm/mach-at91/armv7/Makefile
+++ b/arch/arm/mach-at91/armv7/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SAMA5D2)	+= sama5d2_devices.o clock.o
 obj-$(CONFIG_SAMA5D3)	+= sama5d3_devices.o clock.o
 obj-$(CONFIG_SAMA5D4)	+= sama5d4_devices.o clock.o
 obj-$(CONFIG_SAMA7G5)	+= sama7g5_devices.o
+obj-$(CONFIG_SAMA7D65)	+= sama7d65_devices.o
 obj-y += cpu.o
 ifneq ($(CONFIG_ATMEL_TCB_TIMER),y)
 ifneq ($(CONFIG_ATMEL_PIT_TIMER),y)
diff --git a/arch/arm/mach-at91/armv7/sama7d65_devices.c b/arch/arm/mach-at91/armv7/sama7d65_devices.c
new file mode 100644
index 00000000000..6c6ae751b1a
--- /dev/null
+++ b/arch/arm/mach-at91/armv7/sama7d65_devices.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Microchip Technology, Inc.
+ */
+
+#include <asm/arch/sama7d65.h>
+
+char *get_cpu_name(void)
+{
+	unsigned int extension_id = get_extension_chip_id();
+
+	if (cpu_is_sama7d65())
+		switch (extension_id) {
+		case ARCH_EXID_SAMA7D65:
+			return "SAMA7D65";
+		case ARCH_EXID_SAMA7D65_DD2:
+			return "SAMA7D65 DDR2";
+		case ARCH_EXID_SAMA7D65_D1G:
+			return "SAMA7D65 1Gb DDR3L SiP";
+		case ARCH_EXID_SAMA7D65_D2G:
+			return "SAMA7D65 2Gb DDR3L SiP";
+		case ARCH_EXID_SAMA7D65_D4G:
+			return "SAMA7D65 4Gb DDR3L SiP";
+		case ARCH_EXID_SAMA7D65_TA:
+			return "SAMA7D65 TA1000 SiP";
+		default:
+			return "Unknown CPU type";
+		}
+	else
+		return "Unknown CPU type10";
+}
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index de89714b097..0b2ddbab3be 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -27,6 +27,8 @@
 # include <asm/arch/sam9x7.h>
 #elif defined(CONFIG_SAMA7G5)
 # include <asm/arch/sama7g5.h>
+#elif defined(CONFIG_SAMA7D65)
+# include <asm/arch/sama7d65.h>
 #elif defined(CONFIG_SAMA5D2)
 # include <asm/arch/sama5d2.h>
 #elif defined(CONFIG_SAMA5D3)
diff --git a/arch/arm/mach-at91/include/mach/sama7d65.h b/arch/arm/mach-at91/include/mach/sama7d65.h
new file mode 100644
index 00000000000..8adc5c9a733
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/sama7d65.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Chip-specific header file for the SAMA7D65 SoC
+ *
+ * Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
+ */
+
+#ifndef __SAMA7D65_H__
+#define __SAMA7D65_H__
+
+/*
+ * Peripheral identifiers/interrupts.
+ */
+#define ATMEL_ID_FLEXCOM0	34
+#define ATMEL_ID_FLEXCOM1	35
+#define ATMEL_ID_FLEXCOM2	36
+#define ATMEL_ID_FLEXCOM3	37
+#define ATMEL_ID_FLEXCOM4	38
+#define ATMEL_ID_FLEXCOM5	39
+#define ATMEL_ID_FLEXCOM6	40
+#define ATMEL_ID_FLEXCOM7	41
+#define ATMEL_ID_FLEXCOM8	42
+
+#define ATMEL_ID_SDMMC0		75
+#define ATMEL_ID_SDMMC1		76
+#define ATMEL_ID_SDMMC2		77
+
+#define ATMEL_ID_PIT64B0	66
+#define ATMEL_ID_PIT64B		ATMEL_ID_PIT64B0
+
+#define ATMEL_CHIPID_CIDR	0xe0020000
+#define ATMEL_CHIPID_EXID	0xe0020004
+/*
+ * User Peripherals physical base addresses.
+ */
+#define ATMEL_BASE_PIOA		0xe0014000
+#define ATMEL_BASE_PIOB		(ATMEL_BASE_PIOA + 0x40)
+#define ATMEL_BASE_PIOC		(ATMEL_BASE_PIOB + 0x40)
+#define ATMEL_BASE_PIOD		(ATMEL_BASE_PIOC + 0x40)
+#define ATMEL_BASE_PIOE		(ATMEL_BASE_PIOD + 0x40)
+
+#define ATMEL_PIO_PORTS		5
+
+#define CPU_HAS_PCR
+
+#define ATMEL_BASE_PMC		0xe0018000
+
+#define ATMEL_BASE_WDT		0xe001c000
+#define ATMEL_BASE_RSTC		0xe001d100
+#define ATMEL_BASE_WDTS		0xe001d180
+#define ATMEL_BASE_SCKCR	0xe001d500
+
+#define ATMEL_BASE_SDMMC0	0xe1204000
+#define ATMEL_BASE_SDMMC1	0xe1208000
+
+#define ATMEL_BASE_PIT64B0	0xe1800000
+
+#define ATMEL_BASE_FLEXCOM0	0xe1820000
+#define ATMEL_BASE_FLEXCOM1	0xe1824000
+#define ATMEL_BASE_FLEXCOM2	0xe1828000
+#define ATMEL_BASE_FLEXCOM3	0xe182c000
+#define ATMEL_BASE_FLEXCOM4	0xe2018000
+#define ATMEL_BASE_FLEXCOM5	0xe201C000
+#define ATMEL_BASE_FLEXCOM6	0xe2020000
+#define ATMEL_BASE_FLEXCOM7	0xe2024000
+#define ATMEL_BASE_FLEXCOM8	0xe281C000
+
+#define ATMEL_BASE_TZC400	0xe3000000
+
+#define ATMEL_BASE_UMCTL2	0xe3800000
+#define ATMEL_BASE_UMCTL2_MP	0xe38003f8
+#define ATMEL_BASE_PUBL		0xe3804000
+
+#define ATMEL_NUM_FLEXCOM	11
+#define ATMEL_PIO_PORTS		5
+
+#define ATMEL_BASE_PIT64BC	ATMEL_BASE_PIT64B0
+
+#define ARCH_ID_SAMA7D65	0x80262100
+#define ARCH_EXID_SAMA7D65	0x00000080
+#define ARCH_EXID_SAMA7D65_DD2	0x00000010
+#define ARCH_EXID_SAMA7D65_D1G	0x00000018
+#define ARCH_EXID_SAMA7D65_D2G	0x00000020
+#define ARCH_EXID_SAMA7D65_D4G	0x00000028
+#define ARCH_EXID_SAMA7D65_TA	0x00000040
+
+#define cpu_is_sama7d65()	(get_chip_id() == ARCH_ID_SAMA7D65)
+#define cpu_is_sama7d65_S()	(cpu_is_sama7d65() && \
+		(get_extension_chip_id() == ARCH_EXID_SAMA7D65))
+#define cpu_is_sama7d65_DD2()	(cpu_is_sama7d65() && \
+		(get_extension_chip_id() == ARCH_EXID_SAMA7D65_DD2))
+#define cpu_is_sama7d65_D1G()	(cpu_is_sama7d65() && \
+		(get_extension_chip_id() == ARCH_EXID_SAMA7D65_D1G))
+#define cpu_is_sama7d65_D2G()	(cpu_is_sama7d65() && \
+		(get_extension_chip_id() == ARCH_EXID_SAMA7D65_D2G))
+#define cpu_is_sama7d65_D4G()	(cpu_is_sama7d65() && \
+		(get_extension_chip_id() == ARCH_EXID_SAMA7D65_D4G))
+#define cpu_is_sama7d65_TA()	(cpu_is_sama7d65() && \
+		(get_extension_chip_id() == ARCH_EXID_SAMA7D65_TA))
+
+#ifndef __ASSEMBLY__
+unsigned int get_chip_id(void);
+unsigned int get_extension_chip_id(void);
+char *get_cpu_name(void);
+#endif
+
+#endif /* #ifndef __SAMA7D65_H__ */
-- 
2.45.2

