Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F534CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF5286FA9;
	Sun, 15 Oct 2023 09:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pqyowirH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MfPeMfOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A01386EED; Sun, 15 Oct 2023 08:58:49 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30AA86E2F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S7GgZ6dmRz9scX;
 Sat, 14 Oct 2023 23:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697318874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b34bgLJSYop1VxQUrdOZaTb9tcR7rEv3O9T5wZhWbJo=;
 b=pqyowirHr0w24CRnH64PUVHWjuUylXy9fLZVLrz20/Pf1t/ey+Mnwb6NeSgH8cvp0TDkXB
 KyTUOfP8AYH0q9ZyDmvORTIjcRQttuVbsGRscDgcr8ZaEQNQZa65SNcnlQwHfAlpbiayQs
 sG8h13t+D1Fl+EV7F5bldJqaM4DQQyLL7MfnLwq5zLvQQNxdNYAjOxllwzttKL2k8HN9wk
 IiFK/GhgdzlkgFhTIPf2YOl70y8Z8f0dVShY4ulqOHVoTd7Bl0wPH2rz3N4RlEINlBfnXx
 uzt+cHy9BDAXgfYUBXWPBlyWqoiSKE6RRatq7GJImTrWaYKjWp0t1UBVidgxaA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697318873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b34bgLJSYop1VxQUrdOZaTb9tcR7rEv3O9T5wZhWbJo=;
 b=MfPeMfOID/gAsTp/J5iWOK6/h6XsyXoOsSFrojz1cb3DT/WLzYAW5EnfqPdroG+/L5gxlT
 sTqov9E7cHKuRJA7odSd9SXWDirdvCuHRoKVOdcQgn7yEhFL2EVPC2rvF6aY/M4e53+SWU
 yXJrfF5mxB7HgFmXdBv5O1Rex0jvzAmmgxy2Ju46Bt+WkNEXxU+xcDIIDNFGpSYkyXJhoh
 MRqVyAKQvdQPXqXDx4DJHOKotBrboj0XkGQR1rIDBeG7pWZm5HeOHIKkmI/0V1DoeKRVcN
 ex9FaHFUaH7dZTKTFu/5rQrNeOWQOgbj83Ww77+/k7nVZt3Zp9gRnOowxnAhZQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: sh_sdhi: Drop unused driver
Date: Sat, 14 Oct 2023 23:27:24 +0200
Message-ID: <20231014212739.92483-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 414451ba408e581f4f4
X-MBO-RS-META: n9xirwwi5pf57eshm37ujrrt4uizd6nr
X-Rspamd-Queue-Id: 4S7GgZ6dmRz9scX
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

This driver is long superseded by renesas-sdhi.c and unused.
Drop the driver.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/Kconfig   |   6 -
 drivers/mmc/Makefile  |   1 -
 drivers/mmc/sh_sdhi.c | 910 ------------------------------------------
 3 files changed, 917 deletions(-)
 delete mode 100644 drivers/mmc/sh_sdhi.c

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index de01b9687ba..726c8d8f705 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -390,12 +390,6 @@ config HSMMC2_8BIT
 	depends on MMC_OMAP_HS && (OMAP44XX || OMAP54XX || DRA7XX || AM33XX || \
 		AM43XX || ARCH_KEYSTONE)
 
-config SH_SDHI
-	bool "SuperH/Renesas ARM SoCs on-chip SDHI host controller support"
-	depends on ARCH_RMOBILE
-	help
-	  Support for the on-chip SDHI host controller on SuperH/Renesas ARM SoCs platform
-
 config SH_MMCIF
 	bool "SuperH/Renesas ARM SoCs on-chip MMCIF host controller support"
 	depends on ARCH_RMOBILE || SH
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 2c65c4765ab..e9cf1fcc640 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_MMC_PCI)			+= pci_mmc.o
 obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
 obj-$(CONFIG_MMC_SANDBOX)		+= sandbox_mmc.o
 obj-$(CONFIG_SH_MMCIF) += sh_mmcif.o
-obj-$(CONFIG_SH_SDHI) += sh_sdhi.o
 obj-$(CONFIG_STM32_SDMMC2) += stm32_sdmmc2.o
 obj-$(CONFIG_JZ47XX_MMC) += jz_mmc.o
 obj-$(CONFIG_NEXELL_DWMMC) += nexell_dw_mmc.o
diff --git a/drivers/mmc/sh_sdhi.c b/drivers/mmc/sh_sdhi.c
deleted file mode 100644
index 3ce7cbf71f8..00000000000
--- a/drivers/mmc/sh_sdhi.c
+++ /dev/null
@@ -1,910 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * drivers/mmc/sh_sdhi.c
- *
- * SD/MMC driver for Renesas rmobile ARM SoCs.
- *
- * Copyright (C) 2011,2013-2017 Renesas Electronics Corporation
- * Copyright (C) 2014 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
- * Copyright (C) 2008-2009 Renesas Solutions Corp.
- */
-
-#include <common.h>
-#include <log.h>
-#include <malloc.h>
-#include <mmc.h>
-#include <dm.h>
-#include <part.h>
-#include <dm/device_compat.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/compat.h>
-#include <linux/io.h>
-#include <linux/sizes.h>
-#include <asm/arch/rmobile.h>
-#include <asm/arch/sh_sdhi.h>
-#include <asm/global_data.h>
-#include <clk.h>
-
-#define DRIVER_NAME "sh-sdhi"
-
-struct sh_sdhi_host {
-	void __iomem *addr;
-	int ch;
-	int bus_shift;
-	unsigned long quirks;
-	unsigned char wait_int;
-	unsigned char sd_error;
-	unsigned char detect_waiting;
-	unsigned char app_cmd;
-};
-
-static inline void sh_sdhi_writeq(struct sh_sdhi_host *host, int reg, u64 val)
-{
-	writeq(val, host->addr + (reg << host->bus_shift));
-}
-
-static inline u64 sh_sdhi_readq(struct sh_sdhi_host *host, int reg)
-{
-	return readq(host->addr + (reg << host->bus_shift));
-}
-
-static inline void sh_sdhi_writew(struct sh_sdhi_host *host, int reg, u16 val)
-{
-	writew(val, host->addr + (reg << host->bus_shift));
-}
-
-static inline u16 sh_sdhi_readw(struct sh_sdhi_host *host, int reg)
-{
-	return readw(host->addr + (reg << host->bus_shift));
-}
-
-static void sh_sdhi_detect(struct sh_sdhi_host *host)
-{
-	sh_sdhi_writew(host, SDHI_OPTION,
-		       OPT_BUS_WIDTH_1 | sh_sdhi_readw(host, SDHI_OPTION));
-
-	host->detect_waiting = 0;
-}
-
-static int sh_sdhi_intr(void *dev_id)
-{
-	struct sh_sdhi_host *host = dev_id;
-	int state1 = 0, state2 = 0;
-
-	state1 = sh_sdhi_readw(host, SDHI_INFO1);
-	state2 = sh_sdhi_readw(host, SDHI_INFO2);
-
-	debug("%s: state1 = %x, state2 = %x\n", __func__, state1, state2);
-
-	/* CARD Insert */
-	if (state1 & INFO1_CARD_IN) {
-		sh_sdhi_writew(host, SDHI_INFO1, ~INFO1_CARD_IN);
-		if (!host->detect_waiting) {
-			host->detect_waiting = 1;
-			sh_sdhi_detect(host);
-		}
-		sh_sdhi_writew(host, SDHI_INFO1_MASK, INFO1M_RESP_END |
-			       INFO1M_ACCESS_END | INFO1M_CARD_IN |
-			       INFO1M_DATA3_CARD_RE | INFO1M_DATA3_CARD_IN);
-		return -EAGAIN;
-	}
-	/* CARD Removal */
-	if (state1 & INFO1_CARD_RE) {
-		sh_sdhi_writew(host, SDHI_INFO1, ~INFO1_CARD_RE);
-		if (!host->detect_waiting) {
-			host->detect_waiting = 1;
-			sh_sdhi_detect(host);
-		}
-		sh_sdhi_writew(host, SDHI_INFO1_MASK, INFO1M_RESP_END |
-			       INFO1M_ACCESS_END | INFO1M_CARD_RE |
-			       INFO1M_DATA3_CARD_RE | INFO1M_DATA3_CARD_IN);
-		sh_sdhi_writew(host, SDHI_SDIO_INFO1_MASK, SDIO_INFO1M_ON);
-		sh_sdhi_writew(host, SDHI_SDIO_MODE, SDIO_MODE_OFF);
-		return -EAGAIN;
-	}
-
-	if (state2 & INFO2_ALL_ERR) {
-		sh_sdhi_writew(host, SDHI_INFO2,
-			       (unsigned short)~(INFO2_ALL_ERR));
-		sh_sdhi_writew(host, SDHI_INFO2_MASK,
-			       INFO2M_ALL_ERR |
-			       sh_sdhi_readw(host, SDHI_INFO2_MASK));
-		host->sd_error = 1;
-		host->wait_int = 1;
-		return 0;
-	}
-	/* Respons End */
-	if (state1 & INFO1_RESP_END) {
-		sh_sdhi_writew(host, SDHI_INFO1, ~INFO1_RESP_END);
-		sh_sdhi_writew(host, SDHI_INFO1_MASK,
-			       INFO1M_RESP_END |
-			       sh_sdhi_readw(host, SDHI_INFO1_MASK));
-		host->wait_int = 1;
-		return 0;
-	}
-	/* SD_BUF Read Enable */
-	if (state2 & INFO2_BRE_ENABLE) {
-		sh_sdhi_writew(host, SDHI_INFO2, ~INFO2_BRE_ENABLE);
-		sh_sdhi_writew(host, SDHI_INFO2_MASK,
-			       INFO2M_BRE_ENABLE | INFO2M_BUF_ILL_READ |
-			       sh_sdhi_readw(host, SDHI_INFO2_MASK));
-		host->wait_int = 1;
-		return 0;
-	}
-	/* SD_BUF Write Enable */
-	if (state2 & INFO2_BWE_ENABLE) {
-		sh_sdhi_writew(host, SDHI_INFO2, ~INFO2_BWE_ENABLE);
-		sh_sdhi_writew(host, SDHI_INFO2_MASK,
-			       INFO2_BWE_ENABLE | INFO2M_BUF_ILL_WRITE |
-			       sh_sdhi_readw(host, SDHI_INFO2_MASK));
-		host->wait_int = 1;
-		return 0;
-	}
-	/* Access End */
-	if (state1 & INFO1_ACCESS_END) {
-		sh_sdhi_writew(host, SDHI_INFO1, ~INFO1_ACCESS_END);
-		sh_sdhi_writew(host, SDHI_INFO1_MASK,
-			       INFO1_ACCESS_END |
-			       sh_sdhi_readw(host, SDHI_INFO1_MASK));
-		host->wait_int = 1;
-		return 0;
-	}
-	return -EAGAIN;
-}
-
-static int sh_sdhi_wait_interrupt_flag(struct sh_sdhi_host *host)
-{
-	int timeout = 10000000;
-
-	while (1) {
-		timeout--;
-		if (timeout < 0) {
-			debug(DRIVER_NAME": %s timeout\n", __func__);
-			return 0;
-		}
-
-		if (!sh_sdhi_intr(host))
-			break;
-
-		udelay(1);	/* 1 usec */
-	}
-
-	return 1; /* Return value: NOT 0 = complete waiting */
-}
-
-static int sh_sdhi_clock_control(struct sh_sdhi_host *host, unsigned long clk)
-{
-	u32 clkdiv, i, timeout;
-
-	if (sh_sdhi_readw(host, SDHI_INFO2) & (1 << 14)) {
-		printf(DRIVER_NAME": Busy state ! Cannot change the clock\n");
-		return -EBUSY;
-	}
-
-	sh_sdhi_writew(host, SDHI_CLK_CTRL,
-		       ~CLK_ENABLE & sh_sdhi_readw(host, SDHI_CLK_CTRL));
-
-	if (clk == 0)
-		return -EIO;
-
-	clkdiv = 0x80;
-	i = CONFIG_SH_SDHI_FREQ >> (0x8 + 1);
-	for (; clkdiv && clk >= (i << 1); (clkdiv >>= 1))
-		i <<= 1;
-
-	sh_sdhi_writew(host, SDHI_CLK_CTRL, clkdiv);
-
-	timeout = 100000;
-	/* Waiting for SD Bus busy to be cleared */
-	while (timeout--) {
-		if ((sh_sdhi_readw(host, SDHI_INFO2) & 0x2000))
-			break;
-	}
-
-	if (timeout)
-		sh_sdhi_writew(host, SDHI_CLK_CTRL,
-			       CLK_ENABLE | sh_sdhi_readw(host, SDHI_CLK_CTRL));
-	else
-		return -EBUSY;
-
-	return 0;
-}
-
-static int sh_sdhi_sync_reset(struct sh_sdhi_host *host)
-{
-	u32 timeout;
-	sh_sdhi_writew(host, SDHI_SOFT_RST, SOFT_RST_ON);
-	sh_sdhi_writew(host, SDHI_SOFT_RST, SOFT_RST_OFF);
-	sh_sdhi_writew(host, SDHI_CLK_CTRL,
-		       CLK_ENABLE | sh_sdhi_readw(host, SDHI_CLK_CTRL));
-
-	timeout = 100000;
-	while (timeout--) {
-		if (!(sh_sdhi_readw(host, SDHI_INFO2) & INFO2_CBUSY))
-			break;
-		udelay(100);
-	}
-
-	if (!timeout)
-		return -EBUSY;
-
-	if (host->quirks & SH_SDHI_QUIRK_16BIT_BUF)
-		sh_sdhi_writew(host, SDHI_HOST_MODE, 1);
-
-	return 0;
-}
-
-static int sh_sdhi_error_manage(struct sh_sdhi_host *host)
-{
-	unsigned short e_state1, e_state2;
-	int ret;
-
-	host->sd_error = 0;
-	host->wait_int = 0;
-
-	e_state1 = sh_sdhi_readw(host, SDHI_ERR_STS1);
-	e_state2 = sh_sdhi_readw(host, SDHI_ERR_STS2);
-	if (e_state2 & ERR_STS2_SYS_ERROR) {
-		if (e_state2 & ERR_STS2_RES_STOP_TIMEOUT)
-			ret = -ETIMEDOUT;
-		else
-			ret = -EILSEQ;
-		debug("%s: ERR_STS2 = %04x\n",
-		      DRIVER_NAME, sh_sdhi_readw(host, SDHI_ERR_STS2));
-		sh_sdhi_sync_reset(host);
-
-		sh_sdhi_writew(host, SDHI_INFO1_MASK,
-			       INFO1M_DATA3_CARD_RE | INFO1M_DATA3_CARD_IN);
-		return ret;
-	}
-	if (e_state1 & ERR_STS1_CRC_ERROR || e_state1 & ERR_STS1_CMD_ERROR)
-		ret = -EILSEQ;
-	else
-		ret = -ETIMEDOUT;
-
-	debug("%s: ERR_STS1 = %04x\n",
-	      DRIVER_NAME, sh_sdhi_readw(host, SDHI_ERR_STS1));
-	sh_sdhi_sync_reset(host);
-	sh_sdhi_writew(host, SDHI_INFO1_MASK,
-		       INFO1M_DATA3_CARD_RE | INFO1M_DATA3_CARD_IN);
-	return ret;
-}
-
-static int sh_sdhi_single_read(struct sh_sdhi_host *host, struct mmc_data *data)
-{
-	long time;
-	unsigned short blocksize, i;
-	unsigned short *p = (unsigned short *)data->dest;
-	u64 *q = (u64 *)data->dest;
-
-	if ((unsigned long)p & 0x00000001) {
-		debug(DRIVER_NAME": %s: The data pointer is unaligned.",
-		      __func__);
-		return -EIO;
-	}
-
-	host->wait_int = 0;
-	sh_sdhi_writew(host, SDHI_INFO2_MASK,
-		       ~(INFO2M_BRE_ENABLE | INFO2M_BUF_ILL_READ) &
-		       sh_sdhi_readw(host, SDHI_INFO2_MASK));
-	sh_sdhi_writew(host, SDHI_INFO1_MASK,
-		       ~INFO1M_ACCESS_END &
-		       sh_sdhi_readw(host, SDHI_INFO1_MASK));
-	time = sh_sdhi_wait_interrupt_flag(host);
-	if (time == 0 || host->sd_error != 0)
-		return sh_sdhi_error_manage(host);
-
-	host->wait_int = 0;
-	blocksize = sh_sdhi_readw(host, SDHI_SIZE);
-	if (host->quirks & SH_SDHI_QUIRK_64BIT_BUF)
-		for (i = 0; i < blocksize / 8; i++)
-			*q++ = sh_sdhi_readq(host, SDHI_BUF0);
-	else
-		for (i = 0; i < blocksize / 2; i++)
-			*p++ = sh_sdhi_readw(host, SDHI_BUF0);
-
-	time = sh_sdhi_wait_interrupt_flag(host);
-	if (time == 0 || host->sd_error != 0)
-		return sh_sdhi_error_manage(host);
-
-	host->wait_int = 0;
-	return 0;
-}
-
-static int sh_sdhi_multi_read(struct sh_sdhi_host *host, struct mmc_data *data)
-{
-	long time;
-	unsigned short blocksize, i, sec;
-	unsigned short *p = (unsigned short *)data->dest;
-	u64 *q = (u64 *)data->dest;
-
-	if ((unsigned long)p & 0x00000001) {
-		debug(DRIVER_NAME": %s: The data pointer is unaligned.",
-		      __func__);
-		return -EIO;
-	}
-
-	debug("%s: blocks = %d, blocksize = %d\n",
-	      __func__, data->blocks, data->blocksize);
-
-	host->wait_int = 0;
-	for (sec = 0; sec < data->blocks; sec++) {
-		sh_sdhi_writew(host, SDHI_INFO2_MASK,
-			       ~(INFO2M_BRE_ENABLE | INFO2M_BUF_ILL_READ) &
-			       sh_sdhi_readw(host, SDHI_INFO2_MASK));
-
-		time = sh_sdhi_wait_interrupt_flag(host);
-		if (time == 0 || host->sd_error != 0)
-			return sh_sdhi_error_manage(host);
-
-		host->wait_int = 0;
-		blocksize = sh_sdhi_readw(host, SDHI_SIZE);
-		if (host->quirks & SH_SDHI_QUIRK_64BIT_BUF)
-			for (i = 0; i < blocksize / 8; i++)
-				*q++ = sh_sdhi_readq(host, SDHI_BUF0);
-		else
-			for (i = 0; i < blocksize / 2; i++)
-				*p++ = sh_sdhi_readw(host, SDHI_BUF0);
-	}
-
-	return 0;
-}
-
-static int sh_sdhi_single_write(struct sh_sdhi_host *host,
-		struct mmc_data *data)
-{
-	long time;
-	unsigned short blocksize, i;
-	const unsigned short *p = (const unsigned short *)data->src;
-	const u64 *q = (const u64 *)data->src;
-
-	if ((unsigned long)p & 0x00000001) {
-		debug(DRIVER_NAME": %s: The data pointer is unaligned.",
-		      __func__);
-		return -EIO;
-	}
-
-	debug("%s: blocks = %d, blocksize = %d\n",
-	      __func__, data->blocks, data->blocksize);
-
-	host->wait_int = 0;
-	sh_sdhi_writew(host, SDHI_INFO2_MASK,
-		       ~(INFO2M_BWE_ENABLE | INFO2M_BUF_ILL_WRITE) &
-		       sh_sdhi_readw(host, SDHI_INFO2_MASK));
-	sh_sdhi_writew(host, SDHI_INFO1_MASK,
-		       ~INFO1M_ACCESS_END &
-		       sh_sdhi_readw(host, SDHI_INFO1_MASK));
-
-	time = sh_sdhi_wait_interrupt_flag(host);
-	if (time == 0 || host->sd_error != 0)
-		return sh_sdhi_error_manage(host);
-
-	host->wait_int = 0;
-	blocksize = sh_sdhi_readw(host, SDHI_SIZE);
-	if (host->quirks & SH_SDHI_QUIRK_64BIT_BUF)
-		for (i = 0; i < blocksize / 8; i++)
-			sh_sdhi_writeq(host, SDHI_BUF0, *q++);
-	else
-		for (i = 0; i < blocksize / 2; i++)
-			sh_sdhi_writew(host, SDHI_BUF0, *p++);
-
-	time = sh_sdhi_wait_interrupt_flag(host);
-	if (time == 0 || host->sd_error != 0)
-		return sh_sdhi_error_manage(host);
-
-	host->wait_int = 0;
-	return 0;
-}
-
-static int sh_sdhi_multi_write(struct sh_sdhi_host *host, struct mmc_data *data)
-{
-	long time;
-	unsigned short i, sec, blocksize;
-	const unsigned short *p = (const unsigned short *)data->src;
-	const u64 *q = (const u64 *)data->src;
-
-	debug("%s: blocks = %d, blocksize = %d\n",
-	      __func__, data->blocks, data->blocksize);
-
-	host->wait_int = 0;
-	for (sec = 0; sec < data->blocks; sec++) {
-		sh_sdhi_writew(host, SDHI_INFO2_MASK,
-			       ~(INFO2M_BWE_ENABLE | INFO2M_BUF_ILL_WRITE) &
-			       sh_sdhi_readw(host, SDHI_INFO2_MASK));
-
-		time = sh_sdhi_wait_interrupt_flag(host);
-		if (time == 0 || host->sd_error != 0)
-			return sh_sdhi_error_manage(host);
-
-		host->wait_int = 0;
-		blocksize = sh_sdhi_readw(host, SDHI_SIZE);
-		if (host->quirks & SH_SDHI_QUIRK_64BIT_BUF)
-			for (i = 0; i < blocksize / 8; i++)
-				sh_sdhi_writeq(host, SDHI_BUF0, *q++);
-		else
-			for (i = 0; i < blocksize / 2; i++)
-				sh_sdhi_writew(host, SDHI_BUF0, *p++);
-	}
-
-	return 0;
-}
-
-static void sh_sdhi_get_response(struct sh_sdhi_host *host, struct mmc_cmd *cmd)
-{
-	unsigned short i, j, cnt = 1;
-	unsigned short resp[8];
-
-	if (cmd->resp_type & MMC_RSP_136) {
-		cnt = 4;
-		resp[0] = sh_sdhi_readw(host, SDHI_RSP00);
-		resp[1] = sh_sdhi_readw(host, SDHI_RSP01);
-		resp[2] = sh_sdhi_readw(host, SDHI_RSP02);
-		resp[3] = sh_sdhi_readw(host, SDHI_RSP03);
-		resp[4] = sh_sdhi_readw(host, SDHI_RSP04);
-		resp[5] = sh_sdhi_readw(host, SDHI_RSP05);
-		resp[6] = sh_sdhi_readw(host, SDHI_RSP06);
-		resp[7] = sh_sdhi_readw(host, SDHI_RSP07);
-
-		/* SDHI REGISTER SPECIFICATION */
-		for (i = 7, j = 6; i > 0; i--) {
-			resp[i] = (resp[i] << 8) & 0xff00;
-			resp[i] |= (resp[j--] >> 8) & 0x00ff;
-		}
-		resp[0] = (resp[0] << 8) & 0xff00;
-	} else {
-		resp[0] = sh_sdhi_readw(host, SDHI_RSP00);
-		resp[1] = sh_sdhi_readw(host, SDHI_RSP01);
-	}
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	if (cnt == 4) {
-		cmd->response[0] = (resp[6] << 16) | resp[7];
-		cmd->response[1] = (resp[4] << 16) | resp[5];
-		cmd->response[2] = (resp[2] << 16) | resp[3];
-		cmd->response[3] = (resp[0] << 16) | resp[1];
-	} else {
-		cmd->response[0] = (resp[0] << 16) | resp[1];
-	}
-#else
-	if (cnt == 4) {
-		cmd->response[0] = (resp[7] << 16) | resp[6];
-		cmd->response[1] = (resp[5] << 16) | resp[4];
-		cmd->response[2] = (resp[3] << 16) | resp[2];
-		cmd->response[3] = (resp[1] << 16) | resp[0];
-	} else {
-		cmd->response[0] = (resp[1] << 16) | resp[0];
-	}
-#endif /* __BIG_ENDIAN_BITFIELD */
-}
-
-static unsigned short sh_sdhi_set_cmd(struct sh_sdhi_host *host,
-			struct mmc_data *data, unsigned short opc)
-{
-	if (host->app_cmd) {
-		if (!data)
-			host->app_cmd = 0;
-		return opc | BIT(6);
-	}
-
-	switch (opc) {
-	case MMC_CMD_SWITCH:
-		return opc | (data ? 0x1c00 : 0x40);
-	case MMC_CMD_SEND_EXT_CSD:
-		return opc | (data ? 0x1c00 : 0);
-	case MMC_CMD_SEND_OP_COND:
-		return opc | 0x0700;
-	case MMC_CMD_APP_CMD:
-		host->app_cmd = 1;
-	default:
-		return opc;
-	}
-}
-
-static unsigned short sh_sdhi_data_trans(struct sh_sdhi_host *host,
-			struct mmc_data *data, unsigned short opc)
-{
-	if (host->app_cmd) {
-		host->app_cmd = 0;
-		switch (opc) {
-		case SD_CMD_APP_SEND_SCR:
-		case SD_CMD_APP_SD_STATUS:
-			return sh_sdhi_single_read(host, data);
-		default:
-			printf(DRIVER_NAME": SD: NOT SUPPORT APP CMD = d'%04d\n",
-				opc);
-			return -EINVAL;
-		}
-	} else {
-		switch (opc) {
-		case MMC_CMD_WRITE_MULTIPLE_BLOCK:
-			return sh_sdhi_multi_write(host, data);
-		case MMC_CMD_READ_MULTIPLE_BLOCK:
-			return sh_sdhi_multi_read(host, data);
-		case MMC_CMD_WRITE_SINGLE_BLOCK:
-			return sh_sdhi_single_write(host, data);
-		case MMC_CMD_READ_SINGLE_BLOCK:
-		case MMC_CMD_SWITCH:
-		case MMC_CMD_SEND_EXT_CSD:;
-			return sh_sdhi_single_read(host, data);
-		default:
-			printf(DRIVER_NAME": SD: NOT SUPPORT CMD = d'%04d\n", opc);
-			return -EINVAL;
-		}
-	}
-}
-
-static int sh_sdhi_start_cmd(struct sh_sdhi_host *host,
-			struct mmc_data *data, struct mmc_cmd *cmd)
-{
-	long time;
-	unsigned short shcmd, opc = cmd->cmdidx;
-	int ret = 0;
-	unsigned long timeout;
-
-	debug("opc = %d, arg = %x, resp_type = %x\n",
-	      opc, cmd->cmdarg, cmd->resp_type);
-
-	if (opc == MMC_CMD_STOP_TRANSMISSION) {
-		/* SDHI sends the STOP command automatically by STOP reg */
-		sh_sdhi_writew(host, SDHI_INFO1_MASK, ~INFO1M_ACCESS_END &
-			       sh_sdhi_readw(host, SDHI_INFO1_MASK));
-
-		time = sh_sdhi_wait_interrupt_flag(host);
-		if (time == 0 || host->sd_error != 0)
-			return sh_sdhi_error_manage(host);
-
-		sh_sdhi_get_response(host, cmd);
-		return 0;
-	}
-
-	if (data) {
-		if ((opc == MMC_CMD_READ_MULTIPLE_BLOCK) ||
-		    opc == MMC_CMD_WRITE_MULTIPLE_BLOCK) {
-			sh_sdhi_writew(host, SDHI_STOP, STOP_SEC_ENABLE);
-			sh_sdhi_writew(host, SDHI_SECCNT, data->blocks);
-		}
-		sh_sdhi_writew(host, SDHI_SIZE, data->blocksize);
-	}
-
-	shcmd = sh_sdhi_set_cmd(host, data, opc);
-
-	/*
-	 *  U-Boot cannot use interrupt.
-	 *  So this flag may not be clear by timing
-	 */
-	sh_sdhi_writew(host, SDHI_INFO1, ~INFO1_RESP_END);
-
-	sh_sdhi_writew(host, SDHI_INFO1_MASK,
-		       INFO1M_RESP_END | sh_sdhi_readw(host, SDHI_INFO1_MASK));
-	sh_sdhi_writew(host, SDHI_ARG0,
-		       (unsigned short)(cmd->cmdarg & ARG0_MASK));
-	sh_sdhi_writew(host, SDHI_ARG1,
-		       (unsigned short)((cmd->cmdarg >> 16) & ARG1_MASK));
-
-	timeout = 100000;
-	/* Waiting for SD Bus busy to be cleared */
-	while (timeout--) {
-		if ((sh_sdhi_readw(host, SDHI_INFO2) & 0x2000))
-			break;
-	}
-
-	host->wait_int = 0;
-	sh_sdhi_writew(host, SDHI_INFO1_MASK,
-		       ~INFO1M_RESP_END & sh_sdhi_readw(host, SDHI_INFO1_MASK));
-	sh_sdhi_writew(host, SDHI_INFO2_MASK,
-		       ~(INFO2M_CMD_ERROR | INFO2M_CRC_ERROR |
-		       INFO2M_END_ERROR | INFO2M_TIMEOUT |
-		       INFO2M_RESP_TIMEOUT | INFO2M_ILA) &
-		       sh_sdhi_readw(host, SDHI_INFO2_MASK));
-
-	sh_sdhi_writew(host, SDHI_CMD, (unsigned short)(shcmd & CMD_MASK));
-	time = sh_sdhi_wait_interrupt_flag(host);
-	if (!time) {
-		host->app_cmd = 0;
-		return sh_sdhi_error_manage(host);
-	}
-
-	if (host->sd_error) {
-		switch (cmd->cmdidx) {
-		case MMC_CMD_ALL_SEND_CID:
-		case MMC_CMD_SELECT_CARD:
-		case SD_CMD_SEND_IF_COND:
-		case MMC_CMD_APP_CMD:
-			ret = -ETIMEDOUT;
-			break;
-		default:
-			debug(DRIVER_NAME": Cmd(d'%d) err\n", opc);
-			debug(DRIVER_NAME": cmdidx = %d\n", cmd->cmdidx);
-			ret = sh_sdhi_error_manage(host);
-			break;
-		}
-		host->sd_error = 0;
-		host->wait_int = 0;
-		host->app_cmd = 0;
-		return ret;
-	}
-
-	if (sh_sdhi_readw(host, SDHI_INFO1) & INFO1_RESP_END) {
-		host->app_cmd = 0;
-		return -EINVAL;
-	}
-
-	if (host->wait_int) {
-		sh_sdhi_get_response(host, cmd);
-		host->wait_int = 0;
-	}
-
-	if (data)
-		ret = sh_sdhi_data_trans(host, data, opc);
-
-	debug("ret = %d, resp = %08x, %08x, %08x, %08x\n",
-	      ret, cmd->response[0], cmd->response[1],
-	      cmd->response[2], cmd->response[3]);
-	return ret;
-}
-
-static int sh_sdhi_send_cmd_common(struct sh_sdhi_host *host,
-				   struct mmc_cmd *cmd, struct mmc_data *data)
-{
-	host->sd_error = 0;
-
-	return sh_sdhi_start_cmd(host, data, cmd);
-}
-
-static int sh_sdhi_set_ios_common(struct sh_sdhi_host *host, struct mmc *mmc)
-{
-	int ret;
-
-	ret = sh_sdhi_clock_control(host, mmc->clock);
-	if (ret)
-		return -EINVAL;
-
-	if (mmc->bus_width == 8)
-		sh_sdhi_writew(host, SDHI_OPTION,
-			       OPT_BUS_WIDTH_8 | (~OPT_BUS_WIDTH_M &
-			       sh_sdhi_readw(host, SDHI_OPTION)));
-	else if (mmc->bus_width == 4)
-		sh_sdhi_writew(host, SDHI_OPTION,
-			       OPT_BUS_WIDTH_4 | (~OPT_BUS_WIDTH_M &
-			       sh_sdhi_readw(host, SDHI_OPTION)));
-	else
-		sh_sdhi_writew(host, SDHI_OPTION,
-			       OPT_BUS_WIDTH_1 | (~OPT_BUS_WIDTH_M &
-			       sh_sdhi_readw(host, SDHI_OPTION)));
-
-	debug("clock = %d, buswidth = %d\n", mmc->clock, mmc->bus_width);
-
-	return 0;
-}
-
-static int sh_sdhi_initialize_common(struct sh_sdhi_host *host)
-{
-	int ret = sh_sdhi_sync_reset(host);
-
-	sh_sdhi_writew(host, SDHI_PORTSEL, USE_1PORT);
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	sh_sdhi_writew(host, SDHI_EXT_SWAP, SET_SWAP);
-#endif
-
-	sh_sdhi_writew(host, SDHI_INFO1_MASK, INFO1M_RESP_END |
-		       INFO1M_ACCESS_END | INFO1M_CARD_RE |
-		       INFO1M_DATA3_CARD_RE | INFO1M_DATA3_CARD_IN);
-
-	return ret;
-}
-
-#ifndef CONFIG_DM_MMC
-static void *mmc_priv(struct mmc *mmc)
-{
-	return (void *)mmc->priv;
-}
-
-static int sh_sdhi_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
-			    struct mmc_data *data)
-{
-	struct sh_sdhi_host *host = mmc_priv(mmc);
-
-	return sh_sdhi_send_cmd_common(host, cmd, data);
-}
-
-static int sh_sdhi_set_ios(struct mmc *mmc)
-{
-	struct sh_sdhi_host *host = mmc_priv(mmc);
-
-	return sh_sdhi_set_ios_common(host, mmc);
-}
-
-static int sh_sdhi_initialize(struct mmc *mmc)
-{
-	struct sh_sdhi_host *host = mmc_priv(mmc);
-
-	return sh_sdhi_initialize_common(host);
-}
-
-static const struct mmc_ops sh_sdhi_ops = {
-	.send_cmd       = sh_sdhi_send_cmd,
-	.set_ios        = sh_sdhi_set_ios,
-	.init           = sh_sdhi_initialize,
-};
-
-#ifdef CONFIG_RCAR_GEN3
-static struct mmc_config sh_sdhi_cfg = {
-	.name           = DRIVER_NAME,
-	.ops            = &sh_sdhi_ops,
-	.f_min          = CLKDEV_INIT,
-	.f_max          = CLKDEV_HS_DATA,
-	.voltages       = MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
-	.host_caps      = MMC_MODE_4BIT | MMC_MODE_8BIT | MMC_MODE_HS |
-			  MMC_MODE_HS_52MHz,
-	.part_type      = PART_TYPE_DOS,
-	.b_max          = CONFIG_SYS_MMC_MAX_BLK_COUNT,
-};
-#else
-static struct mmc_config sh_sdhi_cfg = {
-	.name           = DRIVER_NAME,
-	.ops            = &sh_sdhi_ops,
-	.f_min          = CLKDEV_INIT,
-	.f_max          = CLKDEV_HS_DATA,
-	.voltages       = MMC_VDD_32_33 | MMC_VDD_33_34,
-	.host_caps      = MMC_MODE_4BIT | MMC_MODE_HS,
-	.part_type      = PART_TYPE_DOS,
-	.b_max          = CONFIG_SYS_MMC_MAX_BLK_COUNT,
-};
-#endif
-
-int sh_sdhi_init(unsigned long addr, int ch, unsigned long quirks)
-{
-	int ret = 0;
-	struct mmc *mmc;
-	struct sh_sdhi_host *host = NULL;
-
-	if (ch >= CFG_SYS_SH_SDHI_NR_CHANNEL)
-		return -ENODEV;
-
-	host = malloc(sizeof(struct sh_sdhi_host));
-	if (!host)
-		return -ENOMEM;
-
-	mmc = mmc_create(&sh_sdhi_cfg, host);
-	if (!mmc) {
-		ret = -1;
-		goto error;
-	}
-
-	host->ch = ch;
-	host->addr = (void __iomem *)addr;
-	host->quirks = quirks;
-
-	if (host->quirks & SH_SDHI_QUIRK_64BIT_BUF)
-		host->bus_shift = 2;
-	else if (host->quirks & SH_SDHI_QUIRK_16BIT_BUF)
-		host->bus_shift = 1;
-
-	return ret;
-error:
-	free(host);
-	return ret;
-}
-
-#else
-
-struct sh_sdhi_plat {
-	struct mmc_config cfg;
-	struct mmc mmc;
-};
-
-int sh_sdhi_dm_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
-			struct mmc_data *data)
-{
-	struct sh_sdhi_host *host = dev_get_priv(dev);
-
-	return sh_sdhi_send_cmd_common(host, cmd, data);
-}
-
-int sh_sdhi_dm_set_ios(struct udevice *dev)
-{
-	struct sh_sdhi_host *host = dev_get_priv(dev);
-	struct mmc *mmc = mmc_get_mmc_dev(dev);
-
-	return sh_sdhi_set_ios_common(host, mmc);
-}
-
-static const struct dm_mmc_ops sh_sdhi_dm_ops = {
-	.send_cmd	= sh_sdhi_dm_send_cmd,
-	.set_ios	= sh_sdhi_dm_set_ios,
-};
-
-static int sh_sdhi_dm_bind(struct udevice *dev)
-{
-	struct sh_sdhi_plat *plat = dev_get_plat(dev);
-
-	return mmc_bind(dev, &plat->mmc, &plat->cfg);
-}
-
-static int sh_sdhi_dm_probe(struct udevice *dev)
-{
-	struct sh_sdhi_plat *plat = dev_get_plat(dev);
-	struct sh_sdhi_host *host = dev_get_priv(dev);
-	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
-	struct clk sh_sdhi_clk;
-	const u32 quirks = dev_get_driver_data(dev);
-	fdt_addr_t base;
-	int ret;
-
-	base = dev_read_addr(dev);
-	if (base == FDT_ADDR_T_NONE)
-		return -EINVAL;
-
-	host->addr = devm_ioremap(dev, base, SZ_2K);
-	if (!host->addr)
-		return -ENOMEM;
-
-	ret = clk_get_by_index(dev, 0, &sh_sdhi_clk);
-	if (ret) {
-		debug("failed to get clock, ret=%d\n", ret);
-		return ret;
-	}
-
-	ret = clk_enable(&sh_sdhi_clk);
-	if (ret) {
-		debug("failed to enable clock, ret=%d\n", ret);
-		return ret;
-	}
-
-	host->quirks = quirks;
-
-	if (host->quirks & SH_SDHI_QUIRK_64BIT_BUF)
-		host->bus_shift = 2;
-	else if (host->quirks & SH_SDHI_QUIRK_16BIT_BUF)
-		host->bus_shift = 1;
-
-	plat->cfg.name = dev->name;
-	plat->cfg.host_caps = MMC_MODE_HS_52MHz | MMC_MODE_HS;
-
-	switch (fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev), "bus-width",
-			       1)) {
-	case 8:
-		plat->cfg.host_caps |= MMC_MODE_8BIT;
-		break;
-	case 4:
-		plat->cfg.host_caps |= MMC_MODE_4BIT;
-		break;
-	case 1:
-		break;
-	default:
-		dev_err(dev, "Invalid \"bus-width\" value\n");
-		return -EINVAL;
-	}
-
-	sh_sdhi_initialize_common(host);
-
-	plat->cfg.voltages = MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34;
-	plat->cfg.f_min = CLKDEV_INIT;
-	plat->cfg.f_max = CLKDEV_HS_DATA;
-	plat->cfg.b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT;
-
-	upriv->mmc = &plat->mmc;
-
-	return 0;
-}
-
-static const struct udevice_id sh_sdhi_sd_match[] = {
-	{ .compatible = "renesas,sdhi-r8a7795", .data = SH_SDHI_QUIRK_64BIT_BUF },
-	{ .compatible = "renesas,sdhi-r8a7796", .data = SH_SDHI_QUIRK_64BIT_BUF },
-	{ /* sentinel */ }
-};
-
-U_BOOT_DRIVER(sh_sdhi_mmc) = {
-	.name			= "sh-sdhi-mmc",
-	.id			= UCLASS_MMC,
-	.of_match		= sh_sdhi_sd_match,
-	.bind			= sh_sdhi_dm_bind,
-	.probe			= sh_sdhi_dm_probe,
-	.priv_auto	= sizeof(struct sh_sdhi_host),
-	.plat_auto	= sizeof(struct sh_sdhi_plat),
-	.ops			= &sh_sdhi_dm_ops,
-};
-#endif
-- 
2.42.0

