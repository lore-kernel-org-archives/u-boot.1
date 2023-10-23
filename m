Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E0AC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA72878BA;
	Mon, 23 Oct 2023 12:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1797D878BB; Mon, 23 Oct 2023 12:48:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3323387853
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B786C15;
 Mon, 23 Oct 2023 03:49:17 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E51443F762;
 Mon, 23 Oct 2023 03:48:34 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: Pull request: u-boot-sunxi/master for v2024.01
Date: Mon, 23 Oct 2023 11:48:30 +0100
Message-Id: <20231023104830.792659-1-andre.przywara@arm.com>
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

Hi Tom,

please pull the sunxi/master branch, containing the first part of the
2024.01 changes. Apologies for the late PR, there were quite some recent
activities (fixes and reviews), but I didn't want to delay this series
any longer, since it's been around one year in the making already:

This is mostly about support for the Allwinner R528/T113s SoC, which is
reportedly the same die as the Allwinner D1, but with the two
Arm Cortex-A7 cores activated instead of the RISC-V one.
Using sunxi code outside of arch/arm proved to be difficult, so apart
from enabling this Arm SoC, the patches also prepare for more refactoring
to get the D1 nicely supported some day:
- We get rid of some Kconfig (hard-)coded GPIO pins, responsible for
  enabling regulators.
- The GPIO code is moved out of arch/arm, into drivers/gpio.
- Some definitions are moved out of header files under asm/arch.
- Some T113s/D1 specific definitions are guarded by a generic Kconfig
  symbol (CONFIG_SUNXI_GEN_NCAT2).
- The DRAM controller initialisation code is located under drivers/ram.
- The base SoC .dtsi files are shared (under arch/riscv, as in Linux).

Of course there are also the usual new SoC specific patches, like clock
and pinmux descriptions, alongside a rework of the pinctrl code, since
Allwinner changed the GPIO register layout, for the first time since
sunxi's inception.
On top of this the PSCI code sees some update, to provide SMP services
for R528/T113s boards. Many thanks to Sam for providing this code and 
staying strong through the review cycles.
The final patch enables support for one popular board, I hope to see
more DTs and defconfigs contributed in the future!

Many thanks to all the various contributors, testers and reviewers,
that series was a real team effort!

The gitlab CI completed successfully.

Thanks,
Andre

===========================
The following changes since commit 9a3a58396b78b1f9d0c14580dc03f81d29207dd2:

  Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2023-10-20 12:54:33 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to fa066df62ed9bfe0aed7749a68457468ad8bcc1c:

  sunxi: add MangoPi MQ-R board support (2023-10-23 01:00:56 +0100)

----------------------------------------------------------------
Andre Przywara (21):
      sunxi: dts: arm64: update devicetree files from Linux-v6.6-rc6
      sunxi: dts: arm: update devicetree files from Linux-v6.6-rc6
      sunxi: dts: arm: add T113s/D1 DT files from Linux-v6.6-rc6
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

 arch/arm/Kconfig                                   |    3 +-
 arch/arm/cpu/armv7/Kconfig                         |    3 +-
 arch/arm/cpu/armv7/sunxi/psci.c                    |  190 ++-
 arch/arm/cpu/armv7/sunxi/sram.c                    |    1 +
 arch/arm/cpu/armv8/fel_utils.S                     |    1 +
 arch/arm/dts/Makefile                              |    2 +
 arch/arm/dts/axp209.dtsi                           |    7 +
 arch/arm/dts/sun50i-a64.dtsi                       |    3 +-
 arch/arm/dts/sun50i-h6-pine-h64-model-b.dts        |    2 +-
 arch/arm/dts/sun50i-h616-orangepi-zero.dtsi        |  134 ++
 arch/arm/dts/sun50i-h616-orangepi-zero2.dts        |  121 +-
 arch/arm/dts/sun50i-h616-x96-mate.dts              |    2 +-
 arch/arm/dts/sun50i-h618-orangepi-zero3.dts        |   94 ++
 arch/arm/dts/sun5i-r8-chip.dts                     |    6 +
 arch/arm/dts/sun5i.dtsi                            |   11 +-
 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts      |  137 ++
 arch/arm/dts/sun7i-a20-icnova-a20.dtsi             |   62 +
 arch/arm/dts/sun8i-a23-a33.dtsi                    |    2 +-
 arch/arm/dts/sun8i-a83t.dtsi                       |    2 +-
 arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts     |   35 +
 arch/arm/dts/sun8i-t113s.dtsi                      |   59 +
 arch/arm/dts/sun8i-v3s.dtsi                        |    2 +-
 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi      |  126 ++
 arch/arm/dts/sunxi-u-boot.dtsi                     |    7 +
 arch/arm/include/asm/arch-sunxi/boot0.h            |    2 +
 arch/arm/include/asm/arch-sunxi/clock.h            |    3 +-
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h  |   12 +-
 arch/arm/include/asm/arch-sunxi/cpu.h              |    2 +
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h        |   17 -
 arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h    |    7 -
 arch/arm/include/asm/arch-sunxi/cpu_sun9i.h        |    9 -
 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |   39 +
 arch/arm/include/asm/arch-sunxi/cpucfg.h           |   67 -
 arch/arm/include/asm/arch-sunxi/mmc.h              |    2 +-
 arch/arm/include/asm/arch-sunxi/prcm.h             |    2 +-
 arch/arm/include/asm/arch-sunxi/serial.h           |   32 +
 arch/arm/include/asm/arch-sunxi/timer.h            |    2 +-
 arch/arm/mach-sunxi/Kconfig                        |   42 +-
 arch/arm/mach-sunxi/Makefile                       |    2 +-
 arch/arm/mach-sunxi/board.c                        |   31 +-
 arch/arm/mach-sunxi/clock_sun50i_h6.c              |   45 +-
 arch/arm/mach-sunxi/cpu_info.c                     |    2 +
 arch/arm/mach-sunxi/dram_suniv.c                   |    2 +-
 arch/arm/mach-sunxi/gtbus_sun9i.c                  |    1 +
 arch/arm/mach-sunxi/pinmux.c                       |   78 --
 arch/arm/mach-sunxi/spl_spi_sunxi.c                |    1 +
 arch/arm/mach-sunxi/timer.c                        |    1 +
 arch/riscv/dts/sunxi-d1-t113.dtsi                  |   15 +
 arch/riscv/dts/sunxi-d1s-t113.dtsi                 |  927 +++++++++++++
 board/sunxi/board.c                                |   34 +-
 board/sunxi/chip.c                                 |    2 +-
 common/spl/Kconfig                                 |    3 +-
 configs/A10-OLinuXino-Lime_defconfig               |    1 -
 configs/A20-OLinuXino-Lime2-eMMC_defconfig         |    1 -
 configs/A20-OLinuXino-Lime2_defconfig              |    1 -
 configs/A20-OLinuXino-Lime_defconfig               |    1 -
 configs/A20-OLinuXino_MICRO-eMMC_defconfig         |    1 -
 configs/A20-OLinuXino_MICRO_defconfig              |    1 -
 configs/A20-Olimex-SOM-EVB_defconfig               |    1 -
 configs/A20-Olimex-SOM204-EVB-eMMC_defconfig       |    1 -
 configs/A20-Olimex-SOM204-EVB_defconfig            |    1 -
 configs/Bananapi_M2_Ultra_defconfig                |    1 -
 configs/Bananapi_defconfig                         |    1 -
 configs/Bananapro_defconfig                        |    1 -
 configs/Cubieboard2_defconfig                      |    1 -
 configs/Cubieboard_defconfig                       |    1 -
 configs/Cubietruck_defconfig                       |    1 -
 configs/Itead_Ibox_A20_defconfig                   |    1 -
 configs/Lamobo_R1_defconfig                        |    2 -
 configs/Linksprite_pcDuino3_Nano_defconfig         |    1 -
 configs/Linksprite_pcDuino3_defconfig              |    1 -
 configs/Mele_A1000_defconfig                       |    1 -
 configs/Orangepi_defconfig                         |    1 -
 configs/Orangepi_mini_defconfig                    |    1 -
 configs/Sinovoip_BPI_M3_defconfig                  |    1 -
 configs/bananapi_m1_plus_defconfig                 |    1 -
 configs/bananapi_m2_plus_h3_defconfig              |    1 -
 configs/bananapi_m2_plus_h5_defconfig              |    1 -
 configs/i12-tvbox_defconfig                        |    1 -
 configs/jesurun_q5_defconfig                       |    1 -
 configs/mangopi_mq_r_defconfig                     |   15 +
 configs/mixtile_loftq_defconfig                    |    1 -
 configs/nanopi_m1_plus_defconfig                   |    1 -
 configs/nanopi_neo_plus2_defconfig                 |    1 -
 configs/nanopi_r1s_h5_defconfig                    |    1 -
 configs/orangepi_pc2_defconfig                     |    1 -
 configs/orangepi_plus2e_defconfig                  |    1 -
 configs/orangepi_plus_defconfig                    |    3 +-
 configs/orangepi_win_defconfig                     |    1 -
 configs/pine_h64_defconfig                         |    1 -
 configs/zeropi_defconfig                           |    1 -
 drivers/Makefile                                   |    1 +
 drivers/ata/ahci_sunxi.c                           |    9 +
 drivers/clk/sunxi/Kconfig                          |    7 +
 drivers/clk/sunxi/Makefile                         |    1 +
 drivers/clk/sunxi/clk_d1.c                         |   84 ++
 drivers/clk/sunxi/clk_sunxi.c                      |    5 +
 drivers/gpio/Kconfig                               |    7 +
 drivers/gpio/axp_gpio.c                            |    1 +
 drivers/gpio/sunxi_gpio.c                          |  189 ++-
 drivers/i2c/mvtwsi.c                               |    3 +-
 drivers/i2c/sun6i_p2wi.c                           |    2 +-
 drivers/i2c/sun8i_rsb.c                            |    2 +-
 drivers/mmc/sunxi_mmc.c                            |    9 +-
 drivers/net/sun8i_emac.c                           |    7 +
 drivers/net/sunxi_emac.c                           |   38 +
 drivers/pinctrl/sunxi/Kconfig                      |    5 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   47 +-
 drivers/ram/Kconfig                                |    3 +-
 drivers/ram/Makefile                               |    3 +
 drivers/ram/sunxi/Kconfig                          |   60 +
 drivers/ram/sunxi/Makefile                         |    3 +
 drivers/ram/sunxi/dram_sun20i_d1.c                 | 1441 ++++++++++++++++++++
 drivers/ram/sunxi/dram_sun20i_d1.h                 |   73 +
 drivers/video/hitachi_tx18d42vm_lcd.c              |    1 +
 drivers/video/ssd2828.c                            |    1 -
 drivers/video/sunxi/sunxi_display.c                |    1 +
 drivers/video/sunxi/sunxi_lcd.c                    |    1 +
 include/configs/sunxi-common.h                     |    2 +-
 include/dt-bindings/clock/sun20i-d1-ccu.h          |  158 +++
 include/dt-bindings/clock/sun20i-d1-r-ccu.h        |   19 +
 include/dt-bindings/clock/sun50i-h6-ccu.h          |    2 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h        |    2 +-
 include/dt-bindings/clock/sun6i-rtc.h              |    2 +-
 include/dt-bindings/reset/sun20i-d1-ccu.h          |   79 ++
 include/dt-bindings/reset/sun20i-d1-r-ccu.h        |   16 +
 include/dt-bindings/reset/sun50i-h6-ccu.h          |    2 +-
 include/dt-bindings/reset/sun50i-h6-r-ccu.h        |    2 +-
 include/dt-bindings/reset/sun50i-h616-ccu.h        |    2 +-
 .../asm/arch-sunxi/gpio.h => include/sunxi_gpio.h  |   83 +-
 130 files changed, 4229 insertions(+), 594 deletions(-)
 create mode 100644 arch/arm/dts/sun50i-h616-orangepi-zero.dtsi
 create mode 100644 arch/arm/dts/sun50i-h618-orangepi-zero3.dts
 create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
 create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20.dtsi
 create mode 100644 arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts
 create mode 100644 arch/arm/dts/sun8i-t113s.dtsi
 create mode 100644 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
 create mode 100644 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
 delete mode 100644 arch/arm/include/asm/arch-sunxi/cpucfg.h
 create mode 100644 arch/arm/include/asm/arch-sunxi/serial.h
 delete mode 100644 arch/arm/mach-sunxi/pinmux.c
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
