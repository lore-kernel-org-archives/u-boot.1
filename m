Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E278C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B0A884A4;
	Thu,  6 Jun 2024 18:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H7VQGzkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA8587D9B; Thu,  6 Jun 2024 16:30:43 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32398840E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-354dfe54738so862925f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717684241; x=1718289041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=USHF67Hvkkr6X6WZ90mIvVSk959Bhec2gU9xl0MKgOk=;
 b=H7VQGzkXwLxvUYSHrMiIDaEvY/Es/OmfpzNEJCU0XQCP0nokhLQRfGzxrgil11URFE
 NiXmBH1WvQNbI/fhqGFUXQ2D5MR208IN2EE6lvk8NcGUMvcMsBf1fZgnupaEzr/SifK4
 NHPVDQY6Se2bSWPRfd/YGjBZBjfwHXvciFkkiRVBeL4Kh0PyMpSIyWlPi+xSl+lGau+x
 emK+8hoEwDmH320iZtZUKyiX3Bq4kQSQB9ov29hIiBRQBozjF63YGltYF86KAEt6HtiT
 Gc+1ZOgavg+6i1+oXVptohTk3rlS1FecYWOKiuDPJ/P9xdwPqVFI/WYe4nCYp4BCCRBr
 xdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684241; x=1718289041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USHF67Hvkkr6X6WZ90mIvVSk959Bhec2gU9xl0MKgOk=;
 b=Naiwo/ujFVaXkHkkOVhKsoS9HIFYzVntn0JepkHNVnV0ntOtmcidJW8YgwG8Q3v6XI
 gjw6LfbCnnGqN0SuUxy5+caPmPwM/epSjaiR30StdKZfnfI8hwowdiPsRaFeYxJSj1Mz
 ms6dAslTiNshHrT72ey9iw0CWiqHRfbkWTgNB5/TtMUe7xix0VQSEiOfnpTvh9yeY6Ij
 qYEdGmZifZzqAu+Ak94KJsF1GoHjnD/0W0Vvg8qKsNBqqMxSg8Ii/2p7397DZEAIGLN2
 /00InnE2y6oBktkNf0L8dP7F481I1YbPBNQfHEdfngbeWXMPacN3Sx3hp6KHPb4B3K/w
 drPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFZTry/h1yMbjRDcgbSF8WvGhr/3ISxGl3EjMeLE7S8EfZj2jlBpK/nd/KtmpMHeWMR2VxHeW4Psy5r5nHyms+HmkNEw==
X-Gm-Message-State: AOJu0YyMp6pLxIYW9fI8HtY16imfxmj/fbRgrrz5WJOTjghoxc4w3Pfj
 ITNbx9BW47pkh1rlZ+B8I4hgeeiOqWFtvglHoI7bNxJNrelyr+MG
X-Google-Smtp-Source: AGHT+IH+wQ61kXWbNkyd81Smk+da1DQcEldEA4IDbcZtXsfH6u4OZ7IsLPvhWdgslzHQrECXz44rCA==
X-Received: by 2002:a05:6000:1047:b0:354:f515:431d with SMTP id
 ffacd0b85a97d-35e8404948bmr4406979f8f.11.1717684240714; 
 Thu, 06 Jun 2024 07:30:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1718060f8f.71.2024.06.06.07.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:30:40 -0700 (PDT)
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
Subject: [PATCH v2 2/8] led: status_led: add support for white LED colour
Date: Thu,  6 Jun 2024 16:29:23 +0200
Message-ID: <20240606143024.20024-3-ansuelsmth@gmail.com>
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
index 5256255f052..40dbc05a651 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -57,6 +57,9 @@ static const led_tbl_t led_commands[] = {
 #endif
 #ifdef CONFIG_LED_STATUS_BLUE
 	{ "blue", CONFIG_LED_STATUS_BLUE, blue_led_off, blue_led_on, NULL },
+#endif
+#ifdef CONFIG_LED_STATUS_WHITE
+	{ "white", CONFIG_LED_STATUS_WHITE, white_led_off, white_led_on, NULL },
 #endif
 	{ NULL, 0, NULL, NULL, NULL }
 };
@@ -180,6 +183,9 @@ U_BOOT_CMD(
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
index 039d6d712d0..54e2009339e 100644
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
index 0f3682e1465..de84c206b6b 100644
--- a/drivers/misc/gpio_led.c
+++ b/drivers/misc/gpio_led.c
@@ -112,3 +112,15 @@ void blue_led_off(void)
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

