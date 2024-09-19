Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47642CF3958
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C181E88FCA;
	Thu, 19 Sep 2024 16:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LGARBBBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED28988BBC; Thu, 19 Sep 2024 16:38:50 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 103A988FCA
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5365a9574b6so1527546e87.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726756728; x=1727361528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kcBE8bX6dY2Z3/eYeKOgP8rq12G942sz9/Gh6O1VYGI=;
 b=LGARBBBKQKEFfwekHnPWjPakLYSZmRwdKAzLtHUfNQ5E9eMWwArgo/0UbHu/lgUhJG
 A63QgH8pVox9AsdNscAEuCBMboh8TBDQRJfImQzKBaYTcmEReLarsoLWJ3aJIFMtITpu
 jCyE2Rma8BvsZ/ZMO8mKl3xqT17ck0cFvEiH2laVpnGheCRtbgShxBz1QR5EX1n9aZsu
 zwEzSKDEKY6FDaQZHNH1A3RFAIM3TSVhcm/Ub0l4IgmTrvuURGbVnKpumz11i8b1w1BU
 NaOlXuTjYMtbC8+4Imz9ltzLEt06yco3hMLRSDgA2SVlfVoVj6Y/k4W7hITv48pYbwTJ
 bR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726756728; x=1727361528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kcBE8bX6dY2Z3/eYeKOgP8rq12G942sz9/Gh6O1VYGI=;
 b=Ye1WYZRd2zPcdrZPxiNpGABS6GhO7jK4dLAPK++yJxgxhkTmAkpHYhoiU2kQC56nT+
 0pUVA3jo/1KfiyqWvdhTxOPzQ5KFWWZRigsOxt1N2Hd0FTWBZ9nYRcndozpIFg7YjBel
 ytc8lFsw/jZ+V7ZokuTqqJW4l93GYU/D0R87uhACbVAAWyzi1KI0NZ8QRaOzStvGE6OX
 G9QXdbAThjz6987dmZdoMSzvmAbrK4wwSS7RaW4ggSzuJ3jk2E5YCMHgavd1tNcVnh6y
 pmRWv9exfQM18rIUy4d0sTHC3vcslaKYAol99Z8PLJSGz5C1qnVTPIb4rHzRV7RsvVNN
 /sNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAIrLp7LtRwTPk5ij8K6uXQgzWKU9diqZ9OpHZD5VvY734jt3B8S4l5E+lyUFMQm/j1fm0r7c=@lists.denx.de
X-Gm-Message-State: AOJu0YwYHF5qLbBI2TV5gC9lxXWGscaDMtozgmgmwBSW0lhGH350Az0D
 DPV3uRioERigeRfJAq3HbT6u1b/qW2wykN2UsYDkr50+FywI0ue5
X-Google-Smtp-Source: AGHT+IFzk7pGy0Y01vD/rkrS/+vk/z0RM0L7391xdDuQMr+nkGsjUpsEIVJsCGiFYY6R+Bnta5RnmA==
X-Received: by 2002:a05:6512:4017:b0:536:73b5:d961 with SMTP id
 2adb3069b0e04-5367ff32c2cmr16987947e87.54.1726756728090; 
 Thu, 19 Sep 2024 07:38:48 -0700 (PDT)
Received: from wpc.. (host-95-152-62-174.dsl.sura.ru. [95.152.62.174])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870466afsm1831795e87.8.2024.09.19.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:38:47 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de
Subject: [PATCH v1] gpio: mcp230xx: add missing header for udelay()
Date: Thu, 19 Sep 2024 17:38:37 +0300
Message-ID: <20240919143839.174966-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Since GCC 14 -Werror=implicit-function-declaration is enabled by default.
This leads to following compilation error:

  drivers/gpio/mcp230xx_gpio.c:57:9: error:
    implicit declaration of function ‘udelay’
    [-Wimplicit-function-declaration]
      57 |         udelay(1);

Add missing header to fix this error.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/gpio/mcp230xx_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/mcp230xx_gpio.c b/drivers/gpio/mcp230xx_gpio.c
index 42e7fe9d47..b6f533b130 100644
--- a/drivers/gpio/mcp230xx_gpio.c
+++ b/drivers/gpio/mcp230xx_gpio.c
@@ -14,6 +14,7 @@
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <linux/delay.h>
 
 enum mcp230xx_type {
 	UNKNOWN = 0,
-- 
2.45.2

