Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEBDE743C8
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C0286EBF;
	Thu, 28 Sep 2023 23:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A9D86ECF; Thu, 28 Sep 2023 23:56:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B3DBC86EBF
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4999CDA7;
 Thu, 28 Sep 2023 14:57:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 623163F59C;
 Thu, 28 Sep 2023 14:56:36 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 19/22] sunxi: refactor serial base addresses to avoid
 asm/arch/cpu.h
Date: Thu, 28 Sep 2023 22:54:52 +0100
Message-Id: <20230928215455.28094-20-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230928215455.28094-1-andre.przywara@arm.com>
References: <20230928215455.28094-1-andre.przywara@arm.com>
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

At the moment we have each SoC's memory map defined in its own cpu.h,
which is included in include/configs/sunxi_common.h. This will be a
problem with the introduction of Allwinner RISC-V support.

Remove the inclusion of that header file from the common config header,
instead move the required serial base addresses (for the SPL) into a
separate header file. Then include the original cpu.h file only where
we really need it, which is only under arch/arm now.

This disentangles the architecture specific header files from the
generic code.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv7/sunxi/sram.c               |  1 +
 arch/arm/cpu/armv8/fel_utils.S                |  1 +
 arch/arm/include/asm/arch-sunxi/boot0.h       |  2 ++
 arch/arm/include/asm/arch-sunxi/clock.h       |  1 +
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h   | 15 ---------
 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |  5 ---
 arch/arm/include/asm/arch-sunxi/cpu_sun9i.h   |  7 ----
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |  4 ---
 arch/arm/include/asm/arch-sunxi/serial.h      | 32 +++++++++++++++++++
 arch/arm/mach-sunxi/gtbus_sun9i.c             |  1 +
 arch/arm/mach-sunxi/timer.c                   |  1 +
 include/configs/sunxi-common.h                |  2 +-
 12 files changed, 40 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/serial.h

diff --git a/arch/arm/cpu/armv7/sunxi/sram.c b/arch/arm/cpu/armv7/sunxi/sram.c
index 28564c2846a..28ff6a1b7c2 100644
--- a/arch/arm/cpu/armv7/sunxi/sram.c
+++ b/arch/arm/cpu/armv7/sunxi/sram.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <init.h>
 #include <asm/io.h>
+#include <asm/arch/cpu.h>
 
 void sunxi_sram_init(void)
 {
diff --git a/arch/arm/cpu/armv8/fel_utils.S b/arch/arm/cpu/armv8/fel_utils.S
index 2fe38a1a047..939869b9ffa 100644
--- a/arch/arm/cpu/armv8/fel_utils.S
+++ b/arch/arm/cpu/armv8/fel_utils.S
@@ -10,6 +10,7 @@
 #include <config.h>
 #include <asm/system.h>
 #include <linux/linkage.h>
+#include <asm/arch/cpu.h>
 
 /*
  * We don't overwrite save_boot_params() here, to save the FEL state upon
diff --git a/arch/arm/include/asm/arch-sunxi/boot0.h b/arch/arm/include/asm/arch-sunxi/boot0.h
index 30f5680757a..cad25c50bc6 100644
--- a/arch/arm/include/asm/arch-sunxi/boot0.h
+++ b/arch/arm/include/asm/arch-sunxi/boot0.h
@@ -3,6 +3,8 @@
  * Configuration settings for the Allwinner A64 (sun50i) CPU
  */
 
+#include <asm/arch/cpu.h>
+
 #if defined(CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER) && !defined(CONFIG_SPL_BUILD)
 /* reserve space for BOOT0 header information */
 	b	reset
diff --git a/arch/arm/include/asm/arch-sunxi/clock.h b/arch/arm/include/asm/arch-sunxi/clock.h
index 3d34261b0e5..fcc8966cb0b 100644
--- a/arch/arm/include/asm/arch-sunxi/clock.h
+++ b/arch/arm/include/asm/arch-sunxi/clock.h
@@ -9,6 +9,7 @@
 #define _SUNXI_CLOCK_H
 
 #include <linux/types.h>
+#include <asm/arch/cpu.h>
 
 #define CLK_GATE_OPEN			0x1
 #define CLK_GATE_CLOSE			0x0
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
index d6fe51f24bc..3daee2f574a 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
@@ -128,20 +128,6 @@ defined(CONFIG_MACH_SUN50I)
 #define SUNXI_CPUCFG_BASE		0x01c25c00
 #endif
 
-#ifdef CONFIG_MACH_SUNIV
-#define SUNXI_UART0_BASE		0x01c25000
-#define SUNXI_UART1_BASE		0x01c25400
-#define SUNXI_UART2_BASE		0x01c25800
-#else
-#define SUNXI_UART0_BASE		0x01c28000
-#define SUNXI_UART1_BASE		0x01c28400
-#define SUNXI_UART2_BASE		0x01c28800
-#endif
-#define SUNXI_UART3_BASE		0x01c28c00
-#define SUNXI_UART4_BASE		0x01c29000
-#define SUNXI_UART5_BASE		0x01c29400
-#define SUNXI_UART6_BASE		0x01c29800
-#define SUNXI_UART7_BASE		0x01c29c00
 #define SUNXI_PS2_0_BASE		0x01c2a000
 #define SUNXI_PS2_1_BASE		0x01c2a400
 
@@ -208,7 +194,6 @@ defined(CONFIG_MACH_SUN50I)
 #endif
 
 #define SUNXI_R_TWI_BASE		0x01f02400
-#define SUNXI_R_UART_BASE		0x01f02800
 #define SUN6I_P2WI_BASE			0x01f03400
 #define SUNXI_RSB_BASE			0x01f03400
 
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
index 9b6bf843601..15ee092d358 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
@@ -42,10 +42,6 @@
 #define SUNXI_DRAM_PHY0_BASE		0x04800000
 #endif
 
-#define SUNXI_UART0_BASE		0x05000000
-#define SUNXI_UART1_BASE		0x05000400
-#define SUNXI_UART2_BASE		0x05000800
-#define SUNXI_UART3_BASE		0x05000C00
 #define SUNXI_TWI0_BASE			0x05002000
 #define SUNXI_TWI1_BASE			0x05002400
 #define SUNXI_TWI2_BASE			0x05002800
@@ -67,7 +63,6 @@
 #define SUNXI_R_CPUCFG_BASE		0x07000400
 #define SUNXI_PRCM_BASE			0x07010000
 #define SUNXI_R_WDOG_BASE		0x07020400
-#define SUNXI_R_UART_BASE		0x07080000
 #define SUNXI_R_TWI_BASE		0x07081400
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h b/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
index 20025be2319..2bf2675d5c1 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
@@ -86,12 +86,6 @@
 #define SUNXI_LRADC_BASE		(REGS_APB0_BASE + 0x1800)
 
 /* APB1 Module */
-#define SUNXI_UART0_BASE		(REGS_APB1_BASE + 0x0000)
-#define SUNXI_UART1_BASE		(REGS_APB1_BASE + 0x0400)
-#define SUNXI_UART2_BASE		(REGS_APB1_BASE + 0x0800)
-#define SUNXI_UART3_BASE		(REGS_APB1_BASE + 0x0C00)
-#define SUNXI_UART4_BASE		(REGS_APB1_BASE + 0x1000)
-#define SUNXI_UART5_BASE		(REGS_APB1_BASE + 0x1400)
 #define SUNXI_TWI0_BASE			(REGS_APB1_BASE + 0x2800)
 #define SUNXI_TWI1_BASE			(REGS_APB1_BASE + 0x2C00)
 #define SUNXI_TWI2_BASE			(REGS_APB1_BASE + 0x3000)
@@ -100,7 +94,6 @@
 
 /* RCPUS Module */
 #define SUNXI_PRCM_BASE			(REGS_RCPUS_BASE + 0x1400)
-#define SUNXI_R_UART_BASE		(REGS_RCPUS_BASE + 0x2800)
 #define SUNXI_RSB_BASE			(REGS_RCPUS_BASE + 0x3400)
 
 /* Misc. */
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index ca92c39927d..908a582ae0f 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -10,10 +10,6 @@
 #define SUNXI_CCM_BASE			0x02001000
 #define SUNXI_TIMER_BASE		0x02050000
 
-#define SUNXI_UART0_BASE		0x02500000
-#define SUNXI_UART1_BASE		0x02500400
-#define SUNXI_UART2_BASE		0x02500800
-#define SUNXI_UART3_BASE		0x02500C00
 #define SUNXI_TWI0_BASE			0x02502000
 #define SUNXI_TWI1_BASE			0x02502400
 #define SUNXI_TWI2_BASE			0x02502800
diff --git a/arch/arm/include/asm/arch-sunxi/serial.h b/arch/arm/include/asm/arch-sunxi/serial.h
new file mode 100644
index 00000000000..9386287b65e
--- /dev/null
+++ b/arch/arm/include/asm/arch-sunxi/serial.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  hardcoded UART base addresses for early SPL use
+ *
+ *  Copyright (c) 2022  Arm Ltd.
+ */
+
+#ifndef SUNXI_SERIAL_MEMMAP_H
+#define SUNXI_SERIAL_MEMMAP_H
+
+#if defined(CONFIG_MACH_SUN9I)
+#define SUNXI_UART0_BASE		0x07000000
+#define SUNXI_R_UART_BASE		0x08002800
+#elif defined(CONFIG_SUN50I_GEN_H6)
+#define SUNXI_UART0_BASE		0x05000000
+#define SUNXI_R_UART_BASE		0x07080000
+#elif defined(CONFIG_MACH_SUNIV)
+#define SUNXI_UART0_BASE		0x01c25000
+#define SUNXI_R_UART_BASE		0
+#elif defined(CONFIG_SUNXI_GEN_NCAT2)
+#define SUNXI_UART0_BASE		0x02500000
+#define SUNXI_R_UART_BASE		0		// 0x07080000 (?>
+#else
+#define SUNXI_UART0_BASE		0x01c28000
+#define SUNXI_R_UART_BASE		0x01f02800
+#endif
+
+#define SUNXI_UART1_BASE		(SUNXI_UART0_BASE + 0x400)
+#define SUNXI_UART2_BASE		(SUNXI_UART0_BASE + 0x800)
+#define SUNXI_UART3_BASE		(SUNXI_UART0_BASE + 0xc00)
+
+#endif /* SUNXI_SERIAL_MEMMAP_H */
diff --git a/arch/arm/mach-sunxi/gtbus_sun9i.c b/arch/arm/mach-sunxi/gtbus_sun9i.c
index cf011c4cfa7..5624621b500 100644
--- a/arch/arm/mach-sunxi/gtbus_sun9i.c
+++ b/arch/arm/mach-sunxi/gtbus_sun9i.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <asm/io.h>
+#include <asm/arch/cpu.h>
 #include <asm/arch/gtbus_sun9i.h>
 #include <asm/arch/sys_proto.h>
 
diff --git a/arch/arm/mach-sunxi/timer.c b/arch/arm/mach-sunxi/timer.c
index fc9d419a25e..9a6f6c06d8c 100644
--- a/arch/arm/mach-sunxi/timer.c
+++ b/arch/arm/mach-sunxi/timer.c
@@ -10,6 +10,7 @@
 #include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/arch/cpu.h>
 #include <asm/arch/timer.h>
 #include <linux/delay.h>
 
diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
index d2d70f0fc23..b8ca77d031d 100644
--- a/include/configs/sunxi-common.h
+++ b/include/configs/sunxi-common.h
@@ -12,7 +12,6 @@
 #ifndef _SUNXI_COMMON_CONFIG_H
 #define _SUNXI_COMMON_CONFIG_H
 
-#include <asm/arch/cpu.h>
 #include <linux/stringify.h>
 
 /* Serial & console */
@@ -24,6 +23,7 @@
 #define CFG_SYS_NS16550_CLK		24000000
 #endif
 #if !CONFIG_IS_ENABLED(DM_SERIAL)
+#include <asm/arch/serial.h>
 # define CFG_SYS_NS16550_COM1		SUNXI_UART0_BASE
 # define CFG_SYS_NS16550_COM2		SUNXI_UART1_BASE
 # define CFG_SYS_NS16550_COM3		SUNXI_UART2_BASE
-- 
2.35.8

