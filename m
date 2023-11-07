Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3D3C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46636875E8;
	Tue,  7 Nov 2023 20:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H5AkzTs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25DF875C6; Tue,  7 Nov 2023 20:06:11 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E063870BC
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 20:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b2e308a751so5470b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 11:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699383965; x=1699988765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfF15bOqd2HKm14u2HtIQKTVmgnM4eGssEsIUHfHn1E=;
 b=H5AkzTs/TRSHFvvNamac62IcRHn0+r+kdL3gwSDBABwqcE06xtm3V7Y4gDY4SemKci
 LQ1qz4abu4cj6h51Kwpaih/pl6yvFsPFxTEJas2i6ykSGhbPw66MoYt3tNznb8EzHnNC
 xftbO+DnId4OQ4cXwU/fdW85d6TVUF7RBqvoiLe5KTF6eWq/5a+Vqi14BOVVf9E8unH/
 ECdmBfV+ft1SoeNv7uWBmNitRXVZQqvdnyl05tmDm/Hlh4a5Jxykz/89XT98dcw/X/Qz
 F4RP1vL/RMcBGWMDYLsayQl/AVgA0YQfHObZLErvJ7EFJluFaQMkrh4Iakf8LWqxZBgr
 4Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383965; x=1699988765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfF15bOqd2HKm14u2HtIQKTVmgnM4eGssEsIUHfHn1E=;
 b=f9L/ySjlqaxUAboQlhtMhqunT+qsx1jYjXHYSHjj0HVvBd7SVuUCGWGc2GVE70ve3Y
 xzqpl8i4jEpE4ry5e3sKV6EK7A2yH6M0Wi+eYO/CQmSovwsoO8+tXVcs9cr9WStY5SgD
 R0T1nXstmpZE0TpSrrT25FSEZGKX7Raz6zJ+6xJIK9w5yRaph/XgldnwHOesoBElpRYt
 BaIGrJemwpNzjoHoGhUDh0D0RHxVpxRZjlwIKY4GCdKeC/yDn0ep/8GYjbSwBvmNzYGD
 abyNLPUBy9E8Mfo/8htqHC4YI+h83H02ShviTkOCT2p1WhgQ/bl/9SF6kX6MgPvMxfGv
 2ZKw==
X-Gm-Message-State: AOJu0Yx7gTl+NYOCESbVK2v6t1qD21jnYEEg6eeqX8aR7+PwfvceQTAt
 qi6Bs22o9T/UGN81WROg+jXQ0w==
X-Google-Smtp-Source: AGHT+IFugqeYUpu9+SXHGvRmmKu4ZY9hgKr5Rtlv0dHqmVq3EEO5LhNV8AY/a6k14DMYTYTXyM+d5w==
X-Received: by 2002:a05:6808:1492:b0:3b0:f8bd:9503 with SMTP id
 e18-20020a056808149200b003b0f8bd9503mr1847894oiw.10.1699383964749; 
 Tue, 07 Nov 2023 11:06:04 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 c3-20020a056808138300b003b2e7231faasm1632778oiw.28.2023.11.07.11.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:06:04 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <kettenis@openbsd.org>,
	u-boot@lists.denx.de
Subject: [PATCH 3/4] serial: s5p: Use named constants for register values
Date: Tue,  7 Nov 2023 13:06:00 -0600
Message-Id: <20231107190601.17151-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107190601.17151-1-semen.protsenko@linaro.org>
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
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

Get rid of magic numbers in s5p_serial_init() when writing to UART
registers. While at it, use BIT() macro for existing constants when
appropriate.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/serial/serial_s5p.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index c57bdd059ea6..6d316ccaf31d 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -25,19 +25,28 @@ enum {
 	PORT_S5L
 };
 
+#define UFCON_FIFO_EN		BIT(0)
+#define UFCON_RX_FIFO_RESET	BIT(1)
+#define UMCON_RESET_VAL		0x0
+#define ULCON_WORD_8_BIT	0x3
+#define UCON_RX_IRQ_OR_POLLING	BIT(0)
+#define UCON_TX_IRQ_OR_POLLING	BIT(2)
+#define UCON_RX_ERR_IRQ_EN	BIT(6)
+#define UCON_TX_IRQ_LEVEL	BIT(9)
+
 #define S5L_RX_FIFO_COUNT_SHIFT	0
 #define S5L_RX_FIFO_COUNT_MASK	(0xf << S5L_RX_FIFO_COUNT_SHIFT)
-#define S5L_RX_FIFO_FULL	(1 << 8)
+#define S5L_RX_FIFO_FULL	BIT(8)
 #define S5L_TX_FIFO_COUNT_SHIFT	4
 #define S5L_TX_FIFO_COUNT_MASK	(0xf << S5L_TX_FIFO_COUNT_SHIFT)
-#define S5L_TX_FIFO_FULL	(1 << 9)
+#define S5L_TX_FIFO_FULL	BIT(9)
 
 #define S5P_RX_FIFO_COUNT_SHIFT	0
 #define S5P_RX_FIFO_COUNT_MASK	(0xff << S5P_RX_FIFO_COUNT_SHIFT)
-#define S5P_RX_FIFO_FULL	(1 << 8)
+#define S5P_RX_FIFO_FULL	BIT(8)
 #define S5P_TX_FIFO_COUNT_SHIFT	16
 #define S5P_TX_FIFO_COUNT_MASK	(0xff << S5P_TX_FIFO_COUNT_SHIFT)
-#define S5P_TX_FIFO_FULL	(1 << 24)
+#define S5P_TX_FIFO_FULL	BIT(24)
 
 /* Information about a serial port */
 struct s5p_serial_plat {
@@ -80,13 +89,15 @@ static const int udivslot[] = {
 
 static void __maybe_unused s5p_serial_init(struct s5p_uart *uart)
 {
-	/* enable FIFOs, auto clear Rx FIFO */
-	writel(0x3, &uart->ufcon);
-	writel(0, &uart->umcon);
-	/* 8N1 */
-	writel(0x3, &uart->ulcon);
+	/* Enable FIFOs, auto clear Rx FIFO */
+	writel(UFCON_FIFO_EN | UFCON_RX_FIFO_RESET, &uart->ufcon);
+	/* No auto flow control, disable nRTS signal */
+	writel(UMCON_RESET_VAL, &uart->umcon);
+	/* 8N1, no parity bit */
+	writel(ULCON_WORD_8_BIT, &uart->ulcon);
 	/* No interrupts, no DMA, pure polling */
-	writel(0x245, &uart->ucon);
+	writel(UCON_RX_IRQ_OR_POLLING | UCON_TX_IRQ_OR_POLLING |
+	       UCON_RX_ERR_IRQ_EN | UCON_TX_IRQ_LEVEL, &uart->ucon);
 }
 
 static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
-- 
2.39.2

