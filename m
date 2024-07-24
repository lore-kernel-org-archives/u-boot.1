Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6800C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474898891E;
	Wed, 24 Jul 2024 12:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ODn0JQpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11185888F3; Wed, 24 Jul 2024 12:00:16 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E8488905
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7a94478a4eso129739566b.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721815213; x=1722420013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZZxXDi5dWjl5niZEQ4m+yyaS06BDzPpOseJaAxCoRc=;
 b=ODn0JQpgjE+b6uJCY+TXlp+jgmIjU0HWEAI6GLI2HcO8lIPg74KCaUCG2VGz+mOAAK
 z52CzRZdbI5C5u+15gT8X/iDwUruKaNuQyS7sPsTMhwukla80zb3QCKorS2mzTWt1U1k
 K25YBQCYFK2/Oh+VxQlxvQ4gzCFe/Jblth3+TjKDmzz8XccTEYNu+uIH9F+V19+FMP8c
 SVpn6JG6QNNwF5ctSmXTm1adLJ9DGIiycDax32I0yNZujybUSrH2WeXtiGwuBKx6TWiY
 mlty4ukXFyidDIWbkrpG3n9z//5YUNf2hurYzBaYfU/h+yRvBR+2TYTxSYvjSPP3BaBw
 rQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721815213; x=1722420013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZZxXDi5dWjl5niZEQ4m+yyaS06BDzPpOseJaAxCoRc=;
 b=fZ5aRBz/zkMZaPk1mQ/Aol3SpYiPk4RgJSf/vZubWURpj7sP6/znI1XxLCOCsP5zls
 D6eazkafEWit8Xn9SbdeW82P4glRMlbVSsMxXNO/FN80dd/8suMeomG8CqRDKYH+LozR
 EKvwGoJpoUfXIVjt0u+gAzVsk0CVykrd6mKSx3Pm2sYrM1xtK/bsGyJt1tWQE+D6CHxP
 jy7XXzoCGDcrWVcMyV9Fb79FtJi0WtGSmIOt3KgZuyeXMB3ovtn759a016B2XUnquAqT
 wsDoYA6/axomIsk7xRhtxNpBo1oIuY2zTB5/Ljk5zIIY9VTTeUKhRzg0cUAUArspfl9p
 eQPg==
X-Gm-Message-State: AOJu0YzKpM5pwNLoqL+RV3iZLKFQk6GKiARM+ZwHr/hIXuMFrNUYQSrl
 9Tm8GJXWkWMbLuTo0NxBU9l7tb3JHRisaf3SVr4L33OyRekMBmAtPEbBew==
X-Google-Smtp-Source: AGHT+IFMPDOQp5ExK+FwE86ncGSTB9EsKjoi+OR8d/Hirjyg4zCHdDOmnIXd4jXXrlLmuSPYHC48vw==
X-Received: by 2002:a17:907:970b:b0:a77:c051:36a9 with SMTP id
 a640c23a62f3a-a7ab2cfa7c7mr148499766b.9.1721815213023; 
 Wed, 24 Jul 2024 03:00:13 -0700 (PDT)
Received: from localhost.localdomain ([147.161.231.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785d64sm625226666b.28.2024.07.24.03.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:00:12 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH 3/3] i2c: imx_lpi2c: Support read transfers longer than 256
 bytes
Date: Wed, 24 Jul 2024 11:59:43 +0200
Message-Id: <20240724095943.214967-3-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724095943.214967-1-fedor.ross@ifm.com>
References: <20240724095943.214967-1-fedor.ross@ifm.com>
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

From: Fedor Ross <fedor.ross@ifm.com>

The TXFIFO register of LPI2C only has one byte length, and if the length
of the data that needs to be read exceeds 256 bytes, it needs to be
written to TXFIFO multiple times.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/i2c/imx_lpi2c.c | 72 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index 7b10b2b252d..dd97228ddc7 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -19,6 +19,8 @@
 #define LPI2C_NACK_TOUT_MS 1
 #define LPI2C_TIMEOUT_MS 100
 
+#define CHUNK_DATA      256
+
 static int bus_i2c_init(struct udevice *bus, int speed);
 
 /* Weak linked function for overridden by some SoC power function */
@@ -118,8 +120,10 @@ static int bus_i2c_send(struct udevice *bus, u8 *txbuf, int len)
 
 static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
 {
+	struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
 	struct imx_lpi2c_bus *i2c_bus = dev_get_priv(bus);
 	struct imx_lpi2c_reg *regs = (struct imx_lpi2c_reg *)(i2c_bus->base);
+	unsigned int chunk_len, rx_remain, timeout;
 	lpi2c_status_t result = LPI2C_SUCESS;
 	u32 val;
 	ulong start_time = get_timer(0);
@@ -128,33 +132,51 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
 	if (!len)
 		return result;
 
-	result = bus_i2c_wait_for_tx_ready(regs);
-	if (result) {
-		debug("i2c: receive wait for tx ready: %d\n", result);
-		return result;
-	}
+	/*
+	 * Extend the timeout for a bulk read if needed.
+	 * The calculated timeout is the result of multiplying the
+	 * transfer length with 8 bit + ACK + one clock of extra time,
+	 * considering the I2C bus frequency.
+	 */
+	timeout = max(len * 10 * 1000 / i2c->speed_hz, LPI2C_TIMEOUT_MS);
 
-	/* clear all status flags */
-	writel(0x7f00, &regs->msr);
-	/* send receive command */
-	val = LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(len - 1);
-	writel(val, &regs->mtdr);
+	rx_remain = len;
+	while (rx_remain > 0) {
+		chunk_len = clamp(rx_remain, 1, CHUNK_DATA) - 1;
 
-	while (len--) {
-		do {
-			result = imx_lpci2c_check_clear_error(regs);
-			if (result) {
-				debug("i2c: receive check clear error: %d\n",
-				      result);
-				return result;
-			}
-			if (get_timer(start_time) > LPI2C_TIMEOUT_MS) {
-				debug("i2c: receive mrdr: timeout\n");
-				return -1;
-			}
-			val = readl(&regs->mrdr);
-		} while (val & LPI2C_MRDR_RXEMPTY_MASK);
-		*rxbuf++ = LPI2C_MRDR_DATA(val);
+		result = bus_i2c_wait_for_tx_ready(regs);
+		if (result) {
+			debug("i2c: receive wait for tx ready: %d\n", result);
+			return result;
+		}
+
+		/* clear all status flags */
+		writel(0x7f00, &regs->msr);
+		/* send receive command */
+		val = LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(chunk_len);
+		writel(val, &regs->mtdr);
+		rx_remain = rx_remain - (chunk_len & 0xff) - 1;
+
+		while (len--) {
+			do {
+				result = imx_lpci2c_check_clear_error(regs);
+				if (result) {
+					debug("i2c: receive check clear error: %d\n",
+					      result);
+					return result;
+				}
+				if (get_timer(start_time) > timeout) {
+					debug("i2c: receive mrdr: timeout\n");
+					return -1;
+				}
+				val = readl(&regs->mrdr);
+			} while (val & LPI2C_MRDR_RXEMPTY_MASK);
+			*rxbuf++ = LPI2C_MRDR_DATA(val);
+
+			/* send next receive command before controller NACKs last byte */
+			if ((len - rx_remain) < 2 && rx_remain > 0)
+				break;
+		}
 	}
 
 	return result;
-- 
2.34.1

