Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4F9CEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876AC891BF;
	Tue,  1 Oct 2024 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BatZFZRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F41891AC; Tue,  1 Oct 2024 14:25:53 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58FFD891C1
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cd5016d98so2770787f8f.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785551; x=1728390351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y6cQyvcZmw0nUXVw+dPyVauPKz3tVxiF2JmRIS+cobk=;
 b=BatZFZRYZOKSVTXfv0+qoDTQLZkdEa+MDouEJnCoJNcrX1xK2jRPKscPNhA6j94dSF
 dCxSgDFsqafijgXRusPMT+oIRUKKK7I3CWfTP6iKLe+b+zlxjc8SX/8ftQRYSJmSdbHl
 SxkthPh5+gtWEZxVW3ZhkHz8sE6mSgP5oDDZJydGoZ8iVFuSO1C/JEXnREukN3/HHiWz
 eVqiRR6n9Dqj6jxfcZSy3NrvG7zf8eVnQrjt2u9grMz7qZADmt7H5iPR6Y7NuK2kccDt
 fZfL6cCh4n4ebGMjRYEJxvgrn2loEN5ykVsTuRKutU/mElas+J+Ea9VhXjORI1nQJtIR
 NEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785551; x=1728390351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6cQyvcZmw0nUXVw+dPyVauPKz3tVxiF2JmRIS+cobk=;
 b=ihp3EZ8DLe6qTtbjj3b6Dvlyqkb51a2rCTMuf42M90wlu/AGi4De/k659b6KzEjGu/
 y84ix9dym7nv3MC//HowyPC5EKkDiCdHcB2iIWg3NXmTiSKbhOg7vRb5tSMaTeFMDCMV
 LyRp2YvzM/0OoRxz/FeUcIDQLfj4pqrtVwPbkwU1VUKFR0XxOQQHU67C+gLm5tIihovr
 BM2++zhO7IjWAJ6pSz82k2eXMP6dEq/ILpmzcCz2clb4U9uf8CRJXEO1RVGcbWHAe5Ek
 yvl1LY6wPIdVuocMMFCnj4cqPdNGcCbBP+uxAc4VTSG5dJNHnLoiwJ0b8XxZT2D4j6Cb
 nOyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2RdJ0m8cm+csu6IOa+UBARo9x16GD3N4wWqvFHHPKE8+TbcDNtD3uTCTGLNkbY5L/li3PuO0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa8QNngU7zMTh2IA5MoTyIHdmzEL6/RIDoDqI2VIlq6SWrVHxg
 EJFQetu/qzu+ADYbmh4Ia5fRhN49qguAhTSP8VtF0+w/4+/HBhRp
X-Google-Smtp-Source: AGHT+IFOQqWi/L7dprdL6ekzIl1XhCl+H8bO1mGHcehbAXBtTfsuXOXESuvSlXGgrGI3LQ0MAUbMOg==
X-Received: by 2002:adf:e6c7:0:b0:374:c7a3:3349 with SMTP id
 ffacd0b85a97d-37cd5b292c9mr8866390f8f.51.1727785550598; 
 Tue, 01 Oct 2024 05:25:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:50 -0700 (PDT)
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
Subject: [PATCH v5 03/11] led: implement LED boot API
Date: Tue,  1 Oct 2024 14:24:36 +0200
Message-ID: <20241001122511.8832-4-ansuelsmth@gmail.com>
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
 drivers/led/Kconfig      | 11 ++++++
 drivers/led/led-uclass.c | 85 ++++++++++++++++++++++++++++++++++++++++
 include/led.h            | 55 +++++++++++++++++++++++++-
 3 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index bee74b25751..59b007a7ef5 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -9,6 +9,17 @@ config LED
 	  can provide access to board-specific LEDs. Use of the device tree
 	  for configuration is encouraged.
 
+config LED_BOOT
+	bool "Enable LED boot support"
+	help
+	  Enable LED boot support.
+
+	  LED boot is a specific LED assigned to signal boot operation status.
+	  Defined in Device Tree /options/u-boot node. Refer here for the supported
+	  options [1].
+
+	  [1] dtschema/schemas/options/u-boot.yaml
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
 	depends on LED && ARCH_BMIPS
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 199d68bc25a..54113213dcf 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -94,6 +94,75 @@ int led_set_period(struct udevice *dev, int period_ms)
 	return -ENOSYS;
 }
 
+#ifdef CONFIG_LED_BOOT
+static int led_boot_get(struct udevice **devp, int *period_ms)
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
+	if (!priv->boot_led_label)
+		return -ENOENT;
+
+	if (period_ms)
+		*period_ms = priv->boot_led_period;
+
+	return led_get_by_label(priv->boot_led_label, devp);
+}
+
+int led_boot_on(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = led_boot_get(&dev, NULL);
+	if (ret)
+		return ret;
+
+	return led_set_state(dev, LEDST_ON);
+}
+
+int led_boot_off(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = led_boot_get(&dev, NULL);
+	if (ret)
+		return ret;
+
+	return led_set_state(dev, LEDST_OFF);
+}
+
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+int led_boot_blink(void)
+{
+	struct udevice *dev;
+	int period_ms, ret;
+
+	ret = led_boot_get(&dev, &period_ms);
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
@@ -158,10 +227,26 @@ static int led_post_probe(struct udevice *dev)
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
index 99f93c5ef86..49ec2998a33 100644
--- a/include/led.h
+++ b/include/led.h
@@ -9,6 +9,7 @@
 
 #include <stdbool.h>
 #include <cyclic.h>
+#include <dm/ofnode.h>
 
 struct udevice;
 
@@ -52,10 +53,15 @@ struct led_uc_plat {
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
+	int boot_led_period;
+#endif
 };
 
 struct led_ops {
@@ -141,4 +147,49 @@ int led_sw_set_period(struct udevice *dev, int period_ms);
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

