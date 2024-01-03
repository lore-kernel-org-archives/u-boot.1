Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E253C46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9681E8796B;
	Wed,  3 Jan 2024 01:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8366C87990; Wed,  3 Jan 2024 01:13:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 75F5B87950
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14EE21516;
 Tue,  2 Jan 2024 16:14:18 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2751B3F5A1;
 Tue,  2 Jan 2024 16:13:31 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 02/19] sunxi: sun50i-h6: remove unneeded base addresses from
 header
Date: Wed,  3 Jan 2024 00:12:22 +0000
Message-Id: <20240103001239.17482-3-andre.przywara@arm.com>
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

The cpu_sun50i_h6.h header file defined the base addresses for quite some
peripherals of the Allwinner H6 and related CPUs, even though we now only
use a fraction of that.
Most of the addresses are now either read from the DT, or were never used
in U-Boot in the first place.

Removed the ones that are not used in the whole of the U-Boot source.
to make it clear that this file only contains addresses that are needed
for the SPL operation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
index 15ee092d358..8a3f465545a 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
@@ -7,25 +7,14 @@
 #ifndef _SUNXI_CPU_SUN50I_H6_H
 #define _SUNXI_CPU_SUN50I_H6_H
 
-#define SUNXI_SRAM_A1_BASE		CONFIG_SUNXI_SRAM_ADDRESS
-#define SUNXI_SRAM_C_BASE		0x00028000
-#define SUNXI_SRAM_A2_BASE		0x00100000
-
-#define SUNXI_DE3_BASE			0x01000000
-#define SUNXI_SS_BASE			0x01904000
-#define SUNXI_EMCE_BASE			0x01905000
-
 #define SUNXI_SRAMC_BASE		0x03000000
 #define SUNXI_CCM_BASE			0x03001000
-#define SUNXI_DMA_BASE			0x03002000
 /* SID address space starts at 0x03006000, but e-fuse is at offset 0x200 */
 #define SUNXI_SIDC_BASE			0x03006000
 #define SUNXI_SID_BASE			0x03006200
 #define SUNXI_TIMER_BASE		0x03009000
-#define SUNXI_PSI_BASE			0x0300C000
 
 #define SUNXI_GIC400_BASE		0x03020000
-#define SUNXI_IOMMU_BASE		0x030F0000
 
 #ifdef CONFIG_MACH_SUN50I_H6
 #define SUNXI_DRAM_COM_BASE		0x04002000
@@ -46,18 +35,8 @@
 #define SUNXI_TWI1_BASE			0x05002400
 #define SUNXI_TWI2_BASE			0x05002800
 #define SUNXI_TWI3_BASE			0x05002C00
-#define SUNXI_SPI0_BASE			0x05010000
-#define SUNXI_SPI1_BASE			0x05011000
-#define SUNXI_GMAC_BASE			0x05020000
-#define SUNXI_USB0_BASE			0x05100000
-#define SUNXI_XHCI_BASE			0x05200000
-#define SUNXI_USB3_BASE			0x05311000
-#define SUNXI_PCIE_BASE			0x05400000
 
 #define SUNXI_HDMI_BASE			0x06000000
-#define SUNXI_TCON_TOP_BASE		0x06510000
-#define SUNXI_TCON_LCD0_BASE		0x06511000
-#define SUNXI_TCON_TV0_BASE		0x06515000
 
 #define SUNXI_RTC_BASE			0x07000000
 #define SUNXI_R_CPUCFG_BASE		0x07000400
-- 
2.35.8

