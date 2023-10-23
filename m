Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA36CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 485B88792F;
	Mon, 23 Oct 2023 15:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D378790D; Mon, 23 Oct 2023 15:25:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 04A67871C3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7721042;
 Mon, 23 Oct 2023 06:25:55 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62D073F762;
 Mon, 23 Oct 2023 06:25:13 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 08/24] pinctrl: sunxi: move PIO_BASE into sunxi_gpio.h
Date: Mon, 23 Oct 2023 14:24:33 +0100
Message-Id: <20231023132449.813863-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132449.813863-1-andre.przywara@arm.com>
References: <20231023132449.813863-1-andre.przywara@arm.com>
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

On the Allwinner platform we were describing a quite comprehensive
memory map in a per-SoC header unser arch/arm.
In the old days that was used by every driver, but nowadays it should
only be needed by SPL drivers (not using the DT). Many addresses in
there were never used, and some are not needed anymore.

To avoid a dependency on CPU specific headers in an arch specific
directory, move the definition of the pinctroller MMIO base address into
the sunxi_gpio.h header, because the SPL routines for GPIO should be the
only one needing this address.
This is a first step towards getting rid of cpu_sun[x]i.h completely,
and allows to remove the inclusion of that file from the sunxi_gpio.h
header.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h     |  2 --
 arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h |  2 --
 arch/arm/include/asm/arch-sunxi/cpu_sun9i.h     |  2 --
 include/sunxi_gpio.h                            | 12 +++++++++++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
index f7ecc790dbf..d6fe51f24bc 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
@@ -91,7 +91,6 @@
 
 #define SUNXI_CCM_BASE			0x01c20000
 #define SUNXI_INTC_BASE			0x01c20400
-#define SUNXI_PIO_BASE			0x01c20800
 #define SUNXI_TIMER_BASE		0x01c20c00
 #ifndef CONFIG_SUNXI_GEN_SUN6I
 #define SUNXI_PWM_BASE			0x01c20e00
@@ -210,7 +209,6 @@ defined(CONFIG_MACH_SUN50I)
 
 #define SUNXI_R_TWI_BASE		0x01f02400
 #define SUNXI_R_UART_BASE		0x01f02800
-#define SUNXI_R_PIO_BASE		0x01f02c00
 #define SUN6I_P2WI_BASE			0x01f03400
 #define SUNXI_RSB_BASE			0x01f03400
 
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
index d9cf8ae0428..9b6bf843601 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
@@ -22,7 +22,6 @@
 #define SUNXI_SIDC_BASE			0x03006000
 #define SUNXI_SID_BASE			0x03006200
 #define SUNXI_TIMER_BASE		0x03009000
-#define SUNXI_PIO_BASE			0x0300B000
 #define SUNXI_PSI_BASE			0x0300C000
 
 #define SUNXI_GIC400_BASE		0x03020000
@@ -68,7 +67,6 @@
 #define SUNXI_R_CPUCFG_BASE		0x07000400
 #define SUNXI_PRCM_BASE			0x07010000
 #define SUNXI_R_WDOG_BASE		0x07020400
-#define SUNXI_R_PIO_BASE		0x07022000
 #define SUNXI_R_UART_BASE		0x07080000
 #define SUNXI_R_TWI_BASE		0x07081400
 
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h b/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
index 9c2d11b5901..20025be2319 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
@@ -81,7 +81,6 @@
 /* APB0 Module */
 #define SUNXI_CCM_BASE			(REGS_APB0_BASE + 0x0000)
 #define SUNXI_CCMMODULE_BASE		(REGS_APB0_BASE + 0x0400)
-#define SUNXI_PIO_BASE			(REGS_APB0_BASE + 0x0800)
 #define SUNXI_TIMER_BASE		(REGS_APB0_BASE + 0x0C00)
 #define SUNXI_PWM_BASE			(REGS_APB0_BASE + 0x1400)
 #define SUNXI_LRADC_BASE		(REGS_APB0_BASE + 0x1800)
@@ -102,7 +101,6 @@
 /* RCPUS Module */
 #define SUNXI_PRCM_BASE			(REGS_RCPUS_BASE + 0x1400)
 #define SUNXI_R_UART_BASE		(REGS_RCPUS_BASE + 0x2800)
-#define SUNXI_R_PIO_BASE		(REGS_RCPUS_BASE + 0x2c00)
 #define SUNXI_RSB_BASE			(REGS_RCPUS_BASE + 0x3400)
 
 /* Misc. */
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index e0fb5b5da63..c1fdf7ea1d7 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -12,7 +12,17 @@
 #define _SUNXI_GPIO_H
 
 #include <linux/types.h>
-#include <asm/arch/cpu.h>
+
+#if defined(CONFIG_MACH_SUN9I)
+#define SUNXI_PIO_BASE		0x06000800
+#define SUNXI_R_PIO_BASE	0x08002c00
+#elif defined(CONFIG_SUN50I_GEN_H6)
+#define SUNXI_PIO_BASE		0x0300b000
+#define SUNXI_R_PIO_BASE	0x07022000
+#else
+#define SUNXI_PIO_BASE		0x01c20800
+#define SUNXI_R_PIO_BASE	0x01f02c00
+#endif
 
 /*
  * sunxi has 9 banks of gpio, they are:
-- 
2.25.1

