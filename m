Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CE3E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D6288C86;
	Sun,  3 Nov 2024 01:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P44R7obA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E493A890C1; Sun,  3 Nov 2024 01:38:16 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE06E88C86
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cbca51687so29213065ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594293; x=1731199093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBxNnzLMJWYC9vtI5BNUtoeWvQmYv36CW8LIgAwwRFM=;
 b=P44R7obAGgALOu6gby7RGEXFcAubiw+20kJjwPOzf+Xq/qElOZldgRLy7OIkV+1NpO
 K20uU5uFT/alcscY17vElcnnm3PUVq8zEbW7XSZHzIWz0jHYDoW4XrkTCtRcUnXfcsZb
 V3xauODQ05DGGJeAa6gCgMKgy/03cdXk/H4Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594293; x=1731199093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBxNnzLMJWYC9vtI5BNUtoeWvQmYv36CW8LIgAwwRFM=;
 b=tkLX8yMlxatvtd/2V+8J6bhvrO3+JGhU+n2K98SrMu+r5Ln7GPsfIm4MXT3v1Y7c/k
 Y1mqY/4TQ/HefsaUaccU2uziZufXiwS02qLT6GCN8ipVkTmYyQPuDzLquhlfgZJCrzhk
 CMtpz64OC6tbkq9SUyILU9JGZfcROobNeVMMdal9AibSlmYL6zod14W3jWTNMV/2q486
 7t3SfYUgLjam9ZbMpxNYwB0D/StbaJs/RB7hJlIQj5y1Fg3wGUbVEhFE9e9uFm0b61jn
 +8+ABKm/avU59nnoU2YQmFUyO6mS5/EiyPvSzejFXWkWaHof+ola+7106MigwjTo0s2z
 oXzg==
X-Gm-Message-State: AOJu0Yx2/w7DVByuOnzii5LBB+U+GdHIn616cf0P/PL1uUDvl7KBXM40
 dsTesAN/zSjPlkJ4Ek8QRLgmbZIA1X8kDnJ4SIFqdvGZOsC2otQLEPIkjozNFYSVrJ/w3OmPfkt
 TTA==
X-Google-Smtp-Source: AGHT+IGo2XPV+9SDxacweB+aXSMQOrg9nDpJ1fSImQja0cgI9IZb7ZH6jRuLrE8dONJ2mzLGObXzfw==
X-Received: by 2002:a17:902:e80a:b0:20c:8907:902 with SMTP id
 d9443c01a7336-2111af6eac9mr96299635ad.49.1730594292596; 
 Sat, 02 Nov 2024 17:38:12 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:38:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 19/25] common: Drop status-LED code in board_r
Date: Sat,  2 Nov 2024 18:33:11 -0600
Message-ID: <20241103003322.626036-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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
index 62228a723e1..caac092c8e7 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -53,7 +53,6 @@
 #include <pvblock.h>
 #include <scsi.h>
 #include <serial.h>
-#include <status_led.h>
 #include <stdio_dev.h>
 #include <timer.h>
 #include <trace.h>
@@ -459,29 +458,6 @@ static int initr_malloc_bootparams(void)
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
@@ -735,8 +711,6 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
 	timer_init,		/* initialize timer */
 #endif
-	initr_status_led,
-	initr_boot_led_blink,
 	/* PPC has a udelay(20) here dating from 2002. Why? */
 #ifdef CONFIG_BOARD_LATE_INIT
 	board_late_init,
@@ -759,7 +733,6 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CFG_PRAM)
 	initr_mem,
 #endif
-	initr_boot_led_on,
 	run_main_loop,
 };
 
-- 
2.43.0

