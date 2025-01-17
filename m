Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A885FC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A8A80713;
	Fri, 17 Jan 2025 02:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D4D80716; Fri, 17 Jan 2025 02:47:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E906B80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8927E11FB;
 Thu, 16 Jan 2025 17:47:33 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38903F673;
 Thu, 16 Jan 2025 17:47:03 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, Simon Glass <sjg@chromium.org>,
 linux-sunxi@lists.linux.dev, Parthiban <parthiban@linumiz.com>
Subject: [PATCH 0/8] sunxi: (early) Allwinner A133 SoC support
Date: Fri, 17 Jan 2025 01:45:29 +0000
Message-ID: <20250117014537.22513-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
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

The Allwinner A100 SoC has been around for a while, mostly on cheap
tablets, but didn't generate much interest in the community so far.
There were some efforts by two Allwinner employees in 2020, which led
to basic upstream Linux support for that SoC, although this momentum
dried up pretty quickly, leaving a lot of peripherals unsupported.
    
The A100 was silently replaced with the seemingly identical Allwinner
A133, which is reportedly a better bin of the A100. So far we assume
that both are compatible from a software perspective. There are some
more devices with the A133 out there now, so people are working on
filling the gaps, and adding U-Boot and TF-A support.

This series is a somewhat early version of a series to support boards
with the A133 SoC in U-Boot.

Since the basic SoC .dtsi and its bindings are upstream in the Linux
kernel repository, we can go ahead and add support for the pinctrl and
clock drivers: this is handled in patches 4 and 5. Similarly ready are
some refactoring patches, which will be needed later, those are the
first three patches. Patch 6 adds SPL support for the AXP707/803 PMIC,
which is often paired with the A133. Pending some review I am tempted to
push those patches rather quickly.

Patch 7 is the technically most advanced and challenging patch: to add
support for the DRAM controller. Huge thanks and kudos go to Cody, for
reverse engineering, debugging and testing this. The patch itself is
work in progress, and surely needs some love beyond the missing register
bits, to improve formatting, coding style and patch split. However it
works for me (TM), and is essential for the SoC support, so I include it
here, as an early reference. Cody hinted at sending a proper version,
this can then later replace this preliminary patch.

Patch 8 then puts the right values for various existing Allwinner
specific configuration options in Kconfig, and adds the remaining bits
required to enable configuration and build for boards with the A133 SoC.
Due to a lack of an upstream DT for the boards floating around at the
moment, this lacks any defconfig for now, but adding support for a board
just requires providing the defconfig with the DRAM parameters and
generic options, plus the respective .dts file. This has been tested
locally on a Liontron H-A133L here, I will send both the .dts and the
defconfig when they are ready.

For now please have a look, comment and review on the patches, so that
we can start upstream support for this SoC.

Cheers,
Andre

Andre Przywara (7):
  sunxi: clock: improve grouping of default clock register values
  sunxi: pmic_bus: support alternative I2C address
  sunxi: H616: DRAM: rename Kconfig parameters to be more generic
  clk: sunxi: Add support for the A100/A133 CCU
  pinctrl: sunxi: add Allwinner A100/A133 pinctrl description
  power: pmic: sunxi: add SPL support for the AXP803
  sunxi: add support for the Allwinner A100/A133 SoC

Cody Eksal (1):
  sunxi: A133: add DRAM init code [WIP!]

 arch/arm/cpu/armv8/fel_utils.S                |    2 +-
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |   25 +-
 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |    4 +
 arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
 .../include/asm/arch-sunxi/dram_sun50i_a133.h |  210 +++
 arch/arm/mach-sunxi/Kconfig                   |  254 +++-
 arch/arm/mach-sunxi/Makefile                  |    2 +
 arch/arm/mach-sunxi/board.c                   |    4 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |    3 +-
 arch/arm/mach-sunxi/cpu_info.c                |    2 +
 arch/arm/mach-sunxi/dram_sun50i_a133.c        | 1217 +++++++++++++++++
 arch/arm/mach-sunxi/dram_sun50i_h616.c        |   26 +-
 arch/arm/mach-sunxi/dram_timings/Makefile     |    2 +
 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c  |   80 ++
 .../arm/mach-sunxi/dram_timings/a133_lpddr4.c |  102 ++
 arch/arm/mach-sunxi/pmic_bus.c                |   10 +-
 board/sunxi/board.c                           |   13 +-
 common/spl/Kconfig                            |    6 +-
 configs/anbernic_rg35xx_h700_defconfig        |   20 +-
 configs/orangepi_zero2_defconfig              |    8 +-
 configs/orangepi_zero2w_defconfig             |   16 +-
 configs/orangepi_zero3_defconfig              |   16 +-
 configs/tanix_tx1_defconfig                   |   16 +-
 configs/transpeed-8k618-t_defconfig           |   14 +-
 configs/x96_mate_defconfig                    |   14 +-
 drivers/clk/sunxi/Kconfig                     |    7 +
 drivers/clk/sunxi/Makefile                    |    1 +
 drivers/clk/sunxi/clk_a100.c                  |  102 ++
 drivers/clk/sunxi/clk_sunxi.c                 |    5 +
 drivers/pinctrl/sunxi/Kconfig                 |   10 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   47 +
 drivers/power/Kconfig                         |   23 +-
 drivers/power/Makefile                        |    1 +
 drivers/power/axp_spl.c                       |   17 +
 34 files changed, 2151 insertions(+), 130 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
 create mode 100644 arch/arm/mach-sunxi/dram_sun50i_a133.c
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
 create mode 100644 drivers/clk/sunxi/clk_a100.c

-- 
2.46.2

