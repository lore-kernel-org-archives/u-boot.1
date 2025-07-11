Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7E2C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B5738309C;
	Fri, 11 Jul 2025 17:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SlM+Vzil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7218A8309C; Fri, 11 Jul 2025 17:20:11 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E326682F14
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-61208b548e8so612491eaf.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247207; x=1752852007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cjA7fMB/DT6vpfLm8B0NT2jSt6+d83iii3oOWP1da4k=;
 b=SlM+VziluLyZNBz1hEgS8gDRRE141RkvBHU3qIvpfXTGLIZ2Jwufr2CteUywhcITwt
 lZvTkKiBkhYt7PGi8G2ApDQ9NaRlWI7v/osg8YAtTaFYMN9fQqKdgVYPFCXosFUM/uoi
 wnyYDfRhAk3yLwp1Mt9Kbf0EMvGcY5SKwmKwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247207; x=1752852007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cjA7fMB/DT6vpfLm8B0NT2jSt6+d83iii3oOWP1da4k=;
 b=wy4RIH6IHBeE7R+hF61TxIEbRdwO7/ffHjk3EzzA099YsTw6YTJn1mDmvxjWVZWwno
 06lgFubvbkQCb4awq3yVfMI2t9EZv850Xx7ydux2sE2LWsoAaMbR4VUigUzeB8PXKrPh
 Y7JuG/FbjwOWFHbDwC4UPTSM4DgrGPsGE33D1bGMPZ5allAS8s6OnlhwB1XQEsBDwS71
 WFUlBb6Fyv05w29LsyAumUObUVSDRVjoFOieTa6N8xKH36AvMJ2iZzqWh7QF+Hi876VZ
 WKwJy4m8H81ZaBLnTSp3r7f2LqOXfiC8O5kkkQT0ovGU3pZPxzgBPnDn19oF6uAHpS7R
 /rng==
X-Gm-Message-State: AOJu0Yybtq8+gIf/ts/29uTFEV61y4qrh0onEHzuvOXPYrOOPofKWyiH
 qU++Ilx2KWShxO0ZZ8K3srM7l8cE1qPle68MQqDm0La9HgOMSAOxKbAnanvnytV2+KgFFQUgnGY
 bVLrysIc=
X-Gm-Gg: ASbGncsuHQAU4xjGh4wdeFokyfgYgHatmsxTBR41spKBqV+ZxnM97Gin3xczbz6va1E
 Q+44QrPV2oNp5l5X/YwJAkpCrwTM+ZGDdv0C/TuH7XSqyOG1/phHlMicWKSfdPD3RGwFXXIu5f6
 aIOTGvN/Y5l5AHFdHGq+T8KSirPm502bMrX0YQYCsNKIVowMPoxetzU9UqwGxkNCfa00//3hHJP
 m8ZOmbeiKAiBmAtKyuYeqDAdGtp5JpQD5PhsugSD5GMEfxSl6BLCC53bDXew8ZfCJDSkTIg+yAf
 xqkDbDKNJYtreqDjnhC+OkbTrVRU2KGD+pGNbOwaiVAgcPlH+bNcxDBKe+uv2qA/5ReLJK0ZyJ5
 xr12HJxp3Ey7IfASWRQY/NDwzfVFsQOrbM7nXXrSbFlcYBW1y3AveHdUcvV8=
X-Google-Smtp-Source: AGHT+IGf6caZSahzX4Kxve56bIfaca7QKGDbtxsvvJ6K1mhbh26Ythbz4Te0X2sv8MtN2jEcZMcixw==
X-Received: by 2002:a05:6820:4b17:b0:613:c922:32c6 with SMTP id
 006d021491bc7-613e5efca9cmr2348709eaf.2.1752247206728; 
 Fri, 11 Jul 2025 08:20:06 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-613d9d6d51bsm501966eaf.5.2025.07.11.08.20.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] arm: imx: Remove unused mxcmmc driver
Date: Fri, 11 Jul 2025 09:20:05 -0600
Message-ID: <20250711152005.2225412-1-trini@konsulko.com>
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

As no platforms use this driver anymore, remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/arch-mx27/imx-regs.h |   5 -
 drivers/mmc/Kconfig                       |   9 -
 drivers/mmc/Makefile                      |   1 -
 drivers/mmc/mxcmmc.c                      | 523 ----------------------
 4 files changed, 538 deletions(-)
 delete mode 100644 drivers/mmc/mxcmmc.c

diff --git a/arch/arm/include/asm/arch-mx27/imx-regs.h b/arch/arm/include/asm/arch-mx27/imx-regs.h
index 60499189b2cf..a91528142458 100644
--- a/arch/arm/include/asm/arch-mx27/imx-regs.h
+++ b/arch/arm/include/asm/arch-mx27/imx-regs.h
@@ -21,11 +21,6 @@ extern void mx27_uart1_init_pins(void);
 extern void mx27_fec_init_pins(void);
 #endif /* CONFIG_FEC_MXC */
 
-#ifdef CONFIG_MMC_MXC
-extern void mx27_sd1_init_pins(void);
-extern void mx27_sd2_init_pins(void);
-#endif /* CONFIG_MMC_MXC */
-
 /* AIPI */
 struct aipi_regs {
 	u32 psr0;
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 1c9b6898bff4..845b653731f9 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -333,15 +333,6 @@ config MMC_MESON_GX
 	help
 	 Support for EMMC host controller on Meson GX ARM SoCs platform (S905)
 
-config MMC_MXC
-	bool "Freescale i.MX21/27/31 or MPC512x Multimedia Card support"
-	help
-	  This selects the Freescale i.MX21, i.MX27, i.MX31 or MPC512x
-	  Multimedia Card Interface. If you have an i.MX or MPC512x platform
-	  with a Multimedia Card slot, say Y here.
-
-	  If unsure, say N.
-
 config MMC_OWL
 	bool "Actions OWL Multimedia Card Interface support"
 	depends on ARCH_OWL
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 360706f53d2b..280187c6bab7 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_MMC_MESON_GX) += meson_gx_mmc.o
 obj-$(CONFIG_MMC_SPI) += mmc_spi.o
 obj-$(CONFIG_MVEBU_MMC) += mvebu_mmc.o
 obj-$(CONFIG_MMC_OMAP_HS)		+= omap_hsmmc.o
-obj-$(CONFIG_MMC_MXC)			+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)			+= mxsmmc.o
 obj-$(CONFIG_MMC_OCTEONTX)		+= octeontx_hsmmc.o
 obj-$(CONFIG_MMC_OWL)			+= owl_mmc.o
diff --git a/drivers/mmc/mxcmmc.c b/drivers/mmc/mxcmmc.c
deleted file mode 100644
index 1acea6f820b4..000000000000
--- a/drivers/mmc/mxcmmc.c
+++ /dev/null
@@ -1,523 +0,0 @@
-/*
- *  This is a driver for the SDHC controller found in Freescale MX2/MX3
- *  SoCs. It is basically the same hardware as found on MX1 (imxmmc.c).
- *  Unlike the hardware found on MX1, this hardware just works and does
- *  not need all the quirks found in imxmmc.c, hence the seperate driver.
- *
- *  Copyright (C) 2009 Ilya Yanok, <yanok@emcraft.com>
- *  Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *  Copyright (C) 2006 Pavel Pisa, PiKRON <ppisa@pikron.com>
- *
- *  derived from pxamci.c by Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <config.h>
-#include <command.h>
-#include <mmc.h>
-#include <part.h>
-#include <malloc.h>
-#include <mmc.h>
-#include <time.h>
-#include <linux/errno.h>
-#include <asm/io.h>
-#include <asm/arch/clock.h>
-
-#define DRIVER_NAME "mxc-mmc"
-
-struct mxcmci_regs {
-	u32 str_stp_clk;
-	u32 status;
-	u32 clk_rate;
-	u32 cmd_dat_cont;
-	u32 res_to;
-	u32 read_to;
-	u32 blk_len;
-	u32 nob;
-	u32 rev_no;
-	u32 int_cntr;
-	u32 cmd;
-	u32 arg;
-	u32 pad;
-	u32 res_fifo;
-	u32 buffer_access;
-};
-
-#define STR_STP_CLK_RESET               (1 << 3)
-#define STR_STP_CLK_START_CLK           (1 << 1)
-#define STR_STP_CLK_STOP_CLK            (1 << 0)
-
-#define STATUS_CARD_INSERTION		(1 << 31)
-#define STATUS_CARD_REMOVAL		(1 << 30)
-#define STATUS_YBUF_EMPTY		(1 << 29)
-#define STATUS_XBUF_EMPTY		(1 << 28)
-#define STATUS_YBUF_FULL		(1 << 27)
-#define STATUS_XBUF_FULL		(1 << 26)
-#define STATUS_BUF_UND_RUN		(1 << 25)
-#define STATUS_BUF_OVFL			(1 << 24)
-#define STATUS_SDIO_INT_ACTIVE		(1 << 14)
-#define STATUS_END_CMD_RESP		(1 << 13)
-#define STATUS_WRITE_OP_DONE		(1 << 12)
-#define STATUS_DATA_TRANS_DONE		(1 << 11)
-#define STATUS_READ_OP_DONE		(1 << 11)
-#define STATUS_WR_CRC_ERROR_CODE_MASK	(3 << 10)
-#define STATUS_CARD_BUS_CLK_RUN		(1 << 8)
-#define STATUS_BUF_READ_RDY		(1 << 7)
-#define STATUS_BUF_WRITE_RDY		(1 << 6)
-#define STATUS_RESP_CRC_ERR		(1 << 5)
-#define STATUS_CRC_READ_ERR		(1 << 3)
-#define STATUS_CRC_WRITE_ERR		(1 << 2)
-#define STATUS_TIME_OUT_RESP		(1 << 1)
-#define STATUS_TIME_OUT_READ		(1 << 0)
-#define STATUS_ERR_MASK			0x2f
-
-#define CMD_DAT_CONT_CMD_RESP_LONG_OFF	(1 << 12)
-#define CMD_DAT_CONT_STOP_READWAIT	(1 << 11)
-#define CMD_DAT_CONT_START_READWAIT	(1 << 10)
-#define CMD_DAT_CONT_BUS_WIDTH_4	(2 << 8)
-#define CMD_DAT_CONT_INIT		(1 << 7)
-#define CMD_DAT_CONT_WRITE		(1 << 4)
-#define CMD_DAT_CONT_DATA_ENABLE	(1 << 3)
-#define CMD_DAT_CONT_RESPONSE_48BIT_CRC	(1 << 0)
-#define CMD_DAT_CONT_RESPONSE_136BIT	(2 << 0)
-#define CMD_DAT_CONT_RESPONSE_48BIT	(3 << 0)
-
-#define INT_SDIO_INT_WKP_EN		(1 << 18)
-#define INT_CARD_INSERTION_WKP_EN	(1 << 17)
-#define INT_CARD_REMOVAL_WKP_EN		(1 << 16)
-#define INT_CARD_INSERTION_EN		(1 << 15)
-#define INT_CARD_REMOVAL_EN		(1 << 14)
-#define INT_SDIO_IRQ_EN			(1 << 13)
-#define INT_DAT0_EN			(1 << 12)
-#define INT_BUF_READ_EN			(1 << 4)
-#define INT_BUF_WRITE_EN		(1 << 3)
-#define INT_END_CMD_RES_EN		(1 << 2)
-#define INT_WRITE_OP_DONE_EN		(1 << 1)
-#define INT_READ_OP_EN			(1 << 0)
-
-struct mxcmci_host {
-	struct mmc		*mmc;
-	struct mxcmci_regs	*base;
-	int			irq;
-	int			detect_irq;
-	int			dma;
-	int			do_dma;
-	unsigned int		power_mode;
-
-	struct mmc_cmd		*cmd;
-	struct mmc_data		*data;
-
-	unsigned int		dma_nents;
-	unsigned int		datasize;
-	unsigned int		dma_dir;
-
-	u16			rev_no;
-	unsigned int		cmdat;
-
-	int			clock;
-};
-
-static struct mxcmci_host mxcmci_host;
-
-/* maintainer note: do we really want to have a global host pointer? */
-static struct mxcmci_host *host = &mxcmci_host;
-
-static inline int mxcmci_use_dma(struct mxcmci_host *host)
-{
-	return host->do_dma;
-}
-
-static void mxcmci_softreset(struct mxcmci_host *host)
-{
-	int i;
-
-	/* reset sequence */
-	writel(STR_STP_CLK_RESET, &host->base->str_stp_clk);
-	writel(STR_STP_CLK_RESET | STR_STP_CLK_START_CLK,
-			&host->base->str_stp_clk);
-
-	for (i = 0; i < 8; i++)
-		writel(STR_STP_CLK_START_CLK, &host->base->str_stp_clk);
-
-	writel(0xff, &host->base->res_to);
-}
-
-static void mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
-{
-	unsigned int nob = data->blocks;
-	unsigned int blksz = data->blocksize;
-	unsigned int datasize = nob * blksz;
-
-	host->data = data;
-
-	writel(nob, &host->base->nob);
-	writel(blksz, &host->base->blk_len);
-	host->datasize = datasize;
-}
-
-static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_cmd *cmd,
-		unsigned int cmdat)
-{
-	if (host->cmd != NULL)
-		printf("mxcmci: error!\n");
-	host->cmd = cmd;
-
-	switch (cmd->resp_type) {
-	case MMC_RSP_R1: /* short CRC, OPCODE */
-	case MMC_RSP_R1b:/* short CRC, OPCODE, BUSY */
-		cmdat |= CMD_DAT_CONT_RESPONSE_48BIT_CRC;
-		break;
-	case MMC_RSP_R2: /* long 136 bit + CRC */
-		cmdat |= CMD_DAT_CONT_RESPONSE_136BIT;
-		break;
-	case MMC_RSP_R3: /* short */
-		cmdat |= CMD_DAT_CONT_RESPONSE_48BIT;
-		break;
-	case MMC_RSP_NONE:
-		break;
-	default:
-		printf("mxcmci: unhandled response type 0x%x\n",
-				cmd->resp_type);
-		return -EINVAL;
-	}
-
-	writel(cmd->cmdidx, &host->base->cmd);
-	writel(cmd->cmdarg, &host->base->arg);
-	writel(cmdat, &host->base->cmd_dat_cont);
-
-	return 0;
-}
-
-static void mxcmci_finish_request(struct mxcmci_host *host,
-		struct mmc_cmd *cmd, struct mmc_data *data)
-{
-	host->cmd = NULL;
-	host->data = NULL;
-}
-
-static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
-{
-	int data_error = 0;
-
-	if (stat & STATUS_ERR_MASK) {
-		printf("request failed. status: 0x%08x\n",
-				stat);
-		if (stat & STATUS_CRC_READ_ERR) {
-			data_error = -EILSEQ;
-		} else if (stat & STATUS_CRC_WRITE_ERR) {
-			u32 err_code = (stat >> 9) & 0x3;
-			if (err_code == 2) /* No CRC response */
-				data_error = -ETIMEDOUT;
-			else
-				data_error = -EILSEQ;
-		} else if (stat & STATUS_TIME_OUT_READ) {
-			data_error = -ETIMEDOUT;
-		} else {
-			data_error = -EIO;
-		}
-	}
-
-	host->data = NULL;
-
-	return data_error;
-}
-
-static int mxcmci_read_response(struct mxcmci_host *host, unsigned int stat)
-{
-	struct mmc_cmd *cmd = host->cmd;
-	int i;
-	u32 a, b, c;
-	u32 *resp = (u32 *)cmd->response;
-
-	if (!cmd)
-		return 0;
-
-	if (stat & STATUS_TIME_OUT_RESP) {
-		printf("CMD TIMEOUT\n");
-		return -ETIMEDOUT;
-	} else if (stat & STATUS_RESP_CRC_ERR && cmd->resp_type & MMC_RSP_CRC) {
-		printf("cmd crc error\n");
-		return -EILSEQ;
-	}
-
-	if (cmd->resp_type & MMC_RSP_PRESENT) {
-		if (cmd->resp_type & MMC_RSP_136) {
-			for (i = 0; i < 4; i++) {
-				a = readl(&host->base->res_fifo) & 0xFFFF;
-				b = readl(&host->base->res_fifo) & 0xFFFF;
-				resp[i] = a << 16 | b;
-			}
-		} else {
-			a = readl(&host->base->res_fifo) & 0xFFFF;
-			b = readl(&host->base->res_fifo) & 0xFFFF;
-			c = readl(&host->base->res_fifo) & 0xFFFF;
-			resp[0] = a << 24 | b << 8 | c >> 8;
-		}
-	}
-	return 0;
-}
-
-static int mxcmci_poll_status(struct mxcmci_host *host, u32 mask)
-{
-	u32 stat;
-	unsigned long timeout = get_ticks() + CONFIG_SYS_HZ;
-
-	do {
-		stat = readl(&host->base->status);
-		if (stat & STATUS_ERR_MASK)
-			return stat;
-		if (timeout < get_ticks())
-			return STATUS_TIME_OUT_READ;
-		if (stat & mask)
-			return 0;
-	} while (1);
-}
-
-static int mxcmci_pull(struct mxcmci_host *host, void *_buf, int bytes)
-{
-	unsigned int stat;
-	u32 *buf = _buf;
-
-	while (bytes > 3) {
-		stat = mxcmci_poll_status(host,
-				STATUS_BUF_READ_RDY | STATUS_READ_OP_DONE);
-		if (stat)
-			return stat;
-		*buf++ = readl(&host->base->buffer_access);
-		bytes -= 4;
-	}
-
-	if (bytes) {
-		u8 *b = (u8 *)buf;
-		u32 tmp;
-
-		stat = mxcmci_poll_status(host,
-				STATUS_BUF_READ_RDY | STATUS_READ_OP_DONE);
-		if (stat)
-			return stat;
-		tmp = readl(&host->base->buffer_access);
-		memcpy(b, &tmp, bytes);
-	}
-
-	return 0;
-}
-
-static int mxcmci_push(struct mxcmci_host *host, const void *_buf, int bytes)
-{
-	unsigned int stat;
-	const u32 *buf = _buf;
-
-	while (bytes > 3) {
-		stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
-		if (stat)
-			return stat;
-		writel(*buf++, &host->base->buffer_access);
-		bytes -= 4;
-	}
-
-	if (bytes) {
-		const u8 *b = (u8 *)buf;
-		u32 tmp;
-
-		stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
-		if (stat)
-			return stat;
-
-		memcpy(&tmp, b, bytes);
-		writel(tmp, &host->base->buffer_access);
-	}
-
-	stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
-	if (stat)
-		return stat;
-
-	return 0;
-}
-
-static int mxcmci_transfer_data(struct mxcmci_host *host)
-{
-	struct mmc_data *data = host->data;
-	int stat;
-	unsigned long length;
-
-	length = data->blocks * data->blocksize;
-	host->datasize = 0;
-
-	if (data->flags & MMC_DATA_READ) {
-		stat = mxcmci_pull(host, data->dest, length);
-		if (stat)
-			return stat;
-		host->datasize += length;
-	} else {
-		stat = mxcmci_push(host, (const void *)(data->src), length);
-		if (stat)
-			return stat;
-		host->datasize += length;
-		stat = mxcmci_poll_status(host, STATUS_WRITE_OP_DONE);
-		if (stat)
-			return stat;
-	}
-	return 0;
-}
-
-static int mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
-{
-	int datastat;
-	int ret;
-
-	ret = mxcmci_read_response(host, stat);
-
-	if (ret) {
-		mxcmci_finish_request(host, host->cmd, host->data);
-		return ret;
-	}
-
-	if (!host->data) {
-		mxcmci_finish_request(host, host->cmd, host->data);
-		return 0;
-	}
-
-	datastat = mxcmci_transfer_data(host);
-	ret = mxcmci_finish_data(host, datastat);
-	mxcmci_finish_request(host, host->cmd, host->data);
-	return ret;
-}
-
-static int mxcmci_request(struct mmc *mmc, struct mmc_cmd *cmd,
-		struct mmc_data *data)
-{
-	struct mxcmci_host *host = mmc->priv;
-	unsigned int cmdat = host->cmdat;
-	u32 stat;
-	int ret;
-
-	host->cmdat &= ~CMD_DAT_CONT_INIT;
-	if (data) {
-		mxcmci_setup_data(host, data);
-
-		cmdat |= CMD_DAT_CONT_DATA_ENABLE;
-
-		if (data->flags & MMC_DATA_WRITE)
-			cmdat |= CMD_DAT_CONT_WRITE;
-	}
-
-	if ((ret = mxcmci_start_cmd(host, cmd, cmdat))) {
-		mxcmci_finish_request(host, cmd, data);
-		return ret;
-	}
-
-	do {
-		stat = readl(&host->base->status);
-		writel(stat, &host->base->status);
-	} while (!(stat & STATUS_END_CMD_RESP));
-
-	return mxcmci_cmd_done(host, stat);
-}
-
-static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios)
-{
-	unsigned int divider;
-	int prescaler = 0;
-	unsigned long clk_in = mxc_get_clock(MXC_ESDHC_CLK);
-
-	while (prescaler <= 0x800) {
-		for (divider = 1; divider <= 0xF; divider++) {
-			int x;
-
-			x = (clk_in / (divider + 1));
-
-			if (prescaler)
-				x /= (prescaler * 2);
-
-			if (x <= clk_ios)
-				break;
-		}
-		if (divider < 0x10)
-			break;
-
-		if (prescaler == 0)
-			prescaler = 1;
-		else
-			prescaler <<= 1;
-	}
-
-	writel((prescaler << 4) | divider, &host->base->clk_rate);
-}
-
-static int mxcmci_set_ios(struct mmc *mmc)
-{
-	struct mxcmci_host *host = mmc->priv;
-	if (mmc->bus_width == 4)
-		host->cmdat |= CMD_DAT_CONT_BUS_WIDTH_4;
-	else
-		host->cmdat &= ~CMD_DAT_CONT_BUS_WIDTH_4;
-
-	if (mmc->clock) {
-		mxcmci_set_clk_rate(host, mmc->clock);
-		writel(STR_STP_CLK_START_CLK, &host->base->str_stp_clk);
-	} else {
-		writel(STR_STP_CLK_STOP_CLK, &host->base->str_stp_clk);
-	}
-
-	host->clock = mmc->clock;
-
-	return 0;
-}
-
-static int mxcmci_init(struct mmc *mmc)
-{
-	struct mxcmci_host *host = mmc->priv;
-
-	mxcmci_softreset(host);
-
-	host->rev_no = readl(&host->base->rev_no);
-	if (host->rev_no != 0x400) {
-		printf("wrong rev.no. 0x%08x. aborting.\n",
-			host->rev_no);
-		return -ENODEV;
-	}
-
-	/* recommended in data sheet */
-	writel(0x2db4, &host->base->read_to);
-
-	writel(0, &host->base->int_cntr);
-
-	return 0;
-}
-
-static const struct mmc_ops mxcmci_ops = {
-	.send_cmd	= mxcmci_request,
-	.set_ios	= mxcmci_set_ios,
-	.init		= mxcmci_init,
-};
-
-static struct mmc_config mxcmci_cfg = {
-	.name		= "MXC MCI",
-	.ops		= &mxcmci_ops,
-	.host_caps	= MMC_MODE_4BIT,
-	.voltages	= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.b_max		= CONFIG_SYS_MMC_MAX_BLK_COUNT,
-};
-
-static int mxcmci_initialize(struct bd_info *bis)
-{
-	host->base = (struct mxcmci_regs *)CONFIG_MXC_MCI_REGS_BASE;
-
-	mxcmci_cfg.f_min = mxc_get_clock(MXC_ESDHC_CLK) >> 7;
-	mxcmci_cfg.f_max = mxc_get_clock(MXC_ESDHC_CLK) >> 1;
-
-	host->mmc = mmc_create(&mxcmci_cfg, host);
-	if (host->mmc == NULL)
-		return -1;
-
-	return 0;
-}
-
-int mxc_mmc_init(struct bd_info *bis)
-{
-	return mxcmci_initialize(bis);
-}
-- 
2.43.0

