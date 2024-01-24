Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDB0C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 14:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 605C587EB1;
	Wed, 24 Jan 2024 15:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="lqeq1+AV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756D787DC8; Wed, 24 Jan 2024 15:44:12 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251DE87D80
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 15:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2024012414440122176f81bddf6a427f for <u-boot@lists.denx.de>;
 Wed, 24 Jan 2024 15:44:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=epe7dciwYspohMhUPAkccp7dVGrZWTHMCKILMZBmM6I=;
 b=lqeq1+AVD42oyMezaI7cs5h16vadLjnHTnsQ4FuVWyORZzt/bP7+FkoAq/kDMqMTPvehuC
 O78ZL2KWORhg6IZmX8pJDlA6UUkLZtZl+xg8Co0WfnwV/qmoYM35iliOeeXPMsLu+PqyKpaA
 k7wVTwm3MYuAX6mWBF8QDdE6KTG9c=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de,
	alexander.sverdlin@siemens.com
Cc: trini@konsulko.com,
	Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH v6 5/7] siemens: board: clean up products folders vs common
Date: Wed, 24 Jan 2024 15:43:53 +0100
Message-Id: <20240124144355.2040380-6-enrico.leto@siemens.com>
In-Reply-To: <20240124144355.2040380-1-enrico.leto@siemens.com>
References: <20240124144355.2040380-1-enrico.leto@siemens.com>
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
products based on draco-am355x board family. These are the product lines
'pxm2', 'rut' and the base line named 'draco'!

Adding the new capricorn-imx8 board family, common was enhanced without
cleanup.
- rename 'common/board.c' to 'common/board_am335x.c'
- add 'common/board_am335x.h' for export to the product lines

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 .../common/{board.c => board_am335x.c}        |  7 ++--
 board/siemens/common/board_am335x.h           | 39 +++++++++++++++++++
 board/siemens/draco/Makefile                  |  1 +
 board/siemens/draco/board.c                   |  8 ++--
 board/siemens/draco/board.h                   | 31 +++------------
 board/siemens/pxm2/MAINTAINERS                |  2 +-
 board/siemens/pxm2/Makefile                   |  1 +
 board/siemens/pxm2/board.c                    | 10 ++---
 board/siemens/pxm2/board.h                    | 21 ----------
 board/siemens/rut/MAINTAINERS                 |  2 +-
 board/siemens/rut/Makefile                    |  1 +
 board/siemens/rut/board.c                     | 10 ++---
 board/siemens/rut/board.h                     | 21 ----------
 13 files changed, 64 insertions(+), 90 deletions(-)
 rename board/siemens/common/{board.c => board_am335x.c} (98%)
 create mode 100644 board/siemens/common/board_am335x.h
 delete mode 100644 board/siemens/pxm2/board.h
 delete mode 100644 board/siemens/rut/board.h

diff --git a/board/siemens/common/board.c b/board/siemens/common/board_am335x.c
similarity index 98%
rename from board/siemens/common/board.c
rename to board/siemens/common/board_am335x.c
index e5a42d734bb..c55ca983bdd 100644
--- a/board/siemens/common/board.c
+++ b/board/siemens/common/board_am335x.c
@@ -33,6 +33,7 @@
 #include <cpsw.h>
 #include <watchdog.h>
 #include <asm/mach-types.h>
+#include "board_am335x.h"
 #include "eeprom.h"
 #include "factoryset.h"
 
@@ -56,7 +57,7 @@ void set_mux_conf_regs(void)
 	gd->have_console = 1;
 
 	siemens_ee_setup();
-	if (read_eeprom() < 0)
+	if (draco_read_eeprom() < 0)
 		puts("Could not get board ID.\n");
 
 	enable_board_pin_mux();
@@ -64,8 +65,8 @@ void set_mux_conf_regs(void)
 
 void sdram_init(void)
 {
-	spl_siemens_board_init();
-	board_init_ddr();
+	spl_draco_board_init();
+	draco_init_ddr();
 
 	return;
 }
diff --git a/board/siemens/common/board_am335x.h b/board/siemens/common/board_am335x.h
new file mode 100644
index 00000000000..3a20352d457
--- /dev/null
+++ b/board/siemens/common/board_am335x.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Board definitions for draco products
+ *
+ * (C) Copyright 2013 Siemens Schweiz AG
+ * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
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
+#include "eeprom.h"
+
+/* Common functions with product specific implementation */
+void spl_draco_board_init(void);
+void draco_init_ddr(void);
+int draco_read_eeprom(void);
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
index 1d0cb82bcb6..aae536472c5 100644
--- a/board/siemens/draco/Makefile
+++ b/board/siemens/draco/Makefile
@@ -14,6 +14,7 @@ obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
+obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
 ifndef CONFIG_SPL_BUILD
 obj-y += ../common/factoryset.o
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index d108d3e49db..2412a04a9a1 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -159,7 +159,7 @@ static int draco_read_nand_geometry(void)
 /*
  * Read header information from EEPROM into global structure.
  */
-static int read_eeprom(void)
+int draco_read_eeprom(void)
 {
 	/* Read Siemens eeprom data (DDR3) */
 	if (siemens_ee_read_data(SIEMENS_EE_ADDR_DDR3, (uchar *)&settings.ddr3,
@@ -195,7 +195,7 @@ static int read_eeprom(void)
 	return draco_read_nand_geometry();
 }
 
-static void board_init_ddr(void)
+void draco_init_ddr(void)
 {
 struct emif_regs draco_ddr3_emif_reg_data = {
 	.zq_config = 0x50074BE4,
@@ -242,7 +242,7 @@ struct ctrl_ioregs draco_ddr3_ioregs = {
 		   &draco_ddr3_cmd_ctrl_data, &draco_ddr3_emif_reg_data, 0);
 }
 
-static void spl_siemens_board_init(void)
+void spl_draco_board_init(void)
 {
 	return;
 }
@@ -357,5 +357,3 @@ U_BOOT_CMD(
 );
 #endif /* #if defined(CONFIG_DRIVER_TI_CPSW) */
 #endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) */
-
-#include "../common/board.c"
diff --git a/board/siemens/draco/board.h b/board/siemens/draco/board.h
index f027427d1fb..935f340a8f2 100644
--- a/board/siemens/draco/board.h
+++ b/board/siemens/draco/board.h
@@ -1,19 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * board.h
+ * Board definitions for draco products
  *
  * (C) Copyright 2013 Siemens Schweiz AG
  * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
  *
- * Based on:
- * TI AM335x boards information header
- * u-boot:/board/ti/am335x/board.h
- *
- * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
+ * TI am335x specifics moved to ../common/board_am335x.h
  */
 
-#ifndef _BOARD_H_
-#define _BOARD_H_
+#ifndef _BOARD_DRACO_H_
+#define _BOARD_DRACO_H_
 
 #define PARGS(x)	#x , /* Parameter Name */ \
 			settings.ddr3.x, /* EEPROM Value */ \
@@ -58,21 +54,4 @@ struct draco_baseboard_id {
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
index 1d0cb82bcb6..aae536472c5 100644
--- a/board/siemens/pxm2/Makefile
+++ b/board/siemens/pxm2/Makefile
@@ -14,6 +14,7 @@ obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
+obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
 ifndef CONFIG_SPL_BUILD
 obj-y += ../common/factoryset.o
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index 16b0d3df757..bff6d20251e 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -35,7 +35,7 @@
 #include <miiphy.h>
 #include <cpsw.h>
 #include <watchdog.h>
-#include "board.h"
+#include "../common/board_am335x.h"
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 #include "pmic.h"
@@ -43,7 +43,7 @@
 #include <bmp_layout.h>
 
 #ifdef CONFIG_SPL_BUILD
-static void board_init_ddr(void)
+void draco_init_ddr(void)
 {
 struct emif_regs pxm2_ddr3_emif_reg_data = {
 	.sdram_config = 0x41805332,
@@ -135,7 +135,7 @@ int voltage_update(unsigned int module, unsigned char vddx_op_vol_sel)
 const struct dpll_params dpll_mpu_pxm2 = {
 		720, OSC-1, 1, -1, -1, -1, -1};
 
-void spl_siemens_board_init(void)
+void spl_draco_board_init(void)
 {
 	uchar buf[4];
 	/*
@@ -162,7 +162,7 @@ void spl_siemens_board_init(void)
 	}
 }
 
-int read_eeprom(void)
+int draco_read_eeprom(void)
 {
 	/* nothing ToDo here for this board */
 
@@ -275,5 +275,3 @@ int board_late_init(void)
 	return 0;
 }
 #endif
-
-#include "../common/board.c"
diff --git a/board/siemens/pxm2/board.h b/board/siemens/pxm2/board.h
deleted file mode 100644
index 9067e4d5aa8..00000000000
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
- * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
- */
-
-#ifndef _BOARD_H_
-#define _BOARD_H_
-
-void enable_uart0_pin_mux(void);
-void enable_i2c0_pin_mux(void);
-void enable_board_pin_mux(void);
-#endif
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
index 1d0cb82bcb6..aae536472c5 100644
--- a/board/siemens/rut/Makefile
+++ b/board/siemens/rut/Makefile
@@ -14,6 +14,7 @@ obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
+obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
 ifndef CONFIG_SPL_BUILD
 obj-y += ../common/factoryset.o
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index d9e84db03ef..1e0e131addf 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -35,7 +35,7 @@
 #include <video.h>
 #include <watchdog.h>
 #include <linux/delay.h>
-#include "board.h"
+#include "../common/board_am335x.h"
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
@@ -43,12 +43,12 @@
 /*
  * Read header information from EEPROM into global structure.
  */
-static int read_eeprom(void)
+int draco_read_eeprom(void)
 {
 	return 0;
 }
 
-static void board_init_ddr(void)
+void draco_init_ddr(void)
 {
 struct emif_regs rut_ddr3_emif_reg_data = {
 	.sdram_config = 0x61C04AB2,
@@ -125,7 +125,7 @@ err:
 #define REQUEST_AND_PULSE_RESET(N) \
 		request_and_pulse_reset(N, #N);
 
-static void spl_siemens_board_init(void)
+void spl_draco_board_init(void)
 {
 	REQUEST_AND_PULSE_RESET(ETH_PHY_RESET_GPIO);
 	REQUEST_AND_PULSE_RESET(MAXTOUCH_RESET_GPIO);
@@ -245,5 +245,3 @@ int board_late_init(void)
 	return 0;
 }
 #endif
-
-#include "../common/board.c"
diff --git a/board/siemens/rut/board.h b/board/siemens/rut/board.h
deleted file mode 100644
index 9067e4d5aa8..00000000000
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
- * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
- */
-
-#ifndef _BOARD_H_
-#define _BOARD_H_
-
-void enable_uart0_pin_mux(void);
-void enable_i2c0_pin_mux(void);
-void enable_board_pin_mux(void);
-#endif
-- 
2.30.2

