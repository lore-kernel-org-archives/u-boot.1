Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2BEC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F8B81A0C;
	Sun, 23 Mar 2025 12:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC6C81A0C; Sun, 23 Mar 2025 12:36:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 98ED68059D
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 541EE339;
 Sun, 23 Mar 2025 04:36:17 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96E633F694;
 Sun, 23 Mar 2025 04:36:09 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 00/34] sunxi: clock refactoring and Allwinner A523 support
Date: Sun, 23 Mar 2025 11:35:10 +0000
Message-ID: <20250323113544.7933-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
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

This series introduces support for the Allwinner A523 SoC family. The
same die is used in different packages: the A523, A527, T527, and H728:
they connect a different set of peripherals to the pins, or enable extra
goodies like an NPU. From a U-Boot perspective those chips do not differ
much, all the differences are described in the board DT files.
These patches are not the most refined at the moment, but I hope that
people start reviewing them, so we can merge the ones that are ready,
to reduce their number.

To be able to share the SPL clock code, the existing H6 code gets
refactored in patches 01-13. This removes the C struct describing the
127 clock registers, and replaces it with macros defining the register
offsets. For more rationale and explanation see the 01/34 commit message.

Patches 14-20 extend the existing Allwinner U-Boot drivers to cope with
some of the changed peripherals, this includes the mandatory clock and
pinctrl drivers, but also some clock tweaks for the MMC controller
driver, and support for the new watchdog and the AXP323 used.

Patches 21-23 update some SPL bits to be able to cope with the A523.
Patches 24-28 extend the FEL handling code: the A523 has a GICv3, which
requires saving some GICv3 system registers, plus the IRQ mode stack
pointer. Patches 25-27 refactor the CPU clock code, and add the new
clock bits required by the A523.

Patch 29-32 add the new SPL bits for the A523, most prominently the DRAM
initialisation code. Many thanks to Jernej and Mikhail for providing
this part, there is a great reverse engineering and testing effort behind
this.

Patch 33 copies the DT files from the proposed Linux patches. They have
not been merged yet, mostly due to one missing DT binding dependency in
the linux-next tree, but have otherwise been agreed upon, with almost
every used binding being already merged. Eventually we will use the copy
from the DT rebasing repo, but for now those files must do.

The final patch adds defconfig files for the three boards that seem to be
the most popular at the moment, they include two development boards and
one TV box. The most interesting bits in there are the DRAM parameters.

Please have a look, review, and test.

Thanks!
Andre

Andre Przywara (30):
  sunxi: clock: H6: drop usage of struct sunxi_ccm_reg
  sunxi: mmc: remove usage of struct sunxi_ccm_reg
  sunxi: H616: dram: remove usage of struct sunxi_ccm_reg
  sunxi: H6: dram: remove usage of struct sunxi_ccm_reg
  sunxi: clock: H6: remove struct sunxi_ccm_reg
  sunxi: clock: H6: drop usage of struct sunxi_prcm_reg
  sunxi: H6/H616: dram: remove usage of struct sunxi_prcm_reg
  sunxi: clock: H6: remove struct sunxi_prcm_reg
  sunxi: clock: H6: unify PLL control bit definitions
  sunxi: clock: H6: factor out clock_set_pll()
  sunxi: clock: H6: factor out H6/H616 CPU clock setup
  sunxi: clock: H6: add A523 CPU PLL support
  dt-bindings: add Allwinner A523 CCU bindings
  clk: sunxi: Add support for the A523 CCU
  clk: sunxi: Add support for the A523 -R CCU
  pinctrl: sunxi: add Allwinner A523 pinctrl description
  sunxi: mmc: add support for Allwinner A523 MMC mod clock
  watchdog: sunxi: add A523 support
  power: regulator: add AXP323 support
  sunxi: update cpu_sunxi_ncat2.h
  sunxi: Kconfig: consolidate SYS_CLK_FREQ selection
  spl: reorder SPL_MAX_SIZE defaults for sunxi
  sunxi: armv8: fel: move fel_stash variable to the front
  sunxi: arm64: boot0.h: move fel_stash_addr variable to the front
  sunxi: update rmr_switch.S source code
  sunxi: armv8: FEL: save and restore GICv3 registers
  sunxi: armv8: FEL: save and restore SP_IRQ
  sunxi: add basic A523 support
  sunxi: A523: add DT files from Linux v3 branch
  sunxi: A523: add defconfigs for three boards

Jernej Skrabec (3):
  sunxi: spl: add support for Allwinner A523 watchdog
  sunxi: sun50i_h6: add A523 SPL clock setup code
  sunxi: A523: add DRAM initialisation routine

Mikhail Kalashnikov (1):
  sunxi: A523: add DDR3 DRAM support

 arch/arm/cpu/armv8/fel_utils.S                |   20 +-
 arch/arm/dts/sun55i-a523.dtsi                 |  598 +++++++
 arch/arm/dts/sun55i-a527-radxa-a5e.dts        |  299 ++++
 arch/arm/dts/sun55i-h728-x96qpro+.dts         |  287 +++
 arch/arm/dts/sun55i-t527-avaota-a1.dts        |  308 ++++
 arch/arm/include/asm/arch-sunxi/boot0.h       |   20 +-
 arch/arm/include/asm/arch-sunxi/clock_sun4i.h |    6 +
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  280 +--
 arch/arm/include/asm/arch-sunxi/clock_sun6i.h |    7 +
 .../include/asm/arch-sunxi/clock_sun8i_a83t.h |    7 +
 arch/arm/include/asm/arch-sunxi/clock_sun9i.h |    7 +
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |   20 +
 arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
 .../include/asm/arch-sunxi/dram_sun55i_a523.h |  183 ++
 arch/arm/include/asm/arch-sunxi/prcm_sun50i.h |   44 +-
 arch/arm/include/asm/arch-sunxi/watchdog.h    |   12 +
 arch/arm/mach-sunxi/Kconfig                   |   69 +-
 arch/arm/mach-sunxi/Makefile                  |    2 +
 arch/arm/mach-sunxi/board.c                   |   14 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |  203 ++-
 arch/arm/mach-sunxi/cpu_info.c                |    2 +
 arch/arm/mach-sunxi/dram_sun50i_h6.c          |   41 +-
 arch/arm/mach-sunxi/dram_sun50i_h616.c        |   41 +-
 arch/arm/mach-sunxi/dram_sun55i_a523.c        | 1592 +++++++++++++++++
 arch/arm/mach-sunxi/dram_timings/Makefile     |    2 +
 arch/arm/mach-sunxi/dram_timings/a523_ddr3.c  |  135 ++
 .../arm/mach-sunxi/dram_timings/a523_lpddr4.c |  119 ++
 arch/arm/mach-sunxi/rmr_switch.S              |   52 +-
 board/sunxi/board.c                           |    6 +-
 common/spl/Kconfig                            |    7 +-
 configs/avaota-a1_defconfig                   |   31 +
 configs/radxa-a5e_defconfig                   |   30 +
 configs/x96q_pro_plus_defconfig               |   33 +
 drivers/clk/sunxi/Kconfig                     |   14 +
 drivers/clk/sunxi/Makefile                    |    2 +
 drivers/clk/sunxi/clk_a523.c                  |   85 +
 drivers/clk/sunxi/clk_a523_r.c                |   44 +
 drivers/clk/sunxi/clk_sunxi.c                 |   10 +
 drivers/mmc/sunxi_mmc.c                       |   36 +-
 drivers/pinctrl/sunxi/Kconfig                 |   10 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   49 +
 drivers/power/pmic/axp.c                      |    1 +
 drivers/power/regulator/axp_regulator.c       |    1 +
 drivers/watchdog/sunxi_wdt.c                  |   11 +
 include/axp_pmic.h                            |    1 +
 include/configs/sun55i.h                      |   11 +
 include/dt-bindings/clock/sun55i-a523-ccu.h   |  189 ++
 include/dt-bindings/clock/sun55i-a523-r-ccu.h |   37 +
 include/dt-bindings/reset/sun55i-a523-ccu.h   |   88 +
 include/dt-bindings/reset/sun55i-a523-r-ccu.h |   25 +
 50 files changed, 4685 insertions(+), 408 deletions(-)
 create mode 100644 arch/arm/dts/sun55i-a523.dtsi
 create mode 100644 arch/arm/dts/sun55i-a527-radxa-a5e.dts
 create mode 100644 arch/arm/dts/sun55i-h728-x96qpro+.dts
 create mode 100644 arch/arm/dts/sun55i-t527-avaota-a1.dts
 create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
 create mode 100644 arch/arm/mach-sunxi/dram_sun55i_a523.c
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a523_lpddr4.c
 create mode 100644 configs/avaota-a1_defconfig
 create mode 100644 configs/radxa-a5e_defconfig
 create mode 100644 configs/x96q_pro_plus_defconfig
 create mode 100644 drivers/clk/sunxi/clk_a523.c
 create mode 100644 drivers/clk/sunxi/clk_a523_r.c
 create mode 100644 include/configs/sun55i.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-r-ccu.h

-- 
2.46.3

