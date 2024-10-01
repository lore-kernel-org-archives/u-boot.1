Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9426ECEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95164891E2;
	Tue,  1 Oct 2024 15:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZGFifZ7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220DB891B8; Tue,  1 Oct 2024 14:25:58 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30CD1891C4
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so66816275e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785555; x=1728390355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EUOe1jN3Jqz/sD9v+5zEfAs0C1VPvPqu4ovtcvGVas4=;
 b=ZGFifZ7Bo+ndunXR6aarrdGfH7H31/eV3+dtkHXjyxZxq7kSyvJH+0uHRflciYhMdx
 OnMsx0a66qPpY+V2a1/ZtEkU0oIwGZWtg7ZYVFt5d9odxzHABlz8GTvP7UZWjcNsnnA6
 E2wBMwFFcy1nZywU2i7YLPqIFOhJ20KhZZtQCbsTU/t0hu/v2spD9UPxmWmdf7n9vM63
 i2JREAOMRZGqNP8KWC3MpfuuKla+WJNIdGwknDYQb2YmgqUh8i6nbcrrMlO3vJmYZ7ll
 aujaYR6ydc7/xIyKx3+nn4DY31WX943jHXMUgkPjcSd8cqhezu1uXZ1fTTqiLaP3ARqo
 1hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785555; x=1728390355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUOe1jN3Jqz/sD9v+5zEfAs0C1VPvPqu4ovtcvGVas4=;
 b=qBc9X1ANveYzDFKe8V7CpjNZinW6veTtdWtBhWuMU1kvTYdGB9xxJF4tE1faG61mXn
 0KJtOZGmog+9yOYfKASaaAZ5LJ5CQU46bgV1L/ilWTaML8Igw6Ri09+lWMeu6XzYwC2M
 CF2964bhUIZWjLFsmCBDXqwibAnKXn6OzNVUA9DU0qZ+Q2WuGYhS6nze43h7T4ZlXFdW
 TIBK0aN8j6d7O4W6k7txwpyo6sTXjupXw0c14YQ3zS/TTJdGkxm7CCH5ksgUsDt+nlmt
 03h854JpiNX94RUWVVErubr9fGjfjJ89hV+El5SlTE0/U160/UttVhqv3r2uPTjrlc39
 1OzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQLLGZ9jtUP01qY/4rBocQOWcfuRrRFdWK2zMgU/LkS7vgJ/sFUzFLlN8W0Gq97ozLH+4we30=@lists.denx.de
X-Gm-Message-State: AOJu0YwkIy8idhaMHIWHu3rPUToZBRSSzNPPSo+PkvtVKI7O/woabFBo
 8CKjLfx+AqVr+Ex813bSe4snPkOVWbqlhu3oKxE1t/32HnAC6xvV
X-Google-Smtp-Source: AGHT+IGNwwxO9BZae0RHpQxCfUd/98+tnQJynqAULu3DmgMw2jl2uPJvcuMsK9mL09iUvc64eyBuiA==
X-Received: by 2002:a05:600c:1914:b0:42e:94ff:7ac with SMTP id
 5b1f17b1804b1-42f5844c0cemr169057765e9.21.1727785554472; 
 Tue, 01 Oct 2024 05:25:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:54 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 05/11] led: implement LED activity API
Date: Tue,  1 Oct 2024 14:24:38 +0200
Message-ID: <20241001122511.8832-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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
 drivers/led/Kconfig      | 13 +++++++
 drivers/led/led-uclass.c | 81 +++++++++++++++++++++++++++++++++++++++-
 include/led.h            | 51 +++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 59b007a7ef5..c98cbf92fab 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -20,6 +20,19 @@ config LED_BOOT
 
 	  [1] dtschema/schemas/options/u-boot.yaml
 
+config LED_ACTIVITY
+	bool "Enable LED activity support"
+	help
+	  Enable LED activity support.
+
+	  LED activity is a specific LED assigned to signal activity operation
+	  like file trasnfer, flash write/erase...
+
+	  Defined in Device Tree /options/u-boot node. Refer here for the supported
+	  options [1].
+
+	  [1] dtschema/schemas/options/u-boot.yaml
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
 	depends on LED && ARCH_BMIPS
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 54113213dcf..05e09909b7d 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -163,6 +163,75 @@ int led_boot_blink(void)
 #endif
 #endif
 
+#ifdef CONFIG_LED_ACTIVITY
+static int led_activity_get(struct udevice **devp, int *period_ms)
+{
+	struct led_uc_priv *priv;
+	struct uclass *uc;
+	int ret;
+
+	ret = uclass_get(UCLASS_LED, &uc);
+	if (ret)
+		return ret;
+
+	priv = uclass_get_priv(uc);
+	if (!priv->activity_led_label)
+		return -ENOENT;
+
+	if (period_ms)
+		*period_ms = priv->activity_led_period;
+
+	return led_get_by_label(priv->activity_led_label, devp);
+}
+
+int led_activity_on(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = led_activity_get(&dev, NULL);
+	if (ret)
+		return ret;
+
+	return led_set_state(dev, LEDST_ON);
+}
+
+int led_activity_off(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = led_activity_get(&dev, NULL);
+	if (ret)
+		return ret;
+
+	return led_set_state(dev, LEDST_OFF);
+}
+
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+int led_activity_blink(void)
+{
+	struct udevice *dev;
+	int period_ms, ret;
+
+	ret = led_activity_get(&dev, &period_ms);
+	if (ret)
+		return ret;
+
+	ret = led_set_period(dev, period_ms);
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
@@ -227,13 +296,21 @@ static int led_post_probe(struct udevice *dev)
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
@@ -245,7 +322,7 @@ UCLASS_DRIVER(led) = {
 	.per_device_plat_auto	= sizeof(struct led_uc_plat),
 	.post_bind	= led_post_bind,
 	.post_probe	= led_post_probe,
-#ifdef CONFIG_LED_BOOT
+#if defined(CONFIG_LED_BOOT) || defined(CONFIG_LED_ACTIVITY)
 	.init		= led_init,
 	.priv_auto	= sizeof(struct led_uc_priv),
 #endif
diff --git a/include/led.h b/include/led.h
index 49ec2998a33..19d92d6441a 100644
--- a/include/led.h
+++ b/include/led.h
@@ -54,14 +54,21 @@ struct led_uc_plat {
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
 	const char *boot_led_label;
 	int boot_led_period;
 #endif
+#ifdef CONFIG_LED_ACTIVITY
+	const char *activity_led_label;
+	int activity_led_period;
+#endif
 };
 
 struct led_ops {
@@ -192,4 +199,48 @@ static inline int led_boot_blink(void)
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

