Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0353C27C53
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F778850B;
	Thu, 20 Jun 2024 03:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lyazKzf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 632DF884BF; Thu, 20 Jun 2024 01:04:16 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8A38846D
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36087277246so157963f8f.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838254; x=1719443054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1W/OECgpXMCODNpR1v+dyEbiBLXkvDzchERvizWB0Hs=;
 b=lyazKzf3gYLPT+Jv4pfzKsJ85/46M/W46ujprcrNnLDixEABq1N1oDEPPPncoUjeHD
 UQlI4UtkyUXfLnVZaj9w3t+M4bEP/SN9HT53CiigK97ygbVL8bZAv6W3tAzvDLy8p2sI
 Km2rcS9GnYkyUuEaVo38IcbZlkzUh2lYjblTvoQJaSBH836WLOQH33ATnJKe1lVIOjza
 FSOcA8aOVM6oWaRmexYFmbOMPI2YmXdr7sVJIheCv6SH2cfiOhMZaQBGBJ/K0/0phjQ0
 RLpFB0AXhnFmKeD+uGTNCYT+umYrf87j/khDSm8vzIGw54K2o+A9KW/xV9rt98LNmEVD
 bdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838254; x=1719443054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1W/OECgpXMCODNpR1v+dyEbiBLXkvDzchERvizWB0Hs=;
 b=VL+HJ2BQYSNkpD5GTty08M2oSWnlq9AvaKpz3M0EVlEkWsxEwIqYfu3FK4kJ4oH9GY
 12LH1Zi/kYapVlpa+li2nrpkyXkMYEKZ86pFzFjuilZkQaAQYFtg6drdMzlJt7J5CoZj
 tLEvS+ZKnIh/ppUzPI9BCKUpO1rqNYMEp8VX9LTlR0FsGR2BdCtPINwpTlBoQmCmigxH
 5L703ZcaNYwmx00uwmt9cPEIYAPbBXRDqKJ6xlLidMH8WZz2D35hwBe0AT9cdRiQ3pLM
 GuKozrdMjBhvi8fWVO7Djx330pNsBEfFcRFSViXfbyXsN34DiGYeh5I4xOrxs1e6ysXn
 JMCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2TV0SfF7/nv9rjlCehqMDAHTah3ngQVNcBJsoBblkx48t9fvt1yqi6yPkqCOf8Hsg59zf/L9j8JX1hKeUhEin9IAVNQ==
X-Gm-Message-State: AOJu0YzflLRkvUJvh9N0Jr2CAF3wrlEtw4ZgfTaCgR2Hr1kRhPuT7AV6
 2ffQSEReyaL6T8aRs3wSjE1daR0jp//E6Cg3fr0DLMIOwHIH9bdL
X-Google-Smtp-Source: AGHT+IE/G3bHkZiIPCUAWwCgM73gZdHkdpBx3eQK9yv/nIMngHnXqDv5MiNT8RgCUMOn+TE7+dIang==
X-Received: by 2002:a05:6000:1bc1:b0:360:9bf5:1eab with SMTP id
 ffacd0b85a97d-36317c79ff7mr2609617f8f.36.1718838253607; 
 Wed, 19 Jun 2024 16:04:13 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:13 -0700 (PDT)
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
Subject: [PATCH v4 5/9] led: status_led: add new activity LED config and
 functions
Date: Thu, 20 Jun 2024 01:03:23 +0200
Message-ID: <20240619230400.8459-6-ansuelsmth@gmail.com>
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

Add a new activity LED config and additional functions to implement a
simple software blink feature to signal activity of any kind.

Usual activity might be a file transfer with TFTP, a flash write...

User of this API will call status_led_activity_start/stop() on each
activity and LED will be toggled based on the defined FREQ config value.

With this enabled, cyclic API are also enabled as this makes use of
cyclic API to handle LED blink.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig       | 16 +++++++++++++++
 drivers/misc/status_led.c | 43 +++++++++++++++++++++++++++++++++++++++
 include/status_led.h      |  2 ++
 3 files changed, 61 insertions(+)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 6c4f02d71f2..869ed78e87f 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -359,6 +359,22 @@ config LED_STATUS_BOOT
 
 endif # LED_STATUS_BOOT_ENABLE
 
+config LED_STATUS_ACTIVITY_ENABLE
+	bool "Enable BOOT LED"
+	select CYCLIC
+	help
+	  Enable to turn an LED on when the board is doing some
+	  activity (flash write, file download).
+
+if LED_STATUS_ACTIVITY_ENABLE
+
+config LED_STATUS_ACTIVITY
+	int "LED to light when the board is doing some activity"
+	help
+	  Valid enabled LED device number.
+
+endif # LED_STATUS_ACTIVITY_ENABLE
+
 config LED_STATUS_RED_ENABLE
 	bool "Enable red LED"
 	help
diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
index 7912b4a9448..019096562ca 100644
--- a/drivers/misc/status_led.c
+++ b/drivers/misc/status_led.c
@@ -4,7 +4,10 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <cyclic.h>
 #include <status_led.h>
+#include <stdio.h>
+#include <linux/kernel.h>
 #include <linux/types.h>
 
 /*
@@ -23,6 +26,7 @@ typedef struct {
 	int state;
 	int period;
 	int cnt;
+	struct cyclic_info cyclic;
 } led_dev_t;
 
 led_dev_t led_dev[] = {
@@ -142,3 +146,42 @@ void status_led_toggle(int led)
 
 	__led_toggle(ld->mask);
 }
+
+static void status_led_activity_toggle(struct cyclic_info *ctx)
+{
+	led_dev_t *ld = container_of(ctx, led_dev_t, cyclic);
+	__led_toggle(ld->mask);
+}
+
+void status_led_activity_start(int led)
+{
+	led_dev_t *ld;
+
+	ld = status_get_led_dev(led);
+	if (!ld)
+		return;
+
+	/* Use status LED state to track if cyclic is already register */
+	if (ld->state == CONFIG_LED_STATUS_BLINKING) {
+		printf("Cyclic for activity status LED %d already registered. THIS IS AN ERROR.\n",
+		       led);
+		cyclic_unregister(&ld->cyclic);
+	}
+
+	status_led_set(led, CONFIG_LED_STATUS_BLINKING);
+
+	cyclic_register(&ld->cyclic, status_led_activity_toggle,
+			ld->period * 500, "activity");
+}
+
+void status_led_activity_stop(int led)
+{
+	led_dev_t *ld;
+
+	ld = status_get_led_dev(led);
+	if (!ld)
+		return;
+
+	cyclic_unregister(&ld->cyclic);
+	status_led_set(led, CONFIG_LED_STATUS_OFF);
+}
diff --git a/include/status_led.h b/include/status_led.h
index fe0c84fb4b4..7de40551621 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -39,6 +39,8 @@ void status_led_init(void);
 void status_led_tick(unsigned long timestamp);
 void status_led_set(int led, int state);
 void status_led_toggle(int led);
+void status_led_activity_start(int led);
+void status_led_activity_stop(int led);
 
 /*****  MVS v1  **********************************************************/
 #if (defined(CONFIG_MVS) && CONFIG_MVS < 2)
-- 
2.43.0

