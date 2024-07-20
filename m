Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E25C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F80188C7B;
	Sat, 20 Jul 2024 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fFBr3lTu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lSb8Izio";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4075888A5; Sat, 20 Jul 2024 14:43:48 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4882C88C4A
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5nY0W1Cz9sWs;
 Sat, 20 Jul 2024 14:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5dJuF5oBDa5ksbWs5RZH7kEkCtl03ItiJapUNoI9Ug=;
 b=fFBr3lTu5CLPJsNAQ4YtlfLTX3Po00jttDyoUwGJoxvZJmPGRe9thIUy48xM03Y4e47xA9
 tOG3UcfM+Xk3Fq0Pr+M1Ja0A7bndIKxg4/D6KIOxUNZ/m0Rbi0KZQ2toiueYiIKNaEGn3q
 X2jQ4fDc7rEDlUdzp0xzwhkxx8xVWvOiHQhrgn3lHOkXSDbRyDCeHwnla7WjczlYA7GZnd
 DQp0lTJtKobRkM4F+I9tW3N629egsLPtrTj16iZp1NA1pC2d6XfjJmr7OT2GcdXfrPFgFQ
 fF4Zm2W72HxTPUWeVXOVjMyaTNv2j8Fwlp3+Xkk/U0Oyq3PElBwGZRhVTwdPSQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5dJuF5oBDa5ksbWs5RZH7kEkCtl03ItiJapUNoI9Ug=;
 b=lSb8Izios0Tb+TPNYshmdmlXQkXp952mu7urUyZBREm6bxy0dgBQwylESzD6U8xVccEXBP
 yhSW5O48ObOaVoaUEVyjvoDkVKyz1K5BEqFQYEveeDkxzw5AkCoOkA7oyFc/hWTxJyPMng
 Cc221yU4X8hDMxp9tgbSR5O329qVrMr9M/nju9CwU9jJ9nuIZTtDyIHxGnMbyrtEbgfDvJ
 L8T+ClU2FnPWxGXvBofLn061PcQJaXvILgVpvOXfbtZF9/nCxd8R0bwu6gg+cepORKnxQ3
 2/o5ikI+bYlwXYJh2AsirR4Zr3s7VlVz8Z5jfzKgr50SHUAJHoB42kj5m8F64A==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 14/40] drivers: i2c: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:39 +0200
Message-ID: <20240720124239.7553-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: af2c868f3c8ce61f7a0
X-MBO-RS-META: 5b9hqo5aodoncjy149o544wxsx6mynhn
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/i2c/exynos_hs_i2c.c      | 1 -
 drivers/i2c/i2c-uniphier.c       | 1 -
 drivers/i2c/imx_lpi2c.c          | 1 -
 drivers/i2c/muxes/i2c-mux-gpio.c | 1 -
 drivers/i2c/mxc_i2c.c            | 1 -
 drivers/i2c/rcar_i2c.c           | 1 -
 drivers/i2c/soft_i2c.c           | 1 -
 7 files changed, 7 deletions(-)

diff --git a/drivers/i2c/exynos_hs_i2c.c b/drivers/i2c/exynos_hs_i2c.c
index 9a364fdae37..2ab0bae4499 100644
--- a/drivers/i2c/exynos_hs_i2c.c
+++ b/drivers/i2c/exynos_hs_i2c.c
@@ -76,7 +76,6 @@ DECLARE_GLOBAL_DATA_PTR;
 				 HSI2C_TRANS_ABORT)
 #define HSI2C_TRANS_FINISHED_MASK (HSI2C_TRANS_ERROR_MASK | HSI2C_TRANS_SUCCESS)
 
-
 /* I2C_FIFO_STAT Register bits */
 #define HSI2C_RX_FIFO_EMPTY		(1u << 24)
 #define HSI2C_RX_FIFO_FULL		(1u << 23)
diff --git a/drivers/i2c/i2c-uniphier.c b/drivers/i2c/i2c-uniphier.c
index 6eafbeeef4e..cc22c075ab1 100644
--- a/drivers/i2c/i2c-uniphier.c
+++ b/drivers/i2c/i2c-uniphier.c
@@ -198,7 +198,6 @@ static int uniphier_i2c_set_bus_speed(struct udevice *bus, unsigned int speed)
 	return 0;
 }
 
-
 static const struct dm_i2c_ops uniphier_i2c_ops = {
 	.xfer = uniphier_i2c_xfer,
 	.set_bus_speed = uniphier_i2c_set_bus_speed,
diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index 6c0d8eb5f4f..a1be841b119 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -263,7 +263,6 @@ static int bus_i2c_write(struct udevice *bus, u32 chip, u8 *buf, int len)
 	return result;
 }
 
-
 u32 __weak imx_get_i2cclk(u32 i2c_num)
 {
 	return 0;
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index f212bd1f983..0a2800ebd7a 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -38,7 +38,6 @@ struct i2c_mux_gpio_priv {
 	u32 idle;
 };
 
-
 static int i2c_mux_gpio_select(struct udevice *dev, struct udevice *bus,
 			       uint channel)
 {
diff --git a/drivers/i2c/mxc_i2c.c b/drivers/i2c/mxc_i2c.c
index 0acdaf7e743..84c0050eac0 100644
--- a/drivers/i2c/mxc_i2c.c
+++ b/drivers/i2c/mxc_i2c.c
@@ -512,7 +512,6 @@ static int i2c_init_transfer(struct mxc_i2c_bus *i2c_bus, u8 chip,
 	return ret;
 }
 
-
 static int i2c_write_data(struct mxc_i2c_bus *i2c_bus, u8 chip, const u8 *buf,
 			  int len)
 {
diff --git a/drivers/i2c/rcar_i2c.c b/drivers/i2c/rcar_i2c.c
index f0f9b2afacf..3bd5108fd23 100644
--- a/drivers/i2c/rcar_i2c.c
+++ b/drivers/i2c/rcar_i2c.c
@@ -54,7 +54,6 @@
 #define RCAR_I2C_ICFBSCR		0x38
 #define RCAR_I2C_ICFBSCR_TCYC17		0x0f /* 17*Tcyc */
 
-
 enum rcar_i2c_type {
 	RCAR_I2C_TYPE_GEN2,
 	RCAR_I2C_TYPE_GEN3,
diff --git a/drivers/i2c/soft_i2c.c b/drivers/i2c/soft_i2c.c
index 1f2afc65e8b..89ddf821063 100644
--- a/drivers/i2c/soft_i2c.c
+++ b/drivers/i2c/soft_i2c.c
@@ -96,7 +96,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define I2C_ACK		0		/* PD_SDA level to ack a byte */
 #define I2C_NOACK	1		/* PD_SDA level to noack a byte */
 
-
 #ifdef DEBUG_I2C
 #define PRINTD(fmt,args...)	do {	\
 		printf (fmt ,##args);	\
-- 
2.43.0

