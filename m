Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06153C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C8F8760E;
	Tue, 21 Nov 2023 15:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="nQI4R5YJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868DE87602; Tue, 21 Nov 2023 15:21:51 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A74863F8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20231121142147895b724d1211c603f4 for <u-boot@lists.denx.de>;
 Tue, 21 Nov 2023 15:21:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iZkD8wMyfUnRe/cLXLyvgfbkHod9/2xLXqGoifAEXMc=;
 b=nQI4R5YJtPG+uxTYtRrIWu9JLSoOIwd61Kvy8pd4rAEAXV4It1oDMTYbafmCugHjbzV94R
 y4BXCOt76igpTCjN0OPFtLfegRR7iH4Nu2iofdPJPG657GJj5Jv1Zow8VxiA7gblpY59ABRa
 qdBNgFdqBC8WqA5kxfHIUErLeX4R8=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 5/6] siemens: board: clean up includes
Date: Tue, 21 Nov 2023 15:21:33 +0100
Message-Id: <20231121142134.2147652-6-enrico.leto@siemens.com>
In-Reply-To: <20231121142134.2147652-1-enrico.leto@siemens.com>
References: <20231121142134.2147652-1-enrico.leto@siemens.com>
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
 board/siemens/common/board.c      | 24 +++---------------------
 board/siemens/common/factoryset.c | 12 ++----------
 board/siemens/draco/board.c       | 23 +++++------------------
 board/siemens/draco/mux.c         |  4 +---
 board/siemens/pxm2/board.c        | 22 ++++------------------
 board/siemens/pxm2/mux.c          |  4 +---
 board/siemens/rut/board.c         | 21 +++------------------
 board/siemens/rut/mux.c           |  4 +---
 8 files changed, 20 insertions(+), 94 deletions(-)

diff --git a/board/siemens/common/board.c b/board/siemens/common/board.c
index 981ffe4e69a..d3e5b83e30f 100644
--- a/board/siemens/common/board.c
+++ b/board/siemens/common/board.c
@@ -8,30 +8,12 @@
  * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
-#include <env.h>
-#include <errno.h>
-#include <init.h>
-#include <malloc.h>
-#include <serial.h>
-#include <spl.h>
-#include <asm/arch/cpu.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/omap.h>
-#include <asm/arch/ddr_defs.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/mmc_host_def.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/emif.h>
-#include <asm/gpio.h>
+#include <dm/uclass.h>
 #include <i2c.h>
-#include <miiphy.h>
-#include <cpsw.h>
 #include <watchdog.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
 #include <asm/mach-types.h>
 #include "board.h"
 #include "factoryset.h"
diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index 8f5cf066664..9adc42ce0b7 100644
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
 #include "board.h"
 #include "factoryset.h"
 
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index 821da67e0ba..6a59eaddc24 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -12,30 +12,17 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
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
+#include <asm/arch/ddr_defs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/arch/mem.h>
-#include <asm/io.h>
-#include <asm/emif.h>
 #include <asm/gpio.h>
-#include <i2c.h>
-#include <miiphy.h>
-#include <cpsw.h>
-#include <watchdog.h>
-#include <linux/delay.h>
+#include <asm/io.h>
 #include "board.h"
 #include "../common/board_am335x.h"
 #include "../common/factoryset.h"
diff --git a/board/siemens/draco/mux.c b/board/siemens/draco/mux.c
index 1bf0fa961aa..13228039bb7 100644
--- a/board/siemens/draco/mux.c
+++ b/board/siemens/draco/mux.c
@@ -10,12 +10,10 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
  */
 
-#include <common.h>
+#include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-#include <asm/io.h>
-#include <i2c.h>
 #include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index f26e3d8945f..959184008a8 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -12,32 +12,18 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
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
 #include <asm/io.h>
-#include <asm/emif.h>
 #include <asm/gpio.h>
-#include <i2c.h>
-#include <miiphy.h>
-#include <cpsw.h>
-#include <watchdog.h>
 #include "pmic.h"
-#include <nand.h>
-#include <bmp_layout.h>
 #include "../common/board_am335x.h"
 #include "../common/factoryset.h"
 
diff --git a/board/siemens/pxm2/mux.c b/board/siemens/pxm2/mux.c
index 50ef657de10..6f4e64c523c 100644
--- a/board/siemens/pxm2/mux.c
+++ b/board/siemens/pxm2/mux.c
@@ -11,12 +11,10 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
  */
 
-#include <common.h>
+#include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-#include <asm/io.h>
-#include <i2c.h>
 #include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index 7dd527349a2..3f79502c247 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -10,31 +10,16 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
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
+#include <linux/delay.h>
+#include <nand.h>
 #include <asm/arch/ddr_defs.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/mmc_host_def.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
-#include <asm/emif.h>
 #include <asm/gpio.h>
-#include <i2c.h>
-#include <miiphy.h>
-#include <cpsw.h>
-#include <video.h>
-#include <watchdog.h>
-#include <linux/delay.h>
 #include "../common/board_am335x.h"
 #include "../common/factoryset.h"
 
diff --git a/board/siemens/rut/mux.c b/board/siemens/rut/mux.c
index ff752b676a3..c226d299526 100644
--- a/board/siemens/rut/mux.c
+++ b/board/siemens/rut/mux.c
@@ -11,12 +11,10 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
  */
 
-#include <common.h>
+#include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-#include <asm/io.h>
-#include <i2c.h>
 #include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
-- 
2.30.2

