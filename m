Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A328FC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 15:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A1B829C7;
	Mon, 28 Apr 2025 17:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2529682A33; Mon, 28 Apr 2025 17:09:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 54D198293C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 17:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E5AA1516;
 Mon, 28 Apr 2025 08:09:13 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E603F673;
 Mon, 28 Apr 2025 08:09:18 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Subject: Pull request: u-boot-sunxi/master for v2025.07
Date: Mon, 28 Apr 2025 16:09:07 +0100
Message-Id: <20250428150907.206134-1-andre.przywara@arm.com>
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

please pull the sunxi/master branch, containing changes for the second
part of this cycle's sunxi updates.

We have improvements to the reliability of H6 and H616 DRAM
initialisation, hopefully avoiding those occasional size misdetections
many people reported before.
Also there is some modernisation of the USB PHY code, to use DT provided
regulators and GPIOs, instead of relying on this being badly duplicated
in Kconfig. This also happens to fix broken USB operations for older
boards (using the A20 SoCs, for instance), which were clashing over
grabbing some GPIOs, leading to a driver bailout.
There is also some rework of the H6/H616 SPL clock code, to prepare it
for being reused by the upcoming Allwinner A523 support. This drops the
usage of C structs to model MMIO register frames, and replaces them by
using an addition of the base address with a macro defined offset.
Also in preparation for A523 there is one fix and one addition for the
FEL code, to prepare for the GICv3 interrupt controller that the new SoC
uses. And since this is a simple fix, and was ready, there is also the
watchdog driver for that new SoC. Finally tossing in an easy fix to some
H616 defconfig files to enable eMMC.

I also use the opportunity to enable proper page table protection
(observing read-only and no-execute attributes), support for which the
arm64 port recently gained. I didn't spot any issues on my arm64 board
tests, but it can be easily disabled or backed out again in case any
issues arise.

Full support for the two new SoC series (A133 and A523) we are working
on is not quite ready yet, but might follow still a bit later if
progress permits.

CI passed, and boot-tested on at least one board with a H616, H6, A64,
H3, A20, T113s.

Thanks,
Andre

=================================
The following changes since commit 5a0a93a768487e55ebe50a34cc90d751bf99cc56:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-riscv (2025-04-25 13:13:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to d5837bbed841889428379ffff3cc19c9dca4cb6d:

  sunxi: clock: H6: remove struct sunxi_prcm_reg (2025-04-28 15:03:28 +0100)

----------------------------------------------------------------
Andre Przywara (16):
      sunxi: h616: defconfigs: enable eMMC
      sunxi: enable MMU_PGPROT proper page table protection
      phy: sun4i-usb: Determine VBUS detection pin from devicetree
      phy: sun4i-usb: Determine USB OTG detection pin from devicetree
      sunxi: Kconfig: Remove obsolete USBx_* pin symbols
      watchdog: sunxi: add A523 support
      sunxi: armv8: FEL: save and restore GICv3 registers
      sunxi: armv8: FEL: save and restore SP_IRQ
      sunxi: clock: H6: drop usage of struct sunxi_ccm_reg
      sunxi: mmc: remove usage of struct sunxi_ccm_reg
      sunxi: H616: dram: remove usage of struct sunxi_ccm_reg
      sunxi: H6: dram: remove usage of struct sunxi_ccm_reg
      sunxi: clock: H6: remove struct sunxi_ccm_reg
      sunxi: clock: H6: drop usage of struct sunxi_prcm_reg
      sunxi: H6/H616: dram: remove usage of struct sunxi_prcm_reg
      sunxi: clock: H6: remove struct sunxi_prcm_reg

Jernej Skrabec (4):
      sunxi: H6: Remove useless DRAM timings parameter
      sunxi: H6: DRAM: Constify function parameters
      sunxi: h6: dram: split dram_para struct
      sunxi: h6/h616: Reuse common DRAM infrastructure

Samuel Holland (5):
      power: regulator: Add a driver for the AXP PMIC drivevbus
      sunxi: Enable PMIC drivevbus regulator support for USB supplies
      phy: sun4i-usb: Control supplies via the regulator uclass
      sunxi: Remove obsolete USBx_VBUS_PIN Kconfig symbols
      gpio: axp: Remove virtual VBUS enable GPIO

 arch/arm/Kconfig                                   |   1 +
 arch/arm/cpu/armv8/fel_utils.S                     |   9 +
 arch/arm/include/asm/arch-sunxi/boot0.h            |  12 +-
 arch/arm/include/asm/arch-sunxi/clock_sun4i.h      |   6 +
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h  | 229 ++-------------------
 arch/arm/include/asm/arch-sunxi/clock_sun6i.h      |   7 +
 arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h |   7 +
 arch/arm/include/asm/arch-sunxi/clock_sun9i.h      |   7 +
 arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h  |  22 ++
 arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h   |   9 +-
 arch/arm/include/asm/arch-sunxi/prcm_sun50i.h      |  44 +---
 arch/arm/mach-sunxi/Kconfig                        |  43 ----
 arch/arm/mach-sunxi/Makefile                       |   4 +-
 arch/arm/mach-sunxi/board.c                        |   3 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c              |  72 +++----
 arch/arm/mach-sunxi/dram_dw_helpers.c              | 150 ++++++++++++++
 arch/arm/mach-sunxi/dram_sun50i_h6.c               | 212 ++++++-------------
 arch/arm/mach-sunxi/dram_sun50i_h616.c             | 184 ++---------------
 arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c    |   2 +-
 arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c       |   2 +-
 arch/arm/mach-sunxi/rmr_switch.S                   |  12 ++
 configs/A10s-OLinuXino-M_defconfig                 |   1 -
 configs/A13-OLinuXinoM_defconfig                   |   1 -
 configs/A13-OLinuXino_defconfig                    |   2 -
 configs/A20-OLinuXino-Lime2-eMMC_defconfig         |   2 -
 configs/A20-OLinuXino-Lime2_defconfig              |   2 -
 configs/A20-Olimex-SOM-EVB_defconfig               |   2 -
 configs/A20-Olimex-SOM204-EVB-eMMC_defconfig       |   2 -
 configs/A20-Olimex-SOM204-EVB_defconfig            |   2 -
 configs/A33-OLinuXino_defconfig                    |   3 +-
 configs/Ainol_AW1_defconfig                        |   1 -
 configs/Ampe_A76_defconfig                         |   3 -
 configs/Auxtek-T003_defconfig                      |   1 -
 configs/Auxtek-T004_defconfig                      |   1 -
 configs/Bananapi_M2_Ultra_defconfig                |   2 -
 configs/Bananapi_m2m_defconfig                     |   1 -
 configs/Bananapro_defconfig                        |   2 -
 configs/CHIP_defconfig                             |   1 -
 configs/CHIP_pro_defconfig                         |   1 -
 configs/CSQ_CS908_defconfig                        |   2 -
 configs/Chuwi_V7_CW0825_defconfig                  |   3 -
 configs/Colombus_defconfig                         |   1 -
 configs/Cubieboard4_defconfig                      |   5 +-
 configs/Cubietruck_defconfig                       |   3 -
 configs/Cubietruck_plus_defconfig                  |   5 +-
 configs/Empire_electronix_d709_defconfig           |   3 -
 configs/Empire_electronix_m712_defconfig           |   3 -
 configs/Hummingbird_A31_defconfig                  |   2 -
 configs/Hyundai_A7HD_defconfig                     |   4 -
 configs/Linksprite_pcDuino3_Nano_defconfig         |   1 -
 configs/Linksprite_pcDuino_defconfig               |   2 -
 configs/MSI_Primo81_defconfig                      |   2 +-
 configs/Mele_A1000G_quad_defconfig                 |   2 -
 configs/Mele_I7_defconfig                          |   2 -
 configs/Mele_M9_defconfig                          |   2 -
 configs/Merrii_A80_Optimus_defconfig               |   5 +-
 configs/Mini-X_defconfig                           |   1 -
 configs/Orangepi_defconfig                         |   2 -
 configs/Orangepi_mini_defconfig                    |   2 -
 configs/Sinlinx_SinA31s_defconfig                  |   2 -
 configs/Sinlinx_SinA33_defconfig                   |   1 -
 configs/Sinovoip_BPI_M2_defconfig                  |   2 -
 configs/Sinovoip_BPI_M3_defconfig                  |   4 +-
 configs/Sunchip_CX-A99_defconfig                   |   3 -
 configs/UTOO_P66_defconfig                         |   3 -
 configs/Wexler_TAB7200_defconfig                   |   2 -
 configs/Wobo_i5_defconfig                          |   1 -
 configs/Yones_Toptech_BD1078_defconfig             |   1 -
 configs/Yones_Toptech_BS1078_V2_defconfig          |   3 +-
 configs/ba10_tv_box_defconfig                      |   2 -
 configs/bananapi_m2_berry_defconfig                |   1 -
 configs/colorfly_e708_q1_defconfig                 |   3 +-
 configs/difrnce_dit4350_defconfig                  |   3 -
 configs/dserve_dsrv9703c_defconfig                 |   3 -
 configs/ga10h_v1_1_defconfig                       |   3 +-
 configs/gt90h_v4_defconfig                         |   3 +-
 configs/h8_homlet_v2_defconfig                     |   2 -
 configs/iNet_3F_defconfig                          |   2 -
 configs/iNet_3W_defconfig                          |   2 -
 configs/iNet_86VS_defconfig                        |   2 -
 configs/iNet_D978_rev2_defconfig                   |   3 +-
 configs/icnova-a20-swac_defconfig                  |   3 -
 configs/inet1_defconfig                            |   3 -
 configs/inet86dz_defconfig                         |   3 +-
 configs/inet97fv2_defconfig                        |   3 -
 configs/inet98v_rev2_defconfig                     |   3 -
 configs/inet9f_rev03_defconfig                     |   3 -
 configs/inet_q972_defconfig                        |   3 +-
 configs/jesurun_q5_defconfig                       |   1 -
 configs/mixtile_loftq_defconfig                    |   2 -
 configs/mk802_a10s_defconfig                       |   1 -
 configs/mk802_defconfig                            |   1 -
 configs/orangepi_2_defconfig                       |   1 -
 configs/orangepi_plus_defconfig                    |   2 -
 configs/orangepi_zero2_defconfig                   |   1 -
 configs/orangepi_zero3_defconfig                   |   1 -
 configs/parrot_r16_defconfig                       |   2 -
 configs/pine_h64_defconfig                         |   1 -
 configs/polaroid_mid2407pxe03_defconfig            |   3 +-
 configs/polaroid_mid2809pxe04_defconfig            |   3 +-
 configs/pov_protab2_ips9_defconfig                 |   3 -
 configs/q8_a13_tablet_defconfig                    |   3 -
 configs/q8_a23_tablet_800x480_defconfig            |   3 +-
 configs/q8_a33_tablet_1024x600_defconfig           |   3 +-
 configs/q8_a33_tablet_800x480_defconfig            |   3 +-
 configs/r7-tv-dongle_defconfig                     |   1 -
 configs/sun8i_a23_evb_defconfig                    |   3 -
 configs/tanix_tx1_defconfig                        |   2 +
 configs/tbs_a711_defconfig                         |   3 +-
 configs/teres_i_defconfig                          |   1 -
 configs/x96_mate_defconfig                         |   1 +
 drivers/gpio/axp_gpio.c                            |  75 ++-----
 drivers/gpio/sunxi_gpio.c                          |  12 +-
 drivers/mmc/sunxi_mmc.c                            |  20 +-
 drivers/phy/allwinner/phy-sun4i-usb.c              |  96 +++------
 drivers/power/pmic/axp.c                           |   1 +
 drivers/power/regulator/Kconfig                    |   7 +
 drivers/power/regulator/Makefile                   |   1 +
 drivers/power/regulator/axp_drivevbus.c            |  57 +++++
 drivers/watchdog/sunxi_wdt.c                       |  11 +
 include/axp221.h                                   |   4 -
 include/axp809.h                                   |   4 -
 include/axp818.h                                   |   4 -
 include/sunxi_gpio.h                               |   8 -
 124 files changed, 552 insertions(+), 984 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h
 create mode 100644 arch/arm/mach-sunxi/dram_dw_helpers.c
 create mode 100644 drivers/power/regulator/axp_drivevbus.c
