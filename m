Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F1AD0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80AA989268;
	Mon, 21 Oct 2024 13:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c/AdudgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A71988F6F; Mon, 21 Oct 2024 13:39:02 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A3A88EBB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb4af0b6beso66624041fa.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510739; x=1730115539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ycrp9IOzXJ+/Tg69wI5pj6r6RKyG4SYJ8FcKJR7XiqY=;
 b=c/AdudgWRdqZHA1MejmYr2jgZuuoHq7XcfjVSVNrcf4yMupeOXIzjMSfyqBD/UXN9m
 fgJmLASo4736WUXW3jg/0xdbOES0Yv39yzC3XFkXhCt2yf2kVElf+gCqTEA6yPX5A9GD
 eZV5uHAphnZWK/CSLt0iRa/gpMcn8eWurGV2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510739; x=1730115539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ycrp9IOzXJ+/Tg69wI5pj6r6RKyG4SYJ8FcKJR7XiqY=;
 b=ufpZ5+FonedRsFPXJB926wvIZgnWleAL6+sqb9dLRn1TkOWcanhUmx6RZ/1A0sY3Ja
 ss43TjxgdozHIqBO7XppMLDein56m8IQ+EzoxDAI3I+CTtql733+aFwQcBQ/AeWvBgXC
 bIVtqx2pwIeiCeEf3MCIujAqxrGRFWkxK5EIho8DYEKWGJ1VlviEMLGiMaO+qxUSNP8n
 8hMfu9fctzlZEjGoBOmbaf1JGAQxKOyTI6ieL0chJn+faTSFXiUE47dMLJXeV7BUAD6h
 BlrJ3yhvQSLF/AiCbPwfAqMzqWG7xiIZtsYqcgI9ONox7S2+tNqlNI0gibo9C8ampUgZ
 EbkQ==
X-Gm-Message-State: AOJu0YxVtxGkHhUnoi+7P8zMtTedwW0UeuRy7k+FRWDthEbdQciW7tMt
 z/9733r6Lo7dbTtzAUcEb6/6JYCSYKqGMbMfOW/FA4RWMvKIk+y6omrwpjr3btUsD3/dPMG9lxw
 7VCs2
X-Google-Smtp-Source: AGHT+IHnRuu0JwR7PlZiEDyAU1FwKBjlEgQLm+P6l3hGnAOSby0GL04kEsQoWtU7gu/tQwSeh7rTaQ==
X-Received: by 2002:a2e:9fca:0:b0:2fb:5bd:8ff2 with SMTP id
 38308e7fff4ca-2fb82ea1dcdmr58982491fa.16.1729510739136; 
 Mon, 21 Oct 2024 04:38:59 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 10/25] led: Make the LED config common
Date: Mon, 21 Oct 2024 13:38:18 +0200
Message-ID: <20241021113839.318572-11-sjg@chromium.org>
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

Use an if...endif construct to avoid needing to make everything depend
on LED. Make SPL_LED depend on LED since that seems reasonable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/led/Kconfig | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 268118a6c3a..789113a92b5 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -9,6 +9,8 @@ config LED
 	  can provide access to board-specific LEDs. Use of the device tree
 	  for configuration is encouraged.
 
+if LED
+
 config LED_BOOT
 	bool "Enable LED boot support"
 	help
@@ -35,7 +37,7 @@ config LED_ACTIVITY
 
 config LED_BCM6328
 	bool "LED Support for BCM6328"
-	depends on LED && ARCH_BMIPS
+	depends on ARCH_BMIPS
 	help
 	  This option enables support for LEDs connected to the BCM6328
 	  LED HW controller accessed via MMIO registers.
@@ -46,7 +48,7 @@ config LED_BCM6328
 
 config LED_BCM6358
 	bool "LED Support for BCM6358"
-	depends on LED && ARCH_BMIPS
+	depends on ARCH_BMIPS
 	help
 	  This option enables support for LEDs connected to the BCM6358
 	  LED HW controller accessed via MMIO registers.
@@ -54,28 +56,28 @@ config LED_BCM6358
 
 config LED_BCM6753
 	bool "LED Support for BCM6753"
-	depends on LED && BCM6855
+	depends on BCM6855
 	help
 	  This option enables support for LEDs connected to the BCM6753
 	  HW has blinking and fading capabilities and up to 32 LEDs can be controlled.
 
 config LED_BCM6858
 	bool "LED Support for BCM6858"
-	depends on LED && (BCM6856 || BCM6858 || BCM63158)
+	depends on BCM6856 || BCM6858 || BCM63158
 	help
 	  This option enables support for LEDs connected to the BCM6858
 	  HW has blinking capabilities and up to 32 LEDs can be controlled.
 
 config LED_CORTINA
 	bool "LED Support for Cortina Access CAxxxx SoCs"
-	depends on LED && (CORTINA_PLATFORM)
+	depends on CORTINA_PLATFORM
 	help
 	  This option enables support for LEDs connected to the Cortina
 	  Access CAxxxx SOCs.
 
 config LED_LP5562
 	bool "LED Support for LP5562"
-	depends on LED && DM_I2C
+	depends on DM_I2C
 	help
 	  This option enables support for LEDs connected to the TI LP5562
 	  4 channel I2C LED controller.  Driver fully supports blink on the
@@ -83,14 +85,13 @@ config LED_LP5562
 
 config LED_PWM
 	bool "LED PWM"
-	depends on LED && DM_PWM
+	depends on DM_PWM
 	help
 	  Enable support for LEDs connected to PWM.
 	  Linux compatible ofdata.
 
 config LED_BLINK
 	bool "Support hardware LED blinking"
-	depends on LED
 	help
 	  Some drivers can support automatic blinking of LEDs with a given
 	  period, without needing timers or extra code to handle the timing.
@@ -99,7 +100,6 @@ config LED_BLINK
 
 config LED_SW_BLINK
 	bool "Support software LED blinking"
-	depends on LED
 	select CYCLIC
 	help
 	  Turns on led blinking implemented in the software, useful when
@@ -122,7 +122,7 @@ config SPL_LED
 
 config LED_GPIO
 	bool "LED support for GPIO-connected LEDs"
-	depends on LED && DM_GPIO
+	depends on DM_GPIO
 	help
 	  Enable support for LEDs which are connected to GPIO lines. These
 	  GPIOs may be on the SoC or some other device which provides GPIOs.
@@ -136,6 +136,8 @@ config SPL_LED_GPIO
 	  This option is an SPL-variant of the LED_GPIO option.
 	  See the help of LED_GPIO for details.
 
+endif # LED
+
 config LED_STATUS
 	bool "Enable status LED API"
 	help
-- 
2.43.0

