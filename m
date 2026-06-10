Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531C6CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7E1849AC;
	Wed, 10 Jun 2026 16:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VCxg/1W1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435E4849AC; Wed, 10 Jun 2026 16:39:05 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23AB9849AF
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bec85f03e14so95742566b.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102342; x=1781707142; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d9hYjO4s0P0L51ZKE1YROHjrtATj+zSXD84H6lB6a0s=;
 b=VCxg/1W1VxEtKRW3rwU5AonAHSbsEsKfon/XqACjIoMkf8ioeu/7IRlnJb7yFpNeUL
 qu/TWpEZUOilB7kyO3pZmEopNM3P6MossmrWCYA10ddVD5ZEk/yhJlcmW8D0xi8K1Mn1
 sms+GqbWQGu0f7k5sI5B15OYGvq6FvyX8192zvOb1o1Czb3tH60Xp5HeWmKbu0Z0MI4B
 6FnjKvTucq8rBTuhFnYA7eC8L6yy6AAPU9M1sXV7iF/wFg4/ahIbor3hgeynQl4HJCZL
 84B0ErWBkTorMDH9sz4+eR9I+LskYFZkcNcuuEGIoPm1ByvoA+SEoyQ+7I5sZIpmk7F1
 hzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102342; x=1781707142;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d9hYjO4s0P0L51ZKE1YROHjrtATj+zSXD84H6lB6a0s=;
 b=OTDjMUkgY3HOlpFvu1TTR2AKpZaVmYIZhRaEBzXFbaTQg8ovCJxnvK1eR8/0FoWWfi
 iaQRxiJBfYHiqRsiNdCwG4EJ94y8VTKummwM7vY0szfb9p/JcsH3jh05TjTEuGVCmkc8
 N4C4lbuvwkOFqfuxOFkapwoL2sz9dL+z8rgp7OCE1KBIP30Q+RdOGy95wRERwgD4YII5
 kZ/wJl6N8Jnvo4XuvaNKYoFKrqj/PA/Kna9QYOmFzxBHZLoKshO5MZAWwilPS1pzwCtH
 2JkWL55hbrOwsqWbK5HvsrXBuz69vW4w6FTVpaILj4U5t/EDIEYnhMJQXTgoeHvEjuJ1
 GmEg==
X-Gm-Message-State: AOJu0Yx44pgiYUH9GHTnvpZkaOsFY1lGKBNzNavZVydWwVF+db6cBzfQ
 ioamIXtYyC9jdpD2nCCFKUmB0SK42kznEYjHzQmpXsHYANh307fR8Ryh
X-Gm-Gg: Acq92OEmX2Lw8YseyevVqfUL1whFu58NISeRnT4/FBl6QD/lFLnoX+j7J76+zfaRfKp
 TjhGp0aAIG0tZiBJW11XoEnwSTsxhJeydCKXaNFzu6HivplHckdf6BAFDO22MiWXp5mXrQCzdI0
 4AmSCxl93yQ5V4dyEu9uqzqyzYq6aquAoBegfvFhrXQ4dafvUztd4Hi6rjSMXGshZiYMtgyABnm
 OtYtBhLqdn257pnr2HrDYkHnpBapfv+HuUbkou7ufIzfujPPa2XEtCv1w2SfX9H8JhjFqJs8gvO
 KpgdmoDHhhptY/RZRaaffV9H/5MQ6JUf4WgGYkRxrUk7hNVVrI8KzTBig8HTyzUINJflukON3Xu
 OuetDDTiCYI2F9VHItZzcsQzzEOYpgMtR0BLi3izIiYATEZxqpqi0FQlqiZV3e556/TGQ7QYpRw
 ChJtL4xCP4al0GL0DIpswtXbocuIzrDdsesUWgpbf7I96phrrZyiQZqrr5FK7UL4r064vYZP1H
X-Received: by 2002:a17:907:75e3:b0:beb:c327:8e7b with SMTP id
 a640c23a62f3a-bf93a1f9f14mr142456966b.3.1781102342466; 
 Wed, 10 Jun 2026 07:39:02 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f4144sm1188010166b.58.2026.06.10.07.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:39:02 -0700 (PDT)
Message-ID: <317d403a-0274-47b2-b550-fcaa2df2c45a@gmail.com>
Date: Wed, 10 Jun 2026 16:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 09/18] Kconfig: i2c: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "i2c":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/i2c/Kconfig       | 140 +++++++++++++++++++-------------------
 drivers/i2c/muxes/Kconfig |   2 +-
 2 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 37288a47eb75..faec19ec6cbd 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -110,16 +110,16 @@ config I2C_CROS_EC_TUNNEL
 config I2C_CROS_EC_LDO
 	bool "Provide access to LDOs on the Chrome OS EC"
 	depends on CROS_EC
-	---help---
-	On many Chromebooks the main PMIC is inaccessible to the AP. This is
-	often dealt with by using an I2C pass-through interface provided by
-	the EC. On some unfortunate models (e.g. Spring) the pass-through
-	is not available, and an LDO message is available instead. This
-	option enables a driver which provides very basic access to those
-	regulators, via the EC. We implement this as an I2C bus	which
-	emulates just the TPS65090 messages we know about. This is done to
-	avoid duplicating the logic in the TPS65090 regulator driver for
-	enabling/disabling an LDO.
+	help
+	  On many Chromebooks the main PMIC is inaccessible to the AP. This is
+	  often dealt with by using an I2C pass-through interface provided by
+	  the EC. On some unfortunate models (e.g. Spring) the pass-through
+	  is not available, and an LDO message is available instead. This
+	  option enables a driver which provides very basic access to those
+	  regulators, via the EC. We implement this as an I2C bus	which
+	  emulates just the TPS65090 messages we know about. This is done to
+	  avoid duplicating the logic in the TPS65090 regulator driver for
+	  enabling/disabling an LDO.

 config I2C_SET_DEFAULT_BUS_NUM
 	bool "Set default I2C bus number"
@@ -180,9 +180,9 @@ config SYS_I2C_IPROC
 	  Say yes here to to enable the Broadco I2C driver.

 config SYS_I2C_FSL
-       bool "Freescale I2C bus driver"
-       depends on M68K || PPC
-       help
+	bool "Freescale I2C bus driver"
+	depends on M68K || PPC
+	help
 	  Add support for Freescale I2C busses as used on MPC8240, MPC8245, and
 	  MPC85xx processors.

@@ -249,14 +249,14 @@ config SYS_I2C_DW_PCI
 	  controller.

 config SYS_I2C_AST2600
-    bool "AST2600 I2C Controller"
-    depends on DM_I2C && ARCH_ASPEED
-    help
-      Say yes here to select AST2600 I2C Host Controller. The driver
-      support AST2600 I2C new mode register. This I2C controller supports:
-      _Standard-mode (up to 100 kHz)
-      _Fast-mode (up to 400 kHz)
-      _Fast-mode Plus (up to 1 MHz)
+	bool "AST2600 I2C Controller"
+	depends on DM_I2C && ARCH_ASPEED
+	help
+	  Say yes here to select AST2600 I2C Host Controller. The driver
+	  support AST2600 I2C new mode register. This I2C controller supports:
+	  _Standard-mode (up to 100 kHz)
+	  _Fast-mode (up to 400 kHz)
+	  _Fast-mode Plus (up to 1 MHz)

 config SYS_I2C_ASPEED
 	bool "Aspeed I2C Controller"
@@ -333,50 +333,50 @@ if SYS_I2C_MXC && (SYS_I2C_LEGACY || SPL_SYS_I2C_LEGACY)
 config SYS_I2C_MXC_I2C1
 	bool "NXP MXC I2C1"
 	help
-	 Add support for NXP MXC I2C Controller 1.
-	 Required for SoCs which have I2C MXC controller 1 eg LS1088A, LS2080A
+	  Add support for NXP MXC I2C Controller 1.
+	  Required for SoCs which have I2C MXC controller 1 eg LS1088A, LS2080A

 config SYS_I2C_MXC_I2C2
 	bool "NXP MXC I2C2"
 	help
-	 Add support for NXP MXC I2C Controller 2.
-	 Required for SoCs which have I2C MXC controller 2 eg LS1088A, LS2080A
+	  Add support for NXP MXC I2C Controller 2.
+	  Required for SoCs which have I2C MXC controller 2 eg LS1088A, LS2080A

 config SYS_I2C_MXC_I2C3
 	bool "NXP MXC I2C3"
 	help
-	 Add support for NXP MXC I2C Controller 3.
-	 Required for SoCs which have I2C MXC controller 3 eg LS1088A, LS2080A
+	  Add support for NXP MXC I2C Controller 3.
+	  Required for SoCs which have I2C MXC controller 3 eg LS1088A, LS2080A

 config SYS_I2C_MXC_I2C4
 	bool "NXP MXC I2C4"
 	help
-	 Add support for NXP MXC I2C Controller 4.
-	 Required for SoCs which have I2C MXC controller 4 eg LS1088A, LS2080A
+	  Add support for NXP MXC I2C Controller 4.
+	  Required for SoCs which have I2C MXC controller 4 eg LS1088A, LS2080A

 config SYS_I2C_MXC_I2C5
 	bool "NXP MXC I2C5"
 	help
-	 Add support for NXP MXC I2C Controller 5.
-	 Required for SoCs which have I2C MXC controller 5 eg LX2160A
+	  Add support for NXP MXC I2C Controller 5.
+	  Required for SoCs which have I2C MXC controller 5 eg LX2160A

 config SYS_I2C_MXC_I2C6
 	bool "NXP MXC I2C6"
 	help
-	 Add support for NXP MXC I2C Controller 6.
-	 Required for SoCs which have I2C MXC controller 6 eg LX2160A
+	  Add support for NXP MXC I2C Controller 6.
+	  Required for SoCs which have I2C MXC controller 6 eg LX2160A

 config SYS_I2C_MXC_I2C7
 	bool "NXP MXC I2C7"
 	help
-	 Add support for NXP MXC I2C Controller 7.
-	 Required for SoCs which have I2C MXC controller 7 eg LX2160A
+	  Add support for NXP MXC I2C Controller 7.
+	  Required for SoCs which have I2C MXC controller 7 eg LX2160A

 config SYS_I2C_MXC_I2C8
 	bool "NXP MXC I2C8"
 	help
-	 Add support for NXP MXC I2C Controller 8.
-	 Required for SoCs which have I2C MXC controller 8 eg LX2160A
+	  Add support for NXP MXC I2C Controller 8.
+	  Required for SoCs which have I2C MXC controller 8 eg LX2160A
 endif

 if SYS_I2C_MXC_I2C1
@@ -385,13 +385,13 @@ config SYS_MXC_I2C1_SPEED
 	default 40000000 if TARGET_LS2080A_EMU
 	default 100000
 	help
-	 MXC I2C Channel 1 speed
+	  MXC I2C Channel 1 speed

 config SYS_MXC_I2C1_SLAVE
 	hex "I2C1 Slave"
 	default 0x0
 	help
-	 MXC I2C1 Slave
+	  MXC I2C1 Slave
 endif

 if SYS_I2C_MXC_I2C2
@@ -400,13 +400,13 @@ config SYS_MXC_I2C2_SPEED
 	default 40000000 if TARGET_LS2080A_EMU
 	default 100000
 	help
-	 MXC I2C Channel 2 speed
+	  MXC I2C Channel 2 speed

 config SYS_MXC_I2C2_SLAVE
 	hex "I2C2 Slave"
 	default 0x0
 	help
-	 MXC I2C2 Slave
+	  MXC I2C2 Slave
 endif

 if SYS_I2C_MXC_I2C3
@@ -414,13 +414,13 @@ config SYS_MXC_I2C3_SPEED
 	int "I2C Channel 3 speed"
 	default 100000
 	help
-	 MXC I2C Channel 3 speed
+	  MXC I2C Channel 3 speed

 config SYS_MXC_I2C3_SLAVE
 	hex "I2C3 Slave"
 	default 0x0
 	help
-	 MXC I2C3 Slave
+	  MXC I2C3 Slave
 endif

 if SYS_I2C_MXC_I2C4
@@ -428,13 +428,13 @@ config SYS_MXC_I2C4_SPEED
 	int "I2C Channel 4 speed"
 	default 100000
 	help
-	 MXC I2C Channel 4 speed
+	  MXC I2C Channel 4 speed

 config SYS_MXC_I2C4_SLAVE
 	hex "I2C4 Slave"
 	default 0x0
 	help
-	 MXC I2C4 Slave
+	  MXC I2C4 Slave
 endif

 if SYS_I2C_MXC_I2C5
@@ -442,13 +442,13 @@ config SYS_MXC_I2C5_SPEED
 	int "I2C Channel 5 speed"
 	default 100000
 	help
-	 MXC I2C Channel 5 speed
+	  MXC I2C Channel 5 speed

 config SYS_MXC_I2C5_SLAVE
 	hex "I2C5 Slave"
 	default 0x0
 	help
-	 MXC I2C5 Slave
+	  MXC I2C5 Slave
 endif

 if SYS_I2C_MXC_I2C6
@@ -456,13 +456,13 @@ config SYS_MXC_I2C6_SPEED
 	int "I2C Channel 6 speed"
 	default 100000
 	help
-	 MXC I2C Channel 6 speed
+	  MXC I2C Channel 6 speed

 config SYS_MXC_I2C6_SLAVE
 	hex "I2C6 Slave"
 	default 0x0
 	help
-	 MXC I2C6 Slave
+	  MXC I2C6 Slave
 endif

 if SYS_I2C_MXC_I2C7
@@ -470,13 +470,13 @@ config SYS_MXC_I2C7_SPEED
 	int "I2C Channel 7 speed"
 	default 100000
 	help
-	 MXC I2C Channel 7 speed
+	  MXC I2C Channel 7 speed

 config SYS_MXC_I2C7_SLAVE
 	hex "I2C7 Slave"
 	default 0x0
 	help
-	 MXC I2C7 Slave
+	  MXC I2C7 Slave
 endif

 if SYS_I2C_MXC_I2C8
@@ -484,13 +484,13 @@ config SYS_MXC_I2C8_SPEED
 	int "I2C Channel 8 speed"
 	default 100000
 	help
-	 MXC I2C Channel 8 speed
+	  MXC I2C Channel 8 speed

 config SYS_MXC_I2C8_SLAVE
 	hex "I2C8 Slave"
 	default 0x0
 	help
-	 MXC I2C8 Slave
+	  MXC I2C8 Slave
 endif

 config SYS_I2C_NEXELL
@@ -668,19 +668,19 @@ config SYS_I2C_STM32F7
 	help
 	  Enable this option to add support for STM32 I2C controller
 	  introduced with STM32F7/H7 SoCs. This I2C controller supports :
-	   _ Slave and master modes
-	   _ Multimaster capability
-	   _ Standard-mode (up to 100 kHz)
-	   _ Fast-mode (up to 400 kHz)
-	   _ Fast-mode Plus (up to 1 MHz)
-	   _ 7-bit and 10-bit addressing mode
-	   _ Multiple 7-bit slave addresses (2 addresses, 1 with configurable mask)
-	   _ All 7-bit addresses acknowledge mode
-	   _ General call
-	   _ Programmable setup and hold times
-	   _ Easy to use event management
-	   _ Optional clock stretching
-	   _ Software reset
+	  _ Slave and master modes
+	  _ Multimaster capability
+	  _ Standard-mode (up to 100 kHz)
+	  _ Fast-mode (up to 400 kHz)
+	  _ Fast-mode Plus (up to 1 MHz)
+	  _ 7-bit and 10-bit addressing mode
+	  _ Multiple 7-bit slave addresses (2 addresses, 1 with configurable mask)
+	  _ All 7-bit addresses acknowledge mode
+	  _ General call
+	  _ Programmable setup and hold times
+	  _ Easy to use event management
+	  _ Optional clock stretching
+	  _ Software reset

 config SYS_I2C_SUN6I_P2WI
 	bool "Allwinner sun6i P2WI controller"
@@ -792,10 +792,10 @@ config SYS_I2C_XILINX_XIIC
 	  Support for Xilinx AXI I2C controller.

 config SYS_I2C_IHS
-        bool "gdsys IHS I2C driver"
-        depends on DM_I2C
-        help
-          Support for gdsys IHS I2C driver on FPGA bus.
+	bool "gdsys IHS I2C driver"
+	depends on DM_I2C
+	help
+	  Support for gdsys IHS I2C driver on FPGA bus.

 source "drivers/i2c/muxes/Kconfig"

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 3b1220b21056..9f642e4451f3 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -49,7 +49,7 @@ config I2C_MUX_PCA954x
 		MAX7356, MAX7357, MAX7358, MAX7367, MAX7368 and MAX7369

 config I2C_MUX_GPIO
-        tristate "GPIO-based I2C multiplexer"
+	tristate "GPIO-based I2C multiplexer"
 	depends on I2C_MUX && DM_GPIO
 	select DEVRES
 	help
--
2.39.5

