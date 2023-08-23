Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8C1EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07B5864AA;
	Wed, 23 Aug 2023 15:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="UIdA8DlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4DF86459; Wed, 23 Aug 2023 15:59:31 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C4A8649A
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1qYoNs-001ZvF-CR; Wed, 23 Aug 2023 15:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1692799167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3EJBt4gudQfapHupUEzew4DAo0hK/xcwgBPop6OmCY=;
 b=UIdA8DlMaQr8VX6YZiHdauZxmGwYjJCDNJWeHRC+FxyxEUK7k5Nk0D4lYoiOms2XJK7EMY
 DfdjBBeTvjFRQF8P30qdaaA3AIP/hyq8wuU9zv4PP7C/tX30jw1xIfT/qiJj5lNtzZipjN
 VmkXRWZKDBFaI6qGxA7H/PbzF9YLLqHaAlPm83ozU1+mlOphpFtMPoVgHyYinO+npyiC6R
 GXPz60QIQfal8BhaHkUpZp1ws8cmTMgBPjPPGRNYO6n9fgACetxKldC/4oCQYM6Y7pU0y+
 QHa0/RN9KEqMuBRPN+hQnTpU+BWh8gls0DiL+ieZGAZdOeIeiguqvnR/sJtb3g==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: Sergiu Moga <sergiu.moga@microchip.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 5/5] ARM: dts: at91: sam9x60-curiosity: Sync gpio button
 from Linux
Date: Wed, 23 Aug 2023 15:58:56 +0200
Message-Id: <20230823135856.376351-6-ada@thorsis.com>
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

Copied as is from Linux Kernel release v6.4.
(dts file is still the same in Linux v6.5-rc7 but was moved to vendor
sub-directories with v6.5-rc1.)

Button works out of the box now if the following config options are
enabled: CONFIG_BUTTON, CONFIG_BUTTON_GPIO, CONFIG_CMD_BUTTON,
CONFIG_DM_GPIO.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v1 -> v2:
      - reworded commit message

 arch/arm/dts/at91-sam9x60_curiosity.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 244cacfe1b..99867d2bf8 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -7,6 +7,7 @@
  * Author: Durai Manickam KR <durai.manickamkr@microchip.com>
  */
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include "sam9x60.dtsi"
 
@@ -33,6 +34,19 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+
+		button-user {
+			label = "PB_USER";
+			gpios = <&pioA 29 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROG1>;
+			wakeup-source;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -189,6 +203,12 @@
 		};
 	};
 
+	gpio-keys {
+		pinctrl_key_gpio_default: pinctrl-key-gpio {
+			atmel,pins = <AT91_PIOA 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
 	leds {
 		pinctrl_gpio_leds: gpio-leds {
 			atmel,pins = <AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
-- 
2.30.2

