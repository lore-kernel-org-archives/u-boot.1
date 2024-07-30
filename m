Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA04C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 15:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55D788872;
	Tue, 30 Jul 2024 17:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qj8fXj6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF08E88886; Tue, 30 Jul 2024 17:26:07 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6A29888A2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 17:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso441829266b.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722353158; x=1722957958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvKa2ttgKqZPRSyWnp6px77r3hHvsF7m42DGwOPPK8k=;
 b=Qj8fXj6xg+DZbAlL2q74gL/U2G7bmbcVwljR3fMRu0tLLw2/JWPSzcXh2dB6ZgCoNX
 qCKLjTFWe81EK2qj1EfNd0W+2JDszZe38oL+AKEwadFROfJNB33eDTIrdYKQiYODGwDw
 1oQIrH0Pfz9rUI9vGHBe2yXN3UBhqkBtrYjTRKp2z9Ucm4Cq+CZtWbG+keD7t3syT2WX
 DC9aNaeM2BXQR6MZZ4urZ0qgA8NtDVoGiTGFssKsJPhXsB26VGDB4tKVO8p+4NNwxcE7
 mvABN8UCoaUJvtBuZ+9oP38RWNO92z3IYhJ2JLcxIfys+R5yX4HcE7CyMtRFnm748zUR
 mMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722353158; x=1722957958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvKa2ttgKqZPRSyWnp6px77r3hHvsF7m42DGwOPPK8k=;
 b=rIEt0Qa9lB08AihTSlzCghSFYGGfL+9RuS/vomozMZhwV9Qp29Ipwe86G1U7wWqr3l
 RaD+0Aunac2FYbGAlXER1cWcJF7hAVHwmgKNFEBzhjOntkZCyJaRWxZWWO7fzDFiJ9df
 Pu6zhr7v4EqBGzShO+q9IM5z/JzP6Pcc/20LUNBcNNWoyobsJ/Csx//+k29EqVmJ3edZ
 2CzMSW2Ai6hmyhXgowwsa1cJNvUkSME9pL1Fgs+wf47Q+JNjR8P87jQeDgDtdI5KnAHf
 dhsSlfPtcf5e1xqeL/7c2YV/GfCosPgON/OdvYIcaBSTtvlCO3NP9qORSaekWR7pShSB
 Zwdw==
X-Gm-Message-State: AOJu0Yzx9qN1yRVGAvmPHyXPtgslvdzx2KpgqpEiN42Qx5ByGJGVawxc
 c4cdkXokPta556gWSWa8R55VjcB0XspRYsw5gSRoskQZgZ1DNsyUW0OZNg==
X-Google-Smtp-Source: AGHT+IFaZiRK7PoiVd25dlmSUvpo7Hi9qN+E0Z9im4ESkp3Uorpli2PGEScIu7pnXp1A9KtSVHllww==
X-Received: by 2002:a17:906:f58c:b0:a77:c26c:a571 with SMTP id
 a640c23a62f3a-a7d401795a1mr797620566b.54.1722353158079; 
 Tue, 30 Jul 2024 08:25:58 -0700 (PDT)
Received: from localhost.localdomain ([147.161.231.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab535a6sm654333466b.88.2024.07.30.08.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 08:25:57 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCHv2 3/3] i2c: imx_lpi2c: Support read transfers longer than 256
 bytes
Date: Tue, 30 Jul 2024 17:25:29 +0200
Message-Id: <20240730152529.143651-3-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730152529.143651-1-fedor.ross@ifm.com>
References: <20240730152529.143651-1-fedor.ross@ifm.com>
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
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---

Changes in v2:
- Add additional '---' below SoB line to separate Cc list. This way it
  does not get included in the commit message when the patch is applied.
- Prefix 'CHUNK_DATA' macro with 'LPI2C_' to namespace it.
- Do bit manipulation in writel() function directly and drop the 
  'val = assignment' .

 drivers/i2c/imx_lpi2c.c | 71 ++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index 54db6fa863f..a223d91bac3 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -19,6 +19,8 @@
 #define LPI2C_NACK_TOUT_MS 1
 #define LPI2C_TIMEOUT_MS 100
 
+#define LPI2C_CHUNK_DATA	256
+
 static int bus_i2c_init(struct udevice *bus);
 
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
@@ -128,33 +132,50 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
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
+		chunk_len = clamp(rx_remain, 1, LPI2C_CHUNK_DATA) - 1;
 
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
+		writel(LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(chunk_len), &regs->mtdr);
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

