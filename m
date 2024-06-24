Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C79FC30653
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C10C988418;
	Mon, 24 Jun 2024 23:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K4Ejwluo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93DCD87B1A; Mon, 24 Jun 2024 23:46:38 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9083088119
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so587060166b.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265596; x=1719870396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lwn27umt7Ia1pnQO+R9k1S/p3TzisyCSqEQ9iSKDuUo=;
 b=K4EjwluoR4NBy70wvAHQLPZ8Bh6oMhcYnxZrzUj4HpPyWRenXJLTLYz/HRvKJdGS4C
 v3JSctt0Tunk02e5vtMFShtL4NRnq6lv+KwnBJ+8FHwN85t9HQ8aWpzc0fR8QHUw1nOq
 HCgEgIF6h68U/pmIGPxcUQd4PvOOC5b2Og9+uflJcOER4dvUp3aGCk6RXwZqoni5W9U9
 MCkdxbDW486w3cxnVP7pCXxvG2Koz8smWGs3nhHRnVPYAbIJzTyBDDy6zU34/9jLWbOl
 KYI6rzqTxBaLt/3TSsvV/JTfbqHOeaXfZ9MkbjGsdSrLFzjUdVNv02gcCmAYTEPx9rt3
 ve+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265596; x=1719870396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lwn27umt7Ia1pnQO+R9k1S/p3TzisyCSqEQ9iSKDuUo=;
 b=VzyZbbf7K15jzMc7gHdh+8evqC8K8poNasAis3Hs47fLIkP4vss6fNKYmwBSz5JyC4
 CPvIf31ZWfIOiZmK47MaiOTFqiwKl1OEQ1ZTeRvlWI1W9uckdfUrFn4swuj+gMWf4dlC
 GyUJYVZujtX3T5w0ezfjSwAJxnQpmiLqkgLx4JgtMYz+PD/X45t4R9J1CrOp+47Mqsvl
 ChtQGcqQv9hY/xa+TntlSjUWw1XLaFYdZIhL4+06TPl1fm4+6qkd/aP5eQA4YUERMf73
 yE2o/rFR862GRtacziww+oqVmk1h9jVtUcBgbJdzR3YmRW5/+lTm0Tae+RkXS5VIbOxC
 dm5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0ODHKiWTsxQTd1uCh6zXOxjOynIswq+wHdYcwkesUl8jhPWUvyKLRX7qeyziSPpSad4GHt2u96+JBCpUTFPsYuo22YA==
X-Gm-Message-State: AOJu0YwH44Ps+xFKkYWvYp+4qVtDemPJywNdjLxNYgrGNSb6VuPdcEsZ
 ozSuKG4Ms3feEb33SoT626CKS+oYsCuANbYDTNzKX/93G1zeA+Qu
X-Google-Smtp-Source: AGHT+IHliy9X/co+Ru+cZp1q5pqHv+Z7aSFf42QJT9y45ztOpZouKHtArtmgo/fNKr1LDWMx4S6KLg==
X-Received: by 2002:a50:bac3:0:b0:57c:7471:a0dd with SMTP id
 4fb4d7f45d1cf-57d4a2815a6mr5274051a12.12.1719265595460; 
 Mon, 24 Jun 2024 14:46:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 1/9] led: led_gpio: add support for SW Blink
Date: Mon, 24 Jun 2024 23:46:11 +0200
Message-ID: <20240624214626.24336-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624214626.24336-1-ansuelsmth@gmail.com>
References: <20240624214626.24336-1-ansuelsmth@gmail.com>
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

Add support for GPIO-connected LEDs to make use of Cyclic API to
simulate Blink by software.

A new Kconfig is introduced to enable this, CONFIG_LED_GPIO_SW_BLINK.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig    |  9 +++++++
 drivers/led/led_gpio.c | 56 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 9837960198d..13d6eb40cea 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -91,6 +91,15 @@ config LED_GPIO
 	  The GPIO driver must used driver model. LEDs are configured using
 	  the device tree.
 
+config LED_GPIO_SW_BLINK
+	bool "LED support for GPIO software blink"
+	depends on LED_GPIO
+	select CYCLIC
+	select LED_BLINK
+	help
+	  Enable support for GPIO-connected LEDs to make use of Cyclic API
+	  to simulate LED blink by software.
+
 config SPL_LED_GPIO
 	bool "LED support for GPIO-connected LEDs in SPL"
         depends on SPL_LED && SPL_DM_GPIO
diff --git a/drivers/led/led_gpio.c b/drivers/led/led_gpio.c
index ce22fb49f2a..20a6c149e4a 100644
--- a/drivers/led/led_gpio.c
+++ b/drivers/led/led_gpio.c
@@ -4,6 +4,7 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <cyclic.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
@@ -13,13 +14,60 @@
 
 struct led_gpio_priv {
 	struct gpio_desc gpio;
+#ifdef CONFIG_LED_GPIO_SW_BLINK
+	bool sw_blink;
+	struct cyclic_info cyclic;
+#endif
 };
 
+#ifdef CONFIG_LED_GPIO_SW_BLINK
+static void gpio_led_toggle(struct cyclic_info *ctx)
+{
+	struct led_gpio_priv *priv = container_of(ctx, struct led_gpio_priv, cyclic);
+	struct gpio_desc *gpio = &priv->gpio;
+	int state;
+
+	state = dm_gpio_get_value(gpio);
+	if (state < 0) {
+		printf("Error getting value for GPIO %d\n",
+		       gpio->offset);
+		return;
+	}
+
+	dm_gpio_set_value(gpio, !state);
+}
+
+static int gpio_led_set_period(struct udevice *dev, int period_ms)
+{
+	struct led_gpio_priv *priv = dev_get_priv(dev);
+	char cyclic_name[16];
+
+	if (priv->sw_blink)
+		cyclic_unregister(&priv->cyclic);
+
+	snprintf(cyclic_name, sizeof(cyclic_name),
+		 "gpio_cyclic%u", priv->gpio.offset);
+	cyclic_register(&priv->cyclic, gpio_led_toggle,
+			period_ms * 500, cyclic_name);
+
+	/* Init the LED on */
+	dm_gpio_set_value(&priv->gpio, LEDST_ON);
+
+	priv->sw_blink = true;
+	return 0;
+}
+#endif
+
 static int gpio_led_set_state(struct udevice *dev, enum led_state_t state)
 {
 	struct led_gpio_priv *priv = dev_get_priv(dev);
 	int ret;
 
+#ifdef CONFIG_LED_GPIO_SW_BLINK
+	if (priv->sw_blink)
+		cyclic_unregister(&priv->cyclic);
+#endif
+
 	if (!dm_gpio_is_valid(&priv->gpio))
 		return -EREMOTEIO;
 	switch (state) {
@@ -50,6 +98,11 @@ static enum led_state_t gpio_led_get_state(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+#ifdef CONFIG_LED_GPIO_SW_BLINK
+	if (priv->sw_blink)
+		return LEDST_BLINK;
+#endif
+
 	return ret ? LEDST_ON : LEDST_OFF;
 }
 
@@ -84,6 +137,9 @@ static int led_gpio_bind(struct udevice *parent)
 static const struct led_ops gpio_led_ops = {
 	.set_state	= gpio_led_set_state,
 	.get_state	= gpio_led_get_state,
+#ifdef CONFIG_LED_GPIO_SW_BLINK
+	.set_period	= gpio_led_set_period,
+#endif
 };
 
 U_BOOT_DRIVER(led_gpio) = {
-- 
2.45.1

