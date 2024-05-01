Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE53BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBC088B72;
	Wed,  1 May 2024 04:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PI1RmdR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0D388B72; Wed,  1 May 2024 04:44:33 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9084F88B69
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7f169d3ef53so588758241.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531468; x=1715136268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ic8rt5c6z8/BwrRix31TJe5BV4lIhcdfTxkyKFZ80LY=;
 b=PI1RmdR8NMfO3z9mXONs2NvjcL0s2LddwzFNiGp7fADl7aaOW/4Vvjm2CYGR2FLYlt
 wBPUkUmVh/hwrA8CQob6jm6GaaMOVIxwPuuGcxMaCIH/FKfN65qYlIEB6ZAryGHHk8x/
 GkWjGPg12Zu2OMglBqeFDLDEwSSe5WoIe3u8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531468; x=1715136268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ic8rt5c6z8/BwrRix31TJe5BV4lIhcdfTxkyKFZ80LY=;
 b=eclVqnkKyNZaoWKaOovIjvA4H1Rzf0C9S6VQ0t9B/OFdXBaeV2lSyYfvz0r4aIpmvU
 ShMJvxwMIxmHIo1OHrdOQv6HCmyqeqkdV6aTTgk9ls/Ojjp4iZRQ7rau2YdyYRbYOmq2
 ccYtojcqJrgaDPXMR7JmE4VqrM3bxztFIDrj6esYsCrsV4ioaY5uQkiRm20vEbvwtTfz
 DfLnmvxfCSlKibZzlehRCPM9XKLYCc6iATSt03ds6MKId6ER7GewOO081rTs5IYNqkfx
 uwj0+fyHnj9OocBIQOh6fVAUmwL4WGHrHcF25ga4Ez/TVw48ZUMkkVtiWcuZn1GvWF5f
 W5Vg==
X-Gm-Message-State: AOJu0YzBsi7lGW5NJxeEjqYsYQ2H/9LjrcJU6Kjdahnn46IPRKUHxOrv
 ucsQknDMkU+d2fb1yHmym7yVSNzv8rubEQ1ijsJPdnl3lzdFpyIc6AGD2QzRJP4BwoPF5pE1rfy
 kTTnCrg==
X-Google-Smtp-Source: AGHT+IHtlQIzi8nP7JTLa/TLxIMYesfZj7g/mm8uji6dvlp7d+7I+UT1DG7mncYgaq8bmazUAE96Zg==
X-Received: by 2002:a67:ed11:0:b0:47b:cc56:7aa8 with SMTP id
 l17-20020a67ed11000000b0047bcc567aa8mr1755359vsp.1.1714531468082; 
 Tue, 30 Apr 2024 19:44:28 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH 060/149] board: firefly: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:47 -0600
Message-Id: <20240501024316.1767971-60-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Levin Du <djw@t-chip.com.cn>
Cc: Suniel Mahesh <sunil@amarulasolutions.com>
---
 board/firefly/firefly-rk3288/firefly-rk3288.c | 1 -
 board/firefly/firefly-rk3308/roc_cc_rk3308.c  | 1 -
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/firefly/firefly-rk3288/firefly-rk3288.c b/board/firefly/firefly-rk3288/firefly-rk3288.c
index 95d8b00924d8..8e67ab4b1327 100644
--- a/board/firefly/firefly-rk3288/firefly-rk3288.c
+++ b/board/firefly/firefly-rk3288/firefly-rk3288.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015 Google, Inc
  */
 
-#include <common.h>
 #include <hang.h>
 #include <led.h>
 #include <log.h>
diff --git a/board/firefly/firefly-rk3308/roc_cc_rk3308.c b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
index af00250e118d..404bdc632bbc 100644
--- a/board/firefly/firefly-rk3308/roc_cc_rk3308.c
+++ b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <adc.h>
 #include <asm/arch-rockchip/grf_rk3308.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index 590519b32af2..a149e4fe822e 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <log.h>
-- 
2.34.1

