Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFD2C27C79
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725AC88744;
	Wed, 12 Jun 2024 04:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FVgM8VET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 681BB8878B; Wed, 12 Jun 2024 01:14:53 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B84886B1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f2d723ef0so1187029f8f.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147691; x=1718752491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tFLs4djXMjy4iXY0nn18T3TiYUGeLDPIB6Xqyuip8VI=;
 b=FVgM8VETMERj808QkVSqtcehJNsYSk2gAhtJJMwWSVYSgYwLbIJ79iNzLM/ndewpUj
 WQFbSYB7fj02DqblPLOBqjFBuyuzygTpplvZPxE/q0rC6CIa1CF63Jhz1/vvnDsrG6pW
 OpIvIGnQ9h5neCcj6O2jNFjRGrBdOqcq8dID7Iqr6uTshgVqSDIto8jV5WOl4nZpMF9u
 jjq3ZfrTJ06r/kUi1rQiTf1rN62EqqVpPLHjBIDD/So7di5Rnbsg3uPXjSdKIKBUyyPp
 YzYuWEprZdTjWyKDZfOlCzhrOg8vwVio/vNFxgSVO7VLObtqHJbUmzvStXI2kx7q/AZh
 oiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147691; x=1718752491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFLs4djXMjy4iXY0nn18T3TiYUGeLDPIB6Xqyuip8VI=;
 b=vFIEI1PM3w4/HLXKmgrP/sFLHIdR2Chp1kJ+1na5S9iFpu2lCiaMSIs6Cr6aodxh4h
 Wc30eSkreXbsDdoPHcw7OFk7womYPqGzUxIeVNnUK1sp8XFT8TZ6ag2vRy3+dkYilWGK
 lKVHcDYAmK06ctk62mzt324RAjhG2VoEskbI6lhPkSlMe+XY9riAUTRpRSP5va2B5VCO
 5RJu4igmPTvqmShqwsFBaXgZLhbFQHiS8ihg6mqdMxhpKuPF4V8K2Sera7EMKvXg05v9
 fzCvNnFbCYtiyDKb/lhEEBAxsjaG3SMr2YBLAbtDKBi9AaPje4z3xhfPcY40nV5jz1C7
 4jfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGA6cI5yjhzuXrYbpqzCmIMrJzWxCzBbZh/AF7pgVBEWlbUwH26wFKuOZQgEYi9YBpMB7EZF8anW04QvkVYfpWyrncWg==
X-Gm-Message-State: AOJu0YzgLcL/xMzgXiRv3Z+PhWNFBmtnrB7SlN/wAxfCcTd/I6GHjVxa
 z7w+6lLvRIhcPzWqPg5d3V2OHPfBkZDELoh+apEVQhPlA5lgZHSf
X-Google-Smtp-Source: AGHT+IHOYc7Ix5G058dJhbJwY/HZQh2I2ljYQPW4o3Clk8RzrgjoUg44z2uM851gmGRJcNIHdeZUOQ==
X-Received: by 2002:a5d:64e4:0:b0:35f:22e4:fb58 with SMTP id
 ffacd0b85a97d-35fdf79cf3amr95866f8f.8.1718147690480; 
 Tue, 11 Jun 2024 16:14:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Bosch <stefan_b@posteo.net>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v3 1/9] misc: gpio_led: fix broken coloured LED status
 functions
Date: Wed, 12 Jun 2024 01:14:16 +0200
Message-ID: <20240611231435.10366-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611231435.10366-1-ansuelsmth@gmail.com>
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 04:33:23 +0200
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

The GPIO LED driver is a backend to provide LED status functions via the
GPIO common functions.

The coloured LED functions are currently broken and deviates from what
is written in README.LED

Quoting the README.LED:

CONFIG_STATUS_LED_RED is the red LED. It is used to signal errors.
This must be a valid LED number (0-5). Other similar color LED's macros
are CONFIG_STATUS_LED_GREEN, CONFIG_STATUS_LED_YELLOW and
CONFIG_STATUS_LED_BLUE.

Hence the value of the config must refer to the ID.

Currently this is not the case and the driver expect the GPIO ID to be
put in these config. On top of this to actually have these functions, a
never define in Kconfig config must be declared to actually compile
them. (CONFIG_GPIO_LED_STUBS)

To fix this and the GPIO problem, introduce some define that reference
the LED_STATUS_BIT<n> config to have the ID->BIT connection (as
described in Docs) and drop the never defined config.

The gpio_led already provide a wrapper to the functions and should not
be enabled if the board provide their custom function hence it's ok to
also provide the wrapper for the colour functions.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/gpio_led.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
index 30679f80cf1..0f3682e1465 100644
--- a/drivers/misc/gpio_led.c
+++ b/drivers/misc/gpio_led.c
@@ -52,56 +52,63 @@ void __led_toggle(led_id_t mask)
 	gpio_set_value(mask, !gpio_get_value(mask));
 }
 
-#ifdef CONFIG_GPIO_LED_STUBS
-
 /* 'generic' override of colored LED stubs, to use GPIO functions instead */
 
+/* We support up to 6 LEDs, LED 0 STATUS BIT doesn't have the number suffix */
+#define GPIO_BIT0	CONFIG_LED_STATUS_BIT
+#define GPIO_BIT1	CONFIG_LED_STATUS_BIT1
+#define GPIO_BIT2	CONFIG_LED_STATUS_BIT2
+#define GPIO_BIT3	CONFIG_LED_STATUS_BIT3
+#define GPIO_BIT4	CONFIG_LED_STATUS_BIT4
+#define GPIO_BIT5	CONFIG_LED_STATUS_BIT5
+/* C preprocessor magic way to generate a GPIO_LED<id> reference */
+#define GPIO_BIT(id)	___PASTE(GPIO_BIT, id)
+
 #ifdef CONFIG_LED_STATUS_RED
+
 void red_led_on(void)
 {
-	__led_set(CONFIG_LED_STATUS_RED, CONFIG_LED_STATUS_ON);
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_RED), CONFIG_LED_STATUS_ON);
 }
 
 void red_led_off(void)
 {
-	__led_set(CONFIG_LED_STATUS_RED, CONFIG_LED_STATUS_OFF);
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_RED), CONFIG_LED_STATUS_OFF);
 }
 #endif
 
 #ifdef CONFIG_LED_STATUS_GREEN
 void green_led_on(void)
 {
-	__led_set(CONFIG_LED_STATUS_GREEN, CONFIG_LED_STATUS_ON);
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_GREEN), CONFIG_LED_STATUS_ON);
 }
 
 void green_led_off(void)
 {
-	__led_set(CONFIG_LED_STATUS_GREEN, CONFIG_LED_STATUS_OFF);
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_GREEN), CONFIG_LED_STATUS_OFF);
 }
 #endif
 
 #ifdef CONFIG_LED_STATUS_YELLOW
 void yellow_led_on(void)
 {
-	__led_set(CONFIG_LED_STATUS_YELLOW, CONFIG_LED_STATUS_ON);
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_YELLOW), CONFIG_LED_STATUS_ON);
 }
 
 void yellow_led_off(void)
 {
-	__led_set(CONFIG_LED_STATUS_YELLOW, CONFIG_LED_STATUS_OFF);
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_YELLOW), CONFIG_LED_STATUS_OFF);
 }
 #endif
 
 #ifdef CONFIG_LED_STATUS_BLUE
 void blue_led_on(void)
 {
-	__led_set(CONFIG_LED_STATUS_BLUE, CONFIG_LED_STATUS_ON);
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_BLUE), CONFIG_LED_STATUS_ON);
 }
 
 void blue_led_off(void)
 {
-	__led_set(CONFIG_LED_STATUS_BLUE, CONFIG_LED_STATUS_OFF);
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_BLUE), CONFIG_LED_STATUS_OFF);
 }
 #endif
-
-#endif /* CONFIG_GPIO_LED_STUBS */
-- 
2.43.0

