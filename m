Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AF2CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB49588DDC;
	Thu, 26 Sep 2024 22:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FJ64KU/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C83388DDC; Thu, 26 Sep 2024 22:48:24 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBB088363
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c3603292abso10251386d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383700; x=1727988500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9CG6IbZBUWbZy/dZT3ria1L5MDEPanLUMQQV8PtW684=;
 b=FJ64KU/p1g074LSu7h96+71C6KcuAdQPfV0Iw4ir8bEIixIUHCc1tVwsODkNoJGfU5
 1/pjvwv+lg+KyKvysfIK1DOHIZluzgoGNjNJWRbeVCwOpCHIkaiqGL0RxRHM6hYjkb82
 zlR253R15mIvBQlPM9VXDzU98NFGRx7VbFDd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383700; x=1727988500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9CG6IbZBUWbZy/dZT3ria1L5MDEPanLUMQQV8PtW684=;
 b=ONntLczxaw0+ukasvwsJepR+CxmSDSjlfhoxwKhUOm8mLwJf9YBXTE2n/dOuUv7dsW
 9i/2Ik845EDsbPvy7KI9171MWU1odhDBHY6IcskELYA5AiJ2MFDXXlpwuyJflQi/Z+WD
 ZaoEWJuz8uk8eFadMHuM4ZnKPuG6dJDQ9UzHlMRNphCF2DS+UM8zwdzKAu1QjpNuW6hM
 rltqVwRza0XST7XVuWiYSGe5UxYbTPHd8QpuMTCIAAfkWBUWFVgLrRqF1LB9g/3v14RP
 ScMfV+rLlSOMggvUVmMMxftx/t7M5hXSWFYF0M79b1qkZOXQMCAMzmsGCtajRZHt59ar
 qh+A==
X-Gm-Message-State: AOJu0YzlWNhVYubP2E4t723oY2tRMVzeRPwkXomoE2EIsnd+k2DR/dUB
 l08jNasgblynDofNEzLtfC59dwh3595I85zSUb3KURizrn9qDIew9CNbBqscGqlXEbsyJ1bdrpi
 8zhk3rG8=
X-Google-Smtp-Source: AGHT+IFh14V1nsVLi2QeigrH/ovkwEVnOLrEBiqxaNE6H3WhpLIpbyl9ZmR9JQzvJCT05+sY9HmeTw==
X-Received: by 2002:a05:6214:4a8e:b0:6cb:2cfa:3b9e with SMTP id
 6a1803df08f44-6cb3b5e5023mr16955176d6.11.1727383700645; 
 Thu, 26 Sep 2024 13:48:20 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:48:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 04/27] st: stm32f429: Drop old LED code
Date: Thu, 26 Sep 2024 22:44:24 +0200
Message-ID: <20240926204455.963584-5-sjg@chromium.org>
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

This predates the LED framework, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

