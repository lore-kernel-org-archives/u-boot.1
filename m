Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78028D0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10F58904B;
	Mon, 21 Oct 2024 13:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eG02bdt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEF288F82; Mon, 21 Oct 2024 13:39:03 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA81E888D5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so605971666b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510740; x=1730115540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dpmhzd4cwnqvo5o5lCifZV+3oRAHCEtFw6tykX1rN40=;
 b=eG02bdt/LA5pnPcZCuFQoeEMj49Z/iSbrWSIQm/vo3tNQOJsfposHxOf8eqphAfT7S
 RGakcDZvGt0Ex3KgkbIVnv2jUj9BKyo0Ib5HaZqf8f0msRzxw5O3M5TiZM0y551sT7Jy
 Flgcv61vpGA2XRuleHhUm/2cu1/UYOSOQwZaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510740; x=1730115540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dpmhzd4cwnqvo5o5lCifZV+3oRAHCEtFw6tykX1rN40=;
 b=NWAh0daL0ZMIgxyRLToMrK68VjcFPFM9ToKrA8hDwKVJ1A15cPrJaNhGNusQu1JGGx
 eLOYJykcWXqTYQhWwGLxn2VzvS9JluotAvi7tfdu3Cr9mNMZUFUZ+Z3rVuCQnPwGeimF
 fjLpp6d+82GzFKZFwz4Tfc+dXU3tGRWoi6dfRq999aBAf6/D3HdFlzFZp7DzH1AN7aNN
 qO+EOgWvjbOILIwNbfKU+71upokDufuPlC2YMCZhf1/D5uLEXy1Xw1fVUq0ILSUu4M8/
 YVBhabg/dOodHB4sKJYq6YZuBhzwVydkIbUrO9STIshiseKhyqgvezKx3MzAbSdFDzrM
 7hlw==
X-Gm-Message-State: AOJu0YycOxnCfqluoWCuKttZ242ZZj9lmjIF+3qA8IQMzmVK/hjIs0CR
 HU7Kspu2x4a23vENGqD06SB4xtWUnKSd313Kph26LyTIGIlpLTgKlRbNUGQhQaUbCJQv784UxRt
 +mPWt
X-Google-Smtp-Source: AGHT+IHxPFVpoUjROUmdfOa39DChKmYmOM0xb73FYgXjkqJ6ouI+BxxfDIdMEo9Qov1ISogUGAzr0A==
X-Received: by 2002:a17:907:1b84:b0:a9a:8042:bbb8 with SMTP id
 a640c23a62f3a-a9a8042c99cmr543850966b.47.1729510739957; 
 Mon, 21 Oct 2024 04:38:59 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 11/25] led: Drop LED_STATUS from Kconfig
Date: Mon, 21 Oct 2024 13:38:19 +0200
Message-ID: <20241021113839.318572-12-sjg@chromium.org>
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

Drop all of these configs, which are now unused.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/led/Kconfig | 316 --------------------------------------------
 1 file changed, 316 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 789113a92b5..379b3ce49a5 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -138,320 +138,4 @@ config SPL_LED_GPIO
 
 endif # LED
 
-config LED_STATUS
-	bool "Enable status LED API"
-	help
-	  Allows common u-boot commands to use a board's leds to
-	  provide status for activities like booting and downloading files.
-
-if LED_STATUS
-
-# Hidden constants
-
-config LED_STATUS_OFF
-	int
-	default 0
-
-config LED_STATUS_BLINKING
-	int
-	default 1
-
-config LED_STATUS_ON
-	int
-	default 2
-
-# Hidden constants end
-
-config LED_STATUS_GPIO
-	bool "GPIO status LED implementation"
-	help
-	  The status LED can be connected to a GPIO pin. In such cases, the
-	  gpio_led driver can be used as a status LED backend implementation.
-
-comment "LEDs parameters"
-
-config LED_STATUS0
-	bool "Enable status LED 0"
-
-if LED_STATUS0
-
-config LED_STATUS_BIT
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT is passed into the __led_* functions to identify
-	  which LED is being acted on.  As such, the chosen value must be unique
-	  with respect to the other CONFIG_LED_STATUS_BIT's. Mapping the value
-	  to a physical LED is the responsibility of the __led_* function.
-
-config LED_STATUS_STATE
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ:
-	  LED_STATUS_PERIOD = CONFIG_SYS_HZ/LED_STATUS_FREQ
-	  Values range: 2 - 10
-
-endif # LED_STATUS0
-
-config LED_STATUS1
-	bool "Enable status LED 1"
-
-if LED_STATUS1
-
-config LED_STATUS_BIT1
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT1 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE1
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ1
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ1:
-	  LED_STATUS_PERIOD1 = CONFIG_SYS_HZ/LED_STATUS_FREQ1
-	  Values range: 2 - 10
-
-endif # LED_STATUS1
-
-config LED_STATUS2
-	bool "Enable status LED 2"
-
-if LED_STATUS2
-
-config LED_STATUS_BIT2
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT2 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE2
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ2
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ2:
-	  LED_STATUS_PERIOD2 = CONFIG_SYS_HZ/LED_STATUS_FREQ2
-	  Values range: 2 - 10
-
-endif # LED_STATUS2
-
-config LED_STATUS3
-	bool "Enable status LED 3"
-
-if LED_STATUS3
-
-config LED_STATUS_BIT3
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT3 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE3
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ3
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ3:
-	  LED_STATUS_PERIOD3 = CONFIG_SYS_HZ/LED_STATUS_FREQ3
-	  Values range: 2 - 10
-
-endif # LED_STATUS3
-
-config LED_STATUS4
-	bool "Enable status LED 4"
-
-if LED_STATUS4
-
-config LED_STATUS_BIT4
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT4 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE4
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ4
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ4:
-	  LED_STATUS_PERIOD4 = CONFIG_SYS_HZ/LED_STATUS_FREQ4
-	  Values range: 2 - 10
-
-endif # LED_STATUS4
-
-config LED_STATUS5
-	bool "Enable status LED 5"
-
-if LED_STATUS5
-
-config LED_STATUS_BIT5
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT5 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE5
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ5
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ5:
-	  LED_STATUS_PERIOD5 = CONFIG_SYS_HZ/LED_STATUS_FREQ5
-	  Values range: 2 - 10
-
-endif # LED_STATUS5
-
-config LED_STATUS_BOOT_ENABLE
-	bool "Enable BOOT LED"
-	help
-	  Enable to turn an LED on when the board is booting.
-
-if LED_STATUS_BOOT_ENABLE
-
-config LED_STATUS_BOOT
-	int "LED to light when the board is booting"
-	help
-	  Valid enabled LED device number.
-
-endif # LED_STATUS_BOOT_ENABLE
-
-config LED_STATUS_RED_ENABLE
-	bool "Enable red LED"
-	help
-	  Enable red status LED.
-
-if LED_STATUS_RED_ENABLE
-
-config LED_STATUS_RED
-	int "Red LED identification"
-	help
-	  Valid enabled LED device number.
-
-endif # LED_STATUS_RED_ENABLE
-
-config LED_STATUS_YELLOW_ENABLE
-	bool "Enable yellow LED"
-	help
-	  Enable yellow status LED.
-
-if LED_STATUS_YELLOW_ENABLE
-
-config LED_STATUS_YELLOW
-	int "Yellow LED identification"
-	help
-	  Valid enabled LED device number.
-
-endif # LED_STATUS_YELLOW_ENABLE
-
-config LED_STATUS_BLUE_ENABLE
-	bool "Enable blue LED"
-	help
-	  Enable blue status LED.
-
-if LED_STATUS_BLUE_ENABLE
-
-config LED_STATUS_BLUE
-	int "Blue LED identification"
-	help
-	  Valid enabled LED device number.
-
-endif # LED_STATUS_BLUE_ENABLE
-
-config LED_STATUS_GREEN_ENABLE
-	bool "Enable green LED"
-	help
-	  Enable green status LED.
-
-if LED_STATUS_GREEN_ENABLE
-
-config LED_STATUS_GREEN
-	int "Green LED identification"
-	help
-	  Valid enabled LED device number (0-5).
-
-endif # LED_STATUS_GREEN_ENABLE
-
-config LED_STATUS_CMD
-	bool "Enable status LED commands"
-
-endif # LED_STATUS
-
 endmenu
-- 
2.43.0

