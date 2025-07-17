Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBA3C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 23:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A3E0834E1;
	Fri, 18 Jul 2025 01:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1604833FC; Fri, 18 Jul 2025 01:56:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 50AD7833FC
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 01:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF471596;
 Thu, 17 Jul 2025 16:56:43 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 449D13F694;
 Thu, 17 Jul 2025 16:56:50 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/20] sunxi: Add Allwinner A523 support
Date: Fri, 18 Jul 2025 00:54:35 +0100
Message-ID: <20250717235455.32528-1-andre.przywara@arm.com>
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

Hi,

(Mikhail and Jernej: please reply with S-o-b: lines for your patches!)

this series introduces support for the Allwinner A523 SoC family.
Compared to v1, a good chunk of those patches have been merged, so we are
down from 34 to 20 patches now. There are some small fixes to the
pinctrl driver, and the SPL clock bits got updated to fix the conflicts
with the now merged A133 support. I rewrote the SPL watchdog code, to
avoid the MMIO register C struct. The DRAM driver lost one MMIO register
struct. The DT files have now landed in the DT rebasing repo, so we can
cherry-pick them from there.

Otherwise this now based on latest U-Boot master, which hopefully makes
testing easier. If people don't shout, I would like to merge it still
during this merge window, since the patches have been around for a while,
and people want to use them, alongside the now supported mainline Linux
code. So please test and review!

==================================
This series introduces support for the Allwinner A523 SoC family. The
same die is used in different packages: the A523, A527, T527, and H728:
they connect a different set of peripherals to the pins, or enable extra
goodies like an NPU. From a U-Boot perspective those chips do not differ
much, all the differences are described in the board DT files.

To be able to share the SPL clock code, the existing H6 code gets
refactored in patches 01-04. This unifies the (CPU) PLL handling across
the SoCs supported by this code (H6, H616, A133), and adds support for
the separate CPU PLLs on the A523.

Patches 05-10 extend the existing Allwinner U-Boot drivers to cope with
some of the changed peripherals, this includes the mandatory clock and
pinctrl drivers, but also some clock tweaks for the MMC controller
driver, and support for the new-ish AXP323 PMIC used on most boards.

Patches 11 updates some SPL bits to be able to cope with the A523.
Patches 12-15 add the new SPL bits for the A523, most prominently the DRAM
initialisation code. Many thanks to Jernej and Mikhail for providing
this part, there is a great reverse engineering and testing effort behind
this.

Patches 16-19 cherry-pick the DT files from the DT rebasing repo. There
are more fix patches queued, I will update them once they hit the repo.

The final patch adds defconfig files for the three boards that seem to be
the most popular at the moment, they include two development boards and
one TV box. The most interesting bits in there are the DRAM parameters.

Please have a look, review, and test.

Cheers,
Andre

Andre Przywara (17):
  sunxi: clock: H6: unify PLL control bit definitions
  sunxi: clock: H6: factor out clock_set_pll()
  sunxi: clock: H6: factor out H6/H616 CPU clock setup
  sunxi: clock: H6: add A523 CPU PLL support
  sunxi: spl: add support for Allwinner A523 watchdog
  clk: sunxi: Add support for the A523 CCU
  clk: sunxi: Add support for the A523 -R CCU
  pinctrl: sunxi: add Allwinner A523 pinctrl description
  sunxi: mmc: add support for Allwinner A523 MMC mod clock
  power: regulator: add AXP323 support
  sunxi: update cpu_sunxi_ncat2.h
  sunxi: add basic A523 support
  arm64: dts: allwinner: Add Allwinner A523 .dtsi file
  arm64: dts: allwinner: a523: add X96Q-Pro+ support
  arm64: dts: allwinner: a523: add Radxa A5E support
  arm64: dts: allwinner: a523: add Avaota-A1 router support
  sunxi: A523: add defconfigs for three boards

Jernej Skrabec (2):
  sunxi: sun50i_h6: add A523 SPL clock setup code
  sunxi: A523: add DRAM initialisation routine

Mikhail Kalashnikov (1):
  sunxi: A523: add DDR3 DRAM support

 arch/arm/cpu/armv8/fel_utils.S                |    5 +-
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |   49 +-
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |   20 +
 arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
 .../include/asm/arch-sunxi/dram_sun55i_a523.h |  153 ++
 arch/arm/include/asm/arch-sunxi/watchdog.h    |    2 +
 arch/arm/mach-sunxi/Kconfig                   |   54 +-
 arch/arm/mach-sunxi/Makefile                  |    2 +
 arch/arm/mach-sunxi/board.c                   |   11 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |  153 +-
 arch/arm/mach-sunxi/cpu_info.c                |    2 +
 arch/arm/mach-sunxi/dram_sun50i_a133.c        |   10 +-
 arch/arm/mach-sunxi/dram_sun50i_h6.c          |    6 +-
 arch/arm/mach-sunxi/dram_sun50i_h616.c        |    6 +-
 arch/arm/mach-sunxi/dram_sun55i_a523.c        | 1590 +++++++++++++++++
 arch/arm/mach-sunxi/dram_timings/Makefile     |    2 +
 arch/arm/mach-sunxi/dram_timings/a523_ddr3.c  |  134 ++
 .../arm/mach-sunxi/dram_timings/a523_lpddr4.c |  119 ++
 board/sunxi/MAINTAINERS                       |   15 +
 board/sunxi/board.c                           |    7 +-
 common/spl/Kconfig                            |    4 +-
 configs/avaota-a1_defconfig                   |   31 +
 configs/radxa-a5e_defconfig                   |   30 +
 configs/x96q_pro_plus_defconfig               |   32 +
 drivers/clk/sunxi/Kconfig                     |   14 +
 drivers/clk/sunxi/Makefile                    |    2 +
 drivers/clk/sunxi/clk_a523.c                  |   85 +
 drivers/clk/sunxi/clk_a523_r.c                |   39 +
 drivers/clk/sunxi/clk_sunxi.c                 |   10 +
 drivers/mmc/sunxi_mmc.c                       |   16 +-
 drivers/pinctrl/sunxi/Kconfig                 |   10 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   50 +
 drivers/power/pmic/axp.c                      |    1 +
 drivers/power/regulator/axp_regulator.c       |    1 +
 .../src/arm64/allwinner/sun55i-a523.dtsi      |  598 +++++++
 .../arm64/allwinner/sun55i-a527-cubie-a5e.dts |  299 ++++
 .../arm64/allwinner/sun55i-h728-x96qpro+.dts  |  287 +++
 .../arm64/allwinner/sun55i-t527-avaota-a1.dts |  308 ++++
 include/axp_pmic.h                            |    1 +
 include/configs/sun55i.h                      |   11 +
 40 files changed, 4109 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
 create mode 100644 arch/arm/mach-sunxi/dram_sun55i_a523.c
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a523_lpddr4.c
 create mode 100644 configs/avaota-a1_defconfig
 create mode 100644 configs/radxa-a5e_defconfig
 create mode 100644 configs/x96q_pro_plus_defconfig
 create mode 100644 drivers/clk/sunxi/clk_a523.c
 create mode 100644 drivers/clk/sunxi/clk_a523_r.c
 create mode 100644 dts/upstream/src/arm64/allwinner/sun55i-a523.dtsi
 create mode 100644 dts/upstream/src/arm64/allwinner/sun55i-a527-cubie-a5e.dts
 create mode 100644 dts/upstream/src/arm64/allwinner/sun55i-h728-x96qpro+.dts
 create mode 100644 dts/upstream/src/arm64/allwinner/sun55i-t527-avaota-a1.dts
 create mode 100644 include/configs/sun55i.h

-- 
2.46.3

