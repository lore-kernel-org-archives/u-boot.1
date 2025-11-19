Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7FDCF3959
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3AA83F20;
	Wed, 19 Nov 2025 18:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25A8E83FF4; Wed, 19 Nov 2025 18:01:24 +0100 (CET)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D5A83F20
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBSS14vwPzsFd;
 Wed, 19 Nov 2025 18:01:21 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBSS05mFfzHkn; Wed, 19 Nov 2025 18:01:20 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 18:01:14 +0100
Subject: [PATCH 3/4] corvus: migrate red LED to the modern API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-corvus-led-red-green-v1-3-ce86b8d59dfc@cherry.de>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
In-Reply-To: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

red_led_on is either called from the legacy LED shell command (which is
disabled for corvus) or from arm-specific assembly code right before
jumping into board_init_r() in U-Boot proper.

Let's migrate to use the more modern LED subsystem by migrating to DM.

The default-state is set to on to mimic red_led_on() from the
arm-specific assembly code as a missing default-state FDT property
currently means the LED is not probed except if explicitly done via the
led shell command. Note though that this is running much later in the
boot process, once DM is started.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/at91sam9g45-corvus.dts | 11 +++++++++++
 board/siemens/corvus/board.c        | 11 -----------
 configs/corvus_defconfig            |  2 ++
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/at91sam9g45-corvus.dts b/arch/arm/dts/at91sam9g45-corvus.dts
index 67be80bb2b3..acc05994650 100644
--- a/arch/arm/dts/at91sam9g45-corvus.dts
+++ b/arch/arm/dts/at91sam9g45-corvus.dts
@@ -10,6 +10,7 @@
  *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>
  */
 /dts-v1/;
+#include <dt-bindings/leds/common.h>
 #include "at91sam9g45.dtsi"
 
 / {
@@ -106,4 +107,14 @@
 			status = "okay";
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		red_led: led-0 {
+			gpios = <&pioD 31 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			default-state = "on";
+		};
+	};
 };
diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index 670bcab484c..4c83774fceb 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -52,17 +52,6 @@ static void corvus_request_gpio(void)
 	gpio_request(AT91_PIN_PD3, "USB1");
 	gpio_request(AT91_PIN_PB18, "SPICS1");
 	gpio_request(AT91_PIN_PB3, "SPICS0");
-	gpio_request(AT91_PIN_PD31, "red led"); /* this is the user1 led */
-}
-
-void red_led_on(void)
-{
-	gpio_set_value(AT91_PIN_PD31, 1);
-}
-
-void red_led_off(void)
-{
-	gpio_set_value(AT91_PIN_PD31, 0);
 }
 
 static void corvus_nand_hw_init(void)
diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
index fe7d53bcdd8..3d16b9e3abe 100644
--- a/configs/corvus_defconfig
+++ b/configs/corvus_defconfig
@@ -75,6 +75,8 @@ CONFIG_CLK_AT91=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_AT91_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_SYS_NAND_DRIVER_ECC_LAYOUT=y

-- 
2.51.1

