Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8E6EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 463F8864D3;
	Wed, 23 Aug 2023 15:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="jNKIQFay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1B886459; Wed, 23 Aug 2023 15:59:32 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8465F864AA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1qYoNs-001ZvC-Bq; Wed, 23 Aug 2023 15:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1692799167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFIflozD1UVopLQkrP+Zhuqui+zzlAO0P2/DIXZ68Cw=;
 b=jNKIQFaySDCixcR9TWDysrn7NuCSZ8fNmXCzbeqScO3ngR+8Pgk1PEhOCLKQVSVnd70b7/
 LhOnim8LFD7XBrta9LZ8eHOoZ98aoJUPf3G3bR8woeJAQalOgs50+GKFwuzwMTB697ANyE
 klc9gpPuAizoAJ3+3mbB/4S7E2gsAoEcMPlduCm4mikBs/gWbHx7NdSJivLsKnH+AmjPef
 5nHZyg5w80IyMVTfdCbBMgzw1pmcZ6PjgLUBtXEBfRHYB4dv3sukfUmBSQ4uJMfDypRziq
 tp69i9Hs7fCiYYcxVuw90VByFDRsIiV35ONQarEbranJ5K2npsZW2c6e83gM/g==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: Sergiu Moga <sergiu.moga@microchip.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 4/5] board: sam9x60-curiosity: Let LED subsystem init leds
 if enabled
Date: Wed, 23 Aug 2023 15:58:55 +0200
Message-Id: <20230823135856.376351-5-ada@thorsis.com>
In-Reply-To: <20230823135856.376351-1-ada@thorsis.com>
References: <20230823135856.376351-1-ada@thorsis.com>
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

If CONFIG_LED and CONFIG_LED_GPIO are enabled, it is not necessary to
initialize the RGB LED on the board by manually setting hardcoded GPIOs
anymore.  Everything is well defined in dts and can be used like on
boards of other vendors.

Keep the old behaviour as fallback, though.

With all this in place enabling CONFIG_CMD_LED gives us a working 'led'
command on the U-Boot shell.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 .../arm/dts/at91-sam9x60_curiosity-u-boot.dtsi | 18 ++++++++++++++++++
 .../sam9x60_curiosity/sam9x60_curiosity.c      | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
index a1b76e94d1..dd4623311c 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
+++ b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
@@ -20,6 +20,24 @@
 	chosen {
 		bootph-all;
 	};
+
+	config {
+		u-boot,boot-led = "blue";
+	};
+
+	leds {
+		led-red {
+			default-state = "off";
+		};
+
+		led-green {
+			default-state = "off";
+		};
+
+		led-blue {
+			default-state = "off";
+		};
+	};
 };
 
 &clk32 {
diff --git a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
index 0fe0de9fde..f53d359404 100644
--- a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
+++ b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
@@ -9,6 +9,7 @@
 #include <debug_uart.h>
 #include <fdtdec.h>
 #include <init.h>
+#include <led.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/at91_rstc.h>
 #include <asm/arch/at91_sfr.h>
@@ -18,6 +19,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
+#include <dm/ofnode.h>
 
 extern void at91_pda_detect(void);
 
@@ -27,9 +29,25 @@ void at91_prepare_cpu_var(void);
 
 static void board_leds_init(void)
 {
+#if CONFIG_IS_ENABLED(LED)
+	const char *led_name;
+	struct udevice *dev;
+	int ret;
+
+	led_name = ofnode_conf_read_str("u-boot,boot-led");
+	if (!led_name)
+		return;
+
+	ret = led_get_by_label(led_name, &dev);
+	if (ret)
+		return;
+
+	led_set_state(dev, LEDST_ON);
+#else
 	at91_set_pio_output(AT91_PIO_PORTD, 17, 0);	/* LED RED */
 	at91_set_pio_output(AT91_PIO_PORTD, 19, 0);	/* LED GREEN */
 	at91_set_pio_output(AT91_PIO_PORTD, 21, 1);	/* LED BLUE */
+#endif
 }
 
 int board_late_init(void)
-- 
2.30.2

