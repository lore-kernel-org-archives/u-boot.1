Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8916C83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC82835FE;
	Fri, 18 Jul 2025 03:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e9l97ZzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E40835C7; Fri, 18 Jul 2025 03:15:52 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF9D8353A
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73e57751cd9so477315a34.1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801347; x=1753406147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rXh82pqZAVL2+XR1TSa8mik7rN0dTSIbDeg/lUl2Nqs=;
 b=e9l97ZzY/f5IPdUQxzlTM22Iw1DKK7h6OtHcyXHj+Jkd19Ow4oLf+QnBuvzbmg6zGC
 71OZIAt8Ou5FLmOADVR2JkwwF9ghQ9xplaTGHR87IgZH2buEQBsquo5D5QTJdLYX+qyD
 AWTL/ASvWwJnLJCytcc5Gf+/pCaIVWYHaBEzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801347; x=1753406147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rXh82pqZAVL2+XR1TSa8mik7rN0dTSIbDeg/lUl2Nqs=;
 b=N5kbq6oeo631JY6+ia8L6LdVWO2cdAWVZ/9nzqGwbbaN413XuI0yNvwcwJd/bFZ7uL
 SdlCAzIokQ4SI4VjY7FnbLqjwhPjggevnK5TSJKmeIHt3mc5tDW3Jkx4mNsZeoYNQrk3
 Dv+sw5LUy6OjKRZmLr0EfJZ6z48O7uyBRm8ZtdVvYd+v4eDC1INQ40EzRVFg7+7N2iyS
 6DDL7pgrmpj9aye3XMjiIP6fJbQ/RIurjTBx0EFUH2CuKNtALq+ZwLKXsP/xLBzByjDa
 sdi5RI1J9FKLSHpu/BtsccwsPNTXX5m7fkrARPU5Wq4Sxid234qlI2a6r+r56v6zrJpE
 Q+ew==
X-Gm-Message-State: AOJu0YwlB9JfdPT0OMTXZc1wXZecNkDT6+/HOKYd+j1j9WflRvRhDNyC
 SL4Dg54bBVXHf3ODfe8hVXTm/JxOJ+VD/aHJF+r5es4nNP+FyOWBhPlarzqf6/8ipy0NxcHhSbl
 AG+BySFk=
X-Gm-Gg: ASbGncu55Z+VtAg7ekVZvzsbjJuS/fqCOmW9A+ZVzx03AZGmPMxbxe/Aq8dclzeElQ9
 /RLek824Xnh/omPnbxhcTfOriBdt3vA2YAhvHqCBqvxfNIlmpLbPsXFHDvB90MDBUzQZbWe1JRS
 DKb5UuLifTxDg1pm00nSkyTlG/tlOPvMmqM7lXbUZtso3/awKaz92NicJYojA/orziOEe00XADy
 Q5SCsKZEyOrldh+XKm8yLO+GQ8tGLH1KcnqRv1cNJChPXh3ojDJxlOC3crrWAkbICIrIa/R/GA6
 f9NIFXdR4dwBfAw9hYK4OVC47wHiDpqf4DAW1erxi9VB7rxfXPOMh1Ibg+DTjYzzNugjdBgqx80
 xXCjLlbKuommtKwit0XSC7wYl+MBCYLVY9jTce7LYeAmeHaB/n6YurLg/nQTbiBDb4HYROg==
X-Google-Smtp-Source: AGHT+IFaKV0oby3gmsc8eXuUNnCU/F25C3vHoBGoMj1ZExswGhq5gTlwa53OmY7j98gCkUPEsGCBuw==
X-Received: by 2002:a05:6870:e047:b0:2ff:8fd9:6dcd with SMTP id
 586e51a60fabf-300e8c593d7mr740122fac.3.1752801346216; 
 Thu, 17 Jul 2025 18:15:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3010168b114sm211473fac.3.2025.07.17.18.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:15:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH] arm: bcm281xx: Remove ethernet driver
Date: Thu, 17 Jul 2025 19:15:44 -0600
Message-ID: <20250718011544.1333974-1-trini@konsulko.com>
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

As no platforms enable the ethernet driver, remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 arch/arm/cpu/armv7/bcm281xx/Makefile       |   1 -
 arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c |  24 -
 arch/arm/cpu/armv7/bcm281xx/clk-eth.c      | 142 ---
 drivers/net/Kconfig                        |  24 -
 drivers/net/Makefile                       |   2 -
 drivers/net/bcm-sf2-eth-gmac.c             | 976 ---------------------
 drivers/net/bcm-sf2-eth-gmac.h             | 222 -----
 drivers/net/bcm-sf2-eth.c                  | 274 ------
 drivers/net/bcm-sf2-eth.h                  |  65 --
 include/configs/bcm_ns3.h                  |  12 +-
 10 files changed, 1 insertion(+), 1741 deletions(-)
 delete mode 100644 arch/arm/cpu/armv7/bcm281xx/clk-eth.c
 delete mode 100644 drivers/net/bcm-sf2-eth-gmac.c
 delete mode 100644 drivers/net/bcm-sf2-eth-gmac.h
 delete mode 100644 drivers/net/bcm-sf2-eth.c
 delete mode 100644 drivers/net/bcm-sf2-eth.h

diff --git a/arch/arm/cpu/armv7/bcm281xx/Makefile b/arch/arm/cpu/armv7/bcm281xx/Makefile
index e5099975cba3..f6323af1d068 100644
--- a/arch/arm/cpu/armv7/bcm281xx/Makefile
+++ b/arch/arm/cpu/armv7/bcm281xx/Makefile
@@ -7,5 +7,4 @@ obj-y	+= clk-core.o
 obj-y	+= clk-bcm281xx.o
 obj-y	+= clk-sdio.o
 obj-y	+= clk-bsc.o
-obj-$(CONFIG_BCM_SF2_ETH) += clk-eth.o
 obj-y	+= clk-usb-otg.o
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c b/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
index b258fea45c8e..39eb2ca01dc5 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
@@ -307,27 +307,6 @@ static struct ccu_clock kps_ccu_clk = {
 	.freq_tbl = slave_axi_freq_tbl,
 };
 
-#ifdef CONFIG_BCM_SF2_ETH
-static struct ccu_clock esub_ccu_clk = {
-	.clk = {
-		.name = "esub_ccu_clk",
-		.ops = &ccu_clk_ops,
-		.ccu_clk_mgr_base = ESUB_CLK_BASE_ADDR,
-	},
-	.num_policy_masks = 1,
-	.policy_freq_offset = 0x00000008,
-	.freq_bit_shift = 8,
-	.policy_ctl_offset = 0x0000000c,
-	.policy0_mask_offset = 0x00000010,
-	.policy1_mask_offset = 0x00000014,
-	.policy2_mask_offset = 0x00000018,
-	.policy3_mask_offset = 0x0000001c,
-	.lvm_en_offset = 0x00000034,
-	.freq_id = 2,
-	.freq_tbl = esub_freq_tbl,
-};
-#endif
-
 /*
  * Bus clocks
  */
@@ -562,9 +541,6 @@ struct clk_lookup arch_clk_tbl[] = {
 	CLK_LK(bsc1_apb),
 	CLK_LK(bsc2_apb),
 	CLK_LK(bsc3_apb),
-#ifdef CONFIG_BCM_SF2_ETH
-	CLK_LK(esub_ccu),
-#endif
 };
 
 /* public array size */
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-eth.c b/arch/arm/cpu/armv7/bcm281xx/clk-eth.c
deleted file mode 100644
index 5f7cc4a102d0..000000000000
--- a/arch/arm/cpu/armv7/bcm281xx/clk-eth.c
+++ /dev/null
@@ -1,142 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2014 Broadcom Corporation.
- */
-
-#include <asm/io.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <asm/arch/sysmap.h>
-#include <asm/kona-common/clk.h>
-#include "clk-core.h"
-
-#define WR_ACCESS_ADDR			ESUB_CLK_BASE_ADDR
-#define WR_ACCESS_PASSWORD				0xA5A500
-
-#define PLLE_POST_RESETB_ADDR		(ESUB_CLK_BASE_ADDR + 0x00000C00)
-
-#define PLLE_RESETB_ADDR		(ESUB_CLK_BASE_ADDR + 0x00000C58)
-#define PLLE_RESETB_I_PLL_RESETB_PLLE_MASK		0x00010000
-#define PLLE_POST_RESETB_I_POST_RESETB_PLLE_MASK	0x00000001
-
-#define PLL_LOCK_ADDR			(ESUB_CLK_BASE_ADDR + 0x00000C38)
-#define PLL_LOCK_PLL_LOCK_PLLE_MASK			0x00000001
-
-#define ESW_SYS_DIV_ADDR		(ESUB_CLK_BASE_ADDR + 0x00000A04)
-#define ESW_SYS_DIV_PLL_SELECT_MASK			0x00000300
-#define ESW_SYS_DIV_DIV_MASK				0x0000001C
-#define ESW_SYS_DIV_PLL_VAR_208M_CLK_SELECT		0x00000100
-#define ESW_SYS_DIV_DIV_SELECT				0x4
-#define ESW_SYS_DIV_TRIGGER_MASK			0x00000001
-
-#define ESUB_AXI_DIV_DEBUG_ADDR		(ESUB_CLK_BASE_ADDR + 0x00000E04)
-#define ESUB_AXI_DIV_DEBUG_PLL_SELECT_MASK		0x0000001C
-#define ESUB_AXI_DIV_DEBUG_PLL_SELECT_OVERRIDE_MASK	0x00000040
-#define ESUB_AXI_DIV_DEBUG_PLL_VAR_208M_CLK_SELECT	0x0
-#define ESUB_AXI_DIV_DEBUG_TRIGGER_MASK			0x00000001
-
-#define PLL_MAX_RETRY	100
-
-/* Enable appropriate clocks for Ethernet */
-int clk_eth_enable(void)
-{
-	int rc = -1;
-	int retry_count = 0;
-	rc = clk_get_and_enable("esub_ccu_clk");
-
-	/* Enable Access to CCU registers */
-	writel((1 | WR_ACCESS_PASSWORD), WR_ACCESS_ADDR);
-
-	writel(readl(PLLE_POST_RESETB_ADDR) &
-	       ~PLLE_POST_RESETB_I_POST_RESETB_PLLE_MASK,
-	       PLLE_POST_RESETB_ADDR);
-
-	/* Take PLL out of reset and put into normal mode */
-	writel(readl(PLLE_RESETB_ADDR) | PLLE_RESETB_I_PLL_RESETB_PLLE_MASK,
-	       PLLE_RESETB_ADDR);
-
-	/* Wait for PLL lock */
-	rc = -1;
-	while (retry_count < PLL_MAX_RETRY) {
-		udelay(100);
-		if (readl(PLL_LOCK_ADDR) & PLL_LOCK_PLL_LOCK_PLLE_MASK) {
-			rc = 0;
-			break;
-		}
-		retry_count++;
-	}
-
-	if (rc == -1) {
-		printf("%s: ETH-PLL lock timeout, Ethernet is not enabled!\n",
-		       __func__);
-		return -1;
-	}
-
-	writel(readl(PLLE_POST_RESETB_ADDR) |
-	       PLLE_POST_RESETB_I_POST_RESETB_PLLE_MASK,
-	       PLLE_POST_RESETB_ADDR);
-
-	/* Switch esw_sys_clk to use 104MHz(208MHz/2) clock */
-	writel((readl(ESW_SYS_DIV_ADDR) &
-		~(ESW_SYS_DIV_PLL_SELECT_MASK | ESW_SYS_DIV_DIV_MASK)) |
-	       ESW_SYS_DIV_PLL_VAR_208M_CLK_SELECT | ESW_SYS_DIV_DIV_SELECT,
-	       ESW_SYS_DIV_ADDR);
-
-	writel(readl(ESW_SYS_DIV_ADDR) | ESW_SYS_DIV_TRIGGER_MASK,
-	       ESW_SYS_DIV_ADDR);
-
-	/* Wait for trigger complete */
-	rc = -1;
-	retry_count = 0;
-	while (retry_count < PLL_MAX_RETRY) {
-		udelay(100);
-		if (!(readl(ESW_SYS_DIV_ADDR) & ESW_SYS_DIV_TRIGGER_MASK)) {
-			rc = 0;
-			break;
-		}
-		retry_count++;
-	}
-
-	if (rc == -1) {
-		printf("%s: SYS CLK Trigger timeout, Ethernet is not enabled!\n",
-		       __func__);
-		return -1;
-	}
-
-	/* switch Esub AXI clock to 208MHz */
-	writel((readl(ESUB_AXI_DIV_DEBUG_ADDR) &
-		~(ESUB_AXI_DIV_DEBUG_PLL_SELECT_MASK |
-		  ESUB_AXI_DIV_DEBUG_PLL_SELECT_OVERRIDE_MASK |
-		  ESUB_AXI_DIV_DEBUG_TRIGGER_MASK)) |
-	       ESUB_AXI_DIV_DEBUG_PLL_VAR_208M_CLK_SELECT |
-	       ESUB_AXI_DIV_DEBUG_PLL_SELECT_OVERRIDE_MASK,
-	       ESUB_AXI_DIV_DEBUG_ADDR);
-
-	writel(readl(ESUB_AXI_DIV_DEBUG_ADDR) |
-	       ESUB_AXI_DIV_DEBUG_TRIGGER_MASK,
-	       ESUB_AXI_DIV_DEBUG_ADDR);
-
-	/* Wait for trigger complete */
-	rc = -1;
-	retry_count = 0;
-	while (retry_count < PLL_MAX_RETRY) {
-		udelay(100);
-		if (!(readl(ESUB_AXI_DIV_DEBUG_ADDR) &
-		      ESUB_AXI_DIV_DEBUG_TRIGGER_MASK)) {
-			rc = 0;
-			break;
-		}
-		retry_count++;
-	}
-
-	if (rc == -1) {
-		printf("%s: AXI CLK Trigger timeout, Ethernet is not enabled!\n",
-		       __func__);
-		return -1;
-	}
-
-	/* Disable Access to CCU registers */
-	writel(WR_ACCESS_PASSWORD, WR_ACCESS_ADDR);
-
-	return rc;
-}
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 950ed0f25a9a..f8c7637f0b9c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -138,30 +138,6 @@ config ALTERA_TSE
 	  Please find details on the "Triple-Speed Ethernet MegaCore Function
 	  Resource Center" of Altera.
 
-config BCM_SF2_ETH
-	bool "Broadcom SF2 (Starfighter2) Ethernet support"
-	select PHYLIB
-	help
-	  This is an abstract framework which provides a generic interface
-	  to MAC and DMA management for multiple Broadcom SoCs such as
-	  Cygnus, NSP and bcm28155_ap platforms.
-
-config BCM_SF2_ETH_DEFAULT_PORT
-	int "Broadcom SF2 (Starfighter2) Ethernet default port number"
-	depends on BCM_SF2_ETH
-	default 0
-	help
-	  Default port number for the Starfighter2 ethernet driver.
-
-config BCM_SF2_ETH_GMAC
-	bool "Broadcom SF2 (Starfighter2) GMAC Ethernet support"
-	depends on BCM_SF2_ETH
-	help
-	  This flag enables the ethernet support for Broadcom platforms with
-	  GMAC such as Cygnus. This driver is based on the framework provided
-	  by the BCM_SF2_ETH driver.
-	  Say Y to any bcmcygnus based platforms.
-
 config BCM6348_ETH
 	bool "BCM6348 EMAC support"
 	depends on ARCH_BMIPS
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 67bba3a85367..0591312d17db 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -11,8 +11,6 @@ obj-$(CONFIG_ASPEED_MDIO) += aspeed_mdio.o
 obj-$(CONFIG_BCM6348_ETH) += bcm6348-eth.o
 obj-$(CONFIG_BCM6368_ETH) += bcm6368-eth.o
 obj-$(CONFIG_BCMGENET) += bcmgenet.o
-obj-$(CONFIG_BCM_SF2_ETH) += bcm-sf2-eth.o
-obj-$(CONFIG_BCM_SF2_ETH_GMAC) += bcm-sf2-eth-gmac.o
 obj-$(CONFIG_BNXT_ETH) += bnxt/
 obj-$(CONFIG_CALXEDA_XGMAC) += calxedaxgmac.o
 obj-$(CONFIG_CORTINA_NI_ENET) += cortina_ni.o
diff --git a/drivers/net/bcm-sf2-eth-gmac.c b/drivers/net/bcm-sf2-eth-gmac.c
deleted file mode 100644
index ba244b4a26e2..000000000000
--- a/drivers/net/bcm-sf2-eth-gmac.c
+++ /dev/null
@@ -1,976 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2014-2017 Broadcom.
- */
-
-#ifdef BCM_GMAC_DEBUG
-#ifndef DEBUG
-#define DEBUG
-#include <linux/printk.h>
-#endif
-#endif
-
-#include <config.h>
-#include <cpu_func.h>
-#include <log.h>
-#include <malloc.h>
-#include <net.h>
-#include <asm/cache.h>
-#include <asm/io.h>
-#include <phy.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-
-#include "bcm-sf2-eth.h"
-#include "bcm-sf2-eth-gmac.h"
-
-#define SPINWAIT(exp, us) { \
-	uint countdown = (us) + 9; \
-	while ((exp) && (countdown >= 10)) {\
-		udelay(10); \
-		countdown -= 10; \
-	} \
-}
-
-#define RX_BUF_SIZE_ALIGNED	ALIGN(RX_BUF_SIZE, ARCH_DMA_MINALIGN)
-#define TX_BUF_SIZE_ALIGNED	ALIGN(TX_BUF_SIZE, ARCH_DMA_MINALIGN)
-#define DESCP_SIZE_ALIGNED	ALIGN(sizeof(dma64dd_t), ARCH_DMA_MINALIGN)
-
-static int gmac_disable_dma(struct eth_dma *dma, int dir);
-static int gmac_enable_dma(struct eth_dma *dma, int dir);
-
-/* DMA Descriptor */
-typedef struct {
-	/* misc control bits */
-	uint32_t	ctrl1;
-	/* buffer count and address extension */
-	uint32_t	ctrl2;
-	/* memory address of the date buffer, bits 31:0 */
-	uint32_t	addrlow;
-	/* memory address of the date buffer, bits 63:32 */
-	uint32_t	addrhigh;
-} dma64dd_t;
-
-uint32_t g_dmactrlflags;
-
-static uint32_t dma_ctrlflags(uint32_t mask, uint32_t flags)
-{
-	debug("%s enter\n", __func__);
-
-	g_dmactrlflags &= ~mask;
-	g_dmactrlflags |= flags;
-
-	/* If trying to enable parity, check if parity is actually supported */
-	if (g_dmactrlflags & DMA_CTRL_PEN) {
-		uint32_t control;
-
-		control = readl(GMAC0_DMA_TX_CTRL_ADDR);
-		writel(control | D64_XC_PD, GMAC0_DMA_TX_CTRL_ADDR);
-		if (readl(GMAC0_DMA_TX_CTRL_ADDR) & D64_XC_PD) {
-			/*
-			 * We *can* disable it, therefore it is supported;
-			 * restore control register
-			 */
-			writel(control, GMAC0_DMA_TX_CTRL_ADDR);
-		} else {
-			/* Not supported, don't allow it to be enabled */
-			g_dmactrlflags &= ~DMA_CTRL_PEN;
-		}
-	}
-
-	return g_dmactrlflags;
-}
-
-static inline void reg32_clear_bits(uint32_t reg, uint32_t value)
-{
-	uint32_t v = readl(reg);
-	v &= ~(value);
-	writel(v, reg);
-}
-
-static inline void reg32_set_bits(uint32_t reg, uint32_t value)
-{
-	uint32_t v = readl(reg);
-	v |= value;
-	writel(v, reg);
-}
-
-#ifdef BCM_GMAC_DEBUG
-static void dma_tx_dump(struct eth_dma *dma)
-{
-	dma64dd_t *descp = NULL;
-	uint8_t *bufp;
-	int i;
-
-	printf("TX DMA Register:\n");
-	printf("control:0x%x; ptr:0x%x; addrl:0x%x; addrh:0x%x; stat0:0x%x, stat1:0x%x\n",
-	       readl(GMAC0_DMA_TX_CTRL_ADDR),
-	       readl(GMAC0_DMA_TX_PTR_ADDR),
-	       readl(GMAC0_DMA_TX_ADDR_LOW_ADDR),
-	       readl(GMAC0_DMA_TX_ADDR_HIGH_ADDR),
-	       readl(GMAC0_DMA_TX_STATUS0_ADDR),
-	       readl(GMAC0_DMA_TX_STATUS1_ADDR));
-
-	printf("TX Descriptors:\n");
-	for (i = 0; i < TX_BUF_NUM; i++) {
-		descp = (dma64dd_t *)(dma->tx_desc_aligned) + i;
-		printf("ctrl1:0x%08x; ctrl2:0x%08x; addr:0x%x 0x%08x\n",
-		       descp->ctrl1, descp->ctrl2,
-		       descp->addrhigh, descp->addrlow);
-	}
-
-	printf("TX Buffers:\n");
-	/* Initialize TX DMA descriptor table */
-	for (i = 0; i < TX_BUF_NUM; i++) {
-		bufp = (uint8_t *)(dma->tx_buf + i * TX_BUF_SIZE_ALIGNED);
-		printf("buf%d:0x%x; ", i, (uint32_t)bufp);
-	}
-	printf("\n");
-}
-
-static void dma_rx_dump(struct eth_dma *dma)
-{
-	dma64dd_t *descp = NULL;
-	uint8_t *bufp;
-	int i;
-
-	printf("RX DMA Register:\n");
-	printf("control:0x%x; ptr:0x%x; addrl:0x%x; addrh:0x%x; stat0:0x%x, stat1:0x%x\n",
-	       readl(GMAC0_DMA_RX_CTRL_ADDR),
-	       readl(GMAC0_DMA_RX_PTR_ADDR),
-	       readl(GMAC0_DMA_RX_ADDR_LOW_ADDR),
-	       readl(GMAC0_DMA_RX_ADDR_HIGH_ADDR),
-	       readl(GMAC0_DMA_RX_STATUS0_ADDR),
-	       readl(GMAC0_DMA_RX_STATUS1_ADDR));
-
-	printf("RX Descriptors:\n");
-	for (i = 0; i < RX_BUF_NUM; i++) {
-		descp = (dma64dd_t *)(dma->rx_desc_aligned) + i;
-		printf("ctrl1:0x%08x; ctrl2:0x%08x; addr:0x%x 0x%08x\n",
-		       descp->ctrl1, descp->ctrl2,
-		       descp->addrhigh, descp->addrlow);
-	}
-
-	printf("RX Buffers:\n");
-	for (i = 0; i < RX_BUF_NUM; i++) {
-		bufp = dma->rx_buf + i * RX_BUF_SIZE_ALIGNED;
-		printf("buf%d:0x%x; ", i, (uint32_t)bufp);
-	}
-	printf("\n");
-}
-#endif
-
-static int dma_tx_init(struct eth_dma *dma)
-{
-	dma64dd_t *descp = NULL;
-	uint8_t *bufp;
-	int i;
-	uint32_t ctrl;
-
-	debug("%s enter\n", __func__);
-
-	/* clear descriptor memory */
-	memset((void *)(dma->tx_desc_aligned), 0,
-	       TX_BUF_NUM * DESCP_SIZE_ALIGNED);
-	memset(dma->tx_buf, 0, TX_BUF_NUM * TX_BUF_SIZE_ALIGNED);
-
-	/* Initialize TX DMA descriptor table */
-	for (i = 0; i < TX_BUF_NUM; i++) {
-		descp = (dma64dd_t *)(dma->tx_desc_aligned) + i;
-		bufp = dma->tx_buf + i * TX_BUF_SIZE_ALIGNED;
-		/* clear buffer memory */
-		memset((void *)bufp, 0, TX_BUF_SIZE_ALIGNED);
-
-		ctrl = 0;
-		/* if last descr set endOfTable */
-		if (i == (TX_BUF_NUM-1))
-			ctrl = D64_CTRL1_EOT;
-		descp->ctrl1 = ctrl;
-		descp->ctrl2 = 0;
-		descp->addrlow = (uint32_t)bufp;
-		descp->addrhigh = 0;
-	}
-
-	/* flush descriptor and buffer */
-	descp = dma->tx_desc_aligned;
-	bufp = dma->tx_buf;
-	flush_dcache_range((unsigned long)descp,
-			   (unsigned long)descp +
-			   DESCP_SIZE_ALIGNED * TX_BUF_NUM);
-	flush_dcache_range((unsigned long)bufp,
-			   (unsigned long)bufp +
-			   TX_BUF_SIZE_ALIGNED * TX_BUF_NUM);
-
-	/* initialize the DMA channel */
-	writel((uint32_t)(dma->tx_desc_aligned), GMAC0_DMA_TX_ADDR_LOW_ADDR);
-	writel(0, GMAC0_DMA_TX_ADDR_HIGH_ADDR);
-
-	/* now update the dma last descriptor */
-	writel(((uint32_t)(dma->tx_desc_aligned)) & D64_XP_LD_MASK,
-	       GMAC0_DMA_TX_PTR_ADDR);
-
-	return 0;
-}
-
-static int dma_rx_init(struct eth_dma *dma)
-{
-	uint32_t last_desc;
-	dma64dd_t *descp = NULL;
-	uint8_t *bufp;
-	uint32_t ctrl;
-	int i;
-
-	debug("%s enter\n", __func__);
-
-	/* clear descriptor memory */
-	memset((void *)(dma->rx_desc_aligned), 0,
-	       RX_BUF_NUM * DESCP_SIZE_ALIGNED);
-	/* clear buffer memory */
-	memset(dma->rx_buf, 0, RX_BUF_NUM * RX_BUF_SIZE_ALIGNED);
-
-	/* Initialize RX DMA descriptor table */
-	for (i = 0; i < RX_BUF_NUM; i++) {
-		descp = (dma64dd_t *)(dma->rx_desc_aligned) + i;
-		bufp = dma->rx_buf + i * RX_BUF_SIZE_ALIGNED;
-		ctrl = 0;
-		/* if last descr set endOfTable */
-		if (i == (RX_BUF_NUM - 1))
-			ctrl = D64_CTRL1_EOT;
-		descp->ctrl1 = ctrl;
-		descp->ctrl2 = RX_BUF_SIZE_ALIGNED;
-		descp->addrlow = (uint32_t)bufp;
-		descp->addrhigh = 0;
-
-		last_desc = ((uint32_t)(descp) & D64_XP_LD_MASK)
-				+ sizeof(dma64dd_t);
-	}
-
-	descp = dma->rx_desc_aligned;
-	bufp = dma->rx_buf;
-	/* flush descriptor and buffer */
-	flush_dcache_range((unsigned long)descp,
-			   (unsigned long)descp +
-			   DESCP_SIZE_ALIGNED * RX_BUF_NUM);
-	flush_dcache_range((unsigned long)(bufp),
-			   (unsigned long)bufp +
-			   RX_BUF_SIZE_ALIGNED * RX_BUF_NUM);
-
-	/* initailize the DMA channel */
-	writel((uint32_t)descp, GMAC0_DMA_RX_ADDR_LOW_ADDR);
-	writel(0, GMAC0_DMA_RX_ADDR_HIGH_ADDR);
-
-	/* now update the dma last descriptor */
-	writel(last_desc, GMAC0_DMA_RX_PTR_ADDR);
-
-	return 0;
-}
-
-static int dma_init(struct eth_dma *dma)
-{
-	debug(" %s enter\n", __func__);
-
-	/*
-	 * Default flags: For backwards compatibility both
-	 * Rx Overflow Continue and Parity are DISABLED.
-	 */
-	dma_ctrlflags(DMA_CTRL_ROC | DMA_CTRL_PEN, 0);
-
-	debug("rx burst len 0x%x\n",
-	      (readl(GMAC0_DMA_RX_CTRL_ADDR) & D64_RC_BL_MASK)
-	      >> D64_RC_BL_SHIFT);
-	debug("tx burst len 0x%x\n",
-	      (readl(GMAC0_DMA_TX_CTRL_ADDR) & D64_XC_BL_MASK)
-	      >> D64_XC_BL_SHIFT);
-
-	dma_tx_init(dma);
-	dma_rx_init(dma);
-
-	/* From end of chip_init() */
-	/* enable the overflow continue feature and disable parity */
-	dma_ctrlflags(DMA_CTRL_ROC | DMA_CTRL_PEN /* mask */,
-		      DMA_CTRL_ROC /* value */);
-
-	return 0;
-}
-
-static int dma_deinit(struct eth_dma *dma)
-{
-	debug(" %s enter\n", __func__);
-
-	gmac_disable_dma(dma, MAC_DMA_RX);
-	gmac_disable_dma(dma, MAC_DMA_TX);
-
-	free(dma->tx_buf);
-	dma->tx_buf = NULL;
-	free(dma->tx_desc_aligned);
-	dma->tx_desc_aligned = NULL;
-
-	free(dma->rx_buf);
-	dma->rx_buf = NULL;
-	free(dma->rx_desc_aligned);
-	dma->rx_desc_aligned = NULL;
-
-	return 0;
-}
-
-int gmac_tx_packet(struct eth_dma *dma, void *packet, int length)
-{
-	uint8_t *bufp = dma->tx_buf + dma->cur_tx_index * TX_BUF_SIZE_ALIGNED;
-
-	/* kick off the dma */
-	size_t len = length;
-	int txout = dma->cur_tx_index;
-	uint32_t flags;
-	dma64dd_t *descp = NULL;
-	uint32_t ctrl;
-	uint32_t last_desc = (((uint32_t)dma->tx_desc_aligned) +
-			      sizeof(dma64dd_t)) & D64_XP_LD_MASK;
-	size_t buflen;
-
-	debug("%s enter\n", __func__);
-
-	/* load the buffer */
-	memcpy(bufp, packet, len);
-
-	/* Add 4 bytes for Ethernet FCS/CRC */
-	buflen = len + 4;
-
-	ctrl = (buflen & D64_CTRL2_BC_MASK);
-
-	/* the transmit will only be one frame or set SOF, EOF */
-	/* also set int on completion */
-	flags = D64_CTRL1_SOF | D64_CTRL1_IOC | D64_CTRL1_EOF;
-
-	/* txout points to the descriptor to uset */
-	/* if last descriptor then set EOT */
-	if (txout == (TX_BUF_NUM - 1)) {
-		flags |= D64_CTRL1_EOT;
-		last_desc = ((uint32_t)(dma->tx_desc_aligned)) & D64_XP_LD_MASK;
-	}
-
-	/* write the descriptor */
-	descp = ((dma64dd_t *)(dma->tx_desc_aligned)) + txout;
-	descp->addrlow = (uint32_t)bufp;
-	descp->addrhigh = 0;
-	descp->ctrl1 = flags;
-	descp->ctrl2 = ctrl;
-
-	/* flush descriptor and buffer */
-	flush_dcache_range((unsigned long)dma->tx_desc_aligned,
-			   (unsigned long)dma->tx_desc_aligned +
-			   DESCP_SIZE_ALIGNED * TX_BUF_NUM);
-	flush_dcache_range((unsigned long)bufp,
-			   (unsigned long)bufp + TX_BUF_SIZE_ALIGNED);
-
-	/* now update the dma last descriptor */
-	writel(last_desc, GMAC0_DMA_TX_PTR_ADDR);
-
-	/* tx dma should be enabled so packet should go out */
-
-	/* update txout */
-	dma->cur_tx_index = (txout + 1) & (TX_BUF_NUM - 1);
-
-	return 0;
-}
-
-bool gmac_check_tx_done(struct eth_dma *dma)
-{
-	/* wait for tx to complete */
-	uint32_t intstatus;
-	bool xfrdone = false;
-
-	debug("%s enter\n", __func__);
-
-	intstatus = readl(GMAC0_INT_STATUS_ADDR);
-
-	debug("int(0x%x)\n", intstatus);
-	if (intstatus & (I_XI0 | I_XI1 | I_XI2 | I_XI3)) {
-		xfrdone = true;
-		/* clear the int bits */
-		intstatus &= ~(I_XI0 | I_XI1 | I_XI2 | I_XI3);
-		writel(intstatus, GMAC0_INT_STATUS_ADDR);
-	} else {
-		debug("Tx int(0x%x)\n", intstatus);
-	}
-
-	return xfrdone;
-}
-
-int gmac_check_rx_done(struct eth_dma *dma, uint8_t *buf)
-{
-	void *bufp, *datap;
-	size_t rcvlen = 0, buflen = 0;
-	uint32_t stat0 = 0, stat1 = 0;
-	uint32_t control, offset;
-	uint8_t statbuf[HWRXOFF*2];
-
-	int index, curr, active;
-	dma64dd_t *descp = NULL;
-
-	/* udelay(50); */
-
-	/*
-	 * this api will check if a packet has been received.
-	 * If so it will return the address of the buffer and current
-	 * descriptor index will be incremented to the
-	 * next descriptor. Once done with the frame the buffer should be
-	 * added back onto the descriptor and the lastdscr should be updated
-	 * to this descriptor.
-	 */
-	index = dma->cur_rx_index;
-	offset = (uint32_t)(dma->rx_desc_aligned);
-	stat0 = readl(GMAC0_DMA_RX_STATUS0_ADDR) & D64_RS0_CD_MASK;
-	stat1 = readl(GMAC0_DMA_RX_STATUS1_ADDR) & D64_RS0_CD_MASK;
-	curr = ((stat0 - offset) & D64_RS0_CD_MASK) / sizeof(dma64dd_t);
-	active = ((stat1 - offset) & D64_RS0_CD_MASK) / sizeof(dma64dd_t);
-
-	/* check if any frame */
-	if (index == curr)
-		return -1;
-
-	debug("received packet\n");
-	debug("expect(0x%x) curr(0x%x) active(0x%x)\n", index, curr, active);
-	/* remove warning */
-	if (index == active)
-		;
-
-	/* get the packet pointer that corresponds to the rx descriptor */
-	bufp = dma->rx_buf + index * RX_BUF_SIZE_ALIGNED;
-
-	descp = (dma64dd_t *)(dma->rx_desc_aligned) + index;
-	/* flush descriptor and buffer */
-	flush_dcache_range((unsigned long)dma->rx_desc_aligned,
-			   (unsigned long)dma->rx_desc_aligned +
-			   DESCP_SIZE_ALIGNED * RX_BUF_NUM);
-	flush_dcache_range((unsigned long)bufp,
-			   (unsigned long)bufp + RX_BUF_SIZE_ALIGNED);
-
-	buflen = (descp->ctrl2 & D64_CTRL2_BC_MASK);
-
-	stat0 = readl(GMAC0_DMA_RX_STATUS0_ADDR);
-	stat1 = readl(GMAC0_DMA_RX_STATUS1_ADDR);
-
-	debug("bufp(0x%x) index(0x%x) buflen(0x%x) stat0(0x%x) stat1(0x%x)\n",
-	      (uint32_t)bufp, index, buflen, stat0, stat1);
-
-	dma->cur_rx_index = (index + 1) & (RX_BUF_NUM - 1);
-
-	/* get buffer offset */
-	control = readl(GMAC0_DMA_RX_CTRL_ADDR);
-	offset = (control & D64_RC_RO_MASK) >> D64_RC_RO_SHIFT;
-	rcvlen = *(uint16_t *)bufp;
-
-	debug("Received %d bytes\n", rcvlen);
-	/* copy status into temp buf then copy data from rx buffer */
-	memcpy(statbuf, bufp, offset);
-	datap = (void *)((uint32_t)bufp + offset);
-	memcpy(buf, datap, rcvlen);
-
-	/* update descriptor that is being added back on ring */
-	descp->ctrl2 = RX_BUF_SIZE_ALIGNED;
-	descp->addrlow = (uint32_t)bufp;
-	descp->addrhigh = 0;
-	/* flush descriptor */
-	flush_dcache_range((unsigned long)dma->rx_desc_aligned,
-			   (unsigned long)dma->rx_desc_aligned +
-			   DESCP_SIZE_ALIGNED * RX_BUF_NUM);
-
-	/* set the lastdscr for the rx ring */
-	writel(((uint32_t)descp) & D64_XP_LD_MASK, GMAC0_DMA_RX_PTR_ADDR);
-
-	return (int)rcvlen;
-}
-
-static int gmac_disable_dma(struct eth_dma *dma, int dir)
-{
-	int status;
-
-	debug("%s enter\n", __func__);
-
-	if (dir == MAC_DMA_TX) {
-		/* address PR8249/PR7577 issue */
-		/* suspend tx DMA first */
-		writel(D64_XC_SE, GMAC0_DMA_TX_CTRL_ADDR);
-		SPINWAIT(((status = (readl(GMAC0_DMA_TX_STATUS0_ADDR) &
-				     D64_XS0_XS_MASK)) !=
-			  D64_XS0_XS_DISABLED) &&
-			 (status != D64_XS0_XS_IDLE) &&
-			 (status != D64_XS0_XS_STOPPED), 10000);
-
-		/*
-		 * PR2414 WAR: DMA engines are not disabled until
-		 * transfer finishes
-		 */
-		writel(0, GMAC0_DMA_TX_CTRL_ADDR);
-		SPINWAIT(((status = (readl(GMAC0_DMA_TX_STATUS0_ADDR) &
-				     D64_XS0_XS_MASK)) !=
-			  D64_XS0_XS_DISABLED), 10000);
-
-		/* wait for the last transaction to complete */
-		udelay(2);
-
-		status = (status == D64_XS0_XS_DISABLED);
-	} else {
-		/*
-		 * PR2414 WAR: DMA engines are not disabled until
-		 * transfer finishes
-		 */
-		writel(0, GMAC0_DMA_RX_CTRL_ADDR);
-		SPINWAIT(((status = (readl(GMAC0_DMA_RX_STATUS0_ADDR) &
-				     D64_RS0_RS_MASK)) !=
-			  D64_RS0_RS_DISABLED), 10000);
-
-		status = (status == D64_RS0_RS_DISABLED);
-	}
-
-	return status;
-}
-
-static int gmac_enable_dma(struct eth_dma *dma, int dir)
-{
-	uint32_t control;
-
-	debug("%s enter\n", __func__);
-
-	if (dir == MAC_DMA_TX) {
-		dma->cur_tx_index = 0;
-
-		/*
-		 * These bits 20:18 (burstLen) of control register can be
-		 * written but will take effect only if these bits are
-		 * valid. So this will not affect previous versions
-		 * of the DMA. They will continue to have those bits set to 0.
-		 */
-		control = readl(GMAC0_DMA_TX_CTRL_ADDR);
-
-		control |= D64_XC_XE;
-		if ((g_dmactrlflags & DMA_CTRL_PEN) == 0)
-			control |= D64_XC_PD;
-
-		writel(control, GMAC0_DMA_TX_CTRL_ADDR);
-
-		/* initailize the DMA channel */
-		writel((uint32_t)(dma->tx_desc_aligned),
-		       GMAC0_DMA_TX_ADDR_LOW_ADDR);
-		writel(0, GMAC0_DMA_TX_ADDR_HIGH_ADDR);
-	} else {
-		dma->cur_rx_index = 0;
-
-		control = (readl(GMAC0_DMA_RX_CTRL_ADDR) &
-			   D64_RC_AE) | D64_RC_RE;
-
-		if ((g_dmactrlflags & DMA_CTRL_PEN) == 0)
-			control |= D64_RC_PD;
-
-		if (g_dmactrlflags & DMA_CTRL_ROC)
-			control |= D64_RC_OC;
-
-		/*
-		 * These bits 20:18 (burstLen) of control register can be
-		 * written but will take effect only if these bits are
-		 * valid. So this will not affect previous versions
-		 * of the DMA. They will continue to have those bits set to 0.
-		 */
-		control &= ~D64_RC_BL_MASK;
-		/* Keep default Rx burstlen */
-		control |= readl(GMAC0_DMA_RX_CTRL_ADDR) & D64_RC_BL_MASK;
-		control |= HWRXOFF << D64_RC_RO_SHIFT;
-
-		writel(control, GMAC0_DMA_RX_CTRL_ADDR);
-
-		/*
-		 * the rx descriptor ring should have
-		 * the addresses set properly;
-		 * set the lastdscr for the rx ring
-		 */
-		writel(((uint32_t)(dma->rx_desc_aligned) +
-			(RX_BUF_NUM - 1) * RX_BUF_SIZE_ALIGNED) &
-		       D64_XP_LD_MASK, GMAC0_DMA_RX_PTR_ADDR);
-	}
-
-	return 0;
-}
-
-bool gmac_mii_busywait(unsigned int timeout)
-{
-	uint32_t tmp = 0;
-
-	while (timeout > 10) {
-		tmp = readl(GMAC_MII_CTRL_ADDR);
-		if (tmp & (1 << GMAC_MII_BUSY_SHIFT)) {
-			udelay(10);
-			timeout -= 10;
-		} else {
-			break;
-		}
-	}
-	return tmp & (1 << GMAC_MII_BUSY_SHIFT);
-}
-
-int gmac_miiphy_read(struct mii_dev *bus, int phyaddr, int devad, int reg)
-{
-	uint32_t tmp = 0;
-	u16 value = 0;
-
-	/* Busy wait timeout is 1ms */
-	if (gmac_mii_busywait(1000)) {
-		pr_err("%s: Prepare MII read: MII/MDIO busy\n", __func__);
-		return -1;
-	}
-
-	/* Read operation */
-	tmp = GMAC_MII_DATA_READ_CMD;
-	tmp |= (phyaddr << GMAC_MII_PHY_ADDR_SHIFT) |
-		(reg << GMAC_MII_PHY_REG_SHIFT);
-	debug("MII read cmd 0x%x, phy 0x%x, reg 0x%x\n", tmp, phyaddr, reg);
-	writel(tmp, GMAC_MII_DATA_ADDR);
-
-	if (gmac_mii_busywait(1000)) {
-		pr_err("%s: MII read failure: MII/MDIO busy\n", __func__);
-		return -1;
-	}
-
-	value = readl(GMAC_MII_DATA_ADDR) & 0xffff;
-	debug("MII read data 0x%x\n", value);
-	return value;
-}
-
-int gmac_miiphy_write(struct mii_dev *bus, int phyaddr, int devad, int reg,
-		      u16 value)
-{
-	uint32_t tmp = 0;
-
-	/* Busy wait timeout is 1ms */
-	if (gmac_mii_busywait(1000)) {
-		pr_err("%s: Prepare MII write: MII/MDIO busy\n", __func__);
-		return -1;
-	}
-
-	/* Write operation */
-	tmp = GMAC_MII_DATA_WRITE_CMD | (value & 0xffff);
-	tmp |= ((phyaddr << GMAC_MII_PHY_ADDR_SHIFT) |
-		(reg << GMAC_MII_PHY_REG_SHIFT));
-	debug("MII write cmd 0x%x, phy 0x%x, reg 0x%x, data 0x%x\n",
-	      tmp, phyaddr, reg, value);
-	writel(tmp, GMAC_MII_DATA_ADDR);
-
-	if (gmac_mii_busywait(1000)) {
-		pr_err("%s: MII write failure: MII/MDIO busy\n", __func__);
-		return -1;
-	}
-
-	return 0;
-}
-
-void gmac_init_reset(void)
-{
-	debug("%s enter\n", __func__);
-
-	/* set command config reg CC_SR */
-	reg32_set_bits(UNIMAC0_CMD_CFG_ADDR, CC_SR);
-	udelay(GMAC_RESET_DELAY);
-}
-
-void gmac_clear_reset(void)
-{
-	debug("%s enter\n", __func__);
-
-	/* clear command config reg CC_SR */
-	reg32_clear_bits(UNIMAC0_CMD_CFG_ADDR, CC_SR);
-	udelay(GMAC_RESET_DELAY);
-}
-
-static void gmac_enable_local(bool en)
-{
-	uint32_t cmdcfg;
-
-	debug("%s enter\n", __func__);
-
-	/* read command config reg */
-	cmdcfg = readl(UNIMAC0_CMD_CFG_ADDR);
-
-	/* put mac in reset */
-	gmac_init_reset();
-
-	cmdcfg |= CC_SR;
-
-	/* first deassert rx_ena and tx_ena while in reset */
-	cmdcfg &= ~(CC_RE | CC_TE);
-	/* write command config reg */
-	writel(cmdcfg, UNIMAC0_CMD_CFG_ADDR);
-
-	/* bring mac out of reset */
-	gmac_clear_reset();
-
-	/* if not enable exit now */
-	if (!en)
-		return;
-
-	/* enable the mac transmit and receive paths now */
-	udelay(2);
-	cmdcfg &= ~CC_SR;
-	cmdcfg |= (CC_RE | CC_TE);
-
-	/* assert rx_ena and tx_ena when out of reset to enable the mac */
-	writel(cmdcfg, UNIMAC0_CMD_CFG_ADDR);
-
-	return;
-}
-
-int gmac_enable(void)
-{
-	gmac_enable_local(1);
-
-	/* clear interrupts */
-	writel(I_INTMASK, GMAC0_INT_STATUS_ADDR);
-	return 0;
-}
-
-int gmac_disable(void)
-{
-	gmac_enable_local(0);
-	return 0;
-}
-
-int gmac_set_speed(int speed, int duplex)
-{
-	uint32_t cmdcfg;
-	uint32_t hd_ena;
-	uint32_t speed_cfg;
-
-	hd_ena = duplex ? 0 : CC_HD;
-	if (speed == 1000) {
-		speed_cfg = 2;
-	} else if (speed == 100) {
-		speed_cfg = 1;
-	} else if (speed == 10) {
-		speed_cfg = 0;
-	} else {
-		pr_err("%s: Invalid GMAC speed(%d)!\n", __func__, speed);
-		return -1;
-	}
-
-	cmdcfg = readl(UNIMAC0_CMD_CFG_ADDR);
-	cmdcfg &= ~(CC_ES_MASK | CC_HD);
-	cmdcfg |= ((speed_cfg << CC_ES_SHIFT) | hd_ena);
-
-	printf("Change GMAC speed to %dMB\n", speed);
-	debug("GMAC speed cfg 0x%x\n", cmdcfg);
-	writel(cmdcfg, UNIMAC0_CMD_CFG_ADDR);
-
-	return 0;
-}
-
-int gmac_set_mac_addr(unsigned char *mac)
-{
-	/* set our local address */
-	debug("GMAC: %02x:%02x:%02x:%02x:%02x:%02x\n",
-	      mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
-	writel(htonl(*(uint32_t *)mac), UNIMAC0_MAC_MSB_ADDR);
-	writew(htons(*(uint32_t *)&mac[4]), UNIMAC0_MAC_LSB_ADDR);
-
-	return 0;
-}
-
-int gmac_mac_init(struct eth_device *dev)
-{
-	struct eth_info *eth = (struct eth_info *)(dev->priv);
-	struct eth_dma *dma = &(eth->dma);
-
-	uint32_t tmp;
-	uint32_t cmdcfg;
-	int chipid;
-
-	debug("%s enter\n", __func__);
-
-	/* Always use GMAC0 */
-	printf("Using GMAC%d\n", 0);
-
-	/* Reset AMAC0 core */
-	writel(0, AMAC0_IDM_RESET_ADDR);
-	tmp = readl(AMAC0_IO_CTRL_DIRECT_ADDR);
-	/* Set clock */
-	tmp &= ~(1 << AMAC0_IO_CTRL_CLK_250_SEL_SHIFT);
-	tmp |= (1 << AMAC0_IO_CTRL_GMII_MODE_SHIFT);
-	/* Set Tx clock */
-	tmp &= ~(1 << AMAC0_IO_CTRL_DEST_SYNC_MODE_EN_SHIFT);
-	writel(tmp, AMAC0_IO_CTRL_DIRECT_ADDR);
-
-	/* reset gmac */
-	/*
-	 * As AMAC is just reset, NO need?
-	 * set eth_data into loopback mode to ensure no rx traffic
-	 * gmac_loopback(eth_data, TRUE);
-	 * ET_TRACE(("%s gmac loopback\n", __func__));
-	 * udelay(1);
-	 */
-
-	cmdcfg = readl(UNIMAC0_CMD_CFG_ADDR);
-	cmdcfg &= ~(CC_TE | CC_RE | CC_RPI | CC_TAI | CC_HD | CC_ML |
-		    CC_CFE | CC_RL | CC_RED | CC_PE | CC_TPI |
-		    CC_PAD_EN | CC_PF);
-	cmdcfg |= (CC_PROM | CC_NLC | CC_CFE);
-	/* put mac in reset */
-	gmac_init_reset();
-	writel(cmdcfg, UNIMAC0_CMD_CFG_ADDR);
-	gmac_clear_reset();
-
-	/* enable clear MIB on read */
-	reg32_set_bits(GMAC0_DEV_CTRL_ADDR, DC_MROR);
-	/* PHY: set smi_master to drive mdc_clk */
-	reg32_set_bits(GMAC0_PHY_CTRL_ADDR, PC_MTE);
-
-	/* clear persistent sw intstatus */
-	writel(0, GMAC0_INT_STATUS_ADDR);
-
-	if (dma_init(dma) < 0) {
-		pr_err("%s: GMAC dma_init failed\n", __func__);
-		goto err_exit;
-	}
-
-	chipid = CHIPID;
-	printf("%s: Chip ID: 0x%x\n", __func__, chipid);
-
-	/* set switch bypass mode */
-	tmp = readl(SWITCH_GLOBAL_CONFIG_ADDR);
-	tmp |= (1 << CDRU_SWITCH_BYPASS_SWITCH_SHIFT);
-
-	/* Switch mode */
-	/* tmp &= ~(1 << CDRU_SWITCH_BYPASS_SWITCH_SHIFT); */
-
-	writel(tmp, SWITCH_GLOBAL_CONFIG_ADDR);
-
-	tmp = readl(CRMU_CHIP_IO_PAD_CONTROL_ADDR);
-	tmp &= ~(1 << CDRU_IOMUX_FORCE_PAD_IN_SHIFT);
-	writel(tmp, CRMU_CHIP_IO_PAD_CONTROL_ADDR);
-
-	/* Set MDIO to internal GPHY */
-	tmp = readl(GMAC_MII_CTRL_ADDR);
-	/* Select internal MDC/MDIO bus*/
-	tmp &= ~(1 << GMAC_MII_CTRL_BYP_SHIFT);
-	/* select MDC/MDIO connecting to on-chip internal PHYs */
-	tmp &= ~(1 << GMAC_MII_CTRL_EXT_SHIFT);
-	/*
-	 * give bit[6:0](MDCDIV) with required divisor to set
-	 * the MDC clock frequency, 66MHZ/0x1A=2.5MHZ
-	 */
-	tmp |= 0x1A;
-
-	writel(tmp, GMAC_MII_CTRL_ADDR);
-
-	if (gmac_mii_busywait(1000)) {
-		pr_err("%s: Configure MDIO: MII/MDIO busy\n", __func__);
-		goto err_exit;
-	}
-
-	/* Configure GMAC0 */
-	/* enable one rx interrupt per received frame */
-	writel(1 << GMAC0_IRL_FRAMECOUNT_SHIFT, GMAC0_INTR_RECV_LAZY_ADDR);
-
-	/* read command config reg */
-	cmdcfg = readl(UNIMAC0_CMD_CFG_ADDR);
-	/* enable 802.3x tx flow control (honor received PAUSE frames) */
-	cmdcfg &= ~CC_RPI;
-	/* enable promiscuous mode */
-	cmdcfg |= CC_PROM;
-	/* Disable loopback mode */
-	cmdcfg &= ~CC_ML;
-	/* set the speed */
-	cmdcfg &= ~(CC_ES_MASK | CC_HD);
-	/* Set to 1Gbps and full duplex by default */
-	cmdcfg |= (2 << CC_ES_SHIFT);
-
-	/* put mac in reset */
-	gmac_init_reset();
-	/* write register */
-	writel(cmdcfg, UNIMAC0_CMD_CFG_ADDR);
-	/* bring mac out of reset */
-	gmac_clear_reset();
-
-	/* set max frame lengths; account for possible vlan tag */
-	writel(PKTSIZE + 32, UNIMAC0_FRM_LENGTH_ADDR);
-
-	return 0;
-
-err_exit:
-	dma_deinit(dma);
-	return -1;
-}
-
-int gmac_add(struct eth_device *dev)
-{
-	struct eth_info *eth = (struct eth_info *)(dev->priv);
-	struct eth_dma *dma = &(eth->dma);
-	void *tmp;
-
-	/*
-	 * Desc has to be 16-byte aligned. But for dcache flush it must be
-	 * aligned to ARCH_DMA_MINALIGN.
-	 */
-	tmp = memalign(ARCH_DMA_MINALIGN, DESCP_SIZE_ALIGNED * TX_BUF_NUM);
-	if (tmp == NULL) {
-		printf("%s: Failed to allocate TX desc Buffer\n", __func__);
-		return -1;
-	}
-
-	dma->tx_desc_aligned = (void *)tmp;
-	debug("TX Descriptor Buffer: %p; length: 0x%x\n",
-	      dma->tx_desc_aligned, DESCP_SIZE_ALIGNED * TX_BUF_NUM);
-
-	tmp = memalign(ARCH_DMA_MINALIGN, TX_BUF_SIZE_ALIGNED * TX_BUF_NUM);
-	if (tmp == NULL) {
-		printf("%s: Failed to allocate TX Data Buffer\n", __func__);
-		free(dma->tx_desc_aligned);
-		return -1;
-	}
-	dma->tx_buf = (uint8_t *)tmp;
-	debug("TX Data Buffer: %p; length: 0x%x\n",
-	      dma->tx_buf, TX_BUF_SIZE_ALIGNED * TX_BUF_NUM);
-
-	/* Desc has to be 16-byte aligned */
-	tmp = memalign(ARCH_DMA_MINALIGN, DESCP_SIZE_ALIGNED * RX_BUF_NUM);
-	if (tmp == NULL) {
-		printf("%s: Failed to allocate RX Descriptor\n", __func__);
-		free(dma->tx_desc_aligned);
-		free(dma->tx_buf);
-		return -1;
-	}
-	dma->rx_desc_aligned = (void *)tmp;
-	debug("RX Descriptor Buffer: %p, length: 0x%x\n",
-	      dma->rx_desc_aligned, DESCP_SIZE_ALIGNED * RX_BUF_NUM);
-
-	tmp = memalign(ARCH_DMA_MINALIGN, RX_BUF_SIZE_ALIGNED * RX_BUF_NUM);
-	if (tmp == NULL) {
-		printf("%s: Failed to allocate RX Data Buffer\n", __func__);
-		free(dma->tx_desc_aligned);
-		free(dma->tx_buf);
-		free(dma->rx_desc_aligned);
-		return -1;
-	}
-	dma->rx_buf = (uint8_t *)tmp;
-	debug("RX Data Buffer: %p; length: 0x%x\n",
-	      dma->rx_buf, RX_BUF_SIZE_ALIGNED * RX_BUF_NUM);
-
-	g_dmactrlflags = 0;
-
-	eth->phy_interface = PHY_INTERFACE_MODE_GMII;
-
-	dma->tx_packet = gmac_tx_packet;
-	dma->check_tx_done = gmac_check_tx_done;
-
-	dma->check_rx_done = gmac_check_rx_done;
-
-	dma->enable_dma = gmac_enable_dma;
-	dma->disable_dma = gmac_disable_dma;
-
-	eth->miiphy_read = gmac_miiphy_read;
-	eth->miiphy_write = gmac_miiphy_write;
-
-	eth->mac_init = gmac_mac_init;
-	eth->disable_mac = gmac_disable;
-	eth->enable_mac = gmac_enable;
-	eth->set_mac_addr = gmac_set_mac_addr;
-	eth->set_mac_speed = gmac_set_speed;
-
-	return 0;
-}
diff --git a/drivers/net/bcm-sf2-eth-gmac.h b/drivers/net/bcm-sf2-eth-gmac.h
deleted file mode 100644
index ac5e45d4f906..000000000000
--- a/drivers/net/bcm-sf2-eth-gmac.h
+++ /dev/null
@@ -1,222 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2014 Broadcom Corporation.
- */
-
-#ifndef _BCM_SF2_ETH_GMAC_H_
-#define _BCM_SF2_ETH_GMAC_H_
-
-#define BCM_SF2_ETH_MAC_NAME	"gmac"
-
-#ifndef ETHHW_PORT_INT
-#define ETHHW_PORT_INT		8
-#endif
-
-#define GMAC0_REG_BASE			0x18042000
-#define GMAC0_DEV_CTRL_ADDR		GMAC0_REG_BASE
-#define GMAC0_INT_STATUS_ADDR		(GMAC0_REG_BASE + 0x020)
-#define GMAC0_INTR_RECV_LAZY_ADDR	(GMAC0_REG_BASE + 0x100)
-#define GMAC0_PHY_CTRL_ADDR		(GMAC0_REG_BASE + 0x188)
-
-#define GMAC_DMA_PTR_OFFSET		0x04
-#define GMAC_DMA_ADDR_LOW_OFFSET	0x08
-#define GMAC_DMA_ADDR_HIGH_OFFSET	0x0c
-#define GMAC_DMA_STATUS0_OFFSET		0x10
-#define GMAC_DMA_STATUS1_OFFSET		0x14
-
-#define GMAC0_DMA_TX_CTRL_ADDR		(GMAC0_REG_BASE + 0x200)
-#define GMAC0_DMA_TX_PTR_ADDR \
-		(GMAC0_DMA_TX_CTRL_ADDR + GMAC_DMA_PTR_OFFSET)
-#define GMAC0_DMA_TX_ADDR_LOW_ADDR \
-		(GMAC0_DMA_TX_CTRL_ADDR + GMAC_DMA_ADDR_LOW_OFFSET)
-#define GMAC0_DMA_TX_ADDR_HIGH_ADDR \
-		(GMAC0_DMA_TX_CTRL_ADDR + GMAC_DMA_ADDR_HIGH_OFFSET)
-#define GMAC0_DMA_TX_STATUS0_ADDR \
-		(GMAC0_DMA_TX_CTRL_ADDR + GMAC_DMA_STATUS0_OFFSET)
-#define GMAC0_DMA_TX_STATUS1_ADDR \
-		(GMAC0_DMA_TX_CTRL_ADDR + GMAC_DMA_STATUS1_OFFSET)
-
-#define GMAC0_DMA_RX_CTRL_ADDR		(GMAC0_REG_BASE + 0x220)
-#define GMAC0_DMA_RX_PTR_ADDR \
-		(GMAC0_DMA_RX_CTRL_ADDR + GMAC_DMA_PTR_OFFSET)
-#define GMAC0_DMA_RX_ADDR_LOW_ADDR \
-		(GMAC0_DMA_RX_CTRL_ADDR + GMAC_DMA_ADDR_LOW_OFFSET)
-#define GMAC0_DMA_RX_ADDR_HIGH_ADDR \
-		(GMAC0_DMA_RX_CTRL_ADDR + GMAC_DMA_ADDR_HIGH_OFFSET)
-#define GMAC0_DMA_RX_STATUS0_ADDR \
-		(GMAC0_DMA_RX_CTRL_ADDR + GMAC_DMA_STATUS0_OFFSET)
-#define GMAC0_DMA_RX_STATUS1_ADDR \
-		(GMAC0_DMA_RX_CTRL_ADDR + GMAC_DMA_STATUS1_OFFSET)
-
-#define UNIMAC0_CMD_CFG_ADDR		(GMAC0_REG_BASE + 0x808)
-#define UNIMAC0_MAC_MSB_ADDR		(GMAC0_REG_BASE + 0x80c)
-#define UNIMAC0_MAC_LSB_ADDR		(GMAC0_REG_BASE + 0x810)
-#define UNIMAC0_FRM_LENGTH_ADDR		(GMAC0_REG_BASE + 0x814)
-
-#define GMAC0_IRL_FRAMECOUNT_SHIFT	24
-
-/* transmit channel control */
-/* transmit enable */
-#define D64_XC_XE		0x00000001
-/* transmit suspend request */
-#define D64_XC_SE		0x00000002
-/* parity check disable */
-#define D64_XC_PD		0x00000800
-/* BurstLen bits */
-#define D64_XC_BL_MASK		0x001C0000
-#define D64_XC_BL_SHIFT		18
-
-/* transmit descriptor table pointer */
-/* last valid descriptor */
-#define D64_XP_LD_MASK		0x00001fff
-
-/* transmit channel status */
-/* transmit state */
-#define D64_XS0_XS_MASK		0xf0000000
-#define D64_XS0_XS_SHIFT	28
-#define D64_XS0_XS_DISABLED	0x00000000
-#define D64_XS0_XS_ACTIVE	0x10000000
-#define D64_XS0_XS_IDLE		0x20000000
-#define D64_XS0_XS_STOPPED	0x30000000
-#define D64_XS0_XS_SUSP		0x40000000
-
-/* receive channel control */
-/* receive enable */
-#define D64_RC_RE		0x00000001
-/* address extension bits */
-#define D64_RC_AE		0x00030000
-/* overflow continue */
-#define D64_RC_OC		0x00000400
-/* parity check disable */
-#define D64_RC_PD		0x00000800
-/* receive frame offset */
-#define D64_RC_RO_MASK		0x000000fe
-#define D64_RC_RO_SHIFT		1
-/* BurstLen bits */
-#define D64_RC_BL_MASK		0x001C0000
-#define D64_RC_BL_SHIFT		18
-
-/* flags for dma controller */
-/* partity enable */
-#define DMA_CTRL_PEN		(1 << 0)
-/* rx overflow continue */
-#define DMA_CTRL_ROC		(1 << 1)
-
-/* receive descriptor table pointer */
-/* last valid descriptor */
-#define D64_RP_LD_MASK		0x00001fff
-
-/* receive channel status */
-/* current descriptor pointer */
-#define D64_RS0_CD_MASK		0x00001fff
-/* receive state */
-#define D64_RS0_RS_MASK		0xf0000000
-#define D64_RS0_RS_SHIFT	28
-#define D64_RS0_RS_DISABLED	0x00000000
-#define D64_RS0_RS_ACTIVE	0x10000000
-#define D64_RS0_RS_IDLE		0x20000000
-#define D64_RS0_RS_STOPPED	0x30000000
-#define D64_RS0_RS_SUSP		0x40000000
-
-/* descriptor control flags 1 */
-/* core specific flags */
-#define D64_CTRL_COREFLAGS	0x0ff00000
-/* end of descriptor table */
-#define D64_CTRL1_EOT		((uint32_t)1 << 28)
-/* interrupt on completion */
-#define D64_CTRL1_IOC		((uint32_t)1 << 29)
-/* end of frame */
-#define D64_CTRL1_EOF		((uint32_t)1 << 30)
-/* start of frame */
-#define D64_CTRL1_SOF		((uint32_t)1 << 31)
-
-/* descriptor control flags 2 */
-/* buffer byte count. real data len must <= 16KB */
-#define D64_CTRL2_BC_MASK	0x00007fff
-/* address extension bits */
-#define D64_CTRL2_AE		0x00030000
-#define D64_CTRL2_AE_SHIFT	16
-/* parity bit */
-#define D64_CTRL2_PARITY	0x00040000
-/* control flags in the range [27:20] are core-specific and not defined here */
-#define D64_CTRL_CORE_MASK	0x0ff00000
-
-#define DC_MROR		0x00000010
-#define PC_MTE		0x00800000
-
-/* command config */
-#define CC_TE		0x00000001
-#define CC_RE		0x00000002
-#define CC_ES_MASK	0x0000000c
-#define CC_ES_SHIFT	2
-#define CC_PROM		0x00000010
-#define CC_PAD_EN	0x00000020
-#define CC_CF		0x00000040
-#define CC_PF		0x00000080
-#define CC_RPI		0x00000100
-#define CC_TAI		0x00000200
-#define CC_HD		0x00000400
-#define CC_HD_SHIFT	10
-#define CC_SR		0x00002000
-#define CC_ML		0x00008000
-#define CC_AE		0x00400000
-#define CC_CFE		0x00800000
-#define CC_NLC		0x01000000
-#define CC_RL		0x02000000
-#define CC_RED		0x04000000
-#define CC_PE		0x08000000
-#define CC_TPI		0x10000000
-#define CC_AT		0x20000000
-
-#define I_PDEE		0x00000400
-#define I_PDE		0x00000800
-#define I_DE		0x00001000
-#define I_RDU		0x00002000
-#define I_RFO		0x00004000
-#define I_XFU		0x00008000
-#define I_RI		0x00010000
-#define I_XI0		0x01000000
-#define I_XI1		0x02000000
-#define I_XI2		0x04000000
-#define I_XI3		0x08000000
-#define I_ERRORS	(I_PDEE | I_PDE | I_DE | I_RDU | I_RFO | I_XFU)
-#define DEF_INTMASK	(I_XI0 | I_XI1 | I_XI2 | I_XI3 | I_RI | I_ERRORS)
-
-#define I_INTMASK	0x0f01fcff
-
-#define CHIP_DRU_BASE				0x0301d000
-#define CRMU_CHIP_IO_PAD_CONTROL_ADDR		(CHIP_DRU_BASE + 0x0bc)
-#define SWITCH_GLOBAL_CONFIG_ADDR		(CHIP_DRU_BASE + 0x194)
-
-#define CDRU_IOMUX_FORCE_PAD_IN_SHIFT		0
-#define CDRU_SWITCH_BYPASS_SWITCH_SHIFT		13
-
-#define AMAC0_IDM_RESET_ADDR			0x18110800
-#define AMAC0_IO_CTRL_DIRECT_ADDR		0x18110408
-#define AMAC0_IO_CTRL_CLK_250_SEL_SHIFT		6
-#define AMAC0_IO_CTRL_GMII_MODE_SHIFT		5
-#define AMAC0_IO_CTRL_DEST_SYNC_MODE_EN_SHIFT	3
-
-#define CHIPA_CHIP_ID_ADDR			0x18000000
-#define CHIPID		(readl(CHIPA_CHIP_ID_ADDR) & 0xFFFF)
-#define CHIPREV		(((readl(CHIPA_CHIP_ID_ADDR) >> 16) & 0xF)
-#define CHIPSKU		(((readl(CHIPA_CHIP_ID_ADDR) >> 20) & 0xF)
-
-#define GMAC_MII_CTRL_ADDR		0x18002000
-#define GMAC_MII_CTRL_BYP_SHIFT		10
-#define GMAC_MII_CTRL_EXT_SHIFT		9
-#define GMAC_MII_DATA_ADDR		0x18002004
-#define GMAC_MII_DATA_READ_CMD		0x60020000
-#define GMAC_MII_DATA_WRITE_CMD		0x50020000
-#define GMAC_MII_BUSY_SHIFT		8
-#define GMAC_MII_PHY_ADDR_SHIFT		23
-#define GMAC_MII_PHY_REG_SHIFT		18
-
-#define GMAC_RESET_DELAY		2
-#define HWRXOFF				30
-#define MAXNAMEL			8
-#define NUMTXQ				4
-
-int gmac_add(struct eth_device *dev);
-
-#endif /* _BCM_SF2_ETH_GMAC_H_ */
diff --git a/drivers/net/bcm-sf2-eth.c b/drivers/net/bcm-sf2-eth.c
deleted file mode 100644
index c10719c6b510..000000000000
--- a/drivers/net/bcm-sf2-eth.c
+++ /dev/null
@@ -1,274 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2014 Broadcom Corporation.
- */
-
-#include <log.h>
-#include <malloc.h>
-#include <net.h>
-#include <config.h>
-#include <linux/delay.h>
-#include <linux/printk.h>
-
-#include <phy.h>
-#include <miiphy.h>
-
-#include <asm/io.h>
-
-#include <netdev.h>
-#include "bcm-sf2-eth.h"
-
-#if defined(CONFIG_BCM_SF2_ETH_GMAC)
-#include "bcm-sf2-eth-gmac.h"
-#else
-#error "bcm_sf2_eth: NEED to define a MAC!"
-#endif
-
-#define BCM_NET_MODULE_DESCRIPTION	"Broadcom Starfighter2 Ethernet driver"
-#define BCM_NET_MODULE_VERSION		"0.1"
-#define BCM_SF2_ETH_DEV_NAME		"bcm_sf2"
-
-static const char banner[] =
-	BCM_NET_MODULE_DESCRIPTION " " BCM_NET_MODULE_VERSION "\n";
-
-static int bcm_sf2_eth_init(struct eth_device *dev)
-{
-	struct eth_info *eth = (struct eth_info *)(dev->priv);
-	struct eth_dma *dma = &(eth->dma);
-	struct phy_device *phydev;
-	int rc = 0;
-	int i;
-
-	rc = eth->mac_init(dev);
-	if (rc) {
-		pr_err("%s: Couldn't cofigure MAC!\n", __func__);
-		return rc;
-	}
-
-	/* disable DMA */
-	dma->disable_dma(dma, MAC_DMA_RX);
-	dma->disable_dma(dma, MAC_DMA_TX);
-
-	eth->port_num = 0;
-	debug("Connecting PHY 0...\n");
-	phydev = phy_connect(miiphy_get_dev_by_name(dev->name),
-			     -1, dev, eth->phy_interface);
-	if (phydev != NULL) {
-		eth->port[0] = phydev;
-		eth->port_num += 1;
-	} else {
-		debug("No PHY found for port 0\n");
-	}
-
-	for (i = 0; i < eth->port_num; i++)
-		phy_config(eth->port[i]);
-
-	return rc;
-}
-
-/*
- * u-boot net functions
- */
-
-static int bcm_sf2_eth_send(struct eth_device *dev, void *packet, int length)
-{
-	struct eth_dma *dma = &(((struct eth_info *)(dev->priv))->dma);
-	uint8_t *buf = (uint8_t *)packet;
-	int rc = 0;
-	int i = 0;
-
-	debug("%s enter\n", __func__);
-
-	/* load buf and start transmit */
-	rc = dma->tx_packet(dma, buf, length);
-	if (rc) {
-		debug("ERROR - Tx failed\n");
-		return rc;
-	}
-
-	while (!(dma->check_tx_done(dma))) {
-		udelay(100);
-		debug(".");
-		i++;
-		if (i > 20) {
-			pr_err("%s: Tx timeout: retried 20 times\n", __func__);
-			rc = -1;
-			break;
-		}
-	}
-
-	debug("%s exit rc(0x%x)\n", __func__, rc);
-	return rc;
-}
-
-static int bcm_sf2_eth_receive(struct eth_device *dev)
-{
-	struct eth_dma *dma = &(((struct eth_info *)(dev->priv))->dma);
-	uint8_t *buf = (uint8_t *)net_rx_packets[0];
-	int rcvlen;
-	int rc = 0;
-	int i = 0;
-
-	while (1) {
-		/* Poll Rx queue to get a packet */
-		rcvlen = dma->check_rx_done(dma, buf);
-		if (rcvlen < 0) {
-			/* No packet received */
-			rc = -1;
-			debug("\nNO More Rx\n");
-			break;
-		} else if ((rcvlen == 0) || (rcvlen > RX_BUF_SIZE)) {
-			pr_err("%s: Wrong Ethernet packet size (%d B), skip!\n",
-			      __func__, rcvlen);
-			break;
-		} else {
-			debug("recieved\n");
-
-			/* Forward received packet to uboot network handler */
-			net_process_received_packet(buf, rcvlen);
-
-			if (++i >= PKTBUFSRX)
-				i = 0;
-			buf = net_rx_packets[i];
-		}
-	}
-
-	return rc;
-}
-
-static int bcm_sf2_eth_write_hwaddr(struct eth_device *dev)
-{
-	struct eth_info *eth = (struct eth_info *)(dev->priv);
-
-	printf(" ETH MAC: %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       dev->enetaddr[0], dev->enetaddr[1], dev->enetaddr[2],
-	       dev->enetaddr[3], dev->enetaddr[4], dev->enetaddr[5]);
-
-	return eth->set_mac_addr(dev->enetaddr);
-}
-
-static int bcm_sf2_eth_open(struct eth_device *dev, struct bd_info *bt)
-{
-	struct eth_info *eth = (struct eth_info *)(dev->priv);
-	struct eth_dma *dma = &(eth->dma);
-	int i;
-
-	debug("Enabling BCM SF2 Ethernet.\n");
-
-	eth->enable_mac();
-
-	/* enable tx and rx DMA */
-	dma->enable_dma(dma, MAC_DMA_RX);
-	dma->enable_dma(dma, MAC_DMA_TX);
-
-	/*
-	 * Need to start PHY here because link speed can change
-	 * before each ethernet operation
-	 */
-	for (i = 0; i < eth->port_num; i++) {
-		if (phy_startup(eth->port[i])) {
-			pr_err("%s: PHY %d startup failed!\n", __func__, i);
-			if (i == CONFIG_BCM_SF2_ETH_DEFAULT_PORT) {
-				pr_err("%s: No default port %d!\n", __func__, i);
-				return -1;
-			}
-		}
-	}
-
-	/* Set MAC speed using default port */
-	i = CONFIG_BCM_SF2_ETH_DEFAULT_PORT;
-	debug("PHY %d: speed:%d, duplex:%d, link:%d\n", i,
-	      eth->port[i]->speed, eth->port[i]->duplex, eth->port[i]->link);
-	eth->set_mac_speed(eth->port[i]->speed, eth->port[i]->duplex);
-
-	debug("Enable Ethernet Done.\n");
-
-	return 0;
-}
-
-static void bcm_sf2_eth_close(struct eth_device *dev)
-{
-	struct eth_info *eth = (struct eth_info *)(dev->priv);
-	struct eth_dma *dma = &(eth->dma);
-
-	/* disable DMA */
-	dma->disable_dma(dma, MAC_DMA_RX);
-	dma->disable_dma(dma, MAC_DMA_TX);
-
-	eth->disable_mac();
-}
-
-int bcm_sf2_eth_register(struct bd_info *bis, u8 dev_num)
-{
-	struct eth_device *dev;
-	struct eth_info *eth;
-	int rc;
-
-	dev = (struct eth_device *)malloc(sizeof(struct eth_device));
-	if (dev == NULL) {
-		pr_err("%s: Not enough memory!\n", __func__);
-		return -1;
-	}
-
-	eth = (struct eth_info *)malloc(sizeof(struct eth_info));
-	if (eth == NULL) {
-		pr_err("%s: Not enough memory!\n", __func__);
-		return -1;
-	}
-
-	printf(banner);
-
-	memset(dev, 0, sizeof(*dev));
-	sprintf(dev->name, "%s_%s-%hu", BCM_SF2_ETH_DEV_NAME,
-		BCM_SF2_ETH_MAC_NAME, dev_num);
-
-	dev->priv = (void *)eth;
-	dev->iobase = 0;
-
-	dev->init = bcm_sf2_eth_open;
-	dev->halt = bcm_sf2_eth_close;
-	dev->send = bcm_sf2_eth_send;
-	dev->recv = bcm_sf2_eth_receive;
-	dev->write_hwaddr = bcm_sf2_eth_write_hwaddr;
-
-#ifdef CONFIG_BCM_SF2_ETH_GMAC
-	if (gmac_add(dev)) {
-		free(eth);
-		free(dev);
-		pr_err("%s: Adding GMAC failed!\n", __func__);
-		return -1;
-	}
-#else
-#error "bcm_sf2_eth: NEED to register a MAC!"
-#endif
-
-	eth_register(dev);
-
-#ifdef CONFIG_CMD_MII
-	int retval;
-	struct mii_dev *mdiodev = mdio_alloc();
-
-	if (!mdiodev)
-		return -ENOMEM;
-	strlcpy(mdiodev->name, dev->name, MDIO_NAME_LEN);
-	mdiodev->read = eth->miiphy_read;
-	mdiodev->write = eth->miiphy_write;
-
-	retval = mdio_register(mdiodev);
-	if (retval < 0)
-		return retval;
-#endif
-
-	/* Initialization */
-	debug("Ethernet initialization ...");
-
-	rc = bcm_sf2_eth_init(dev);
-	if (rc != 0) {
-		pr_err("%s: configuration failed!\n", __func__);
-		return -1;
-	}
-
-	printf("Basic ethernet functionality initialized\n");
-
-	return 0;
-}
diff --git a/drivers/net/bcm-sf2-eth.h b/drivers/net/bcm-sf2-eth.h
deleted file mode 100644
index f4dbb4e1952d..000000000000
--- a/drivers/net/bcm-sf2-eth.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2014-2017 Broadcom.
- */
-
-#ifndef _BCM_SF2_ETH_H_
-#define _BCM_SF2_ETH_H_
-
-#include <phy.h>
-
-#define RX_BUF_SIZE	2048
-/* RX_BUF_NUM must be power of 2 */
-#define RX_BUF_NUM	32
-
-#define TX_BUF_SIZE	2048
-/* TX_BUF_NUM must be power of 2 */
-#define TX_BUF_NUM	2
-
-/* Support 2 Ethernet ports now */
-#define BCM_ETH_MAX_PORT_NUM	2
-
-enum {
-	MAC_DMA_TX = 1,
-	MAC_DMA_RX = 2
-};
-
-struct eth_dma {
-	void *tx_desc_aligned;
-	void *rx_desc_aligned;
-
-	uint8_t *tx_buf;
-	uint8_t *rx_buf;
-
-	int cur_tx_index;
-	int cur_rx_index;
-
-	int (*tx_packet)(struct eth_dma *dma, void *packet, int length);
-	bool (*check_tx_done)(struct eth_dma *dma);
-
-	int (*check_rx_done)(struct eth_dma *dma, uint8_t *buf);
-
-	int (*enable_dma)(struct eth_dma *dma, int dir);
-	int (*disable_dma)(struct eth_dma *dma, int dir);
-};
-
-struct eth_info {
-	struct eth_dma dma;
-	phy_interface_t phy_interface;
-	struct phy_device *port[BCM_ETH_MAX_PORT_NUM];
-	int port_num;
-
-	int (*miiphy_read)(struct mii_dev *bus, int phyaddr, int devad,
-			   int reg);
-	int (*miiphy_write)(struct mii_dev *bus, int phyaddr, int devad,
-			    int reg, u16 value);
-
-	int (*mac_init)(struct eth_device *dev);
-	int (*enable_mac)(void);
-	int (*disable_mac)(void);
-	int (*set_mac_addr)(unsigned char *mac);
-	int (*set_mac_speed)(int speed, int duplex);
-
-};
-
-#endif /* _BCM_SF2_ETH_H_ */
diff --git a/include/configs/bcm_ns3.h b/include/configs/bcm_ns3.h
index 7c6e0725a6c3..8584b2b99c6e 100644
--- a/include/configs/bcm_ns3.h
+++ b/include/configs/bcm_ns3.h
@@ -44,20 +44,11 @@
 
 #define PCIE_ARGS "pcie_args=pci=pcie_bus_safe pcie_ports=native vfio_pci.disable_idle_d3=1\0"
 
-#ifdef CONFIG_BCM_SF2_ETH
-#define BCM_ETH_ADDR "ethaddr=00:0A:F7:95:65:A4\0"
-#define NET_ARGS "bgmac_platform.ethaddr=${ethaddr} " \
-	"ip=${ipaddr}::${gatewayip}:${netmask}::${ethif}:off"
-#else
-#define BMC_ETH_ADDR
-#define NET_ARGS
-#endif
-
 #define RESERVED_MEM "reserved_mem=memmap=0xff000000$0x1000000\0"
 
 #define BASE_ARGS "${console_args} ${extra_args} ${pcie_args}" \
 		  " ${max_cpus}  ${log_level} ${reserved_mem}"
-#define SETBOOTARGS "setbootargs=setenv bootargs " BASE_ARGS " " NET_ARGS "\0"
+#define SETBOOTARGS "setbootargs=setenv bootargs " BASE_ARGS "\0"
 
 #define UPDATEME_FLASH_PARAMS "bcm_compat_level=4\0" \
 			      "bcm_need_recovery_rootfs=0\0" \
@@ -749,7 +740,6 @@
 	OS_LOG_LEVEL \
 	EXTRA_ARGS \
 	PCIE_ARGS \
-	BMC_ETH_ADDR \
 	RESERVED_MEM \
 	SETBOOTARGS \
 	UPDATEME_FLASH_PARAMS \
-- 
2.43.0

