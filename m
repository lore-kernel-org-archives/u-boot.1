Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7172CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5759F88E36;
	Thu, 26 Sep 2024 22:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G6TE1f24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B1888E60; Thu, 26 Sep 2024 22:53:06 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F13088DFD
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb2dffcdbbso10744316d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383983; x=1727988783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z13QU8vEvU1bIUZdDWDzjMpoLrFWAolmaWx9D6dXDbI=;
 b=G6TE1f24eh/RkxqK5uPrwVFdUowYPWPfP8rKk/xGPe5PUfkhIAevje5b3lCrxgdQOf
 2p6kIO2Mf0zoVd+koNeOFtmz31JbXA1DjD2vRjl9ne9l/3ESNMfjbhyCiPn3fAHyTtXf
 ZJugz0ZQVlv4AAz8Os176ZgUDRwHHqBjHUniQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383983; x=1727988783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z13QU8vEvU1bIUZdDWDzjMpoLrFWAolmaWx9D6dXDbI=;
 b=Ggwv0/uugqfpI871/CDKcKnb+S0yJV1REYbrLFrFcvDXSDjzK49bQ4AkNnGr6L62FS
 /MST9GlNwVJyf+Qy6E+pM96HZjeFAJlhdUd4zXL81S8TxZ1nzmUh9dm8kz/ZHK+fDoFF
 ge+bXqIn8cWF87jInb2bXD497bNgsUjS+pTxzOA6vvUH/lYTah5wlDoB+dgDzg462RMg
 UD0k0xbH1pwvLeaXpvBs0MI1YNcylff9RLvC6tCZZkvGqY5PNw5vCWpmdDhELvIZ5hEF
 btZEWH9B0vb8ar9EsG24aamYKbcRK+mVueD0X+2qwGCT8auy8fQ9t8dBRAB9EdJUC7BQ
 ZS2g==
X-Gm-Message-State: AOJu0YwA06gMAQmEUeNMRkas6Vv4vME+5zbdcijOqVAOz0HApFNGYWBD
 sqRE8GETxkzHljspYNfHmu4kUKINNvFGrmg2BBTy4VjayshXB+S8sPXoEeAm0InDpogPCkrpYgO
 F7UwCTgY=
X-Google-Smtp-Source: AGHT+IEnV6AWjC7gg1B7bmSckqAJKKgtTrp0G4yA8H9SmhCrRfVsfuPdOKh/rNnXuhFBwJhmQWNzcQ==
X-Received: by 2002:a05:6214:3f86:b0:6c1:6bf9:8fea with SMTP id
 6a1803df08f44-6cb3b6a7706mr9148756d6.50.1727383983213; 
 Thu, 26 Sep 2024 13:53:03 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:53:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 22/27] common: Drop status-LED code in board_r
Date: Thu, 26 Sep 2024 22:44:42 +0200
Message-ID: <20240926204455.963584-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

 common/board_r.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 4faaa202421..b207c04e4d4 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -51,7 +51,6 @@
 #include <pvblock.h>
 #include <scsi.h>
 #include <serial.h>
-#include <status_led.h>
 #include <stdio_dev.h>
 #include <timer.h>
 #include <trace.h>
@@ -460,18 +459,6 @@ static int initr_malloc_bootparams(void)
 }
 #endif
 
-#if defined(CONFIG_LED_STATUS)
-static int initr_status_led(void)
-{
-#if defined(CONFIG_LED_STATUS_BOOT)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_BLINKING);
-#else
-	status_led_init();
-#endif
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_CMD_NET
 static int initr_net(void)
 {
@@ -724,9 +711,6 @@ static init_fnc_t init_sequence_r[] = {
 	interrupt_init,
 #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
 	timer_init,		/* initialize timer */
-#endif
-#if defined(CONFIG_LED_STATUS)
-	initr_status_led,
 #endif
 	/* PPC has a udelay(20) here dating from 2002. Why? */
 #ifdef CONFIG_BOARD_LATE_INIT
-- 
2.43.0

