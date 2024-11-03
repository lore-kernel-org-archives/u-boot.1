Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1A3E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1F189169;
	Sun,  3 Nov 2024 01:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MrTr76zb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4809891AD; Sun,  3 Nov 2024 01:35:43 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D27BD89157
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-210e5369b7dso30764265ad.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594137; x=1731198937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6lPGYgtc+6jQZ9TUbI9+VQGxMBaV4EQW1fljF9RDRo=;
 b=MrTr76zbDDnkuvbB5pOuofrGZISfLO1PHWbZ95r1z6X5NjHNeokB5CpOHPHQm5xM9F
 TvKRIuT98/0wXCmjLYUgKJiC6s0CQQ3qK7WChWvMXQwOSYH63podRRRxcYFHh6LxpLTQ
 FMZ4uH/LXTxLIV3jDCBNd6gQDOgDRMs6NDvdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594137; x=1731198937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6lPGYgtc+6jQZ9TUbI9+VQGxMBaV4EQW1fljF9RDRo=;
 b=UCcjRDRQLkQOALUE0iuxtEFn93Z9Q+noRBZ40PyV7++R9V/IC2XR/Y02tidKR1/Grq
 HInn3XNz/xjCJ3wjqijwNw/3xvV/5xIWWySe6rZPeN7vrqE6Ccz/QhZqOAIFozL2NVY4
 R7b3cODC7xOJnSfNF/2Y4r97q6rcUcxwoK/HmZzOpZLnX+xeYDYUPXH+Yym9sc844Fuh
 2wHkobpCzZAtxan8dx7lYRl/dSWcZBVmP7okabxMFBC6EHVyj9s+lFl6iJEvw7fYNL+k
 3J4gDTRJrOMY+IdrlFbJ5G71IcL+1vzt+Js+vcadchrGvsIOtIIvsyIhUkDEyH40Qwdf
 E/tQ==
X-Gm-Message-State: AOJu0YypIFQZoFrInSwB8GWt91p3BiaD4ESuXtBGLx/yN4bUm2kDNPtu
 2FKVe2OzX0m07ceR5ZpoF2+kww7aTd7+oSyQ822p2IGj8CrR1QXIUxcSAFJxUTgJ2FgOGpU5RHv
 mzg==
X-Google-Smtp-Source: AGHT+IGkWLuX6ippWlPvGf7rzjNsydx0g+auB/UGfJgLHATHjnp55nyEiEjLO6m1BQYLH+cunXKlZw==
X-Received: by 2002:a17:903:2350:b0:20f:5443:9ec1 with SMTP id
 d9443c01a7336-2111af6c144mr109929445ad.33.1730594137424; 
 Sat, 02 Nov 2024 17:35:37 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:35:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 08/25] st: stm32f429: Drop old LED code
Date: Sat,  2 Nov 2024 18:33:00 -0600
Message-ID: <20241103003322.626036-9-sjg@chromium.org>
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

This predates the LED framework, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/st/stm32f429-discovery/Makefile |  1 -
 board/st/stm32f429-discovery/led.c    | 39 ---------------------------
 2 files changed, 40 deletions(-)
 delete mode 100644 board/st/stm32f429-discovery/led.c

diff --git a/board/st/stm32f429-discovery/Makefile b/board/st/stm32f429-discovery/Makefile
index 6b02c0fddec..233eafdad3d 100644
--- a/board/st/stm32f429-discovery/Makefile
+++ b/board/st/stm32f429-discovery/Makefile
@@ -7,4 +7,3 @@
 # Kamil Lulko, <kamil.lulko@gmail.com>
 
 obj-y	:= stm32f429-discovery.o
-obj-y	+= led.o
diff --git a/board/st/stm32f429-discovery/led.c b/board/st/stm32f429-discovery/led.c
deleted file mode 100644
index 4b8038341b9..00000000000
--- a/board/st/stm32f429-discovery/led.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2015
- * Kamil Lulko, <kamil.lulko@gmail.com>
- */
-
-#include <status_led.h>
-#include <asm-generic/gpio.h>
-
-#define RED_LED			110
-#define GREEN_LED		109
-
-void coloured_LED_init(void)
-{
-	gpio_request(RED_LED, "red led");
-	gpio_direction_output(RED_LED, 0);
-	gpio_request(GREEN_LED, "green led");
-	gpio_direction_output(GREEN_LED, 0);
-}
-
-void red_led_off(void)
-{
-	gpio_set_value(RED_LED, 0);
-}
-
-void green_led_off(void)
-{
-	gpio_set_value(GREEN_LED, 0);
-}
-
-void red_led_on(void)
-{
-	gpio_set_value(RED_LED, 1);
-}
-
-void green_led_on(void)
-{
-	gpio_set_value(GREEN_LED, 1);
-}
-- 
2.43.0

