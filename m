Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC9AC47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 15:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9BC87BB5;
	Mon, 29 Jan 2024 16:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016DB87BCB; Mon, 29 Jan 2024 16:55:59 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BECBC8775F
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 16:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DBF8DA7;
 Mon, 29 Jan 2024 07:56:39 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAD923F738;
 Mon, 29 Jan 2024 07:55:53 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Nick Alilovic <nickalilovic@gmail.com>,
 Chuanhong Guo <gch981213@gmail.com>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: Pull request: u-boot-sunxi/master for v2024.04
Date: Mon, 29 Jan 2024 15:55:43 +0000
Message-Id: <20240129155543.2439451-1-andre.przywara@arm.com>
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
2024.04 changes. I had some more (USB regulator) changes queued, but
found regressions during the final testing, so had to drop some. If I
can find reasons and simple fixes for those, I would send them later.

So for now these are some rather easy changes:
- Some cleanups in header files: those do not affect the generated
binaries at all.
- The usual update of DT files from the kernel repo, mostly adding new
board files this time. On the wake of this there is one defconfig to
enable a new board, some H618 TV box branded as "Transpeed".
- Samuel's series to support SPL FIT image loading for 32-bit SoCs as
well, so far this was restricted to ARM64 boards. I refrained from
automatically enabling this everywhere, instead this requires user
intervention during board configuration. This allows to ship the "crust"
management processor firmware on H3 boards, which enables better power
saving.
- One defconfig for an older H3 board. There was a close-by defconfig for
a related board, but there are some differences which deserve a separate
file.
- Support for the EMAC driver to work with fixed-link PHYs, which allows
to directly wire the MAC to a switch IC.

The branch survived build testing for all 167 sunxi boards, and Linux
boot testing on some selected boards.

Please pull!

Cheers,
Andre

==================
The following changes since commit 526a865fe4fea59fb2638726c26e39557eb97fdd:

  Merge branch 'master-cleanup' of https://source.denx.de/u-boot/custodians/u-boot-sh (2024-01-27 20:43:20 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to 539612e27690a8df7f197cd1e9f4c2cf6ee1ac64:

  sunxi: Consider SPL size limitations for FIT loading (2024-01-29 14:31:00 +0000)

----------------------------------------------------------------
Andre Przywara (7):
      sunxi: cleanup sunxi-common.h
      sunxi: sun50i-h6: remove unneeded base addresses from header
      sunxi: sun4i: remove unneeded base addresses from header
      sunxi: sun9i: remove unneeded base addresses from header
      sunxi: remove common.h inclusion
      sunxi: simplify U-Boot proper only builds
      sunxi: dts: update devicetree files from Linux-v6.8-rc1

Chuanhong Guo (1):
      sunxi: add defconfig for nanopi_duo2

Maksim Kiselev (1):
      net: sun8i-emac: Add support for fixed-link phy

Nick Alilovic (1):
      sunxi: add Transpeed 8K618-T board support

Samuel Holland (4):
      sunxi: spl: Disable padding from SPL_PAD_TO
      sunxi: binman: Move BL31 and SCP firmware addresses to Kconfig
      sunxi: binman: Support FIT generation for 32-bit SoCs
      sunxi: Consider SPL size limitations for FIT loading

 arch/arm/Kconfig                                   |   4 +-
 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/sun50i-h616-bigtreetech-cb1-manta.dts |  35 +++
 arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi      | 138 +++++++++++
 arch/arm/dts/sun50i-h616-bigtreetech-pi.dts        |  63 +++++
 arch/arm/dts/sun50i-h616.dtsi                      |   7 +
 arch/arm/dts/sun50i-h618-orangepi-zero2w.dts       | 176 +++++++++++++
 arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts     | 161 ++++++++++++
 arch/arm/dts/sun8i-r40.dtsi                        |   2 +
 arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts        | 276 +++++++++++++++++++++
 arch/arm/dts/sun8i-v3s.dtsi                        |  35 +++
 arch/arm/dts/sunxi-u-boot.dtsi                     |  41 +--
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h        |  47 ----
 arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h    |  21 --
 arch/arm/include/asm/arch-sunxi/cpu_sun9i.h        |  41 ---
 arch/arm/mach-sunxi/Kconfig                        |  33 ++-
 arch/arm/mach-sunxi/board.c                        |   1 -
 arch/arm/mach-sunxi/clock.c                        |   1 -
 arch/arm/mach-sunxi/clock_sun4i.c                  |   1 -
 arch/arm/mach-sunxi/clock_sun50i_h6.c              |   1 -
 arch/arm/mach-sunxi/clock_sun6i.c                  |   1 -
 arch/arm/mach-sunxi/clock_sun8i_a83t.c             |   1 -
 arch/arm/mach-sunxi/clock_sun9i.c                  |   1 -
 arch/arm/mach-sunxi/cpu_info.c                     |   1 -
 arch/arm/mach-sunxi/dram_helpers.c                 |   3 +-
 arch/arm/mach-sunxi/dram_sun4i.c                   |   1 -
 arch/arm/mach-sunxi/dram_sun50i_h6.c               |   1 -
 arch/arm/mach-sunxi/dram_sun50i_h616.c             |   1 -
 arch/arm/mach-sunxi/dram_sun6i.c                   |   1 -
 arch/arm/mach-sunxi/dram_sun8i_a23.c               |   1 -
 arch/arm/mach-sunxi/dram_sun8i_a33.c               |   1 -
 arch/arm/mach-sunxi/dram_sun8i_a83t.c              |   1 -
 arch/arm/mach-sunxi/dram_sun9i.c                   |   1 -
 arch/arm/mach-sunxi/dram_suniv.c                   |   2 +-
 arch/arm/mach-sunxi/dram_sunxi_dw.c                |   1 -
 arch/arm/mach-sunxi/gtbus_sun9i.c                  |   1 -
 arch/arm/mach-sunxi/pmic_bus.c                     |   1 -
 arch/arm/mach-sunxi/prcm.c                         |   1 -
 arch/arm/mach-sunxi/spl_spi_sunxi.c                |   1 -
 arch/arm/mach-sunxi/timer.c                        |   1 -
 common/spl/Kconfig                                 |   6 +-
 configs/nanopi_duo2_defconfig                      |  12 +
 configs/transpeed-8k618-t_defconfig                |  27 ++
 drivers/net/sun8i_emac.c                           |   7 +-
 include/configs/sunxi-common.h                     |  56 +----
 45 files changed, 1002 insertions(+), 214 deletions(-)
 create mode 100644 arch/arm/dts/sun50i-h616-bigtreetech-cb1-manta.dts
 create mode 100644 arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi
 create mode 100644 arch/arm/dts/sun50i-h616-bigtreetech-pi.dts
 create mode 100644 arch/arm/dts/sun50i-h618-orangepi-zero2w.dts
 create mode 100644 arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
 create mode 100644 arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts
 create mode 100644 configs/nanopi_duo2_defconfig
 create mode 100644 configs/transpeed-8k618-t_defconfig
