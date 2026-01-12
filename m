Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AEAC9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0184C8393F;
	Mon, 12 Jan 2026 14:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="MicEwrd9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC52C839A8; Mon, 12 Jan 2026 14:13:08 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989E5803F5
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4529812f8f.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1768223586; x=1768828386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qzq8r2RNhzZsTWJm/7iFXQgjY0csUe4Qr/j26iRa7Tg=;
 b=MicEwrd9kNIzsKaDKwMBbZejjyMk+lrTjqsajMoZkKsks+d9dVKGg9BlFMCbSz4PYk
 ChK0r4Uth3hoWfiw+DHVataEspFQVnJ7/ke25JAooLAfOeYmG1iNL4cgn+Gh/sa4RBLB
 OAPLyvbMQavBrS8+QL73OSpK3C3QbknNrgHf1fWI7ZmnLN2GQcU2SIrPZqR4vZsvcy8e
 5vhLdS+SP/JWHNAfC2qFhD0pspm0SoAe6lZrznAqJQS6LuA5iuJmjGN76jtqXljyPoAW
 iiU6fawbUrrA3sEu7Mdd8c+mePVq9bKsmuYg33f/Q0QyzETDInbdEL3zwcJ1mav7kJlZ
 pFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768223586; x=1768828386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qzq8r2RNhzZsTWJm/7iFXQgjY0csUe4Qr/j26iRa7Tg=;
 b=PhNTJYuV0gBPutr1yZfpeZZ3iGD1h7TSXdJf4u2HtPkyIB6m0o1Mojv+txKjKHTrEG
 13NiFJLkAfsKKkHMo6tOM5ufrMKM9/8LfoLEpXo+avjz9oaDupu7vyQ/1AYdKYbw/Gd5
 wxXZ1+y4eGZHakpQgVXBG0+ZlQyz9F3vzD33cQPvPA4Oa/Sm9FrdJRmUVIZ4P6sFWXir
 dkaqyhEvpbhc8mt1U9mPx6Z26LL0Ceemjh2YYN79xU7LWdLD7bua3F35obaNI6kt5qEP
 RumNG3OiLAS/rALqJYsEzgdmA9xuPQlwDAMTz0MiXDIAALD2g04MmpeiKPFHCFzUBGA8
 p64w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI1q+JYUQr9+WiBvLIjKDTcpd6RvIKbK+LX+qID0LCJHnkNgSwA53AQWtEwu3uCOlowVp2auQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzDICfTVmIZlrbFNvfHTglaHG6i2FlUZybLboojdRRtk7XZYHkH
 rub9XIcWsFx4wLRyTQ+Yb0+OmeVXQipP0dIfWdZpQ2oUC7b2EE3dnhNqni1aIEc9K5s=
X-Gm-Gg: AY/fxX79zdlt5QQdjSTQjdCQPHn+wtIuBgOPC3gwDt9YmPgfgInsYIjtmA/2fUP8lWV
 8SaZxZM0/11e4Fnma6fwPJqU+DNFEq221rNe6cLulgXhCPFjcPSpB5gal1T0Xwc8GcVzohoZ1EV
 y3fhu5rQSNByPnQhkuLju/nsU7iofxwb+ZrXFIsViJ7e1mPTEwc3/wPuZPYxcU70CO7JBcNKNNQ
 lbHXRX3295VloceTjhW/ZC5Ql4I6/gDt+fjPE5dF8ZQBV4l56AFO9NFTnGdiVUnXs9iYYY2TOan
 WjCskCaLHeisVVgTCa8EmzMusyK3S4ggCtKq6N3HO1+vNndiSkpsfiNJ0NnGBLqactY9+YjWA2L
 /JfKiULugM8y8ZwJdyjqBN94U5PPFMkrBN2ASjRE3qE3Hlb8x7Dl2TaHTtd02W/3RXCgf5eraip
 H/5BmyEnbqHHrtriynzcDz4BOAgnFtPN1tTPOJA65tJx6/udfZmLaUh4MhtAMmJ/6eT4S8dose9
 zZuLM4F
X-Google-Smtp-Source: AGHT+IFjdw0xobiHtW5DKAX0N4S59F9ch0JanJ7fNjUw6XYPeS6MjhBitW5SiJZdfwy+FgdXn1qVhA==
X-Received: by 2002:a05:6000:2689:b0:432:5b81:483 with SMTP id
 ffacd0b85a97d-432c3775a7cmr20200064f8f.24.1768223585755; 
 Mon, 12 Jan 2026 05:13:05 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm39635162f8f.22.2026.01.12.05.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:13:05 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: eugen.hristev@linaro.org, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/4] arm: at91: move atmel_serial.h to
 include/dm/platform_data
Date: Mon, 12 Jan 2026 14:12:39 +0100
Message-ID: <20260112131258.182173-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
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

Move the arch specific atmel_serial.h header from AT91 to the generic
include/dm/platform_data.

This will be used for support on Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 board/bluewater/gurnard/gurnard.c                               | 2 +-
 board/siemens/corvus/board.c                                    | 2 +-
 board/siemens/smartweb/smartweb.c                               | 2 +-
 board/siemens/taurus/taurus.c                                   | 2 +-
 drivers/serial/atmel_usart.c                                    | 2 +-
 .../include/mach => include/dm/platform_data}/atmel_serial.h    | 0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename {arch/arm/mach-at91/include/mach => include/dm/platform_data}/atmel_serial.h (100%)

diff --git a/board/bluewater/gurnard/gurnard.c b/board/bluewater/gurnard/gurnard.c
index 3275803226a..71db6409721 100644
--- a/board/bluewater/gurnard/gurnard.c
+++ b/board/bluewater/gurnard/gurnard.c
@@ -29,7 +29,7 @@
 #include <asm/arch/at91_rstc.h>
 #include <asm/arch/at91_rtc.h>
 #include <asm/arch/at91_sck.h>
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/gpio.h>
 #include <dm/uclass-internal.h>
diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index 4c83774fceb..c0a94ac904f 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -20,7 +20,7 @@
 #include <asm/arch/at91sam9_smc.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/at91_rstc.h>
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #include <asm/arch/gpio.h>
 #include <asm/gpio.h>
 #include <asm/arch/clk.h>
diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
index 6fa3ca573ae..ce16aad3b98 100644
--- a/board/siemens/smartweb/smartweb.c
+++ b/board/siemens/smartweb/smartweb.c
@@ -25,7 +25,7 @@
 #include <asm/arch/at91sam9260_matrix.h>
 #include <asm/arch/at91sam9_smc.h>
 #include <asm/arch/at91_common.h>
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #include <asm/arch/at91_spi.h>
 #include <spi.h>
 #include <asm/arch/clk.h>
diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
index 252b0787124..690c00046fa 100644
--- a/board/siemens/taurus/taurus.c
+++ b/board/siemens/taurus/taurus.c
@@ -24,7 +24,7 @@
 #include <asm/arch/at91_rstc.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/at91sam9_sdramc.h>
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #include <asm/arch/clk.h>
 #include <asm/gpio.h>
 #include <linux/mtd/rawnand.h>
diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
index 0b35582aaa4..d6c3d4cbcc8 100644
--- a/drivers/serial/atmel_usart.c
+++ b/drivers/serial/atmel_usart.c
@@ -18,7 +18,7 @@
 
 #include <asm/io.h>
 #if CONFIG_IS_ENABLED(DM_SERIAL)
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #endif
 #include <asm/arch/clk.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/include/mach/atmel_serial.h b/include/dm/platform_data/atmel_serial.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/atmel_serial.h
rename to include/dm/platform_data/atmel_serial.h
-- 
2.52.0

