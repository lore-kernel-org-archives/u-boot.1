Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CA9C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3E788C28;
	Wed,  1 May 2024 04:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q8Jg+70v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8212988C6C; Wed,  1 May 2024 04:45:29 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF9488C10
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7f17efe79a1so492502241.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531526; x=1715136326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o19BGfMtvuUbilUTJ5MSfbQe7jzt1Yif7K0ZPrNUWF4=;
 b=Q8Jg+70vi/+Gzpr1/vdScN2RAsAo9ZEwj22omDNcgjXZJnR/87O26N8/qNmv6K0f6O
 853eEVseTRPx25sq2/Jm3GmMU6sl4QrU+xufk5iPfISET4JShxRdNv3mcpo2eJW9fqsp
 3in63twqpaeyNnhLRiTWglc819tjtmBUXgQJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531526; x=1715136326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o19BGfMtvuUbilUTJ5MSfbQe7jzt1Yif7K0ZPrNUWF4=;
 b=UgBymNENTGIF+CAwAteIg6k0MLXj9tm76PFmr7iuU138qKE3dzwARwd9TLO6vs/phY
 DzNQX+NcWrp3Saauw/DkxBUs3zkmHY9P1a53qXIgQR+FEfSrTShdsNehB+Rd7VgnATts
 2EarwWI+zBmWgaaifNiKwIyj+edoXyhry2X/rUazgLG17+PWRiTPgh4Ltj0A0IZCr+zX
 NwLGEEVV75u6C4MqXgariQDue9qgvtkb3zMDDSrSqgF+HLg8UMrl+/FDzFY3L0iDaJgw
 kpHK1WOX3fLzPP6oZ9bG0TmM6o8/EddvLY1PV76jLfbIYRWUuIYmaYnoKSOwJmh/T6D1
 yIzg==
X-Gm-Message-State: AOJu0Yw78BUMBqwfUE5FuUXm9m8isD3GPIuHghGUy6es8bp1cici/25T
 0zU9UKUUh2vUq0A+scfORDF4BDRKZ1QqPAgZMfDQkH1ohaYURNxQmbVLOF8bfHVAZQRlLok9rFW
 yZvjPEGrd
X-Google-Smtp-Source: AGHT+IEin/M5mivMS3p7WSKeebyqeD8JBF2h0cttOKvhwlN/ptT/3RrTepYhOHGPmsPm6mDXcD30dQ==
X-Received: by 2002:a05:6102:dc8:b0:47b:9fd6:233b with SMTP id
 e8-20020a0561020dc800b0047b9fd6233bmr1705313vst.31.1714531525618; 
 Tue, 30 Apr 2024 19:45:25 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: huang lin <hl@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 111/149] board: rockchip: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:38 -0600
Message-Id: <20240501024316.1767971-111-trini@konsulko.com>
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
Cc: huang lin <hl@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/include/asm/arch-rockchip/grf_rk3308.h | 2 ++
 board/rockchip/evb_rk3036/evb_rk3036.c          | 1 -
 board/rockchip/evb_rk3308/evb_rk3308.c          | 1 -
 board/rockchip/evb_rv1108/evb_rv1108.c          | 1 -
 board/rockchip/kylin_rk3036/kylin_rk3036.c      | 1 -
 board/rockchip/tinker_rk3288/tinker-rk3288.c    | 1 -
 6 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3308.h b/arch/arm/include/asm/arch-rockchip/grf_rk3308.h
index a995bb950d97..f4bbc2401310 100644
--- a/arch/arm/include/asm/arch-rockchip/grf_rk3308.h
+++ b/arch/arm/include/asm/arch-rockchip/grf_rk3308.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_ARCH_GRF_rk3308_H
 #define _ASM_ARCH_GRF_rk3308_H
 
+#include <linux/kernel.h>
+
 struct rk3308_grf {
 	unsigned int gpio0a_iomux;
 	unsigned int reserved0;
diff --git a/board/rockchip/evb_rk3036/evb_rk3036.c b/board/rockchip/evb_rk3036/evb_rk3036.c
index 8c606463e455..a0805030ea46 100644
--- a/board/rockchip/evb_rk3036/evb_rk3036.c
+++ b/board/rockchip/evb_rk3036/evb_rk3036.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/uart.h>
diff --git a/board/rockchip/evb_rk3308/evb_rk3308.c b/board/rockchip/evb_rk3308/evb_rk3308.c
index e0c96fd70a28..c895da934a99 100644
--- a/board/rockchip/evb_rk3308/evb_rk3308.c
+++ b/board/rockchip/evb_rk3308/evb_rk3308.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2018 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <adc.h>
 #include <asm/global_data.h>
 
diff --git a/board/rockchip/evb_rv1108/evb_rv1108.c b/board/rockchip/evb_rv1108/evb_rv1108.c
index 0d7a486bed74..48b9d8f80c4b 100644
--- a/board/rockchip/evb_rv1108/evb_rv1108.c
+++ b/board/rockchip/evb_rv1108/evb_rv1108.c
@@ -4,7 +4,6 @@
  * Authors: Andy Yan <andy.yan@rock-chips.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <syscon.h>
 #include <asm/global_data.h>
diff --git a/board/rockchip/kylin_rk3036/kylin_rk3036.c b/board/rockchip/kylin_rk3036/kylin_rk3036.c
index 0ca91cdeb014..c452b131208d 100644
--- a/board/rockchip/kylin_rk3036/kylin_rk3036.c
+++ b/board/rockchip/kylin_rk3036/kylin_rk3036.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
index e6e75981c2d1..e966e9f201ab 100644
--- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
+++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <i2c_eeprom.h>
-- 
2.34.1

