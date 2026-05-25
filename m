Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D939CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6C1846A7;
	Mon, 25 May 2026 04:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="EgIAeLMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061FD8404D; Mon, 25 May 2026 03:28:53 +0200 (CEST)
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch
 [79.135.106.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9D8D8039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672526; x=1779931726;
 bh=L43fsmdAtF4Q64UIUmm6KgKsXSQL6ZndUMKxCIhrLs4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=EgIAeLMZ1nqYgQzmk87S3UhT9kmsvWC+8pIC0viFirbZDD6pWxtPzU9qaVySlIHdu
 u08IjFS9DxG4dDfyc8a3UN8O/Fr6VcfWEDbBa4nhsbhZdl1w/KqOC2OWUXV1yLpHWd
 RivIchk6i+jLfF+GQ7fi4gsAY5jWZhvqm4XdEa/wR8+MzvcT8/AmG8qvQsSwFHXCRu
 n1CExuzG+UED6l2B7EAo6v7qgRUqZlD/WRZ4Ro8Tgdw5sksPgQE8OKoDeczXnxwKcg
 lWhcuYhF8Zn6Wkra5sx+uMCc0flOdNb203d2SegEWc2IedeJSVM+zvZ8CPNnwqzHMu
 SI0iKQM8KwnVg==
Date: Mon, 25 May 2026 01:28:41 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 00/14] arm: rockchip: rk3576: BLOB-free TPL DRAM init
Message-ID: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: cb18cbe444057d5f9d8d2a44a92250ce714baa36
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

This series adds an open-source TPL DRAM initialisation driver for the
Rockchip RK3576 SoC, replacing the proprietary DDR binary blob.

Hardware
--------
The RK3576 DDR subsystem consists of two independent channels, each
containing one Synopsys uMCTL2 DDRCTL and one Synopsys LPDDR4/4X/5
combo PHY.  Supported DRAM types: LPDDR4, LPDDR4X, LPDDR5.

The driver follows the TRM =C2=A77.6.2 (LPDDR4, 37 steps) and =C2=A77.6.3
(LPDDR5, 42 steps) software initialisation procedures.

PHY training
------------
The RK3576 combo PHY includes a hardware training engine controlled by
SCHD_TRAIN_CON0[0] (phy_train_en) and SCHD_TRAIN_CON0[1]
(phy_train_done).  No Synopsys PHY training firmware (.bin) is required.
This was confirmed from the TRM and matches the approach used on RK3568.

Timing tables
-------------
Precalculated timing tables are provided as .inc files, one per DRAM
type and speed grade.  The values in this RFC are TRM reset defaults
(placeholders) and are NOT correct for actual hardware operation.
Correct values require:
  - JEDEC JESD209-5B (LPDDR5) / JESD209-4D (LPDDR4) timing parameters
  - Synopsys uMCTL2 SRS field encoding rules
  - The specific DRAM part number and its datasheet

Target board
------------
Primary target: Flipper One (rk3576-flipper-one-rev-f0b0c1) with 8 GB
LPDDR5.  This addresses the open task in
flipperdevices/flipperone-linux-build-scripts#56.  The Flipper One DTS
is not yet upstream; a Flipper One defconfig will follow once it lands.

The series also enables the driver for the ArmSoM Sige5
(configs/sige5-rk3576_defconfig) as an immediately testable board.

Series structure
----------------
 01/14  sysreset: guard sysreset_psci.o from XPL builds (prerequisite)
 02/14  clk: rk3576: OF_PLATDATA support for TPL
 03/14  clk: rk3576: use CONFIG_XPL_BUILD (fixes TPL size exclusion)
 04/14  syscon: add DDR GRF region
 05/14  sdram_common: LPDDR4X and LPDDR5 type support
 06/14  new: sdram_pctl_rk3576.h =E2=80=94 uMCTL2 register layout
 07/14  new: sdram_rk3576.h     =E2=80=94 platform structs and addresses
 08/14  new: sdram_phy_rk3576.h =E2=80=94 combo PHY register layout
 09/14  new: sdram_rk3576.c     =E2=80=94 controller + PHY driver
 10/14  new: LPDDR4 timing table placeholder (1560 MHz CK)
 11/14  new: LPDDR5 timing table placeholder (2133 MHz PHY 2x clock)
 12/14  dts: DMC reg spaces and DDR GRF syscon node
 13/14  serial: DM_DRIVER_ALIAS for RK3576 UART
 14/14  Kconfig + defconfig: enable TPL for RK3576

Known limitations / TODO
-------------------------
 - Timing tables contain only TRM reset values.  Hardware bring-up
   will fail until values are calculated from JEDEC specs + chip data.
 - LPDDR5 MR1/MR2 encoding (initmr0) not yet calculated.
 - PHY vref and ODT settings use PHY reset defaults (steps 27-28/31-32).
 - Flipper One defconfig pending DTS upstream.
 - Not compile-tested on real hardware yet (cross-compiler required).

Modelled on the RK3568 RFC series (20260517-rk3568-raminit-v1,
Pavel Golikov).

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>

Johan Axelsson (14):
  sysreset: psci: exclude from XPL builds
  clk: rockchip: rk3576: add OF_PLATDATA support for TPL
  clk: rockchip: rk3576: use CONFIG_XPL_BUILD instead of
    CONFIG_SPL_BUILD
  arm: rockchip: rk3576: add DDR GRF syscon region
  ram: rockchip: sdram_common: add LPDDR4X and LPDDR5 support
  ram: rockchip: add RK3576 DDRCTL register definitions
  ram: rockchip: add RK3576 DRAM platform header
  ram: rockchip: add RK3576 DDRPHY register definitions
  ram: rockchip: rk3576: add DRAM controller and PHY driver
  ram: rockchip: rk3576: add LPDDR4 timing table placeholder (1560 MHz)
  ram: rockchip: rk3576: add LPDDR5 timing table placeholder (2133 MHz)
  arm: dts: rk3576: add DMC reg spaces and DDR GRF syscon node
  serial: rockchip: add DM_DRIVER_ALIAS for RK3576 UART
  arm: rockchip: rk3576: enable TPL DRAM init in Kconfig and defconfig

 arch/arm/dts/rk3576-u-boot.dtsi               |  15 +-
 arch/arm/include/asm/arch-rockchip/clock.h    |   1 +
 .../asm/arch-rockchip/sdram_pctl_rk3576.h     | 303 ++++++++
 .../asm/arch-rockchip/sdram_phy_rk3576.h      | 363 ++++++++++
 .../include/asm/arch-rockchip/sdram_rk3576.h  | 235 +++++++
 arch/arm/mach-rockchip/Kconfig                |  11 +
 arch/arm/mach-rockchip/rk3576/Kconfig         |   3 +
 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |   4 +-
 configs/sige5-rk3576_defconfig                |   3 +
 drivers/clk/rockchip/clk_rk3576.c             |  24 +-
 drivers/ram/rockchip/Kconfig                  |   7 +
 .../sdram-rk3576-lpddr4-detect-1560.inc       | 170 +++++
 .../sdram-rk3576-lpddr5-detect-2133.inc       | 174 +++++
 drivers/ram/rockchip/sdram_common.c           |  11 +-
 drivers/ram/rockchip/sdram_rk3576.c           | 655 +++++++++++++++++-
 drivers/serial/serial_rockchip.c              |   1 +
 drivers/sysreset/Makefile                     |   2 +
 17 files changed, 1963 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_pctl_rk3576.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_phy_rk3576.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_rk3576.h
 create mode 100644 drivers/ram/rockchip/sdram-rk3576-lpddr4-detect-1560.in=
c
 create mode 100644 drivers/ram/rockchip/sdram-rk3576-lpddr5-detect-2133.in=
c

--=20
2.45.1.windows.1


