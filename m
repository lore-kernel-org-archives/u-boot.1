Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717CCC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 09:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6133987DCA;
	Mon, 18 Dec 2023 10:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="D4KJE+hZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CEF87727; Mon, 18 Dec 2023 10:00:13 +0100 (CET)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983AD87D99
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20231218090010e7d368bcda6a7a0a32 for <u-boot@lists.denx.de>;
 Mon, 18 Dec 2023 10:00:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cOORbyPhH35dR7lCid4g26XZhTpBZNyU6a9c+gMgYAo=;
 b=D4KJE+hZYA47x3ptrAAaFvlpRy549Y9NJIu4hKXYi9H7iFIRCr09npsDvwmrFJ3gaI/SVQ
 +njuqe4Gc4UAGZ0OA7HYL3WNLSiUANQ2S+fnMGzGWyZJNmOo1ozhK70m0oj70GtyALJpcRlV
 6mzWgbqzbVfHyoQOHG/7upHk6vg8A=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH v3 5/6] siemens: board: clean up includes
Date: Mon, 18 Dec 2023 09:59:14 +0100
Message-Id: <20231218085915.3739975-6-enrico.leto@siemens.com>
In-Reply-To: <20231218085915.3739975-1-enrico.leto@siemens.com>
References: <20231218085915.3739975-1-enrico.leto@siemens.com>
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
index 91d753d4aeb..dfe70a9cfba 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -12,30 +12,17 @@
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
index 594da729058..c85355f293b 100644
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
 #include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index 066ca61d60a..f15a26af18f 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -12,32 +12,18 @@
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
index 9d3cb5c31b9..c061c95ff2b 100644
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
 #include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index 2c6fbfe1201..e7571b7654a 100644
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
index 090c898ccad..cf0305d2d9c 100644
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
 #include "../common/board_am335x.h"
 
 static struct module_pin_mux uart0_pin_mux[] = {
-- 
2.30.2

