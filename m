Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC35C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E4287FEF;
	Tue, 27 Feb 2024 14:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="nsM0BcQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D1E87FEE; Tue, 27 Feb 2024 14:44:27 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AAD87FF5
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1709041465; x=1740577465;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s9YSV2iSBIpwQHtXo4h1zezLc3X3a2f/lBlNy/bF0AM=;
 b=nsM0BcQ/DGEvj4wue8fhsemHq2bpsunuDLqb3zM0OOhDtzFODsqzLLxc
 x0UqVt2aSnCLELmu+HavFdOhedPFrItis37X0X2xN0c0GFXVKq4ZAwG7U
 2aaY5ooW1iM4yy6+0SU9ykrN5VyDsULm1ehUXCO9Kw3PBoX9W4bRhzXAD
 AkjFdNaoA1DCC0nRJ0URkyG23luRipS27NnLYe5zXCZW7uUCtiwy7R9XS
 yIvBl8iKVIyccOHbk4TAGcpo6aXdacR6Xc+B66gjktaTW10vYWvlQvKZ6
 ZgF5YnthLtCt4mZR6viX30RZYgKPkS6YW5V3My1lUtJjXdjZ7Zvklmwls w==;
X-CSE-ConnectionGUID: rMT+by1bQ1ie1abVCT+3tw==
X-CSE-MsgGUID: 6/R8JGtZSY+ibOGuL93sgQ==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; d="scan'208";a="17418740"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2024 06:44:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:44:07 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 06:44:06 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 0/4] Add initial support for Microchip SAMA7G54 Curiosity
 board
Date: Tue, 27 Feb 2024 15:43:59 +0200
Message-ID: <20240227134403.10686-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patch series adds initial support for Microchip SAMA7G54 Curiosity board.

Changes in v2:
--------------

* Update flexcom 10 node in order to match previous flexcom definitions.
* Sort in alphabetical order all nodes and pinctrl.
* Remove status okay from leds, nand, eeprom, flash.
* Add CONFIG_ENV_SIZE=0x4000 in mmc defconfig.
* Set CONFIG_ENV_SECT_SIZE=0x10000 in qspiflash defconfig.

Mihai Sain (4):
  ARM: dts: at91: sama7g5: Add flexcom 10 node
  ARM: dts: at91: sama7g54_curiosity: Add initial device tree of the board
  board: at91: sama7g54_curiosity: Add initial board support
  configs: at91: sama7g54_curiosity: Add initial default configs

 arch/arm/dts/Makefile                         |   3 +
 .../dts/at91-sama7g54_curiosity-u-boot.dtsi   |  59 +++++
 arch/arm/dts/at91-sama7g54_curiosity.dts      | 242 ++++++++++++++++++
 arch/arm/dts/sama7g5.dtsi                     |  24 ++
 arch/arm/mach-at91/Kconfig                    |  10 +
 board/atmel/sama7g54_curiosity/Kconfig        |  15 ++
 board/atmel/sama7g54_curiosity/MAINTAINERS    |   9 +
 board/atmel/sama7g54_curiosity/Makefile       |   7 +
 .../sama7g54_curiosity/sama7g54_curiosity.c   |  36 +++
 configs/sama7g54_curiosity_mmc_defconfig      | 123 +++++++++
 .../sama7g54_curiosity_nandflash_defconfig    | 122 +++++++++
 .../sama7g54_curiosity_qspiflash_defconfig    | 122 +++++++++
 include/configs/sama7g54_curiosity.h          |  17 ++
 13 files changed, 789 insertions(+)
 create mode 100644 arch/arm/dts/at91-sama7g54_curiosity-u-boot.dtsi
 create mode 100644 arch/arm/dts/at91-sama7g54_curiosity.dts
 create mode 100644 board/atmel/sama7g54_curiosity/Kconfig
 create mode 100644 board/atmel/sama7g54_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sama7g54_curiosity/Makefile
 create mode 100644 board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
 create mode 100644 configs/sama7g54_curiosity_mmc_defconfig
 create mode 100644 configs/sama7g54_curiosity_nandflash_defconfig
 create mode 100644 configs/sama7g54_curiosity_qspiflash_defconfig
 create mode 100644 include/configs/sama7g54_curiosity.h

-- 
2.44.0

