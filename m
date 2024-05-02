Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2C1C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6283D88C6B;
	Thu,  2 May 2024 03:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lX1YXrcY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2AF88C38; Thu,  2 May 2024 03:32:44 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A3F188C62
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-790e7c02430so378589285a.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613560; x=1715218360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4kPduWTXsqopZoVsh0u/PVyN8rRlmOxnS0537tamnw=;
 b=lX1YXrcYYca6wZoAs6tTnXsA8Cb6KJgKRUK/W/yjuWHVuoKbh7FFxrztCvrvEitQHZ
 KhTKeOAkp2jKjkIKupSVhTy4QiLXjamNnZNJA2Yzvvl4IAU+Pr8QgL20tUmPkkMX7kew
 lSfekhQ3G9n4BdsLv15UqvuCvmDTdcepgWVtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613560; x=1715218360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4kPduWTXsqopZoVsh0u/PVyN8rRlmOxnS0537tamnw=;
 b=GM0N2Ma8+KdgtmItBefDbPS3Dqq8XZosJ7f54ynziTpq7Fxd0Eq79mHUtks7Ou7qQu
 Gk29rDgNOr3OZk9tqlf7Zc8dshVPSsDuUNm0rId+X833miHMGZ895nf4PQPPgDpOA7SL
 FPVgZMA9Lv51y74LlRrmQ+MnsIWlq93dQ+RUYOFhdGsYLcIPSW5M/hF2OW3US3YR8Zb0
 x6LPWdO16zbAQd+ELNbEZDdZzxEy430j4XE4+HzMxdtv5qB2aXS2U0LmA57KxFuG2xmv
 ySdYMc3WHYkJFw09UXJP1WKCYD0SdYUr+gBBiPT2Ucd7b3k+zsYnNIvq8Uv/shr4MlBn
 /nMw==
X-Gm-Message-State: AOJu0Ywc2DLquT5/Qzw/bKU5Jf9CJfaNHOpLMxqoRYd4QSY42vFB8mZZ
 bVIgzlu+R7upTgPzhR3zysSro2mSCMXQMDharo29iufprW+AFTIZONtcDT5kXskEPH42Q97uQ9v
 LNEEWY2PD
X-Google-Smtp-Source: AGHT+IFNbWdUXaFFWXODN9Tnj/ZuBGJjfNte3okECz2An3hG0XlZr/dctWEuPMzWqkX5qf5KlWfRQw==
X-Received: by 2002:a05:622a:1650:b0:43a:c4e8:cb8c with SMTP id
 y16-20020a05622a165000b0043ac4e8cb8cmr626542qtj.64.1714613560377; 
 Wed, 01 May 2024 18:32:40 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Joel Peshkin <joel.peshkin@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Ivan Vozvakhov <i.vozvakhov@vk.team>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 38/81] led: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:55 -0600
Message-Id: <20240502013138.2383421-38-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Anand Gore <anand.gore@broadcom.com>
Cc: William Zhang <william.zhang@broadcom.com>
Cc: Kursad Oney <kursad.oney@broadcom.com>
Cc: Joel Peshkin <joel.peshkin@broadcom.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: Ivan Vozvakhov <i.vozvakhov@vk.team>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marek Vasut <marex@denx.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/led/led-uclass.c  | 1 -
 drivers/led/led_bcm6328.c | 1 -
 drivers/led/led_bcm6358.c | 1 -
 drivers/led/led_bcm6753.c | 1 -
 drivers/led/led_bcm6858.c | 1 -
 drivers/led/led_cortina.c | 1 -
 drivers/led/led_gpio.c    | 1 -
 drivers/led/led_pwm.c     | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index a4be56fc2584..f37bf6a1550c 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_LED
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
diff --git a/drivers/led/led_bcm6328.c b/drivers/led/led_bcm6328.c
index f59a92fb1fda..dcc5741195cd 100644
--- a/drivers/led/led_bcm6328.c
+++ b/drivers/led/led_bcm6328.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
diff --git a/drivers/led/led_bcm6358.c b/drivers/led/led_bcm6358.c
index 25aa3994d0e4..b1373ab74267 100644
--- a/drivers/led/led_bcm6358.c
+++ b/drivers/led/led_bcm6358.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
diff --git a/drivers/led/led_bcm6753.c b/drivers/led/led_bcm6753.c
index 2466d9301166..170caf7bdca7 100644
--- a/drivers/led/led_bcm6753.c
+++ b/drivers/led/led_bcm6753.c
@@ -6,7 +6,6 @@
  * drivers/led/led_bcm6858.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
diff --git a/drivers/led/led_bcm6858.c b/drivers/led/led_bcm6858.c
index 397dc0d8693d..a6efdcf64053 100644
--- a/drivers/led/led_bcm6858.c
+++ b/drivers/led/led_bcm6858.c
@@ -7,7 +7,6 @@
  * drivers/led/led_bcm6358.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
diff --git a/drivers/led/led_cortina.c b/drivers/led/led_cortina.c
index bcbe78d632ac..2d3ad323d33b 100644
--- a/drivers/led/led_cortina.c
+++ b/drivers/led/led_cortina.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
diff --git a/drivers/led/led_gpio.c b/drivers/led/led_gpio.c
index 71421de628c9..ce22fb49f2a9 100644
--- a/drivers/led/led_gpio.c
+++ b/drivers/led/led_gpio.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
index ae6de3087ab7..15dd836509b8 100644
--- a/drivers/led/led_pwm.c
+++ b/drivers/led/led_pwm.c
@@ -4,7 +4,6 @@
  * Author: Ivan Vozvakhov <i.vozvakhov@vk.team>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <led.h>
-- 
2.34.1

