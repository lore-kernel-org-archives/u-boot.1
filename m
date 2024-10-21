Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4E4D0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E291F89321;
	Mon, 21 Oct 2024 13:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OeH4+sbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD3488F28; Mon, 21 Oct 2024 13:39:13 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C980A88F6B
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso591571966b.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510749; x=1730115549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyAO1hnbfYBzFneQT56s9G+ldjB5bX2s9kSQp5Xx7Ak=;
 b=OeH4+sbe/lvBo1NS8kuJa9aI3WprJVjv+DR+Nv1+zT6U4tjzO1vTwb4bXQZ2mGTAj1
 N7qZVSst0mNpAM/aumW7wI9tUeQl39DcoX7HfhXXmg07xInGJU6J7ovWS8NySpj8TkCb
 RjK+fVaYsdOCtM2/MpugYALL9PtzalE6trXYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510749; x=1730115549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyAO1hnbfYBzFneQT56s9G+ldjB5bX2s9kSQp5Xx7Ak=;
 b=VEfNkkdFZV94z6cCJ3sqniDa3Zz7qJzP3tp4A0md3pZGXK9Trmsobcg96m5/aOE2me
 Xv/pYdbTp7eW4CXhdJ4K3L7Y9neBSh96uzZVp4XcbY+/YYOgiIobUkNbm/RqPDb8qaRT
 p8avcdgmaHKQyVvZ8Ms3EomFX5pqkF2+IUC2KZj5o53KBa0FQam/CrORGGZS1OUCfIvH
 O50UyFhEojJhfJrvDW3TEyjFP/DnplpsDJ+kEHB/W6ucMzkafev2dfovik52kQPX3P4w
 vFN6xvUv1iPrKIKRzQ8KFh8LY3Ye6uDCGJcwJdu2R0HI5HAhD0puvnSm4Amo3RNkPGhm
 vuPA==
X-Gm-Message-State: AOJu0Yy+wj8bsZb+0GkMbFzUqsjHZU3CsVmfRzG/HBxh9e74qV74wpyN
 iFN4qDVM/4iHi3RL7+QMS5UjFsWRPhb49feMIibDvjZLHUC0Se5T+GOm0EFDvno2MC9k17Ib255
 xEVqM
X-Google-Smtp-Source: AGHT+IEOQIMteUtpvlYo6wt3vHClXVImyJ23foR5bk1g09X0AVdrZmqhA9eXoyRQBvQPr945z6r9Cw==
X-Received: by 2002:a17:907:9712:b0:a99:f466:a87a with SMTP id
 a640c23a62f3a-a9a69a63eedmr1148859366b.3.1729510748965; 
 Mon, 21 Oct 2024 04:39:08 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Artur Rojek <artur@conclusive.pl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 20/25] common: Drop status-LED code in board_r
Date: Mon, 21 Oct 2024 13:38:28 +0200
Message-ID: <20241021113839.318572-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_r.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index e5f33f40643..70ffd3497ab 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -52,7 +52,6 @@
 #include <pvblock.h>
 #include <scsi.h>
 #include <serial.h>
-#include <status_led.h>
 #include <stdio_dev.h>
 #include <timer.h>
 #include <trace.h>
@@ -461,29 +460,6 @@ static int initr_malloc_bootparams(void)
 }
 #endif
 
-static int initr_status_led(void)
-{
-	status_led_init();
-
-	return 0;
-}
-
-static int initr_boot_led_blink(void)
-{
-	status_led_boot_blink();
-
-	led_boot_blink();
-
-	return 0;
-}
-
-static int initr_boot_led_on(void)
-{
-	led_boot_on();
-
-	return 0;
-}
-
 #if defined(CONFIG_CMD_NET)
 static int initr_net(void)
 {
@@ -737,8 +713,6 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
 	timer_init,		/* initialize timer */
 #endif
-	initr_status_led,
-	initr_boot_led_blink,
 	/* PPC has a udelay(20) here dating from 2002. Why? */
 #ifdef CONFIG_BOARD_LATE_INIT
 	board_late_init,
@@ -761,7 +735,6 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CFG_PRAM)
 	initr_mem,
 #endif
-	initr_boot_led_on,
 	run_main_loop,
 };
 
-- 
2.43.0

