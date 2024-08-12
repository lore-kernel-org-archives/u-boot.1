Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD512C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A24A688747;
	Mon, 12 Aug 2024 12:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2jze8GM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB0887F19; Mon, 12 Aug 2024 12:33:10 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70EC487D6B
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5314c6dbaa5so3065228e87.2
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458787; x=1724063587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ozbQb4FB9CmFfyNx71cGb9eR8igJ78Q3C61YyFsXplE=;
 b=U2jze8GM1DuXwKaTQK9B9m0LCA3nfKPIfpus773vUROjkJ0lGAmfvHoCSe8WjbwNoW
 x2jt4YwklsUqdTK0GL/a+EmGb3OTxj7Ea15Zt0ZdJzlaCHCbTDSbAAg4c97zcWFUwMXV
 MgrRVRiDWHEriuMS/x6c0KzF/i2e6GSfK8rm1z8abwkGnnP0B8WML8GWbIt5Ki5E8CqU
 i5mGuQFcdQJ1tmnMmzRu4zJHHTxM0iMapqFN369HxbWMkueaEK3fiie72MwcjxUROUlg
 r+hkNz9s74wO0omZ0Rpx5Bpe4qQbhDYyJhVFlbgYPSRENNR/+C3+imLqSG3KH2nr1qRW
 LeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458787; x=1724063587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozbQb4FB9CmFfyNx71cGb9eR8igJ78Q3C61YyFsXplE=;
 b=ZZzcuiJerS2CJLz2b4FpczgGlups3eSRbm05JcDC8NU2C/5LK9JUuwNzQoWRUepltc
 PV4Yp9w0lsY8vga+w2fD81PXZgIutiDfjESnPL0ZylpIPOn1E3nq5mphhKYzAAGDJxm/
 WjAdKbrrBi7uf1tfGckWO3p+DQwKIPWV9jhSN5D8BqOkpTWDclbMCWTcZK3s8OKnN8Rh
 nzVxecbf5cmZ+ZzaH+nkQwX8sRElXkV+P8Q8VP5pJ3ZHsXdWNJzlb1Xaz48jXfkAqO5H
 hD13JRE23OnumAmwbwGQdOQrOXgZ/wp6FaUci3aCx9HmGSx825QCa6ehkcNwFyZCSOyZ
 rulA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0dgQ+EvMXqhq+B0uTW340IaLTnifssQUNjqDBn4UTrTULANzqB3BfPQLf6lfUjCZDpTZvWNQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyri/pxGkP68IO9m7H3sNgGbLAH59sLpr6RJ+yhF0GtMSxam7Tc
 /c6cHud932Kc1Hf18BUFGxHq9H3OT6iLTcOvcu3NACfMXpUVPqxC
X-Google-Smtp-Source: AGHT+IHT86ewDNqiICgZVWJ+8DgdQjXT5zulAN9TM3PxdNlaVklxyH14G6Um/+K8c9ZzmXZx5ZUxMA==
X-Received: by 2002:a05:6512:4020:b0:52f:cdb0:11da with SMTP id
 2adb3069b0e04-530ee995d7amr6397853e87.33.1723458786184; 
 Mon, 12 Aug 2024 03:33:06 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v3 3/9] led: implement LED boot API
Date: Mon, 12 Aug 2024 12:32:45 +0200
Message-ID: <20240812103254.26972-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812103254.26972-1-ansuelsmth@gmail.com>
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
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

New Kconfig are introduced, CONFIG_LED_BOOT_ENABLE to enable the feature.
This makes use of the /config property "u-boot,boot-led" to the define
the boot LED.
It's also introduced a new /config property "u-boot,boot-led-period" to
define the default period when the LED is set to blink mode.

If "u-boot,boot-led-period" is not defined, the value of 250 (ms) is
used by default.

If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
led_boot_blink call will fallback to simple LED ON.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 doc/device-tree-bindings/config.txt |  3 ++
 drivers/led/Kconfig                 | 20 +++++++++
 include/led.h                       | 64 +++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
index f50c68bbdc3..68edd177040 100644
--- a/doc/device-tree-bindings/config.txt
+++ b/doc/device-tree-bindings/config.txt
@@ -31,6 +31,9 @@ u-boot,error-led (string)
 	This is used to specify the label for an LED to indicate an error and
 	a successful boot, on supported hardware.
 
+u-boot,boot-led-period (int)
+	This is used to specify the default period for an LED in blink mode.
+
 bootsecure (int)
 	Indicates that U-Boot should use secure_boot_cmd() to run commands,
 	rather than the normal CLI. This can be used in production images, to
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index bee74b25751..fd9442edaf3 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -9,6 +9,26 @@ config LED
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
+	depends on LED_BOOT_ENABLE && (LED_BLINK || LED_SW_BLINK)
+	default 2
+	help
+	  LED boot blink period in ms.
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
 	depends on LED && ARCH_BMIPS
diff --git a/include/led.h b/include/led.h
index c1f3380f253..2d3b89674e2 100644
--- a/include/led.h
+++ b/include/led.h
@@ -9,6 +9,7 @@
 
 #include <stdbool.h>
 #include <cyclic.h>
+#include <dm/ofnode.h>
 
 struct udevice;
 
@@ -159,4 +160,67 @@ int led_sw_set_period(struct udevice *dev, int period_ms);
 bool led_sw_is_blinking(struct udevice *dev);
 bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
 
+#ifdef CONFIG_LED_BOOT_ENABLE
+
+/**
+ * led_boot_on() - turn ON the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_boot_on(void)
+{
+	const char *led_name;
+
+	led_name = ofnode_conf_read_str("u-boot,boot-led");
+	if (!led_name)
+		return -ENOENT;
+
+	return led_set_state_by_label(led_name, LEDST_ON);
+}
+
+/**
+ * led_boot_off() - turn OFF the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_boot_off(void)
+{
+	const char *led_name;
+
+	led_name = ofnode_conf_read_str("u-boot,boot-led");
+	if (!led_name)
+		return -ENOENT;
+
+	return led_set_state_by_label(CONFIG_LED_BOOT_LABEL, LEDST_OFF);
+}
+
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+/**
+ * led_boot_blink() - turn ON the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_boot_blink(void)
+{
+	const char *led_name;
+	int led_period, ret;
+
+	led_name = ofnode_conf_read_str("u-boot,boot-led");
+	if (!led_name)
+		return -ENOENT;
+
+	led_period = ofnode_conf_read_int("u-boot,boot-led-period", 250);
+
+	ret = led_set_period_by_label(led_name, led_period);
+	if (ret)
+		return ret;
+
+	return led_set_state_by_label(led_name, LEDST_BLINK);
+}
+#else
+/* If LED BLINK is not supported/enabled, fallback to LED ON */
+#define led_boot_blink led_boot_on
+#endif
+#endif
+
 #endif
-- 
2.45.2

