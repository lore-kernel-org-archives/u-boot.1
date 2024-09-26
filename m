Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBACCDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382A288DFD;
	Thu, 26 Sep 2024 22:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VXUX4Mm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E759588E0D; Thu, 26 Sep 2024 22:49:39 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC5188DF1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cb3062d9b5so8688806d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383776; x=1727988576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ol9SON4knWgm0zoaP4tWsA7tEIF7qEPOEwcXr0XDRes=;
 b=VXUX4Mm2+gU56PkiSDvhCJAGcwjbyKc4G6fHok84/oIaffnRvxHSo9WGd2UunEiOHF
 jYV9DGxJZ7m8Qa1NAF3neiGhmzbKp8EUIUnthdHHV/1DGEmMpcyI+7O7zRRAxmGSKmIQ
 2GEFGGF001R/6QnHIIwkLNklRirp3c2jgvaTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383776; x=1727988576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ol9SON4knWgm0zoaP4tWsA7tEIF7qEPOEwcXr0XDRes=;
 b=f+h1RNxA7fddzsWOg18WmBFPqSJFaPDxgD1RIroFt/HGQmhfjXoUNTG89JGcIAD14a
 J35VBAdBG5kUIAZ2s2yPIQf9OtOPnhQe8quQbRyqnbrRyax36NVJQSPLT0n4yiwdKAew
 OseWiV0agj6yT2c5MfR8+SgjZW0kPe5KBca1w5p+MsIHvHREforxwWbndWig/RJBOq4D
 YiQ+/94LH2awVtL0ll9xpXIfBOwLAarXc9x0AsIgIuGywUB5xhIB1x14gKxlj986MB2i
 MeM/fUlwAqAIGvF+ArwZSCe90w7CIqOTnY6iEkCc/Da6K6xdVURv2fBDX/pph8js4nDq
 EzTA==
X-Gm-Message-State: AOJu0YzBGDclmDKG7YYqEehzNP1G4M5Pnc5G/QFFD70P3NajOjp7+Mjj
 /F/dgkc4oaU4y4+Mmk3Z2AUncfhv1PDJm7+YH23Fspfv7XGEFmIfjmonCZNQCAo2yjfdrSMEvlL
 TZgL5yAs=
X-Google-Smtp-Source: AGHT+IFRzW6sPUK5dm3zUabVLsF7UGC8chZyhzcpxubTMMk/4tDwEHDGCpse9pJ72NEr3Te90Dk0pQ==
X-Received: by 2002:a05:6214:3209:b0:6c3:6425:fe66 with SMTP id
 6a1803df08f44-6cb3b5c0f33mr13406486d6.11.1727383776352; 
 Thu, 26 Sep 2024 13:49:36 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:49:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Doug Zobel <douglas.zobel@climate.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 10/27] led: Drop LED_STATUS from Kconfig
Date: Thu, 26 Sep 2024 22:44:30 +0200
Message-ID: <20240926204455.963584-11-sjg@chromium.org>
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

Drop all of these configs, which are now unused.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/led/Kconfig | 316 --------------------------------------------
 1 file changed, 316 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 32f0eade710..f4d47d0f327 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -114,320 +114,4 @@ config SPL_LED_GPIO
 
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

