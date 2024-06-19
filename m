Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7ADC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2106884CA;
	Thu, 20 Jun 2024 03:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOWEeaTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF838846D; Thu, 20 Jun 2024 01:04:10 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073C38846D
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4217dbeb4caso3107315e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838248; x=1719443048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7KSsr5sd4Y0MY+zz8swijIctuwVPsy5JiwiZ7tE0uMw=;
 b=kOWEeaTc+kMpWiw70wVnm5EnduQShIcrufK8CJG20Ifu2x2JbSe/3COE/hd6tmFtAr
 SNxB3HIKv9161m9OSr2pxVtSbBiy6u0mOmq4bs2W3I/SPA12sacewWfXx7hZF5JJeRFn
 goosVSs68BrIiA5V+rxFvUpHqecB56/b6dzyCl1NkccVWBqGgdUFkhXYiCIlNOGll/fR
 rrMO93/XTGrw7FcVKqSzLIUE75uVJedzgngkrbp4o0Atbz8l3qtbsdfIDUjKSOpwDELn
 /3MuHURJMBLrDrDyf+rR1GYDONPiqpCPH+EtbZugQca0aYkSohzEKmlsIuAlWNx72F0o
 JqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838248; x=1719443048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7KSsr5sd4Y0MY+zz8swijIctuwVPsy5JiwiZ7tE0uMw=;
 b=Y4hGtc8GeDThpefjbBdc7P08VFZKScgPBx0aTair8Oc9+Ug3H5PU7PViHbCEJhZSAx
 F/G998UDO7fTrGscMbmJmfKJj5JBdaKXLtcMpJcLCSQJocv8trLhR1j/y9dF0sqMbOOL
 IDInWaHz5JMQhjB5OlW0jLIxwJybPY6fuW9FWzoeFUXAlJrAjoZysjE4wv2CHKMGeyme
 2l3qpXz7vN7OJeNj1D+39StRC63ibOeLqPDrLFAhiiykOrZaNW+l0N6H60PwD8YTpCuK
 2wH4GuM9Bo20cimrIqIl6G4jtt755oU1Vk8/Q+K3BxoEy2r7PNNg3nu7poIGu50BP9Gm
 gthw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF/8cg0EBhg6dkQwIXu4rnyiayJdkyZPV/Mj9GbwB151nPfyPgPA7T2z2TIR+zF2i51iy2ub4wofTHBXdB9ZnsAkPaqQ==
X-Gm-Message-State: AOJu0YzPTfULrqvVDwXhUPZWljv93dMIbYXUzZnCsoQ/zfBkAuuKIJmG
 jQu6MOZcjb33lAzsyFdd+liJxpWzsL5tLxIo5gyxi77kDFWBFj3l
X-Google-Smtp-Source: AGHT+IGiE8ntqrdMff90aNnkCT3mQfAg8UL8NV4R6dP/tT9M9VVealMWDJlE5aUIdUx4OKMB0L9oAA==
X-Received: by 2002:a05:600c:2106:b0:421:79dc:56e4 with SMTP id
 5b1f17b1804b1-424752a25f1mr25776465e9.41.1718838248397; 
 Wed, 19 Jun 2024 16:04:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:08 -0700 (PDT)
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
Subject: [PATCH v4 1/9] misc: gpio_led: fix broken coloured LED status
 functions
Date: Thu, 20 Jun 2024 01:03:19 +0200
Message-ID: <20240619230400.8459-2-ansuelsmth@gmail.com>
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
index e63689967a7..6626b137087 100644
--- a/drivers/misc/gpio_led.c
+++ b/drivers/misc/gpio_led.c
@@ -51,56 +51,63 @@ void __led_toggle(led_id_t mask)
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

