Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EADC27C79
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210B2887CA;
	Wed, 12 Jun 2024 04:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K5bdUK+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FF587B30; Wed, 12 Jun 2024 01:14:58 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FED78871C
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f1e35156cso2883112f8f.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147696; x=1718752496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rCPUoR3Hm4ttQ2PN9Sraj9o+7KI/qo8K5RXCu1Gre4o=;
 b=K5bdUK+xNyFSWDhDtBPy7022cVTZXxxIyqR/oAERPT+4HNncKHbA6q0zqHMfat8Slk
 Mj1gHvtbrjA61guiGlGWQm7lu/lMiXjj9EvAVcR3krVYUfoQGK8xX3ETXim2/YX23VRg
 q7hJ0CxNh1Iwe8NE4/f7B69QL3B7K+aebRj+TVr3K7xyiXoPIksFbqnUBLlKvWWBGF9w
 Vhy80D56Yzk2w/7kNL3rlut3GAt5ZhZwSCyehfjqzQoP3llNqQ/e9ZH1IU8FAkhF7EiR
 oe7U+VvaNmgB+zNA6IamGNBCD3uHC6HELwfMCdXcsHi/12pn8capheM8MJF2+mdY5EV/
 9tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147696; x=1718752496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCPUoR3Hm4ttQ2PN9Sraj9o+7KI/qo8K5RXCu1Gre4o=;
 b=SOSJLm+xFPNL/5YVlAFDK1q1qaFS05/a0ZiHb8Chmx5AYxr6jWlIHZN5OpYhbB2jRA
 uoWifUKrVR67BKwWvDFskelT4tN4jvzwlh6EygCrdiUtmj/Ap1SszupM28dQhnPT0RD4
 rWOBKSPfY9tD/eZkGuQi16+GWaknuFV0ggDkDpw35MrV6Aw0teqp6ywZZBEqVQJzMxAY
 iyf+a6D1NHEKyFRiKIsDCYGndn9mFJ8lbQtlaEwSU8cc7kVyTVfG97hDiIyzwUaWd/jo
 fbk7KFdK9yNOSpc7Rs3XOaRdxuJLublFXsZOm6tJg0paNY29tariuMZebCwlPWV/fjrP
 4cTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv2VlYuZnj6n2D3CGAZJM/MLTDNkcadMmnUUb3UJBJe9GFwJcAyzbQjJVDkimEPd2ry1Mj4koNHBupJS85wwlnMmgXNA==
X-Gm-Message-State: AOJu0YzBXF/D7HV6IfV4MLT9Q4bxo4kXdA0YO25YCYNEJXVMH0j+PvL+
 eVnaO90/E4R0Zh4k5YYd3YNDwhGgU6fvXYdw8+/OvEfFcKUiQoz7
X-Google-Smtp-Source: AGHT+IGHf9tTJLJX4JQHCj+ejWkxjQqMMtA8Bi5vpbtcE1t6B2B4Lf2niFw9caRCgj+MarBlGtj04A==
X-Received: by 2002:a5d:4c92:0:b0:35f:322b:92d6 with SMTP id
 ffacd0b85a97d-35fdf786ea2mr48230f8f.12.1718147695498; 
 Tue, 11 Jun 2024 16:14:55 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:55 -0700 (PDT)
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
Subject: [PATCH v3 5/9] led: status_led: add new activity LED config and
 functions
Date: Wed, 12 Jun 2024 01:14:20 +0200
Message-ID: <20240611231435.10366-6-ansuelsmth@gmail.com>
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
index 882273cc322..6d5207508d8 100644
--- a/drivers/misc/status_led.c
+++ b/drivers/misc/status_led.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cyclic.h>
 #include <status_led.h>
 
 /*
@@ -23,6 +24,7 @@ typedef struct {
 	int state;
 	int period;
 	int cnt;
+	struct cyclic_info *cyclic;
 } led_dev_t;
 
 led_dev_t led_dev[] = {
@@ -142,3 +144,44 @@ void status_led_toggle(int led)
 
 	__led_toggle(ld->mask);
 }
+
+static void status_led_activity_toggle(void *ctx)
+{
+	__led_toggle(*(led_id_t *)ctx);
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
+	if (ld->cyclic) {
+		printf("Cyclic for activity status LED %d already registered. THIS IS AN ERROR.\n",
+		       led);
+		cyclic_unregister(ld->cyclic);
+	}
+
+	status_led_set(led, CONFIG_LED_STATUS_BLINKING);
+
+	ld->cyclic = cyclic_register(status_led_activity_toggle,
+				     ld->period * 500, "activity", &ld->mask);
+	if (!ld->cyclic)
+		printf("Registering of cyclic function for activity status LED %d failed\n",
+		       led);
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
+	cyclic_unregister(ld->cyclic);
+	ld->cyclic = NULL
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

