Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2091CD3429
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C1B83DA7;
	Wed, 12 Nov 2025 18:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6479183DA7; Wed, 12 Nov 2025 18:48:52 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4D483CF2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d69r21szHz7yX;
 Wed, 12 Nov 2025 18:48:50 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d69r12v6mzsy9; Wed, 12 Nov 2025 18:48:49 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Nov 2025 18:48:15 +0100
Subject: [PATCH 10/11] sam9x60-curiosity: migrate Boot LED setup to use
 /options/u-boot/boot-led
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-led-old-dt-v1-10-2892d49517db@cherry.de>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
In-Reply-To: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
To: Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Klaus Goger <klaus.goger@cherry.de>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alexander Dahl <ada@thorsis.com>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This board is one of the last users of /config/u-boot,boot-led property
which is a U-Boot property out of the DT spec.

Let's migrate it to use the in-spec /options/u-boot/boot-led property.
When enabling LED_BOOT, U-Boot proper will lit the LED right before
entering the main loop, so nothing needs to be done in board files.

As explained in the commit adding support for this u-boot,boot-led
property, let's keep backward compatibility in case LED_BOOT isn't
selected.

Note that this is not tested as I do not own this device.

Cc: Alexander Dahl <ada@thorsis.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi   |  9 ++++++---
 board/atmel/sam9x60_curiosity/sam9x60_curiosity.c | 16 +---------------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
index 9144387861e..b8f16c0b0c0 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
+++ b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
@@ -21,8 +21,11 @@
 		bootph-all;
 	};
 
-	config {
-		u-boot,boot-led = "blue";
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_blue>;
+		};
 	};
 
 	leds {
@@ -34,7 +37,7 @@
 			default-state = "off";
 		};
 
-		led-blue {
+		led_blue: led-blue {
 			default-state = "off";
 		};
 	};
diff --git a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
index e75043ec00f..3393478e4c8 100644
--- a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
+++ b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
@@ -28,21 +28,7 @@ void at91_prepare_cpu_var(void);
 
 static void board_leds_init(void)
 {
-#if CONFIG_IS_ENABLED(LED)
-	const char *led_name;
-	struct udevice *dev;
-	int ret;
-
-	led_name = ofnode_conf_read_str("u-boot,boot-led");
-	if (!led_name)
-		return;
-
-	ret = led_get_by_label(led_name, &dev);
-	if (ret)
-		return;
-
-	led_set_state(dev, LEDST_ON);
-#else
+#if !CONFIG_IS_ENABLED(LED_BOOT)
 	at91_set_pio_output(AT91_PIO_PORTD, 17, 0);	/* LED RED */
 	at91_set_pio_output(AT91_PIO_PORTD, 19, 0);	/* LED GREEN */
 	at91_set_pio_output(AT91_PIO_PORTD, 21, 1);	/* LED BLUE */

-- 
2.51.1

