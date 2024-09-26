Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD53CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2504388DBC;
	Thu, 26 Sep 2024 22:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hv0EbWzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B72F88DF8; Thu, 26 Sep 2024 22:48:34 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6098688DF9
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cb22e9c6dbso8493516d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383710; x=1727988510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDrE5XnURyFWUhogFnQsnZJtUsj0X5Rgc24p45TWPfw=;
 b=Hv0EbWzAX8V5+19cl5hmrV3bjVspKbVxbT2PDCuklXoLDpIZKf1sJRLNbtRR5gIr3X
 qKAHJGraANtsymq+sSdVjXyLGqt8Ou1+WE3RE4wUzVPO8J/Ccp+/k+jVsTdXEjs27CSf
 1rN4wjJwLItd1Mf9ybBUrFkfP+5LhZHuvzZzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383710; x=1727988510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDrE5XnURyFWUhogFnQsnZJtUsj0X5Rgc24p45TWPfw=;
 b=prD81iTgZHUT/CwdykKwpd2m9He8HfrOpEdCOOKdgdcUgbicw93kQlZjjoCXRDiRMn
 MEMlK/CzGXhsrZ/lofpDpPJUXz3nBVfOX9+9B1883FjG918VtY+I/dxcRxanc7kvD9sW
 4f1Cd75H7nqDt+A1QDmu81fiUR2u93ntEzBtQFdhd+UG12LAalP9kXkEiq0BEsAxV1TF
 4hzbrOlhN7HMtory+OCzoadVugL947Kw7I3UHUSa93KMdGF2uw9TkGKxdzFZKyn3d+5X
 LlUNK/WeVGTEAG8pZcR6vv3dOp5gR5roD4UQz7l539RqXgXHtEYsFKR0aAhOD5q/qqQW
 lkrA==
X-Gm-Message-State: AOJu0Yxdk0LlduHHYCnB5UmF1j0rwnJQxg7NsyBIviGlRM/o+K7hOV1J
 SowfFfu1De8NZJ+omiHIX2ecl5CXUW2K9TvBPVRf3BUDS8T0TvCc7wEUoLgjdAPjuLY5Q+QvRYr
 BAIczVoA=
X-Google-Smtp-Source: AGHT+IHSp485dUCUuHN4p/i4DBJygnHqYYPr4GuhEhDl6/d7kE4kEbIY60HmeSEKAzYOeeB8Tdp3Zw==
X-Received: by 2002:a05:6214:3a8a:b0:6c5:517a:56d0 with SMTP id
 6a1803df08f44-6cb3b5caff8mr17903376d6.13.1727383709882; 
 Thu, 26 Sep 2024 13:48:29 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:48:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Doug Zobel <douglas.zobel@climate.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 05/27] led: Make the LED config common
Date: Thu, 26 Sep 2024 22:44:25 +0200
Message-ID: <20240926204455.963584-6-sjg@chromium.org>
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

Use an if...endif construct to avoid needing to make everything depend
on LED. Make SPL_LED depend on LED since that seems reasonable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/led/Kconfig | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 5c401f92080..32f0eade710 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -9,9 +9,11 @@ config LED
 	  can provide access to board-specific LEDs. Use of the device tree
 	  for configuration is encouraged.
 
+if LED
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
-	depends on LED && ARCH_BMIPS
+	depends on ARCH_BMIPS
 	help
 	  This option enables support for LEDs connected to the BCM6328
 	  LED HW controller accessed via MMIO registers.
@@ -22,7 +24,7 @@ config LED_BCM6328
 
 config LED_BCM6358
 	bool "LED Support for BCM6358"
-	depends on LED && ARCH_BMIPS
+	depends on ARCH_BMIPS
 	help
 	  This option enables support for LEDs connected to the BCM6358
 	  LED HW controller accessed via MMIO registers.
@@ -30,28 +32,28 @@ config LED_BCM6358
 
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
@@ -59,14 +61,13 @@ config LED_LP5562
 
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
@@ -75,7 +76,6 @@ config LED_BLINK
 
 config LED_SW_BLINK
 	bool "Support software LED blinking"
-	depends on LED
 	select CYCLIC
 	help
 	  Turns on led blinking implemented in the software, useful when
@@ -98,7 +98,7 @@ config SPL_LED
 
 config LED_GPIO
 	bool "LED support for GPIO-connected LEDs"
-	depends on LED && DM_GPIO
+	depends on DM_GPIO
 	help
 	  Enable support for LEDs which are connected to GPIO lines. These
 	  GPIOs may be on the SoC or some other device which provides GPIOs.
@@ -112,6 +112,8 @@ config SPL_LED_GPIO
 	  This option is an SPL-variant of the LED_GPIO option.
 	  See the help of LED_GPIO for details.
 
+endif # LED
+
 config LED_STATUS
 	bool "Enable status LED API"
 	help
-- 
2.43.0

