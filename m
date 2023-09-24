Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC4ACE7A88
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 13:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41FD9868D1;
	Sun, 24 Sep 2023 15:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZRC/+cpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239948656B; Sun, 24 Sep 2023 12:21:39 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3538C86488
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=okhunjon72@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50307759b65so7532187e87.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695550896; x=1696155696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfBgi/qO6kQVNQgQpHeC9mSlpdhJMtEFxHbUzJTrsLM=;
 b=ZRC/+cpdLiKTqxYA/jeJEuFTegrwljUKut08Lhf1yPi+F7RFXeeElsVXhiLEsQLZG1
 Rx5Fe12kAfSiG6kah1nCPxOLV0sLLKu5cHP6JwF/OgC7HcTaBpATZ9/r5IIUsVpdGB9j
 utZTK110Jy5olu0YYryFyVJ/junKgIyA2hI6GVWwJqGHnG2wYCCXVCxy5k7icuN3Vrj1
 sj4FTim6PT6O0jqmuOLwjefa2c2ar0OnqoDdtwvS2X9kJDFCLCSoxXdx0mUFmFSzFM/D
 1IHkcktLon7C9HT14GZPnHeiTHqbbuBfUwMUhrdgTjPt5pzRAm1eU+PkZm4l8A5LImuD
 fmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695550896; x=1696155696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfBgi/qO6kQVNQgQpHeC9mSlpdhJMtEFxHbUzJTrsLM=;
 b=J2KVYEAtfDx8QXVgK8wE7teuvwtzIqsLL2feRLN8fXPbJIyyJkgI6RYM/672MTk5KY
 fte4BcPXnc8Zp06+Ojzkme9iCa4UZ0p7j81iAMouBLpnXpTBjeovEE1n3tnGgKhDDP//
 BIj2tHNrP1p1S7Ek+KL8TCKuN6blwEx9y9xSwWC+AqiY58bugllQ8zcjulPDdIs7Gdgi
 vzMMgZC9vxPWbhIO+9gOMzxGtT2ONi8jyjZ4TEi/0yhwEV4deYukkZ32ZHAULa+HKuHU
 H4G/oJzH0DkA/Qv7mCGUKoj9qSFVjLO/hF7xg13oM3MmCrBXa5jahrmkdybPYmjcFzDC
 pU0g==
X-Gm-Message-State: AOJu0YzFvESJfZFgfgRwBU0b7Vk12UGrM7SvGq3Go1IDroNxcljx19uS
 xbUcY1tNgDpYwtwkwYVojhA=
X-Google-Smtp-Source: AGHT+IF2/u77Iua+9XxcBxfkuh4eJ7KCXoJ+Z6IvEFoWpSRFBnkdfYnzdtQs7n7H8IW9bSFkmi9jTA==
X-Received: by 2002:a05:6512:3e1f:b0:500:daf6:3898 with SMTP id
 i31-20020a0565123e1f00b00500daf63898mr4119943lfv.26.1695550896166; 
 Sun, 24 Sep 2023 03:21:36 -0700 (PDT)
Received: from okhunjon.localdomain ([94.158.55.47])
 by smtp.gmail.com with ESMTPSA id
 ep30-20020a056512485e00b00500cede2786sm1391435lfb.65.2023.09.24.03.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 03:21:35 -0700 (PDT)
From: Okhunjon Sobirjonov <okhunjon72@gmail.com>
To: andre.przywara@arm.com,
	jagan@amarulasolutions.com
Cc: u-boot@lists.denx.de, Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Okhunjon Sobirjonov <Okhunjon.Sobirjonov@Mec-electronics.com>
Subject: [PATCH] sunxi: R528: add SMHC2 pin pull ups support
Date: Sun, 24 Sep 2023 13:21:16 +0300
Message-Id: <20230924102116.59856-1-okhunjon72@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721134606.4505-1-andre.przywara@arm.com>
References: <20230721134606.4505-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 24 Sep 2023 15:26:35 +0200
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

