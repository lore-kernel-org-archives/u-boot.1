Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37520CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 16:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DED4835D0;
	Wed, 15 Oct 2025 18:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="SwAmUEHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1FD836A3; Wed, 15 Oct 2025 18:26:17 +0200 (CEST)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B30E835C6
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 18:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1760545573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzTdnsmYyQn4s+9GEos7ZS4aqqYVllpTmSHt9fKmqKY=;
 b=SwAmUEHqSPi1jjRnzCN34MPo2QualDr1RPAV3ok7+A18el1+1SeTF3gVM5cvvqMcQH9qrx
 a9wxWXQZQQt669NGu3pUY95L1p5032DmBA5cCJEBRklnj9SP/JsWH1vgYyk/UyYmDtSVcn
 J0+oqK4D41fU5gjt5NU8qs6E69UZqoJ0afUPySR3dAqS7ZfO44MpHm6F6oZ8g+0q4T+f9J
 2RyDQnirADU1VUXTGH6lRyYvHmS+Ia2ONV3QsYHyJbXnvWBurYBZecEPZVNT5Ge7X0SegX
 PeHl8jGbqv7n91xJ/v4MdoRwVgpC44zEzu+4HJJ8S9rRb8cm/kN6WEA/FK0rJQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Oct 2025 16:25:50 +0000
Subject: [PATCH v4 3/8] serial: serial_meson: add minimal non-DM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-spl-gx-v4-3-f5d7fe03225b@postmarketos.org>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
In-Reply-To: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4802;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=l7WHzcd50G1ypQr2Fvu+hWhyrOP8ionWt6nOUOl7/Hs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo78se4b4g5Qj0pfupgyJ1B4H7cQD8P+ZxPaQtI
 HCBvM9K6T+JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaO/LHgAKCRCEr8vQ14ma
 AykmEACNJybVQnKydlH10OzLvsRfCwFexfelS+Gz9tzwcSHAPqN+i1dlf41l3jjPn5FDqAk1JY6
 OMumlPkJgCMJ7FcvMKUtJplFv5B8o1KR1Q6yNqYl60ma3Oxe9Oc0ezMIV3Pdleiya/5yrwyP8JM
 /ZHWpnA3oahcJx/0fITWHft5NpyNrGe3+lGHbMzpJahRaLbobwovsIDm4UK2uRW7d907ZXnbcIB
 7PwdHVK+v/YMRK4Ki305ZyGpSwC+RQDvpsCj6F4aDwg4Rd0CUb7e74Ac3h60LelSsgdutEvlC4F
 iG//kOy3w9uLCBRtVUY7+/T6mByANZu7Zk9zhKey1sglK5WG/I6zWFiWzboDoyO7GLvbRVxi3vt
 imE1Q+Qy4TMG8D8dOUNedtNkL+thE81ESrdiEWLLiSD16Q6SzsEFUJ2RKiQW+KwU5XgrkFwv7fI
 rtz+KkTGiYkJvTNT/tWjmfep3LRG7zALrXx4kTfz3zCgxBm4rosTb30N9g2O1Dn07RrvkK3bW2E
 CS98B7nTuqRPG+djuBnuxhDFWddRXzMAf0l/6GlwglxEbDZg+C6zj3WAhfTikiXRkYmbql3IR3e
 3lcVoRzCq9Q+ChUPspXqnAwzhWQxtwN/cYfF2q30Rb2pUv572lsuV0KaKHumm7k1n/V2zp3xt26
 tvR2J8uFxP41TQg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

It is very limited and minimal, only implements putc/puts.
This minimal driver is intended to be used in SPL, and other
size-constrained situations.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 drivers/serial/serial.c       |   2 +
 drivers/serial/serial_meson.c | 119 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
index e10ca6eef76..c0b1eb30561 100644
--- a/drivers/serial/serial.c
+++ b/drivers/serial/serial.c
@@ -129,6 +129,7 @@ serial_initfunc(pxa_serial_initialize);
 serial_initfunc(smh_serial_initialize);
 serial_initfunc(sh_serial_initialize);
 serial_initfunc(mtk_serial_initialize);
+serial_initfunc(meson_serial_initialize);
 
 /**
  * serial_register() - Register serial driver with serial driver core
@@ -167,6 +168,7 @@ int serial_initialize(void)
 	smh_serial_initialize();
 	sh_serial_initialize();
 	mtk_serial_initialize();
+	meson_serial_initialize();
 
 	serial_assign(default_serial_console()->name);
 
diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index bb79b972957..cc71381f87e 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -3,9 +3,11 @@
  * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
  */
 
+#if CONFIG_IS_ENABLED(DM_SERIAL)
 #include <dm.h>
-#include <errno.h>
 #include <fdtdec.h>
+#endif
+#include <errno.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
@@ -25,6 +27,15 @@ struct meson_serial_plat {
 	struct meson_uart *reg;
 };
 
+#if !CONFIG_IS_ENABLED(DM_SERIAL)
+/* UART base address */
+#if defined(CONFIG_MESON_GX)
+#define AML_UART_BASE	0xc81004c0
+#else /* G12A, AXG, ... */
+#define AML_UART_BASE	0xff803000
+#endif
+#endif
+
 /* AML_UART_STATUS bits */
 #define AML_UART_PARITY_ERR		BIT(16)
 #define AML_UART_FRAME_ERR		BIT(17)
@@ -51,6 +62,7 @@ struct meson_serial_plat {
 #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
 #define AML_UART_REG5_BAUD_MASK		0x7fffff
 
+#if CONFIG_IS_ENABLED(DM_SERIAL)
 static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
 {
 	/*
@@ -245,6 +257,111 @@ U_BOOT_DRIVER(serial_meson) = {
 	.plat_auto	= sizeof(struct meson_serial_plat),
 };
 
+#else
+
+static int meson_serial_init(void)
+{
+	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
+	u32 val;
+
+	val = readl(&uart->control);
+	val |= (AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
+	writel(val, &uart->control);
+	val &= ~(AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
+	writel(val, &uart->control);
+	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
+	writel(val, &uart->control);
+
+	return 0;
+}
+
+static int meson_serial_stop(void)
+{
+	return 0;
+}
+
+static void meson_serial_setbrg(void)
+{
+}
+
+static void meson_serial_putc(const char ch)
+{
+	struct meson_uart *uart = (struct meson_uart *)AML_UART_BASE;
+
+	/* On '\n' also do '\r' */
+	if (ch == '\n')
+		meson_serial_putc('\r');
+
+	while (readl(&uart->status) & AML_UART_TX_FULL)
+		;
+
+	writel(ch, &uart->wfifo);
+}
+
+static void meson_serial_puts(const char *s)
+{
+	while (*s)
+		meson_serial_putc(*s++);
+}
+
+static int meson_serial_getc(void)
+{
+	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
+	uint32_t status = readl(&uart->status);
+
+	if (status & AML_UART_RX_EMPTY)
+		return -EAGAIN;
+
+	if (status & AML_UART_ERR) {
+		u32 val = readl(&uart->control);
+
+		/* Clear error */
+		val |= AML_UART_CLR_ERR;
+		writel(val, &uart->control);
+		val &= ~AML_UART_CLR_ERR;
+		writel(val, &uart->control);
+
+		/* Remove spurious byte from fifo */
+		readl(&uart->rfifo);
+		return -EIO;
+	}
+
+	return readl(&uart->rfifo) & 0xff;
+}
+
+static int meson_serial_tstc(void)
+{
+	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
+	uint32_t status = readl(&uart->status);
+
+	if (status & AML_UART_RX_EMPTY)
+		return 0;
+	return 1;
+}
+
+struct serial_device meson_serial_device = {
+	.name	= "meson_serial",
+	.start	= meson_serial_init,
+	.stop	= meson_serial_stop,
+	.setbrg	= meson_serial_setbrg,
+	.getc	= meson_serial_getc,
+	.tstc	= meson_serial_tstc,
+	.putc	= meson_serial_putc,
+	.puts	= meson_serial_puts,
+};
+
+void meson_serial_initialize(void)
+{
+	serial_register(&meson_serial_device);
+}
+
+__weak struct serial_device *default_serial_console(void)
+{
+	return &meson_serial_device;
+}
+
+#endif
+
 #ifdef CONFIG_DEBUG_UART_MESON
 
 #include <debug_uart.h>

-- 
2.51.0

