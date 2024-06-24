Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6C4C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119898855B;
	Mon, 24 Jun 2024 23:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lgK4Happ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD7988119; Mon, 24 Jun 2024 23:46:42 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F608848D
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6fe7a0cb58so128870566b.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265599; x=1719870399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dJX5RhwWGDdrpnAtg3eu17Ph2P7mi53gQC+5L1tt27k=;
 b=lgK4HappRtr0Ut2EM3yk6ygaAVFEohw3py2wQ70yhpzg7jGDf/Velu7mWSzZLOlCBm
 Nae7XYNTTnslY/Nc0MtQDwYHGmppA+XdasPHeLwYfd23KqDDFYTlUPcu+5nrHhtDf+PS
 7FeiN+YRUrPvnzkSP+lu/D7bYbrFxVAKblWeCyxTFrejvTSY2ohed6lCt1DoG3UbffLh
 s9IB/1ZhHroeTbu63tH2d2BJrPZVa+x45ml/x+6X5eKTtxNZUguycofAPC4Qyy9B3AkT
 U8pRamXWXpO9SvH4YmjmzwKCQIRJfLdvp/qy8UY2/oBYGmhzGvwnlqyq/hrVId15zjlj
 X0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265599; x=1719870399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJX5RhwWGDdrpnAtg3eu17Ph2P7mi53gQC+5L1tt27k=;
 b=jhNN200izAKXpFUrW5mKand0HItUybC7s0DahaamK/22cCuUBr6qkvQn8EAITiIBzk
 KtDpbSLMCTf/UNtEHbwi7nw/OCheV6UByzOvDKORRcr2Dphg4k7moqxM0uXEILxGdW0E
 7gTS1Xhzoak16ikxcJGWUcpUHnIDKs0gOqEYt5zSJO9a1i7kjPk3PHRR/BD2UDV42oKV
 8iRANEFTo6MFkDbDxs4dPaZFGVnMH4NvDpsH9R7bM5ix9pKTKwjIrEk5SvWkM7Lc9N1J
 xmTCnQgoAgc3690u6Q1v0DW3vOqpnK3JrllC8zW6qtRQcJateWDeVsDlQVkb/KVjf2H2
 SHeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURD3PJpPf6fxOEcqpehr3fHrxpPny+O3DN2fY5Ou+wvwza+tyc7t9ddzIafMAbzSL0w2eAdNS6+KReOprX9rSMmrsfoQ==
X-Gm-Message-State: AOJu0YwZCGwumumvEzmXX7joFNvGNDuxmQ/qae6rZV5D5EdkwSIPh1SW
 K0xq5eDZBNH8JgUmH7snAf5zbY2mmVpu8oqe7+SUTdPSHdtOJP/W
X-Google-Smtp-Source: AGHT+IHP+xrYkg/sI01AXS7y7/pLdm63OKm7HbjGsqzgfPTofGPtbK3T57nWn/UF3MY333xr8vTWyA==
X-Received: by 2002:a50:d653:0:b0:57d:3b8:85e6 with SMTP id
 4fb4d7f45d1cf-57d4bddfba2mr4257717a12.39.1719265599562; 
 Mon, 24 Jun 2024 14:46:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 4/9] common: board_r: rework BOOT LED handling
Date: Mon, 24 Jun 2024 23:46:14 +0200
Message-ID: <20240624214626.24336-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624214626.24336-1-ansuelsmth@gmail.com>
References: <20240624214626.24336-1-ansuelsmth@gmail.com>
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
index c823cd262f1..6a4dacdea88 100644
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
@@ -463,14 +464,30 @@ static int initr_malloc_bootparams(void)
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
@@ -717,6 +734,7 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CONFIG_LED_STATUS)
 	initr_status_led,
 #endif
+	initr_boot_led_blink,
 	/* PPC has a udelay(20) here dating from 2002. Why? */
 #ifdef CONFIG_BOARD_LATE_INIT
 	board_late_init,
@@ -739,6 +757,7 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CFG_PRAM)
 	initr_mem,
 #endif
+	initr_boot_led_on,
 	run_main_loop,
 };
 
-- 
2.45.1

