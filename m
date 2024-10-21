Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A21D0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8179188F8A;
	Mon, 21 Oct 2024 13:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EP5AKpSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E972F88F28; Mon, 21 Oct 2024 13:39:00 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07AF4888D5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a5b2f2026so501918166b.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510738; x=1730115538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6lPGYgtc+6jQZ9TUbI9+VQGxMBaV4EQW1fljF9RDRo=;
 b=EP5AKpSCjZkz0xhZv9j6Tu5FIo8WqGXFth/UzuKN8Tu2OIcDakBGAsRVCx0YuFzwwv
 h+O9TmEnKqqOwJ6wW9lgj+rkTW59WldEGMq1X8vNDfSqrOYKxIE6efGIRKZ2vBtR0YcI
 7hKfukTBiOMHEh6MU1BoAznyQTipifmK0nlHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510738; x=1730115538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6lPGYgtc+6jQZ9TUbI9+VQGxMBaV4EQW1fljF9RDRo=;
 b=lVjIDQDrvzp/gjA7YGYaG5T8uMHONUcZMSN8mty+5UU5kVkJeeZgZeQe1MRWu+Ab2i
 D5Po3b3G17lGaaNCX7vakw4kYo2Hl6dH0Z+G5zyghlCx2foM7M+Qz2CMcFHTEPdFFpo+
 mle7yerVdTnth4IWlhCiAmWc0X+7wg+1BFtKdGguPGq7/eg/0PWp3XGtrpR66MyvgqfZ
 zeyOITyNo5QNoviJsV5AA0K9y0rpgz0xwI9zLydb6jSifoux4kvkhDbFpeDh49ptl/8B
 lg+uYLmkdHUF1LknAm+WsaGSP4Wge8hgjhJ/uF0ePXZUSchjN/Vw4Mn0qp5+QFIuHPeD
 3oXQ==
X-Gm-Message-State: AOJu0YyNP/sguwEhl7hwHiKW7EFBwrpKTc1nMzJ1MNwLYHCSAdbksFzQ
 qO19BYUOE3Cw7EaHKcEmUJ9bbbrvtUaOrRMmVgiYgpw8Msdum5jAV5keo+jrhtbUbAynDyfA4ll
 3iP9p
X-Google-Smtp-Source: AGHT+IGTRiDPmgvx9SP4AEiOiK5RpVCIaJjpKgk/y/RNiL0XYhM1AsZMo1jX81wlJlq0U6XVj/cbOA==
X-Received: by 2002:a17:907:7b85:b0:a9a:b70:2a7c with SMTP id
 a640c23a62f3a-a9a69a7627fmr1234083466b.25.1729510738198; 
 Mon, 21 Oct 2024 04:38:58 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 09/25] st: stm32f429: Drop old LED code
Date: Mon, 21 Oct 2024 13:38:17 +0200
Message-ID: <20241021113839.318572-10-sjg@chromium.org>
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

