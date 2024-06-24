Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B409AC30653
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4FC884E5;
	Mon, 24 Jun 2024 23:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="anRiUYSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6CC884E5; Mon, 24 Jun 2024 23:46:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057A0883CD
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00b97so4600341a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265598; x=1719870398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NZ4kWG3twGxCVLj6uKain/qVjrWftO9nQKi4a5+SpF4=;
 b=anRiUYSFAPzHjPxzbY0xWziX9h1OMOiMqG/CXiSyapdbrqTBCxKT3HLxmPh/wXvBR5
 DniLOZOKAb5MsQXEYZ92PysvPPf54d0BBfVdbswmU7lH9OQUEuj7UEYe9kUdd/eu+MWc
 vcqsHkSJOpeANUS9gllhb6RE5hM7oHfvwUf9pzn1fE+nivkiy7LVbZL7FeKq5t5md1PV
 AkdXM80rSpBauz2lv4V9/UTkzuW6BN+eVo91UPa9nvE5bwrynk6uPx6F2kDkNuxzLig7
 Nkn6kPecT4Zji1i2VB4zG7TnNpbmTP+/iyPxVTO1xN2XGoZdal6Vx6FwUcKt2wA65TaM
 gKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265598; x=1719870398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZ4kWG3twGxCVLj6uKain/qVjrWftO9nQKi4a5+SpF4=;
 b=lQ3DPAEvZT92nu+Wkczjc+vc48sod63g3ymicNeWt/iVjr0+Jt0cf8DoeVAwSvXDp+
 +8fSBKo0Ftlhsxd31asVaF90SPA7X66rgrLi4IhUiPGQPxPShgbudxwsuYinPJO1MB3P
 sqoUUoB1RpJLYZ6H10wWiepWkjdHWUIZta8Mae2iGN6nxkxsayU8TxBKRxMam1d6TJbv
 Vt/lNZ99Ym0mArwHjxT1zD9OgdkSFS7y10zMQLCCXcamz+8Kb0gWB5OTOCKTtZTb5QW6
 ugdiRAULra+Iq1ZPMnrTR2DacrciDXg57upNIXU+ZLwQnce3e8rXiyWA8TFr8ctX8FqK
 YjRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyyO6IEEWy0PSLZIHOzJ2H47FMWERay+nkuZ4uE7ddqY5DtBHekbzZuGTASjE+IwSboNCeO5NvgHxg/0MRZgwQXiRtpA==
X-Gm-Message-State: AOJu0YxCWTJluIfaoYb6L5kkESGxxRoGZRj2IK51ZZmzoub+8siKGTMf
 UaxLRjpkp8TFo+6o9gS8Ow6bebn8oy3k+jrNtDAzGMAF9QAWhbD+
X-Google-Smtp-Source: AGHT+IHHv84Ii2PuRGJEvNTxys8Ts0KdYhyYGmOt0DcpTJl4tIHLwu49dHxyvP8aFcukDUPKg3cEaw==
X-Received: by 2002:a05:6402:26ce:b0:57d:544d:16e with SMTP id
 4fb4d7f45d1cf-57d544d01f6mr3262043a12.31.1719265598233; 
 Mon, 24 Jun 2024 14:46:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:37 -0700 (PDT)
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
Subject: [PATCH 3/9] led: implement LED boot API
Date: Mon, 24 Jun 2024 23:46:13 +0200
Message-ID: <20240624214626.24336-4-ansuelsmth@gmail.com>
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

Implement LED boot API to signal correct boot of the system.

led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
designated boot LED.

New Kconfig are introduced, CONFIG_LED_BOOT_ENABLE to enable the feature,
CONFIG_LED_BOOT_LABEL to declare the LED label in DT to reference
the LED for BOOT usage and CONFIG_LED_BOOT_PERIOD to declare the
blinking period.

If CONFIG_LED_BLINK is not enabled, led_boot_blink call will fallback to
simple LED ON.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig | 22 ++++++++++++++++++++++
 include/led.h       | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 13d6eb40cea..0506a33b6ee 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -9,6 +9,28 @@ config LED
 	  can provide access to board-specific LEDs. Use of the device tree
 	  for configuration is encouraged.
 
+config LED_BOOT_ENABLE
+	bool "Enable LED boot support"
+	help
+	  Enable LED boot support.
+
+	  LED boot is a specific LED assigned to signal boot operation status.
+
+config LED_BOOT_LABEL
+	string "LED boot label"
+	depends on LED_BOOT_ENABLE
+	help
+	  LED label defined in DT to assign for LED boot usage.
+
+config LED_BOOT_PERIOD
+	int "LED boot period"
+	depends on LED_BOOT_ENABLE && LED_BLINK
+	default 2
+	help
+	  LED boot blink period in ms.
+
+	  Value is normalized per CONFIG_SYS_HZ.
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
 	depends on LED && ARCH_BMIPS
diff --git a/include/led.h b/include/led.h
index 71dd7a28d93..479c6d17c5b 100644
--- a/include/led.h
+++ b/include/led.h
@@ -136,4 +136,44 @@ int led_set_period_by_label(const char *label, int period_ms);
  */
 int led_bind_generic(struct udevice *parent, const char *driver_name);
 
+#ifdef CONFIG_LED_BOOT_ENABLE
+
+#define LED_BOOT_PERIOD CONFIG_SYS_HZ / CONFIG_LED_BOOT_PERIOD
+
+/**
+ * led_boot_on() - turn ON the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_boot_on(void)
+{
+	return led_set_state_by_label(CONFIG_LED_BOOT_LABEL, LEDST_ON);
+}
+
+/**
+ * led_boot_off() - turn OFF the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_boot_off(void)
+{
+	return led_set_state_by_label(CONFIG_LED_BOOT_LABEL, LEDST_OFF);
+}
+
+#ifdef CONFIG_LED_BLINK
+/**
+ * led_boot_blink() - turn ON the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_boot_blink(void)
+{
+	return led_set_period_by_label(CONFIG_LED_BOOT_LABEL, LED_BOOT_PERIOD);
+}
+#else
+/* If LED BLINK is not supported/enabled, fallback to LED ON */
+#define led_boot_blink led_boot_on
+#endif
+#endif
+
 #endif
-- 
2.45.1

