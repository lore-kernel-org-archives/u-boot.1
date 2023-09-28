Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F575E743C4
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3853386E37;
	Thu, 28 Sep 2023 23:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C419486E43; Thu, 28 Sep 2023 23:56:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CDAED864EE
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704611FB;
 Thu, 28 Sep 2023 14:56:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A1133F59C;
 Thu, 28 Sep 2023 14:56:02 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 00/22] sunxi: Allwinner T113s support
Date: Thu, 28 Sep 2023 22:54:33 +0100
Message-Id: <20230928215455.28094-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
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

this is an update to the Allwinner T113s support series. It addresses
some comments I got (many thanks to the reviewers!). Samuel had a mishap
where his email client ate his draft responses, so the put the gist of
his review comments in an IRC query. Most of the GPIO changes in this
series were triggered by his comments, many thanks!
The biggest change is that all low-level GPIO/pinctrl routines now live
in the GPIO driver file under drivers/gpio, that's a better place than
under board/sunxi. Also the GPIO header file saw some cleanup, many
definition are not (longer) needed outside of sunxi_gpio.c.
Based on origin/next. For a detailed changelog, see below.

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
With the basics in, we add support for the MangoPi MQ-R board, which
uses the T113s and seems to be a popular board. This should also serve
as a blueprint for supporting similar boards. The DTs are copied from
the kernel (as usual).

There are some bits missing, prominently PSCI support. There is a series
out there, which just needs some smaller fixes in some places. I expect
the PSCI support to go back-to-back with this series.

This series is based on top of current origin/next, so that should cover
some chunks of the v2024.01 merge window already.

A branch is available at:
https://source.denx.de/u-boot/custodians/u-boot-sunxi.git t113s-v2

Please have a look, review and test.

Cheers,
Andre

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

Andre Przywara (19):
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
  ARM: dts: sunxi: add Allwinner T113-s SoC .dtsi
  sunxi: add MangoPi MQ-R board support

Okhunjon Sobirjonov (1):
  sunxi: R528: add SMHC2 pin pull ups support

Samuel Holland (2):
  clk: sunxi: Add support for the D1 CCU
  riscv: dts: allwinner: Add the D1/D1s SoC devicetree

 arch/arm/Kconfig                              |    3 +-
 arch/arm/cpu/armv7/sunxi/sram.c               |    1 +
 arch/arm/cpu/armv8/fel_utils.S                |    1 +
 arch/arm/dts/Makefile                         |    2 +
 .../arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts |   35 +
 arch/arm/dts/sun8i-t113s.dtsi                 |   59 +
 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi |  126 ++
 arch/arm/dts/sunxi-u-boot.dtsi                |    7 +
 arch/arm/include/asm/arch-sunxi/boot0.h       |    2 +
 arch/arm/include/asm/arch-sunxi/clock.h       |    3 +-
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |   12 +-
 arch/arm/include/asm/arch-sunxi/cpu.h         |    2 +
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h   |   17 -
 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |    7 -
 arch/arm/include/asm/arch-sunxi/cpu_sun9i.h   |    9 -
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |   39 +
 arch/arm/include/asm/arch-sunxi/mmc.h         |    2 +-
 arch/arm/include/asm/arch-sunxi/prcm.h        |    2 +-
 arch/arm/include/asm/arch-sunxi/serial.h      |   32 +
 arch/arm/include/asm/arch-sunxi/timer.h       |    2 +-
 arch/arm/mach-sunxi/Kconfig                   |   44 +-
 arch/arm/mach-sunxi/Makefile                  |    2 +-
 arch/arm/mach-sunxi/board.c                   |   31 +-
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |   45 +-
 arch/arm/mach-sunxi/cpu_info.c                |    2 +
 arch/arm/mach-sunxi/dram_suniv.c              |    2 +-
 arch/arm/mach-sunxi/gtbus_sun9i.c             |    1 +
 arch/arm/mach-sunxi/pinmux.c                  |   78 -
 arch/arm/mach-sunxi/spl_spi_sunxi.c           |    1 +
 arch/arm/mach-sunxi/timer.c                   |    1 +
 arch/riscv/dts/sun20i-common-regulators.dtsi  |   28 +
 arch/riscv/dts/sun20i-d1.dtsi                 |   66 +
 arch/riscv/dts/sun20i-d1s.dtsi                |   76 +
 arch/riscv/dts/sunxi-d1-t113.dtsi             |   15 +
 arch/riscv/dts/sunxi-d1s-t113.dtsi            |  927 +++++++++++
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
 drivers/gpio/axp_gpio.c                       |    1 +
 drivers/gpio/sunxi_gpio.c                     |  189 ++-
 drivers/i2c/mvtwsi.c                          |    3 +-
 drivers/i2c/sun6i_p2wi.c                      |    2 +-
 drivers/i2c/sun8i_rsb.c                       |    2 +-
 drivers/mmc/sunxi_mmc.c                       |    9 +-
 drivers/net/sun8i_emac.c                      |    9 +-
 drivers/net/sunxi_emac.c                      |   39 +
 drivers/pinctrl/sunxi/Kconfig                 |    5 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   43 +-
 drivers/ram/Kconfig                           |    3 +-
 drivers/ram/Makefile                          |    3 +
 drivers/ram/sunxi/Kconfig                     |   73 +
 drivers/ram/sunxi/Makefile                    |    4 +
 drivers/ram/sunxi/dram_sun20i_d1.c            | 1432 +++++++++++++++++
 drivers/ram/sunxi/dram_sun20i_d1.h            |   73 +
 drivers/video/hitachi_tx18d42vm_lcd.c         |    1 +
 drivers/video/ssd2828.c                       |    1 -
 drivers/video/sunxi/sunxi_display.c           |    1 +
 drivers/video/sunxi/sunxi_lcd.c               |    1 +
 include/configs/sunxi-common.h                |    2 +-
 include/dt-bindings/clock/sun20i-d1-ccu.h     |  158 ++
 include/dt-bindings/clock/sun20i-d1-r-ccu.h   |   19 +
 include/dt-bindings/reset/sun20i-d1-ccu.h     |   79 +
 include/dt-bindings/reset/sun20i-d1-r-ccu.h   |   16 +
 .../arch-sunxi/gpio.h => include/sunxi_gpio.h |   83 +-
 109 files changed, 3809 insertions(+), 326 deletions(-)
 create mode 100644 arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts
 create mode 100644 arch/arm/dts/sun8i-t113s.dtsi
 create mode 100644 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
 create mode 100644 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
 create mode 100644 arch/arm/include/asm/arch-sunxi/serial.h
 delete mode 100644 arch/arm/mach-sunxi/pinmux.c
 create mode 100644 arch/riscv/dts/sun20i-common-regulators.dtsi
 create mode 100644 arch/riscv/dts/sun20i-d1.dtsi
 create mode 100644 arch/riscv/dts/sun20i-d1s.dtsi
 create mode 100644 arch/riscv/dts/sunxi-d1-t113.dtsi
 create mode 100644 arch/riscv/dts/sunxi-d1s-t113.dtsi
 create mode 100644 configs/mangopi_mq_r_defconfig
 create mode 100644 drivers/clk/sunxi/clk_d1.c
 create mode 100644 drivers/ram/sunxi/Kconfig
 create mode 100644 drivers/ram/sunxi/Makefile
 create mode 100644 drivers/ram/sunxi/dram_sun20i_d1.c
 create mode 100644 drivers/ram/sunxi/dram_sun20i_d1.h
 create mode 100644 include/dt-bindings/clock/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/clock/sun20i-d1-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-r-ccu.h
 rename arch/arm/include/asm/arch-sunxi/gpio.h => include/sunxi_gpio.h (75%)

-- 
2.35.8

