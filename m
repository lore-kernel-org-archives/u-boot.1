Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E96CD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D9C848C5;
	Tue,  9 Jun 2026 03:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWmQytS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834C0848D7; Tue,  9 Jun 2026 03:26:44 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB2BE84825
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68cebf2657cso770788a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968400; x=1781573200; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XGMnPUrD4VjVoXZnCP3uozUXx23JtokC93e+IiQUZ4w=;
 b=hWmQytS+L419QtEEFMs0IvTU2o+KMCwAui3WR6aTV+FAV5yPCFVU8F8+p7waYiEhlO
 dFoUxSgOPRE1nOl3RI6TJzb1tiDFSHprzlDGEf4ybKAxNq3pL0QfrkRC2KGZ4UVVKktk
 dw2mO3r+um1SIALyj1B/XLgGP1PoZWqMW5oVU0BCSN38g8VksIuxvipztiKif/74fRGc
 C/l4Q4uoCGwM1OqYHOf0eYHFoyfv1cYXkrO/xxT+uraC98sJF7SdYihgqWwjkQTf7v8t
 VsOccWRgDzxX7eCmM9j+AMZDYuUyjjB/u3Fg5WPkCpRH6batDNKpixIIQjtHBOB2lty6
 qUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968400; x=1781573200;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGMnPUrD4VjVoXZnCP3uozUXx23JtokC93e+IiQUZ4w=;
 b=B0v/egxMRj1ik/hVdidFLbx7BATVNMoRrvx3wZJwKyA5QbbQlGEb72XarYBcmx8AD1
 0SSP0M/yCccIKvaTlr5whdU9fpn5MLehBcihGx/sWrF/9FLIdZMl99Y5LTMio3s+I3D/
 iUbsC5MIeYh8u1UfQX267vgSks7ribez/ybUnp4418yDR+D25CDJ/YGHat7sS6G+ixjC
 d1yFXFrpmYJ8reTUhjwwZJCjEzwR+LLF6r35ELXptZHNLFLt6ov/Nd0uKCBwVjsLlSIw
 QkB9b4g8gMYTQzoe4Ygn0TwQr7NewHfJHWss9i4DaW+fuEQIEqaXqJV/n3WbyR+h0hs1
 5VCg==
X-Gm-Message-State: AOJu0YzNUtnDcF7t1jwV6iNyyMbD/W+jlDb55ebzebotm29x3aXW/lVr
 1RbnV2SNAAAw+R+/XCOajKKKnRKoRyvBfDXpgwdayKLx/dmUcPXr9J8+cQclbw==
X-Gm-Gg: Acq92OFlYalS427eJN9RjmSCE5ZyoIk2+7/oYGDrdbglgbNHr7HyZTlcxj1VeBrEpvE
 yiz7pQtdCenhhQXBZ04hhHe4uboxL8mGiqZVk6pZUsydXcAlMfLht62ibsnnOQNeNXb3LNSt16X
 8bd9f7RWOpg4NZQ+Dozs4Vi8r+lx8H0ezSxZA3lPIOU9S36PiaTr2a9UWiG1OQN2BNUjKoL5q35
 tf9LS3viUPAXHiFalZKgxe+yqAdbpAtnw1ZcZytMiwfRtcSrn2rKfBGdazuADMFdWjPyn8zp3vd
 C43hslRtKchLG7VrY7n3Vjk2JUVr2YvruLKlKXZgP1/RfUGLwHbZsZNyJQC5iyzgnq0nTM5QYRS
 cDuw4j9UOQzKRmhVMSISIaohH90ct47z11bMouUQrzjzFKlH4n/CpTAa47zJL167K56ENuyCzaB
 cxX2US70JgrHsUhZiPsJkxoMnS03awj8J7J2SDNNqKFpK8O6wsJEFLLLjimtfBp5mZS66q9Frp
X-Received: by 2002:a17:907:28ca:b0:b9b:1963:2ff2 with SMTP id
 a640c23a62f3a-bf36d2c1748mr330079766b.0.1780968400036; 
 Mon, 08 Jun 2026 18:26:40 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05208e897sm942980166b.25.2026.06.08.18.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:26:38 -0700 (PDT)
Message-ID: <8a86f850-bc3b-4de1-b7c7-43d9b89a5856@gmail.com>
Date: Tue, 9 Jun 2026 03:26:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 8/8] Kconfig: board: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
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

Restyle all Kconfigs:
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 board/alliedtelesis/SBx81LIFKW/Kconfig   |  2 +-
 board/alliedtelesis/SBx81LIFXCAT/Kconfig |  2 +-
 board/beagle/beagleboneai64/Kconfig      |  4 +-
 board/beagle/beagleplay/Kconfig          | 12 ++---
 board/beagle/beagley-ai/Kconfig          |  2 +-
 board/cortina/common/Kconfig             | 10 ++--
 board/cortina/presidio-asic/Kconfig      |  2 +-
 board/firefly/roc-pc-rk3399/Kconfig      |  2 +-
 board/imgtec/boston/Kconfig              |  2 +-
 board/logicpd/imx6/Kconfig               |  2 +-
 board/nxp/ls1012ardb/Kconfig             |  2 +-
 board/nxp/mx6memcal/Kconfig              | 60 ++++++++++++------------
 board/out4/o4-imx6ull-nano/Kconfig       | 20 ++++----
 board/phytec/common/Kconfig              | 18 +++----
 board/phytec/common/k3/Kconfig           |  4 +-
 board/phytec/phycore_am62ax/Kconfig      |  4 +-
 board/phytec/phycore_am62x/Kconfig       | 40 ++++++++--------
 board/phytec/phycore_am64x/Kconfig       | 34 +++++++-------
 board/phytec/phycore_am68x/Kconfig       |  4 +-
 board/samsung/axy17lte/Kconfig           | 12 ++---
 board/siemens/draco/Kconfig              |  4 +-
 board/socionext/developerbox/Kconfig     |  8 ++--
 board/sysam/amcore/Kconfig               |  6 +--
 board/ti/am62ax/Kconfig                  |  2 +-
 board/ti/am62px/Kconfig                  |  2 +-
 board/ti/am62x/Kconfig                   |  4 +-
 board/ti/am64x/Kconfig                   |  4 +-
 board/ti/am65x/Kconfig                   |  4 +-
 board/ti/common/Kconfig                  |  4 +-
 board/ti/j7200/Kconfig                   |  4 +-
 board/ti/j721e/Kconfig                   |  4 +-
 board/ti/j721s2/Kconfig                  |  4 +-
 board/ti/j722s/Kconfig                   |  2 +-
 board/ti/j784s4/Kconfig                  |  8 ++--
 board/toradex/apalis_imx6/Kconfig        | 12 ++---
 board/toradex/aquila-am69/Kconfig        |  4 +-
 board/toradex/colibri_imx6/Kconfig       |  2 +-
 board/toradex/verdin-am62p/Kconfig       | 28 +++++------
 board/traverse/common/Kconfig            |  4 +-
 board/xilinx/Kconfig                     |  2 +-
 40 files changed, 175 insertions(+), 175 deletions(-)

diff --git a/board/alliedtelesis/SBx81LIFKW/Kconfig b/board/alliedtelesis/SBx81LIFKW/Kconfig
index 5c2609b7f464..49516b7f0078 100644
--- a/board/alliedtelesis/SBx81LIFKW/Kconfig
+++ b/board/alliedtelesis/SBx81LIFKW/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
        default "SBx81LIFKW"

 config SYS_VENDOR
-       default "alliedtelesis"
+	default "alliedtelesis"

 config SYS_CONFIG_NAME
        default "SBx81LIFKW"
diff --git a/board/alliedtelesis/SBx81LIFXCAT/Kconfig b/board/alliedtelesis/SBx81LIFXCAT/Kconfig
index 524c2900892e..20e02144d3a0 100644
--- a/board/alliedtelesis/SBx81LIFXCAT/Kconfig
+++ b/board/alliedtelesis/SBx81LIFXCAT/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
        default "SBx81LIFXCAT"

 config SYS_VENDOR
-       default "alliedtelesis"
+	default "alliedtelesis"

 config SYS_CONFIG_NAME
        default "SBx81LIFXCAT"
diff --git a/board/beagle/beagleboneai64/Kconfig b/board/beagle/beagleboneai64/Kconfig
index 0f21582614d5..7d7077e9f28e 100644
--- a/board/beagle/beagleboneai64/Kconfig
+++ b/board/beagle/beagleboneai64/Kconfig
@@ -34,7 +34,7 @@ config SYS_BOARD
        default "beagleboneai64"

 config SYS_VENDOR
-       default "beagle"
+	default "beagle"

 config SYS_CONFIG_NAME
        default "beagleboneai64"
@@ -49,7 +49,7 @@ config SYS_BOARD
        default "beagleboneai64"

 config SYS_VENDOR
-       default "beagle"
+	default "beagle"

 config SYS_CONFIG_NAME
        default "beagleboneai64"
diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
index 592b53e493c0..fcc6a5aa4960 100644
--- a/board/beagle/beagleplay/Kconfig
+++ b/board/beagle/beagleplay/Kconfig
@@ -30,13 +30,13 @@ endchoice
 if TARGET_AM625_A53_BEAGLEPLAY

 config SYS_BOARD
-       default "beagleplay"
+	default "beagleplay"

 config SYS_VENDOR
-       default "beagle"
+	default "beagle"

 config SYS_CONFIG_NAME
-       default "beagleplay"
+	default "beagleplay"

 source "board/ti/common/Kconfig"

@@ -45,13 +45,13 @@ endif
 if TARGET_AM625_R5_BEAGLEPLAY

 config SYS_BOARD
-       default "beagleplay"
+	default "beagleplay"

 config SYS_VENDOR
-       default "beagle"
+	default "beagle"

 config SYS_CONFIG_NAME
-       default "beagleplay"
+	default "beagleplay"

 config SPL_LDSCRIPT
 	default "arch/arm/mach-omap2/u-boot-spl.lds"
diff --git a/board/beagle/beagley-ai/Kconfig b/board/beagle/beagley-ai/Kconfig
index bf9539821515..07aedc2ea3f9 100644
--- a/board/beagle/beagley-ai/Kconfig
+++ b/board/beagle/beagley-ai/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "beagley-ai"

 config SYS_VENDOR
-       default "beagle"
+	default "beagle"

 config SYS_CONFIG_NAME
        default "beagley_ai"
diff --git a/board/cortina/common/Kconfig b/board/cortina/common/Kconfig
index 00c709e70f0d..bf5229abd75a 100644
--- a/board/cortina/common/Kconfig
+++ b/board/cortina/common/Kconfig
@@ -1,6 +1,6 @@
 config CORTINA_PLATFORM
-       bool "Cortina-Access Platform"
-       default y
-       help
-         Select this option for Cortina-Access platforms
-	 to enables selection of CAxxxx drivers
+	bool "Cortina-Access Platform"
+	default y
+	help
+	  Select this option for Cortina-Access platforms
+	  to enables selection of CAxxxx drivers
diff --git a/board/cortina/presidio-asic/Kconfig b/board/cortina/presidio-asic/Kconfig
index 8e6f6cfa27ca..7bf8b78742ab 100644
--- a/board/cortina/presidio-asic/Kconfig
+++ b/board/cortina/presidio-asic/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_PRESIDIO_ASIC
 config BIT64
        bool
-       default y
+	default y

 select SOC_CA7774

diff --git a/board/firefly/roc-pc-rk3399/Kconfig b/board/firefly/roc-pc-rk3399/Kconfig
index c211e9d3c796..b800f7d2102a 100644
--- a/board/firefly/roc-pc-rk3399/Kconfig
+++ b/board/firefly/roc-pc-rk3399/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
         default "roc-pc-rk3399"

 config SYS_VENDOR
-        default "firefly"
+	default "firefly"

 config SYS_CONFIG_NAME
         default "roc-pc-rk3399"
diff --git a/board/imgtec/boston/Kconfig b/board/imgtec/boston/Kconfig
index 965847d9650d..d7d8bfd0a761 100644
--- a/board/imgtec/boston/Kconfig
+++ b/board/imgtec/boston/Kconfig
@@ -11,7 +11,7 @@ config SYS_CONFIG_NAME


 config ENV_SOURCE_FILE
-       default "boston"
+	default "boston"

 config TEXT_BASE
 	default 0x9fc00000 if 32BIT
diff --git a/board/logicpd/imx6/Kconfig b/board/logicpd/imx6/Kconfig
index f5e2f58b12be..dfc196124f3a 100644
--- a/board/logicpd/imx6/Kconfig
+++ b/board/logicpd/imx6/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
        default "imx6"

 config SYS_VENDOR
-       default "logicpd"
+	default "logicpd"

 config SYS_CONFIG_NAME
        default "imx6_logic"
diff --git a/board/nxp/ls1012ardb/Kconfig b/board/nxp/ls1012ardb/Kconfig
index bbe5ce21109e..ff5a57aaa412 100644
--- a/board/nxp/ls1012ardb/Kconfig
+++ b/board/nxp/ls1012ardb/Kconfig
@@ -63,7 +63,7 @@ config SYS_BOARD
         default "ls1012ardb"

 config SYS_VENDOR
-        default "nxp"
+	default "nxp"

 config SYS_SOC
         default "fsl-layerscape"
diff --git a/board/nxp/mx6memcal/Kconfig b/board/nxp/mx6memcal/Kconfig
index a6c39d5e4d10..03d8422242f3 100644
--- a/board/nxp/mx6memcal/Kconfig
+++ b/board/nxp/mx6memcal/Kconfig
@@ -35,30 +35,30 @@ choice
 	  The choices below reflect the most commonly used options
 	  for your UART.

-	config UART2_EIM_D26_27
-		bool "UART2 on EIM_D26/27 (SabreLite, Nitrogen6x)"
-		depends on SERIAL_CONSOLE_UART2
-		help
-		  Choose this configuration if you're using pads
-		  EIM_D26 and D27 for a console on UART2.
-		  This is typical for designs that are based on the
-		  NXP SABRELite.
-
-	config UART1_CSI0_DAT10_11
-		bool "UART1 on CSI0_DAT10/11 (Wand, SabreSD)"
-		depends on SERIAL_CONSOLE_UART1
-		help
-		  Choose this configuration if you're using pads
-		  CSI0_DAT10 and DAT11 for a console on UART1 as
-		  is done on the i.MX6 Wand board and i.MX6 SabreSD.
-
-	config UART1_UART1
-		bool "UART1 on UART1 (i.MX6SL EVK, WaRP)"
-		depends on SERIAL_CONSOLE_UART1
-		help
-		  Choose this configuration if you're using pads
-		  UART1_TXD/RXD for a console on UART1 as is done
-		  on most i.MX6SL designs.
+config UART2_EIM_D26_27
+	bool "UART2 on EIM_D26/27 (SabreLite, Nitrogen6x)"
+	depends on SERIAL_CONSOLE_UART2
+	help
+	  Choose this configuration if you're using pads
+	  EIM_D26 and D27 for a console on UART2.
+	  This is typical for designs that are based on the
+	  NXP SABRELite.
+
+config UART1_CSI0_DAT10_11
+	bool "UART1 on CSI0_DAT10/11 (Wand, SabreSD)"
+	depends on SERIAL_CONSOLE_UART1
+	help
+	  Choose this configuration if you're using pads
+	  CSI0_DAT10 and DAT11 for a console on UART1 as
+	  is done on the i.MX6 Wand board and i.MX6 SabreSD.
+
+config UART1_UART1
+	bool "UART1 on UART1 (i.MX6SL EVK, WaRP)"
+	depends on SERIAL_CONSOLE_UART1
+	help
+	  Choose this configuration if you're using pads
+	  UART1_TXD/RXD for a console on UART1 as is done
+	  on most i.MX6SL designs.

 endchoice

@@ -215,12 +215,12 @@ config REFR
 	range 0 7
 	default 7
 	help
-	   This selects the number of refreshes (-1) during each period.
-	   i.e.:
-	   0 == 1 refresh (tRFC)
-	   7 == 8 refreshes (tRFC*8)
-	   See the description of MDREF[REFR] in the reference manual for
-	   details.
+	  This selects the number of refreshes (-1) during each period.
+	  i.e.:
+	  0 == 1 refresh (tRFC)
+	  7 == 8 refreshes (tRFC*8)
+	  See the description of MDREF[REFR] in the reference manual for
+	  details.

 endmenu

diff --git a/board/out4/o4-imx6ull-nano/Kconfig b/board/out4/o4-imx6ull-nano/Kconfig
index e2ab80b6d4d8..1b948fdc9ff3 100644
--- a/board/out4/o4-imx6ull-nano/Kconfig
+++ b/board/out4/o4-imx6ull-nano/Kconfig
@@ -13,21 +13,21 @@ choice
 	prompt "Memory model"
 	default K4B4G1646D_BCMA
 	help
-	    Memory type setup.
+	  Memory type setup.

 	    Please choose correct memory model here.

 config K4B4G1646D_BCMA
 	bool "K4B4G1646D-BCMA 256Mx16 (512 MiB/chip)"
 	help
-	    Samsung DDR3 SDRAM
-	    K4B4G1646D-BCMA
+	  Samsung DDR3 SDRAM
+	  K4B4G1646D-BCMA

 config MT41K256M16HA_125E
 	bool "MT41K256M16HA-125:E 256Mx16 (512 MiB/chip)"
 	help
-	    Micron DDR3L SDRAM
-	    MT41K256M16HA-125:E
+	  Micron DDR3L SDRAM
+	  MT41K256M16HA-125:E

 endchoice

@@ -35,21 +35,21 @@ choice
 	prompt "Mainboard model"
 	default O4_IMX_NANO
 	help
-	    Mainboard setup.
+	  Mainboard setup.

 	    Please choose correct main board model here.

 config O4_IMX_NANO
 	bool "O4-iMX-NANO"
 	help
-	    A baseboard for EV-iMX280-NANO module:
-	    https://out4.ru/products/board/18-o4-imx-nano.html
+	  A baseboard for EV-iMX280-NANO module:
+	  https://out4.ru/products/board/18-o4-imx-nano.html

 config EV_IMX280_NANO_X_MB
 	bool "EV-IMX280-NANO-X-MB"
 	help
-	    A simple baseboard for EV-iMX280-NANO module:
-	    http://evodbg.net/products/mx28-eval-kits/14-ev-imx280-nano-x-mb.html
+	  A simple baseboard for EV-iMX280-NANO module:
+	  http://evodbg.net/products/mx28-eval-kits/14-ev-imx280-nano-x-mb.html

 endchoice

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index 6afd03086f7a..87fa70632e5d 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -2,14 +2,14 @@ config PHYTEC_SOM_DETECTION
 	bool "Support SoM detection for PHYTEC platforms"
 	select SPL_CRC8 if SPL
 	help
-	   Support of I2C EEPROM based SoM detection.
+	  Support of I2C EEPROM based SoM detection.

 config PHYTEC_SOM_DETECTION_BLOCKS
 	bool "Extend SoM detection with block support"
 	depends on PHYTEC_SOM_DETECTION
 	help
-	   Extend the I2C EEPROM based SoM detection with API v3. This API
-	   introduces blocks with different payloads.
+	  Extend the I2C EEPROM based SoM detection with API v3. This API
+	  introduces blocks with different payloads.

 config PHYTEC_IMX8M_SOM_DETECTION
 	bool "Support SoM detection for i.MX8M PHYTEC platforms"
@@ -35,8 +35,8 @@ config PHYTEC_AM62_SOM_DETECTION
 	depends on SPL_I2C && DM_I2C
 	default y
 	help
-	   Support of I2C EEPROM based SoM detection. Supported
-	   for PHYTEC AM62x boards.
+	  Support of I2C EEPROM based SoM detection. Supported
+	  for PHYTEC AM62x boards.

 config PHYTEC_AM62A_SOM_DETECTION
 	bool "Support SoM detection for AM62Ax PHYTEC platforms"
@@ -46,8 +46,8 @@ config PHYTEC_AM62A_SOM_DETECTION
 	depends on SPL_I2C && DM_I2C
 	default y
 	help
-	   Support of I2C EEPROM based SoM detection. Supported
-	   for PHYTEC AM62Ax boards.
+	  Support of I2C EEPROM based SoM detection. Supported
+	  for PHYTEC AM62Ax boards.

 config PHYTEC_AM64_SOM_DETECTION
 	bool "Support SoM detection for AM64x PHYTEC platforms"
@@ -57,8 +57,8 @@ config PHYTEC_AM64_SOM_DETECTION
 	depends on SPL_I2C && DM_I2C
 	default y
 	help
-	   Support of I2C EEPROM based SoM detection. Supported
-	   for PHYTEC AM64x boards.
+	  Support of I2C EEPROM based SoM detection. Supported
+	  for PHYTEC AM64x boards.

 config PHYTEC_EEPROM_BUS
 	int "Board EEPROM's I2C bus number"
diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
index 282f4b797429..4bbe1a5ec3cc 100644
--- a/board/phytec/common/k3/Kconfig
+++ b/board/phytec/common/k3/Kconfig
@@ -1,5 +1,5 @@
 config PHYTEC_K3_DDR_PATCH
 	bool "Patch DDR timings on PHYTEC K3 SoMs"
 	help
-	   Allow to override default DDR timings prior to
-	   DDRSS driver probing.
+	  Allow to override default DDR timings prior to
+	  DDRSS driver probing.
diff --git a/board/phytec/phycore_am62ax/Kconfig b/board/phytec/phycore_am62ax/Kconfig
index 516dc8e20201..e7943c51dbc2 100644
--- a/board/phytec/phycore_am62ax/Kconfig
+++ b/board/phytec/phycore_am62ax/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "phycore_am62ax"

 config SYS_VENDOR
-       default "phytec"
+	default "phytec"

 config SYS_CONFIG_NAME
        default "phycore_am62ax"
@@ -24,7 +24,7 @@ config SYS_BOARD
        default "phycore_am62ax"

 config SYS_VENDOR
-       default "phytec"
+	default "phytec"

 config SYS_CONFIG_NAME
        default "phycore_am62ax"
diff --git a/board/phytec/phycore_am62x/Kconfig b/board/phytec/phycore_am62x/Kconfig
index ecee5873c0c9..feacc3d6d402 100644
--- a/board/phytec/phycore_am62x/Kconfig
+++ b/board/phytec/phycore_am62x/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "phycore_am62x"

 config SYS_VENDOR
-       default "phytec"
+	default "phytec"

 config SYS_CONFIG_NAME
        default "phycore_am62x"
@@ -24,7 +24,7 @@ config SYS_BOARD
        default "phycore_am62x"

 config SYS_VENDOR
-       default "phytec"
+	default "phytec"

 config SYS_CONFIG_NAME
        default "phycore_am62x"
@@ -38,31 +38,31 @@ source "board/phytec/common/k3/Kconfig"
 endif

 config PHYCORE_AM62X_RAM_SIZE_FIX
-        bool "Set phyCORE-AM62x RAM size fix instead of detecting"
-        default false
-        help
-          RAM size is automatic being detected with the help of
-          the EEPROM introspection data. Set RAM size to a fix value
-          instead.
+	bool "Set phyCORE-AM62x RAM size fix instead of detecting"
+	default false
+	help
+	  RAM size is automatic being detected with the help of
+	  the EEPROM introspection data. Set RAM size to a fix value
+	  instead.

 choice
-        prompt "phyCORE-AM62x RAM size"
-        depends on PHYCORE_AM62X_RAM_SIZE_FIX
-        default PHYCORE_AM62X_RAM_SIZE_2GB
+	prompt "phyCORE-AM62x RAM size"
+	depends on PHYCORE_AM62X_RAM_SIZE_FIX
+	default PHYCORE_AM62X_RAM_SIZE_2GB

 config PHYCORE_AM62X_RAM_SIZE_1GB
-        bool "1GB RAM"
-        help
-          Set RAM size fix to 1GB for phyCORE-AM62x.
+	bool "1GB RAM"
+	help
+	  Set RAM size fix to 1GB for phyCORE-AM62x.

 config PHYCORE_AM62X_RAM_SIZE_2GB
-        bool "2GB RAM"
-        help
-          Set RAM size fix to 2GB for phyCORE-AM62x.
+	bool "2GB RAM"
+	help
+	  Set RAM size fix to 2GB for phyCORE-AM62x.

 config PHYCORE_AM62X_RAM_SIZE_4GB
-        bool "4GB RAM"
-        help
-          Set RAM size fix to 4GB for phyCORE-AM62x.
+	bool "4GB RAM"
+	help
+	  Set RAM size fix to 4GB for phyCORE-AM62x.

 endchoice
diff --git a/board/phytec/phycore_am64x/Kconfig b/board/phytec/phycore_am64x/Kconfig
index a709b71ba4dc..a4d25b84b96c 100644
--- a/board/phytec/phycore_am64x/Kconfig
+++ b/board/phytec/phycore_am64x/Kconfig
@@ -12,7 +12,7 @@ config SYS_BOARD
        default "phycore_am64x"

 config SYS_VENDOR
-       default "phytec"
+	default "phytec"

 config SYS_CONFIG_NAME
        default "phycore_am64x"
@@ -27,7 +27,7 @@ config SYS_BOARD
        default "phycore_am64x"

 config SYS_VENDOR
-       default "phytec"
+	default "phytec"

 config SYS_CONFIG_NAME
        default "phycore_am64x"
@@ -37,26 +37,26 @@ source "board/phytec/common/Kconfig"
 endif

 config PHYCORE_AM64X_RAM_SIZE_FIX
-        bool "Set phyCORE-AM64x RAM size fix instead of detecting"
-        default false
-        help
-          RAM size is automatic being detected with the help of
-          the EEPROM introspection data. Set RAM size to a fix value
-          instead.
+	bool "Set phyCORE-AM64x RAM size fix instead of detecting"
+	default false
+	help
+	  RAM size is automatic being detected with the help of
+	  the EEPROM introspection data. Set RAM size to a fix value
+	  instead.

 choice
-        prompt "phyCORE-AM64x RAM size"
-        depends on PHYCORE_AM64X_RAM_SIZE_FIX
-        default PHYCORE_AM64X_RAM_SIZE_2GB
+	prompt "phyCORE-AM64x RAM size"
+	depends on PHYCORE_AM64X_RAM_SIZE_FIX
+	default PHYCORE_AM64X_RAM_SIZE_2GB

 config PHYCORE_AM64X_RAM_SIZE_1GB
-        bool "1GB RAM"
-        help
-          Set RAM size fix to 1GB for phyCORE-AM64x.
+	bool "1GB RAM"
+	help
+	  Set RAM size fix to 1GB for phyCORE-AM64x.

 config PHYCORE_AM64X_RAM_SIZE_2GB
-        bool "2GB RAM"
-        help
-          Set RAM size fix to 2GB for phyCORE-AM64x.
+	bool "2GB RAM"
+	help
+	  Set RAM size fix to 2GB for phyCORE-AM64x.

 endchoice
diff --git a/board/phytec/phycore_am68x/Kconfig b/board/phytec/phycore_am68x/Kconfig
index 37912fb4ed32..d82cdaf819b9 100644
--- a/board/phytec/phycore_am68x/Kconfig
+++ b/board/phytec/phycore_am68x/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "phycore_am68x"

 config SYS_VENDOR
-       default "phytec"
+	default "phytec"

 config SYS_CONFIG_NAME
        default "phycore_am68x"
@@ -27,7 +27,7 @@ config SYS_BOARD
        default "phycore_am68x"

 config SYS_VENDOR
-       default "phytec"
+	default "phytec"

 config SYS_CONFIG_NAME
        default "phycore_am68x"
diff --git a/board/samsung/axy17lte/Kconfig b/board/samsung/axy17lte/Kconfig
index 64a4ffa7e673..d98da0ecab5c 100644
--- a/board/samsung/axy17lte/Kconfig
+++ b/board/samsung/axy17lte/Kconfig
@@ -11,8 +11,8 @@ config SYS_CONFIG_NAME
 	default "exynos78x0-common"

 config EXYNOS7880
-    bool "Exynos 7880 SOC support"
-    default y
+	bool "Exynos 7880 SOC support"
+	default y
 endif

 if TARGET_A7Y17LTE
@@ -28,8 +28,8 @@ config SYS_CONFIG_NAME
 	default "exynos78x0-common"

 config EXYNOS7880
-    bool "Exynos 7880 SOC support"
-    default y
+	bool "Exynos 7880 SOC support"
+	default y
 endif

 if TARGET_A3Y17LTE
@@ -45,6 +45,6 @@ config SYS_CONFIG_NAME
 	default "exynos78x0-common"

 config EXYNOS7870
-    bool "Exynos 7870 SOC support"
-    default y
+	bool "Exynos 7870 SOC support"
+	default y
 endif
diff --git a/board/siemens/draco/Kconfig b/board/siemens/draco/Kconfig
index 9d45c4239be4..3f2e75b03fe2 100644
--- a/board/siemens/draco/Kconfig
+++ b/board/siemens/draco/Kconfig
@@ -33,10 +33,10 @@ endif
 if TARGET_ETAMIN

 config SYS_BOARD
-        default "draco"
+	default "draco"

 config SYS_VENDOR
-        default "siemens"
+	default "siemens"

 config SYS_SOC
         default "am33xx"
diff --git a/board/socionext/developerbox/Kconfig b/board/socionext/developerbox/Kconfig
index c181d26a44a6..1b1c9181bad7 100644
--- a/board/socionext/developerbox/Kconfig
+++ b/board/socionext/developerbox/Kconfig
@@ -11,10 +11,10 @@ config TARGET_DEVELOPERBOX
 	select SYS_DISABLE_DCACHE_OPS
 	select OF_BOARD_SETUP
 	help
-	 Choose this option if you build the U-Boot for the DeveloperBox
-	 96boards Enterprise Edition.
-	 This board will booted from SCP firmware and it enables SMMU, thus
-	 the dcache is updated automatically when DMA operation is executed.
+	  Choose this option if you build the U-Boot for the DeveloperBox
+	  96boards Enterprise Edition.
+	  This board will booted from SCP firmware and it enables SMMU, thus
+	  the dcache is updated automatically when DMA operation is executed.
 endchoice

 config SYS_SOC
diff --git a/board/sysam/amcore/Kconfig b/board/sysam/amcore/Kconfig
index b5c81dda237d..7efd857dc32c 100644
--- a/board/sysam/amcore/Kconfig
+++ b/board/sysam/amcore/Kconfig
@@ -4,13 +4,13 @@ config SYS_CPU
         default "mcf530x"

 config SYS_BOARD
-        default "amcore"
+	default "amcore"

 config SYS_VENDOR
-        default "sysam"
+	default "sysam"

 config SYS_CONFIG_NAME
-        default "amcore"
+	default "amcore"

 endif

diff --git a/board/ti/am62ax/Kconfig b/board/ti/am62ax/Kconfig
index 51e7b3e0eaba..a80ea9149b1f 100644
--- a/board/ti/am62ax/Kconfig
+++ b/board/ti/am62ax/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "am62ax"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "am62ax_evm"
diff --git a/board/ti/am62px/Kconfig b/board/ti/am62px/Kconfig
index 9d95ffd9b290..1011b89d75f6 100644
--- a/board/ti/am62px/Kconfig
+++ b/board/ti/am62px/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "am62px"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "am62px_evm"
diff --git a/board/ti/am62x/Kconfig b/board/ti/am62x/Kconfig
index 610dacfdc085..eb54154d1ce0 100644
--- a/board/ti/am62x/Kconfig
+++ b/board/ti/am62x/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "am62x"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "am62x_evm"
@@ -24,7 +24,7 @@ config SYS_BOARD
        default "am62x"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "am62x_evm"
diff --git a/board/ti/am64x/Kconfig b/board/ti/am64x/Kconfig
index b873476a9d5f..c727b7f8c161 100644
--- a/board/ti/am64x/Kconfig
+++ b/board/ti/am64x/Kconfig
@@ -8,7 +8,7 @@ config SYS_BOARD
        default "am64x"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "am64x_evm"
@@ -23,7 +23,7 @@ config SYS_BOARD
        default "am64x"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "am64x_evm"
diff --git a/board/ti/am65x/Kconfig b/board/ti/am65x/Kconfig
index eb47a25c70a5..fe3fa13dc4b4 100644
--- a/board/ti/am65x/Kconfig
+++ b/board/ti/am65x/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "am65x"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "am65x_evm"
@@ -24,7 +24,7 @@ config SYS_BOARD
        default "am65x"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "am65x_evm"
diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index 149909093b38..6762d08d4001 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -1,8 +1,8 @@
 config TI_I2C_BOARD_DETECT
 	bool "Support for Board detection for TI platforms"
 	help
-	   Support for detection board information on Texas Instrument's
-	   Evaluation Boards which have I2C based EEPROM detection
+	  Support for detection board information on Texas Instrument's
+	  Evaluation Boards which have I2C based EEPROM detection

 config EEPROM_BUS_ADDRESS
 	int "Board EEPROM's I2C bus address"
diff --git a/board/ti/j7200/Kconfig b/board/ti/j7200/Kconfig
index 093d23e7bf85..38edbe129684 100644
--- a/board/ti/j7200/Kconfig
+++ b/board/ti/j7200/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "j7200"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j721e_evm"
@@ -27,7 +27,7 @@ config SYS_BOARD
        default "j7200"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j721e_evm"
diff --git a/board/ti/j721e/Kconfig b/board/ti/j721e/Kconfig
index 7c7e23988d80..d85056e65bbc 100644
--- a/board/ti/j721e/Kconfig
+++ b/board/ti/j721e/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "j721e"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j721e_evm"
@@ -27,7 +27,7 @@ config SYS_BOARD
        default "j721e"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j721e_evm"
diff --git a/board/ti/j721s2/Kconfig b/board/ti/j721s2/Kconfig
index 40853a8fd667..34a3e6ef187e 100644
--- a/board/ti/j721s2/Kconfig
+++ b/board/ti/j721s2/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "j721s2"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j721s2_evm"
@@ -27,7 +27,7 @@ config SYS_BOARD
        default "j721s2"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j721s2_evm"
diff --git a/board/ti/j722s/Kconfig b/board/ti/j722s/Kconfig
index 68c214e473be..e819ba2f554f 100644
--- a/board/ti/j722s/Kconfig
+++ b/board/ti/j722s/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "j722s"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j722s_evm"
diff --git a/board/ti/j784s4/Kconfig b/board/ti/j784s4/Kconfig
index de95ac575d79..40c4913aea14 100644
--- a/board/ti/j784s4/Kconfig
+++ b/board/ti/j784s4/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "j784s4"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j784s4_evm"
@@ -24,7 +24,7 @@ config SYS_BOARD
        default "j784s4"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j784s4_evm"
@@ -42,7 +42,7 @@ config SYS_BOARD
        default "j784s4"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j784s4_evm"
@@ -57,7 +57,7 @@ config SYS_BOARD
        default "j784s4"

 config SYS_VENDOR
-       default "ti"
+	default "ti"

 config SYS_CONFIG_NAME
        default "j784s4_evm"
diff --git a/board/toradex/apalis_imx6/Kconfig b/board/toradex/apalis_imx6/Kconfig
index c6ff387351c4..fc4cbe3323c7 100644
--- a/board/toradex/apalis_imx6/Kconfig
+++ b/board/toradex/apalis_imx6/Kconfig
@@ -35,7 +35,7 @@ config TDX_CMD_IMX_MFGR
 	bool "Enable factory testing commands for Toradex iMX 6 modules"
 	help
 	  This adds the commands
-	    pf0100_otp_prog - Program the OTP fuses on the PMIC PF0100
+	  pf0100_otp_prog - Program the OTP fuses on the PMIC PF0100
 	  If executed on already fused modules it doesn't change any fuse setting.
 	default y

@@ -43,11 +43,11 @@ config TDX_APALIS_IMX6_V1_0
 	bool "Apalis iMX6 V1.0 HW"
 	help
 	  Apalis iMX6 V1.0 HW has a different pinout for the UART.
-	    The UARTs must be used in DCE mode, RTS/CTS are swapped and
-	    thus unusable on standard carrier boards.
-	    This option configures DCE mode unconditionally. Whithout this
-	    option the config block stating V1.0 HW selects DCE mode,
-	    otherwise the UARTs are configuered in DTE mode.
+	  The UARTs must be used in DCE mode, RTS/CTS are swapped and
+	  thus unusable on standard carrier boards.
+	  This option configures DCE mode unconditionally. Whithout this
+	  option the config block stating V1.0 HW selects DCE mode,
+	  otherwise the UARTs are configuered in DTE mode.

 source "board/toradex/common/Kconfig"

diff --git a/board/toradex/aquila-am69/Kconfig b/board/toradex/aquila-am69/Kconfig
index 6afa97e2c828..b44b9247603c 100644
--- a/board/toradex/aquila-am69/Kconfig
+++ b/board/toradex/aquila-am69/Kconfig
@@ -9,7 +9,7 @@ config SYS_BOARD
        default "aquila-am69"

 config SYS_VENDOR
-       default "toradex"
+	default "toradex"

 config SYS_CONFIG_NAME
        default "aquila-am69"
@@ -48,7 +48,7 @@ config SYS_BOARD
        default "aquila-am69"

 config SYS_VENDOR
-       default "toradex"
+	default "toradex"

 config SYS_CONFIG_NAME
        default "aquila-am69"
diff --git a/board/toradex/colibri_imx6/Kconfig b/board/toradex/colibri_imx6/Kconfig
index d2ad1ce2a033..53d3469d439a 100644
--- a/board/toradex/colibri_imx6/Kconfig
+++ b/board/toradex/colibri_imx6/Kconfig
@@ -35,7 +35,7 @@ config TDX_CMD_IMX_MFGR
 	bool "Enable factory testing commands for Toradex iMX 6 modules"
 	help
 	  This adds the commands
-	    pf0100_otp_prog - Program the OTP fuses on the PMIC PF0100
+	  pf0100_otp_prog - Program the OTP fuses on the PMIC PF0100
 	  If executed on already fused modules it doesn't change any fuse setting.
 	default y

diff --git a/board/toradex/verdin-am62p/Kconfig b/board/toradex/verdin-am62p/Kconfig
index a65caf3c26df..4f5968bca2ea 100644
--- a/board/toradex/verdin-am62p/Kconfig
+++ b/board/toradex/verdin-am62p/Kconfig
@@ -8,22 +8,22 @@ choice
 	optional

 config TARGET_VERDIN_AM62P_A53
-        bool "Toradex Verdin AM62P running on A53"
-        select ARM64
-        select BINMAN
-        select OF_SYSTEM_SETUP
-        imply OF_UPSTREAM
+	bool "Toradex Verdin AM62P running on A53"
+	select ARM64
+	select BINMAN
+	select OF_SYSTEM_SETUP
+	imply OF_UPSTREAM

 config TARGET_VERDIN_AM62P_R5
-        bool "Toradex Verdin AM62P running on R5"
-        select CPU_V7R
-        select SYS_THUMB_BUILD
-        select K3_LOAD_SYSFW
-        select RAM
-        select SPL_RAM
-        select K3_DDRSS
-        select BINMAN
-        imply SYS_K3_SPL_ATF
+	bool "Toradex Verdin AM62P running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF

 endchoice

diff --git a/board/traverse/common/Kconfig b/board/traverse/common/Kconfig
index d34832bd0d30..96b2566b697f 100644
--- a/board/traverse/common/Kconfig
+++ b/board/traverse/common/Kconfig
@@ -2,5 +2,5 @@ config TEN64_CONTROLLER
 	bool "Enable Ten64 board controller driver"
 	depends on TARGET_TEN64
 	help
-		Support for the board microcontroller on the Traverse
-		Ten64 family of boards.
+	  Support for the board microcontroller on the Traverse
+	  Ten64 family of boards.
diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
index 5c3240da0733..07fc8da1b71a 100644
--- a/board/xilinx/Kconfig
+++ b/board/xilinx/Kconfig
@@ -67,7 +67,7 @@ config BOOT_SCRIPT_OFFSET
 	default 0x7F80000 if ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	default 0 if TARGET_XILINX_MBV
 	help
-	   Specifies distro boot script offset in NAND/QSPI/NOR flash.
+	  Specifies distro boot script offset in NAND/QSPI/NOR flash.

 config CMD_FRU
 	bool "FRU information for product"
--
2.39.5

