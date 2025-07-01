Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBD4C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6903382F14;
	Tue,  1 Jul 2025 20:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bsfrurF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9274782F14; Tue,  1 Jul 2025 20:42:37 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE738003E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ea83f382c3so4047552fac.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395354; x=1752000154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=K9KLJeVgr0+T9EDgdKdClAYegB2/lh4fyJePSyNMHwI=;
 b=bsfrurF0Esi3Pz5EXKhYFFQP95QJhQyk13FXHqUc8ahSH82ueDcvAXaBkazLCkvwS7
 T8ijOVeI6j0vefFHKYMeRyLJor036NbJseP7WE4/FV0K0n1LXfTq6EbkUjKOu1gbS0Hs
 jC9NGu+cLNfS5hondrh539DMpJ5aQGSK+nUDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395354; x=1752000154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K9KLJeVgr0+T9EDgdKdClAYegB2/lh4fyJePSyNMHwI=;
 b=WEVuEO+mB7GU+/TIyaQydR5zXOQVY8vPj6wxv94OmJn8JFfhch3t0Vk+xYF0s6Xx0p
 Dmqe/y6DaAkJMmmoi7vMXO4xNiQjASRk9GZxXSs/bjO/3kbhH0c/c0MF/pL2TOn1GyHT
 IuQteTCCiWaZNChoOHBys4Gv0bLvQ1qED8FjW7/tx8ABj8SLwrGx3SQpEPHl9mEbH2RC
 qVw7xYoHyhIvG293CRaNDep0wqHWx6zZAON7C2FyBE4Ex2zE15CnSUc0I9UKluCcHEuV
 vzgkw9SiUWpIW6mE6SC8tgSxOphqJMzWHSBMnQqB2mDGFlV+z9qJEZAUjHpBksvABSAc
 V+Rg==
X-Gm-Message-State: AOJu0YyNXJ8TSBLDyBUW13GjZK5Bk1/tzhnDwtyqWdeWsVmyqigOKKkC
 OSn5nWrW1v1eBSRvup8zVMcLwkk8A+hCRldslqAMym9VvbqJZodgnbKv2ytB06bavPNBB9LCNLe
 zvwwjLyk=
X-Gm-Gg: ASbGncvfMnySuA4HN5E2F+ZG9BqJRFu+IlrL8ibeMQeOJdUR5oH8g0FpbonZ4ErKfD3
 qMW+bokyPEj67OEQKaUYKXhr5RLD9BW1eAIniLKPKrIgdE4b2K+3I4/T7UUqDCEKcqzxiiP+Bfq
 9Js7Ocz1vfuC8327PqzonjueIRTZIH0VfRLRsVGbj7dV7lfaqaSZDRpIbOkxE54ugNWNvWG5fMJ
 1GYo6EN0ZByMHEsp3FJOx9PqZUGOT9G448CPg+YdADyZXQSeXx/tYvt8f3kr8fWG1dyei0zHKsN
 0JLJzt8kMkYglA1ObWqQk7g2jKilEyteG0aXvgRBc3us8PYDXg5y4oRVx5vm6rJFiQOqAbMfQfA
 29sQnFaq/ah9TcimN+XGxkLXsuw==
X-Google-Smtp-Source: AGHT+IFoZ6DTF/yIM02k+/yuTmLFI/A2zi+dGyJ6J5N/t1aMyppT1Im86L+SbvcKEV/FiVdvZbXWKg==
X-Received: by 2002:a05:6871:2b08:b0:2b7:d3d2:ba53 with SMTP id
 586e51a60fabf-2efed46efb4mr13170301fac.12.1751395353748; 
 Tue, 01 Jul 2025 11:42:33 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb100876sm2186174a34.49.2025.07.01.11.42.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:42:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] dma: Remove lpc32x_dma driver
Date: Tue,  1 Jul 2025 12:42:32 -0600
Message-ID: <20250701184232.3191405-1-trini@konsulko.com>
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

This driver has no users after we removed the last supported platform in
2024.

Fixes: 26ed58b40f58 ("arm: Remove devkit3250 board")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/dma/Kconfig       |  10 ---
 drivers/dma/Makefile      |   1 -
 drivers/dma/lpc32xx_dma.c | 150 --------------------------------------
 3 files changed, 161 deletions(-)
 delete mode 100644 drivers/dma/lpc32xx_dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 4b47be6b016b..e8ef90e2bd6a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -35,16 +35,6 @@ config BCM6348_IUDMA
 	  This driver support data transfer from devices to
 	  memory and from memory to devices.
 
-config DMA_LPC32XX
-	bool "LPC32XX DMA driver"
-	select DMA_LEGACY
-	help
-	  Enable some legacy DMA code for lpc32xx. It provides some direct
-	  functions likes lpc32xx_dma_wait_status() which can be called from
-	  other code.
-
-	  This should be converted to use driver model and UCLASS_DMA.
-
 config TI_EDMA3
 	bool "TI EDMA3 driver"
 	select DMA_LEGACY
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 00d765864cdc..fde26c2a886f 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_FSL_DMA) += fsl_dma.o
 obj-$(CONFIG_SANDBOX_DMA) += sandbox-dma-test.o
 obj-$(CONFIG_TI_KSNAV) += keystone_nav.o keystone_nav_cfg.o
 obj-$(CONFIG_TI_EDMA3) += ti-edma3.o
-obj-$(CONFIG_DMA_LPC32XX) += lpc32xx_dma.o
 obj-$(CONFIG_XILINX_DPDMA) += xilinx_dpdma.o
 obj-$(CONFIG_ADI_DMA) += adi_dma.o
 
diff --git a/drivers/dma/lpc32xx_dma.c b/drivers/dma/lpc32xx_dma.c
deleted file mode 100644
index f15b67546a9f..000000000000
--- a/drivers/dma/lpc32xx_dma.c
+++ /dev/null
@@ -1,150 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2008 by NXP Semiconductors
- * @Author: Kevin Wells
- * @Descr: LPC3250 DMA controller interface support functions
- *
- * Copyright (c) 2015 Tyco Fire Protection Products.
- */
-
-#include <errno.h>
-#include <init.h>
-#include <time.h>
-#include <asm/arch/dma.h>
-#include <asm/arch/cpu.h>
-#include <asm/arch/clk.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/io.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/printk.h>
-
-/* DMA controller channel register structure */
-struct dmac_chan_reg {
-	u32 src_addr;
-	u32 dest_addr;
-	u32 lli;
-	u32 control;
-	u32 config_ch;
-	u32 reserved[3];
-};
-
-/* DMA controller register structures */
-struct dma_reg {
-	u32 int_stat;
-	u32 int_tc_stat;
-	u32 int_tc_clear;
-	u32 int_err_stat;
-	u32 int_err_clear;
-	u32 raw_tc_stat;
-	u32 raw_err_stat;
-	u32 chan_enable;
-	u32 sw_burst_req;
-	u32 sw_single_req;
-	u32 sw_last_burst_req;
-	u32 sw_last_single_req;
-	u32 config;
-	u32 sync;
-	u32 reserved[50];
-	struct dmac_chan_reg dma_chan[8];
-};
-
-#define DMA_NO_OF_CHANNELS	8
-
-/* config register definitions */
-#define DMAC_CTRL_ENABLE	(1 << 0) /* For enabling the DMA controller */
-
-static u32 alloc_ch;
-
-static struct dma_reg *dma = (struct dma_reg *)DMA_BASE;
-
-int lpc32xx_dma_get_channel(void)
-{
-	int i;
-
-	if (!alloc_ch) { /* First time caller */
-		/*
-		 * DMA clock are enable by "lpc32xx_dma_init()" and should
-		 * be call by board "board_early_init_f()" function.
-		 */
-
-		/*
-		 * Make sure DMA controller and all channels are disabled.
-		 * Controller is in little-endian mode. Disable sync signals.
-		 */
-		writel(0, &dma->config);
-		writel(0, &dma->sync);
-
-		/* Clear interrupt and error statuses */
-		writel(0xFF, &dma->int_tc_clear);
-		writel(0xFF, &dma->raw_tc_stat);
-		writel(0xFF, &dma->int_err_clear);
-		writel(0xFF, &dma->raw_err_stat);
-
-		/* Enable DMA controller */
-		writel(DMAC_CTRL_ENABLE, &dma->config);
-	}
-
-	i = ffz(alloc_ch);
-
-	/* Check if all the available channels are busy */
-	if (unlikely(i == DMA_NO_OF_CHANNELS))
-		return -1;
-	alloc_ch |= BIT_MASK(i);
-	return i;
-}
-
-int lpc32xx_dma_start_xfer(unsigned int channel,
-			   const struct lpc32xx_dmac_ll *desc, u32 config)
-{
-	if (unlikely(((BIT_MASK(channel) & alloc_ch) == 0) ||
-		     (channel >= DMA_NO_OF_CHANNELS))) {
-		pr_err("Request for xfer on unallocated channel %d", channel);
-		return -1;
-	}
-	writel(BIT_MASK(channel), &dma->int_tc_clear);
-	writel(BIT_MASK(channel), &dma->int_err_clear);
-	writel(desc->dma_src, &dma->dma_chan[channel].src_addr);
-	writel(desc->dma_dest, &dma->dma_chan[channel].dest_addr);
-	writel(desc->next_lli, &dma->dma_chan[channel].lli);
-	writel(desc->next_ctrl, &dma->dma_chan[channel].control);
-	writel(config, &dma->dma_chan[channel].config_ch);
-
-	return 0;
-}
-
-int lpc32xx_dma_wait_status(unsigned int channel)
-{
-	unsigned long start;
-	u32 reg;
-
-	/* Check if given channel is valid */
-	if (unlikely(channel >= DMA_NO_OF_CHANNELS)) {
-		pr_err("Request for status on unallocated channel %d", channel);
-		return -1;
-	}
-
-	start = get_timer(0);
-	while (1) {
-		reg = readl(&dma->raw_tc_stat);
-		reg |= readl(dma->raw_err_stat);
-		if (reg & BIT_MASK(channel))
-			break;
-
-		if (get_timer(start) > CONFIG_SYS_HZ) {
-			pr_err("DMA status timeout channel %d\n", channel);
-			return -ETIMEDOUT;
-		}
-		udelay(1);
-	}
-
-	if (unlikely(readl(&dma->raw_err_stat) & BIT_MASK(channel))) {
-		setbits_le32(&dma->int_err_clear, BIT_MASK(channel));
-		setbits_le32(&dma->raw_err_stat, BIT_MASK(channel));
-		pr_err("DMA error on channel %d\n", channel);
-		return -1;
-	}
-	setbits_le32(&dma->int_tc_clear, BIT_MASK(channel));
-	setbits_le32(&dma->raw_tc_stat, BIT_MASK(channel));
-	return 0;
-}
-- 
2.43.0

