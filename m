Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85610C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050D388D04;
	Wed,  7 Aug 2024 16:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ANL7q6Px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFBD688D04; Wed,  7 Aug 2024 16:08:42 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E311588D0E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7a975fb47eso234102866b.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723039719; x=1723644519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzEG+V+GsA8Zg1qM4QSGr8tZxBvYiFKQrEBd52fh35c=;
 b=ANL7q6PxtfYMw1wKSPYfSOVUZ2Xzi3PR2K+8qKns+EtCNZlOqrlRRw0UGlggUz54IY
 A+xM8y1mrzBAIwc6Luj7hYnuOSwEd6qfwScwBMqGTOyULvmOI6V89SLOKS6zn/FYEV2Z
 Ka4nA5sJdOQTAojijIT0MS4E/Z3PLDEUWwuXlApy+4G97vUyaXrjOL/Dlp67EwnBhv7j
 EBSSu2hnulTK6vSpS0q+aJGiusoIvhcb/HSTydU+q1+udOYuZ0yQXd7ygo0XX+MzCeFN
 qBaq+DMohsO82isH2y2FMfCuLUU+IpZyCMIf2O1s+Cz4eGaXe8X/qX0Q9UN91IaSvMcK
 Gl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723039719; x=1723644519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzEG+V+GsA8Zg1qM4QSGr8tZxBvYiFKQrEBd52fh35c=;
 b=ofK9IO4wm87rAb4lqHyFc3+X2Wb/xxduE4VqhhWu5V1b7PjPg74mSkta9uNJ+6XauK
 9z3UzlFC6UGx62vfFuQGSEV5yKBVjpVpOvcJV98pyWwJX2IdrinKVPLJ711/j8PcJDOA
 Yae6vwtbzVnB78q15wUZKo9OP+L6AkRsDwcuPbosswHgthgYguW0lFbICqF+XAKrKC/j
 ILKCrPDoO9HZ1d9drALxq1qnLP3Tv29Bi7gI5Sd6s9H3DWXeDuCpeXltAmnbshAkhk5W
 A+a26y7rTYRQONQP8e+66kJmyM7MlUByc6cUckQfDIiE2OOPCdP12vKjetq+EsBE8Dfy
 Ib/A==
X-Gm-Message-State: AOJu0Yyux0dMzJN170BX55AOrL0HUTnLtZcWcixzMUbBNiDy6q8hLYGL
 bYxj71klxRIJITaB5tom7hm/e6HSGwqCOb3VO7qXShxnYQzr0rE1ltCDMg==
X-Google-Smtp-Source: AGHT+IG1GpPoZTLScGVKZjGklkKG/hw+2taJPTdJ/peXt2oLKvwDGwiskxSCOOAYswNMgCR++zzRFw==
X-Received: by 2002:a17:907:6e9e:b0:a6f:4a42:1976 with SMTP id
 a640c23a62f3a-a7dc4e75471mr1322974266b.37.1723039718609; 
 Wed, 07 Aug 2024 07:08:38 -0700 (PDT)
Received: from mafrox3.fritz.box
 (p200300c8071991002a9d74ab3dca2577.dip0.t-ipconnect.de.
 [2003:c8:719:9100:2a9d:74ab:3dca:2577])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0ca0bsm641278566b.74.2024.08.07.07.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:08:38 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 3/3] i2c: imx_lpi2c: Support read transfers longer than 256
 bytes
Date: Wed,  7 Aug 2024 16:08:01 +0200
Message-Id: <20240807140801.1718483-3-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807140801.1718483-1-fedor.ross@ifm.com>
References: <20240807140801.1718483-1-fedor.ross@ifm.com>
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

Changes in v3:
- Add LPI2C_CHUNK_LEN_MIN
- Force macros LPI2C_CHUNK_DATA and LPI2C_CHUNK_LEN_MIN to be of
  unsigned type to satisfy type-check of min()/max()/clamp() macros.

Changes in v2:
- Add additional '---' below SoB line to separate Cc list. This way it
  does not get included in the commit message when the patch is applied.
- Prefix 'CHUNK_DATA' macro with 'LPI2C_' to namespace it.
- Do bit manipulation in writel() function directly and drop the 
  'val = assignment' .

 drivers/i2c/imx_lpi2c.c | 72 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index 54db6fa863f..4636da9f301 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -19,6 +19,9 @@
 #define LPI2C_NACK_TOUT_MS 1
 #define LPI2C_TIMEOUT_MS 100
 
+#define LPI2C_CHUNK_DATA	256U
+#define LPI2C_CHUNK_LEN_MIN	1U
+
 static int bus_i2c_init(struct udevice *bus);
 
 /* Weak linked function for overridden by some SoC power function */
@@ -118,8 +121,10 @@ static int bus_i2c_send(struct udevice *bus, u8 *txbuf, int len)
 
 static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
 {
+	struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
 	struct imx_lpi2c_bus *i2c_bus = dev_get_priv(bus);
 	struct imx_lpi2c_reg *regs = (struct imx_lpi2c_reg *)(i2c_bus->base);
+	unsigned int chunk_len, rx_remain, timeout;
 	lpi2c_status_t result = LPI2C_SUCESS;
 	u32 val;
 	ulong start_time = get_timer(0);
@@ -128,33 +133,50 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
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
+		chunk_len = clamp(rx_remain, LPI2C_CHUNK_LEN_MIN, LPI2C_CHUNK_DATA) - 1;
 
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

