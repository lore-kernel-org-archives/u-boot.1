Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77863C3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 01:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6374B80ADF;
	Sun, 11 May 2025 03:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB1BA826AA; Sun, 11 May 2025 03:10:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6FA588091A
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 03:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD6B71516;
 Sat, 10 May 2025 18:10:00 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 834013F58B;
 Sat, 10 May 2025 18:10:10 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 0/6] sunxi: Allwinner A133 SoC support
Date: Sun, 11 May 2025 02:09:57 +0100
Message-ID: <20250511011003.15654-1-andre.przywara@arm.com>
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

This is an update to that early post of the Allwinner A133 SoC support,
now much more serious, and also adding support for a development board.
The DRAM init code was heavily updated, also rebased to apply on latest
mainline. Some uncontroversial and simple patches from v1 have been
merged, so this series mostly is about the DRAM code and the Kconfig
bits.
To make this usable, this contains patches to add support for one
development board using this SoC. The DT patch for that board is
pending review on the Linux mailing list, I include it here for the sake
of completeness, it will eventually find its way via the DT rebasing
repo.
===========================

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

This series aims to support boards with the A133 SoC in U-Boot.

Patch 1 is the technically most advanced and challenging patch: to add
support for the DRAM controller. Huge thanks and kudos go to Cody, for
reverse engineering, debugging and testing this. The code works for
me (TM), but I guess there be some improvements and refactoring coming
up.

Patch 2 then puts the right values for various existing Allwinner
specific configuration options in Kconfig, and adds the remaining bits
required to enable configuration and build for boards with the A133 SoC.

Patch 3 and 4 update the DT files from the latest kernel repo, anticipating
the update via the DT rebasing repo, to get a matching base for patch 5,
which adds the board .dts file for the Liontron H-A133L development
board. The DT has been proposed on the kernel ML, but has not been
reviewed or approved yet. Since a .dts file is essential for building
the image for a board, I include it here.

Please have a look, comment and review on the patches, so that we can
finish upstream support for this SoC.

Cheers,
Andre

Changelog v1 .. v2:
- update to latest mainline
- drop already applied patches
- heavy update of the DRAM driver (see commit msg for more details)
- add some (yet) missing DT patches
- add Liontron H-A133L .dts and defconfig file

Andre Przywara (5):
  sunxi: add support for the Allwinner A100/A133 SoC
  arm64: dts: allwinner: a100: Add CPU Operating Performance Points table
  arm64: dts: allwinner: a100: set maximum MMC frequency
  arm64: dts: allwinner: a100: add Liontron H-A133L board support
  sunxi: add support for Liontron H-A133L board

Cody Eksal (1):
  sunxi: A133: add DRAM init code

 arch/arm/cpu/armv8/fel_utils.S                |    2 +-
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |    7 +
 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |    4 +
 arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
 .../include/asm/arch-sunxi/dram_sun50i_a133.h |  230 ++++
 arch/arm/mach-sunxi/Kconfig                   |  114 +-
 arch/arm/mach-sunxi/Makefile                  |    2 +
 arch/arm/mach-sunxi/board.c                   |    4 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |    3 +-
 arch/arm/mach-sunxi/cpu_info.c                |    2 +
 arch/arm/mach-sunxi/dram_sun50i_a133.c        | 1204 +++++++++++++++++
 arch/arm/mach-sunxi/dram_timings/Makefile     |    2 +
 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c  |   80 ++
 .../arm/mach-sunxi/dram_timings/a133_lpddr4.c |  102 ++
 board/sunxi/board.c                           |    4 +-
 common/spl/Kconfig                            |    4 +-
 configs/liontron-h-a133l_defconfig            |   37 +
 .../allwinner/sun50i-a100-allwinner-perf1.dts |    5 +
 .../arm64/allwinner/sun50i-a100-cpu-opp.dtsi  |   90 ++
 .../src/arm64/allwinner/sun50i-a100.dtsi      |   11 +
 .../sun50i-a133-liontron-h-a133l.dts          |  211 +++
 21 files changed, 2104 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
 create mode 100644 arch/arm/mach-sunxi/dram_sun50i_a133.c
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
 create mode 100644 configs/liontron-h-a133l_defconfig
 create mode 100644 dts/upstream/src/arm64/allwinner/sun50i-a100-cpu-opp.dtsi
 create mode 100644 dts/upstream/src/arm64/allwinner/sun50i-a133-liontron-h-a133l.dts

-- 
2.46.3

