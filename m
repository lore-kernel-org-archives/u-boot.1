Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B79BC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325D088C27;
	Thu,  2 May 2024 03:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uaXp/pV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8372688BF0; Thu,  2 May 2024 03:32:04 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B2ED88C05
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-439656c1b50so45047431cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613519; x=1715218319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2al+Pstt14Ku+fxFD4/JgLt6NUWM5aTEbGWICEfo40=;
 b=uaXp/pV9vgde2RrBA+lYzEm0f3AYEot7Wwjo4ibehUIIRCi5E2dma8IFCy8vLUWLSK
 7xlLJh6iWRmtceMG7QnGZ0OzguQXpIVtzljaQ2r+Ewv5J7Qx7EXF+Xkcg4qFC519N4xm
 WbHmDyI3bOe9Xtaj2/Fs/yHIAZHFuMjR33F8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613519; x=1715218319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2al+Pstt14Ku+fxFD4/JgLt6NUWM5aTEbGWICEfo40=;
 b=XEXixHIC/wgoMQDIt+hKNuPu/E/fhNEbsjwGVpad0ViltAcBNeT0gDxtmT3rtcQo30
 kMZuWpcHPFjoBBdz3ryKyHgImg9DZlHONTlDh7asNFUc9KbmTV9SMekdxYScImdFKan6
 4mFc4QyQAq1rYNtMQFumPxm7ckeeXrwPMpp4wPKIggIDLQYwRkSA0y1tSmHnHRJ0v160
 lI5Y/JUqNpF96xdSPQqeEM+9n+MxuGP50G9Ztz3L67sPSLAy6Zn8jueLtuD01j5g5Pn0
 KXc4lh7dC4EqKf0TrWNxBZ01BaPXIpgZjG6SOwwiUxiG19+Tuo9zc5Y7hBn+hQ8YRDY2
 IBkQ==
X-Gm-Message-State: AOJu0YxKZSL6NKKqUqQNctLh2u0TERpdSDl2s+kMmF1SF4bfVaA94Jdr
 U8wPujbzhqWY2tKTZAaDxuRYe+HuXYmdESy1EFsAITLdPgpyOGKDUqR3E6fODMkjhU0Rlzl0y79
 fINuXeIc+
X-Google-Smtp-Source: AGHT+IGZVS+hddQ9Ze2CMgCP+mYVRr9uE8OpT0rIlygVXY0/4NkoKvMYAAQOMZ4two9hWIDQ7DsD9A==
X-Received: by 2002:a05:622a:5488:b0:43a:b5e9:7df with SMTP id
 ep8-20020a05622a548800b0043ab5e907dfmr4788444qtb.24.1714613519632; 
 Wed, 01 May 2024 18:31:59 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 15/81] bootcount: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:32 -0600
Message-Id: <20240502013138.2383421-15-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/bootcount/bootcount-uclass.c | 1 -
 drivers/bootcount/bootcount_at91.c   | 1 -
 drivers/bootcount/bootcount_env.c    | 1 -
 drivers/bootcount/bootcount_ram.c    | 1 -
 drivers/bootcount/bootcount_syscon.c | 1 -
 drivers/bootcount/i2c-eeprom.c       | 1 -
 drivers/bootcount/pmic_pfuze100.c    | 1 -
 drivers/bootcount/rtc.c              | 1 -
 drivers/bootcount/spi-flash.c        | 1 -
 9 files changed, 9 deletions(-)

diff --git a/drivers/bootcount/bootcount-uclass.c b/drivers/bootcount/bootcount-uclass.c
index 5a369c82f1c5..0178c1818e59 100644
--- a/drivers/bootcount/bootcount-uclass.c
+++ b/drivers/bootcount/bootcount-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTCOUNT
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <bootcount.h>
diff --git a/drivers/bootcount/bootcount_at91.c b/drivers/bootcount/bootcount_at91.c
index c4ab5ceafabd..1a06db1fb740 100644
--- a/drivers/bootcount/bootcount_at91.c
+++ b/drivers/bootcount/bootcount_at91.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_gpbr.h>
diff --git a/drivers/bootcount/bootcount_env.c b/drivers/bootcount/bootcount_env.c
index b75c9002b2c0..960cd71b9d56 100644
--- a/drivers/bootcount/bootcount_env.c
+++ b/drivers/bootcount/bootcount_env.c
@@ -4,7 +4,6 @@
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
 
-#include <common.h>
 #include <env.h>
 
 void bootcount_store(ulong a)
diff --git a/drivers/bootcount/bootcount_ram.c b/drivers/bootcount/bootcount_ram.c
index 8cc30cf40eff..33e157b865a1 100644
--- a/drivers/bootcount/bootcount_ram.c
+++ b/drivers/bootcount/bootcount_ram.c
@@ -4,7 +4,6 @@
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
diff --git a/drivers/bootcount/bootcount_syscon.c b/drivers/bootcount/bootcount_syscon.c
index f80d87071d98..5dbc13cd5452 100644
--- a/drivers/bootcount/bootcount_syscon.c
+++ b/drivers/bootcount/bootcount_syscon.c
@@ -3,7 +3,6 @@
  * Copyright (c) Vaisala Oyj. All rights reserved.
  */
 
-#include <common.h>
 #include <bootcount.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/bootcount/i2c-eeprom.c b/drivers/bootcount/i2c-eeprom.c
index 709be094b118..12c430465c98 100644
--- a/drivers/bootcount/i2c-eeprom.c
+++ b/drivers/bootcount/i2c-eeprom.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2019 GE
  */
 
-#include <common.h>
 #include <bootcount.h>
 #include <dm.h>
 #include <i2c_eeprom.h>
diff --git a/drivers/bootcount/pmic_pfuze100.c b/drivers/bootcount/pmic_pfuze100.c
index df046f1b0ab0..8c529f5592b4 100644
--- a/drivers/bootcount/pmic_pfuze100.c
+++ b/drivers/bootcount/pmic_pfuze100.c
@@ -8,7 +8,6 @@
  * This works only, if the PMIC is not connected to a battery.
  */
 
-#include <common.h>
 #include <bootcount.h>
 #include <dm.h>
 #include <power/pmic.h>
diff --git a/drivers/bootcount/rtc.c b/drivers/bootcount/rtc.c
index 483caaa80df4..b131946aa9d1 100644
--- a/drivers/bootcount/rtc.c
+++ b/drivers/bootcount/rtc.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2018 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <bootcount.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/bootcount/spi-flash.c b/drivers/bootcount/spi-flash.c
index 03050e666134..155d0323ee78 100644
--- a/drivers/bootcount/spi-flash.c
+++ b/drivers/bootcount/spi-flash.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2019 GE
  */
 
-#include <common.h>
 #include <bootcount.h>
 #include <dm.h>
 #include <spi_flash.h>
-- 
2.34.1

