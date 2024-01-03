Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9456DC46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD3187980;
	Wed,  3 Jan 2024 01:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB6C878D3; Wed,  3 Jan 2024 01:13:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6803E87927
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0648614BF;
 Tue,  2 Jan 2024 16:14:17 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B7583F5A1;
 Tue,  2 Jan 2024 16:13:29 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 01/19] sunxi: cleanup sunxi-common.h
Date: Wed,  3 Jan 2024 00:12:21 +0000
Message-Id: <20240103001239.17482-2-andre.przywara@arm.com>
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

The sunxi-common.h configs header used to contain a lot of random
Allwinner platform related constants, but over the years we moved a lot
of those definitions out there.

Clean up the file to remove outdated comments which are leftovers from
the olden days. Also remove the definition of LOW_LEVEL_SRAM_STACK,
which is actually used nowhere in the whole source tree.

This also uses the opportunity to add some section comments that helps
structuring the header file and improving readability.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/configs/sunxi-common.h | 56 ++++++++--------------------------
 1 file changed, 12 insertions(+), 44 deletions(-)

diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
index b8ca77d031d..b29a25d5617 100644
--- a/include/configs/sunxi-common.h
+++ b/include/configs/sunxi-common.h
@@ -14,8 +14,9 @@
 
 #include <linux/stringify.h>
 
-/* Serial & console */
-/* ns16550 reg in the low bits of cpu reg */
+/****************************************************************************
+ *                  base addresses for the SPL UART driver                  *
+ ****************************************************************************/
 #ifdef CONFIG_MACH_SUNIV
 /* suniv doesn't have apb2 and uart is connected to apb1 */
 #define CFG_SYS_NS16550_CLK		100000000
@@ -31,8 +32,9 @@
 # define CFG_SYS_NS16550_COM5		SUNXI_R_UART_BASE
 #endif
 
-/* CPU */
-
+/****************************************************************************
+ *                             DRAM base address                            *
+ ****************************************************************************/
 /*
  * The DRAM Base differs between some models. We cannot use macros for the
  * CONFIG_FOO defines which contain the DRAM base address since they end
@@ -52,16 +54,6 @@
 /* V3s do not have enough memory to place code at 0x4a000000 */
 #endif
 
-/*
- * The A80's A1 sram starts at 0x00010000 rather then at 0x00000000 and is
- * slightly bigger. Note that it is possible to map the first 32 KiB of the
- * A1 at 0x00000000 like with older SoCs by writing 0x16aa0001 to the
- * undocumented 0x008000e0 SYS_CTRL register. Where the 16aa is a key and
- * the 1 actually activates the mapping of the first 32 KiB to 0x00000000.
- * A64 and H5 also has SRAM A1 at 0x00010000, but no magic remap register
- * is known yet.
- * H6 has SRAM A1 at 0x00020000.
- */
 #define CFG_SYS_INIT_RAM_ADDR	CONFIG_SUNXI_SRAM_ADDRESS
 /* FIXME: this may be larger on some SoCs */
 #define CFG_SYS_INIT_RAM_SIZE	0x8000 /* 32 KiB */
@@ -69,36 +61,13 @@
 #define PHYS_SDRAM_0			CFG_SYS_SDRAM_BASE
 #define PHYS_SDRAM_0_SIZE		0x80000000 /* 2 GiB */
 
-/*
- * Miscellaneous configurable options
- */
-
-/* FLASH and environment organization */
-
+/****************************************************************************
+ *           environment variables holding default load addresses           *
+ ****************************************************************************/
 /*
  * We cannot use expressions here, because expressions won't be evaluated in
  * autoconf.mk.
  */
-#if CONFIG_SUNXI_SRAM_ADDRESS == 0x10000
-#ifdef CONFIG_ARM64
-/* end of SRAM A2 for now, as SRAM A1 is pretty tight for an ARM64 build */
-#define LOW_LEVEL_SRAM_STACK		0x00054000
-#else
-#define LOW_LEVEL_SRAM_STACK		0x00018000
-#endif /* !CONFIG_ARM64 */
-#elif CONFIG_SUNXI_SRAM_ADDRESS == 0x20000
-#ifdef CONFIG_MACH_SUN50I_H616
-#define LOW_LEVEL_SRAM_STACK		0x52a00		/* below FEL buffers */
-#else
-/* end of SRAM A2 on H6 for now */
-#define LOW_LEVEL_SRAM_STACK		0x00118000
-#endif
-#else
-#define LOW_LEVEL_SRAM_STACK		0x00008000	/* End of sram */
-#endif
-
-/* Ethernet support */
-
 #ifdef CONFIG_ARM64
 /*
  * Boards seem to come with at least 512MB of DRAM.
@@ -174,15 +143,11 @@
 	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0"
 
 #ifdef CONFIG_ARM64
-
 #define MEM_LAYOUT_ENV_EXTRA_SETTINGS \
 	"kernel_comp_addr_r=" KERNEL_COMP_ADDR_R "\0" \
 	"kernel_comp_size=" KERNEL_COMP_SIZE "\0"
-
 #else
-
 #define MEM_LAYOUT_ENV_EXTRA_SETTINGS ""
-
 #endif
 
 #define DFU_ALT_INFO_RAM \
@@ -191,6 +156,9 @@
 	"fdt ram " FDT_ADDR_R " 0x100000;" \
 	"ramdisk ram " RAMDISK_ADDR_R " 0x4000000\0"
 
+/****************************************************************************
+ *                  definitions for the distro boot system                  *
+ ****************************************************************************/
 #ifdef CONFIG_MMC
 #if CONFIG_MMC_SUNXI_SLOT_EXTRA != -1
 #define BOOTENV_DEV_MMC_AUTO(devtypeu, devtypel, instance)		\
-- 
2.35.8

