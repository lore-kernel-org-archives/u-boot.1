Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ABFC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774BC88B83;
	Thu, 18 Jul 2024 19:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VjezCYNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FC488B4C; Thu, 18 Jul 2024 19:37:04 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A69688B3C
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so15570511fa.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324211; x=1721929011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUUm/STYO5VBjXLu0pO4WLA+xPwtQwEfQiZ17q2qcgI=;
 b=VjezCYNVV/YkDonHP23AUnDm/AJiK+9zocF0TyaKUuYFt5XEIcPXqt4VER+Qg2oRgD
 z4v7d6RKXm/Nqq8V7wEhKIwn5GHt1fDPSIELgbFoTEPxpNNxNxjfPL8aQoVNxdUyxF35
 czOjIfPrxWudvutjrFNv54NBf1YiwRnJXlOa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324211; x=1721929011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUUm/STYO5VBjXLu0pO4WLA+xPwtQwEfQiZ17q2qcgI=;
 b=jRerZXzxB4HJbHGaJftfIwCgjdpaEoveyLcJb38LCe9qqyceXLV2eaqvsoVx7zwwyL
 lEqsftRxOBMkyamocaon+tkiBQnEwstrgWUW+gbSnRo0eRRSv5lBdJQWunAJ6gg75F1b
 V7b5zkMMNJPm9FmdKIF0ReO1M/1LjwOdtmu3KUTV2T8fQqXwo3ZQftBY1bapuaULfGy/
 wwjcq2xC7QfdmIwUx/4x2+Tz9KZfFMwlVtlopZD4CRFiOQupKsaH38Zofnrv8PyON1rB
 eoqhS2RqQceDyDTnPBZ3bgULLpOBS8/oMJSZ0zB5IqySLl3f4kCGxwWJNa/F9WL0jD2x
 +3bQ==
X-Gm-Message-State: AOJu0YyvvrJXpz+caXVJRnnUfYjHTwClSq9l9p5vso0/zcJ8pE2eyxGv
 b5lgxxOWeOc2mN1Ck7Rxr/Y+aV+pmyzdDeulZRitzc3KdR18LyNrvwI5uOg/H20viqebafvfLv4
 =
X-Google-Smtp-Source: AGHT+IGaonxc4D9b9eLrTkz/ywDP/xpVeNZc5yWBpeYxe8HHqsSir/jIabKuWTHpeympmxR2LcCVDQ==
X-Received: by 2002:a2e:8198:0:b0:2ec:541b:4b4e with SMTP id
 38308e7fff4ca-2ef05d2f545mr21287401fa.32.1721324211570; 
 Thu, 18 Jul 2024 10:36:51 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philip Richard Oberfichtner <pro@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 20/20] i2c: Remove CFG_SYS_I2C_DIRECT_BUS
Date: Thu, 18 Jul 2024 18:36:11 +0100
Message-Id: <20240718173611.4014274-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

Now that this is always 1, remove it and the associated dead code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 README                 |   7 +--
 drivers/i2c/i2c_core.c | 104 -----------------------------------------
 include/i2c.h          |  35 --------------
 3 files changed, 1 insertion(+), 145 deletions(-)

diff --git a/README b/README
index 44dafa3be98..461c5d4d0e3 100644
--- a/README
+++ b/README
@@ -771,13 +771,8 @@ The following options need to be configured:
 		CFG_SYS_NUM_I2C_BUSES
 		Hold the number of i2c buses you want to use.
 
-		CFG_SYS_I2C_DIRECT_BUS
-		define this, if you don't use i2c muxes on your hardware.
-
 		CFG_SYS_I2C_BUSES
-		hold a list of buses you want to use, only used if
-		CFG_SYS_I2C_DIRECT_BUS is not defined, for example
-		a board with CFG_SYS_NUM_I2C_BUSES = 9:
+		hold a list of buses you want to use
 
 		 CFG_SYS_I2C_BUSES	{{0, {I2C_NULL_HOP}}, \
 					{0, {{I2C_MUX_PCA9547, 0x70, 1}}}, \
diff --git a/drivers/i2c/i2c_core.c b/drivers/i2c/i2c_core.c
index f371d952af5..cccd45027db 100644
--- a/drivers/i2c/i2c_core.c
+++ b/drivers/i2c/i2c_core.c
@@ -33,100 +33,8 @@ struct i2c_adapter *i2c_get_adapter(int index)
 	return i2c_adap_p;
 }
 
-#if !defined(CFG_SYS_I2C_DIRECT_BUS)
-struct i2c_bus_hose i2c_bus[CFG_SYS_NUM_I2C_BUSES] =
-			CFG_SYS_I2C_BUSES;
-#endif
-
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifndef CFG_SYS_I2C_DIRECT_BUS
-/*
- * i2c_mux_set()
- * -------------
- *
- * This turns on the given channel on I2C multiplexer chip connected to
- * a given I2C adapter directly or via other multiplexers. In the latter
- * case the entire multiplexer chain must be initialized first starting
- * with the one connected directly to the adapter. When disabling a chain
- * muxes must be programmed in reverse order, starting with the one
- * farthest from the adapter.
- *
- * mux_id is the multiplexer chip type from defined in i2c.h. So far only
- * NXP (Philips) PCA954x multiplexers are supported. Switches are NOT
- * supported (anybody uses them?)
- */
-
-static int i2c_mux_set(struct i2c_adapter *adap, int mux_id, int chip,
-			int channel)
-{
-	uint8_t	buf;
-	int ret;
-
-	/* channel < 0 - turn off the mux */
-	if (channel < 0) {
-		buf = 0;
-		ret = adap->write(adap, chip, 0, 0, &buf, 1);
-		if (ret)
-			printf("%s: Could not turn off the mux.\n", __func__);
-		return ret;
-	}
-
-	switch (mux_id) {
-	case I2C_MUX_PCA9540_ID:
-	case I2C_MUX_PCA9542_ID:
-		if (channel > 1)
-			return -1;
-		buf = (uint8_t)((channel & 0x01) | (1 << 2));
-		break;
-	case I2C_MUX_PCA9544_ID:
-		if (channel > 3)
-			return -1;
-		buf = (uint8_t)((channel & 0x03) | (1 << 2));
-		break;
-	case I2C_MUX_PCA9547_ID:
-		if (channel > 7)
-			return -1;
-		buf = (uint8_t)((channel & 0x07) | (1 << 3));
-		break;
-	case I2C_MUX_PCA9548_ID:
-		if (channel > 7)
-			return -1;
-		buf = (uint8_t)(0x01 << channel);
-		break;
-	default:
-		printf("%s: wrong mux id: %d\n", __func__, mux_id);
-		return -1;
-	}
-
-	ret = adap->write(adap, chip, 0, 0, &buf, 1);
-	if (ret)
-		printf("%s: could not set mux: id: %d chip: %x channel: %d\n",
-		       __func__, mux_id, chip, channel);
-	return ret;
-}
-
-static int i2c_mux_set_all(void)
-{
-	struct i2c_bus_hose *i2c_bus_tmp = &i2c_bus[I2C_BUS];
-	int i;
-
-	return 0;
-}
-
-static int i2c_mux_disconnect_all(void)
-{
-	struct	i2c_bus_hose *i2c_bus_tmp = &i2c_bus[I2C_BUS];
-	int	i;
-	uint8_t	buf = 0;
-
-	if (I2C_ADAP->init_done == 0)
-		return 0;
-
-	return 0;
-}
-#endif
-
 /*
  * i2c_init_bus():
  * ---------------
@@ -200,11 +108,6 @@ int i2c_set_bus_num(unsigned int bus)
 	if ((bus == I2C_BUS) && (I2C_ADAP->init_done > 0))
 		return 0;
 
-#ifndef CFG_SYS_I2C_DIRECT_BUS
-	if (bus >= CFG_SYS_NUM_I2C_BUSES)
-		return -1;
-#endif
-
 	max = ll_entry_count(struct i2c_adapter, i2c);
 	if (I2C_ADAPTER(bus) >= max) {
 		printf("Error, wrong i2c adapter %d max %d possible\n",
@@ -212,17 +115,10 @@ int i2c_set_bus_num(unsigned int bus)
 		return -2;
 	}
 
-#ifndef CFG_SYS_I2C_DIRECT_BUS
-	i2c_mux_disconnect_all();
-#endif
-
 	gd->cur_i2c_bus = bus;
 	if (I2C_ADAP->init_done == 0)
 		i2c_init_bus(bus, I2C_ADAP->speed, I2C_ADAP->slaveaddr);
 
-#ifndef CFG_SYS_I2C_DIRECT_BUS
-	i2c_mux_set_all();
-#endif
 	return 0;
 }
 
diff --git a/include/i2c.h b/include/i2c.h
index 180b71f1451..91917f54be9 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -646,7 +646,6 @@ void i2c_early_init_f(void);
 #define I2C_RXTX_LEN	128	/* maximum tx/rx buffer length */
 
 /* no muxes used bus = i2c adapters */
-#define CFG_SYS_I2C_DIRECT_BUS	1
 #define CFG_SYS_NUM_I2C_BUSES	ll_entry_count(struct i2c_adapter, i2c)
 
 struct i2c_adapter {
@@ -692,47 +691,13 @@ struct i2c_adapter {
 
 struct i2c_adapter *i2c_get_adapter(int index);
 
-#ifndef CFG_SYS_I2C_DIRECT_BUS
-struct i2c_mux {
-	int	id;
-	char	name[16];
-};
-
-struct i2c_next_hop {
-	struct i2c_mux		mux;
-	uint8_t		chip;
-	uint8_t		channel;
-};
-
-struct i2c_bus_hose {
-	int	adapter;
-};
-#define I2C_NULL_HOP	{{-1, ""}, 0, 0}
-extern struct i2c_bus_hose	i2c_bus[];
-
-#define I2C_ADAPTER(bus)	i2c_bus[bus].adapter
-#else
 #define I2C_ADAPTER(bus)	bus
-#endif
 #define	I2C_BUS			gd->cur_i2c_bus
 
 #define	I2C_ADAP_NR(bus)	i2c_get_adapter(I2C_ADAPTER(bus))
 #define	I2C_ADAP		I2C_ADAP_NR(gd->cur_i2c_bus)
 #define I2C_ADAP_HWNR		(I2C_ADAP->hwadapnr)
 
-#ifndef CFG_SYS_I2C_DIRECT_BUS
-#define I2C_MUX_PCA9540_ID	1
-#define I2C_MUX_PCA9540		{I2C_MUX_PCA9540_ID, "PCA9540B"}
-#define I2C_MUX_PCA9542_ID	2
-#define I2C_MUX_PCA9542		{I2C_MUX_PCA9542_ID, "PCA9542A"}
-#define I2C_MUX_PCA9544_ID	3
-#define I2C_MUX_PCA9544		{I2C_MUX_PCA9544_ID, "PCA9544A"}
-#define I2C_MUX_PCA9547_ID	4
-#define I2C_MUX_PCA9547		{I2C_MUX_PCA9547_ID, "PCA9547A"}
-#define I2C_MUX_PCA9548_ID	5
-#define I2C_MUX_PCA9548		{I2C_MUX_PCA9548_ID, "PCA9548"}
-#endif
-
 #ifndef I2C_SOFT_DECLARATIONS
 # if (defined(CONFIG_AT91RM9200) || \
 	defined(CONFIG_AT91SAM9260) ||  defined(CONFIG_AT91SAM9261) || \
-- 
2.34.1

