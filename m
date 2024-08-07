Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC67C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F4F88D67;
	Wed,  7 Aug 2024 21:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EGon7hVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0550988C23; Wed,  7 Aug 2024 21:54:33 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D1388D39
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so2488045e9.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060469; x=1723665269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F7EzSifg9g5UstZpOxR5pGveBAvWbwJf3eidWqN+PFY=;
 b=EGon7hVxfkHQEfNdzq14d0ICQdJ1n7By9Y1kgqx7//lSHXKHPhsLHC0e506iibXVQ3
 Q6iJ8zo5w87S05jY0G/pZaVKKloAGbpbq44WuJIuciFkzDM9fWcBY4PeJGiIZpW4E8dO
 Xlvnqp3iximx7X51Ys18xnYI4huFFdRQwm6gkWjHCH0l4seKisFVNB9LXq+RIQm3GTGt
 FtU9RFidt80I1LyxjQHcS29tdv/wAeRyX3DzR2NTa8Ag/mOT1tJpLZYNw2CYnKsJMMIj
 KTpwdOX8qP1xvwLYHVJ+q/zecv8wNVk4TiCqiKWt9q8yBA8JqUpTrfg59sfEESHvbqzI
 60EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060469; x=1723665269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7EzSifg9g5UstZpOxR5pGveBAvWbwJf3eidWqN+PFY=;
 b=WNsRTkq9aI8Cn4Indk5LI7Fujo2jM0/uj5Wyxsu8kPaCPLeT3WHBdZbGD2FN2rKI6g
 zL+uKlKBqi/suLdhb3tcZg3EPqD6fs/LEprzFqV3YW8BWpKyqDqMnoJDwoyTNIaRjYgY
 8XLelQdRfP35pwCFGADTDArwMgX7nHSUxTXdLAni9etT0811H3vTCgG6ydmNLxUtkL5x
 e4bwhY3WjfxiMzlIcFg5+0o4kYr2QRNIIiNdc9Fmevqm5IqhiizRqqhtqBA2gGVzOr5k
 g2iuYkGF7FHPS+j4OVJW1+Udsh7tAmyOWW2ivgdynacZ4SCaSKsExZLTR0q1hShFmnkB
 px3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7jhTw0Xu324Nr1QR1/S4BLx4GBTlui6rwgj3Oj52baJOcyyGzkbmy+fbJ00xUwbXY0nhg3fr93FaXaDROfPHYnnq9TQ==
X-Gm-Message-State: AOJu0YzezVNjIcmUWHEaXYCz1m+CfaknKbbB7dPLcOZa+LBCousI13o7
 awjB+VwYet1klw1Ha3GjFKQRr/Q7m9cGdOoAaBTCuuf7HtLiolXe
X-Google-Smtp-Source: AGHT+IHgUX43Gh+Wvr1BFIIzz6Jw1RfKmNvlJBi3nWvD7Kl03OwbPKFI5U7zu/r/CWBgofjTv6MGGg==
X-Received: by 2002:a05:600c:4588:b0:428:15b0:c8dd with SMTP id
 5b1f17b1804b1-428e6b2f14emr185108825e9.20.1723060469322; 
 Wed, 07 Aug 2024 12:54:29 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:28 -0700 (PDT)
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
Subject: [PATCH v2 4/9] common: board_r: rework BOOT LED handling
Date: Wed,  7 Aug 2024 21:54:07 +0200
Message-ID: <20240807195413.30456-5-ansuelsmth@gmail.com>
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

Rework BOOT LED handling. There is currently one legacy implementation
for BOOT LED from Status Led API.

This work on ancient implementation wused by BOOTP by setting the LED
to Blink on boot and to turn it OFF when the firmware was correctly
received by network.

Now that we new LED implementation have support for LED boot, rework
this by also set the new BOOT LED to blink and also set it to ON before
entering main loop to confirm successful boot.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 common/board_r.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index d4ba245ac69..57957b4e99b 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -39,6 +39,7 @@
 #include <initcall.h>
 #include <kgdb.h>
 #include <irq_func.h>
+#include <led.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <miiphy.h>
@@ -462,14 +463,30 @@ static int initr_malloc_bootparams(void)
 #if defined(CONFIG_LED_STATUS)
 static int initr_status_led(void)
 {
-#if defined(CONFIG_LED_STATUS_BOOT)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_BLINKING);
-#else
 	status_led_init();
+
+	return 0;
+}
+#endif
+
+static int initr_boot_led_blink(void)
+{
+#ifdef CONFIG_LED_STATUS_BOOT
+	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_BLINKING);
+#endif
+#ifdef CONFIG_LED_BOOT_ENABLE
+	led_boot_blink();
 #endif
 	return 0;
 }
+
+static int initr_boot_led_on(void)
+{
+#ifdef CONFIG_LED_BOOT_ENABLE
+	led_boot_on();
 #endif
+	return 0;
+}
 
 #ifdef CONFIG_CMD_NET
 static int initr_net(void)
@@ -716,6 +733,7 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CONFIG_LED_STATUS)
 	initr_status_led,
 #endif
+	initr_boot_led_blink,
 	/* PPC has a udelay(20) here dating from 2002. Why? */
 #ifdef CONFIG_BOARD_LATE_INIT
 	board_late_init,
@@ -738,6 +756,7 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CFG_PRAM)
 	initr_mem,
 #endif
+	initr_boot_led_on,
 	run_main_loop,
 };
 
-- 
2.45.2

