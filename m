Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E8BC27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A015C884BA;
	Wed,  5 Jun 2024 21:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WLRuoNfp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858AE88300; Wed,  5 Jun 2024 21:22:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC9B8825E
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42147970772so1511485e9.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717615318; x=1718220118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tFLs4djXMjy4iXY0nn18T3TiYUGeLDPIB6Xqyuip8VI=;
 b=WLRuoNfpb+yB0zPGWfnPHFbJ5jmS+hUalw1X91W32HbfgmLl6bpfO8M2YkCuzdxrFT
 YiI0C1ieypRHKVzzC9lMvsDfeFKoTWp7TmixeSlRII8xdBGRLX9nTTrj4fG7Ejcg2Tku
 n4X0rLKSb1WnsNSovvoatycMPczRPj5QRH1Ykx3U5RlFDkn1Y5RnoP6c1IAmniOpDEy4
 i1lsvCdbnkxtpKL2BCJja/gt+RpB5ysRcqYyawrUbkrIayptcjsCh+kvrec2ReLJ4RTd
 owyAxcBICmlAv0VQnWnTaGX61KQFTz20+DWBH0rQsJCL5p12mFlWOIP5Q//gZTK1nge6
 SD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717615318; x=1718220118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFLs4djXMjy4iXY0nn18T3TiYUGeLDPIB6Xqyuip8VI=;
 b=M7h4byQTf8AaPPbc3+HYqjutDEVWJQ3+zWKQ5cNizulGsgaEfyICZvavxdpvEtO1H+
 RDSaAb2iW2FqKKbfs6ShbA6iaPxteGEkZBnvZiBTFuARQZ1UcRP0xV3u5wAtOl63vbB6
 kYl79/exLwuqn8bQZSq96NaGHfDVvViJ1Q7Siav9A3lA0F1j041oK+OhXZ8T1vZa6GiK
 MHVoKW0LLOxMUN4Z1pfVDbb/j1whZ498xVh4wmMJb8nJHyWg1b3EHQKQ+cVwadNV7Rs0
 1mfGd3vLhcSTL5C0LevoZ04qkuDfq9sJSV/QHwFlYVWpSzyQr6j1yugwC0kC39oHgU8d
 ZauA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU058oVziXANEGTPYKoYx+Gs/mgQN7KsfA7UU1FiEoR4o/xwXT+5ZJAbKwoEUMkA/5PekPWJuS0mowdUHgYJiET2JQugA==
X-Gm-Message-State: AOJu0YxfUVjprB3mXEGxHelX8TFkZF7awduEyiSkMRQH3vOO+ALsXCZ0
 Y4KhJJHukRNzl4qMgn9rJTuEar/lCNBWw1Y7GcSD4dPcXAyrrR8/
X-Google-Smtp-Source: AGHT+IGiX2LAnPfXvoiYiWPwxB7YUqVTWflFtU2cD61pbKMWs+3HBc7rsX8+nvISMLPUvYLCTVIxzQ==
X-Received: by 2002:a05:600c:4f83:b0:420:66e:4c31 with SMTP id
 5b1f17b1804b1-4215634de43mr31102835e9.34.1717615317813; 
 Wed, 05 Jun 2024 12:21:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214bf5994csm36079625e9.1.2024.06.05.12.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:21:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 1/7] misc: gpio_led: fix broken coloured LED status functions
Date: Wed,  5 Jun 2024 21:21:33 +0200
Message-ID: <20240605192146.19052-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605192146.19052-1-ansuelsmth@gmail.com>
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

