Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3727C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5214C884DB;
	Thu, 20 Jun 2024 03:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0UuvCno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E45668840C; Thu, 20 Jun 2024 01:04:12 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D5888427
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52c85a7f834so365792e87.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838250; x=1719443050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ixx02Xe74NaBl6w9rxIlJyhksnvnH4eo2kFSeBHCLmE=;
 b=P0UuvCnosSnYHpHPsZLyW9/wgXrvHyhEqFTAc98ZrC0rh8dDqVebn2vkEJohlGI508
 39hUxWgvk22CI6B/IVrBObGVpd1I084x/LlFgoLcOZvBReC+LbAmMznJghk3k97FZnqI
 ZiupS+Sx/qrNq41ngRlF9kSE9N6G63NTT8T9CXN8PmAFJnFpsIW2r1hrQ8w8JwIHuf14
 igg+PqdjvrGoIkGiyCRqkgaC9u8bxgde/MvXsY8ts6cPZJWMjE3rnRhgCJ9t7qBGCesr
 ouA9ghb3zKpHOo2Ja3PuV6pR80EBeP1r63ax6Bu/NTIdOyPsznaSaM7nUpcXt1WWCVY1
 Lvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838250; x=1719443050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ixx02Xe74NaBl6w9rxIlJyhksnvnH4eo2kFSeBHCLmE=;
 b=VbKLSn31Itf4XU+PAwEE/cvcn40TTc6zYyJQroo7QnYyLAGWNHr1LRE1dUZi4+4qnp
 Dzk4lJWhw41R5Lx7ilhVPvjii/8Z9lDfHdA8NXpn7NJSfm7DzMwjiOOZNIqTC+o69vU/
 5Uqab2Kvf7FJQrdXmRgB6HjrWshe0pzVKi1od/T/vssdJpB3w4PhBULkzX0oFGSbTfLg
 juWYb/ozdrLVBYb/Utcenr+FV4BvzGBMNlwrjCW616NtC6rFl7xOqw1h5n8csEvAyk1m
 qPNCzU2RXgy5jmClvnfQU047CUoiZLD0f0bdg5EgNylYARFOnqnc8zLXwIX8D1MjQPE5
 QWVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjfgRzxFfu6NJ4SksRIuhgorX+VILel06g/fJc0TeGCT5sthzXkCfgDeIwMrbvTRAm1YBq0TYzOMzRp0iHCf9+k6wisg==
X-Gm-Message-State: AOJu0YzTsynQMgmEABh8mPzwIPOEwVhw+KH4NobZ6dsVLwrQonFsoiiA
 R0dWg5Hlw2OjYZIrBK1VN1x5jcTFATNScsoxSX1G04WTdFMn0UDu
X-Google-Smtp-Source: AGHT+IEbJTrpI7c2bFelzB6QTHezRAE0+BlbZv0mbQziTh3EkjslrlQLDbHVBaWRB8iCMA54hQXfqA==
X-Received: by 2002:a05:6512:138c:b0:51e:11d5:bca5 with SMTP id
 2adb3069b0e04-52ccaa974c1mr2343182e87.54.1718838249725; 
 Wed, 19 Jun 2024 16:04:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v4 2/9] led: status_led: add support for white LED colour
Date: Thu, 20 Jun 2024 01:03:20 +0200
Message-ID: <20240619230400.8459-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619230400.8459-1-ansuelsmth@gmail.com>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Jun 2024 03:31:55 +0200
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

Add support for white LED colour present on many devices.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/legacy_led.c        |  6 ++++++
 common/board_f.c        |  2 ++
 drivers/led/Kconfig     | 14 ++++++++++++++
 drivers/misc/gpio_led.c | 12 ++++++++++++
 include/status_led.h    |  4 ++++
 5 files changed, 38 insertions(+)

diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
index 50de7e89d8f..18f0c3472c4 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -56,6 +56,9 @@ static const led_tbl_t led_commands[] = {
 #endif
 #ifdef CONFIG_LED_STATUS_BLUE
 	{ "blue", CONFIG_LED_STATUS_BLUE, blue_led_off, blue_led_on, NULL },
+#endif
+#ifdef CONFIG_LED_STATUS_WHITE
+	{ "white", CONFIG_LED_STATUS_WHITE, white_led_off, white_led_on, NULL },
 #endif
 	{ NULL, 0, NULL, NULL, NULL }
 };
@@ -179,6 +182,9 @@ U_BOOT_CMD(
 #endif
 #ifdef CONFIG_LED_STATUS_BLUE
 	"blue|"
+#endif
+#ifdef CONFIG_LED_STATUS_WHITE
+	"white|"
 #endif
 	"all] [on|off|toggle|blink] [blink-freq in ms]",
 	"[led_name] [on|off|toggle|blink] sets or clears led(s)"
diff --git a/common/board_f.c b/common/board_f.c
index 212ffb3090b..af79ed9c776 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -72,6 +72,8 @@ __weak void yellow_led_on(void) {}
 __weak void yellow_led_off(void) {}
 __weak void blue_led_on(void) {}
 __weak void blue_led_off(void) {}
+__weak void white_led_on(void) {}
+__weak void white_led_off(void) {}
 
 /*
  * Why is gd allocated a register? Prior to reloc it might be better to
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 9837960198d..6c4f02d71f2 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -415,6 +415,20 @@ config LED_STATUS_GREEN
 
 endif # LED_STATUS_GREEN_ENABLE
 
+config LED_STATUS_WHITE_ENABLE
+	bool "Enable white LED"
+	help
+	  Enable white status LED.
+
+if LED_STATUS_WHITE_ENABLE
+
+config LED_STATUS_WHITE
+	int "White LED identification"
+	help
+	  Valid enabled LED device number (0-5).
+
+endif # LED_STATUS_WHITE_ENABLE
+
 config LED_STATUS_CMD
 	bool "Enable status LED commands"
 
diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
index 6626b137087..dfc9b009570 100644
--- a/drivers/misc/gpio_led.c
+++ b/drivers/misc/gpio_led.c
@@ -111,3 +111,15 @@ void blue_led_off(void)
 	__led_set(GPIO_BIT(CONFIG_LED_STATUS_BLUE), CONFIG_LED_STATUS_OFF);
 }
 #endif
+
+#ifdef CONFIG_LED_STATUS_WHITE
+void white_led_on(void)
+{
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_WHITE), CONFIG_LED_STATUS_ON);
+}
+
+void white_led_off(void)
+{
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_WHITE), CONFIG_LED_STATUS_OFF);
+}
+#endif
diff --git a/include/status_led.h b/include/status_led.h
index 6707ab1d29d..5ce4522b029 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -87,6 +87,8 @@ void yellow_led_on(void);
 void yellow_led_off(void);
 void blue_led_on(void);
 void blue_led_off(void);
+void white_led_on(void);
+void white_led_off(void);
 #else
 	.extern LED_init
 	.extern red_led_on
@@ -97,6 +99,8 @@ void blue_led_off(void);
 	.extern green_led_off
 	.extern blue_led_on
 	.extern blue_led_off
+	.extern white_led_on
+	.extern white_led_off
 #endif
 
 #endif	/* _STATUS_LED_H_	*/
-- 
2.43.0

