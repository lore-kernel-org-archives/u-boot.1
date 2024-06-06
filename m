Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5158EC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7818848F;
	Thu,  6 Jun 2024 18:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iZfPUBlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E40188423; Thu,  6 Jun 2024 16:30:42 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA4A88414
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52b83225088so1241151e87.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717684239; x=1718289039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tFLs4djXMjy4iXY0nn18T3TiYUGeLDPIB6Xqyuip8VI=;
 b=iZfPUBlBbi8q3tiuW4xDEE/Hxb9nKRRRxLbyDriMZOzT0OzR+TjHyKoZhpMyK3IdML
 5yK7t84WMxRLtYMnO4qr/ZBW3r67pxud8TUQqqiZalukaN6sS8RBvVDHEdiCXVNnChsG
 JftF6WO8HqUDj47PaukAq2Lxee0LI41Fi0dgmr0dRzA+AoHYsP2qDxZwyMs/p2m6/gkF
 Yhi54RnxfVvlp8kChLvAoI+SW8E/60bwLYJ+RNbcoM9s83EDN6B9cRsgfb7X/GHBYiI/
 8J0O3y/QavzeHOPKV3XJYbUb+Lxy+NrWIoNAlMrFkNR24FFW3HcLMX9aYCYr9VTkZoUI
 wRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684239; x=1718289039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFLs4djXMjy4iXY0nn18T3TiYUGeLDPIB6Xqyuip8VI=;
 b=Szb3mgrSPaxGuonSTnFc3wvloGa9AJcino1KpTBbxdYltk8yR6RM9Is1yDyTSzvxNU
 7lyyLogOvSiZi3CEcagUX2aaAlywSHq8w6ounzuPgqabeoUvRrbQdAbvSsl/LnhD6179
 cEJzVmUK7jknkJy0gGt39uFPNEdbPNYw1HkiZVJqvMRrvH0oZIMBhKTKRNWjupAjim6e
 GvEpwg3yX6H7nxwL7oynfQHRgXMS2kstI1BWuTwcdVJtpZl9IvmMATQ0GQcLMVh7urfg
 eXmJ9zLnmcm+HxFBjhCh1YXfsFEjePV/ZtnwaYC93cPpZgZMLtuHyzqoAaMlOxtumFaU
 pC9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhtJSCV2ajIpFl9C1i/EwFadHJLX/aVKqYcPaCrb7yfB3tQePXgQCFQt27W8bausWTpRtdynsWFVBsoV4qDrX3LL9JKg==
X-Gm-Message-State: AOJu0YwvMZblWrzyyjyRAJOefUXbZcy2CFt+BKhXa0btZbVcMlxPTm6f
 E0CuFt8QVlFtImXIRFGKWtIKU41quuIlMc6pR+4A8VYixP/ocEtB
X-Google-Smtp-Source: AGHT+IEqORuJ8vixJr9HFeAYU0+TjgIUR76cKsVrLm+kZKJ5VS0sRc0sfSPgWxpepGUw286qfQuCAw==
X-Received: by 2002:a05:6512:39c7:b0:52b:7c7e:303 with SMTP id
 2adb3069b0e04-52bab4fa592mr3983220e87.49.1717684238956; 
 Thu, 06 Jun 2024 07:30:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1718060f8f.71.2024.06.06.07.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:30:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v2 1/8] misc: gpio_led: fix broken coloured LED status
 functions
Date: Thu,  6 Jun 2024 16:29:22 +0200
Message-ID: <20240606143024.20024-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606143024.20024-1-ansuelsmth@gmail.com>
References: <20240606143024.20024-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:33:44 +0200
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

