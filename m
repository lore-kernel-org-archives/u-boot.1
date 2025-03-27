Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BB5C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 07:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489C6807D7;
	Thu, 27 Mar 2025 08:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="isVP0YRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFFE481D6C; Thu, 27 Mar 2025 08:07:13 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47EC681DDF
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=174f6da1a=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1743059229; x=1774595229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QTK0NrX22qKdlGpITe7KqS+7BAVGa5fWZ0F7nwKZozY=;
 b=isVP0YRFUTMX2lBvQh9sZCOWdIEr9x1US97CSBk4ygKDabEhopYzKlXX
 f3+gzqy9MQ9kBMrhmBWNE0kiNFNx8mC3ukI90I487w8W0+O6a2dTH65yR
 bbG2ENdHPUt6NFlybzvivOttRhH9V0FuHpsoO4rJi5MrsCHMTAtJTgjYz
 /LLVNLlCoCUQXF1EQQhrlgquZSWS6S3kcdVUlWJsPzC8JxnQJBwwJKviB
 FIl7JwxK6Y0en77q1fzkphB5BHiwEFyvd6i83N3iJ6vw1mhpd2f2A3r+p
 17IBsHDoPHuUY2UyHLlw18jbk+GgKvF9rFuMMBRxHBzbxg59z6958s43w g==;
X-CSE-ConnectionGUID: /Z1pgm4SQpmwpZxHOURRBQ==
X-CSE-MsgGUID: G6ElKXiCQGK9hiPfdXOxeg==
X-IronPort-AV: E=Sophos;i="6.14,279,1736838000"; d="scan'208";a="40231147"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Mar 2025 00:07:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 00:07:06 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 00:07:00 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <nathan.morrison@timesys.com>, <ilias.apalodimas@linaro.org>,
 <greg.malysa@timesys.com>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <igor.opaniuk@gmail.com>, <semen.protsenko@linaro.org>,
 <william.zhang@broadcom.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>, Varshini Rajendran
 <varshini.rajendran@microchip.com>, Balamanikandan Gunasundar
 <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v5 5/8] ARM: at91: Add sam9x7 soc
Date: Thu, 27 Mar 2025 12:36:12 +0530
Message-ID: <20250327070615.334551-6-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327070615.334551-1-manikandan.m@microchip.com>
References: <20250327070615.334551-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Varshini Rajendran <varshini.rajendran@microchip.com>

Add new Microchip sam9x7 SoC based on an ARM926.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/mach-at91/Kconfig                    |   4 +
 arch/arm/mach-at91/arm926ejs/Makefile         |   1 +
 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c |  49 +++++
 arch/arm/mach-at91/include/mach/hardware.h    |   2 +
 arch/arm/mach-at91/include/mach/sam9x7.h      | 172 ++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c
 create mode 100644 arch/arm/mach-at91/include/mach/sam9x7.h

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7c4ccc427c8..5429257875d 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -43,6 +43,10 @@ config SAM9X60
 	bool
 	select CPU_ARM926EJS
 
+config SAM9X7
+	bool
+	select CPU_ARM926EJS
+
 config SAMA7G5
 	bool
 	select CPU_V7A
diff --git a/arch/arm/mach-at91/arm926ejs/Makefile b/arch/arm/mach-at91/arm926ejs/Makefile
index 8f0bc5d997e..977299a5911 100644
--- a/arch/arm/mach-at91/arm926ejs/Makefile
+++ b/arch/arm/mach-at91/arm926ejs/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_AT91SAM9G45)	+= at91sam9m10g45_devices.o
 obj-$(CONFIG_AT91SAM9N12)	+= at91sam9n12_devices.o
 obj-$(CONFIG_AT91SAM9X5)	+= at91sam9x5_devices.o
 obj-$(CONFIG_SAM9X60)		+= sam9x60_devices.o
+obj-$(CONFIG_SAM9X7)		+= sam9x7_devices.o
 obj-y += clock.o
 obj-y += cpu.o
 ifndef CONFIG_$(PHASE_)SYSRESET
diff --git a/arch/arm/mach-at91/arm926ejs/sam9x7_devices.c b/arch/arm/mach-at91/arm926ejs/sam9x7_devices.c
new file mode 100644
index 00000000000..c65764a3de4
--- /dev/null
+++ b/arch/arm/mach-at91/arm926ejs/sam9x7_devices.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ */
+
+#include <asm/arch/at91_common.h>
+#include <asm/arch/clk.h>
+#include <asm/arch/gpio.h>
+#include <asm/io.h>
+
+unsigned int get_chip_id(void)
+{
+	/* The 0x40 is the offset of cidr in DBGU */
+	return readl(ATMEL_BASE_DBGU + 0x40);
+}
+
+unsigned int get_extension_chip_id(void)
+{
+	/* The 0x44 is the offset of exid in DBGU */
+	return readl(ATMEL_BASE_DBGU + 0x44);
+}
+
+char *get_cpu_name(void)
+{
+	unsigned int extension_id = get_extension_chip_id();
+
+	if (cpu_is_sam9x7()) {
+		switch (extension_id) {
+		case ARCH_EXID_SAM9X70:
+			return "SAM9X70";
+		case ARCH_EXID_SAM9X72:
+			return "SAM9X72";
+		case ARCH_EXID_SAM9X75:
+			return "SAM9X75";
+		case ARCH_EXID_SAM9X75_D1M:
+			return "SAM9X75 16MB DDR2 SiP";
+		case ARCH_EXID_SAM9X75_D5M:
+			return "SAM9X75 64MB DDR2 SiP";
+		case ARCH_EXID_SAM9X75_D1G:
+			return "SAM9X75 125MB DDR3L SiP";
+		case ARCH_EXID_SAM9X75_D2G:
+			return "SAM9X75 250MB DDR3L SiP";
+		default:
+			return "Unknown CPU type";
+		}
+	} else {
+		return "Unknown CPU type";
+	}
+}
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 988ef492b62..de89714b097 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -23,6 +23,8 @@
 # include <asm/arch/at91sam9x5.h>
 #elif defined(CONFIG_SAM9X60)
 # include <asm/arch/sam9x60.h>
+#elif defined(CONFIG_SAM9X7)
+# include <asm/arch/sam9x7.h>
 #elif defined(CONFIG_SAMA7G5)
 # include <asm/arch/sama7g5.h>
 #elif defined(CONFIG_SAMA5D2)
diff --git a/arch/arm/mach-at91/include/mach/sam9x7.h b/arch/arm/mach-at91/include/mach/sam9x7.h
new file mode 100644
index 00000000000..998fa786f90
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/sam9x7.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Chip-specific header file for the SAM9X7 SoC.
+ *
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ */
+
+#ifndef __SAM9X7_H__
+#define __SAM9X7_H__
+
+/*
+ * Peripheral identifiers/interrupts.
+ */
+#define ATMEL_ID_FIQ		0	/* Advanced Interrupt Controller - FIQ */
+#define ATMEL_ID_SYS		1	/* System Controller Interrupt */
+#define ATMEL_ID_PIOA		2	/* Parallel I/O Controller A */
+#define ATMEL_ID_PIOB		3	/* Parallel I/O Controller B */
+#define ATMEL_ID_PIOC		4	/* Parallel I/O Controller C */
+#define ATMEL_ID_FLEXCOM0	5	/* FLEXCOM 0 */
+#define ATMEL_ID_FLEXCOM1	6	/* FLEXCOM 1 */
+#define ATMEL_ID_FLEXCOM2	7	/* FLEXCOM 2 */
+#define ATMEL_ID_FLEXCOM3	8	/* FLEXCOM 3 */
+#define ATMEL_ID_FLEXCOM6	9	/* FLEXCOM 6 */
+#define ATMEL_ID_FLEXCOM7	10	/* FLEXCOM 7 */
+#define ATMEL_ID_FLEXCOM8	11	/* FLEXCOM 8 */
+#define ATMEL_ID_SDMMC0		12	/* SDMMC 0 */
+#define ATMEL_ID_FLEXCOM4	13	/* FLEXCOM 4 */
+#define ATMEL_ID_FLEXCOM5	14	/* FLEXCOM 5 */
+#define ATMEL_ID_FLEXCOM9	15	/* FLEXCOM 9 */
+#define ATMEL_ID_FLEXCOM10	16	/* FLEXCOM 10 */
+#define ATMEL_ID_TC01		17	/* Timer Counter 0, 1, 2, 3, 4 and 5 */
+#define ATMEL_ID_PWM		18	/* Pulse Width Modulation Controller */
+#define ATMEL_ID_ADC		19	/* ADC Controller */
+#define ATMEL_ID_XDMAC0		20	/* XDMA Controller 0 */
+#define ATMEL_ID_MATRIX		21	/* BUS Matrix */
+#define ATMEL_ID_UHPHS		22	/* USB Host High Speed */
+#define ATMEL_ID_UDPHS		23	/* USB Device High Speed */
+#define ATMEL_ID_GMAC		24	/* GMAC */
+#define ATMEL_ID_LCDC		25	/* LCD Controller */
+#define ATMEL_ID_SDMMC1		26	/* SDMMC 1 */
+#define ATMEL_ID_SSC		28	/* Synchronous Serial Controller */
+#define ATMEL_ID_IRQ		31	/* Advanced Interrupt Controller - IRQ */
+#define ATMEL_ID_TRNG		38	/* True Random Number Generator */
+#define ATMEL_ID_PIOD		44	/* Parallel I/O Controller D */
+#define ATMEL_ID_DBGU		47	/* Debug unit */
+
+/*
+ * User Peripheral physical base addresses.
+ */
+#define ATMEL_BASE_FLEXCOM4	0xf0000000
+#define ATMEL_BASE_FLEXCOM5	0xf0004000
+#define ATMEL_BASE_XDMA0	0xf0008000
+#define ATMEL_BASE_SSC		0xf0010000
+#define ATMEL_BASE_QSPI		0xf0014000
+#define ATMEL_BASE_CAN0		0xf8000000
+#define ATMEL_BASE_CAN1		0xf8004000
+#define ATMEL_BASE_TC0		0xf8008000
+#define ATMEL_BASE_TC1		0xf800c000
+#define ATMEL_BASE_FLEXCOM6	0xf8010000
+#define ATMEL_BASE_FLEXCOM7	0xf8014000
+#define ATMEL_BASE_FLEXCOM8	0xf8018000
+#define ATMEL_BASE_FLEXCOM0	0xf801c000
+#define ATMEL_BASE_FLEXCOM1	0xf8020000
+#define ATMEL_BASE_FLEXCOM2	0xf8024000
+#define ATMEL_BASE_FLEXCOM3	0xf8028000
+#define ATMEL_BASE_GMAC		0xf802c000
+#define ATMEL_BASE_PWM		0xf8034000
+#define ATMEL_BASE_LCDC		0xf8038000
+#define ATMEL_BASE_UDPHS	0xf803c000
+#define ATMEL_BASE_FLEXCOM9	0xf8040000
+#define ATMEL_BASE_FLEXCOM10	0xf8044000
+#define ATMEL_BASE_ISC		0xf8048000
+#define ATMEL_BASE_ADC		0xf804c000
+#define ATMEL_BASE_SFR		0xf8050000
+#define ATMEL_BASE_SYS		0xffffc000
+
+/*
+ * System Peripherals
+ */
+#define ATMEL_BASE_MATRIX	0xffffde00
+#define ATMEL_BASE_PMECC	0xffffe000
+#define ATMEL_BASE_PMERRLOC	0xffffe600
+#define ATMEL_BASE_MPDDRC	0xffffe800
+#define ATMEL_BASE_SMC		0xffffea00
+#define ATMEL_BASE_SDRAMC	0xffffec00
+#define ATMEL_BASE_AIC		0xfffff100
+#define ATMEL_BASE_DBGU		0xfffff200
+#define ATMEL_BASE_PIOA		0xfffff400
+#define ATMEL_BASE_PIOB		0xfffff600
+#define ATMEL_BASE_PIOC		0xfffff800
+#define ATMEL_BASE_PIOD		0xfffffa00
+#define ATMEL_BASE_PMC		0xfffffc00
+#define ATMEL_BASE_RSTC		0xfffffe00
+#define ATMEL_BASE_SHDWC	0xfffffe10
+#define ATMEL_BASE_PIT		0xfffffe40
+#define ATMEL_BASE_GPBR		0xfffffe60
+#define ATMEL_BASE_RTC		0xfffffea8
+#define ATMEL_BASE_WDT		0xffffff80
+
+/*
+ * Internal Memory.
+ */
+#define ATMEL_BASE_ROM		0x00100000 /* Internal ROM base address */
+#define ATMEL_BASE_SRAM		0x00300000 /* Internal SRAM base address */
+#define ATMEL_BASE_UDPHS_FIFO	0x00500000 /* USB Device HS controller */
+#define ATMEL_BASE_OHCI		0x00600000 /* USB Host controller (OHCI) */
+#define ATMEL_BASE_EHCI		0x00700000 /* USB Host controller (EHCI) */
+
+/*
+ * External memory
+ */
+#define ATMEL_BASE_CS0		0x10000000
+#define ATMEL_BASE_CS1		0x20000000
+#define ATMEL_BASE_CS2		0x30000000
+#define ATMEL_BASE_CS3		0x40000000
+#define ATMEL_BASE_CS4		0x50000000
+#define ATMEL_BASE_CS5		0x60000000
+#define ATMEL_BASE_SDMMC0	0x80000000
+#define ATMEL_BASE_SDMMC1	0x90000000
+
+/*
+ * SAM9x7 series chip id definitions
+ */
+#define ARCH_ID_SAM9X7		0x89750030
+#define ARCH_EXID_SAM9X70	0x00000005
+#define ARCH_EXID_SAM9X72	0x00000004
+#define ARCH_EXID_SAM9X75	0x00000000
+#define ARCH_EXID_SAM9X75_D1G	0x00000018
+#define ARCH_EXID_SAM9X75_D2G	0x00000020
+#define ARCH_EXID_SAM9X75_D1M	0x00000003
+#define ARCH_EXID_SAM9X75_D5M	0x00000010
+
+#define cpu_is_sam9x7()	(get_chip_id() == ARCH_ID_SAM9X7)
+
+/*
+ * Cpu Name
+ */
+#define ATMEL_CPU_NAME	get_cpu_name()
+
+/*
+ * Timer
+ */
+#define CFG_SYS_TIMER_COUNTER	0xf0028000
+
+/*
+ * Other misc defines
+ */
+#define ATMEL_PIO_PORTS		4
+#define CPU_HAS_PCR
+#define CPU_NO_PLLB
+#define PLL_ID_PLLA		0
+#define PLL_ID_UPLL		1
+#define PLL_ID_AUDIOPLL		2
+#define PLL_ID_LVDSPLL		3
+#define PLL_ID_PLLA_DIV_2	4
+
+/*
+ * PMECC table in ROM
+ */
+#define ATMEL_PMECC_INDEX_OFFSET_512	0x0000
+#define ATMEL_PMECC_INDEX_OFFSET_1024	0x8000
+
+/*
+ * SAM9X7 specific prototypes
+ */
+#ifndef __ASSEMBLY__
+unsigned int get_chip_id(void);
+unsigned int get_extension_chip_id(void);
+char *get_cpu_name(void);
+#endif
+
+#endif
-- 
2.25.1

