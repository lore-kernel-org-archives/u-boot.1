Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAF8CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E8A088703;
	Sat, 21 Sep 2024 04:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZHaKn6BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E4987E30; Sat, 21 Sep 2024 00:51:56 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76BD880A5
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-378f600e090so1490187f8f.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872713; x=1727477513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O+zHjwIvLfrTJj9POeemFP/0SMsykXjxdjynOoKsQL8=;
 b=ZHaKn6BRxgUPx/D2mVIARnp5ZqlXTRd29TkJ1flFotCbG3SADg9NGhAA6WS2KH6hA0
 xPqWqojixFAvNPm5RPjidjcWuTRoJLciYthtMoBPI2YmAZ7qcxjAGQW56H+6NubyLXcM
 ZIlhTCz1N7cB6Gp8VuQc+cgrijzSftxIkh3248rNW4Fz6y1jHp9AgiDNzOi/uhbiR1Ay
 ldBfLC0in69wWXIfpU1PAdZq15IanT5HvbfDSLFD6ZSjJb88pQLOHfbbCYUIzJJ2qzBk
 rod77tmB8j+6g/zQw9Cydliyla7acEbU1M6pvPpnN6gq6iEueoyIFd3A5eqh/44SOdy/
 NDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872713; x=1727477513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+zHjwIvLfrTJj9POeemFP/0SMsykXjxdjynOoKsQL8=;
 b=lU+3+4Apt3pVGW6UA9JEV8wii+sCFTI5Hg546cuSiGKGtd4+vc49u8sQJmfB7Oa7M3
 2Tn1YUafwkvGj1KixhURYheKFcVXQrT04KmYhg6d1Q3Sf9oq4onv34Gu+kuH03NFU6ak
 Bc9q3DVyyyqiuAPNsvGUFptJIdoQhF8/dxdU34o6ny+TV8U9z80DVOTTWDtEUdl/deov
 tZMakTkS0c0+FmajMk2Bp/w3jdjOxbST4Vf9qyg0ooHoDVDzpoM0wppIZmAzrHupRRN4
 a//QJIizjOTxMZuR04iMUskoybxS7JSAGuwPwNc+pX7znx6RopmgWJUIQF7OGwjSgd1Y
 2hVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt3LqSVlElK3qIRnLaiAfI4mF8+cdnHNMeK9vZzdpMaAtOoEtLrmbZAne5VDQPB38+2blOYpE=@lists.denx.de
X-Gm-Message-State: AOJu0YxmG5fPoPuFTRbr6fqv9h0qZuJxFKN89x2dda/LayYgct1NEesS
 zBUuxJ1weAxB6/WSfjvx3tb+k2o73UKqQwhy8xQ1Vl5iK9z1IbXL
X-Google-Smtp-Source: AGHT+IGQgXd106PdD75AJs6k1hs7QHKOKjaPx0QbjhnuvjIiGnv8Fm01dj74ownYhsfGzgq7tGgONQ==
X-Received: by 2002:adf:ae51:0:b0:374:c847:85e with SMTP id
 ffacd0b85a97d-37a431319e8mr1986777f8f.13.1726872713027; 
 Fri, 20 Sep 2024 15:51:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:51:51 -0700 (PDT)
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
Subject: [PATCH v4 05/11] led: implement LED activity API
Date: Sat, 21 Sep 2024 00:49:58 +0200
Message-ID: <20240920225101.2008-6-ansuelsmth@gmail.com>
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

Implement LED activity API similar to BOOT LED API.

Usual activity might be a file transfer with TFTP, a flash write...

User of this API will call led_activity_on/off/blink() to signal these
kind of activity.

New Kconfig is implemented similar to BOOT LED, LED_ACTIVITY to
enable support for it.

It's introduced a new /options/u-boot property "activity-led" and
"activity-led-period" to define the activity LED label and the
default period when the activity LED is set to blink mode.

If "activity-led-period" is not defined, the value of 250 (ms) is
used by default.

If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
led_boot_blink call will fallback to simple LED ON.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig      |  8 ++++
 drivers/led/led-uclass.c | 94 ++++++++++++++++++++++++++++++++++++++--
 include/led.h            | 52 ++++++++++++++++++++++
 3 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 6149cfa02b8..f0434f247a4 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -16,6 +16,14 @@ config LED_BOOT
 
 	  LED boot is a specific LED assigned to signal boot operation status.
 
+config LED_ACTIVITY
+	bool "Enable LED activity support"
+	help
+	  Enable LED activity support.
+
+	  LED activity is a specific LED assigned to signal activity operation
+	  like file trasnfer, flash write/erase...
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
 	depends on LED && ARCH_BMIPS
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index c5b560982b0..c87fc7540c7 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -168,12 +168,86 @@ int led_boot_blink(void)
 #endif
 #endif
 
+#ifdef CONFIG_LED_ACTIVITY
+int led_activity_on(void)
+{
+	struct uclass *uc = uclass_find(UCLASS_LED);
+	struct led_uc_priv *priv;
+	struct udevice *dev;
+
+	if (!uc)
+		return -ENOENT;
+
+	priv = uclass_get_priv(uc);
+	if (!priv->activity_led_dev ||
+	    uclass_get_device_tail(priv->activity_led_dev, 0, &dev)) {
+		printf("Failed to get activity LED %s\n",
+		       priv->activity_led_label);
+		return -EINVAL;
+	}
+
+	return led_set_state(dev, LEDST_ON);
+}
+
+int led_activity_off(void)
+{
+	struct uclass *uc = uclass_find(UCLASS_LED);
+	struct led_uc_priv *priv;
+	struct udevice *dev;
+
+	if (!uc)
+		return -ENOENT;
+
+	priv = uclass_get_priv(uc);
+	if (!priv->activity_led_dev ||
+	    uclass_get_device_tail(priv->activity_led_dev, 0, &dev)) {
+		printf("Failed to get activity LED %s\n",
+		       priv->activity_led_label);
+		return -EINVAL;
+	}
+
+	return led_set_state(dev, LEDST_OFF);
+}
+
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+int led_activity_blink(void)
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
+	if (!priv->activity_led_dev ||
+	    uclass_get_device_tail(priv->activity_led_dev, 0, &dev)) {
+		printf("Failed to get activity LED %s\n",
+		       priv->activity_led_label);
+		return -EINVAL;
+	}
+
+	ret = led_set_period(dev, priv->activity_led_period);
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
 
-#ifdef CONFIG_LED_BOOT
+#if defined(CONFIG_LED_BOOT) || defined(CONFIG_LED_ACTIVITY)
 	struct led_uc_priv *priv = uclass_get_priv(dev->uclass);
 #endif
 
@@ -189,6 +263,12 @@ static int led_post_bind(struct udevice *dev)
 		priv->boot_led_dev = dev;
 #endif
 
+#ifdef CONFIG_LED_ACTIVITY
+	/* check if we are binding activity LED and assign it */
+	if (!strcmp(priv->activity_led_label, uc_plat->label))
+		priv->activity_led_dev = dev;
+#endif
+
 	uc_plat->default_state = LEDST_COUNT;
 
 	default_state = dev_read_string(dev, "default-state");
@@ -242,13 +322,21 @@ static int led_post_probe(struct udevice *dev)
 	return ret;
 }
 
-#ifdef CONFIG_LED_BOOT
+#if defined(CONFIG_LED_BOOT) || defined(CONFIG_LED_ACTIVITY)
 static int led_init(struct uclass *uc)
 {
 	struct led_uc_priv *priv = uclass_get_priv(uc);
 
+#ifdef CONFIG_LED_BOOT
 	priv->boot_led_label = ofnode_options_read_str("boot-led");
 	priv->boot_led_period = ofnode_options_read_int("boot-led-period", 250);
+#endif
+
+#ifdef CONFIG_LED_ACTIVITY
+	priv->activity_led_label = ofnode_options_read_str("activity-led");
+	priv->activity_led_period = ofnode_options_read_int("activity-led-period",
+							    250);
+#endif
 
 	return 0;
 }
@@ -260,7 +348,7 @@ UCLASS_DRIVER(led) = {
 	.per_device_plat_auto	= sizeof(struct led_uc_plat),
 	.post_bind	= led_post_bind,
 	.post_probe	= led_post_probe,
-#ifdef CONFIG_LED_BOOT
+#if defined(CONFIG_LED_BOOT) || defined(CONFIG_LED_ACTIVITY)
 	.init		= led_init,
 	.priv_auto	= sizeof(struct led_uc_priv),
 #endif
diff --git a/include/led.h b/include/led.h
index ca495217777..bba8c0009ca 100644
--- a/include/led.h
+++ b/include/led.h
@@ -54,8 +54,11 @@ struct led_uc_plat {
  * struct led_uc_priv - Private data the uclass stores about each device
  *
  * @boot_led_label:	Boot LED label
+ * @activity_led_label:	Activity LED label
  * @boot_led_dev:	Boot LED dev
+ * @activity_led_dev:	Activity LED dev
  * @boot_led_period:	Boot LED blink period
+ * @activity_led_period: Activity LED blink period
  */
 struct led_uc_priv {
 #ifdef CONFIG_LED_BOOT
@@ -63,6 +66,11 @@ struct led_uc_priv {
 	struct udevice *boot_led_dev;
 	int boot_led_period;
 #endif
+#ifdef CONFIG_LED_ACTIVITY
+	const char *activity_led_label;
+	struct udevice *activity_led_dev;
+	int activity_led_period;
+#endif
 };
 
 struct led_ops {
@@ -193,4 +201,48 @@ static inline int led_boot_blink(void)
 }
 #endif
 
+#ifdef CONFIG_LED_ACTIVITY
+
+/**
+ * led_activity_on() - turn ON the designated LED for activity
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int led_activity_on(void);
+
+/**
+ * led_activity_off() - turn OFF the designated LED for activity
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int led_activity_off(void);
+
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+/**
+ * led_activity_blink() - turn ON the designated LED for activity
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int led_activity_blink(void);
+#else
+/* If LED BLINK is not supported/enabled, fallback to LED ON */
+#define led_activity_blink led_activity_on
+#endif
+#else
+static inline int led_activity_on(void)
+{
+	return -ENOSYS;
+}
+
+static inline int led_activity_off(void)
+{
+	return -ENOSYS;
+}
+
+static inline int led_activity_blink(void)
+{
+	return -ENOSYS;
+}
+#endif
+
 #endif
-- 
2.45.2

