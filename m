Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5958AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 23:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443F3877EA;
	Tue, 12 Dec 2023 00:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eoGzmXwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85EED877C6; Tue, 12 Dec 2023 00:21:57 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F0BC877C6
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 00:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b9f727d94cso681283b6e.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702336895; x=1702941695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i87RhnjO8GZSHdEP0gaGe/4YhkfPRWoWKMbSvztmvCg=;
 b=eoGzmXwt/DUwRqZVw6IV8GpnytRG+KMzjAhc8P03ICHig9YjrfSJ7fR7HmA7DvAlYO
 sdS8wvqgzoc6Y+4VlZwZDzv7JrXbyHAoQnHQ4bI/y56rxvgeUN11rDaR/Io0iOmTrtCO
 fpTLClIhtod5RWZXuasW1WJlh6FzM0X2GKchNZTWwlsRAiv7RFoXEleHqRJPQU7aAhyb
 L9z3tuRrGihnN6DnZkpPU2UR4YXuEnOiVkqD49e0I2wpwRQnHO2lcB4zaNf6ByuTRJ8z
 ehVAn7aMbd6ouFE1pAJfxngGbw9+sZfUY5NQeRBf2xowDDXJWj83LG48f9SdxKS9xBI6
 a1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336895; x=1702941695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i87RhnjO8GZSHdEP0gaGe/4YhkfPRWoWKMbSvztmvCg=;
 b=u0OQ4k68x0W10V1D2f6BdsPy+c3yOmhU3odLHn5NiXcoAhQ5CwTraGDsJmxKvPBDqi
 hP5RuVuy973pExsT28O+lSlc1L10ALasAewh9OjskMiPemfE/fTDNci3Wp1ehipyk5+3
 HXhOX3PL+zxsyGHJPj/FHV3Wxm7FExxtY8izZzmMHgiwrUwvDuu30Gqe9XnJVCLUl2R2
 m8jvylicUXnNUUx6D/Kgqbr6woTXSxdLuOnRMmt5I3y+nMnMzF8au3pcf85VtoLsAEvt
 S7KMrJQMcO7Sni8RY7VVGnuJJdneq/UHgTRmGgZkNLRX34bW/2QKq9wsGKw37fC+vBme
 nIfQ==
X-Gm-Message-State: AOJu0Ywyts9CfJx5eAZCfBaeGuEUta6WSQ6w/0W+2Cnc7adZT6K8b72g
 JbUhsZdZCl9c39t4FhYl1Fb9/M1UdEk=
X-Google-Smtp-Source: AGHT+IEygxniXBlpEc2ncxhLpKEsyOk4jJnvPkrZAMAR2LwqAMNB7SETfwPbtnFkvZ0zhf4MyaGOEw==
X-Received: by 2002:a05:6808:1146:b0:3b8:b063:8938 with SMTP id
 u6-20020a056808114600b003b8b0638938mr3895863oiu.70.1702336894864; 
 Mon, 11 Dec 2023 15:21:34 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bl11-20020a056808308b00b003b9d0371517sm2059617oib.28.2023.12.11.15.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 15:21:34 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 5/7] rockchip: board: Add board_rng_seed() for all Rockchip
 devices
Date: Mon, 11 Dec 2023 17:21:23 -0600
Message-Id: <20231211232125.171438-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211232125.171438-1-macroalpha82@gmail.com>
References: <20231211232125.171438-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Allow all rockchip devices to use the hardware RNG to seed Linux
RNG.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/board.c             | 32 ++++++++++++++++++++++
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 29 --------------------
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 57f08e0be0..77145524ea 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -348,3 +348,35 @@ __weak int misc_init_r(void)
 	return ret;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_BOARD_RNG_SEED) && IS_ENABLED(CONFIG_RNG_ROCKCHIP)
+#include <rng.h>
+
+/* Use hardware rng to seed Linux random. */
+__weak int board_rng_seed(struct abuf *buf)
+{
+	struct udevice *dev;
+	size_t len = 0x8;
+	u64 *data;
+
+	data = malloc(len);
+	if (!data) {
+		printf("Out of memory\n");
+		return -ENOMEM;
+	}
+
+	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
+		printf("No RNG device\n");
+		return -ENODEV;
+	}
+
+	if (dm_rng_read(dev, data, len)) {
+		printf("Reading RNG failed\n");
+		return -EIO;
+	}
+
+	abuf_init_set(buf, data, len);
+
+	return 0;
+}
+#endif
diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 45854709f5..7bef5a53f0 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -17,7 +17,6 @@
 #include <mmc.h>
 #include <panel.h>
 #include <pwm.h>
-#include <rng.h>
 #include <stdlib.h>
 #include <video_bridge.h>
 
@@ -137,34 +136,6 @@ void spl_board_init(void)
 	       (GPIO0_BASE + GPIO_SWPORT_DR_H));
 }
 
-/* Use hardware rng to seed Linux random. */
-int board_rng_seed(struct abuf *buf)
-{
-	struct udevice *dev;
-	size_t len = 0x8;
-	u64 *data;
-
-	data = malloc(len);
-	if (!data) {
-		printf("Out of memory\n");
-		return -ENOMEM;
-	}
-
-	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
-		printf("No RNG device\n");
-		return -ENODEV;
-	}
-
-	if (dm_rng_read(dev, data, len)) {
-		printf("Reading RNG failed\n");
-		return -EIO;
-	}
-
-	abuf_init_set(buf, data, len);
-
-	return 0;
-}
-
 /*
  * Buzz the buzzer so the user knows something is going on. Make it
  * optional in case PWM is disabled.
-- 
2.34.1

