Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370C4C83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33738835AA;
	Fri, 18 Jul 2025 03:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e0uhkHOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C2B9805D7; Fri, 18 Jul 2025 03:15:46 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D87835B2
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73e82d2ec21so214587a34.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801343; x=1753406143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/pFE0ESEGGA8+zyM0SKXKjNvMk/CVxKGbhNIyUt1Y5Y=;
 b=e0uhkHOOVAQ6b24sX9rdbj3BRD32tDxWoqsbfasYRu4McJBWTcwSU5j9/aiw5vchFN
 4KEF9v1MfzrSUYxjUJlnfscO9cB0kUB9kFSYTINDNY0b2JkXgFqbpWEAB3c8NEbI72tc
 sJFcsedWbw5vKeY/Hxx6DfVwMonLzPr3VgpTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801343; x=1753406143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/pFE0ESEGGA8+zyM0SKXKjNvMk/CVxKGbhNIyUt1Y5Y=;
 b=MGxg35GMdPWLYf5Mq9Y9/kSdGnGX4P89SuAOdF7wBZTMhjz3LUeMD9FIjoKbDeCmhY
 PIQRvjtWBDHYGTCgS/2MwdUL6O0q4qqzMN9glbVkMWeEjFeAFa4Yt8gQAzNUeDvIdgE8
 llXJP7FqTtCP8pf/UhHjypdxynnR/V64OnvvEGcEy2ND4gGvu+hHPJ+wc793x1Dz7jLT
 uxcPHigfEYk9jf8J7QAjzZOf79ECUpzeQsLoahqnaadueZ2bWqbAEjwxzg7AkH+7+/Nz
 2hzb+8yUc94DLRMtbpXbKK4yj4RXMWB4mYHRGnE4vqUa+Z1w15525aYIg9a50mIijBkY
 on1Q==
X-Gm-Message-State: AOJu0Yxcm0i0+NKccypPWIbislQjhUytvcsAi0lbwQnLMjNBeRFedSvu
 ghnAgS4NhDR1mcKUzT2awQB8UkXQy3Oewm/KxHLckx73AbJfE1goUDUSbLlZWZQXD7966o/HIcb
 xpwciI/4=
X-Gm-Gg: ASbGncs8XtFcyDrELYdXyI5dbuJABqZoYFUi7/Cxr1IqjcO9E6AvfRDsiO4gRqZ0+Qr
 ug5KHW+AISvUi4NZHht0J3MwneWmTMd1vtt76XNL0gNhBRac/HXcoQFjh6eoSb+4gDjesXQJ3hA
 BM7muauGiO9QmF1sTRgHhLhuS/NeVeGy8vWaEOAhSRaiDb6B8jhPchjYK5eqwT2GBlPZ2q20TuJ
 FIlbCFMa+TKPgIFzpyfTj1C+BgbONcNqwc49Tslpf+iqRNAJfBhpeLQvBXS3nXH08Bayj8rmBsL
 w3yoMSsVoxktg+M1rJbsW/+6d2NS4AqXKFLfoOn8Abz/bQgpiqfD8gW2MBvpyNHpgbjqGazbpvS
 z8cAPMSyQ0z0vSX3p70aqNwIkazCVmWBO4CM5g6gQ3sUCeiM0vAqNObec6Lw2ftjPfkD7HA==
X-Google-Smtp-Source: AGHT+IGbrTL7dYLPmy0t7YKRZbNjNxz9p2jtrvsJ6r3zmAQyvkNbLtT8OlFPDBViS/1Fli2+6BPuxA==
X-Received: by 2002:a05:6830:43a2:b0:73e:5def:537 with SMTP id
 46e09a7af769-73e7538d38emr4689150a34.21.1752801342585; 
 Thu, 17 Jul 2025 18:15:42 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b66c03sm217371a34.49.2025.07.17.18.15.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:15:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] net: Tighten some network driver dependencies
Date: Thu, 17 Jul 2025 19:15:40 -0600
Message-ID: <20250718011540.1333950-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

A large number of network drivers cannot build without access to some
platform specific header files. Express those requirements in Kconfig as
well. This covers the QUICC engine drivers as that is networking
driver infrastructure.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/net/Kconfig         | 28 ++++++++++++++++++++--------
 drivers/net/pfe_eth/Kconfig |  1 +
 drivers/net/qe/Kconfig      |  1 +
 drivers/net/ti/Kconfig      |  3 +++
 drivers/qe/Kconfig          |  1 +
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f8c7637f0b9c..9f206c0b56de 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -173,6 +173,7 @@ config CORTINA_NI_ENET
 
 config CALXEDA_XGMAC
 	bool "Calxeda XGMAC support"
+	depends on ARCH_HIGHBANK
 	help
 	  This driver supports the XGMAC in Calxeda Highbank and Midway
 	  machines.
@@ -222,14 +223,14 @@ config DWC_ETH_QOS
 
 config DWC_ETH_QOS_ADI
 	bool "Synopsys DWC Ethernet QOS device support for ADI SC59x-64 parts"
-	depends on DWC_ETH_QOS
+	depends on DWC_ETH_QOS && ARCH_SC5XX
 	help
 		The Synopsis Designware Ethernet QoS IP block with the specific
 		configuration used in the ADI ADSP-SC59X 64 bit SoCs
 
 config DWC_ETH_QOS_IMX
 	bool "Synopsys DWC Ethernet QOS device support for IMX"
-	depends on DWC_ETH_QOS
+	depends on DWC_ETH_QOS && MACH_IMX
 	help
 	  The Synopsys Designware Ethernet QOS IP block with the specific
 	  configuration used in IMX soc.
@@ -243,7 +244,7 @@ config DWC_ETH_QOS_INTEL
 
 config DWC_ETH_QOS_ROCKCHIP
 	bool "Synopsys DWC Ethernet QOS device support for Rockchip SoCs"
-	depends on DWC_ETH_QOS
+	depends on DWC_ETH_QOS && ARCH_ROCKCHIP
 	select DM_ETH_PHY
 	help
 	  The Synopsys Designware Ethernet QOS IP block with specific
@@ -251,7 +252,7 @@ config DWC_ETH_QOS_ROCKCHIP
 
 config DWC_ETH_QOS_STM32
 	bool "Synopsys DWC Ethernet QOS device support for STM32"
-	depends on DWC_ETH_QOS
+	depends on DWC_ETH_QOS && ARCH_STM32MP
 	select DM_ETH_PHY
 	default y if ARCH_STM32MP
 	help
@@ -303,7 +304,7 @@ config E1000_SPI_GENERIC
 
 config E1000_SPI
 	bool "Enable SPI bus utility code"
-	depends on E1000
+	depends on E1000 && !E1000_NO_NVM
 	help
 	  Utility code for direct access to the SPI bus on Intel 8257x.
 	  This does not do anything useful unless you set at least one
@@ -319,6 +320,7 @@ config CMD_E1000
 
 config EEPRO100
 	bool "Intel PRO/100 82557/82559/82559ER Fast Ethernet support"
+	depends on !64BIT
 	help
 	  This driver supports Intel(R) PRO/100 82557/82559/82559ER fast
 	  ethernet family of adapters.
@@ -382,7 +384,7 @@ config ETH_DESIGNWARE_SOCFPGA
 
 config ETH_DESIGNWARE_S700
 	bool "Actins S700 glue driver for Synopsys Designware Ethernet MAC"
-	depends on ETH_DESIGNWARE
+	depends on ETH_DESIGNWARE && ARCH_OWL
 	help
 	  This provides glue layer to use Synopsys Designware Ethernet MAC
 	  present on Actions S700 SoC.
@@ -416,7 +418,7 @@ config FEC_MXC
 
 config FMAN_ENET
 	bool "Freescale FMan ethernet support"
-	depends on ARM || PPC
+	depends on FSL_LSCH2 || PPC
 	select SYS_FMAN_V3 if ARCH_B4420 || ARCH_B4860 || ARCH_LS1043A || \
 		ARCH_LS1046A || ARCH_T1024 || ARCH_T1040 || ARCH_T1042 || \
 		ARCH_T2080 || ARCH_T4240
@@ -488,6 +490,7 @@ config SYS_DISCOVER_PHY
 
 config MCFFEC
 	bool "ColdFire Ethernet Support"
+	depends on M68K
 	select PHYLIB
 	select SYS_DISCOVER_PHY
 	help
@@ -551,6 +554,7 @@ config MVPP2
 
 config MACB
 	bool "Cadence MACB/GEM Ethernet Interface"
+	depends on ARM || RISCV
 	select PHYLIB
 	help
 	  The Cadence MACB ethernet interface is found on many Atmel
@@ -587,6 +591,7 @@ config MT7628_ETH
 
 config NET_NPCM750
 	bool "Nuvoton NPCM750 Ethernet MAC"
+	depends on ARCH_NPCM
 	help
 	  support NPCM750 EMAC
 
@@ -661,6 +666,7 @@ source "drivers/net/qe/Kconfig"
 
 config RTL8139
 	bool "Realtek 8139 series Ethernet controller driver"
+	depends on !64BIT
 	help
 	  This driver supports Realtek 8139 series fast ethernet family of
 	  PCI chipsets/adapters.
@@ -714,6 +720,7 @@ config SUN7I_GMAC_FORCE_TXERR
 
 config SUN4I_EMAC
 	bool "Allwinner Sun4i Ethernet MAC support"
+	depends on ARCH_SUNXI
 	select PHYLIB
 	help
 	  This driver supports the Allwinner based SUN4I Ethernet MAC.
@@ -729,6 +736,7 @@ config SUN8I_EMAC
 
 config SH_ETHER
 	bool "Renesas SH Ethernet MAC"
+	depends on ARCH_RENESAS
 	select PHYLIB
 	select PHY_ETHERNET_ID
 	help
@@ -738,6 +746,7 @@ source "drivers/net/ti/Kconfig"
 
 config TULIP
 	bool "DEC Tulip DC2114x Ethernet support"
+	depends on !64BIT
 	help
 	  This driver supports DEC DC2114x Fast ethernet chips.
 
@@ -791,6 +800,7 @@ config XILINX_AXIMRMAC
 
 config VSC7385_ENET
 	bool "Vitesse 7385 Switch Firmware Upload driver"
+	depends on !COMPILE_TEST && PPC
 
 config XILINX_EMACLITE
 	select PHYLIB
@@ -802,6 +812,7 @@ config XILINX_EMACLITE
 config ZYNQ_GEM
 	select PHYLIB
 	bool "Xilinx Ethernet GEM"
+	depends on ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || ARCH_ZYNQ || ARCH_ZYNQMP
 	help
 	  This MAC is present in Xilinx Zynq and ZynqMP SoCs.
 
@@ -815,7 +826,7 @@ config PIC32_ETH
 
 config GMAC_ROCKCHIP
 	bool "Rockchip Synopsys Designware Ethernet MAC"
-	depends on ETH_DESIGNWARE
+	depends on ETH_DESIGNWARE && ARCH_ROCKCHIP
 	help
 	  This driver provides Rockchip SoCs network support based on the
 	  Synopsys Designware driver.
@@ -942,6 +953,7 @@ config SYS_FSL_QMAN_V3
 config TSEC_ENET
 	select PHYLIB
 	bool "Enable Three-Speed Ethernet Controller"
+	depends on ARCH_LS1021A || PPC
 	help
 	  This driver implements support for the (Enhanced) Three-Speed
 	  Ethernet Controller found on Freescale SoCs.
diff --git a/drivers/net/pfe_eth/Kconfig b/drivers/net/pfe_eth/Kconfig
index b2724ee3e846..f5947ab5f17f 100644
--- a/drivers/net/pfe_eth/Kconfig
+++ b/drivers/net/pfe_eth/Kconfig
@@ -1,5 +1,6 @@
 menuconfig FSL_PFE
 	bool "NXP PFE Ethernet driver"
+	depends on ARCH_LS1012A
 	help
 	  This driver provides support for NXP's Packet Forwarding Engine.
 
diff --git a/drivers/net/qe/Kconfig b/drivers/net/qe/Kconfig
index e795e913d42d..34de23903100 100644
--- a/drivers/net/qe/Kconfig
+++ b/drivers/net/qe/Kconfig
@@ -4,5 +4,6 @@
 
 config QE_UEC
 	bool "NXP QE UEC Ethernet controller"
+	depends on PPC
 	help
 	  This driver supports the NXP QE UEC ethernet controller
diff --git a/drivers/net/ti/Kconfig b/drivers/net/ti/Kconfig
index ddfa95a0b7e9..52267339de08 100644
--- a/drivers/net/ti/Kconfig
+++ b/drivers/net/ti/Kconfig
@@ -4,6 +4,7 @@
 
 config DRIVER_TI_CPSW
 	bool "TI Common Platform Ethernet Switch"
+	depends on ARCH_OMAP2PLUS
 	select PHYLIB
 	help
 	  This driver supports the TI three port switch gigabit ethernet
@@ -11,6 +12,7 @@ config DRIVER_TI_CPSW
 
 config DRIVER_TI_EMAC
 	bool "TI Davinci EMAC"
+	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS
 	help
 	   Support for davinci emac
 
@@ -22,6 +24,7 @@ config DRIVER_TI_EMAC_USE_RMII
 
 config DRIVER_TI_KEYSTONE_NET
 	bool "TI Keystone 2 Ethernet"
+	depends on ARCH_KEYSTONE
 	help
 	   This driver supports the TI Keystone 2 Ethernet subsystem
 
diff --git a/drivers/qe/Kconfig b/drivers/qe/Kconfig
index 89a75c175b00..22ed80bfc66e 100644
--- a/drivers/qe/Kconfig
+++ b/drivers/qe/Kconfig
@@ -11,6 +11,7 @@ config QE
 
 config U_QE
 	bool "Enable support for U QUICC Engine"
+	depends on PPC || ARCH_LS1012A || ARCH_LS1021A || ARCH_LS1043A
 	default y if (ARCH_LS1021A && !SD_BOOT && !NAND_BOOT && !QSPI_BOOT) \
 		|| (TARGET_T1024QDS) \
 		|| (TARGET_T1024RDB) \
-- 
2.43.0

