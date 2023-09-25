Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1E1CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 03:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AB2A857AF;
	Mon, 25 Sep 2023 05:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dBoV4Qoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB7F8642A; Mon, 25 Sep 2023 05:43:37 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECEC81420
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 05:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=okhunjon72@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b95d5ee18dso92066271fa.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 20:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695613414; x=1696218214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfBgi/qO6kQVNQgQpHeC9mSlpdhJMtEFxHbUzJTrsLM=;
 b=dBoV4QoeJQyEU4LyvKD2j5ZN2JYHKB+00TRS8R/B6Yq1RpA5WLNLaSfqIZfVb4RLVn
 KzgqvgbQroxEmxP99/DeySbWXYjvyEkyUZAnIDN72CO0e81Wo/eEyVbVzkOTQR8JnXCO
 nXqeqUYlw+pgcq6nWXz1jNCQEOu9gQ7Bk4bXxVqWWMZ6P5cDKfO2Tgk7ifu2PqOUJeNO
 vpYt6iwNfc2yjBfzip3JAUciDHVJUl/er23iEj9TOMi2s7MdfVVMHA+hfjnP+hIQkdpi
 759yhwXLcjlCgUR/1P4dBORLNWO2ebn1z6t+i7FF0O24VNaRZvzD1slb5R9Qxiz2Owsg
 84KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695613414; x=1696218214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfBgi/qO6kQVNQgQpHeC9mSlpdhJMtEFxHbUzJTrsLM=;
 b=QzAvDnQye0Dm+z98yByKboyfiNQHW3DoDHucLG34Q8TyZs/xXLL1yOp7GFtbSDEgd+
 ob5n+sTqAkHH2/LF6Znjuy6SatVqvjpbjyB6QSpwNRKv0JJNrzfagxf8NIAYli5WbHTT
 8capEB7ywtv05qqUKTJ8te7wxnLKEhc1Kj0dXU8Ji4NZi/3HOqZqvZAbGU1pR0xA+GyB
 RsHwawrgiJX0it43GBVOoY0Zuq46eZMVfhkV6mKYD9O1Oi45PYDGCHDjS5O45Y40n6pP
 HduDYvA6mwLj0oZUvqDzywsp8vXCWMhSxRJdkcwClk+du/lRU6tMm/yJigU3qxk39g8V
 gj4w==
X-Gm-Message-State: AOJu0YwG3Fwr/Uho1+tI0S6cXdhIlmXwBndiXgoJuNGYkffL0MLL7uw5
 cikwBRi16JPFGuvqf/4VT9o=
X-Google-Smtp-Source: AGHT+IGdGWn0prGtam5q8W5Q8gbVuV1XsPZGLIiGDf8YeCg+NPNbesP6VJP5Ujhr927rjIw9k0JYRQ==
X-Received: by 2002:a05:651c:97:b0:2bc:d6d8:8ab5 with SMTP id
 23-20020a05651c009700b002bcd6d88ab5mr4336963ljq.24.1695613414105; 
 Sun, 24 Sep 2023 20:43:34 -0700 (PDT)
Received: from okhunjon.localdomain ([94.158.55.47])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a2e9842000000b002bffb3f8cebsm2024970ljj.54.2023.09.24.20.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 20:43:33 -0700 (PDT)
From: Okhunjon Sobirjonov <okhunjon72@gmail.com>
To: andre.przywara@arm.com,
	jagan@amarulasolutions.com
Cc: u-boot@lists.denx.de, Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Okhunjon Sobirjonov <Okhunjon.Sobirjonov@Mec-electronics.com>
Subject: [PATCH] sunxi: R528: add SMHC2 pin pull ups support
Date: Mon, 25 Sep 2023 06:43:28 +0300
Message-Id: <20230925034328.72371-1-okhunjon72@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721134606.4505-1-andre.przywara@arm.com>
References: <20230721134606.4505-1-andre.przywara@arm.com>
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

Added support for on-chip EMMC(SMHC2) pin pull ups
for sunxi R528 board. Otherwise, "No pinmux setup
defined for MMC2" appears. Moreover, adding
CONFIG_MMC_SUNXI_SLOT_EXTRA=2 to defconfig might be
needed in order to inform SPL code that another MMC instance on
top of the default 0 for booting should be considered.

Signed-off-by: Okhunjon Sobirjonov <Okhunjon.Sobirjonov@Mec-electronics.com>
---
 board/sunxi/board.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index f321cd58a6..764a1ea998 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -482,6 +482,13 @@ static void mmc_pinmux_setup(int sdc)
 			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
 			sunxi_gpio_set_drv(pin, 2);
 		}
+#elif defined(CONFIG_MACH_SUN8I_R528)
+                /* SDC2: PC2-PC7 */
+                for (pin = SUNXI_GPC(2); pin <= SUNXI_GPC(7); pin++) {
+                        sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+                        sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+                        sunxi_gpio_set_drv(pin, 2);
+                }
 #else
 		puts("ERROR: No pinmux setup defined for MMC2!\n");
 #endif
-- 
2.34.1

