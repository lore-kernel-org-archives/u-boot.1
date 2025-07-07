Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9047C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFE98324C;
	Mon,  7 Jul 2025 17:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="laL/pH72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036F583121; Mon,  7 Jul 2025 13:43:12 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8429F830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2768a2b95=Varshini.Rajendran@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751888589; x=1783424589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LtAfNFKPE/caTdaHGeTJbccY/xKn0F2sjiKEBF3zve8=;
 b=laL/pH729f3My516vTzZp8fq422RvfNu1WUWaIbBGT507W8DIZ/8/8JR
 Sq5gMtnInm9XXQhQwOgiGylTslFKYfaQ30DRkOcDIgsyw/FePyi0+E+RA
 azE7TO2BweZcM+PNtCHaBPb6nnwTvt7Jhb5aFzg4eokuC7c1crJjO/rZ1
 FX59OxaaDsfV9ClTVXprHaKi2etvfRf4nj0hXDAzDGTaWtJK2mX0JiVEG
 NLYgwSvkjcBZ7m97IRNRAaikPPDq6onqnZDCuT1PhdaV9wyWl00xrowXh
 YvN5ugpcuwgewOS0bBaH30zZLCn8ELSDtzQXOLklee8vPslQYDXFwjixO Q==;
X-CSE-ConnectionGUID: gbTpSdOhQhCztcCm+eT6eQ==
X-CSE-MsgGUID: XKijB7XfS7OLmyVEtHOG4A==
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="44272061"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Jul 2025 04:43:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 04:42:58 -0700
Received: from che-dk-mpulab01.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 7 Jul 2025 04:42:54 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <ryan.wanner@microchip.com>,
 <manikandan.m@microchip.com>, <sjg@chromium.org>,
 <varshini.rajendran@microchip.com>,
 <balamanikandan.gunasundar@microchip.com>, <Romain.Sioen@microchip.com>,
 <u-boot@lists.denx.de>
CC: Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 5/6] board: sama7d65_curiosity: Add support for
 sama7d65_curiosity
Date: Mon, 7 Jul 2025 17:06:50 +0530
Message-ID: <20250707113650.4135507-1-varshini.rajendran@microchip.com>
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

Add board specific functions for sama7d65_curiosity.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/mach-at91/Kconfig                    |  8 ++
 board/atmel/sama7d65_curiosity/Kconfig        | 15 ++++
 board/atmel/sama7d65_curiosity/MAINTAINERS    |  5 ++
 board/atmel/sama7d65_curiosity/Makefile       |  7 ++
 .../sama7d65_curiosity/sama7d65_curiosity.c   | 75 +++++++++++++++++++
 include/configs/sama7d65_curiosity.h          | 20 +++++
 6 files changed, 130 insertions(+)
 create mode 100644 board/atmel/sama7d65_curiosity/Kconfig
 create mode 100644 board/atmel/sama7d65_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sama7d65_curiosity/Makefile
 create mode 100644 board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
 create mode 100644 include/configs/sama7d65_curiosity.h

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index cc9ed89e544..7d00f1650b4 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -304,6 +304,13 @@ config TARGET_SAMA7G54_CURIOSITY
 	  4Gbit SLC nand-flash, MCP16502 PMIC, 2 x Mikrobus connectors,
 	  1 x SD-Card connector, 1 x M.2 slot, 3 x USB
 
+config TARGET_SAMA7D65_CURIOSITY
+	bool "SAMA7D65 CURIOSITY board"
+	select SAMA7D65
+	select BOARD_EARLY_INIT_F
+	select BOARD_LATE_INIT
+	imply OF_UPSTREAM
+
 config TARGET_TAURUS
 	bool "Support taurus"
 	select AT91SAM9G20
@@ -370,6 +377,7 @@ source "board/atmel/sam9x60_curiosity/Kconfig"
 source "board/atmel/sam9x75_curiosity/Kconfig"
 source "board/atmel/sama7g5ek/Kconfig"
 source "board/atmel/sama7g54_curiosity/Kconfig"
+source "board/atmel/sama7d65_curiosity/Kconfig"
 source "board/atmel/sama5d2_ptc_ek/Kconfig"
 source "board/atmel/sama5d2_xplained/Kconfig"
 source "board/atmel/sama5d27_som1_ek/Kconfig"
diff --git a/board/atmel/sama7d65_curiosity/Kconfig b/board/atmel/sama7d65_curiosity/Kconfig
new file mode 100644
index 00000000000..21ff432f2c1
--- /dev/null
+++ b/board/atmel/sama7d65_curiosity/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_SAMA7D65_CURIOSITY
+
+config SYS_BOARD
+	default "sama7d65_curiosity"
+
+config SYS_VENDOR
+	default "atmel"
+
+config SYS_SOC
+	default "at91"
+
+config SYS_CONFIG_NAME
+	default "sama7d65_curiosity"
+
+endif
diff --git a/board/atmel/sama7d65_curiosity/MAINTAINERS b/board/atmel/sama7d65_curiosity/MAINTAINERS
new file mode 100644
index 00000000000..be67d56dc5b
--- /dev/null
+++ b/board/atmel/sama7d65_curiosity/MAINTAINERS
@@ -0,0 +1,5 @@
+SAMA7D65 CURIOSITY BOARD
+M:     Ryan Wanner <ryan.wanner@microchip.com>
+S:     Maintained
+F:     board/atmel/sama7d65_curiosity.c
+F:     include/configs/sama7d65_curiosity.h
diff --git a/board/atmel/sama7d65_curiosity/Makefile b/board/atmel/sama7d65_curiosity/Makefile
new file mode 100644
index 00000000000..56d011d1d81
--- /dev/null
+++ b/board/atmel/sama7d65_curiosity/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier:     GPL-2.0+
+#
+# Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
+#
+# Author: Ryan Wanner <ryan.wanner@microchip.com>
+
+obj-y += sama7d65_curiosity.o
diff --git a/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c b/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
new file mode 100644
index 00000000000..713b1b9d959
--- /dev/null
+++ b/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
+ *
+ * Author: Ryan Wanner <ryan.wanner@microchip.com>
+ *
+ */
+
+#include <debug_uart.h>
+#include <init.h>
+#include <fdtdec.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/at91_common.h>
+#include <asm/arch/atmel_pio4.h>
+#include <asm/arch/clk.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/sama7d65.h>
+#include <asm/mach-types.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static void board_leds_init(void)
+{
+	atmel_pio4_set_pio_output(AT91_PIO_PORTA, 21, 0);	/* LED BLUE */
+	atmel_pio4_set_pio_output(AT91_PIO_PORTB, 17, 0);	/* LED RED */
+	atmel_pio4_set_pio_output(AT91_PIO_PORTB, 15, 1);	/* LED GREEN */
+}
+
+int board_late_init(void)
+{
+	return 0;
+}
+
+#if (IS_ENABLED(CONFIG_DEBUG_UART_BOARD_INIT))
+static void board_uart0_hw_init(void)
+{
+	/* FLEXCOM6 IO0 */
+	atmel_pio4_set_b_periph(AT91_PIO_PORTD, 18, 0);
+	/* FLEXCOM6 IO1 */
+	atmel_pio4_set_b_periph(AT91_PIO_PORTD, 19, 0);
+
+	at91_periph_clk_enable(ATMEL_ID_FLEXCOM6);
+}
+
+void board_debug_uart_init(void)
+{
+	board_uart0_hw_init();
+}
+#endif
+
+int board_early_init_f(void)
+{
+	return 0;
+}
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+
+	board_leds_init();
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
diff --git a/include/configs/sama7d65_curiosity.h b/include/configs/sama7d65_curiosity.h
new file mode 100644
index 00000000000..9316b104ee3
--- /dev/null
+++ b/include/configs/sama7d65_curiosity.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration file for the SAMA7D65 Curiosity Board.
+ *
+ * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ryan Wanner <ryan.wanner@microchip.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_AT91_SLOW_CLOCK      32768
+#define CFG_SYS_AT91_MAIN_CLOCK      24000000 /* from 24 MHz crystal */
+/* SDRAM */
+#define CFG_SYS_SDRAM_BASE		0x60000000
+#define CFG_SYS_SDRAM_SIZE		0x40000000
+
+#endif
-- 
2.45.2

