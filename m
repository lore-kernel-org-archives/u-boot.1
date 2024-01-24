Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F85DC47422
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 14:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C2B87E70;
	Wed, 24 Jan 2024 15:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="O21E1TYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAC087D58; Wed, 24 Jan 2024 15:44:08 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD5787D82
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 15:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2024012414440236213387822a3f2d12 for <u-boot@lists.denx.de>;
 Wed, 24 Jan 2024 15:44:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mG/iJMaN7tCEGnGZFHQfz9h6GrSQkMdjWvsLbOup8p4=;
 b=O21E1TYp52+qdGP2S9Jf4stcUd4a4bg/rji/yw2lLPvYqz8rhT9Q5nT24fTjW/jeWXnleG
 lEFBvWm5fgWViK91wmGiQFi3rLJNtmyiWA0ie65S5VdYGx9b70JLqya1THshUuiTZBCx5aGH
 tEM5GD9sPcIfdHC6L9XJ5NHmEuBKk=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de,
	alexander.sverdlin@siemens.com
Cc: trini@konsulko.com,
	Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH v6 6/7] siemens: board: clean up includes
Date: Wed, 24 Jan 2024 15:43:54 +0100
Message-Id: <20240124144355.2040380-7-enrico.leto@siemens.com>
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

Many includes were not removed when code parts were moved or removed.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 board/siemens/capricorn/board.c     |  1 -
 board/siemens/common/board_am335x.c | 19 +------------------
 board/siemens/common/factoryset.c   | 12 ++----------
 board/siemens/draco/board.c         | 25 ++++++-------------------
 board/siemens/draco/mux.c           |  4 +---
 board/siemens/pxm2/board.c          | 26 ++++++--------------------
 board/siemens/pxm2/mux.c            |  4 +---
 board/siemens/rut/board.c           | 25 +++++--------------------
 board/siemens/rut/mux.c             |  4 +---
 9 files changed, 23 insertions(+), 97 deletions(-)

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 5f7e2b1e899..0d66a75bbfa 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -22,7 +22,6 @@
 #include <asm/gpio.h>
 #include <asm/arch/imx8-pins.h>
 #include <asm/arch/iomux.h>
-#include <firmware/imx/sci/sci.h>
 #include <asm/arch/sys_proto.h>
 #ifndef CONFIG_SPL
 #include <asm/arch-imx8/clock.h>
diff --git a/board/siemens/common/board_am335x.c b/board/siemens/common/board_am335x.c
index c55ca983bdd..445af9ddbf6 100644
--- a/board/siemens/common/board_am335x.c
+++ b/board/siemens/common/board_am335x.c
@@ -9,29 +9,12 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <command.h>
-#include <env.h>
-#include <errno.h>
-#include <init.h>
-#include <malloc.h>
 #include <serial.h>
-#include <spl.h>
-#include <asm/arch/cpu.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/omap.h>
-#include <asm/arch/ddr_defs.h>
+#include <watchdog.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/mmc_host_def.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/emif.h>
 #include <asm/gpio.h>
-#include <miiphy.h>
-#include <cpsw.h>
-#include <watchdog.h>
 #include <asm/mach-types.h>
 #include "board_am335x.h"
 #include "eeprom.h"
diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index 4a1277340a7..b20af95d13d 100644
--- a/board/siemens/common/factoryset.c
+++ b/board/siemens/common/factoryset.c
@@ -7,21 +7,13 @@
 
 #if !defined(CONFIG_SPL_BUILD)
 
-#include <common.h>
 #include <env.h>
-#include <dm.h>
-#include <env_internal.h>
-#include <i2c.h>
-#include <log.h>
+#include <g_dnl.h>
+#include <net.h>
 #include <asm/io.h>
 #if !CONFIG_IS_ENABLED(TARGET_GIEDI) && !CONFIG_IS_ENABLED(TARGET_DENEB)
 #include <asm/arch/cpu.h>
 #endif
-#include <asm/arch/sys_proto.h>
-#include <asm/unaligned.h>
-#include <net.h>
-#include <errno.h>
-#include <g_dnl.h>
 #include "eeprom.h"
 #include "factoryset.h"
 
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index 2412a04a9a1..fc3eb06ccf2 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -12,34 +12,21 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <command.h>
+#include <cpsw.h>
 #include <env.h>
-#include <errno.h>
 #include <init.h>
-#include <net.h>
-#include <spl.h>
-#include <asm/arch/cpu.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/omap.h>
-#include <asm/arch/ddr_defs.h>
+#include <linux/delay.h>
+#include <nand.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/mmc_host_def.h>
-#include <asm/arch/sys_proto.h>
+#include <asm/arch/ddr_defs.h>
 #include <asm/arch/mem.h>
-#include <asm/io.h>
-#include <asm/emif.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <i2c.h>
-#include <miiphy.h>
-#include <cpsw.h>
-#include <watchdog.h>
-#include <linux/delay.h>
+#include <asm/io.h>
 #include "board.h"
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
-#include <nand.h>
 
 #ifdef CONFIG_SPL_BUILD
 static struct draco_baseboard_id __section(".data") settings;
diff --git a/board/siemens/draco/mux.c b/board/siemens/draco/mux.c
index 56d8f45c349..4149e628475 100644
--- a/board/siemens/draco/mux.c
+++ b/board/siemens/draco/mux.c
@@ -10,12 +10,10 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-#include <asm/io.h>
-#include <i2c.h>
 #include "eeprom.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index bff6d20251e..888c7c09baf 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -12,35 +12,21 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <cpsw.h>
 #include <env.h>
-#include <errno.h>
+#include <i2c.h>
 #include <init.h>
-#include <log.h>
-#include <malloc.h>
+#include <nand.h>
 #include <net.h>
-#include <spl.h>
-#include <asm/arch/cpu.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/omap.h>
-#include <asm/arch/ddr_defs.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/mmc_host_def.h>
+#include <asm/arch/ddr_defs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/io.h>
-#include <asm/emif.h>
 #include <asm/gpio.h>
-#include <i2c.h>
-#include <miiphy.h>
-#include <cpsw.h>
-#include <watchdog.h>
+#include <asm/io.h>
+#include "pmic.h"
 #include "../common/board_am335x.h"
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
-#include "pmic.h"
-#include <nand.h>
-#include <bmp_layout.h>
 
 #ifdef CONFIG_SPL_BUILD
 void draco_init_ddr(void)
diff --git a/board/siemens/pxm2/mux.c b/board/siemens/pxm2/mux.c
index 07cf5675927..bdf460b5920 100644
--- a/board/siemens/pxm2/mux.c
+++ b/board/siemens/pxm2/mux.c
@@ -11,12 +11,10 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-#include <asm/io.h>
-#include <i2c.h>
 #include "eeprom.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index 1e0e131addf..8d316918e7a 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -10,31 +10,16 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <cpsw.h>
 #include <env.h>
-#include <errno.h>
 #include <init.h>
-#include <malloc.h>
-#include <net.h>
-#include <spi.h>
-#include <spl.h>
-#include <asm/arch/cpu.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/omap.h>
-#include <asm/arch/ddr_defs.h>
+#include <linux/delay.h>
+#include <nand.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/mmc_host_def.h>
+#include <asm/arch/ddr_defs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/io.h>
-#include <asm/emif.h>
 #include <asm/gpio.h>
-#include <i2c.h>
-#include <miiphy.h>
-#include <cpsw.h>
-#include <video.h>
-#include <watchdog.h>
-#include <linux/delay.h>
+#include <asm/io.h>
 #include "../common/board_am335x.h"
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
diff --git a/board/siemens/rut/mux.c b/board/siemens/rut/mux.c
index 894a9bf1e3d..8947e4e537c 100644
--- a/board/siemens/rut/mux.c
+++ b/board/siemens/rut/mux.c
@@ -11,12 +11,10 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-#include <asm/io.h>
-#include <i2c.h>
 
 static struct module_pin_mux uart0_pin_mux[] = {
 	{OFFSET(uart0_rxd), (MODE(0) | PULLUDDIS | RXACTIVE)},	/* UART0_RXD */
-- 
2.30.2

