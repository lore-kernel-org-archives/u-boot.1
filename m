Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF38DCDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3991788E0D;
	Thu, 26 Sep 2024 22:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G0ezV/XH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDDB88DFD; Thu, 26 Sep 2024 22:51:39 +0200 (CEST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D44B88E25
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-84e85014badso475124241.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383896; x=1727988696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o0M/jzd3kuSMdl37aZN/KWH+w6gY9cVknFemMIRx5A=;
 b=G0ezV/XHJQZM17urfehGlWF5KX8U9Py8xzV7YAgoXL7ngMSsxAfmhu/IDrMgskH47F
 QebP39WJ3G1xjKpZE4s/gR/4Qz2td/FICJEPf0HuGr+DYoWFjSvC6bczLVcsKMk1EeV9
 mmgYGRbVesHb7sL7D8MvEtsP1AIgco2CuIM9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383896; x=1727988696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o0M/jzd3kuSMdl37aZN/KWH+w6gY9cVknFemMIRx5A=;
 b=BEGNhALwdmmDlY8tN7evrd6V3abBbL3p3bgqRCMmb8s9oxWtZy+fOzU7KeWzcCM+X1
 bz/F96EWXy+OcIdlBRFMQtr7T4IVZluDhaq5Qy+9s8ZJNE39bx84pXoPlJnE9aWMgxg4
 Vpjvc1BfbdI8mgAN2jI8Bh5dfcCDONLSzSQcFXRyoTHWwcteyWNeSz6i9GwSjYiji8Bu
 iRl4IHiFt/e/Af41f5gxm+shLPG9mk6bgVL1Cmrn8LxTbI9RFx1tcFmrwylaXK335wnW
 WR1Qyvpo+Lv8Sn6PIbgYi1f9FFtdr5u+6gFaqJZFmyQbojOq7jqOZ7DJOsTQbnYiBltk
 jOcg==
X-Gm-Message-State: AOJu0YyDzIqdrGZC2va5qQraYWGrVtW6LfOy+mrh8iSdBqGEbyP5fDif
 pl0n6PGJy+H4hBzJN5qaLYmTMNIG55cUL2xaVwssH9ONlDXHYxvufLPsyV8IIQs4zf6jXjaD7Gp
 h1i/99Gs=
X-Google-Smtp-Source: AGHT+IEZm+PBZZ639C3qj/V7CJQj3Xzkzku72brYap2uYK/7rsS80jnv0dGOBKRLF/PC5jMzfbDgoA==
X-Received: by 2002:a05:6102:370b:b0:498:cce6:a10 with SMTP id
 ada2fe7eead31-4a2e1168db2mr1023864137.27.1727383896244; 
 Thu, 26 Sep 2024 13:51:36 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:51:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jens Scharsig <esw@bus-elektronik.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 17/27] eb_cpu5282: Drop status-LED code
Date: Thu, 26 Sep 2024 22:44:37 +0200
Message-ID: <20240926204455.963584-18-sjg@chromium.org>
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

 board/BuS/eb_cpu5282/eb_cpu5282.c | 20 --------------------
 include/configs/eb_cpu5282.h      |  6 ------
 2 files changed, 26 deletions(-)

diff --git a/board/BuS/eb_cpu5282/eb_cpu5282.c b/board/BuS/eb_cpu5282/eb_cpu5282.c
index c254da62bf4..cdd862c57d2 100644
--- a/board/BuS/eb_cpu5282/eb_cpu5282.c
+++ b/board/BuS/eb_cpu5282/eb_cpu5282.c
@@ -14,7 +14,6 @@
 #include <bmp_layout.h>
 #include <env.h>
 #include <init.h>
-#include <status_led.h>
 #include <bus_vcxk.h>
 
 /*---------------------------------------------------------------------------*/
@@ -160,25 +159,6 @@ int misc_init_r(void)
 	return 1;
 }
 
-void __led_toggle(led_id_t mask)
-{
-	MCFGPTA_GPTPORT ^= (1 << 3);
-}
-
-void __led_init(led_id_t mask, int state)
-{
-	__led_set(mask, state);
-	MCFGPTA_GPTDDR  |= (1 << 3);
-}
-
-void __led_set(led_id_t mask, int state)
-{
-	if (state == CONFIG_LED_STATUS_ON)
-		MCFGPTA_GPTPORT |= (1 << 3);
-	else
-		MCFGPTA_GPTPORT &= ~(1 << 3);
-}
-
 /*---------------------------------------------------------------------------*/
 
 /* EOF EB+MCF-EV123.c */
diff --git a/include/configs/eb_cpu5282.h b/include/configs/eb_cpu5282.h
index 26e4ade34ee..a4d1338c8fa 100644
--- a/include/configs/eb_cpu5282.h
+++ b/include/configs/eb_cpu5282.h
@@ -14,12 +14,6 @@
 
 #define CFG_SYS_UART_PORT		(0)
 
-/*----------------------------------------------------------------------*
- * Options								*
- *----------------------------------------------------------------------*/
-
-#define STATUS_LED_ACTIVE		0
-
 /*----------------------------------------------------------------------*
  * Configuration for environment					*
  * Environment is in the second sector of the first 256k of flash	*
-- 
2.43.0

