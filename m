Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4C5C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8440188BF9;
	Wed,  7 Aug 2024 21:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gzF8yuWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5C1889D4; Wed,  7 Aug 2024 21:54:30 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2EF88BF9
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so2400145e9.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060467; x=1723665267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hYvK2I9nvof/73nSjBfyzMimiE25coX9dBrpUO5rafE=;
 b=gzF8yuWrY8O1nJ9L2cU6slH9RkYotPlWOl8qnw/TbjgOt8RvX74/BBZZE34NHhVsm2
 eUVm7y5MXrSr4mwBrygh1mL9T45qnPiKb7vQmC5rB3T90zzniKvZZ6sWR0KQyQ1J1Lmk
 BAy4cxpoGIoY2pdWehyaJ81p+qrdQSdIohFpflyCYH++0mXFc3hDBgaaTQKAiS4GmFa5
 nKP2VaFiNSLVulY7FDohyAEZNCIt/d5dEmTvXKfgaNnieMcMMEE6zXkeyBZDSKjc0jAB
 hDOPt8TUjR7Ld5ZTy4i+m9KTG3JVWbNlQY8uJrYwqvv72Q2IekYI06l8PHnPoDaU7p3x
 UoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060467; x=1723665267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYvK2I9nvof/73nSjBfyzMimiE25coX9dBrpUO5rafE=;
 b=VXacDRDvRJmduLn4hYICMJyuRpsKPtK467H3s1b/wxCcSLjnS6CrSzRgpX2j8aefxy
 ZYQWwmliEhpQ1U4684zTJkJosONkdsp4+suYe/wfRe3FQf2A2OMjnHApZp9ysJUjpC4y
 iE94CbDpVE5pJIVpHAQjeOLkcMuM+A7i/rwXvqfYLbROwx/oU0eefZuX3RvNW31aGtIf
 3Tos5cQ6NQN8VYPE1OtmO9lYIdeKsXcTslt3Q2X/lTDk8FjtS0mhvJntHHyJdnGKn1oO
 Q6kdbJzeKB3tZuAv7uX4CoOg9mMMfmiLdeaD9/xSmBbbe08etkPyAOACpv04yyYN1KmY
 7BSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAH2ULhqwFRXg/d5t1nRjG4AnENENI8hDLcH278HToSbGyeEQ0DL11nirEa/VlE8kuhgYM4SpnVnLv4fQlI6iHGwC+6g==
X-Gm-Message-State: AOJu0Ywfzc9lLQ1bXs6+xOLjZaX+FVLK2VnPv7hWvuUmQ38oNMbFbq1S
 iDNoJFlE61YhupQXwJ1ruusqhTH3+qbmzspLTNh1DX78IK6PG/zk
X-Google-Smtp-Source: AGHT+IFux2EvhMFcJx18f21iQI69cROesVB9DYgPagBBlT9JCI3SDn8tBIdSFA35eDGEsb5rDAXSTg==
X-Received: by 2002:a05:600c:35ca:b0:426:545b:ec00 with SMTP id
 5b1f17b1804b1-428e6b2f0c5mr177132375e9.19.1723060467442; 
 Wed, 07 Aug 2024 12:54:27 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v2 3/9] led: implement LED boot API
Date: Wed,  7 Aug 2024 21:54:06 +0200
Message-ID: <20240807195413.30456-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807195413.30456-1-ansuelsmth@gmail.com>
References: <20240807195413.30456-1-ansuelsmth@gmail.com>
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

If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
led_boot_blink call will fallback to simple LED ON.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig | 20 ++++++++++++++++++++
 include/led.h       | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

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
index c1f3380f253..7bbe165d838 100644
--- a/include/led.h
+++ b/include/led.h
@@ -159,4 +159,48 @@ int led_sw_set_period(struct udevice *dev, int period_ms);
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
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+/**
+ * led_boot_blink() - turn ON the designated LED for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_boot_blink(void)
+{
+	int ret;
+
+	ret = led_set_period_by_label(CONFIG_LED_BOOT_LABEL, CONFIG_LED_BOOT_PERIOD);
+	if (ret)
+		return ret;
+
+	return led_set_state_by_label(CONFIG_LED_BOOT_LABEL, LEDST_BLINK);
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

