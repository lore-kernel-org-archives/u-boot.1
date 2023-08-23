Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD85EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726F886459;
	Wed, 23 Aug 2023 15:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="shNCgzXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B046864CA; Wed, 23 Aug 2023 15:59:31 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344F386459
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1qYoNs-001Zv9-BD; Wed, 23 Aug 2023 15:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1692799167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3G0iM5QZgmJ6V2J7piqqYIXqBRnmH3rZEmfoJOzhIA=;
 b=shNCgzXajtT8KI9ngdcfQluaeQVd5FvcAyJsSKps6T8YK9fMy6fWx+0HpogJuUdbfvWkiZ
 WWyh6Y44lvUjs92DLjz3BzMGdHt5apIfd2DZL8eRd3hPEGO7Q1yt7URRf7aDXk5YRZMk6+
 czFhOGpVBcAl/NM0Mt0mvKXk+YPEg4Lw6nodWDHr85NFAFwjlzkq5luIAa/MQM38lkuYtp
 F8tdxGknLYT7bUZ8aCZu4coiOxnD9G+MH/SYoqhluuo6y6WYyxzRIQt0kAYhS8ZhiA9RZZ
 k22ZI146Tyg/Z+HgGYSLwRrr2kdLAbhoCZDsZ52SmG9e6FuEtXD1ilLBaIXN3w==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: Sergiu Moga <sergiu.moga@microchip.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/5] ARM: dts: at91: sam9x60-curiosity: Sync LED nodes from
 Linux
Date: Wed, 23 Aug 2023 15:58:54 +0200
Message-Id: <20230823135856.376351-4-ada@thorsis.com>
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

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 2547b4527c..244cacfe1b 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -33,6 +33,28 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-red {
+			label = "red";
+			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-green {
+			label = "green";
+			gpios = <&pioD 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-blue {
+			label = "blue";
+			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	onewire_tm: onewire {
 		gpios = <&pioD 14 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -167,6 +189,14 @@
 		};
 	};
 
+	leds {
+		pinctrl_gpio_leds: gpio-leds {
+			atmel,pins = <AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
 	nand {
 		pinctrl_nand_oe_we: nand-oe-we-0 {
 			atmel,pins =
-- 
2.30.2

