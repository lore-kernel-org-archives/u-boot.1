Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB505C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07D688489;
	Wed,  5 Jun 2024 21:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CHtiy/xP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2FC088354; Wed,  5 Jun 2024 21:22:05 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D80588193
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4210aa012e5so2698795e9.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717615323; x=1718220123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TNivcV9fIP6piDP5txka5GQYQ+I/DYUHWTGBY1OTgpM=;
 b=CHtiy/xPFoYr35PW4cGv7QbjE4dDIz5BGoAw1tZnGxLlJriUuAouc3n817lLqI5O/G
 GECGGLjb7iYkz6Ob+/v63UcYGe0DZh3BW3IbXxHHUbE/wfbRX5raEfPx/kL/LUY8P2Wr
 4/Tp+j3uLzA+t8Lmvr4tl1m86XCy1pXwTfoKjFH8VMubLL+JTGhKAdXDFG+uKV5BYP24
 4Q+BkiBZDF0yBj4cc1de1tJ0LNYWogcfp/aGpBZC5ZFFOYLO+IsMWVotzdLpf3qvi1Q+
 0to0KrrRI/rKKi48n4kZ1oZZO6YQxVoLni59DO/ZxkB2Sg7crdVGQ2h7ISuInoa45bdG
 cOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717615323; x=1718220123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNivcV9fIP6piDP5txka5GQYQ+I/DYUHWTGBY1OTgpM=;
 b=QQYho4PUbLdPrAobVdVd6LLrFeUCv8JRBF163TvibbZX7AGBrIZcOT+do9TeRRv0zD
 FKRfTWCBpRxMjOCOKnIadxhBhhd+Oc3M2gTbAcMfRh0Hn1+TWBZNa1YG0MhkD63nhLmT
 FlZZfzMCl55wX5+WXydwr29Ja8lxRpmvMopjPGMNhmE1aE0o/vP2kJVx/KXn2Io1vgUh
 nDYskfWTyspuLQupWXMvAQlnLUzxz/HeP8VyQOl/nIulR062cX4g65JBpHXEvy7XIY/b
 Ak6PmOLTtbIqU4iAl//OHu2DuuxelR7uFKBSU4JSpTgS/6SOHuhXw9fc5wsOHlHsQAoP
 BMHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNORJtgcasM2W8JsFt016n6yWxTNChxjkDLfwB8O8BjV3g0nuZU43aq+zVjTfUVmgAKiXm4Ny/pkfKjYYeYccrbrCSeA==
X-Gm-Message-State: AOJu0YymYQMKDHayUYWt095Ilj3TJCIp8/VsCzsKMbx4GYJo0HfGxXfZ
 U76aUPe3JMSVo4JAwRSiqoDgfskHgfi/hVzgb+3iTuCJ3XgxOs9Y
X-Google-Smtp-Source: AGHT+IGT9+3D9UD80TiBI3TFi6cZpJx9+WTpFk67YPUOm5iAhPwLt81InOzx0HRlzW+Z/VvM80qhIg==
X-Received: by 2002:a05:600c:154a:b0:421:2b3e:3a22 with SMTP id
 5b1f17b1804b1-421562cce3dmr27899135e9.14.1717615322817; 
 Wed, 05 Jun 2024 12:22:02 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214bf5994csm36079625e9.1.2024.06.05.12.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:22:02 -0700 (PDT)
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
Subject: [PATCH 4/7] led: status_led: add new activity LED config and functions
Date: Wed,  5 Jun 2024 21:21:36 +0200
Message-ID: <20240605192146.19052-5-ansuelsmth@gmail.com>
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

Add a new activity LED config and additional functions to implement a
simple software blink feature to signal activity of any kind.

Usual activity might be a file transfer with TFTP, a flash write...

Driver will call status_led_activity on each activity and LED will be
toggled based on the defined FREQ config value.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig       | 15 +++++++++++++++
 drivers/misc/status_led.c | 25 ++++++++++++++++++++-----
 include/status_led.h      |  1 +
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 6c4f02d71f2..8eaa74bdd27 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -359,6 +359,21 @@ config LED_STATUS_BOOT
 
 endif # LED_STATUS_BOOT_ENABLE
 
+config LED_STATUS_ACTIVITY_ENABLE
+	bool "Enable BOOT LED"
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
index 93bfb410662..9490e1d7341 100644
--- a/drivers/misc/status_led.c
+++ b/drivers/misc/status_led.c
@@ -82,6 +82,14 @@ void status_led_init(void)
 	status_led_init_done = 1;
 }
 
+static void status_led_sw_blink(led_dev_t *ld)
+{
+	if (++ld->cnt >= ld->period) {
+		__led_toggle(ld->mask);
+		ld->cnt -= ld->period;
+	}
+}
+
 void status_led_tick(ulong timestamp)
 {
 	led_dev_t *ld;
@@ -95,11 +103,7 @@ void status_led_tick(ulong timestamp)
 		if (ld->state != CONFIG_LED_STATUS_BLINKING)
 			continue;
 
-		if (++ld->cnt >= ld->period) {
-			__led_toggle (ld->mask);
-			ld->cnt -= ld->period;
-		}
-
+		status_led_sw_blink(ld);
 	}
 }
 
@@ -140,3 +144,14 @@ void status_led_toggle(int led)
 
 	__led_toggle(ld->mask);
 }
+
+void status_led_activity(int led)
+{
+	led_dev_t *ld;
+
+	ld = status_get_led_dev(led);
+	if (!ld)
+		return;
+
+	status_led_sw_blink(ld);
+}
diff --git a/include/status_led.h b/include/status_led.h
index fe0c84fb4b4..037bad159c2 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -39,6 +39,7 @@ void status_led_init(void);
 void status_led_tick(unsigned long timestamp);
 void status_led_set(int led, int state);
 void status_led_toggle(int led);
+void status_led_activity(int led);
 
 /*****  MVS v1  **********************************************************/
 #if (defined(CONFIG_MVS) && CONFIG_MVS < 2)
-- 
2.43.0

