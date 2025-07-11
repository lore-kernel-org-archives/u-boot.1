Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E05C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55828304C;
	Fri, 11 Jul 2025 17:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mfCElFgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A3583082; Fri, 11 Jul 2025 17:20:02 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75648304C
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c172f1de1so1084210a34.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247199; x=1752851999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jeyknYCFCcJG6gGjMxxpAwI4uOtxCel22NV5sS5svBY=;
 b=mfCElFggDr+55PQpnr7vwWxrvFSUK4w3BgsBTumiL2RMHsxvpFCSMZTBt47pYzKktv
 X6NCLYbFWtY19ARMBiL7F4OmM48HzrPayb0EZI/7shuopXq0G2MXkq1VeHuyswkdIaqW
 uNJnVoD0b2VwLL/khM+fdm2DlwVoEjlSkVbNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247199; x=1752851999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jeyknYCFCcJG6gGjMxxpAwI4uOtxCel22NV5sS5svBY=;
 b=qoayYW0XhiZ3tQT4H7hHzYqKecRLYaGcu8IV0ElDZAgFelQSca5y5FoD4iI5dCuvUT
 itGXairVOl2vp7a4PURr3ihEVVO6WnLSQZkXdY1mRBURYPf9FNVsvQuyy1EOY9D3zi3J
 L6RJgt3vXjrMDppzH4D+Mw3fURhFW3Go00Dv2fnrVK5JbfjmHfS58zmdLFl460vztJhN
 qvbqLYgu70pyfgH0mdGZaVrMlWgkmtvdv/aVUj1/MvBgWrnsSPD6/BIUS3fpEMpl3pYL
 c+CyFa3wY2oGvhsEJM6f/6Sca1kKQ83QwyFq9NKZSgxkPW2fJFFttaIZlBIjiwnCba2K
 4JgQ==
X-Gm-Message-State: AOJu0YyBf+EpXrwaad3TAarP3qx7Zn48kM4m6MkE4/CeXuvROBPX2twa
 oLNGywsNeqSImA0VGlLmJhRSF6o8rMmDGAik5PMr3d/N/QyqyuVHWr1dJ37JP6sP3evJHmzpzKl
 lqc+tyVk=
X-Gm-Gg: ASbGncukl62VIG0J6FJ6FpyKLYfTYQFtZ2LnUX3hAMqdXu7KC2LiawIGVyu2alKfrYy
 XIm4JKeqyM9jB441LpxPncWtmO4ZtI/dooQ7u4H7AYxt8uZfGOft0vKZoYSK9MNpT3E/mgQzetZ
 sc2BFc1qMMJ1M1wBwqyrulSqI9LZ/9an/78wDf/bRu1ThYouYiBeP0yKNnnZKpkFfBKVjh+xlIa
 PBfdgXqsvVx7WBQXzEiGfdXQObB104qmjLxhLEBARvQABR9RLpAmi2jbL5GYo0mwZRm+nssusPd
 gX4+cf81hi7Y/BS2jvSAfJgFzwSIrBSTLqW8qrjcIXPjPoTOaYb6gaVaJC1DjJ5CL1RPD6BTHxn
 9OmPGQwau0C5e8KmtT3KaVd509YY4+tSFdSpkleKJfYaVSPcQEfQOBCEIig4=
X-Google-Smtp-Source: AGHT+IGKMfLA3ZTMGA2DSW5R+oqApUCIGT46RY1Z5Gbm64Bems6p2L4bUZuEhAy2RZfm9rMLaOS2KA==
X-Received: by 2002:a05:6830:4990:b0:73b:26ed:237 with SMTP id
 46e09a7af769-73cfb261cc0mr2528378a34.28.1752247198343; 
 Fri, 11 Jul 2025 08:19:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12a634fsm590949a34.51.2025.07.11.08.19.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:19:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mtd: nand: raw: Remove unused lpc32xx_nand_slc driver
Date: Fri, 11 Jul 2025 09:19:57 -0600
Message-ID: <20250711151957.2225373-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As no platforms use this driver anymore let's go ahead and remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/arch-lpc32xx/config.h |  19 -
 drivers/mtd/nand/raw/Kconfig               |   9 +-
 drivers/mtd/nand/raw/Makefile              |   1 -
 drivers/mtd/nand/raw/lpc32xx_nand_slc.c    | 587 ---------------------
 4 files changed, 2 insertions(+), 614 deletions(-)
 delete mode 100644 drivers/mtd/nand/raw/lpc32xx_nand_slc.c

diff --git a/arch/arm/include/asm/arch-lpc32xx/config.h b/arch/arm/include/asm/arch-lpc32xx/config.h
index b2d87524f709..e4005b94b543 100644
--- a/arch/arm/include/asm/arch-lpc32xx/config.h
+++ b/arch/arm/include/asm/arch-lpc32xx/config.h
@@ -17,25 +17,6 @@
 #define CFG_SYS_BAUDRATE_TABLE	\
 		{ 9600, 19200, 38400, 57600, 115200, 230400, 460800 }
 
-/* NAND */
-#if defined(CONFIG_NAND_LPC32XX_SLC)
-#define NAND_LARGE_BLOCK_PAGE_SIZE	0x800
-#define NAND_SMALL_BLOCK_PAGE_SIZE	0x200
-
-#if (CONFIG_SYS_NAND_PAGE_SIZE == NAND_LARGE_BLOCK_PAGE_SIZE)
-#define CFG_SYS_NAND_ECCPOS		{ 40, 41, 42, 43, 44, 45, 46, 47, \
-					  48, 49, 50, 51, 52, 53, 54, 55, \
-					  56, 57, 58, 59, 60, 61, 62, 63, }
-#elif (CONFIG_SYS_NAND_PAGE_SIZE == NAND_SMALL_BLOCK_PAGE_SIZE)
-#define CFG_SYS_NAND_ECCPOS		{ 10, 11, 12, 13, 14, 15, }
-#else
-#error "CONFIG_SYS_NAND_PAGE_SIZE set to an invalid value"
-#endif
-
-#define CFG_SYS_NAND_ECCSIZE		0x100
-#define CFG_SYS_NAND_ECCBYTES	3
-#endif	/* CONFIG_NAND_LPC32XX_SLC */
-
 /* NOR Flash */
 
 /* USB OHCI */
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index c9b4450aafa1..3ca6d1cca812 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -260,11 +260,6 @@ config NAND_LPC32XX_MLC
 	help
 	  Enable the LPC32XX MLC NAND controller.
 
-config NAND_LPC32XX_SLC
-	bool "Support LPC32XX_SLC controller"
-	help
-	  Enable the LPC32XX SLC NAND controller.
-
 config NAND_OMAP_GPMC
 	bool "Support OMAP GPMC NAND controller"
 	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3
@@ -683,7 +678,7 @@ config SYS_NAND_ONFI_DETECTION
 
 config SYS_NAND_PAGE_SIZE
 	hex "NAND chip page size"
-	depends on ARCH_SUNXI || NAND_OMAP_GPMC || NAND_LPC32XX_SLC || \
+	depends on ARCH_SUNXI || NAND_OMAP_GPMC || \
 		SPL_NAND_SIMPLE || (NAND_MXC && SPL_NAND_SUPPORT) || \
 		MVEBU_SPL_BOOT_DEVICE_NAND || \
 		(NAND_ATMEL && SPL_NAND_SUPPORT) || \
@@ -694,7 +689,7 @@ config SYS_NAND_PAGE_SIZE
 
 config SYS_NAND_OOBSIZE
 	hex "NAND chip OOB size"
-	depends on ARCH_SUNXI || NAND_OMAP_GPMC || NAND_LPC32XX_SLC || \
+	depends on ARCH_SUNXI || NAND_OMAP_GPMC || \
 		SPL_NAND_SIMPLE || (NAND_MXC && SPL_NAND_SUPPORT) || \
 		(NAND_ATMEL && SPL_NAND_SUPPORT) || SPL_GENERATE_ATMEL_PMECC_HEADER
 	help
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 34cba77046a1..97e874ef769d 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -61,7 +61,6 @@ obj-$(CONFIG_NAND_FSL_IFC) += fsl_ifc_nand.o
 obj-$(CONFIG_NAND_KIRKWOOD) += kirkwood_nand.o
 obj-$(CONFIG_NAND_KMETER1) += kmeter1_nand.o
 obj-$(CONFIG_NAND_LPC32XX_MLC) += lpc32xx_nand_mlc.o
-obj-$(CONFIG_NAND_LPC32XX_SLC) += lpc32xx_nand_slc.o
 obj-$(CONFIG_NAND_VF610_NFC) += vf610_nfc.o
 obj-$(CONFIG_NAND_MESON) += meson_nand.o
 obj-$(CONFIG_NAND_MXC) += mxc_nand.o
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
deleted file mode 100644
index 109c31fb4d10..000000000000
--- a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
+++ /dev/null
@@ -1,587 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * LPC32xx SLC NAND flash controller driver
- *
- * (C) Copyright 2015-2018 Vladimir Zapolskiy <vz@mleia.com>
- * Copyright (c) 2015 Tyco Fire Protection Products.
- *
- * Hardware ECC support original source code
- * Copyright (C) 2008 by NXP Semiconductors
- * Author: Kevin Wells
- */
-
-#include <config.h>
-#include <log.h>
-#include <nand.h>
-#include <linux/bug.h>
-#include <linux/mtd/nand_ecc.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/errno.h>
-#include <asm/io.h>
-#include <asm/arch/config.h>
-#include <asm/arch/clk.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/arch/dma.h>
-#include <asm/arch/cpu.h>
-#include <linux/printk.h>
-
-struct lpc32xx_nand_slc_regs {
-	u32 data;
-	u32 addr;
-	u32 cmd;
-	u32 stop;
-	u32 ctrl;
-	u32 cfg;
-	u32 stat;
-	u32 int_stat;
-	u32 ien;
-	u32 isr;
-	u32 icr;
-	u32 tac;
-	u32 tc;
-	u32 ecc;
-	u32 dma_data;
-};
-
-/* CFG register */
-#define CFG_CE_LOW		(1 << 5)
-#define CFG_DMA_ECC		(1 << 4) /* Enable DMA ECC bit */
-#define CFG_ECC_EN		(1 << 3) /* ECC enable bit */
-#define CFG_DMA_BURST		(1 << 2) /* DMA burst bit */
-#define CFG_DMA_DIR		(1 << 1) /* DMA write(0)/read(1) bit */
-
-/* CTRL register */
-#define CTRL_SW_RESET		(1 << 2)
-#define CTRL_ECC_CLEAR		(1 << 1) /* Reset ECC bit */
-#define CTRL_DMA_START		(1 << 0) /* Start DMA channel bit */
-
-/* STAT register */
-#define STAT_DMA_FIFO		(1 << 2) /* DMA FIFO has data bit */
-#define STAT_NAND_READY		(1 << 0)
-
-/* INT_STAT register */
-#define INT_STAT_TC		(1 << 1)
-#define INT_STAT_RDY		(1 << 0)
-
-/* TAC register bits, be aware of overflows */
-#define TAC_W_RDY(n)		(max_t(uint32_t, (n), 0xF) << 28)
-#define TAC_W_WIDTH(n)		(max_t(uint32_t, (n), 0xF) << 24)
-#define TAC_W_HOLD(n)		(max_t(uint32_t, (n), 0xF) << 20)
-#define TAC_W_SETUP(n)		(max_t(uint32_t, (n), 0xF) << 16)
-#define TAC_R_RDY(n)		(max_t(uint32_t, (n), 0xF) << 12)
-#define TAC_R_WIDTH(n)		(max_t(uint32_t, (n), 0xF) << 8)
-#define TAC_R_HOLD(n)		(max_t(uint32_t, (n), 0xF) << 4)
-#define TAC_R_SETUP(n)		(max_t(uint32_t, (n), 0xF) << 0)
-
-/* NAND ECC Layout for small page NAND devices
- * Note: For large page devices, the default layouts are used. */
-static struct nand_ecclayout lpc32xx_nand_oob_16 = {
-	.eccbytes = 6,
-	.eccpos = { 10, 11, 12, 13, 14, 15, },
-	.oobfree = {
-		{ .offset = 0, .length = 4, },
-		{ .offset = 6, .length = 4, },
-	}
-};
-
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
-#define ECCSTEPS	(CONFIG_SYS_NAND_PAGE_SIZE / CFG_SYS_NAND_ECCSIZE)
-
-/*
- * DMA Descriptors
- * For Large Block: 17 descriptors = ((16 Data and ECC Read) + 1 Spare Area)
- * For Small Block: 5 descriptors = ((4 Data and ECC Read) + 1 Spare Area)
- */
-static struct lpc32xx_dmac_ll dmalist[ECCSTEPS * 2 + 1];
-static u32 ecc_buffer[8]; /* MAX ECC size */
-static unsigned int dmachan = (unsigned int)-1; /* Invalid channel */
-
-/*
- * Helper macro for the DMA client (i.e. NAND SLC):
- * - to write the next DMA linked list item address
- *   (see arch/include/asm/arch-lpc32xx/dma.h).
- * - to assign the DMA data register to DMA source or destination address.
- * - to assign the ECC register to DMA source or destination address.
- */
-#define lpc32xx_dmac_next_lli(x)	((u32)x)
-#define lpc32xx_dmac_set_dma_data()	((u32)&lpc32xx_nand_slc_regs->dma_data)
-#define lpc32xx_dmac_set_ecc()		((u32)&lpc32xx_nand_slc_regs->ecc)
-#endif
-
-static struct lpc32xx_nand_slc_regs __iomem *lpc32xx_nand_slc_regs
-	= (struct lpc32xx_nand_slc_regs __iomem *)SLC_NAND_BASE;
-
-static void lpc32xx_nand_init(void)
-{
-	uint32_t hclk = get_hclk_clk_rate();
-
-	/* Reset SLC NAND controller */
-	writel(CTRL_SW_RESET, &lpc32xx_nand_slc_regs->ctrl);
-
-	/* 8-bit bus, no DMA, no ECC, ordinary CE signal */
-	writel(0, &lpc32xx_nand_slc_regs->cfg);
-
-	/* Interrupts disabled and cleared */
-	writel(0, &lpc32xx_nand_slc_regs->ien);
-	writel(INT_STAT_TC | INT_STAT_RDY,
-	       &lpc32xx_nand_slc_regs->icr);
-
-	/* Configure NAND flash timings */
-	writel(TAC_W_RDY(CFG_LPC32XX_NAND_SLC_WDR_CLKS) |
-	       TAC_W_WIDTH(hclk / CFG_LPC32XX_NAND_SLC_WWIDTH) |
-	       TAC_W_HOLD(hclk / CFG_LPC32XX_NAND_SLC_WHOLD) |
-	       TAC_W_SETUP(hclk / CFG_LPC32XX_NAND_SLC_WSETUP) |
-	       TAC_R_RDY(CFG_LPC32XX_NAND_SLC_RDR_CLKS) |
-	       TAC_R_WIDTH(hclk / CFG_LPC32XX_NAND_SLC_RWIDTH) |
-	       TAC_R_HOLD(hclk / CFG_LPC32XX_NAND_SLC_RHOLD) |
-	       TAC_R_SETUP(hclk / CFG_LPC32XX_NAND_SLC_RSETUP),
-	       &lpc32xx_nand_slc_regs->tac);
-}
-
-static void lpc32xx_nand_cmd_ctrl(struct mtd_info *mtd,
-				  int cmd, unsigned int ctrl)
-{
-	debug("ctrl: 0x%08x, cmd: 0x%08x\n", ctrl, cmd);
-
-	if (ctrl & NAND_NCE)
-		setbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_CE_LOW);
-	else
-		clrbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_CE_LOW);
-
-	if (cmd == NAND_CMD_NONE)
-		return;
-
-	if (ctrl & NAND_CLE)
-		writel(cmd & 0xFF, &lpc32xx_nand_slc_regs->cmd);
-	else if (ctrl & NAND_ALE)
-		writel(cmd & 0xFF, &lpc32xx_nand_slc_regs->addr);
-}
-
-static int lpc32xx_nand_dev_ready(struct mtd_info *mtd)
-{
-	return readl(&lpc32xx_nand_slc_regs->stat) & STAT_NAND_READY;
-}
-
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
-/*
- * Prepares DMA descriptors for NAND RD/WR operations
- * If the size is < 256 Bytes then it is assumed to be
- * an OOB transfer
- */
-static void lpc32xx_nand_dma_configure(struct nand_chip *chip,
-				       const u8 *buffer, int size,
-				       int read)
-{
-	u32 i, dmasrc, ctrl, ecc_ctrl, oob_ctrl, dmadst;
-	struct lpc32xx_dmac_ll *dmalist_cur;
-	struct lpc32xx_dmac_ll *dmalist_cur_ecc;
-
-	/*
-	 * CTRL descriptor entry for reading ECC
-	 * Copy Multiple times to sync DMA with Flash Controller
-	 */
-	ecc_ctrl = 0x5 |
-			DMAC_CHAN_SRC_BURST_1 |
-			DMAC_CHAN_DEST_BURST_1 |
-			DMAC_CHAN_SRC_WIDTH_32 |
-			DMAC_CHAN_DEST_WIDTH_32 |
-			DMAC_CHAN_DEST_AHB1;
-
-	/* CTRL descriptor entry for reading/writing Data */
-	ctrl = (CFG_SYS_NAND_ECCSIZE / 4) |
-			DMAC_CHAN_SRC_BURST_4 |
-			DMAC_CHAN_DEST_BURST_4 |
-			DMAC_CHAN_SRC_WIDTH_32 |
-			DMAC_CHAN_DEST_WIDTH_32 |
-			DMAC_CHAN_DEST_AHB1;
-
-	/* CTRL descriptor entry for reading/writing Spare Area */
-	oob_ctrl = (CONFIG_SYS_NAND_OOBSIZE / 4) |
-			DMAC_CHAN_SRC_BURST_4 |
-			DMAC_CHAN_DEST_BURST_4 |
-			DMAC_CHAN_SRC_WIDTH_32 |
-			DMAC_CHAN_DEST_WIDTH_32 |
-			DMAC_CHAN_DEST_AHB1;
-
-	if (read) {
-		dmasrc = lpc32xx_dmac_set_dma_data();
-		dmadst = (u32)buffer;
-		ctrl |= DMAC_CHAN_DEST_AUTOINC;
-	} else {
-		dmadst = lpc32xx_dmac_set_dma_data();
-		dmasrc = (u32)buffer;
-		ctrl |= DMAC_CHAN_SRC_AUTOINC;
-	}
-
-	/*
-	 * Write Operation Sequence for Small Block NAND
-	 * ----------------------------------------------------------
-	 * 1. X'fer 256 bytes of data from Memory to Flash.
-	 * 2. Copy generated ECC data from Register to Spare Area
-	 * 3. X'fer next 256 bytes of data from Memory to Flash.
-	 * 4. Copy generated ECC data from Register to Spare Area.
-	 * 5. X'fer 16 byets of Spare area from Memory to Flash.
-	 * Read Operation Sequence for Small Block NAND
-	 * ----------------------------------------------------------
-	 * 1. X'fer 256 bytes of data from Flash to Memory.
-	 * 2. Copy generated ECC data from Register to ECC calc Buffer.
-	 * 3. X'fer next 256 bytes of data from Flash to Memory.
-	 * 4. Copy generated ECC data from Register to ECC calc Buffer.
-	 * 5. X'fer 16 bytes of Spare area from Flash to Memory.
-	 * Write Operation Sequence for Large Block NAND
-	 * ----------------------------------------------------------
-	 * 1. Steps(1-4) of Write Operations repeate for four times
-	 * which generates 16 DMA descriptors to X'fer 2048 bytes of
-	 * data & 32 bytes of ECC data.
-	 * 2. X'fer 64 bytes of Spare area from Memory to Flash.
-	 * Read Operation Sequence for Large Block NAND
-	 * ----------------------------------------------------------
-	 * 1. Steps(1-4) of Read Operations repeate for four times
-	 * which generates 16 DMA descriptors to X'fer 2048 bytes of
-	 * data & 32 bytes of ECC data.
-	 * 2. X'fer 64 bytes of Spare area from Flash to Memory.
-	 */
-
-	for (i = 0; i < size/CFG_SYS_NAND_ECCSIZE; i++) {
-		dmalist_cur = &dmalist[i * 2];
-		dmalist_cur_ecc = &dmalist[(i * 2) + 1];
-
-		dmalist_cur->dma_src = (read ? (dmasrc) : (dmasrc + (i*256)));
-		dmalist_cur->dma_dest = (read ? (dmadst + (i*256)) : dmadst);
-		dmalist_cur->next_lli = lpc32xx_dmac_next_lli(dmalist_cur_ecc);
-		dmalist_cur->next_ctrl = ctrl;
-
-		dmalist_cur_ecc->dma_src = lpc32xx_dmac_set_ecc();
-		dmalist_cur_ecc->dma_dest = (u32)&ecc_buffer[i];
-		dmalist_cur_ecc->next_lli =
-			lpc32xx_dmac_next_lli(&dmalist[(i * 2) + 2]);
-		dmalist_cur_ecc->next_ctrl = ecc_ctrl;
-	}
-
-	if (i) { /* Data only transfer */
-		dmalist_cur_ecc = &dmalist[(i * 2) - 1];
-		dmalist_cur_ecc->next_lli = 0;
-		dmalist_cur_ecc->next_ctrl |= DMAC_CHAN_INT_TC_EN;
-		return;
-	}
-
-	/* OOB only transfer */
-	if (read) {
-		dmasrc = lpc32xx_dmac_set_dma_data();
-		dmadst = (u32)buffer;
-		oob_ctrl |= DMAC_CHAN_DEST_AUTOINC;
-	} else {
-		dmadst = lpc32xx_dmac_set_dma_data();
-		dmasrc = (u32)buffer;
-		oob_ctrl |= DMAC_CHAN_SRC_AUTOINC;
-	}
-
-	/* Read/ Write Spare Area Data To/From Flash */
-	dmalist_cur = &dmalist[i * 2];
-	dmalist_cur->dma_src = dmasrc;
-	dmalist_cur->dma_dest = dmadst;
-	dmalist_cur->next_lli = 0;
-	dmalist_cur->next_ctrl = (oob_ctrl | DMAC_CHAN_INT_TC_EN);
-}
-
-static void lpc32xx_nand_xfer(struct mtd_info *mtd, const u8 *buf,
-			      int len, int read)
-{
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	u32 config;
-	int ret;
-
-	/* DMA Channel Configuration */
-	config = (read ? DMAC_CHAN_FLOW_D_P2M : DMAC_CHAN_FLOW_D_M2P) |
-		(read ? DMAC_DEST_PERIP(0) : DMAC_DEST_PERIP(DMA_PERID_NAND1)) |
-		(read ? DMAC_SRC_PERIP(DMA_PERID_NAND1) : DMAC_SRC_PERIP(0)) |
-		DMAC_CHAN_ENABLE;
-
-	/* Prepare DMA descriptors */
-	lpc32xx_nand_dma_configure(chip, buf, len, read);
-
-	/* Setup SLC controller and start transfer */
-	if (read)
-		setbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_DMA_DIR);
-	else  /* NAND_ECC_WRITE */
-		clrbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_DMA_DIR);
-	setbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_DMA_BURST);
-
-	/* Write length for new transfers */
-	if (!((readl(&lpc32xx_nand_slc_regs->stat) & STAT_DMA_FIFO) |
-	      readl(&lpc32xx_nand_slc_regs->tc))) {
-		int tmp = (len != mtd->oobsize) ? mtd->oobsize : 0;
-		writel(len + tmp, &lpc32xx_nand_slc_regs->tc);
-	}
-
-	setbits_le32(&lpc32xx_nand_slc_regs->ctrl, CTRL_DMA_START);
-
-	/* Start DMA transfers */
-	ret = lpc32xx_dma_start_xfer(dmachan, dmalist, config);
-	if (unlikely(ret < 0))
-		BUG();
-
-	/* Wait for NAND to be ready */
-	while (!lpc32xx_nand_dev_ready(mtd))
-		;
-
-	/* Wait till DMA transfer is DONE */
-	if (lpc32xx_dma_wait_status(dmachan))
-		pr_err("NAND DMA transfer error!\r\n");
-
-	/* Stop DMA & HW ECC */
-	clrbits_le32(&lpc32xx_nand_slc_regs->ctrl, CTRL_DMA_START);
-	clrbits_le32(&lpc32xx_nand_slc_regs->cfg,
-		     CFG_DMA_DIR | CFG_DMA_BURST | CFG_ECC_EN | CFG_DMA_ECC);
-}
-
-static u32 slc_ecc_copy_to_buffer(u8 *spare, const u32 *ecc, int count)
-{
-	int i;
-	for (i = 0; i < (count * CFG_SYS_NAND_ECCBYTES);
-	     i += CFG_SYS_NAND_ECCBYTES) {
-		u32 ce = ecc[i / CFG_SYS_NAND_ECCBYTES];
-		ce = ~(ce << 2) & 0xFFFFFF;
-		spare[i+2] = (u8)(ce & 0xFF); ce >>= 8;
-		spare[i+1] = (u8)(ce & 0xFF); ce >>= 8;
-		spare[i]   = (u8)(ce & 0xFF);
-	}
-	return 0;
-}
-
-static int lpc32xx_ecc_calculate(struct mtd_info *mtd, const uint8_t *dat,
-				 uint8_t *ecc_code)
-{
-	return slc_ecc_copy_to_buffer(ecc_code, ecc_buffer, ECCSTEPS);
-}
-
-/*
- * Enables and prepares SLC NAND controller
- * for doing data transfers with H/W ECC enabled.
- */
-static void lpc32xx_hwecc_enable(struct mtd_info *mtd, int mode)
-{
-	/* Clear ECC */
-	writel(CTRL_ECC_CLEAR, &lpc32xx_nand_slc_regs->ctrl);
-
-	/* Setup SLC controller for H/W ECC operations */
-	setbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_ECC_EN | CFG_DMA_ECC);
-}
-
-/*
- * lpc32xx_correct_data - [NAND Interface] Detect and correct bit error(s)
- * mtd:	MTD block structure
- * dat:	raw data read from the chip
- * read_ecc:	ECC from the chip
- * calc_ecc:	the ECC calculated from raw data
- *
- * Detect and correct a 1 bit error for 256 byte block
- */
-int lpc32xx_correct_data(struct mtd_info *mtd, u_char *dat,
-			 u_char *read_ecc, u_char *calc_ecc)
-{
-	unsigned int i;
-	int ret1, ret2 = 0;
-	u_char *r = read_ecc;
-	u_char *c = calc_ecc;
-	u16 data_offset = 0;
-
-	for (i = 0 ; i < ECCSTEPS ; i++) {
-		r += CFG_SYS_NAND_ECCBYTES;
-		c += CFG_SYS_NAND_ECCBYTES;
-		data_offset += CFG_SYS_NAND_ECCSIZE;
-
-		ret1 = nand_correct_data(mtd, dat + data_offset, r, c);
-		if (ret1 < 0)
-			return -EBADMSG;
-		else
-			ret2 += ret1;
-	}
-
-	return ret2;
-}
-
-static void lpc32xx_dma_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
-{
-	lpc32xx_nand_xfer(mtd, buf, len, 1);
-}
-
-static void lpc32xx_dma_write_buf(struct mtd_info *mtd, const uint8_t *buf,
-				  int len)
-{
-	lpc32xx_nand_xfer(mtd, buf, len, 0);
-}
-
-/* Reuse the logic from "nand_read_page_hwecc()" */
-static int lpc32xx_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				uint8_t *buf, int oob_required, int page)
-{
-	int i;
-	int stat;
-	uint8_t *p = buf;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
-	unsigned int max_bitflips = 0;
-
-	/*
-	 * As per the "LPC32x0 and LPC32x0/01 User manual" table 173 notes
-	 * and section 9.7, the NAND SLC & DMA allowed single DMA transaction
-	 * of a page size using DMA controller scatter/gather mode through
-	 * linked list; the ECC read is done without any software intervention.
-	 */
-
-	lpc32xx_hwecc_enable(mtd, NAND_ECC_READ);
-	lpc32xx_dma_read_buf(mtd, p, chip->ecc.size * chip->ecc.steps);
-	lpc32xx_ecc_calculate(mtd, p, &ecc_calc[0]);
-	lpc32xx_dma_read_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	for (i = 0; i < chip->ecc.total; i++)
-		ecc_code[i] = chip->oob_poi[eccpos[i]];
-
-	stat = chip->ecc.correct(mtd, p, &ecc_code[0], &ecc_calc[0]);
-	if (stat < 0)
-		mtd->ecc_stats.failed++;
-	else {
-		mtd->ecc_stats.corrected += stat;
-		max_bitflips = max_t(unsigned int, max_bitflips, stat);
-	}
-
-	return max_bitflips;
-}
-
-/* Reuse the logic from "nand_write_page_hwecc()" */
-static int lpc32xx_write_page_hwecc(struct mtd_info *mtd,
-				    struct nand_chip *chip,
-				    const uint8_t *buf, int oob_required,
-				    int page)
-{
-	int i;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	const uint8_t *p = buf;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
-
-	/*
-	 * As per the "LPC32x0 and LPC32x0/01 User manual" table 173 notes
-	 * and section 9.7, the NAND SLC & DMA allowed single DMA transaction
-	 * of a page size using DMA controller scatter/gather mode through
-	 * linked list; the ECC read is done without any software intervention.
-	 */
-
-	lpc32xx_hwecc_enable(mtd, NAND_ECC_WRITE);
-	lpc32xx_dma_write_buf(mtd, p, chip->ecc.size * chip->ecc.steps);
-	lpc32xx_ecc_calculate(mtd, p, &ecc_calc[0]);
-
-	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
-
-	lpc32xx_dma_write_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	return 0;
-}
-#else
-static void lpc32xx_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
-{
-	while (len-- > 0)
-		*buf++ = readl(&lpc32xx_nand_slc_regs->data);
-}
-
-static void lpc32xx_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
-{
-	while (len-- > 0)
-		writel(*buf++, &lpc32xx_nand_slc_regs->data);
-}
-#endif
-
-static uint8_t lpc32xx_read_byte(struct mtd_info *mtd)
-{
-	return readl(&lpc32xx_nand_slc_regs->data);
-}
-
-static void lpc32xx_write_byte(struct mtd_info *mtd, uint8_t byte)
-{
-	writel(byte, &lpc32xx_nand_slc_regs->data);
-}
-
-/*
- * LPC32xx has only one SLC NAND controller, don't utilize
- * CONFIG_SYS_NAND_SELF_INIT to be able to reuse this function
- * both in SPL NAND and U-Boot images.
- */
-int board_nand_init(struct nand_chip *lpc32xx_chip)
-{
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
-	int ret;
-
-	/* Acquire a channel for our use */
-	ret = lpc32xx_dma_get_channel();
-	if (unlikely(ret < 0)) {
-		pr_info("Unable to get free DMA channel for NAND transfers\n");
-		return -1;
-	}
-	dmachan = (unsigned int)ret;
-#endif
-
-	lpc32xx_chip->cmd_ctrl  = lpc32xx_nand_cmd_ctrl;
-	lpc32xx_chip->dev_ready = lpc32xx_nand_dev_ready;
-
-	/*
-	 * The implementation of these functions is quite common, but
-	 * they MUST be defined, because access to data register
-	 * is strictly 32-bit aligned.
-	 */
-	lpc32xx_chip->read_byte  = lpc32xx_read_byte;
-	lpc32xx_chip->write_byte = lpc32xx_write_byte;
-
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
-	/* Hardware ECC calculation is supported when DMA driver is selected */
-	lpc32xx_chip->ecc.mode		= NAND_ECC_HW;
-
-	lpc32xx_chip->read_buf		= lpc32xx_dma_read_buf;
-	lpc32xx_chip->write_buf		= lpc32xx_dma_write_buf;
-
-	lpc32xx_chip->ecc.calculate	= lpc32xx_ecc_calculate;
-	lpc32xx_chip->ecc.correct	= lpc32xx_correct_data;
-	lpc32xx_chip->ecc.hwctl		= lpc32xx_hwecc_enable;
-	lpc32xx_chip->chip_delay	= 2000;
-
-	lpc32xx_chip->ecc.read_page	= lpc32xx_read_page_hwecc;
-	lpc32xx_chip->ecc.write_page	= lpc32xx_write_page_hwecc;
-	lpc32xx_chip->options		|= NAND_NO_SUBPAGE_WRITE;
-#else
-	/*
-	 * Hardware ECC calculation is not supported by the driver,
-	 * because it requires DMA support, see LPC32x0 User Manual,
-	 * note after SLC_ECC register description (UM10326, p.198)
-	 */
-	lpc32xx_chip->ecc.mode = NAND_ECC_SOFT;
-
-	/*
-	 * The implementation of these functions is quite common, but
-	 * they MUST be defined, because access to data register
-	 * is strictly 32-bit aligned.
-	 */
-	lpc32xx_chip->read_buf   = lpc32xx_read_buf;
-	lpc32xx_chip->write_buf  = lpc32xx_write_buf;
-#endif
-
-	/*
-	 * These values are predefined
-	 * for both small and large page NAND flash devices.
-	 */
-	lpc32xx_chip->ecc.size     = CFG_SYS_NAND_ECCSIZE;
-	lpc32xx_chip->ecc.bytes    = CFG_SYS_NAND_ECCBYTES;
-	lpc32xx_chip->ecc.strength = 1;
-
-	if (CONFIG_SYS_NAND_PAGE_SIZE != NAND_LARGE_BLOCK_PAGE_SIZE)
-		lpc32xx_chip->ecc.layout = &lpc32xx_nand_oob_16;
-
-#if defined(CONFIG_SYS_NAND_USE_FLASH_BBT)
-	lpc32xx_chip->bbt_options |= NAND_BBT_USE_FLASH;
-#endif
-
-	/* Initialize NAND interface */
-	lpc32xx_nand_init();
-
-	return 0;
-}
-- 
2.43.0

