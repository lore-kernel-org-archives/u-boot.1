Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69117CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE208855C;
	Sat, 21 Sep 2024 04:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CV2a/L3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B27B487E30; Sat, 21 Sep 2024 00:51:49 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE6D78785E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so22602655e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872706; x=1727477506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tOKm760l90Mt+ORMaiEyashhKP3/BOnbIoQ5uWV6QQ8=;
 b=CV2a/L3SB2K45/RT3kSQnN+Pmcje4QnChC4VfDs1ze7jYMSZuPGK5xlvA0pB6NQ1tk
 ZsUQAXZJbCOMC/x2Q3shRtZV2eFE9wUBvwSU69N5ChnwuU9GlITnwBB9JJQuOTAQN8Do
 Y2Tv6t3iYB9u8XB1kiOgU4OUcr0MfqVBaJZAsYRUUEkLQz+dX+pSTx+lN7cP6oUSBVCN
 BPJlvHqmVr6dMk+60cr7HPCY7WnD4kvn9LuZjIarciep0UwMdlKlOMN9y3RqdXP8OLk7
 7+qclj3Ui7LPZW6vtfGegPvEnF9rfkKPXUb5oW6KNqiqxsgUcJW/6STcn9Ioj0ShLxKd
 FMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872706; x=1727477506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOKm760l90Mt+ORMaiEyashhKP3/BOnbIoQ5uWV6QQ8=;
 b=b/nGM6r2skFvp+53UXIDeNrXamu1ukHSmuKGqnPd6wz4iePUIhPTjJJw0YYwUqtnAB
 6qbxRzttsXz7Xe6aECtGdooNmkDnNz9g30G4EilswDzGAKBRROzMJ/9Oco6Li+09iFPQ
 Ycp0aMa1gbOqZBLMzUrrlU7vqLLy04c3Hhfvjfn51h+JUtXrr83/+/ifxNSkw/InCtWV
 x8lyUKhoQ2oiGyRoHz7HhSqYLhh/fADMwq4K1B91la4L3U938wTDnGQCBPATigqOlWyX
 GXBpcZ6ovRSyaahuwQMrmD0hbnMgfvgwA2GViPwZqe+z/KkCfmC2xqTWM6eBCkKVyPKC
 OVuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUarZl7NZ/ZbXdzUgFHMxD9Uo3+wMPXo9U/jYLMp3byzcfcdlPPBf7rxgybzlABoe9lM3JLsGA=@lists.denx.de
X-Gm-Message-State: AOJu0YxihRG7U4fIzO580Q6IqDmGemy9aC5k5gDzt7G5JFYz+WwrFxVm
 M45YrEta7zb33yAWiadjB6s1riMO9sVUPlYqDj2/yFezI1e0CkL2aEGpzT9z
X-Google-Smtp-Source: AGHT+IFLgYGmlhfGKfReIW+dChtHiOdC//V1a9T0TyDNmmuTWMnpgOHn0+zIGu+nN/Yc4vI/2OaL2A==
X-Received: by 2002:a05:600c:8715:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-42e7ab3eb57mr31610325e9.0.1726872706165; 
 Fri, 20 Sep 2024 15:51:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:51:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 03/11] led: implement LED boot API
Date: Sat, 21 Sep 2024 00:49:56 +0200
Message-ID: <20240920225101.2008-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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

Implement LED boot API to signal correct boot of the system.

led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
designated boot LED.

New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
This makes use of the /options/u-boot property "boot-led" to the
define the boot LED.
It's also introduced a new /options/u-boot property "boot-led-period"
to define the default period when the LED is set to blink mode.

If "boot-led-period" is not defined, the value of 250 (ms) is
used by default.

If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
led_boot_blink call will fallback to simple LED ON.

To cache the data we repurpose the now unused led_uc_priv for storage of
global LED uclass info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig      |   7 +++
 drivers/led/led-uclass.c | 100 +++++++++++++++++++++++++++++++++++++++
 include/led.h            |  56 +++++++++++++++++++++-
 3 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index bee74b25751..6149cfa02b8 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -9,6 +9,13 @@ config LED
 	  can provide access to board-specific LEDs. Use of the device tree
 	  for configuration is encouraged.
 
+config LED_BOOT
+	bool "Enable LED boot support"
+	help
+	  Enable LED boot support.
+
+	  LED boot is a specific LED assigned to signal boot operation status.
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
 	depends on LED && ARCH_BMIPS
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 199d68bc25a..c5b560982b0 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -94,17 +94,101 @@ int led_set_period(struct udevice *dev, int period_ms)
 	return -ENOSYS;
 }
 
+#ifdef CONFIG_LED_BOOT
+int led_boot_on(void)
+{
+	struct uclass *uc = uclass_find(UCLASS_LED);
+	struct led_uc_priv *priv;
+	struct udevice *dev;
+
+	if (!uc)
+		return -ENOENT;
+
+	priv = uclass_get_priv(uc);
+	if (!priv->boot_led_dev ||
+	    uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {
+		printf("Failed to get boot LED %s\n",
+		       priv->boot_led_label);
+		return -EINVAL;
+	}
+
+	return led_set_state(dev, LEDST_ON);
+}
+
+int led_boot_off(void)
+{
+	struct uclass *uc = uclass_find(UCLASS_LED);
+	struct led_uc_priv *priv;
+	struct udevice *dev;
+
+	if (!uc)
+		return -ENOENT;
+
+	priv = uclass_get_priv(uc);
+	if (!priv->boot_led_dev ||
+	    uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {
+		printf("Failed to get boot LED %s\n",
+		       priv->boot_led_label);
+		return -EINVAL;
+	}
+
+	return led_set_state(dev, LEDST_OFF);
+}
+
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+int led_boot_blink(void)
+{
+	struct uclass *uc = uclass_find(UCLASS_LED);
+	struct led_uc_priv *priv;
+	struct udevice *dev;
+	int ret;
+
+	if (!uc)
+		return -ENOENT;
+
+	priv = uclass_get_priv(uc);
+	if (!priv->boot_led_dev ||
+	    uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {
+		printf("Failed to get boot LED %s\n",
+		       priv->boot_led_label);
+		return -EINVAL;
+	}
+
+	ret = led_set_period(dev, priv->boot_led_period);
+	if (ret) {
+		if (ret != -ENOSYS)
+			return ret;
+
+		/* fallback to ON with no set_period and no SW_BLINK */
+		return led_set_state(dev, LEDST_ON);
+	}
+
+	return led_set_state(dev, LEDST_BLINK);
+}
+#endif
+#endif
+
 static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
 
+#ifdef CONFIG_LED_BOOT
+	struct led_uc_priv *priv = uclass_get_priv(dev->uclass);
+#endif
+
 	if (!uc_plat->label)
 		uc_plat->label = dev_read_string(dev, "label");
 
 	if (!uc_plat->label && !dev_read_string(dev, "compatible"))
 		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
 
+#ifdef CONFIG_LED_BOOT
+	/* check if we are binding boot LED and assign it */
+	if (!strcmp(priv->boot_led_label, uc_plat->label))
+		priv->boot_led_dev = dev;
+#endif
+
 	uc_plat->default_state = LEDST_COUNT;
 
 	default_state = dev_read_string(dev, "default-state");
@@ -158,10 +242,26 @@ static int led_post_probe(struct udevice *dev)
 	return ret;
 }
 
+#ifdef CONFIG_LED_BOOT
+static int led_init(struct uclass *uc)
+{
+	struct led_uc_priv *priv = uclass_get_priv(uc);
+
+	priv->boot_led_label = ofnode_options_read_str("boot-led");
+	priv->boot_led_period = ofnode_options_read_int("boot-led-period", 250);
+
+	return 0;
+}
+#endif
+
 UCLASS_DRIVER(led) = {
 	.id		= UCLASS_LED,
 	.name		= "led",
 	.per_device_plat_auto	= sizeof(struct led_uc_plat),
 	.post_bind	= led_post_bind,
 	.post_probe	= led_post_probe,
+#ifdef CONFIG_LED_BOOT
+	.init		= led_init,
+	.priv_auto	= sizeof(struct led_uc_priv),
+#endif
 };
diff --git a/include/led.h b/include/led.h
index 99f93c5ef86..ca495217777 100644
--- a/include/led.h
+++ b/include/led.h
@@ -9,6 +9,7 @@
 
 #include <stdbool.h>
 #include <cyclic.h>
+#include <dm/ofnode.h>
 
 struct udevice;
 
@@ -52,10 +53,16 @@ struct led_uc_plat {
 /**
  * struct led_uc_priv - Private data the uclass stores about each device
  *
- * @period_ms:	Flash period in milliseconds
+ * @boot_led_label:	Boot LED label
+ * @boot_led_dev:	Boot LED dev
+ * @boot_led_period:	Boot LED blink period
  */
 struct led_uc_priv {
-	int period_ms;
+#ifdef CONFIG_LED_BOOT
+	const char *boot_led_label;
+	struct udevice *boot_led_dev;
+	int boot_led_period;
+#endif
 };
 
 struct led_ops {
@@ -141,4 +148,49 @@ int led_sw_set_period(struct udevice *dev, int period_ms);
 bool led_sw_is_blinking(struct udevice *dev);
 bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
 
+#ifdef CONFIG_LED_BOOT
+
+/**
+ * led_boot_on() - turn ON the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int led_boot_on(void);
+
+/**
+ * led_boot_off() - turn OFF the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int led_boot_off(void);
+
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+/**
+ * led_boot_blink() - turn ON the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int led_boot_blink(void);
+
+#else
+/* If LED BLINK is not supported/enabled, fallback to LED ON */
+#define led_boot_blink led_boot_on
+#endif
+#else
+static inline int led_boot_on(void)
+{
+	return -ENOSYS;
+}
+
+static inline int led_boot_off(void)
+{
+	return -ENOSYS;
+}
+
+static inline int led_boot_blink(void)
+{
+	return -ENOSYS;
+}
+#endif
+
 #endif
-- 
2.45.2

