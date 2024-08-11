Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A709DC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56CB3889C5;
	Sun, 11 Aug 2024 16:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VLdZ0CSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097E088977; Sun, 11 Aug 2024 16:51:34 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399A888580
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81f9339e537so146013339f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387888; x=1723992688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jYPTB2vDYK/nWgHS1qVx/X+0bA8cqYM6BobBArMKTE=;
 b=VLdZ0CSVYMoj0vTSHLHtkreHcbkhPh2DXWsCqOLGHctLHQ82RwCuZ4s4vOLX7Cg8TE
 sJeLm2du4mwa2+kYTEaN89HOhaFbRVmLAMNEqXa6wWxWlsID4QosA3y/U0pgRiQP+pRY
 YFIPPgTKmuWeJqgyDmLGciiy+BXnc8vAm4w/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387888; x=1723992688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jYPTB2vDYK/nWgHS1qVx/X+0bA8cqYM6BobBArMKTE=;
 b=tORsnATpL0+8o2jl1GKQoWhVhRld73fKLtjj61ryreeuU5tRUqVeCdEnmZ6026uYlo
 EIPH4VxX/gmARwXGrHw2Gk6hbY7wHEUM12r2+pd0Y3++ws56Z9DmzhI5HzhWXZrDnVia
 Ix9858XnNX8FS2o59SE8fXK1qKhr/0ABgi5mPII+h2v18BtcKf59Vdc0GhsO0I7zZDvW
 S0K5GXF3z4vYE3tBA3+Untup0/DlHSR8hwpQdni/iUhoCPpsnA6evhTshCvIfrDF40vj
 COh790YEUmeZXS+qF27Ed9pCo5UankybUJfySzyR8s+57M9ENN2mPmjMfqABnLEqVmK7
 QfCw==
X-Gm-Message-State: AOJu0YyrR4Wix1yATIvBPYxiJgK6XkB5YcgrJh8j/q2AXAQsMP4WtVd3
 HW8B7WxLadprUl0zUakDY68NSUsvhrD7Jv9v0iaQDtFf/fjz9c96hpsUZLC17VObiiMnw4/olus
 =
X-Google-Smtp-Source: AGHT+IFCIKAG6b5YY9Iohp8WJRbM9eeY9yfT/AaOuFoi4OMWxcvkCoeP/g5kA9jSn2IZynS2onCekA==
X-Received: by 2002:a05:6602:1647:b0:7f9:59af:c26b with SMTP id
 ca18e2360f4ac-8225eed34e3mr1140864539f.17.1723387887838; 
 Sun, 11 Aug 2024 07:51:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 18/18] i2c: Remove CFG_SYS_I2C_DIRECT_BUS
Date: Sun, 11 Aug 2024 08:50:47 -0600
Message-Id: <20240811145047.4189460-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

Changes in v2:
- Drop patch "pg-wcom: Drop CFG_SYS_I2C_MAX_HOPS"

 README                 |   7 +--
 drivers/i2c/i2c_core.c | 104 -----------------------------------------
 include/i2c.h          |  35 --------------
 3 files changed, 1 insertion(+), 145 deletions(-)

diff --git a/README b/README
index 4ffa4b8b68c..4be1e8c22a0 100644
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

