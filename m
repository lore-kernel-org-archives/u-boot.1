Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A99C46CA0
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 12:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F608766E;
	Thu, 30 Nov 2023 13:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="S+RD/uxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A35875EE; Thu, 30 Nov 2023 13:24:33 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9484E875CC
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 13:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202311301224253c7bb1b127c82882c3 for <u-boot@lists.denx.de>;
 Thu, 30 Nov 2023 13:24:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gv2ei52bN6YVcflc96o4LGeiKsLlDPG8vO1lxCGrrdE=;
 b=S+RD/uxpEoFJdOosvZG9CPY3pDllCjYSce4Y8pXkD/Jm/A1G1MpgHmCccY56oOJl624IrN
 p76XHwLFsrKyeychRddIS9x9AeBc2U59juntFMrMxwmBid0Ai63CAVfPHfxnVzgHdnDbPlU8
 g6jf8A2Gfy+tI6PJZZp1NMtQZSBHs=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v2 4/6] siemens: board: clean up draco products vs common
Date: Thu, 30 Nov 2023 13:23:22 +0100
Message-Id: <20231130122324.658502-5-enrico.leto@siemens.com>
In-Reply-To: <20231130122324.658502-1-enrico.leto@siemens.com>
References: <20231130122324.658502-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
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

The common folder was initialially created for the common parts of the
products based on draco-am355x board family. These are the product
lines 'pxm2', 'rut' and the base line named 'draco'!

Adding the new capricorn-imx8 board family, common was enhanced without
cleanup.

Move all am355x specifics to a new file 'board_am335x'.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 board/siemens/common/board.c        | 54 +++------------------------
 board/siemens/common/board_am335x.c | 58 +++++++++++++++++++++++++++++
 board/siemens/common/board_am335x.h | 38 +++++++++++++++++++
 board/siemens/draco/Makefile        |  2 +
 board/siemens/draco/board.c         | 10 ++---
 board/siemens/draco/board.h         | 32 +++-------------
 board/siemens/draco/mux.c           |  2 +-
 board/siemens/pxm2/MAINTAINERS      |  2 +-
 board/siemens/pxm2/Makefile         |  2 +
 board/siemens/pxm2/board.c          | 10 ++---
 board/siemens/pxm2/board.h          | 21 -----------
 board/siemens/pxm2/mux.c            |  2 +-
 board/siemens/rut/MAINTAINERS       |  2 +-
 board/siemens/rut/Makefile          |  2 +
 board/siemens/rut/board.c           | 10 ++---
 board/siemens/rut/board.h           | 21 -----------
 board/siemens/rut/mux.c             |  1 +
 17 files changed, 129 insertions(+), 140 deletions(-)
 create mode 100644 board/siemens/common/board_am335x.c
 create mode 100644 board/siemens/common/board_am335x.h
 delete mode 100644 board/siemens/pxm2/board.h
 delete mode 100644 board/siemens/rut/board.h

diff --git a/board/siemens/common/board.c b/board/siemens/common/board.c
index ddbb92811cf..981ffe4e69a 100644
--- a/board/siemens/common/board.c
+++ b/board/siemens/common/board.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Common board functions for siemens AM335X based boards
+ * Common board functions for siemens based boards
+ *
+ * TI am335x specifics moved to board_am335x.c
+ *
  * (C) Copyright 2013 Siemens Schweiz AG
  * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
- *
- * Based on:
- * U-Boot file:/board/ti/am335x/board.c
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
  */
 
 #include <common.h>
@@ -39,7 +38,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-
 #if CONFIG_IS_ENABLED(DM_I2C)
 static struct udevice *i2c_dev;
 #endif
@@ -82,39 +80,6 @@ int siemens_ee_read_data(uint address, uchar *buffer, int len)
 #endif
 }
 
-
-#ifdef CONFIG_SPL_BUILD
-void set_uart_mux_conf(void)
-{
-	enable_uart0_pin_mux();
-}
-
-void set_mux_conf_regs(void)
-{
-	/* Initalize the board header */
-	enable_i2c0_pin_mux();
-
-	/* enable early the console */
-	gd->baudrate = CONFIG_BAUDRATE;
-	serial_init();
-	gd->have_console = 1;
-
-	siemens_ee_setup();
-	if (read_eeprom() < 0)
-		puts("Could not get board ID.\n");
-
-	enable_board_pin_mux();
-}
-
-void sdram_init(void)
-{
-	spl_siemens_board_init();
-	board_init_ddr();
-
-	return;
-}
-#endif /* #ifdef CONFIG_SPL_BUILD */
-
 #ifndef CONFIG_SPL_BUILD
 /*
  * Basic board specific setup.  Pinmux has been handled already.
@@ -145,15 +110,6 @@ int board_init(void)
 }
 #endif /* #ifndef CONFIG_SPL_BUILD */
 
-#define OSC	(V_OSCK/1000000)
-const struct dpll_params dpll_ddr = {
-		DDR_PLL_FREQ, OSC-1, 1, -1, -1, -1, -1};
-
-const struct dpll_params *get_dpll_ddr_params(void)
-{
-	return &dpll_ddr;
-}
-
 #ifndef CONFIG_SPL_BUILD
 
 #define MAX_NR_LEDS	10
@@ -232,7 +188,7 @@ U_BOOT_CMD(
  * defines the startup state of the led, S1 the special state of the led when
  * it enters e.g. dfu mode.
  */
-void set_env_gpios(unsigned char state)
+static void set_env_gpios(unsigned char state)
 {
 	char *ptr_env;
 	char str_tmp[5];	/* must contain "ledX"*/
diff --git a/board/siemens/common/board_am335x.c b/board/siemens/common/board_am335x.c
new file mode 100644
index 00000000000..c44b09a21e3
--- /dev/null
+++ b/board/siemens/common/board_am335x.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Common board functions for siemens AM335X based boards
+ * (C) Copyright Siemens AG 2013
+ * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
+ *
+ * Based on:
+ * U-Boot file:/board/ti/am335x/board.c
+ * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ */
+
+#include <init.h>
+#include <serial.h>
+#include <asm/arch/clock.h>
+#include "board_am335x.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#ifdef CONFIG_SPL_BUILD
+void set_uart_mux_conf(void)
+{
+	enable_uart0_pin_mux();
+}
+
+void set_mux_conf_regs(void)
+{
+	/* Initalize the board header */
+	enable_i2c0_pin_mux();
+
+	/* enable early the console */
+	gd->baudrate = CONFIG_BAUDRATE;
+	serial_init();
+	gd->have_console = 1;
+
+	siemens_ee_setup();
+	if (siemens_read_eeprom() < 0)
+		puts("Could not get board ID.\n");
+
+	enable_board_pin_mux();
+}
+
+void sdram_init(void)
+{
+	spl_siemens_board_init();
+	siemens_init_ddr();
+
+	return;
+}
+#endif /* #ifdef CONFIG_SPL_BUILD */
+
+#define OSC	(V_OSCK/1000000)
+const struct dpll_params dpll_ddr = {
+		DDR_PLL_FREQ, OSC-1, 1, -1, -1, -1, -1};
+
+const struct dpll_params *get_dpll_ddr_params(void)
+{
+	return &dpll_ddr;
+}
diff --git a/board/siemens/common/board_am335x.h b/board/siemens/common/board_am335x.h
new file mode 100644
index 00000000000..ce5bec4f9cb
--- /dev/null
+++ b/board/siemens/common/board_am335x.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Common board definitions for am335x based boards
+ *
+ * Copyright Siemens AG 2023
+ *
+ * Based on:
+ * TI AM335x boards information header
+ * u-boot:/board/ti/am335x/board.h
+ *
+ * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ */
+
+#ifndef _BOARD_AM335X_H_
+#define _BOARD_AM335X_H_
+
+#include "board.h"
+
+/* Common functions with product specific implementation */
+void spl_siemens_board_init(void);
+void siemens_init_ddr(void);
+int siemens_read_eeprom(void);
+
+#ifdef CONFIG_SPL_BUILD
+/* Mux for init: uart?, i2c0 to read the main EEPROM */
+void enable_uart0_pin_mux(void);
+void enable_uart1_pin_mux(void);
+void enable_uart2_pin_mux(void);
+void enable_uart3_pin_mux(void);
+void enable_uart4_pin_mux(void);
+void enable_uart5_pin_mux(void);
+void enable_i2c0_pin_mux(void);
+
+/* Main mux function to enable other pinmux required on the board */
+void enable_board_pin_mux(void);
+#endif /* CONFIG_SPL_BUILD */
+
+#endif /* _BOARD_AM335X_H_ */
diff --git a/board/siemens/draco/Makefile b/board/siemens/draco/Makefile
index 3e3394a8656..5f41108d3ae 100644
--- a/board/siemens/draco/Makefile
+++ b/board/siemens/draco/Makefile
@@ -14,6 +14,8 @@ obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
+obj-y += ../common/board.o
+obj-y += ../common/board_am335x.o
 ifndef CONFIG_SPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index 43db76490f7..821da67e0ba 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -37,7 +37,7 @@
 #include <watchdog.h>
 #include <linux/delay.h>
 #include "board.h"
-#include "../common/board.h"
+#include "../common/board_am335x.h"
 #include "../common/factoryset.h"
 #include <nand.h>
 
@@ -159,7 +159,7 @@ static int draco_read_nand_geometry(void)
 /*
  * Read header information from EEPROM into global structure.
  */
-static int read_eeprom(void)
+int siemens_read_eeprom(void)
 {
 	/* Read Siemens eeprom data (DDR3) */
 	if (siemens_ee_read_data(SIEMENS_EE_ADDR_DDR3, (uchar *)&settings.ddr3,
@@ -195,7 +195,7 @@ static int read_eeprom(void)
 	return draco_read_nand_geometry();
 }
 
-static void board_init_ddr(void)
+void siemens_init_ddr(void)
 {
 struct emif_regs draco_ddr3_emif_reg_data = {
 	.zq_config = 0x50074BE4,
@@ -242,7 +242,7 @@ struct ctrl_ioregs draco_ddr3_ioregs = {
 		   &draco_ddr3_cmd_ctrl_data, &draco_ddr3_emif_reg_data, 0);
 }
 
-static void spl_siemens_board_init(void)
+void spl_siemens_board_init(void)
 {
 	return;
 }
@@ -383,5 +383,3 @@ static void board_nand_cs_init(void)
 			      0x18000000, GPMC_SIZE_16M);
 }
 #endif
-
-#include "../common/board.c"
diff --git a/board/siemens/draco/board.h b/board/siemens/draco/board.h
index 7c29a45c036..b3a765d2eda 100644
--- a/board/siemens/draco/board.h
+++ b/board/siemens/draco/board.h
@@ -1,19 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * board.h
- *
+ * Board definitions for draco products
  * (C) Copyright 2013 Siemens Schweiz AG
  * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
  *
- * Based on:
- * TI AM335x boards information header
- * u-boot:/board/ti/am335x/board.h
- *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * TI am335x specifics moved to ../common/board_am335x.h
  */
 
-#ifndef _BOARD_H_
-#define _BOARD_H_
+#ifndef _BOARD_DRACO_H_
+#define _BOARD_DRACO_H_
 
 #define PARGS(x)	#x , /* Parameter Name */ \
 			settings.ddr3.x, /* EEPROM Value */ \
@@ -58,21 +53,4 @@ struct draco_baseboard_id {
 	struct chip_data chip;
 };
 
-/*
- * We have three pin mux functions that must exist.  We must be able to enable
- * uart0, for initial output and i2c0 to read the main EEPROM.  We then have a
- * main pinmux function that can be overridden to enable all other pinmux that
- * is required on the board.
- */
-void enable_uart0_pin_mux(void);
-void enable_uart1_pin_mux(void);
-void enable_uart2_pin_mux(void);
-void enable_uart3_pin_mux(void);
-void enable_uart4_pin_mux(void);
-void enable_uart5_pin_mux(void);
-void enable_i2c0_pin_mux(void);
-void enable_board_pin_mux(void);
-
-/* Forwared declaration, defined in common board.c */
-void set_env_gpios(unsigned char state);
-#endif
+#endif /* _BOARD_DRACO_H_ */
diff --git a/board/siemens/draco/mux.c b/board/siemens/draco/mux.c
index 3f2d41befeb..1bf0fa961aa 100644
--- a/board/siemens/draco/mux.c
+++ b/board/siemens/draco/mux.c
@@ -16,7 +16,7 @@
 #include <asm/arch/mux.h>
 #include <asm/io.h>
 #include <i2c.h>
-#include "board.h"
+#include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
 	{OFFSET(uart0_rxd), (MODE(0) | PULLUP_EN | RXACTIVE)},	/* UART0_RXD */
diff --git a/board/siemens/pxm2/MAINTAINERS b/board/siemens/pxm2/MAINTAINERS
index dc02fe87c9b..49025446079 100644
--- a/board/siemens/pxm2/MAINTAINERS
+++ b/board/siemens/pxm2/MAINTAINERS
@@ -1,5 +1,5 @@
 PXM2 BOARD
-M:	Samuel Egli <samuel.egli@siemens.com>
+M:	Enrico Leto <enrico.leto@siemens.com>
 S:	Maintained
 F:	board/siemens/pxm2/
 F:	include/configs/pxm2.h
diff --git a/board/siemens/pxm2/Makefile b/board/siemens/pxm2/Makefile
index 3e3394a8656..5f41108d3ae 100644
--- a/board/siemens/pxm2/Makefile
+++ b/board/siemens/pxm2/Makefile
@@ -14,6 +14,8 @@ obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
+obj-y += ../common/board.o
+obj-y += ../common/board_am335x.o
 ifndef CONFIG_SPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index 6a345b5639f..f26e3d8945f 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -35,14 +35,14 @@
 #include <miiphy.h>
 #include <cpsw.h>
 #include <watchdog.h>
-#include "board.h"
-#include "../common/factoryset.h"
 #include "pmic.h"
 #include <nand.h>
 #include <bmp_layout.h>
+#include "../common/board_am335x.h"
+#include "../common/factoryset.h"
 
 #ifdef CONFIG_SPL_BUILD
-static void board_init_ddr(void)
+void siemens_init_ddr(void)
 {
 struct emif_regs pxm2_ddr3_emif_reg_data = {
 	.sdram_config = 0x41805332,
@@ -161,7 +161,7 @@ void spl_siemens_board_init(void)
 	}
 }
 
-int read_eeprom(void)
+int siemens_read_eeprom(void)
 {
 	/* nothing ToDo here for this board */
 
@@ -274,5 +274,3 @@ int board_late_init(void)
 	return 0;
 }
 #endif
-
-#include "../common/board.c"
diff --git a/board/siemens/pxm2/board.h b/board/siemens/pxm2/board.h
deleted file mode 100644
index af21fc47432..00000000000
--- a/board/siemens/pxm2/board.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * board.h
- *
- * (C) Copyright 2013 Siemens Schweiz AG
- * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
- *
- * Based on:
- * TI AM335x boards information header
- * u-boot:/board/ti/am335x/board.h
- *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
- */
-
-#ifndef _BOARD_H_
-#define _BOARD_H_
-
-void enable_uart0_pin_mux(void);
-void enable_i2c0_pin_mux(void);
-void enable_board_pin_mux(void);
-#endif
diff --git a/board/siemens/pxm2/mux.c b/board/siemens/pxm2/mux.c
index 2f35bb4a730..50ef657de10 100644
--- a/board/siemens/pxm2/mux.c
+++ b/board/siemens/pxm2/mux.c
@@ -17,7 +17,7 @@
 #include <asm/arch/mux.h>
 #include <asm/io.h>
 #include <i2c.h>
-#include "board.h"
+#include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
 	{OFFSET(uart0_rxd), (MODE(0) | PULLUP_EN | RXACTIVE)},	/* UART0_RXD */
diff --git a/board/siemens/rut/MAINTAINERS b/board/siemens/rut/MAINTAINERS
index 1e92710904b..4d8e2567099 100644
--- a/board/siemens/rut/MAINTAINERS
+++ b/board/siemens/rut/MAINTAINERS
@@ -1,5 +1,5 @@
 RUT BOARD
-M:	Samuel Egli <samuel.egli@siemens.com>
+M:	Enrico Leto <enrico.leto@siemens.com>
 S:	Maintained
 F:	board/siemens/rut/
 F:	include/configs/rut.h
diff --git a/board/siemens/rut/Makefile b/board/siemens/rut/Makefile
index 3e3394a8656..5f41108d3ae 100644
--- a/board/siemens/rut/Makefile
+++ b/board/siemens/rut/Makefile
@@ -14,6 +14,8 @@ obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
+obj-y += ../common/board.o
+obj-y += ../common/board_am335x.o
 ifndef CONFIG_SPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index bd1c5894f6a..7dd527349a2 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -35,19 +35,19 @@
 #include <video.h>
 #include <watchdog.h>
 #include <linux/delay.h>
-#include "board.h"
+#include "../common/board_am335x.h"
 #include "../common/factoryset.h"
 
 #ifdef CONFIG_SPL_BUILD
 /*
  * Read header information from EEPROM into global structure.
  */
-static int read_eeprom(void)
+int siemens_read_eeprom(void)
 {
 	return 0;
 }
 
-static void board_init_ddr(void)
+void siemens_init_ddr(void)
 {
 struct emif_regs rut_ddr3_emif_reg_data = {
 	.sdram_config = 0x61C04AB2,
@@ -124,7 +124,7 @@ err:
 #define REQUEST_AND_PULSE_RESET(N) \
 		request_and_pulse_reset(N, #N);
 
-static void spl_siemens_board_init(void)
+void spl_siemens_board_init(void)
 {
 	REQUEST_AND_PULSE_RESET(ETH_PHY_RESET_GPIO);
 	REQUEST_AND_PULSE_RESET(MAXTOUCH_RESET_GPIO);
@@ -244,5 +244,3 @@ int board_late_init(void)
 	return 0;
 }
 #endif
-
-#include "../common/board.c"
diff --git a/board/siemens/rut/board.h b/board/siemens/rut/board.h
deleted file mode 100644
index af21fc47432..00000000000
--- a/board/siemens/rut/board.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * board.h
- *
- * (C) Copyright 2013 Siemens Schweiz AG
- * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
- *
- * Based on:
- * TI AM335x boards information header
- * u-boot:/board/ti/am335x/board.h
- *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
- */
-
-#ifndef _BOARD_H_
-#define _BOARD_H_
-
-void enable_uart0_pin_mux(void);
-void enable_i2c0_pin_mux(void);
-void enable_board_pin_mux(void);
-#endif
diff --git a/board/siemens/rut/mux.c b/board/siemens/rut/mux.c
index d80120bbdd2..ff752b676a3 100644
--- a/board/siemens/rut/mux.c
+++ b/board/siemens/rut/mux.c
@@ -17,6 +17,7 @@
 #include <asm/arch/mux.h>
 #include <asm/io.h>
 #include <i2c.h>
+#include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
 	{OFFSET(uart0_rxd), (MODE(0) | PULLUDDIS | RXACTIVE)},	/* UART0_RXD */
-- 
2.30.2

