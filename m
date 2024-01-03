Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C212C46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057D0879A9;
	Wed,  3 Jan 2024 01:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD02B8795C; Wed,  3 Jan 2024 01:13:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 854448796B
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DC4C152B;
 Tue,  2 Jan 2024 16:14:19 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 331923F5A1;
 Tue,  2 Jan 2024 16:13:32 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 03/19] sunxi: sun4i: remove unneeded base addresses from header
Date: Wed,  3 Jan 2024 00:12:23 +0000
Message-Id: <20240103001239.17482-4-andre.przywara@arm.com>
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

The cpu_sun4i.h header file defined the base addresses for quite some
peripherals of earlier Allwinner CPUs, even though we now only use a
fraction of that.
Most of the addresses are now either read from the DT, or were never
used in U-Boot in the first place.

Removed the ones that are not used in the whole of the U-Boot source.
to make it clear that this file only contains addresses that are needed
for the SPL operation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h | 47 ---------------------
 1 file changed, 47 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
index 3daee2f574a..f023a4cfd93 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
@@ -36,58 +36,20 @@
 
 #define SUNXI_SRAMC_BASE		0x01c00000
 #define SUNXI_DRAMC_BASE		0x01c01000
-#define SUNXI_DMA_BASE			0x01c02000
 #define SUNXI_NFC_BASE			0x01c03000
-#define SUNXI_TS_BASE			0x01c04000
-#define SUNXI_SPI0_BASE			0x01c05000
-#define SUNXI_SPI1_BASE			0x01c06000
-#define SUNXI_MS_BASE			0x01c07000
-#define SUNXI_TVD_BASE			0x01c08000
-#define SUNXI_CSI0_BASE			0x01c09000
 #ifndef CONFIG_MACH_SUNXI_H3_H5
 #define SUNXI_TVE0_BASE			0x01c0a000
 #endif
-#define SUNXI_EMAC_BASE			0x01c0b000
 #define SUNXI_LCD0_BASE			0x01c0C000
 #define SUNXI_LCD1_BASE			0x01c0d000
-#define SUNXI_VE_BASE			0x01c0e000
 #define SUNXI_MMC0_BASE			0x01c0f000
 #define SUNXI_MMC1_BASE			0x01c10000
 #define SUNXI_MMC2_BASE			0x01c11000
 #define SUNXI_MMC3_BASE			0x01c12000
-#ifdef CONFIG_SUNXI_GEN_SUN4I
-#define SUNXI_USB0_BASE			0x01c13000
-#define SUNXI_USB1_BASE			0x01c14000
-#endif
 #define SUNXI_SS_BASE			0x01c15000
 #if !defined(CONFIG_MACH_SUNXI_H3_H5) && !defined(CONFIG_MACH_SUN50I)
 #define SUNXI_HDMI_BASE			0x01c16000
 #endif
-#define SUNXI_SPI2_BASE			0x01c17000
-#define SUNXI_SATA_BASE			0x01c18000
-#ifdef CONFIG_SUNXI_GEN_SUN4I
-#define SUNXI_PATA_BASE			0x01c19000
-#define SUNXI_ACE_BASE			0x01c1a000
-#define SUNXI_TVE1_BASE			0x01c1b000
-#define SUNXI_USB2_BASE			0x01c1c000
-#endif
-#ifdef CONFIG_SUNXI_GEN_SUN6I
-#if defined(CONFIG_MACH_SUNXI_H3_H5) || defined(CONFIG_MACH_SUN50I)
-#define SUNXI_USBPHY_BASE		0x01c19000
-#define SUNXI_USB0_BASE			SUNXI_USBPHY_BASE
-#define SUNXI_USB1_BASE			0x01c1a000
-#define SUNXI_USB2_BASE			0x01c1b000
-#define SUNXI_USB3_BASE			0x01c1c000
-#define SUNXI_USB4_BASE			0x01c1d000
-#else
-#define SUNXI_USB0_BASE			0x01c19000
-#define SUNXI_USB1_BASE			0x01c1a000
-#define SUNXI_USB2_BASE			0x01c1b000
-#endif
-#endif
-#define SUNXI_CSI1_BASE			0x01c1d000
-#define SUNXI_TZASC_BASE		0x01c1e000
-#define SUNXI_SPI3_BASE			0x01c1f000
 
 #define SUNXI_CCM_BASE			0x01c20000
 #define SUNXI_INTC_BASE			0x01c20400
@@ -177,8 +139,6 @@ defined(CONFIG_MACH_SUN50I)
 #else
 #define SUNXI_TVE0_BASE			0x01e40000
 #endif
-#define SUNXI_MP_BASE			0x01e80000
-#define SUNXI_AVG_BASE			0x01ea0000
 
 #if defined(CONFIG_MACH_SUNXI_H3_H5) || defined(CONFIG_MACH_SUN50I)
 #define SUNXI_HDMI_BASE			0x01ee0000
@@ -197,13 +157,6 @@ defined(CONFIG_MACH_SUN50I)
 #define SUN6I_P2WI_BASE			0x01f03400
 #define SUNXI_RSB_BASE			0x01f03400
 
-/* CoreSight Debug Module */
-#define SUNXI_CSDM_BASE			0x3f500000
-
-#define SUNXI_DDRII_DDRIII_BASE		0x40000000	/* 2 GiB */
-
-#define SUNXI_BROM_BASE			0xffff0000	/* 32 kiB */
-
 #define SUNXI_CPU_CFG			(SUNXI_TIMER_BASE + 0x13c)
 
 /* SS bonding ids used for cpu identification */
-- 
2.35.8

