Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128ABC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 07:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0E18070C;
	Thu, 27 Mar 2025 08:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="RpRMXqMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347B381273; Thu, 27 Mar 2025 08:06:35 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9672E806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=174f6da1a=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1743059193; x=1774595193;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=J0dnR7h7rmS5fYKD7lvXYwSaSVLNatk/2afwAIqGxnc=;
 b=RpRMXqMkv1fTbT3v82xSFaXsSg2UhZINmdKlwk/FRTCza4BaWZNIJVFV
 hn8nOig8M3eFM+lJzni3zwddoI9nDXnrfjKg3KTPtuMPT3RK+pWgOu1nf
 3lb3EsKBQkZGkbosAqRrsL5ch/CRZv82Egtuxx+vScPU8IkJ8Vhu+bZmh
 TQnGuUq7bsNpbHXfeHt2Bb911aBf/1l1JaGtpF8IhsIAnTGbJPJg3tlXL
 T+zyc3gzrnj6SXJBhupXmarCK4yPY0MDeJOv2iGYGPTP5/rZyXcxZS+mQ
 PoCIkhJOKYhGykcKRkYri2z38mKp0WJRgb1+Sihm5SFuDWskxpq8eauLt A==;
X-CSE-ConnectionGUID: 5nEG/Rh/Ry+LI6F8V6dTJA==
X-CSE-MsgGUID: kGD7ysQgQ6OrRPd4US622g==
X-IronPort-AV: E=Sophos;i="6.14,279,1736838000"; d="scan'208";a="39784699"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Mar 2025 00:06:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 00:06:29 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 00:06:22 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <nathan.morrison@timesys.com>, <ilias.apalodimas@linaro.org>,
 <greg.malysa@timesys.com>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <igor.opaniuk@gmail.com>, <semen.protsenko@linaro.org>,
 <william.zhang@broadcom.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v5 0/8] Add support for sam9x7 SoC and SAM9X75 Curiosity board
Date: Thu, 27 Mar 2025 12:36:07 +0530
Message-ID: <20250327070615.334551-1-manikandan.m@microchip.com>
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
 - sam9x7 SoC is added
 - Clock driver for sam9x7 is added
 - Target board SAM9X75 Curiosity is added with its differences in DT
 and MMC config support 

----
changes in v5:
- 4/8 - Define ID_MAIN_RC name in sam9x7 clock driver thus dropping
	the main_rc clock from DT and Alinging it with Linux
- 6/8 - Drop main_rc clock for pmc node in DT


changes in v4:
- 1/8 - Drop the local include file clock/at91.h and the update
	the MAINTAINERS respectively.

changes in v3:
- 1/8 - rename at91.h to at91-pmc-status.h, update the SoC DTs
	and MAINTAINERS file respectively
- 4/8 - update header from clk/at91.h to clock/at91.h 

changes in v2:
- 1/8 - add additional PMC clock definition to support the sam9x7 upstream
	DT
- 6/8 - Remove support for SoC DT and board DTS as they are already available
        in dts/upstream
      - add the differences in DT files between upstream Linux DT and U-Boot
      	DT to at91-sam9x75_curiosity-u-boot.dtsi
- 7/8 - Add OF_UPSTREAM support for sam9x75 curiosity board
- 8/8 - update the DEFAULT_DEVICE_TREE config to <vendor/name>

----

Manikandan Muralidharan (4):
  dt-bindings: drop at91.h from clock includes
  ARM: dts: at91: sam9x75_curiosity: add tweaks for sam9x75 curiosity
    board
  board: sam9x75_curiosity: Add support for sam9x75 curiosity
  configs: sam9x75_curiosity: Add initial mmc default config

Varshini Rajendran (4):
  clk: at91: sam9x60-pll: add support for core clock frequency inputs
  clk: at91: sam9x60-pll: add support for HW PLL freq dividers
  clk: at91: sam9x7: add pmc driver for sam9x7 SoC family
  ARM: at91: Add sam9x7 soc

 MAINTAINERS                                   |    1 -
 .../dts/at91-sam9x75_curiosity-u-boot.dtsi    |  105 ++
 arch/arm/mach-at91/Kconfig                    |   12 +
 arch/arm/mach-at91/arm926ejs/Makefile         |    1 +
 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c |   49 +
 arch/arm/mach-at91/include/mach/hardware.h    |    2 +
 arch/arm/mach-at91/include/mach/sam9x7.h      |  172 +++
 board/atmel/sam9x75_curiosity/Kconfig         |   15 +
 board/atmel/sam9x75_curiosity/MAINTAINERS     |    7 +
 board/atmel/sam9x75_curiosity/Makefile        |    7 +
 .../sam9x75_curiosity/sam9x75_curiosity.c     |   66 +
 configs/sam9x75_curiosity_mmc_defconfig       |   73 ++
 drivers/clk/at91/Makefile                     |    1 +
 drivers/clk/at91/clk-sam9x60-pll.c            |   55 +-
 drivers/clk/at91/pmc.h                        |    2 +
 drivers/clk/at91/sam9x60.c                    |    7 +
 drivers/clk/at91/sam9x7.c                     | 1085 +++++++++++++++++
 drivers/clk/at91/sama7g5.c                    |    6 +
 include/configs/sam9x75_curiosity.h           |   23 +
 include/dt-bindings/clock/at91.h              |   23 -
 20 files changed, 1678 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
 create mode 100644 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c
 create mode 100644 arch/arm/mach-at91/include/mach/sam9x7.h
 create mode 100644 board/atmel/sam9x75_curiosity/Kconfig
 create mode 100644 board/atmel/sam9x75_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sam9x75_curiosity/Makefile
 create mode 100644 board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
 create mode 100644 configs/sam9x75_curiosity_mmc_defconfig
 create mode 100644 drivers/clk/at91/sam9x7.c
 create mode 100644 include/configs/sam9x75_curiosity.h
 delete mode 100644 include/dt-bindings/clock/at91.h

-- 
2.25.1

