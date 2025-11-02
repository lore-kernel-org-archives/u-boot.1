Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97852CCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 02:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1B48307F;
	Sun,  2 Nov 2025 03:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gx8a3VPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35FB830A0; Sun,  2 Nov 2025 03:23:58 +0100 (CET)
Received: from mail-m81142.xmail.ntesmail.com (mail-m81142.xmail.ntesmail.com
 [156.224.81.142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC27382A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 03:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 28096ae6c;
 Sun, 2 Nov 2025 10:23:49 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20251101
Date: Sun,  2 Nov 2025 10:23:49 +0800
Message-Id: <20251102022349.326599-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a4260c5c103afkunm316abdcfa364db
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTxpKVklCTx1OGUlMTUMdSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=gx8a3VPacMmhZtelhPpJBqVjuajhOhXhkIH/gtdiTT/Nx6WeKHb7uxFiygKucAzx6hB7GWAGNEX79fvQozcWzmjZOYxIRyJcosG31vQV5aNM1AuiOOY8+rkfxWjYCkdCtLC57rMQVG3+P1Z8Kb5gPnNCEhHX9CA++/HvkrFzDCs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=pgOGnGGWzCt7w9GCqAEeeLMWirmga/FDIoNT+nO6TAc=;
 h=date:mime-version:subject:message-id:from;
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

Please pull the updates for rockchip platform:
- New Boards support: 
	rk3588: MNT Reform2
	rk3528: Radxa ROCK 2A/2F
	rk3576: ArmSoM Sige1, Luckfox Omni3576, FriendlyElec NanoPi M5, Radxa ROCK 4D
	rk3568: Lunzn FastRhino R66S
- Other board level updates.


CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/28119

Thanks,
- Kever

The following changes since commit e34d01d23e45e007368685ffa6dfd674b6dd7b17:

  Merge tag 'u-boot-ufs-20251029' of https://source.denx.de/u-boot/custodians/u-boot-ufs (2025-10-29 07:41:43 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20251101

for you to fetch changes up to 498a9756adf57e94af64e31b144a6698c656c50a:

  mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528 (2025-11-02 00:29:58 +0800)

----------------------------------------------------------------
David Barbion (1):
      board: rockchip: Fix RG353M model renaming

Jon Lin (1):
      spi: rockchip_sfc: Support sclk_x2 version

Jonas Karlman (32):
      clk: px30: Allow use of GPU and WIFI_PMU in assigned-clocks
      rockchip: odroid-go2: Remove cru assigned-clocks override
      rockchip: odroid-go2: Remove incorrect re-defined spi0 alias
      rockchip: odroid-go2: Remove u-boot.dtsi props already defined
      rockchip: odroid-go2: Use appropriate bootph props
      rockchip: odroid-go2: Move SoC common overrides into a SoC u-boot.dtsi
      rockchip: odroid-go2: Remove unsupported Kconfig options
      rockchip: odroid-go2: Update Kconfig options for SPL
      rockchip: odroid-go2: Include pinctrl for sdmmc, sfc and uart in SPL
      rockchip: odroid-go2: Use power off at power plug-in event
      rockchip: odroid-go2: Add support for SPI flash boot
      rockchip: odroid-go2: Select board FDT from FIT in SPL
      rockchip: odroid-go2: Use env from same storage FIT was loaded from
      rockchip: odroid-go2: Enable RockUSB, button, LED and RNG support
      rockchip: odroid-go2: Turn on the blue LED at boot
      rockchip: odroid-go2: Enable more commands
      rockchip: odroid-go2: Add myself as a reviewer
      arm: dts: rockchip: Include OTP in U-Boot pre-reloc phase for RK3326
      rockchip: rk3528-radxa-e20c: Drop eMMC HS200 prop from board u-boot.dtsi
      rockchip: spl: Add a read_brom_bootsource_id() helper
      rockchip: rk3528: Implement read_brom_bootsource_id()
      rockchip: rk3576: Add SPI Flash boot support
      board: rockchip: Add Radxa ROCK 4D
      board: rockchip: Add Luckfox Omni3576
      board: rockchip: Add FriendlyElec NanoPi M5
      arm64: dts: rockchip: Add Radxa ROCK 2A/2F
      board: rockchip: Add Radxa ROCK 2A/2F
      arm64: dts: rockchip: Add ArmSoM Sige1
      board: rockchip: Add ArmSoM Sige1
      rockchip: spl-boot-order: Defer probe of boot device
      rockchip: Ensure env in SPI Flash can work correctly
      mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528

Peter Robinson (1):
      board: rockchip: Add support for rk3588 MNT Reform2

Quentin Schulz (6):
      rockchip: px30: use rockchip_stimer_init from spl_common.o for TPL
      rockchip: rk3036: use rockchip_stimer_init from spl_common.o
      rockchip: rk3399: fix TIMER_FMODE constant
      rockchip: spl_common: fix TIMER_FMODE constant
      binman: btool: mkimage: fix Bintoolmkimage.run() method docstring
      rockchip: imply most symbols for ARCH_ROCKCHIP

Tianling Shen (1):
      board: rockchip: add Lunzn FastRhino R66S

 arch/arm/Kconfig                                   |  26 +-
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi         | 111 ++---
 arch/arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi     |   3 +
 arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi         |   3 +
 arch/arm/dts/rk3326-u-boot.dtsi                    | 154 +++++++
 arch/arm/dts/rk3328-u-boot.dtsi                    |   4 +
 arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi       |  11 +
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi         |   5 +-
 arch/arm/dts/rk3528-rock-2-u-boot.dtsi             |  16 +
 arch/arm/dts/rk3528-rock-2a-u-boot.dtsi            |   3 +
 arch/arm/dts/rk3528-rock-2f-u-boot.dtsi            |   3 +
 arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi     |   3 +
 arch/arm/dts/rk356x-u-boot.dtsi                    |   1 +
 arch/arm/dts/rk3576-luckfox-omni3576-u-boot.dtsi   |  11 +
 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi          |  22 +
 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi            |  10 +
 arch/arm/dts/rk3576-u-boot.dtsi                    |  46 ++
 arch/arm/dts/rk3588s-u-boot.dtsi                   |   1 +
 arch/arm/include/asm/arch-rockchip/bootrom.h       |   2 +
 arch/arm/mach-rockchip/Makefile                    |   4 +-
 arch/arm/mach-rockchip/px30-board-tpl.c            |  28 +-
 arch/arm/mach-rockchip/rk3036-board-spl.c          |  21 +-
 arch/arm/mach-rockchip/rk3399/rk3399.c             |   4 +-
 arch/arm/mach-rockchip/rk3528/Kconfig              |   7 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS          |   6 +
 arch/arm/mach-rockchip/rk3528/rk3528.c             |  15 +
 arch/arm/mach-rockchip/rk3576/MAINTAINERS          |  18 +
 arch/arm/mach-rockchip/rk3576/rk3576.c             |  25 ++
 arch/arm/mach-rockchip/spl-boot-order.c            |   4 +-
 arch/arm/mach-rockchip/spl.c                       |   7 +-
 arch/arm/mach-rockchip/spl_common.c                |   4 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c         |   2 +-
 board/hardkernel/odroid_go2/Kconfig                |   7 +
 board/hardkernel/odroid_go2/MAINTAINERS            |   2 +
 board/hardkernel/odroid_go2/go2.c                  |  88 +++-
 board/radxa/rock-2-rk3528/Kconfig                  |  14 +
 board/radxa/rock-2-rk3528/MAINTAINERS              |   6 +
 board/radxa/rock-2-rk3528/Makefile                 |   3 +
 board/radxa/rock-2-rk3528/rock-2-rk3528.c          |  60 +++
 board/rockchip/evb_rk3568/MAINTAINERS              |   7 +
 board/rockchip/evb_rk3588/MAINTAINERS              |   5 +
 configs/fastrhino-r66s-rk3568_defconfig            |  64 +++
 configs/mnt-reform2-rk3588_defconfig               |  84 ++++
 configs/nanopi-m5-rk3576_defconfig                 |  78 ++++
 configs/odroid-go2_defconfig                       |  63 ++-
 configs/omni3576-rk3576_defconfig                  |  63 +++
 configs/radxa-e20c-rk3528_defconfig                |   3 +
 configs/rock-2-rk3528_defconfig                    |  68 +++
 configs/rock-4d-rk3576_defconfig                   |  68 +++
 configs/sige1-rk3528_defconfig                     |  64 +++
 doc/board/rockchip/rockchip.rst                    |   7 +
 drivers/clk/rockchip/clk_px30.c                    |   6 +
 drivers/mmc/rockchip_sdhci.c                       |  27 +-
 drivers/spi/rockchip_sfc.c                         |  13 +-
 .../src/arm64/rockchip/rk3528-armsom-sige1.dts     | 464 +++++++++++++++++++++
 dts/upstream/src/arm64/rockchip/rk3528-rock-2.dtsi | 293 +++++++++++++
 dts/upstream/src/arm64/rockchip/rk3528-rock-2a.dts |  82 ++++
 dts/upstream/src/arm64/rockchip/rk3528-rock-2f.dts |  10 +
 tools/binman/btool/mkimage.py                      |   1 -
 59 files changed, 2031 insertions(+), 199 deletions(-)
 create mode 100644 arch/arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3326-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-rock-2-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-rock-2a-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-rock-2f-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-luckfox-omni3576-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
 create mode 100644 board/radxa/rock-2-rk3528/Kconfig
 create mode 100644 board/radxa/rock-2-rk3528/MAINTAINERS
 create mode 100644 board/radxa/rock-2-rk3528/Makefile
 create mode 100644 board/radxa/rock-2-rk3528/rock-2-rk3528.c
 create mode 100644 configs/fastrhino-r66s-rk3568_defconfig
 create mode 100644 configs/mnt-reform2-rk3588_defconfig
 create mode 100644 configs/nanopi-m5-rk3576_defconfig
 create mode 100644 configs/omni3576-rk3576_defconfig
 create mode 100644 configs/rock-2-rk3528_defconfig
 create mode 100644 configs/rock-4d-rk3576_defconfig
 create mode 100644 configs/sige1-rk3528_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-rock-2.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-rock-2a.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-rock-2f.dts
