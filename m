Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC30CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7974D84974;
	Wed, 10 Jun 2026 16:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AzJQIOuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA1A849AC; Wed, 10 Jun 2026 16:39:43 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F02F84963
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-691acf5ddb4so477820a12.3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102381; x=1781707181; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=++pMaTjkauraWl/tlOIvS+Ow3fOijOAaCP/QKy8GJMI=;
 b=AzJQIOuYHP4vLC1ur0p9s4R3UDYDKyNDDEn6O2F9nslv9E3orY/ANCu89gpzbGZwvR
 4yNWqzBuHucCbZZuBDn//I5Dgd52Ar8PQhpmSPdQ/QlTnH4hHfgi8JradYOfbA+4UBNF
 Ls3mQgmoHSa4BUCJW/8gxz5vF5kTCsTuwdbGrsu/Iq8NxryfBJ5Tu/+EVObTCDjsWxXu
 hYNZaBaQKDL5b1rG1n0+ehoYfYOiwitjnWYllYBnVXxC/1A03F0q1gDX5ofFHg1DF8pZ
 k/hp52IPq+7MJLpd4ev6GCxgI8BBSrPUW1R6Qe3Z8ulqfjz4z3RBlVGFJNMubIqFglCa
 Gnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102381; x=1781707181;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=++pMaTjkauraWl/tlOIvS+Ow3fOijOAaCP/QKy8GJMI=;
 b=q9Wav+2GhwppGJ2Hu1k7DXN9ONMn63iQsTFWpysoV/WIP/zu7yU0pxLJUVPHHn/atc
 A9ppOIV5h0sGOYfTOfY/fgw48gT7uAc+cGOAC0EFFOUM+gcxxo9XXigcw8Er5erx7xdA
 9hh8djYkYNwrvb6UEwz9Eb9XtWhfzduMIxSMBwUe4pNXII7r04VPbkms8lFOXF6gfMO/
 VSRBP5GkguZhTm+zeVHikMLCAMjQJCTn6+2lCV7JUktzjSqG0KGz10YQESOl+hLh/Xd4
 x0mnuuEohDugkB4C5wd4P6ptGRvKhQqZm5+sjoituW7ICBdNMkP1u00qa4iyoKRCiWln
 fJVQ==
X-Gm-Message-State: AOJu0YywNJALpBF4bYffMhdqnTMO5AWfRP8ap/khTp00/DH8ZqZgwzdC
 HyNGwi8gom2x/6+vlcbsKnQ0O3XZJ2IPcnyyuSmC7wnFQRISq2FaDCq1
X-Gm-Gg: Acq92OHK1A+iMQMZsc+/Eq4rtVx14kCDHK2pnm0Ji1c4pGmHSRaJOweCsCL93S4mCg+
 m5g+ctw8tO2qtRoROy8K2Ze7bynJ14enkV/9GF7hyzYBYoL0pG7jpDQw8E3IurbQFRjExokZ0Fy
 nREAifpmmYW0pJJb0dFPKKPDSUsbXyEZPfvy2VWSqEHzjFloZeogXqVbjDdobarZAoNAP14DB4J
 6fba3oWB4clzd98zpzcvarH47/m7hdlUBJgYToFEbPbVyMZABQehoFa/7jRsc8DqX9g5ZSdmMFz
 kAx56lcUHILGvCBD5GII5rhhAAosQbb6+33FRVfJSpXiSHIuX4AsvPVElfNa4KF4EQRh1bXzF0I
 2UO2MWoOEYTLBawQ7GzBvoVPOaGMEpw5D5n5WStYIzmfDCWf4mVfIfTHHlPCdHJmhcrZi9TvY1z
 FqZCnPbAheDxIppOtzJMthcKXL4s6XAYJvA2VCJJ962uafeelbVWsVueGcX9r+bTTOBQUeyIPQ
X-Received: by 2002:a05:6402:3226:b0:67c:9609:eb8c with SMTP id
 4fb4d7f45d1cf-69237dd856dmr1838056a12.8.1781102380530; 
 Wed, 10 Jun 2026 07:39:40 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64c2f358sm10174287a12.6.2026.06.10.07.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:39:40 -0700 (PDT)
Message-ID: <51ad2822-1267-4c5f-9fcb-a550be5cb23d@gmail.com>
Date: Wed, 10 Jun 2026 16:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 11/18] Kconfig: net: restyle
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

Restyle all Kconfigs for "net":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/net/Kconfig     | 48 ++++++++++++++++++++---------------------
 drivers/net/phy/Kconfig | 18 ++++++++--------
 drivers/net/ti/Kconfig  |  4 ++--
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 666618681df6..17d18d45712d 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -184,10 +184,10 @@ config CALXEDA_XGMAC
 config DWC_ETH_XGMAC
         bool
 	select PHYLIB
-        help
-          This driver supports the Synopsys Designware Ethernet XGMAC (10G
-          Ethernet MAC) IP block. The IP supports many options for bus type,
-          clocking/reset structure, and feature list.
+	help
+	  This driver supports the Synopsys Designware Ethernet XGMAC (10G
+	  Ethernet MAC) IP block. The IP supports many options for bus type,
+	  clocking/reset structure, and feature list.

 config DWC_ETH_XGMAC_SOCFPGA
 	bool "Synopsys DWC Ethernet XGMAC device support for SOCFPGA"
@@ -229,8 +229,8 @@ config DWC_ETH_QOS_ADI
 	bool "Synopsys DWC Ethernet QOS device support for ADI SC59x-64 parts"
 	depends on DWC_ETH_QOS && ARCH_SC5XX
 	help
-		The Synopsis Designware Ethernet QoS IP block with the specific
-		configuration used in the ADI ADSP-SC59X 64 bit SoCs
+	  The Synopsis Designware Ethernet QoS IP block with the specific
+	  configuration used in the ADI ADSP-SC59X 64 bit SoCs

 config DWC_ETH_QOS_IMX
 	bool "Synopsys DWC Ethernet QOS device support for IMX"
@@ -460,9 +460,9 @@ config FSL_FM_10GEC_REGULAR_NOTATION
 	help
 	  On SoCs T4240, T2080, LS1043A, etc, the notation between 10GEC and
 	  MAC as below:
-		10GEC1->MAC9, 10GEC2->MAC10, 10GEC3->MAC1, 10GEC4->MAC2
+	  10GEC1->MAC9, 10GEC2->MAC10, 10GEC3->MAC1, 10GEC4->MAC2
 	  While on SoCs T1024, etc, the notation between 10GEC and MAC as below:
-		10GEC1->MAC1, 10GEC2->MAC2
+	  10GEC1->MAC1, 10GEC2->MAC2
 	  so we introduce CONFIG_FSL_FM_10GEC_REGULAR_NOTATION to identify the
 	  new SoCs on which 10GEC enumeration is consistent with MAC
 	  enumeration.
@@ -529,7 +529,7 @@ config KSZ9477
 config LITEETH
 	bool "LiteX LiteEth Ethernet MAC"
 	help
-	 Driver for the LiteEth Ethernet MAC from LiteX.
+	  Driver for the LiteEth Ethernet MAC from LiteX.

 config MV88E6XXX
 	bool "Marvell MV88E6xxx Ethernet switch DSA driver"
@@ -701,12 +701,12 @@ config SJA1105
 	  family. These are 5-port devices and are managed over an SPI
 	  interface. Probing is handled based on OF bindings. The driver
 	  supports the following revisions:
-	    - SJA1105E (Gen. 1, No TT-Ethernet)
-	    - SJA1105T (Gen. 1, TT-Ethernet)
-	    - SJA1105P (Gen. 2, No SGMII, No TT-Ethernet)
-	    - SJA1105Q (Gen. 2, No SGMII, TT-Ethernet)
-	    - SJA1105R (Gen. 2, SGMII, No TT-Ethernet)
-	    - SJA1105S (Gen. 2, SGMII, TT-Ethernet)
+	  - SJA1105E (Gen. 1, No TT-Ethernet)
+	  - SJA1105T (Gen. 1, TT-Ethernet)
+	  - SJA1105P (Gen. 2, No SGMII, No TT-Ethernet)
+	  - SJA1105Q (Gen. 2, No SGMII, TT-Ethernet)
+	  - SJA1105R (Gen. 2, SGMII, No TT-Ethernet)
+	  - SJA1105S (Gen. 2, SGMII, TT-Ethernet)

 config SMC911X
 	bool "SMSC LAN911x and LAN921x controller driver"
@@ -740,11 +740,11 @@ config SUN4I_EMAC
 	  This driver supports the Allwinner based SUN4I Ethernet MAC.

 config SUN8I_EMAC
-        bool "Allwinner Sun8i Ethernet MAC support"
-        select PHYLIB
+	bool "Allwinner Sun8i Ethernet MAC support"
+	select PHYLIB
 	select PHY_GIGE
-        help
-          This driver supports the  Allwinner based SUN8I/SUN50I Ethernet MAC.
+	help
+	  This driver supports the  Allwinner based SUN8I/SUN50I Ethernet MAC.
 	  It can be found in H3/A64/A83T based SoCs and compatible with both
 	  External and Internal PHYs.

@@ -905,7 +905,7 @@ config FEC1_PHY
 	help
 	  Define to the hardcoded PHY address which corresponds
 	  to the given FEC; i. e.
-		#define CONFIG_FEC1_PHY 4
+	  #define CONFIG_FEC1_PHY 4
 	  means that the PHY with address 4 is connected to FEC1

 	  When set to -1, means to probe for first available.
@@ -929,7 +929,7 @@ config FEC2_PHY
 	help
 	  Define to the hardcoded PHY address which corresponds
 	  to the given FEC; i. e.
-		#define CONFIG_FEC1_PHY 4
+	  #define CONFIG_FEC1_PHY 4
 	  means that the PHY with address 4 is connected to FEC1

 	  When set to -1, means to probe for first available.
@@ -1034,7 +1034,7 @@ config MDIO_GPIO_BITBANG
 	bool "GPIO bitbanging MDIO driver"
 	depends on DM_MDIO && DM_GPIO
 	help
-	 Driver for bitbanging MDIO
+	  Driver for bitbanging MDIO

 config MDIO_MUX_I2CREG
 	bool "MDIO MUX accessed as a register over I2C"
@@ -1080,8 +1080,8 @@ config MDIO_MSCC_MIIM
 	depends on DM_MDIO
 	select REGMAP
 	help
-		This driver supports MDIO interface found in Microsemi and Microchip
-		network switches.
+	  This driver supports MDIO interface found in Microsemi and Microchip
+	  network switches.

 config MDIO_MUX_MMIOREG
 	bool "MDIO MUX accessed as a MMIO register access"
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 0025c895f125..3f7953d693c9 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -81,7 +81,7 @@ config PHYLIB_10G
 config PHY_ADIN
 	bool "Analog Devices Industrial Ethernet PHYs"
 	help
-		Add support for configuring RGMII on Analog Devices ADIN PHYs.
+	  Add support for configuring RGMII on Analog Devices ADIN PHYs.

 menuconfig PHY_AQUANTIA
 	bool "Aquantia Ethernet PHYs support"
@@ -126,9 +126,9 @@ config SYS_CORTINA_NO_FW_UPLOAD
 	bool "Cortina firmware loading support"
 	depends on PHY_CORTINA
 	help
-		Cortina phy has provision to store phy firmware in attached dedicated
-		EEPROM. And boards designed with such EEPROM does not require firmware
-		upload.
+	  Cortina phy has provision to store phy firmware in attached dedicated
+	  EEPROM. And boards designed with such EEPROM does not require firmware
+	  upload.

 choice
 	prompt "Location of the Cortina firmware"
@@ -167,7 +167,7 @@ config PHY_CORTINA_ACCESS
 	default y
 	depends on CORTINA_NI_ENET
 	help
-		Cortina Access Ethernet PHYs init process
+	  Cortina Access Ethernet PHYs init process

 config PHY_DAVICOM
 	bool "Davicom Ethernet PHYs support"
@@ -317,13 +317,13 @@ config PHY_TERANETICS

 config PHY_TI
 	bool "Texas Instruments Ethernet PHYs support"
-	---help---
+	help
 	  Adds PHY registration support for TI PHYs.

 config PHY_TI_DP83867
 	select PHY_TI
 	bool "Texas Instruments Ethernet DP83867 PHY support"
-	---help---
+	help
 	  Adds support for the TI DP83867 1Gbit PHY.

 config SPL_PHY_TI_DP83867
@@ -333,13 +333,13 @@ config SPL_PHY_TI_DP83867
 config PHY_TI_DP83869
 	select PHY_TI
 	bool "Texas Instruments Ethernet DP83869 PHY support"
-	---help---
+	help
 	  Adds support for the TI DP83869 1Gbit PHY.

 config PHY_TI_GENERIC
 	select PHY_TI
 	bool "Texas Instruments Generic Ethernet PHYs support"
-	---help---
+	help
 	  Adds support for Generic TI PHYs that don't need special handling but
 	  the PHY name is associated with a PHY ID.

diff --git a/drivers/net/ti/Kconfig b/drivers/net/ti/Kconfig
index 93c3a0c35f2e..2d72af8aade0 100644
--- a/drivers/net/ti/Kconfig
+++ b/drivers/net/ti/Kconfig
@@ -14,7 +14,7 @@ config DRIVER_TI_EMAC
 	bool "TI Davinci EMAC"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS
 	help
-	   Support for davinci emac
+	  Support for davinci emac

 config DRIVER_TI_EMAC_USE_RMII
 	depends on DRIVER_TI_EMAC
@@ -26,7 +26,7 @@ config DRIVER_TI_KEYSTONE_NET
 	bool "TI Keystone 2 Ethernet"
 	depends on ARCH_KEYSTONE
 	help
-	   This driver supports the TI Keystone 2 Ethernet subsystem
+	  This driver supports the TI Keystone 2 Ethernet subsystem

 choice
 	prompt "TI Keystone 2 Ethernet NETCP IP revision"
--
2.39.5

