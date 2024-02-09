Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3EFC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ACC487E50;
	Fri,  9 Feb 2024 10:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="zblVmirM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D11A87E59; Fri,  9 Feb 2024 10:48:19 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF7187B80
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1707472097; x=1739008097;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kI3ayFmNY4qEtXxmmoN3NPXO7bwlztWAC0/s7Aa6op8=;
 b=zblVmirM5vnGzTFQsoRV+JZHrGEypAp26F952zjwhBw02HAfA+dzLV3u
 K9cydKGfBpTop1Mc6xeE3VgoQVNIa1p/Ajhy9gKggM3wN/nRZ4hej8490
 RlNA/7o0gfxt4835XxZah0JOIS7xOLwEaRYyZhaY8qJJ1lHfVw4u8P+V1
 del6VfbOho5q0aIVcGlHu34KMNiZ/ncQLzHhuRW+E+tJNz4IyxmlUSMaS
 XDPUFsvNu3e/maeAOBVblqI1pUo6PiG12dvTywsQNNXzb46gmoHrl0NDB
 dIdsDgU+a3mSgTe2TLuz72e3oKsHBCAHdDaqS3oJxHReymu2pL7kP2kaU w==;
X-CSE-ConnectionGUID: 66jlKJ8MStW7WWgmZa/VmA==
X-CSE-MsgGUID: DDsMTzGUSgm+gw9tb5gPNw==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; d="scan'208";a="16528728"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2024 02:48:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 02:47:47 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 02:47:46 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 0/4] Add initial support for Microchip SAMA7G54 Curiosity board
Date: Fri, 9 Feb 2024 11:47:33 +0200
Message-ID: <20240209094737.38347-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
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

Mihai Sain (4):
  ARM: dts: at91: sama7g5: add flexcom 10 node
  ARM: dts: at91: sama7g54_curiosity: Add initial device tree of the board
  board: at91: sama7g54_curiosity: Add initial board support
  configs: at91: sama7g54_curiosity: Add initial default configs

 arch/arm/dts/Makefile                         |   3 +
 .../dts/at91-sama7g54_curiosity-u-boot.dtsi   |  59 +++++
 arch/arm/dts/at91-sama7g54_curiosity.dts      | 246 ++++++++++++++++++
 arch/arm/dts/sama7g5.dtsi                     |  26 ++
 arch/arm/mach-at91/Kconfig                    |  10 +
 board/atmel/sama7g54_curiosity/Kconfig        |  15 ++
 board/atmel/sama7g54_curiosity/MAINTAINERS    |   9 +
 board/atmel/sama7g54_curiosity/Makefile       |   7 +
 .../sama7g54_curiosity/sama7g54_curiosity.c   |  36 +++
 configs/sama7g54_curiosity_mmc_defconfig      | 123 +++++++++
 .../sama7g54_curiosity_nandflash_defconfig    | 122 +++++++++
 .../sama7g54_curiosity_qspiflash_defconfig    | 122 +++++++++
 include/configs/sama7g54_curiosity.h          |  17 ++
 13 files changed, 795 insertions(+)
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
2.43.0

