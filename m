Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98036C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59CDA82F28;
	Tue, 24 Jun 2025 10:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mnTgy9iw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F9E82C2F; Tue, 24 Jun 2025 10:45:42 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502C682E20
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so27012705e9.3
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754740; x=1751359540; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xopmBEDY1CEYS6c45FXr72QHWJs6lsZNkN1px9QWbgc=;
 b=mnTgy9iwn0JDdTsGssBY8Avil1Tk2RAmLAdEAijjvd5b1ZXCoafKGc8m5lm57+wriB
 16LDx7XHXP5TJuUMd5ZXdx0A03DrDsx3fP7TBlOCuT9e7pnjU1zhW1nzVhZL0lxs5JLp
 P7vFNaATOsitUUeaV+zOn8L/me6i3WisxLRDaGSi7d8inAnhAJkezBrODzV17Y2It/lZ
 xJ+ryqh9yNnZYTYwqPpulqK9ewln2vKVhofnrTm5Fl8ca2qLzR/EvmPCXuUepnJfX5Xn
 km70I04NU+jQ3e1QkfNdGogSNsqQDS9YOnil+OMPYt5ibveyUDS/9KtneAS3/JRBEX0R
 jMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754740; x=1751359540;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xopmBEDY1CEYS6c45FXr72QHWJs6lsZNkN1px9QWbgc=;
 b=a8VFP4ENH/0yx+SoAmDNg0bMEeexZPYFWQT6XD9I0GYN94a0EtQvHR2D4nOe/U8KI1
 qOBLJ2FiIXCuGQvqoVi+a4XMZxdo/Ninwf0w691uoJrNX8JwXbvrSXY5wG9siXCdfhpk
 wOdUAXMajWTUmBu8OvHXrcrcHVlGt0bT+8xrlkwWgPAvFghKqxBaHfl55gWagwEbzwnJ
 qvGvZ1CizsG+MwEfRgaCEeKmFG9gMIe6rbsLaXJRlYCnvmYVRdfipt0m+129qmw261+q
 Y51hWZr8jhdx2OOCpk/KYW21t7ri9Aftx4nl3Bily4iXQ/21RZzYsOHZnUrIbggNsbRP
 MViA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgdASy84/9d62qkOiYLIIdDBOwtA8aE7TaLHSPXKqst2xp+pgTjutDUBlBBcq3IMlXGOrHuxs=@lists.denx.de
X-Gm-Message-State: AOJu0YyaAxj2XRXSqQsPmncHReRaKCh4UKzGZtnw+JfOOC0RtjkVwxv7
 l90WFiBgtPbcGwZHn0tsgu/qIk0fLiktJCSO/Snv2tr7pQRRIrovBsv7anTHP12BH80=
X-Gm-Gg: ASbGnct3rU7SxSq8o1aIilMSbNSr0qxGzr/S9QLa5iG7wOjg3t07NMZJcbKY2fZZu2D
 8PD1WfUsPt4M0JiSHjIe4qc1yG7GnF3QLWEf35OCNVWPXLRubNUXkAeW4SIxp9VdBbWSZZorx+0
 SDHcEDVKNOhSj89xYT3GW8djnmcam2XBrf+/tckKnN/SDAJ+FjNNJM50TDh9Igyklqp6yPRsLLp
 y6dUAshri92JUNgswDuvKvopW3yUNAIX5OugVqvWHU+w5KdpqPYoFAKLck3i12AfJRXyP4WswJC
 kORJxIs61tCo+prgo4Hs16eHUl6mtWMJ8UKzka8qBD9H5hKnRqUi7S3Z9b8QkPJChEFgpxbEVHQ
 =
X-Google-Smtp-Source: AGHT+IFU2It5IUE81knpgbbSYgegvmouELy3HhmlbOI0W1rRIuMAzSlW0FPsv7YYksx+xUY5YgM4iw==
X-Received: by 2002:a05:600c:3b1e:b0:453:78f:faa8 with SMTP id
 5b1f17b1804b1-453659c0dbamr131857495e9.6.1750754739574; 
 Tue, 24 Jun 2025 01:45:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:39 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:23 +0200
Subject: [PATCH 10/10] serial: msm: Use single character mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-10-d96c97ae41d1@linaro.org>
References: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
In-Reply-To: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

The UART DM controller supports different channel data packing modes,
either the 4-character packing mode (where 32-bit are read/written at once)
or the single-character mode (where only a single character is read/written
at a time). The 4-character mode can be more efficient, but the
single-character mode is much easier to implement.

At the moment, serial_msm uses the 4-character mode. Since the
dm_serial_ops operate on one character at the time, the code goes through
quite some hoops in order to break this down to single characters. This
code is prone to race conditions (e.g. priv->chars_cnt is read from the
registers, then a command is issued, what if another char came in
inbetween?). It also seems to cause another subtle issue with autoboot:

Unlike the previous autoboot failures that happened when UART was
disconnected, this problem occurs when UART is connected and open in a
terminal: For EFI boot, the console size is queried in efi_console.c
query_console_serial() by sending an ANSI escape code via UART. For some
reason, with the current driver we get yet another 0x00 byte (UART break
event?) when reading the reply from serial input. Because of that, reading
the console size fails in efi_console.c, the actual reply remains in the
UART buffer, and later the boot flow aborts because it detects input after
printing a prompt.

Rather than trying to fix the issue in the current complicated approach,
switch the driver to use the single-character mode. This is simple and
straightforward to implement without race conditions:

 - We write one character at a time to UARTDM_TF, as long as the TX FIFO
   has space available (TX_READY). To flush the console before starting
   Linux, we wait for TX_EMPTY.

 - We read one character at a time from UARTDM_RF and strip off the
   additional error information (assuming there is something in the
   RX FIFO, as indicated by RX_READY).

In this mode, querying the serial console size works and autoboot is no
longer interrupted. The overall code is also much shorter.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/serial/serial_msm.c | 102 +++++++-------------------------------------
 1 file changed, 16 insertions(+), 86 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 2c08a84b02773663f3c3a11eddaaa7a8bab2b4a1..18d15b7b15b3aeb2e8fd1da1aa49967d55c943ab 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -21,13 +21,9 @@
 
 /* Serial registers - this driver works in uartdm mode*/
 
-#define UARTDM_DMRX             0x34 /* Max RX transfer length */
-#define UARTDM_DMEN             0x3C /* DMA/data-packing mode */
-#define UARTDM_NCF_TX           0x40 /* Number of chars to TX */
+#define UARTDM_DMEN			0x3C /* DMA/data-packing mode */
+#define UARTDM_DMEN_TXRX_SC_ENABLE	(BIT(4) | BIT(5))
 
-#define UARTDM_RXFS             0x50 /* RX channel status register */
-#define UARTDM_RXFS_BUF_SHIFT   0x7  /* Number of bytes in the packing buffer */
-#define UARTDM_RXFS_BUF_MASK    0x7
 #define UARTDM_MR1				 0x00
 #define UARTDM_MR1_RX_RDY_CTL			 BIT(7)
 #define UARTDM_MR2				 0x04
@@ -45,118 +41,56 @@
 #define UARTDM_CSR				 0xA0
 
 #define UARTDM_SR                0xA4 /* Status register */
-#define UARTDM_SR_RX_READY       (1 << 0) /* Word is the receiver FIFO */
+#define UARTDM_SR_RX_READY       (1 << 0) /* Receiver FIFO has data */
+#define UARTDM_SR_TX_READY       (1 << 2) /* Transmitter FIFO has space */
 #define UARTDM_SR_TX_EMPTY       (1 << 3) /* Transmitter underrun */
-#define UARTDM_SR_UART_OVERRUN   (1 << 4) /* Receive overrun */
 
 #define UARTDM_CR                         0xA8 /* Command register */
 #define UARTDM_CR_RX_ENABLE               (1 << 0) /* Enable receiver */
 #define UARTDM_CR_TX_ENABLE               (1 << 2) /* Enable transmitter */
 #define UARTDM_CR_CMD_RESET_RX            (1 << 4) /* Reset receiver */
 #define UARTDM_CR_CMD_RESET_TX            (2 << 4) /* Reset transmitter */
-#define UARTDM_CR_CMD_RESET_ERR           (3 << 4) /* Clear overrun error */
-#define UARTDM_CR_CMD_RESET_STALE_INT     (8 << 4) /* Clears stale irq */
-#define UARTDM_CR_CMD_RESET_TX_READY      (3 << 8) /* Clears TX Ready irq*/
-#define UARTDM_CR_CMD_FORCE_STALE         (4 << 8) /* Causes stale event */
-#define UARTDM_CR_CMD_STALE_EVENT_DISABLE (6 << 8) /* Disable stale event */
-
-#define UARTDM_IMR                0xB0 /* Interrupt mask register */
-#define UARTDM_ISR                0xB4 /* Interrupt status register */
-#define UARTDM_ISR_TX_READY       0x80 /* TX FIFO empty */
 
 #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
 #define UARTDM_RF               0x140 /* UART Receive FIFO register */
+#define UARTDM_RF_CHAR          0xff /* higher bits contain error information */
 
 DECLARE_GLOBAL_DATA_PTR;
 
 struct msm_serial_data {
 	phys_addr_t base;
-	unsigned chars_cnt; /* number of buffered chars */
-	uint32_t chars_buf; /* buffered chars */
 	uint32_t clk_rate; /* core clock rate */
 };
 
-static int msm_serial_fetch(struct udevice *dev)
-{
-	struct msm_serial_data *priv = dev_get_priv(dev);
-	unsigned sr;
-
-	if (priv->chars_cnt)
-		return priv->chars_cnt;
-
-	/* Clear error in case of buffer overrun */
-	if (readl(priv->base + UARTDM_SR) & UARTDM_SR_UART_OVERRUN)
-		writel(UARTDM_CR_CMD_RESET_ERR, priv->base + UARTDM_CR);
-
-	/* We need to fetch new character */
-	sr = readl(priv->base + UARTDM_SR);
-
-	if (sr & UARTDM_SR_RX_READY) {
-		/* There are at least 4 bytes in fifo */
-		priv->chars_buf = readl(priv->base + UARTDM_RF);
-		priv->chars_cnt = 4;
-	} else {
-		/* Check if there is anything in fifo */
-		priv->chars_cnt = readl(priv->base + UARTDM_RXFS);
-		/* Extract number of characters in UART packing buffer*/
-		priv->chars_cnt = (priv->chars_cnt >>
-				   UARTDM_RXFS_BUF_SHIFT) &
-				  UARTDM_RXFS_BUF_MASK;
-		if (!priv->chars_cnt)
-			return 0;
-
-		/* There is at least one charcter, move it to fifo */
-		writel(UARTDM_CR_CMD_FORCE_STALE,
-		       priv->base + UARTDM_CR);
-
-		priv->chars_buf = readl(priv->base + UARTDM_RF);
-		writel(UARTDM_CR_CMD_RESET_STALE_INT,
-		       priv->base + UARTDM_CR);
-		writel(0x7, priv->base + UARTDM_DMRX);
-	}
-
-	return priv->chars_cnt;
-}
-
 static int msm_serial_getc(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
-	char c;
 
-	if (!msm_serial_fetch(dev))
+	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY))
 		return -EAGAIN;
 
-	c = priv->chars_buf & 0xFF;
-	priv->chars_buf >>= 8;
-	priv->chars_cnt--;
-
-	return c;
+	return readl(priv->base + UARTDM_RF) & UARTDM_RF_CHAR;
 }
 
 static int msm_serial_putc(struct udevice *dev, const char ch)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 
-	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
-	    !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
+	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
 		return -EAGAIN;
 
-	writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
-
-	writel(1, priv->base + UARTDM_NCF_TX);
 	writel(ch, priv->base + UARTDM_TF);
-
 	return 0;
 }
 
 static int msm_serial_pending(struct udevice *dev, bool input)
 {
-	if (input) {
-		if (msm_serial_fetch(dev))
-			return 1;
-	}
+	struct msm_serial_data *priv = dev_get_priv(dev);
 
-	return 0;
+	if (input)
+		return !!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY);
+	else
+		return !(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY);
 }
 
 static const struct dm_serial_ops msm_serial_ops = {
@@ -222,8 +156,8 @@ static void uart_dm_init(struct msm_serial_data *priv)
 	writel(UARTDM_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
 	writel(UARTDM_MR2_8_N_1_MODE, priv->base + UARTDM_MR2);
 
-	/* Make sure BAM/single character mode is disabled */
-	writel(0x0, priv->base + UARTDM_DMEN);
+	/* Enable single character mode */
+	writel(UARTDM_DMEN_TXRX_SC_ENABLE, priv->base + UARTDM_DMEN);
 
 	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
 	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
@@ -320,13 +254,9 @@ static inline void _debug_uart_putc(int ch)
 {
 	struct msm_serial_data *priv = &init_serial_data;
 
-	while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
-	       !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
+	while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
 		;
 
-	writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
-
-	writel(1, priv->base + UARTDM_NCF_TX);
 	writel(ch, priv->base + UARTDM_TF);
 }
 

-- 
2.49.0

