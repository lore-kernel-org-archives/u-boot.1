Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264EAC27C50
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 01:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F6D88245;
	Wed,  5 Jun 2024 03:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QjODm7pX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD9C88292; Wed,  5 Jun 2024 03:37:50 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222158822D
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 03:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f264d5dadaso3840519a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 18:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717551466; x=1718156266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m23SCUNw23Hll2FPL8r/RfukmnIJhTVAiQ8i2WUNJo0=;
 b=QjODm7pXG0c+a8aIwiok3RaCooQgCOlCrVfkO9r1TC3iLxBBSp1+uHU2L4JXiN2op4
 84pBsO/J9MKBBlTJ3er7r1T2NyYQ+13f8j96aWHYe9OXP91OvWr+O7JytghPRiLtdmPb
 sblyfbtHy3/Vnt8KkMXv7Csbf9gN5/iiz3wNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717551466; x=1718156266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m23SCUNw23Hll2FPL8r/RfukmnIJhTVAiQ8i2WUNJo0=;
 b=WE0lo1P7z1joR2KcXjCPlHCJjKzFfXSOa0suOWA74GX/RsZjQGEmIGE8XpV0ZuUH7l
 AiuyU1pju7QLzjCWjkyIo4Tn7Myt3zPtof0FRnC8Ac8A/taxX6R4qsPoQzC4bE+yO578
 1U2KQlHyEunppK3UC9Sx0TkT5/+3uRhxGsGdaDUl9YlPYZitYDarb6IHBv29MT1ygsuV
 +mZSDLhX1+o5r/LwaWvP2puq4IRSlehOP9bYEcsChRVLFJUMDaqTG+0qNG3hsoPHuv/l
 Rnn5cPNwbmVhSAw55PMLd7nF63RPHTyzA5H4lwbW9du6dHrMilz14Vp6WFAfZn3f8NsR
 MieQ==
X-Gm-Message-State: AOJu0YxJKtlW0fERSS1Z0KHcNN+ygSKGYHBiXwOTtFIj9pvHkvfRcBdD
 U1VWJdXKr5quRMwVQ2IVu7gXchKwDIafWLWUsIDEvAOlUMOpzSLaORMVAg2U1CIwl8NFLw/fc+9
 1l1Y=
X-Google-Smtp-Source: AGHT+IGCK3VE0R0YAKBnCH8oPsA280Uxm6Mb2ja/jg00HNQ/+SGtn4wt6XUw92qH4FCd6iXEDzxl2w==
X-Received: by 2002:a05:6870:1713:b0:250:7913:170b with SMTP id
 586e51a60fabf-2512294cf49mr1344728fac.55.1717551465587; 
 Tue, 04 Jun 2024 18:37:45 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-100-45.totalplay.net. [189.203.100.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2508522515asm3660485fac.43.2024.06.04.18.37.44
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 18:37:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] block: Update BLK to be def_bool
Date: Tue,  4 Jun 2024 19:37:42 -0600
Message-Id: <20240605013742.576403-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013742.576403-1-trini@konsulko.com>
References: <20240605013742.576403-1-trini@konsulko.com>
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

At this point in the DM migration, all platforms enable DM. BLK requires
DM. Make BLK "def_bool y" in the cases it had been "default y" to make
this clearer. Now remove the symbol requirement from other places as it
is redundant here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/ata/Kconfig   |  1 -
 drivers/block/Kconfig |  4 ++--
 drivers/mmc/Kconfig   | 30 ++++++++++++++----------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9bc5283c2688..6cca561f974f 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -61,7 +61,6 @@ config DWC_AHCI
 config DWC_AHSATA
 	bool "Enable DWC AHSATA driver support"
 	select LIBATA
-	depends on BLK
 	help
 	  Enable this driver to support the DWC AHSATA SATA controller found
 	  in i.MX5 and i.MX6 SoCs.
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 6ad18889f61e..48529a6982f5 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -1,8 +1,8 @@
 config BLK
 	bool # "Support block devices"
 	depends on DM
-	default y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
-	default y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
+	def_bool y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
+	def_bool y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
 	help
 	  Enable support for block devices, such as SCSI, MMC and USB
 	  flash sticks. These provide a block-level interface which permits
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index d0944793c92d..8b13a0821ee0 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -41,7 +41,6 @@ config MMC_BROKEN_CD
 config DM_MMC
 	bool "Enable MMC controllers using Driver Model"
 	depends on DM
-	select BLK
 	help
 	  This enables the MultiMediaCard (MMC) uclass which supports MMC and
 	  Secure Digital I/O (SDIO) cards. Both removable (SD, micro-SD, etc.)
@@ -249,7 +248,6 @@ config MMC_DW_CORTINA
 	bool "Cortina specific extensions for Synopsys DW Memory Card Interface"
 	depends on DM_MMC
 	depends on MMC_DW
-	depends on BLK
 	help
 	  This selects support for Cortina SoC specific extensions to the
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
@@ -313,7 +311,7 @@ config NEXELL_DWMMC
 
 config MMC_MESON_GX
 	bool "Meson GX EMMC controller support"
-	depends on DM_MMC && BLK && ARCH_MESON
+	depends on DM_MMC && ARCH_MESON
 	help
 	 Support for EMMC host controller on Meson GX ARM SoCs platform (S905)
 
@@ -367,7 +365,7 @@ config MMC_OCTEONTX
 
 config MVEBU_MMC
 	bool "Kirkwood MMC controller support"
-	depends on DM_MMC && BLK && ARCH_KIRKWOOD
+	depends on DM_MMC && ARCH_KIRKWOOD
 	help
 	  Support for MMC host controller on Kirkwood SoCs.
 	  If you are on a Kirkwood architecture, say Y here.
@@ -420,7 +418,7 @@ config SH_MMCIF
 config MMC_UNIPHIER
 	bool "UniPhier SD/MMC Host Controller support"
 	depends on ARCH_UNIPHIER
-	depends on BLK && DM_MMC
+	depends on DM_MMC
 	depends on OF_CONTROL
 	help
 	  This selects support for the Matsushita SD/MMC Host Controller on
@@ -429,7 +427,7 @@ config MMC_UNIPHIER
 config RENESAS_SDHI
 	bool "Renesas R-Car SD/MMC Host Controller support"
 	depends on ARCH_RENESAS
-	depends on BLK && DM_MMC
+	depends on DM_MMC
 	depends on OF_CONTROL
 	select BOUNCE_BUFFER
 	help
@@ -439,7 +437,7 @@ config RENESAS_SDHI
 config MMC_BCM2835
 	bool "BCM2835 family custom SD/MMC Host Controller support"
 	depends on ARCH_BCM283X
-	depends on BLK && DM_MMC
+	depends on DM_MMC
 	depends on OF_CONTROL
 	default y
 	help
@@ -459,7 +457,7 @@ config JZ47XX_MMC
 config MMC_SANDBOX
 	bool "Sandbox MMC support"
 	depends on SANDBOX
-	depends on BLK && DM_MMC && OF_CONTROL
+	depends on DM_MMC && OF_CONTROL
 	help
 	  This select a dummy sandbox MMC driver. At present this does nothing
 	  other than allow sandbox to be build with MMC support. This
@@ -561,7 +559,7 @@ config MMC_SDHCI_ASPEED
 config MMC_SDHCI_ATMEL
 	bool "Atmel SDHCI controller support"
 	depends on ARCH_AT91
-	depends on DM_MMC && BLK && ARCH_AT91
+	depends on DM_MMC && ARCH_AT91
 	depends on MMC_SDHCI
 	help
 	  This enables support for the Atmel SDHCI controller, which supports
@@ -596,7 +594,7 @@ config MMC_SDHCI_BCMSTB
 
 config MMC_SDHCI_CADENCE
 	bool "SDHCI support for the Cadence SD/SDIO/eMMC controller"
-	depends on BLK && DM_MMC
+	depends on DM_MMC
 	depends on MMC_SDHCI
 	depends on OF_CONTROL
 	help
@@ -608,7 +606,7 @@ config MMC_SDHCI_CADENCE
 
 config MMC_SDHCI_CV1800B
 	bool "SDHCI support for the CV1800B SD/SDIO/eMMC controller"
-	depends on BLK && DM_MMC
+	depends on DM_MMC
 	depends on MMC_SDHCI
 	depends on OF_CONTROL
 	help
@@ -643,7 +641,7 @@ config MMC_SDHCI_IPROC
 
 config MMC_SDHCI_F_SDH30
 	bool "SDHCI support for Fujitsu Semiconductor/Socionext F_SDH30"
-	depends on BLK && DM_MMC
+	depends on DM_MMC
 	depends on MMC_SDHCI
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
@@ -663,7 +661,7 @@ config MMC_SDHCI_KONA
 
 config MMC_SDHCI_MSM
 	bool "Qualcomm SDHCI controller"
-	depends on BLK && DM_MMC
+	depends on DM_MMC
 	depends on MMC_SDHCI
 	help
 	  Enables support for SDHCI 2.0 controller present on some Qualcomm
@@ -829,7 +827,7 @@ config MMC_PITON
 
 config GENERIC_ATMEL_MCI
 	bool "Atmel Multimedia Card Interface support"
-	depends on DM_MMC && BLK && ARCH_AT91
+	depends on DM_MMC && ARCH_AT91
 	help
 	  This enables support for Atmel High Speed Multimedia Card Interface
 	  (HSMCI), which supports the MultiMedia Card (MMC) Specification V4.3,
@@ -838,7 +836,7 @@ config GENERIC_ATMEL_MCI
 
 config STM32_SDMMC2
 	bool "STMicroelectronics STM32H7 SD/MMC Host Controller support"
-	depends on DM_MMC && BLK && OF_CONTROL
+	depends on DM_MMC && OF_CONTROL
 	help
 	  This selects support for the SD/MMC controller on STM32H7 SoCs.
 	  If you have a board based on such a SoC and with a SD/MMC slot,
@@ -858,7 +856,7 @@ config FTSDC010_SDIO
 config MMC_MTK
 	bool "MediaTek SD/MMC Card Interface support"
 	depends on ARCH_MEDIATEK || ARCH_MTMIPS
-	depends on BLK && DM_MMC
+	depends on DM_MMC
 	depends on OF_CONTROL
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
-- 
2.34.1

