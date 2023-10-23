Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B821C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F7B8790F;
	Mon, 23 Oct 2023 15:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CAC387912; Mon, 23 Oct 2023 15:25:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C5A678790D
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 212D62F4;
 Mon, 23 Oct 2023 06:25:43 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DBD13F762;
 Mon, 23 Oct 2023 06:25:00 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 00/24] sunxi: Allwinner T113s support
Date: Mon, 23 Oct 2023 14:24:25 +0100
Message-Id: <20231023132449.813863-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
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

Hi,

this is just for the records (mailing list archives), I just sent a
pull request with that series, to still make the 2024.01 merge window.
Some smaller changes, addressing the review comments (many thanks to
Samuel!) This now embeds Sam's PSCI support patches, and also relies
on the devicetree sync from the Linux v6.6-rc6 kernel.

If you find issues with this series, then please reply to the respective
patch, or send a patch on top. We still have till the end of the year to
fix things in the repo.
Changelog below.

===================
This series adds support for the new SoC series that covers the Allwinner
D1 siblings R528 and T113s (a version with co-packaged DRAM). They all
share the same die, although the D1 and D1s use RISC-V cores, which
requires more plumbing, to use the sunxi code across two architectures.
Getting the R528 support in should help a bit in sorting out what's new
peripheral code and what is architecture dependent. IIUC, Samuel has that
running, although with some hacks, the number of which this series tries
to reduce.

The most interesting part of this is the pincontroller rework, this
tackles two issues:
- For the first time in the history of mainline Allwinner support the
  pincontroller changed the register layout. The code here tries to
  abstract the differences away, so both variants can share the code
  peacefully.
- For the above mentioned reason, the pincontroller code is quite old,
  and is mostly spread out across arch/arm, in a pre-DM style, even
  though we have real DM support in U-Boot proper. We need the non-DM
  version for the (ARM-only?) legacy SPL, so can't get rid of that
  completely. This series also tries to modernise that code, and moves
  it into drivers/gpio, where it can be more easily shared with RISC-V.

The main feature is then of course the T113s support, of which the new
pinctroller is only one part. Apart from the new pincontroller and the
usual new SoC bits (like clock and pinmux support), this includes the
DRAM controller code.
The PSCI support has been contributed by Sam (many thanks for that!).
To follow the common pattern there is first some refactoring, then the
R528/T113s bits plug on top.
With the basics in, we add support for the MangoPi MQ-R board, which
uses the T113s and seems to be a popular board. This should also serve
as a blueprint for supporting similar boards.

This series is based on top of current master, but it relies on the
Allwinner DT update series (from Linux kernel v6.6-rc6).

A branch is available at:
https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

Cheers,
Andre

Changelog v3 .. v2:
- add review and test tags
- mention OrangePi Plus USB3_VBUS_PIN speciality in commit message
- use dev_get_phy_node() wrapper in sunxi_emac.c
- change [gs]et_output_ to [gs]et_value_ in pinctrl code
- move SUNXI_NEW_PINCTRL Kconfig definition to drivers/gpio
- fix ordering of pinctrl structure definitions
- add some new pinmux functions (i2c0, mmc1, uart1/2)
- fix ordering of clock structure definitions
- drop DRAM_SUN8I_R528 symbol in favour of just DRAM_SUN20I_D1
- drop defaults from DRAM parameters (forces definition in defconfig)
- fix test writes/reads into DRAM for 64-bit builds
- fix DRAM driver build failure for DM_RAM
- un-indent dram_para_t definition
- drop devicetree patches and rely on generic DT update
- include PSCI patches from Sam Edwards
- make sure SUNXI_R_CPUCFG_BASE is always defined

Changelog v2 .. v1:
- add review and test tags
- reorder pinctrl rework patches: first move shared code, then add in/out,
  then remove struct, then move headers
- move all GPIO routines into drivers/gpio/sunxi_gpio.c
- move private GPIO definitions from GPIO header file to sunxi_gpio.c
- use GPIO_NUM() instead of "% 32" directly
- define more MMIO addresses (PRCM, CPUCFG, R_PIO)
- do not enable 8-bit eMMC mode (Okhunjon)
- add eMMC pins to SPL pinmux setup (Okhunjon)
- drop patch [PATCH 13/20] sunxi: clock: h6: prepare for PRCM less SoCs
- update DT files from latest Linux kernel tree
- fix pin numbers for the UART pinmux setup
- let DRAM driver depend on ARCH_SUNXI

Andre Przywara (18):
  sunxi: remove CONFIG_SATAPWR
  net: sunxi_emac: chase DT nodes to find PHY regulator
  sunxi: remove CONFIG_MACPWR
  pinctrl: sunxi: move pinctrl code
  pinctrl: sunxi: add GPIO in/out wrappers
  pinctrl: sunxi: remove struct sunxi_gpio
  pinctrl: sunxi: remove GPIO_EXTRA_HEADER
  pinctrl: sunxi: move PIO_BASE into sunxi_gpio.h
  pinctrl: sunxi: add new D1 pinctrl support
  sunxi: introduce NCAT2 generation model
  pinctrl: sunxi: add Allwinner D1 pinctrl description
  sunxi: clock: D1/R528: Enable PLL LDO during PLL1 setup
  sunxi: clock: support D1/R528 PLL6 clock
  Kconfig: sunxi: prepare for using drivers/ram/sunxi
  sunxi: add R528/T113-s3/D1(s) DRAM initialisation code
  sunxi: add Allwinner R528/T113 SoC support
  sunxi: refactor serial base addresses to avoid asm/arch/cpu.h
  sunxi: add MangoPi MQ-R board support

Okhunjon Sobirjonov (1):
  sunxi: R528: add SMHC2 pin pull ups support

Sam Edwards (4):
  sunxi: psci: clean away preprocessor macros
  sunxi: psci: refactor register access to separate functions
  sunxi: psci: stop modeling register layout with C structs
  sunxi: psci: implement PSCI on R528

Samuel Holland (1):
  clk: sunxi: Add support for the D1 CCU

 arch/arm/Kconfig                              |    3 +-
 arch/arm/cpu/armv7/Kconfig                    |    3 +-
 arch/arm/cpu/armv7/sunxi/psci.c               |  190 ++-
 arch/arm/cpu/armv7/sunxi/sram.c               |    1 +
 arch/arm/cpu/armv8/fel_utils.S                |    1 +
 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/sunxi-u-boot.dtsi                |    7 +
 arch/arm/include/asm/arch-sunxi/boot0.h       |    2 +
 arch/arm/include/asm/arch-sunxi/clock.h       |    3 +-
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |   12 +-
 arch/arm/include/asm/arch-sunxi/cpu.h         |    2 +
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h   |   17 -
 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |    7 -
 arch/arm/include/asm/arch-sunxi/cpu_sun9i.h   |    9 -
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |   39 +
 arch/arm/include/asm/arch-sunxi/cpucfg.h      |   67 -
 arch/arm/include/asm/arch-sunxi/mmc.h         |    2 +-
 arch/arm/include/asm/arch-sunxi/prcm.h        |    2 +-
 arch/arm/include/asm/arch-sunxi/serial.h      |   32 +
 arch/arm/include/asm/arch-sunxi/timer.h       |    2 +-
 arch/arm/mach-sunxi/Kconfig                   |   42 +-
 arch/arm/mach-sunxi/Makefile                  |    2 +-
 arch/arm/mach-sunxi/board.c                   |   31 +-
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |   45 +-
 arch/arm/mach-sunxi/cpu_info.c                |    2 +
 arch/arm/mach-sunxi/dram_suniv.c              |    2 +-
 arch/arm/mach-sunxi/gtbus_sun9i.c             |    1 +
 arch/arm/mach-sunxi/pinmux.c                  |   78 -
 arch/arm/mach-sunxi/spl_spi_sunxi.c           |    1 +
 arch/arm/mach-sunxi/timer.c                   |    1 +
 board/sunxi/board.c                           |   34 +-
 board/sunxi/chip.c                            |    2 +-
 common/spl/Kconfig                            |    3 +-
 configs/A10-OLinuXino-Lime_defconfig          |    1 -
 configs/A20-OLinuXino-Lime2-eMMC_defconfig    |    1 -
 configs/A20-OLinuXino-Lime2_defconfig         |    1 -
 configs/A20-OLinuXino-Lime_defconfig          |    1 -
 configs/A20-OLinuXino_MICRO-eMMC_defconfig    |    1 -
 configs/A20-OLinuXino_MICRO_defconfig         |    1 -
 configs/A20-Olimex-SOM-EVB_defconfig          |    1 -
 configs/A20-Olimex-SOM204-EVB-eMMC_defconfig  |    1 -
 configs/A20-Olimex-SOM204-EVB_defconfig       |    1 -
 configs/Bananapi_M2_Ultra_defconfig           |    1 -
 configs/Bananapi_defconfig                    |    1 -
 configs/Bananapro_defconfig                   |    1 -
 configs/Cubieboard2_defconfig                 |    1 -
 configs/Cubieboard_defconfig                  |    1 -
 configs/Cubietruck_defconfig                  |    1 -
 configs/Itead_Ibox_A20_defconfig              |    1 -
 configs/Lamobo_R1_defconfig                   |    2 -
 configs/Linksprite_pcDuino3_Nano_defconfig    |    1 -
 configs/Linksprite_pcDuino3_defconfig         |    1 -
 configs/Mele_A1000_defconfig                  |    1 -
 configs/Orangepi_defconfig                    |    1 -
 configs/Orangepi_mini_defconfig               |    1 -
 configs/Sinovoip_BPI_M3_defconfig             |    1 -
 configs/bananapi_m1_plus_defconfig            |    1 -
 configs/bananapi_m2_plus_h3_defconfig         |    1 -
 configs/bananapi_m2_plus_h5_defconfig         |    1 -
 configs/i12-tvbox_defconfig                   |    1 -
 configs/jesurun_q5_defconfig                  |    1 -
 configs/mangopi_mq_r_defconfig                |   15 +
 configs/mixtile_loftq_defconfig               |    1 -
 configs/nanopi_m1_plus_defconfig              |    1 -
 configs/nanopi_neo_plus2_defconfig            |    1 -
 configs/nanopi_r1s_h5_defconfig               |    1 -
 configs/orangepi_pc2_defconfig                |    1 -
 configs/orangepi_plus2e_defconfig             |    1 -
 configs/orangepi_plus_defconfig               |    3 +-
 configs/orangepi_win_defconfig                |    1 -
 configs/pine_h64_defconfig                    |    1 -
 configs/zeropi_defconfig                      |    1 -
 drivers/Makefile                              |    1 +
 drivers/ata/ahci_sunxi.c                      |    9 +
 drivers/clk/sunxi/Kconfig                     |    7 +
 drivers/clk/sunxi/Makefile                    |    1 +
 drivers/clk/sunxi/clk_d1.c                    |   84 +
 drivers/clk/sunxi/clk_sunxi.c                 |    5 +
 drivers/gpio/Kconfig                          |    7 +
 drivers/gpio/axp_gpio.c                       |    1 +
 drivers/gpio/sunxi_gpio.c                     |  189 ++-
 drivers/i2c/mvtwsi.c                          |    3 +-
 drivers/i2c/sun6i_p2wi.c                      |    2 +-
 drivers/i2c/sun8i_rsb.c                       |    2 +-
 drivers/mmc/sunxi_mmc.c                       |    9 +-
 drivers/net/sun8i_emac.c                      |    7 +
 drivers/net/sunxi_emac.c                      |   38 +
 drivers/pinctrl/sunxi/Kconfig                 |    5 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   47 +-
 drivers/ram/Kconfig                           |    3 +-
 drivers/ram/Makefile                          |    3 +
 drivers/ram/sunxi/Kconfig                     |   60 +
 drivers/ram/sunxi/Makefile                    |    3 +
 drivers/ram/sunxi/dram_sun20i_d1.c            | 1441 +++++++++++++++++
 drivers/ram/sunxi/dram_sun20i_d1.h            |   73 +
 drivers/video/hitachi_tx18d42vm_lcd.c         |    1 +
 drivers/video/ssd2828.c                       |    1 -
 drivers/video/sunxi/sunxi_display.c           |    1 +
 drivers/video/sunxi/sunxi_lcd.c               |    1 +
 include/configs/sunxi-common.h                |    2 +-
 .../arch-sunxi/gpio.h => include/sunxi_gpio.h |   83 +-
 101 files changed, 2330 insertions(+), 462 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
 delete mode 100644 arch/arm/include/asm/arch-sunxi/cpucfg.h
 create mode 100644 arch/arm/include/asm/arch-sunxi/serial.h
 delete mode 100644 arch/arm/mach-sunxi/pinmux.c
 create mode 100644 configs/mangopi_mq_r_defconfig
 create mode 100644 drivers/clk/sunxi/clk_d1.c
 create mode 100644 drivers/ram/sunxi/Kconfig
 create mode 100644 drivers/ram/sunxi/Makefile
 create mode 100644 drivers/ram/sunxi/dram_sun20i_d1.c
 create mode 100644 drivers/ram/sunxi/dram_sun20i_d1.h
 rename arch/arm/include/asm/arch-sunxi/gpio.h => include/sunxi_gpio.h (75%)

-- 
2.25.1

