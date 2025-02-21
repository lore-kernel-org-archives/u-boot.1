Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB4BC021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 10:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 557D6807C4;
	Fri, 21 Feb 2025 11:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Yi5egtDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D20980F70; Fri, 21 Feb 2025 11:03:57 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 966428007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 11:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1402d5598=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1740132234; x=1771668234;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=smhTrHtasqHheWXJzEauGRJheoWkYGTVEsIka/kUGxM=;
 b=Yi5egtDeCzh+JgANuWNZAaSti5AnjSgxVCAVaBKQR8ZQCy2rVN0G6f6t
 Lac87fXHbbWzTBheKFpRhfpEk2ZhBnXwssTnyrEcAW/eeM6kEhc0mCGhb
 5VCPShxcHUDVOlgTevcH6gxAvUe7uT6Ipe1mrcsblSma8LphqYl5ZlJmB
 f50q4ENNNWcQih2H63fWZFlvRDjGaKirSN4C5hZnHJOxfUCUw13HlgbAK
 MP61yAtz06xM9XY2QBd9UnNATsxX1PGidhYF6znuthsC0f1N20MH/aYJm
 1Wb/N7WQm5WGcgyJWjm56MMM/YQyTO5QAwwHUM6/MKKYoLzNjBiqoIczp Q==;
X-CSE-ConnectionGUID: ttj8uaB8R+mU6Re4nx9L4g==
X-CSE-MsgGUID: zi4RlPKBRHW1uZLGf15ZKQ==
X-IronPort-AV: E=Sophos;i="6.13,304,1732604400"; d="scan'208";a="37553902"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Feb 2025 03:03:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 21 Feb 2025 03:03:25 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 21 Feb 2025 03:03:18 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>, 
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>, 
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <nicolas.ferre@microchip.com>, <mihai.sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 0/8] Add support for sam9x7 SoC and SAM9X75 Curiosity board
Date: Fri, 21 Feb 2025 15:33:06 +0530
Message-ID: <20250221100314.464818-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
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

This patch series adds support for the new SoC family - sam9x7.
 - sam9x7 device tree and SoC is added
 - Clock driver for sam9x7 is added
 - Target board SAM9X75 Curiosity is added with its DT and MMC config

Manikandan Muralidharan (3):
  ARM: dts: at91: sam9x75_curiosity: add sam9x75 curiosity board
  board: sam9x75_curiosity: Add support for sam9x75 curiosity
  configs: sam9x75_curiosity: Add initial mmc default config

Varshini Rajendran (5):
  clk: at91: sam9x60-pll: add support for core clock frequency inputs
  clk: at91: sam9x60-pll: add support for HW PLL freq dividers
  clk: at91: sam9x7: add pmc driver for sam9x7 SoC family
  ARM: at91: Add sam9x7 soc
  ARM: dts: at91: sam9x7: Add initial DT for sam9x7 SoC

 arch/arm/dts/Makefile                         |    2 +
 .../dts/at91-sam9x75_curiosity-u-boot.dtsi    |   79 +
 arch/arm/dts/at91-sam9x75_curiosity.dts       |  374 +++++
 arch/arm/dts/sam9x7.dtsi                      | 1273 +++++++++++++++++
 arch/arm/mach-at91/Kconfig                    |   11 +
 arch/arm/mach-at91/arm926ejs/Makefile         |    1 +
 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c |   49 +
 arch/arm/mach-at91/include/mach/hardware.h    |    2 +
 arch/arm/mach-at91/include/mach/sam9x7.h      |  172 +++
 board/atmel/sam9x75_curiosity/Kconfig         |   15 +
 board/atmel/sam9x75_curiosity/MAINTAINERS     |    7 +
 board/atmel/sam9x75_curiosity/Makefile        |    7 +
 .../sam9x75_curiosity/sam9x75_curiosity.c     |   66 +
 configs/sam9x75_curiosity_mmc_defconfig       |   73 +
 drivers/clk/at91/Makefile                     |    1 +
 drivers/clk/at91/clk-sam9x60-pll.c            |   55 +-
 drivers/clk/at91/pmc.h                        |    2 +
 drivers/clk/at91/sam9x60.c                    |    7 +
 drivers/clk/at91/sam9x7.c                     | 1094 ++++++++++++++
 drivers/clk/at91/sama7g5.c                    |    6 +
 include/configs/sam9x75_curiosity.h           |   23 +
 21 files changed, 3309 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
 create mode 100644 arch/arm/dts/at91-sam9x75_curiosity.dts
 create mode 100644 arch/arm/dts/sam9x7.dtsi
 create mode 100644 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c
 create mode 100644 arch/arm/mach-at91/include/mach/sam9x7.h
 create mode 100644 board/atmel/sam9x75_curiosity/Kconfig
 create mode 100644 board/atmel/sam9x75_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sam9x75_curiosity/Makefile
 create mode 100644 board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
 create mode 100644 configs/sam9x75_curiosity_mmc_defconfig
 create mode 100644 drivers/clk/at91/sam9x7.c
 create mode 100644 include/configs/sam9x75_curiosity.h

-- 
2.25.1

