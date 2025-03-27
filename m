Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA86EC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 11:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5ED8070C;
	Thu, 27 Mar 2025 12:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0BBC81951; Thu, 27 Mar 2025 12:12:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A1BE5806D8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 12:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31D3A1063;
 Thu, 27 Mar 2025 04:12:26 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 100FC3F58B;
 Thu, 27 Mar 2025 04:12:19 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Liya Huang <1425075683@qq.com>, linux-sunxi@lists.linux.dev
Subject: Pull request: u-boot-sunxi/next for next
Date: Thu, 27 Mar 2025 11:12:14 +0000
Message-Id: <20250327111214.2064340-1-andre.przywara@arm.com>
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

please pull these sunxi changes into next:

Assorted fixes, refactorings and additions that are ready, and shave
off some load from upcoming series'.

Improves MMC performance on D1/T113 (missed clock divider), enables
eMMC access on the H616 family (never worked, many thanks to Jernej for
the fix!), DRAM detection fixes for the H616 (now reportedly stable).

Some patches for the upcoming Allwinner A133 SoC support: a few
refactorings, plus the DM clock and pinctrl driver. The DRAM init
routines work, but need some more polishing, that also holds back the
actual enablement patch, which will hopefully follow for v2025.07 still.

Also some preparatory patches for the Allwinner A523 SoC support, for
now just to improve the FEL save/restore code. There will be more patches
coming up for this, ideally also in the coming cycle still.

Gitlab CI passed, and I booted that briefly on some boards.

Thanks,
Andre

===========================================================
The following changes since commit b052de94fa14577cb5d9e724edeb09fee674d582:

  test: lmb: fix the lmb_alloc_addr() based test cases (2025-03-26 14:05:36 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git next

for you to fetch changes up to 6d6d58be25dd0b8e1955b15cf197f418be58bfd9:

  sunxi: update rmr_switch.S source code (2025-03-27 00:26:35 +0000)

----------------------------------------------------------------
Andre Przywara (11):
      sunxi: mmc: Fix T113-s3 MMC clock divider
      sunxi: sun50i_h6: clock: fix PLL_PERIPH0 rate calculation
      power: pmic: sunxi: add SPL support for the AXP803
      sunxi: pmic_bus: Move SPL I2C addresses into Kconfig
      sunxi: Kconfig: consolidate SYS_CLK_FREQ selection
      spl: reorder SPL_MAX_SIZE defaults for sunxi
      clk: sunxi: Add support for the A100/A133 CCU
      pinctrl: sunxi: add Allwinner A100/A133 pinctrl description
      sunxi: armv8: fel: move fel_stash variable to the front
      sunxi: arm64: boot0.h: move fel_stash_addr variable to the front
      sunxi: update rmr_switch.S source code

Jernej Skrabec (3):
      sunxi: h616: dram: Rework size detection
      sunxi: H616: dram: Improve address wrapping detection
      sunxi: mmc: Improve reset procedure

Liya Huang (1):
      sunxi: kconfig : Make CHIP_DIP_SCAN depend on ARCH_SUNXI

 arch/arm/cpu/armv8/fel_utils.S          |   7 ++-
 arch/arm/include/asm/arch-sunxi/boot0.h |   8 +--
 arch/arm/mach-sunxi/Kconfig             |  21 +++----
 arch/arm/mach-sunxi/clock_sun50i_h6.c   |  15 +++--
 arch/arm/mach-sunxi/dram_sun50i_h616.c  |  74 ++++++++++++++++++++---
 arch/arm/mach-sunxi/pmic_bus.c          |  27 +--------
 arch/arm/mach-sunxi/rmr_switch.S        |  40 +++++++++++--
 board/sunxi/board.c                     |   5 +-
 common/spl/Kconfig                      |   3 +-
 drivers/clk/sunxi/Kconfig               |   7 +++
 drivers/clk/sunxi/Makefile              |   1 +
 drivers/clk/sunxi/clk_a100.c            | 102 ++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk_sunxi.c           |   5 ++
 drivers/mmc/sunxi_mmc.c                 |  35 +++++++++--
 drivers/mmc/sunxi_mmc.h                 |  18 +++++-
 drivers/pinctrl/sunxi/Kconfig           |  10 ++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c   |  47 +++++++++++++++
 drivers/power/Kconfig                   |  25 ++++++--
 drivers/power/Makefile                  |   1 +
 drivers/power/axp_spl.c                 |  17 ++++++
 20 files changed, 390 insertions(+), 78 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk_a100.c
