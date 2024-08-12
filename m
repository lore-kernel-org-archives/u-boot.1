Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E51AC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDED88755;
	Mon, 12 Aug 2024 12:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GeGCt1iu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740858880B; Mon, 12 Aug 2024 12:33:12 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B028884F
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-369c609d0c7so2993823f8f.3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458788; x=1724063588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F7EzSifg9g5UstZpOxR5pGveBAvWbwJf3eidWqN+PFY=;
 b=GeGCt1iuCc5jswQrq8b+NaJAeaJMQstHgmfujmXaQg3h+em5NAQv7za1rxto/DHu5Z
 Z4jVHowYhYHd91e0ppH+hDXJyuQwDh2zLYRJEWh696y7nQlDAg69veAJ/VgPfIWejb+K
 tSzFErPRy59NHhGvRQojbBJz6HM4WU7jNhh1cnuNZCUyyOqjKYVGk8J/uPjtrbRpPuIs
 gOp3O4WMEYr2X3mzAZaalaiHlJAvpYhdI2CezrAqQUrL6yDBOrWvW0j/eLG1xMOAt1g2
 Whcb/eR3TcfFTI31pJ8tJ6j7Ga1P9p3M6/kBNmW3LmDCsZgSCxh7oti5aLWW2U7v49sB
 wVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458788; x=1724063588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7EzSifg9g5UstZpOxR5pGveBAvWbwJf3eidWqN+PFY=;
 b=TFH7PG6SUbyKPx6lifVRQhQ+/7gSvB1q17sz6D6TGFLtyeXuy0IQXpIvzzmAdXWvHX
 WF/XCYMrZUi63ezvHlythUrcHBGho0LDm6UiBUBTaVwFb0gTPHMkHu7pW73eKG3o1Uv5
 XEsLo3oaUglCsGTm2Mm2lbyXngpKMTxqV3DlmG12egnumswKoV6ZNlVbos0i7QMpM9B7
 IucQp/lpKztXO13WLATzvRu1/01i21dM6b1vfiY91KrEzGRsrRP4JVXs+lZoGOMF3KkY
 7rmrhd+h7JExXI5ZQ4Wiq1QbRwvWL7eyEtMvyq036TVOiMQtpfcCzf4cymvi7Vp6Shdc
 QyaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuhWpFyTVdsGs0Iyq+tcPW+yMsdiHMsPbIEw6C1NwY4Tjxzsh+7hm9dVzvaVvARItRSbGA6zM=@lists.denx.de
X-Gm-Message-State: AOJu0YzOcWosWh0vChwn2RmQqZZpYQKIcjilSCnQGLSGEcLa+LigUUFm
 DtpHspJZfkE4Fqky+8bVOk0HRM39PGiopo3DfODELrjzWvBgCiH1
X-Google-Smtp-Source: AGHT+IFNrxeAyY1fNs+ttpV0wE4YJI+joscAhpjAVcXM3vP8Up0zMwci3NDdDCxl0/7nmBr8AqMaXw==
X-Received: by 2002:a05:6000:2a1:b0:368:4c38:a668 with SMTP id
 ffacd0b85a97d-36d5db7ac57mr9092366f8f.9.1723458788288; 
 Mon, 12 Aug 2024 03:33:08 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v3 4/9] common: board_r: rework BOOT LED handling
Date: Mon, 12 Aug 2024 12:32:46 +0200
Message-ID: <20240812103254.26972-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812103254.26972-1-ansuelsmth@gmail.com>
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
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

