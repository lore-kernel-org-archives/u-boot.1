Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BADC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9BF84033;
	Mon,  4 Aug 2025 23:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pSRM3g8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2772683FE6; Mon,  4 Aug 2025 23:57:34 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0977583D40
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3e3d0cba6a7so17955755ab.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344649; x=1754949449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UNfpn/8bNdtWB3rYjkwmg9v4PBV8vUw+HdnYfbRneSA=;
 b=pSRM3g8Rd4XBt7XXGHVoWWVNpsX0WqHPnXYL5FhvVcaKNqOhjYosR3l2nii/imHqfY
 aqE2LZxri0oWH3ryhFL/PcaYLDvpem8AgqfS21VB54UyU+2s2538Qibat5A/DSU2gMiz
 v4RA8er2CIiObCiyxvzPZfZRuHeqGpV8MsGH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344649; x=1754949449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNfpn/8bNdtWB3rYjkwmg9v4PBV8vUw+HdnYfbRneSA=;
 b=Fb2ksZotSB2aZ3/clGBN+MB7wV7E6LpQEQ0wAQfJVvbbgVJ9XS3xpQvE1vZNTx7I4u
 nOkuQloYyhAVlRSPMd4n/HnYmm6hnz8ux4IoRIbOPA5+pUT1VK3Updx4eE/LK7SiE/vb
 JM73xOo9U0Pq/RmRb+QHVRjZ2kYCej65oxqTNLVC8NgCsxRRNmK4qYlOXHZa7VdX/Pem
 fUlprworFBkM7IXQOvhhJwH3Yr3TyyeP7LCj1++/jxwz1vByewUTgWjhBPaiPj/5TREk
 tsFJxksJM272PTiZhTGJM6Kq0yBR8FJN37aF812zyDibP9w43XaIYaXDA9RhxKoHDgGR
 g/RQ==
X-Gm-Message-State: AOJu0YzljWG1hrFX5yhiE5Nq+bv70uSxIVASpR9eMDszEMP69h5WETvp
 OFqkFQtqjr80eMYR2gpP6HTKvo2Kou4cVLjAUIGTjdcmHzsDUjOcmQOhcaJHv3nWR5gr/NNlClh
 LeIcOM7w=
X-Gm-Gg: ASbGncsn1v+l8s0peDLjBRYxu953a01/+eqS9l0V2wy74TkLx0m0B5j4nm/RBPz6Lrt
 m5fEZlpneAng/X+SRnpilGOnr2LGN/z1UW8JrpfrDZe9UsXnuT+oWyqBMporXHrYAOU1Txt0Q2T
 SvlE9+c4yO03agA6UtqqvIh/MQQCWr+79tG7n9S4TwXesDnmFYlqXOvFH0pjWKx87Xm9YyWB6Pv
 /N5izZqo+xySVoWZW2LQ7FDdKMxCilv4LDhwFU/f6tn9Ut5W57xYaZSRNYFeykidJi4WxnGFT4A
 pzs+96gUfV2a4QjYtXnVPskIfr9UDmvfQSQ/yPCfYU73Cn1m1qm9uKQCifXvpOB+l/10S9YyE0C
 I4KOlm78fjFmqZNcXDUpueJHFXEkw4jP4gVSGiuLVlHb7lSSAQn6howoglHrkxv5S7Uax
X-Google-Smtp-Source: AGHT+IEdueYt12zv8mqqV10JZVagT7cE9B6jPPcNMfyt//yscrapcazusBTLeWDgNzFg+y5PzZseOA==
X-Received: by 2002:a05:6e02:1b0b:b0:3e4:117d:68b3 with SMTP id
 e9e14a558f8ab-3e4160fb7a9mr215399275ab.2.1754344644732; 
 Mon, 04 Aug 2025 14:57:24 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] serial: linflexuart: Remove unused driver
Date: Mon,  4 Aug 2025 15:57:14 -0600
Message-ID: <20250804215719.1413106-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215719.1413106-1-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
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

This driver is unused. Remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/serial/Kconfig              |   7 -
 drivers/serial/Makefile             |   1 -
 drivers/serial/serial_linflexuart.c | 216 ----------------------------
 3 files changed, 224 deletions(-)
 delete mode 100644 drivers/serial/serial_linflexuart.c

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7d59e02dd0a..bc05d2f15085 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -730,13 +730,6 @@ config CORTINA_UART
 	  Select this to enable UART support for Cortina-Access UART devices
 	  found on CAxxxx SoCs.
 
-config FSL_LINFLEXUART
-	bool "Freescale Linflex UART support"
-	depends on DM_SERIAL
-	help
-	  Select this to enable the Linflex serial module found on some
-	  NXP SoCs like S32V234.
-
 config FSL_LPUART
 	bool "Freescale LPUART support"
 	depends on MACH_IMX || ARCH_LS1021A || ARCH_LS1028A
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index c32e3fcd439b..8eaae62b0fc4 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_SCIF_CONSOLE) += serial_sh.o
 obj-$(CONFIG_SEMIHOSTING_SERIAL) += serial_semihosting.o
 obj-$(CONFIG_ZYNQ_SERIAL) += serial_zynq.o
 obj-$(CONFIG_FSL_LPUART) += serial_lpuart.o
-obj-$(CONFIG_FSL_LINFLEXUART) += serial_linflexuart.o
 obj-$(CONFIG_ARC_SERIAL) += serial_arc.o
 obj-$(CONFIG_UNIPHIER_SERIAL) += serial_uniphier.o
 obj-$(CONFIG_STM32_SERIAL) += serial_stm32.o
diff --git a/drivers/serial/serial_linflexuart.c b/drivers/serial/serial_linflexuart.c
deleted file mode 100644
index 24ecb236d516..000000000000
--- a/drivers/serial/serial_linflexuart.c
+++ /dev/null
@@ -1,216 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2013-2016 Freescale Semiconductor, Inc.
- */
-
-#include <dm.h>
-#include <errno.h>
-#include <watchdog.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <serial.h>
-#include <linux/compiler.h>
-#include <asm/arch/imx-regs.h>
-#include <asm/arch/clock.h>
-
-#define US1_TDRE            (1 << 7)
-#define US1_RDRF            (1 << 5)
-#define UC2_TE              (1 << 3)
-#define LINCR1_INIT         (1 << 0)
-#define LINCR1_MME          (1 << 4)
-#define LINCR1_BF           (1 << 7)
-#define LINSR_LINS_INITMODE (0x00001000)
-#define LINSR_LINS_MASK     (0x0000F000)
-#define UARTCR_UART         (1 << 0)
-#define UARTCR_WL0          (1 << 1)
-#define UARTCR_PCE          (1 << 2)
-#define UARTCR_PC0          (1 << 3)
-#define UARTCR_TXEN         (1 << 4)
-#define UARTCR_RXEN         (1 << 5)
-#define UARTCR_PC1          (1 << 6)
-#define UARTSR_DTF          (1 << 1)
-#define UARTSR_DRF          (1 << 2)
-#define UARTSR_RMB          (1 << 9)
-
-DECLARE_GLOBAL_DATA_PTR;
-
-static void _linflex_serial_setbrg(struct linflex_fsl *base, int baudrate)
-{
-	u32 clk = mxc_get_clock(MXC_UART_CLK);
-	u32 ibr, fbr;
-
-	if (!baudrate)
-		baudrate = CONFIG_BAUDRATE;
-
-	ibr = (u32) (clk / (16 * gd->baudrate));
-	fbr = (u32) (clk % (16 * gd->baudrate)) * 16;
-
-	__raw_writel(ibr, &base->linibrr);
-	__raw_writel(fbr, &base->linfbrr);
-}
-
-static int _linflex_serial_getc(struct linflex_fsl *base)
-{
-	char c;
-
-	if (!(__raw_readb(&base->uartsr) & UARTSR_DRF))
-		return -EAGAIN;
-
-	if (!(__raw_readl(&base->uartsr) & UARTSR_RMB))
-		return -EAGAIN;
-
-	c = __raw_readl(&base->bdrm);
-	__raw_writeb((__raw_readb(&base->uartsr) | (UARTSR_DRF | UARTSR_RMB)),
-		     &base->uartsr);
-	return c;
-}
-
-static int _linflex_serial_putc(struct linflex_fsl *base, const char c)
-{
-	__raw_writeb(c, &base->bdrl);
-
-	if (!(__raw_readb(&base->uartsr) & UARTSR_DTF))
-		return -EAGAIN;
-
-	__raw_writeb((__raw_readb(&base->uartsr) | UARTSR_DTF), &base->uartsr);
-
-	return 0;
-}
-
-/*
- * Initialise the serial port with the given baudrate. The settings
- * are always 8 data bits, no parity, 1 stop bit, no start bits.
- */
-static int _linflex_serial_init(struct linflex_fsl *base)
-{
-	volatile u32 ctrl;
-
-	/* set the Linflex in master mode amd activate by-pass filter */
-	ctrl = LINCR1_BF | LINCR1_MME;
-	__raw_writel(ctrl, &base->lincr1);
-
-	/* init mode */
-	ctrl |= LINCR1_INIT;
-	__raw_writel(ctrl, &base->lincr1);
-
-	/* waiting for init mode entry - TODO: add a timeout */
-	while ((__raw_readl(&base->linsr) & LINSR_LINS_MASK) !=
-	       LINSR_LINS_INITMODE);
-
-	/* set UART bit to allow writing other bits */
-	__raw_writel(UARTCR_UART, &base->uartcr);
-
-	/* provide data bits, parity, stop bit, etc */
-	serial_setbrg();
-
-	/* 8 bit data, no parity, Tx and Rx enabled, UART mode */
-	__raw_writel(UARTCR_PC1 | UARTCR_RXEN | UARTCR_TXEN | UARTCR_PC0
-		     | UARTCR_WL0 | UARTCR_UART, &base->uartcr);
-
-	ctrl = __raw_readl(&base->lincr1);
-	ctrl &= ~LINCR1_INIT;
-	__raw_writel(ctrl, &base->lincr1);	/* end init mode */
-
-	return 0;
-}
-
-struct linflex_serial_plat {
-	struct linflex_fsl *base_addr;
-	u8 port_id; /* do we need this? */
-};
-
-struct linflex_serial_priv {
-	struct linflex_fsl *lfuart;
-};
-
-int linflex_serial_setbrg(struct udevice *dev, int baudrate)
-{
-	struct linflex_serial_priv *priv = dev_get_priv(dev);
-
-	_linflex_serial_setbrg(priv->lfuart, baudrate);
-
-	return 0;
-}
-
-static int linflex_serial_getc(struct udevice *dev)
-{
-	struct linflex_serial_priv *priv = dev_get_priv(dev);
-
-	return _linflex_serial_getc(priv->lfuart);
-}
-
-static int linflex_serial_putc(struct udevice *dev, const char ch)
-{
-
-	struct linflex_serial_priv *priv = dev_get_priv(dev);
-
-	return _linflex_serial_putc(priv->lfuart, ch);
-}
-
-static int linflex_serial_pending(struct udevice *dev, bool input)
-{
-	struct linflex_serial_priv *priv = dev_get_priv(dev);
-	uint32_t uartsr = __raw_readl(&priv->lfuart->uartsr);
-
-	if (input)
-		return ((uartsr & UARTSR_DRF) && (uartsr & UARTSR_RMB)) ? 1 : 0;
-	else
-		return uartsr & UARTSR_DTF ? 0 : 1;
-}
-
-static void linflex_serial_init_internal(struct linflex_fsl *lfuart)
-{
-	_linflex_serial_init(lfuart);
-	_linflex_serial_setbrg(lfuart, CONFIG_BAUDRATE);
-	return;
-}
-
-static int linflex_serial_probe(struct udevice *dev)
-{
-	struct linflex_serial_plat *plat = dev_get_plat(dev);
-	struct linflex_serial_priv *priv = dev_get_priv(dev);
-
-	priv->lfuart = (struct linflex_fsl *)plat->base_addr;
-	linflex_serial_init_internal(priv->lfuart);
-
-	return 0;
-}
-
-static const struct dm_serial_ops linflex_serial_ops = {
-	.putc = linflex_serial_putc,
-	.pending = linflex_serial_pending,
-	.getc = linflex_serial_getc,
-	.setbrg = linflex_serial_setbrg,
-};
-
-U_BOOT_DRIVER(serial_linflex) = {
-	.name	= "serial_linflex",
-	.id	= UCLASS_SERIAL,
-	.probe = linflex_serial_probe,
-	.ops	= &linflex_serial_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-	.priv_auto	= sizeof(struct linflex_serial_priv),
-};
-
-#ifdef CONFIG_DEBUG_UART_LINFLEXUART
-
-#include <debug_uart.h>
-
-static inline void _debug_uart_init(void)
-{
-	struct linflex_fsl *base = (struct linflex_fsl *)CONFIG_VAL(DEBUG_UART_BASE);
-
-	linflex_serial_init_internal(base);
-}
-
-static inline void _debug_uart_putc(int ch)
-{
-	struct linflex_fsl *base = (struct linflex_fsl *)CONFIG_VAL(DEBUG_UART_BASE);
-
-	/* XXX: Is this OK? Should this use the non-DM version? */
-	_linflex_serial_putc(base, ch);
-}
-
-DEBUG_UART_FUNCS
-
-#endif /* CONFIG_DEBUG_UART_LINFLEXUART */
-- 
2.43.0

