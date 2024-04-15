Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1241C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C531888228;
	Mon, 15 Apr 2024 08:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE9A2881FA; Mon, 15 Apr 2024 08:08:17 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCA088195
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYW3zn0z9t1J;
 Mon, 15 Apr 2024 08:08:15 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gOSQ2Uj_i-Af; Mon, 15 Apr 2024 08:08:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYK4tvTz9t0b;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A35AC8B770;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QMaKXNmRIEe5; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 739FA8B764;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 10/17] board: cssi: add support for reading temperature
Date: Mon, 15 Apr 2024 08:07:23 +0200
Message-ID: <54e5e03ea68a6d352ae593c47114ddfb4ff034e4.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
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

All CSSI boards have an LM74 chip as temperature sensor.

Enable it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/dts/cmpc885.dts | 12 +++++++++++-
 arch/powerpc/dts/cmpcpro.dts | 12 +++++++++++-
 arch/powerpc/dts/mcr3000.dts |  6 ++++++
 configs/CMPC885_defconfig    |  3 +++
 configs/CMPCPRO_defconfig    |  3 +++
 configs/MCR3000_defconfig    |  3 +++
 6 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/dts/cmpc885.dts b/arch/powerpc/dts/cmpc885.dts
index 9a33e7e77c..454ceb91ca 100644
--- a/arch/powerpc/dts/cmpc885.dts
+++ b/arch/powerpc/dts/cmpc885.dts
@@ -85,12 +85,22 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc8xx-spi";
-			gpios = <&CPM1_PIO_B 21 1>; /* /EEPROM_CS ACTIVE_LOW */
+			gpios = <&CPM1_PIO_B 21 1	/* /EEPROM_CS ACTIVE_LOW */
+				 &CPM1_PIO_B 23 1	/* Temperature mother board */
+				 &CPM1_PIO_B 14 1>;	/* Temperature CPU board */
 
 			eeprom@0 {
 				reg = <0>;
 				compatible = "atmel,at25", "cs,eeprom";
 			};
+			temp@1 {
+				reg = <1>;
+				compatible = "ti,lm74";
+			};
+			temp@2 {
+				reg = <2>;
+				compatible = "ti,lm74";
+			};
 		};
 	};
 };
diff --git a/arch/powerpc/dts/cmpcpro.dts b/arch/powerpc/dts/cmpcpro.dts
index 78f8a9f4d3..1dfa864ebb 100644
--- a/arch/powerpc/dts/cmpcpro.dts
+++ b/arch/powerpc/dts/cmpcpro.dts
@@ -140,12 +140,22 @@
 			compatible = "fsl,mpc832x-spi";
 			reg = <0x4c0 0x40>;
 			mode = "cpu";
-			gpios = <&qe_pio_d 3 1>;
+			gpios = <&qe_pio_d 3 1
+				 &qe_pio_c 5 1		/* TEMP mother board */
+				 &qe_pio_c 3 1>;	/* TEMP CPU board */
 			clock-frequency = <0>;
 			eeprom@0 {
 				reg = <0>;
 				compatible = "atmel,at25", "cs,eeprom";
 			};
+			temp@1 {
+				reg = <1>;
+				compatible = "ti,lm74";
+			};
+			temp@2 {
+				reg = <2>;
+				compatible = "ti,lm74";
+			};
 		};
 		eth0: ucc@3000 {
 			device_type = "network";
diff --git a/arch/powerpc/dts/mcr3000.dts b/arch/powerpc/dts/mcr3000.dts
index edcd8358d0..f678951e22 100644
--- a/arch/powerpc/dts/mcr3000.dts
+++ b/arch/powerpc/dts/mcr3000.dts
@@ -33,6 +33,12 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl,mpc8xx-spi";
+			gpios = <&csspi 2 0>;
+
+			temp@0 {
+				reg = <0>;
+				compatible = "ti,lm74";
+			};
 		};
 	};
 
diff --git a/configs/CMPC885_defconfig b/configs/CMPC885_defconfig
index bbe8d5be7e..11c24f72a8 100644
--- a/configs/CMPC885_defconfig
+++ b/configs/CMPC885_defconfig
@@ -50,6 +50,7 @@ CONFIG_CMD_ASKENV=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
@@ -107,6 +108,8 @@ CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MPC8XX_SPI=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_LM74_THERMAL=y
 CONFIG_WDT=y
 CONFIG_WDT_MPC8xxx_BME=y
 # CONFIG_REGEX is not set
diff --git a/configs/CMPCPRO_defconfig b/configs/CMPCPRO_defconfig
index cefed63f24..f8f5c9fd86 100644
--- a/configs/CMPCPRO_defconfig
+++ b/configs/CMPCPRO_defconfig
@@ -134,6 +134,7 @@ CONFIG_CMD_ASKENV=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_DHCP=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_MII=y
@@ -197,6 +198,8 @@ CONFIG_DM_SPI=y
 CONFIG_MPC8XXX_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_MPC83XX=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_LM74_THERMAL=y
 CONFIG_WDT=y
 CONFIG_WDT_MPC8xxx=y
 # CONFIG_REGEX is not set
diff --git a/configs/MCR3000_defconfig b/configs/MCR3000_defconfig
index ce34c2aa88..f2eac2c544 100644
--- a/configs/MCR3000_defconfig
+++ b/configs/MCR3000_defconfig
@@ -47,6 +47,7 @@ CONFIG_CMD_ASKENV=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND=y
+CONFIG_CMD_TEMPERATURE=y
 # CONFIG_CMD_ECHO is not set
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
@@ -107,6 +108,8 @@ CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MPC8XX_SPI=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_LM74_THERMAL=y
 CONFIG_WDT=y
 CONFIG_WDT_MPC8xxx_BME=y
 CONFIG_LZMA=y
-- 
2.43.0

