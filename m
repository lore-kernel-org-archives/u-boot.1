Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69A2C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D1887483;
	Fri, 17 Nov 2023 23:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aZVizEcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC0486F56; Fri, 17 Nov 2023 23:38:43 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB858701C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHMcWXM024222;
 Fri, 17 Nov 2023 16:38:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700260712;
 bh=dUDIjnGMRLkAVN8ZmaU+CbF4u8wqbQ+3xnlaICnLYs4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aZVizEcD3OBTT9TQOfmwkZe/R7nBzILQtc/+9oQgEoSODUibYZfk70Hxhg2Dquk7F
 zD7K4Ry0f5iGMBzEFogUekZLqf18vm2MKfKLfU7tGlojnlrdhEYBqDdc6SU9p0g9gp
 p2MFhchn3pk03UnWcEBtveAMUhZ8opvSn/0py1W8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHMcW2D006445
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Nov 2023 16:38:32 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 16:38:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 16:38:31 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHMcUtx021675; 
 Fri, 17 Nov 2023 16:38:31 -0600
From: Andrew Davis <afd@ti.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>
Subject: [PATCH 3/3] ARM: keystone2: Remove unneeded inclusions of common.h
Date: Fri, 17 Nov 2023 16:38:29 -0600
Message-ID: <20231117223829.346652-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117223829.346652-1-afd@ti.com>
References: <20231117223829.346652-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-keystone/clock.c                | 1 -
 arch/arm/mach-keystone/cmd_clock.c            | 2 +-
 arch/arm/mach-keystone/cmd_mon.c              | 1 -
 arch/arm/mach-keystone/cmd_poweroff.c         | 1 -
 arch/arm/mach-keystone/ddr3.c                 | 2 +-
 arch/arm/mach-keystone/ddr3_spd.c             | 2 +-
 arch/arm/mach-keystone/include/mach/mux-k2g.h | 1 -
 arch/arm/mach-keystone/init.c                 | 1 -
 arch/arm/mach-keystone/keystone.c             | 1 -
 arch/arm/mach-keystone/mon.c                  | 1 -
 arch/arm/mach-keystone/msmc.c                 | 1 -
 arch/arm/mach-keystone/psc.c                  | 1 -
 12 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-keystone/clock.c b/arch/arm/mach-keystone/clock.c
index 0c59515d2eb..4f193794efb 100644
--- a/arch/arm/mach-keystone/clock.c
+++ b/arch/arm/mach-keystone/clock.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/clock_defs.h>
 #include <linux/bitops.h>
diff --git a/arch/arm/mach-keystone/cmd_clock.c b/arch/arm/mach-keystone/cmd_clock.c
index 72dc394df5f..e9ecc05953a 100644
--- a/arch/arm/mach-keystone/cmd_clock.c
+++ b/arch/arm/mach-keystone/cmd_clock.c
@@ -6,7 +6,7 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
+#include <vsprintf.h>
 #include <command.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-keystone/cmd_mon.c b/arch/arm/mach-keystone/cmd_mon.c
index dc97bac8550..c6e7e2c3097 100644
--- a/arch/arm/mach-keystone/cmd_mon.c
+++ b/arch/arm/mach-keystone/cmd_mon.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <image.h>
 #include <mach/mon.h>
diff --git a/arch/arm/mach-keystone/cmd_poweroff.c b/arch/arm/mach-keystone/cmd_poweroff.c
index f0ad9173b96..0ad31ef4e28 100644
--- a/arch/arm/mach-keystone/cmd_poweroff.c
+++ b/arch/arm/mach-keystone/cmd_poweroff.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/arch/mon.h>
 #include <asm/arch/psc_defs.h>
diff --git a/arch/arm/mach-keystone/ddr3.c b/arch/arm/mach-keystone/ddr3.c
index ea7d0b903cf..ca0fb702d54 100644
--- a/arch/arm/mach-keystone/ddr3.c
+++ b/arch/arm/mach-keystone/ddr3.c
@@ -9,7 +9,7 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <asm/io.h>
-#include <common.h>
+#include <vsprintf.h>
 #include <asm/arch/msmc.h>
 #include <asm/arch/ddr3.h>
 #include <asm/arch/psc_defs.h>
diff --git a/arch/arm/mach-keystone/ddr3_spd.c b/arch/arm/mach-keystone/ddr3_spd.c
index 6f7f8ab7b40..d4ff442175b 100644
--- a/arch/arm/mach-keystone/ddr3_spd.c
+++ b/arch/arm/mach-keystone/ddr3_spd.c
@@ -5,8 +5,8 @@
  * (C) Copyright 2015-2016 Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <log.h>
+#include <string.h>
 
 #include <i2c.h>
 #include <ddr_spd.h>
diff --git a/arch/arm/mach-keystone/include/mach/mux-k2g.h b/arch/arm/mach-keystone/include/mach/mux-k2g.h
index 67d47f81721..dfb5ad43506 100644
--- a/arch/arm/mach-keystone/include/mach/mux-k2g.h
+++ b/arch/arm/mach-keystone/include/mach/mux-k2g.h
@@ -9,7 +9,6 @@
 #ifndef __ASM_ARCH_MUX_K2G_H
 #define __ASM_ARCH_MUX_K2G_H
 
-#include <common.h>
 #include <asm/io.h>
 
 #define K2G_PADCFG_REG	(KS2_DEVICE_STATE_CTRL_BASE + 0x1000)
diff --git a/arch/arm/mach-keystone/init.c b/arch/arm/mach-keystone/init.c
index 1954e69e9f0..39afaaa63d6 100644
--- a/arch/arm/mach-keystone/init.c
+++ b/arch/arm/mach-keystone/init.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <ns16550.h>
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index efaabca5a7e..8846df3af48 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-keystone/mon.c b/arch/arm/mach-keystone/mon.c
index e91b0d68f4d..b945e19ec77 100644
--- a/arch/arm/mach-keystone/mon.c
+++ b/arch/arm/mach-keystone/mon.c
@@ -8,7 +8,6 @@
 #include <hang.h>
 #include <image.h>
 #include <asm/unaligned.h>
-#include <common.h>
 #include <command.h>
 #include <mach/mon.h>
 #include <spl.h>
diff --git a/arch/arm/mach-keystone/msmc.c b/arch/arm/mach-keystone/msmc.c
index f5cadfbf669..a20e0c98865 100644
--- a/arch/arm/mach-keystone/msmc.c
+++ b/arch/arm/mach-keystone/msmc.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <asm/arch/msmc.h>
 
 struct mpax {
diff --git a/arch/arm/mach-keystone/psc.c b/arch/arm/mach-keystone/psc.c
index 145aff8ac66..84d64f3bc40 100644
--- a/arch/arm/mach-keystone/psc.c
+++ b/arch/arm/mach-keystone/psc.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <asm/io.h>
-- 
2.39.2

