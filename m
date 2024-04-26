Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E35BC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 09:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC8089083;
	Fri, 26 Apr 2024 11:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JWMvExI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B7B88DE7; Fri, 26 Apr 2024 11:45:11 +0200 (CEST)
Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com
 [45.254.49.209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB05D883E8
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 11:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JWMvExI7uarz+xKBTqm/OPqEcSC/fEmDPggFvHQ+XbMLLikiqTvDo6lToEHiVUVIyblcGCrQ3zkcebdq6Of6Dg9ukLWN5eA11vH9bYnu8VEPQJhdUcHKGT0ASx8J5m01w5LFbFGsWMWtEHU2Fo/iAK0FsHEQwDcKQZg6d5sZm/A=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=80twcASztiIbuSgPPtocV8B4NeSOQrskKlNVWNJIInM=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7329D900379;
 Fri, 26 Apr 2024 17:44:58 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240426
Date: Fri, 26 Apr 2024 17:44:58 +0800
Message-Id: <20240426094458.46701-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ04YT1YdGE5OHRlKGkxDSRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f19cb33c303a9kunm7329d900379
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06OCo6OTMDCCsCTzovATQ3
 CjFPCUhVSlVKTEpPSklPTUJCS0JJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSEJOQjcG
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

Hi Tom,

Please pull the updates for rockchip platform:
- dts sync for rk3308;
- sdram: Support getting banks from TPL for rk3568 and rk3588;
- dts and config clean and sync up for rk3568/rk3588;
- Other misc fixes;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/20543

Thanks,
- Kever

The following changes since commit d097f9e1299a3bdb7de468f0d9bbc63932f461cd:

  Merge tag 'fsl-qoriq-2024-4-24' of https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq (2024-04-23 17:53:06 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240426

for you to fetch changes up to f6114fb871108eb2bad7393191c9983f0b125dc1:

  rockchip: rk356x: use DRAM banks from ATAGS (2024-04-26 15:47:06 +0800)

----------------------------------------------------------------
Christopher Obbard (4):
      rockchip: spl-boot-order: fix typo in comment succes→success
      rockchip: spl-boot-order: show DT path for missing device
      arm: rockchip: sync ROCK Pi 4A DTS from Linux
      rockchip: rock-pi-4-rk3399: enable booting from SPI flash

Dragan Simic (1):
      board: rk3288: simplify the DT file list in MAINTAINERS

Finley Xiao (1):
      clk: rockchip: rk3308: Add support for SCLK_RTC32K clock

Jason Zhu (1):
      rockchip: bootrom: Sync bootsource id enum from bootrom

Jonas Karlman (47):
      rockchip: spl: Cache boot source id for later use
      rockchip: spl: Add SPI NOR flash to boot_devices array
      board: rockchip: rk3308: Add device tree files and myself to MAINTAINERS
      rockchip: rk3308: Sort imply statements alphabetically
      rockchip: rk3308: Enable ARMv8 crypto and FIT checksum validation
      rockchip: rk3308: Generate ethaddr based on cpu id
      rockchip: rk3308: Enable random generator
      rockchip: rk3308: Fix loading FIT from SD-card when booting from eMMC
      clk: rockchip: rk3308: Add dummy support for USB480M clock
      phy: rockchip-inno-usb2: Add support for RK3308
      rockchip: rk3308: Sync device tree from linux v6.8
      rockchip: rk3308-evb: Update defconfig
      rockchip: rk3308-roc-cc: Update defconfig
      rockchip: rk3308-rock-pi-s: Update defconfig
      rockchip: rk3308: Move cru and grf include files to arch-rockchip
      clk: rockchip: rk356x: Add CLK_USB3OTGx_REF support
      clk: rockchip: rk3588: Add REF_CLK_USB3OTGx support
      clk: rockchip: rk356x: Fix set rate of SCLK_SFC clock
      rockchip: rk3588: Drop REGULATOR_PWM Kconfig option
      rockchip: rk3566-anbernic-rgxx3: Remove SPL_ROCKCHIP_BACK_TO_BROM option
      rockchip: rk35xx: Sort imply statements alphabetically
      rockchip: rk35xx: Enable random generator
      rockchip: rk35xx: Imply support for GbE PHY
      rockchip: rk356x: Imply enhanced features for standard boot
      rockchip: rk35xx: Sort soc u-boot.dtsi alphabetically
      rockchip: rk356x: Update bootph props
      rockchip: rk3588: Update bootph props
      rockchip: rk3568-evb: Use pinctrl in SPL
      rockchip: rk3588-evb: Use pinctrl and aliases in SPL
      rockchip: rk3566-pinetab2: Fix reading FIT from SPI flash
      rockchip: rk3588-coolpi: Add boards to documentation
      rockchip: rk3588-coolpi: Fix .dtb-file entries in Makefile
      rockchip: rk3588-toybrick: Use pinctrl and aliases in SPL
      rockchip: rk3588-toybrick: Add .dtb-file entry in Makefile
      rockchip: rk3588-turing-rk1: Use dwc3-generic driver
      rockchip: rk3588-edgeble-neu6: Enable FIT checksum validation
      rockchip: rk356x-generic: Fix eMMC and SD-card pinctrl
      rockchip: rk356x-generic: Add support for SPI flash
      rockchip: rk356x-generic: Add support for USB OTG
      rockchip: rk3588-generic: Use M0 iomux for UART2
      rockchip: rk3588-generic: Add support for USB OTG
      rockchip: rk35xx-generic: Disable unused features
      mmc: rockchip_sdhci: Fix 4 blocks PIO mode read limit for RK35xx
      rockchip: rk3328: Sort imply statements alphabetically
      rockchip: rk3328: Enable ARMv8 crypto extensions
      rockchip: io-domain: Add support for RK3328
      rockchip: rk3328: Fix bootph prop for vop node

Lukasz Czechowski (1):
      rockchip: px30-board-tpl: Sync ifdef guards with full TPL

Quentin Schulz (12):
      rockchip: ringneck-px30: put STM32_RST line in input mode instead of output
      rockchip: sdram: Support getting banks from TPL for rk3568 and rk3588
      rockchip: NR_DRAM_BANKS now defaults to 10 when Rockchip TPL blob is used
      rockchip: nanopc-t6-rk3588: use DRAM banks from ATAGS
      rockchip: quartzpro64-rk3588: use DRAM banks from ATAGS
      rockchip: rock5a-rk3588s: use DRAM banks from ATAGS
      rockchip: rock5b-rk3588: use DRAM banks from ATAGS
      rockchip: evb_rk3588 et al.: use DRAM banks from ATAGS
      rockchip: toybrick_rk3588: use DRAM banks from ATAGS
      rockchip: turing-rk1-rk3588: use DRAM banks from ATAGS
      rockchip: rk3588: use DRAM banks from ATAGS
      rockchip: rk356x: use DRAM banks from ATAGS

 arch/arm/dts/Makefile                              |    5 +-
 arch/arm/dts/rk3308-evb-u-boot.dtsi                |   11 +-
 arch/arm/dts/rk3308-evb.dts                        |  104 +-
 arch/arm/dts/rk3308-roc-cc-u-boot.dtsi             |   30 +-
 arch/arm/dts/rk3308-roc-cc.dts                     |   83 +-
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi          |   45 +-
 arch/arm/dts/rk3308-rock-pi-s.dts                  |  100 +-
 arch/arm/dts/rk3308-u-boot.dtsi                    |  120 +-
 arch/arm/dts/rk3308.dtsi                           | 1205 ++++++++++----------
 arch/arm/dts/rk3328-u-boot.dtsi                    |    2 +-
 arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi         |    7 +
 arch/arm/dts/rk3399-rock-pi-4a.dts                 |   10 +
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi     |    6 -
 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi           |   23 +-
 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi         |    8 +-
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi         |    4 +-
 arch/arm/dts/rk3568-generic-u-boot.dtsi            |    7 +
 arch/arm/dts/rk3568-generic.dts                    |   37 +-
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi          |    7 +-
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi            |    5 +-
 arch/arm/dts/rk356x-u-boot.dtsi                    |  122 +-
 arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi     |    8 +-
 arch/arm/dts/rk3588-generic-u-boot.dtsi            |   22 +
 arch/arm/dts/rk3588-generic.dts                    |    3 +-
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi          |    8 +-
 arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi    |    7 +-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi            |    8 +-
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi         |    6 +-
 arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi         |    8 +-
 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi        |    7 +-
 arch/arm/dts/rk3588s-u-boot.dtsi                   |  118 +-
 arch/arm/include/asm/arch-rockchip/bootrom.h       |    3 +
 .../{arch-rk3308 => arch-rockchip}/cru_rk3308.h    |   14 +
 .../{arch-rk3308 => arch-rockchip}/grf_rk3308.h    |    0
 arch/arm/mach-rockchip/Kconfig                     |   65 +-
 arch/arm/mach-rockchip/px30-board-tpl.c            |    4 +-
 arch/arm/mach-rockchip/px30/px30.c                 |    1 +
 arch/arm/mach-rockchip/rk3288/rk3288.c             |    1 +
 arch/arm/mach-rockchip/rk3308/Kconfig              |    3 -
 arch/arm/mach-rockchip/rk3308/clk_rk3308.c         |    2 +-
 arch/arm/mach-rockchip/rk3308/rk3308.c             |    3 +-
 arch/arm/mach-rockchip/rk3328/syscon_rk3328.c      |    3 +
 arch/arm/mach-rockchip/rk3368/rk3368.c             |    1 +
 arch/arm/mach-rockchip/rv1126/rv1126.c             |    1 +
 arch/arm/mach-rockchip/sdram.c                     |  260 +++++
 arch/arm/mach-rockchip/spl-boot-order.c            |    6 +-
 arch/arm/mach-rockchip/spl.c                       |   14 +-
 board/firefly/firefly-rk3308/MAINTAINERS           |    1 +
 board/firefly/firefly-rk3308/roc_cc_rk3308.c       |    2 +-
 board/friendlyelec/nanopc-t6-rk3588/Makefile       |    6 -
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c            |   39 -
 board/pine64/quartzpro64-rk3588/Makefile           |    3 -
 .../pine64/quartzpro64-rk3588/quartzpro64-rk3588.c |   39 -
 board/radxa/rock2/MAINTAINERS                      |    4 +-
 board/radxa/rock5a-rk3588s/Makefile                |    6 -
 board/radxa/rock5a-rk3588s/rock5a-rk3588s.c        |   39 -
 board/radxa/rock5b-rk3588/Makefile                 |    6 -
 board/radxa/rock5b-rk3588/rock5b-rk3588.c          |   39 -
 board/rockchip/evb_rk3308/MAINTAINERS              |    5 +-
 board/rockchip/evb_rk3588/Makefile                 |    6 -
 board/rockchip/evb_rk3588/evb-rk3588.c             |   39 -
 board/rockchip/toybrick_rk3588/Makefile            |    6 -
 board/rockchip/toybrick_rk3588/toybrick-rk3588.c   |   39 -
 .../ringneck_px30/ringneck-px30.c                  |    4 +-
 board/turing/turing-rk1-rk3588/Makefile            |    6 -
 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c |   39 -
 configs/anbernic-rgxx3-rk3566_defconfig            |    5 -
 configs/bpi-r2-pro-rk3568_defconfig                |    2 -
 configs/coolpi-4b-rk3588s_defconfig                |    2 -
 configs/coolpi-cm5-evb-rk3588_defconfig            |    2 -
 configs/evb-rk3308_defconfig                       |   40 +-
 configs/evb-rk3328_defconfig                       |    1 +
 configs/evb-rk3568_defconfig                       |    4 +-
 configs/evb-rk3588_defconfig                       |    7 +-
 configs/generic-rk3568_defconfig                   |   31 +-
 configs/generic-rk3588_defconfig                   |   18 +-
 configs/jaguar-rk3588_defconfig                    |    1 -
 configs/lubancat-2-rk3568_defconfig                |    1 -
 configs/nanopc-t6-rk3588_defconfig                 |    2 -
 configs/nanopi-r5c-rk3568_defconfig                |    1 -
 configs/nanopi-r5s-rk3568_defconfig                |    1 -
 configs/neu6a-io-rk3588_defconfig                  |    9 +-
 configs/neu6b-io-rk3588_defconfig                  |    9 +-
 configs/odroid-m1-rk3568_defconfig                 |    1 -
 configs/orangepi-5-plus-rk3588_defconfig           |    2 -
 configs/orangepi-5-rk3588s_defconfig               |    2 -
 configs/pinetab2-rk3566_defconfig                  |    2 +-
 configs/quartz64-a-rk3566_defconfig                |    1 -
 configs/quartz64-b-rk3566_defconfig                |    1 -
 configs/quartzpro64-rk3588_defconfig               |    3 -
 configs/radxa-cm3-io-rk3566_defconfig              |    1 -
 configs/radxa-e25-rk3568_defconfig                 |    1 -
 configs/roc-cc-rk3308_defconfig                    |   40 +-
 configs/rock-3a-rk3568_defconfig                   |    1 -
 configs/rock-pi-4-rk3399_defconfig                 |   17 +-
 configs/rock-pi-s-rk3308_defconfig                 |   35 +-
 configs/rock5a-rk3588s_defconfig                   |    2 -
 configs/rock5b-rk3588_defconfig                    |    3 -
 configs/soquartz-blade-rk3566_defconfig            |    1 -
 configs/soquartz-cm4-rk3566_defconfig              |    1 -
 configs/soquartz-model-a-rk3566_defconfig          |    1 -
 configs/toybrick-rk3588_defconfig                  |    7 +-
 configs/turing-rk1-rk3588_defconfig                |    4 -
 doc/board/rockchip/rockchip.rst                    |    2 +
 drivers/clk/rockchip/clk_rk3308.c                  |  101 +-
 drivers/clk/rockchip/clk_rk3568.c                  |   36 +-
 drivers/clk/rockchip/clk_rk3588.c                  |    6 +
 drivers/misc/Kconfig                               |    2 +-
 drivers/misc/rockchip-io-domain.c                  |   38 +
 drivers/mmc/rockchip_sdhci.c                       |   26 +-
 drivers/net/gmac_rockchip.c                        |    4 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   20 +
 drivers/ram/rockchip/sdram_rk3308.c                |    2 +-
 113 files changed, 1933 insertions(+), 1411 deletions(-)
 rename arch/arm/include/asm/{arch-rk3308 => arch-rockchip}/cru_rk3308.h (95%)
 rename arch/arm/include/asm/{arch-rk3308 => arch-rockchip}/grf_rk3308.h (100%)
 delete mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
 delete mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
 delete mode 100644 board/pine64/quartzpro64-rk3588/Makefile
 delete mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
 delete mode 100644 board/radxa/rock5a-rk3588s/Makefile
 delete mode 100644 board/radxa/rock5a-rk3588s/rock5a-rk3588s.c
 delete mode 100644 board/radxa/rock5b-rk3588/Makefile
 delete mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
 delete mode 100644 board/rockchip/evb_rk3588/Makefile
 delete mode 100644 board/rockchip/evb_rk3588/evb-rk3588.c
 delete mode 100644 board/rockchip/toybrick_rk3588/Makefile
 delete mode 100644 board/rockchip/toybrick_rk3588/toybrick-rk3588.c
 delete mode 100644 board/turing/turing-rk1-rk3588/Makefile
 delete mode 100644 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c
