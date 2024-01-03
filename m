Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0197CC47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9B6879B3;
	Wed,  3 Jan 2024 01:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7596879A0; Wed,  3 Jan 2024 01:13:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 91C5A87927
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29712153B;
 Tue,  2 Jan 2024 16:14:20 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ECFA3F5A1;
 Tue,  2 Jan 2024 16:13:33 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 04/19] sunxi: sun9i: remove unneeded base addresses from header
Date: Wed,  3 Jan 2024 00:12:24 +0000
Message-Id: <20240103001239.17482-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

The cpu_sun9i.h header file defined the base addresses for quite some
peripherals of the Allwinner A80 CPU, even though we now only use a
fraction of that.
Most of the addresses are now either read from the DT, or were never
used in U-Boot in the first place.

Removed the ones that are not used in the whole of the U-Boot source.
to make it clear that this file only contains addresses that are needed
for the SPL operation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/cpu_sun9i.h | 41 ---------------------
 1 file changed, 41 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h b/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
index 2bf2675d5c1..73de4707c16 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun9i.h
@@ -20,7 +20,6 @@
 
 /* AHB0 Module */
 #define SUNXI_NFC_BASE			(REGS_AHB0_BASE + 0x3000)
-#define SUNXI_TSC_BASE			(REGS_AHB0_BASE + 0x4000)
 
 #define SUNXI_GTBUS_BASE		(REGS_AHB0_BASE + 0x9000)
 /* SID address space starts at 0x01ce000, but e-fuse is at offset 0x200 */
@@ -32,14 +31,7 @@
 #define SUNXI_MMC3_BASE			(REGS_AHB0_BASE + 0x12000)
 #define SUNXI_MMC_COMMON_BASE		(REGS_AHB0_BASE + 0x13000)
 
-#define SUNXI_SPI0_BASE			(REGS_AHB0_BASE + 0x1A000)
-#define SUNXI_SPI1_BASE			(REGS_AHB0_BASE + 0x1B000)
-#define SUNXI_SPI2_BASE			(REGS_AHB0_BASE + 0x1C000)
-#define SUNXI_SPI3_BASE			(REGS_AHB0_BASE + 0x1D000)
-
 #define SUNXI_GIC400_BASE		(REGS_AHB0_BASE + 0x40000)
-#define SUNXI_ARMA9_GIC_BASE		(REGS_AHB0_BASE + 0x41000)
-#define SUNXI_ARMA9_CPUIF_BASE		(REGS_AHB0_BASE + 0x42000)
 
 #define SUNXI_DRAM_COM_BASE		(REGS_AHB0_BASE + 0x62000)
 #define SUNXI_DRAM_CTL0_BASE		(REGS_AHB0_BASE + 0x63000)
@@ -47,59 +39,26 @@
 #define SUNXI_DRAM_PHY0_BASE		(REGS_AHB0_BASE + 0x65000)
 #define SUNXI_DRAM_PHY1_BASE		(REGS_AHB0_BASE + 0x66000)
 
-/* AHB1 Module */
-#define SUNXI_DMA_BASE			(REGS_AHB1_BASE + 0x002000)
-#define SUNXI_USBOTG_BASE		(REGS_AHB1_BASE + 0x100000)
-#define SUNXI_USBEHCI0_BASE		(REGS_AHB1_BASE + 0x200000)
-#define SUNXI_USBEHCI1_BASE		(REGS_AHB1_BASE + 0x201000)
-#define SUNXI_USBEHCI2_BASE		(REGS_AHB1_BASE + 0x202000)
-
-/* AHB2 Module */
-#define SUNXI_DE_SYS_BASE		(REGS_AHB2_BASE + 0x000000)
-#define SUNXI_DISP_SYS_BASE		(REGS_AHB2_BASE + 0x010000)
 #define SUNXI_DE_FE0_BASE		(REGS_AHB2_BASE + 0x100000)
-#define SUNXI_DE_FE1_BASE		(REGS_AHB2_BASE + 0x140000)
-#define SUNXI_DE_FE2_BASE		(REGS_AHB2_BASE + 0x180000)
-
 #define SUNXI_DE_BE0_BASE		(REGS_AHB2_BASE + 0x200000)
-#define SUNXI_DE_BE1_BASE		(REGS_AHB2_BASE + 0x240000)
-#define SUNXI_DE_BE2_BASE		(REGS_AHB2_BASE + 0x280000)
-
-#define SUNXI_DE_DEU0_BASE		(REGS_AHB2_BASE + 0x300000)
-#define SUNXI_DE_DEU1_BASE		(REGS_AHB2_BASE + 0x340000)
-#define SUNXI_DE_DRC0_BASE		(REGS_AHB2_BASE + 0x400000)
-#define SUNXI_DE_DRC1_BASE		(REGS_AHB2_BASE + 0x440000)
-
 #define SUNXI_LCD0_BASE			(REGS_AHB2_BASE + 0xC00000)
 #define SUNXI_LCD1_BASE			(REGS_AHB2_BASE + 0xC10000)
 #define SUNXI_LCD2_BASE			(REGS_AHB2_BASE + 0xC20000)
-#define SUNXI_MIPI_DSI0_BASE		(REGS_AHB2_BASE + 0xC40000)
-/* Also seen as SUNXI_MIPI_DSI0_DPHY_BASE 0x01ca1000 */
-#define SUNXI_MIPI_DSI0_DPHY_BASE	(REGS_AHB2_BASE + 0xC40100)
 #define SUNXI_HDMI_BASE			(REGS_AHB2_BASE + 0xD00000)
 
 /* APB0 Module */
 #define SUNXI_CCM_BASE			(REGS_APB0_BASE + 0x0000)
-#define SUNXI_CCMMODULE_BASE		(REGS_APB0_BASE + 0x0400)
 #define SUNXI_TIMER_BASE		(REGS_APB0_BASE + 0x0C00)
 #define SUNXI_PWM_BASE			(REGS_APB0_BASE + 0x1400)
-#define SUNXI_LRADC_BASE		(REGS_APB0_BASE + 0x1800)
 
 /* APB1 Module */
 #define SUNXI_TWI0_BASE			(REGS_APB1_BASE + 0x2800)
 #define SUNXI_TWI1_BASE			(REGS_APB1_BASE + 0x2C00)
-#define SUNXI_TWI2_BASE			(REGS_APB1_BASE + 0x3000)
-#define SUNXI_TWI3_BASE			(REGS_APB1_BASE + 0x3400)
-#define SUNXI_TWI4_BASE			(REGS_APB1_BASE + 0x3800)
 
 /* RCPUS Module */
 #define SUNXI_PRCM_BASE			(REGS_RCPUS_BASE + 0x1400)
 #define SUNXI_RSB_BASE			(REGS_RCPUS_BASE + 0x3400)
 
-/* Misc. */
-#define SUNXI_BROM_BASE			0xFFFF0000 /* 32K */
-#define SUNXI_CPU_CFG			(SUNXI_TIMER_BASE + 0x13c)
-
 #ifndef __ASSEMBLY__
 void sunxi_board_init(void);
 void sunxi_reset(void);
-- 
2.35.8

