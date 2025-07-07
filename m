Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5AEC8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF7B83189;
	Mon,  7 Jul 2025 17:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="kACCDefD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2159D830E4; Mon,  7 Jul 2025 13:36:06 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F63D8305C
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2768a2b95=Varshini.Rajendran@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751888163; x=1783424163;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t+SJL2gyIU5Tt4nFuDZyo6DFEwj8VapwEHtre71jghA=;
 b=kACCDefDiWFjsXeXBegeoB8Si7PyqBt5PXOg0KKxKN0YXFJ6dEyukk7j
 kSZ/feoQbiF9A2RCayEOPs/gt1V3LnV6HOKptjQjIp0qrfn5yiDpRXlyn
 kEFN51RNRw7j8btAL5ciAmyaQT9ziAwlw/j/yHq33QFmcloS+rcgemUx2
 ijVjp2o6zkgOQa4kHiGdgRrvfYmmMS+T9o4sv7/z1ZLL0Ui82kWcIWMT1
 uMuoNzbc1DG3qP83xUJo6CLYAU2ID3s18CUIzoxNMEVTccCnS3OckYHmL
 mbeLUlUOFzV5WLJlrwWXYEmifUJl7exsiEs0SX5/uSmzllTUdyYwOnKde w==;
X-CSE-ConnectionGUID: g3f6m/IuQeKiZIhKrT2jbg==
X-CSE-MsgGUID: Z9+ihSJ8RhCyuDknSMyuFQ==
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="44271891"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Jul 2025 04:36:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 04:35:43 -0700
Received: from che-dk-mpulab01.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 7 Jul 2025 04:35:40 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <ryan.wanner@microchip.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <varshini.rajendran@microchip.com>,
 <manikandan.m@microchip.com>, <nicolas.ferre@microchip.com>,
 <sjg@chromium.org>, <balamanikandan.gunasundar@microchip.com>,
 <Romain.Sioen@microchip.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/6] Add support for sama7d65 SoC and sama7d65 curiosity board
Date: Mon, 7 Jul 2025 16:59:34 +0530
Message-ID: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 07 Jul 2025 17:54:47 +0200
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

This patch series adds support for the new SoC sama7d65.
 - sama7d65 SoC is added
 - Clock driver for sama7d65 is added
 - Target board SAMA7D65 Curiosity is added with its differences in DT
 and MMC config support

Ryan Wanner (6):
  clk: at91: Update MAX PLL and master clk ID
  clk: at91: sama7d65: add clock support
  ARM: mach-at91: add support for new SoC sama7d65
  ARM: dts: at91: sama7d65-curiosity: Add DT tweaks for
    sama7d65-curiosity board
  board: sama7d65_curiosity: Add support for sama7d65_curiosity
  configs: sama7d65_curiosity: Add defconfig for sama7d65_curiosity

 .../dts/at91-sama7d65_curiosity-u-boot.dtsi   |   80 +
 arch/arm/mach-at91/Kconfig                    |   13 +
 arch/arm/mach-at91/armv7/Makefile             |    1 +
 arch/arm/mach-at91/armv7/sama7d65_devices.c   |   31 +
 arch/arm/mach-at91/include/mach/hardware.h    |    2 +
 arch/arm/mach-at91/include/mach/sama7d65.h    |  107 ++
 board/atmel/sama7d65_curiosity/Kconfig        |   15 +
 board/atmel/sama7d65_curiosity/MAINTAINERS    |    6 +
 board/atmel/sama7d65_curiosity/Makefile       |    7 +
 .../sama7d65_curiosity/sama7d65_curiosity.c   |   75 +
 configs/sama7d65_curiosity_mmc1_defconfig     |  108 ++
 drivers/clk/at91/Makefile                     |    1 +
 drivers/clk/at91/clk-master.c                 |    2 +-
 drivers/clk/at91/clk-sam9x60-pll.c            |    2 +-
 drivers/clk/at91/sama7d65.c                   | 1451 +++++++++++++++++
 include/configs/sama7d65_curiosity.h          |   20 +
 16 files changed, 1919 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/at91-sama7d65_curiosity-u-boot.dtsi
 create mode 100644 arch/arm/mach-at91/armv7/sama7d65_devices.c
 create mode 100644 arch/arm/mach-at91/include/mach/sama7d65.h
 create mode 100644 board/atmel/sama7d65_curiosity/Kconfig
 create mode 100644 board/atmel/sama7d65_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sama7d65_curiosity/Makefile
 create mode 100644 board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
 create mode 100644 configs/sama7d65_curiosity_mmc1_defconfig
 create mode 100644 drivers/clk/at91/sama7d65.c
 create mode 100644 include/configs/sama7d65_curiosity.h

-- 
2.45.2

