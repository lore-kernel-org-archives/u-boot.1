Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E44C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 09:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2C7886A7;
	Mon, 12 Aug 2024 11:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Sdugj1GE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FAEC88703; Mon, 12 Aug 2024 11:45:42 +0200 (CEST)
Received: from mail-m32122.qiye.163.com (mail-m32122.qiye.163.com
 [220.197.32.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CD4886A0
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Sdugj1GEeucIyvBwAGpJmo5588SEuCcbOi5bb8/AdAvxoVwu97xNGpnYu0r4hVi9/30kv0n03+/eQLg4fEVPcsJF0XPe+URvOoACKfDjF0vmmo3GkFEfbx6lKMB8BYUPp3tqbdTOe5vm/VZaME6Aq8RmO7J2KE6eUUsUebTB7Bs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=hHikVgBujzUCI+RvI9CEp+Lx2WHbcwsWq45s4GbZF3A=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A64F09006CC;
 Mon, 12 Aug 2024 17:45:30 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240812
Date: Mon, 12 Aug 2024 17:45:30 +0800
Message-Id: <20240812094530.39676-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpKSVZKGh1NHUlKGk8fQ0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9145fa81a003a9kunma64f09006cc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6ITo4QjI8H1EUCQkiKjRM
 IwwKCiFVSlVKTElIT05OQkhKQ0pKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKT0hPTzcG
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
- Add board support:
	RK3566: Radxa ROCK 3 Model C
		Radxa ZERO 3W/3E
		Xunlong Orange Pi 3B
	RK3568J: Radxa ROCK 3B
	RK3308B: Radxa ROCK S0
	RK3588: Radxa ROCK 5 ITX
		FriendlyElec CM3588 NAS board
- dw-mmc: allow 4-bit mode;
- dts and config updates;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/21997

Thanks,
- Kever

The following changes since commit 1c5445f190cabfd0e453f583aca44da10156c0d6:

  Merge patch series "Low Power Mode: Package TIFS Stub in BeaglePlay" (2024-08-08 18:37:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240812

for you to fetch changes up to 192318d3dcd42da47b9df532a9bda125ed120e4f:

  configs: rockchip: enable "ums" command for Radxa ROCK 5B (2024-08-12 15:44:04 +0800)

----------------------------------------------------------------
Alexey Charkov (1):
      arm64: dts: rockchip: add thermal zones information on RK3588

Dragan Simic (1):
      arm64: dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs

FUKAUMI Naoki (6):
      arm64: dts: rockchip: fix mmc aliases for Radxa ZERO 3E/3W
      arm: dts: rockchip: disable "usb_host0_ohci" to make boot faster for Radxa ROCK 3A
      arm64: dts: rockchip: change spi-max-frequency for Radxa ROCK 3C
      arm: dts: rockchip: remove upstreamed props for Radxa ROCK 3A
      arm: dts: rockchip: remove upstreamed props for Radxa ROCK 5B
      configs: rockchip: enable "ums" command for Radxa ROCK 5B

Heiko Stuebner (2):
      arm64: dts: rockchip: add ROCK 5 ITX board
      board: rockchip: Add Radxa ROCK 5 ITX

Jonas Karlman (26):
      mmc: rockchip_dw_mmc: Allow 4-bit mode when 8-bit mode is supported
      rockchip: io-domain: Add support for RK3308
      rockchip: rk3566-pinetab2: Migrate to OF_UPSTREAM
      rockchip: rk3588-toybrick-x0: Migrate to OF_UPSTREAM
      rockchip: px30/rk3326: Use soc dtsi files from dts/upstream
      rockchip: Use files from dts/upstream
      rockchip: rk3308: Remove OTP device node from soc u-boot dtsi
      arm64: dts: rockchip: Add OTP device node for RK3308
      arm64: dts: rockchip: Add rk3308 IO voltage domains
      arm64: dts: rockchip: Add sdmmc related properties on rk3308-rock-pi-s
      arm64: dts: rockchip: Add pinctrl for UART0 to rk3308-rock-pi-s
      arm64: dts: rockchip: Add mdio and ethernet-phy nodes to rk3308-rock-pi-s
      arm64: dts: rockchip: Add io-domains to rk3308-rock-pi-s
      arm64: dts: rockchip: Update WIFi/BT related nodes on rk3308-rock-pi-s
      rockchip: rk3308-rock-pi-s: Remove unnecessary u-boot dtsi overrides
      rockchip: rk3308-rock-pi-s: Enable LED and IO Domain driver
      arm64: dts: rockchip: Add Radxa ROCK S0
      board: rockchip: Add Radxa ROCK S0
      arm64: dts: rockchip: Add Radxa ROCK 3B
      board: rockchip: Add Radxa ROCK 3B
      arm64: dts: rockchip: Add Radxa ZERO 3W/3E
      dm: adc: Add SPL_ADC Kconfig symbol for use of ADC in SPL
      board: rockchip: Add Radxa ZERO 3W/3E
      arm64: dts: rockchip: Add Xunlong Orange Pi 3B
      board: rockchip: Add FriendlyElec CM3588 NAS
      rockchip: rk3568-nanopi-r5: Disable SPL_DM_WARN Kconfig option

Kever Yang (1):
      rockchip: dts: rk3568: Sync the evb board name with kernel

Maxim Moskalets (1):
      board: rockchip: add Radxa ROCK 3 Model C

Quentin Schulz (1):
      rockchip: configs: puma-rk3399: disable VIDEO support that breaks Linux

Ricardo Pardini (1):
      board: rockchip: Add Xunlong Orange Pi 3B

Sebastian Kropatsch (2):
      phy: rockchip: naneng-combphy: Introduce PHY-IDs to fix RK3588 muxing
      arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board

Trevor Woerner (1):
      arm64: dts: rockchip: add gpio-line-names to radxa-zero-3

 arch/arm/dts/px30-firefly.dts                      |    4 +
 arch/arm/dts/px30-u-boot.dtsi                      |    4 +
 arch/arm/dts/px30.dtsi                             | 2415 -----------------
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi          |   19 -
 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi            |   21 +
 arch/arm/dts/rk3308-u-boot.dtsi                    |   16 -
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi         |    4 +
 arch/arm/dts/rk3326.dtsi                           |   15 -
 arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi        |   14 +
 arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi   |    3 +
 arch/arm/dts/rk3566-orangepi-3b-v1.1.dts           |    3 +
 arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi   |    3 +
 arch/arm/dts/rk3566-orangepi-3b-v2.1.dts           |    3 +
 arch/arm/dts/rk3566-orangepi-3b.dts                |    5 +
 arch/arm/dts/rk3566-pinetab2-v0.1.dts              |   28 -
 arch/arm/dts/rk3566-pinetab2-v2.0.dts              |   48 -
 arch/arm/dts/rk3566-pinetab2.dtsi                  |  943 -------
 arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi      |   15 +
 arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi      |   15 +
 arch/arm/dts/rk3566-rock-3c-u-boot.dtsi            |   18 +
 ...evb-u-boot.dtsi => rk3568-evb1-v10-u-boot.dtsi} |    0
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi            |   13 +-
 arch/arm/dts/rk3568-rock-3b-u-boot.dtsi            |   15 +
 .../dts/rk3588-friendlyelec-cm3588-nas-u-boot.dtsi |    8 +
 arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi         |   22 +
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi            |   17 -
 arch/arm/dts/rockchip-pinconf.dtsi                 |  344 ---
 arch/arm/mach-rockchip/rk3308/syscon_rk3308.c      |    3 +
 arch/arm/mach-rockchip/rk3568/Kconfig              |   12 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |   53 +
 board/friendlyelec/cm3588-nas-rk3588/Kconfig       |   12 +
 board/friendlyelec/cm3588-nas-rk3588/MAINTAINERS   |    6 +
 board/radxa/rock-5-itx-rk3588/Kconfig              |   12 +
 board/radxa/rock-5-itx-rk3588/MAINTAINERS          |    8 +
 board/radxa/zero3-rk3566/Kconfig                   |   12 +
 board/radxa/zero3-rk3566/MAINTAINERS               |    6 +
 board/radxa/zero3-rk3566/Makefile                  |    3 +
 board/radxa/zero3-rk3566/zero3-rk3566.c            |   59 +
 board/rockchip/evb_rk3308/MAINTAINERS              |    6 +
 board/rockchip/evb_rk3568/MAINTAINERS              |   13 +
 board/xunlong/orangepi-3b-rk3566/Kconfig           |   12 +
 board/xunlong/orangepi-3b-rk3566/MAINTAINERS       |    6 +
 board/xunlong/orangepi-3b-rk3566/Makefile          |    3 +
 .../orangepi-3b-rk3566/orangepi-3b-rk3566.c        |   77 +
 configs/cm3588-nas-rk3588_defconfig                |   90 +
 configs/nanopi-r5c-rk3568_defconfig                |    1 -
 configs/nanopi-r5s-rk3568_defconfig                |    1 -
 configs/orangepi-3b-rk3566_defconfig               |   98 +
 configs/pinetab2-rk3566_defconfig                  |    5 +-
 configs/puma-rk3399_defconfig                      |   10 +-
 configs/radxa-zero-3-rk3566_defconfig              |   85 +
 configs/rock-3b-rk3568_defconfig                   |  100 +
 configs/rock-3c-rk3566_defconfig                   |   97 +
 configs/rock-5-itx-rk3588_defconfig                |  111 +
 configs/rock-pi-s-rk3308_defconfig                 |    4 +
 configs/rock-s0-rk3308_defconfig                   |   72 +
 configs/rock5b-rk3588_defconfig                    |    1 +
 configs/toybrick-rk3588_defconfig                  |    3 +-
 doc/board/rockchip/rockchip.rst                    |    9 +-
 drivers/Makefile                                   |    2 +-
 drivers/adc/Kconfig                                |    5 +
 drivers/adc/Makefile                               |    2 +-
 drivers/misc/rockchip-io-domain.c                  |   37 +
 drivers/mmc/rockchip_dw_mmc.c                      |    4 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |   46 +-
 .../src/arm64/rockchip/rk3308-rock-pi-s.dts        |   81 +-
 dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts |  293 ++
 dts/upstream/src/arm64/rockchip/rk3308.dtsi        |   29 +
 .../src/arm64/rockchip/rk3566-orangepi-3b-v1.1.dts |   29 +
 .../src/arm64/rockchip/rk3566-orangepi-3b-v2.1.dts |   70 +
 .../src/arm64/rockchip/rk3566-orangepi-3b.dtsi     |  678 +++++
 .../src/arm64/rockchip/rk3566-radxa-zero-3.dtsi    |  531 ++++
 .../src/arm64/rockchip/rk3566-radxa-zero-3e.dts    |   52 +
 .../src/arm64/rockchip/rk3566-radxa-zero-3w.dts    |   92 +
 dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts |    2 +-
 dts/upstream/src/arm64/rockchip/rk3568-rock-3b.dts |  781 ++++++
 ...3588s-pinctrl.dtsi => rk3588-base-pinctrl.dtsi} |    0
 dts/upstream/src/arm64/rockchip/rk3588-base.dtsi   | 2823 ++++++++++++++++++++
 ...3588-pinctrl.dtsi => rk3588-extra-pinctrl.dtsi} |    0
 dts/upstream/src/arm64/rockchip/rk3588-extra.dtsi  |  413 +++
 .../rockchip/rk3588-friendlyelec-cm3588-nas.dts    |  778 ++++++
 .../arm64/rockchip/rk3588-friendlyelec-cm3588.dtsi |  455 ++--
 .../src/arm64/rockchip/rk3588-rock-5-itx.dts       | 1177 ++++++++
 dts/upstream/src/arm64/rockchip/rk3588.dtsi        |  412 +--
 dts/upstream/src/arm64/rockchip/rk3588j.dtsi       |    2 +-
 dts/upstream/src/arm64/rockchip/rk3588s.dtsi       | 2669 +-----------------
 include/configs/rock-5-itx-rk3588.h                |   15 +
 include/dt-bindings/clock/px30-cru.h               |  389 ---
 include/dt-bindings/clock/rockchip,rk808.h         |   11 -
 include/dt-bindings/power/px30-power.h             |   27 -
 include/dt-bindings/soc/rockchip,boot-mode.h       |   16 -
 include/dt-bindings/soc/rockchip,vop2.h            |   18 -
 92 files changed, 9278 insertions(+), 7666 deletions(-)
 delete mode 100644 arch/arm/dts/px30.dtsi
 create mode 100644 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3326.dtsi
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b.dts
 delete mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1.dts
 delete mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0.dts
 delete mode 100644 arch/arm/dts/rk3566-pinetab2.dtsi
 create mode 100644 arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
 rename arch/arm/dts/{rk3568-evb-u-boot.dtsi => rk3568-evb1-v10-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/rk3568-rock-3b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-friendlyelec-cm3588-nas-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rockchip-pinconf.dtsi
 create mode 100644 board/friendlyelec/cm3588-nas-rk3588/Kconfig
 create mode 100644 board/friendlyelec/cm3588-nas-rk3588/MAINTAINERS
 create mode 100644 board/radxa/rock-5-itx-rk3588/Kconfig
 create mode 100644 board/radxa/rock-5-itx-rk3588/MAINTAINERS
 create mode 100644 board/radxa/zero3-rk3566/Kconfig
 create mode 100644 board/radxa/zero3-rk3566/MAINTAINERS
 create mode 100644 board/radxa/zero3-rk3566/Makefile
 create mode 100644 board/radxa/zero3-rk3566/zero3-rk3566.c
 create mode 100644 board/xunlong/orangepi-3b-rk3566/Kconfig
 create mode 100644 board/xunlong/orangepi-3b-rk3566/MAINTAINERS
 create mode 100644 board/xunlong/orangepi-3b-rk3566/Makefile
 create mode 100644 board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c
 create mode 100644 configs/cm3588-nas-rk3588_defconfig
 create mode 100644 configs/orangepi-3b-rk3566_defconfig
 create mode 100644 configs/radxa-zero-3-rk3566_defconfig
 create mode 100644 configs/rock-3b-rk3568_defconfig
 create mode 100644 configs/rock-3c-rk3566_defconfig
 create mode 100644 configs/rock-5-itx-rk3588_defconfig
 create mode 100644 configs/rock-s0-rk3308_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-orangepi-3b-v1.1.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-orangepi-3b-v2.1.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-orangepi-3b.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3568-rock-3b.dts
 rename dts/upstream/src/arm64/rockchip/{rk3588s-pinctrl.dtsi => rk3588-base-pinctrl.dtsi} (100%)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
 rename dts/upstream/src/arm64/rockchip/{rk3588-pinctrl.dtsi => rk3588-extra-pinctrl.dtsi} (100%)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-extra.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-friendlyelec-cm3588-nas.dts
 rename arch/arm/dts/rk3588-toybrick-x0.dts => dts/upstream/src/arm64/rockchip/rk3588-friendlyelec-cm3588.dtsi (66%)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-rock-5-itx.dts
 create mode 100644 include/configs/rock-5-itx-rk3588.h
 delete mode 100644 include/dt-bindings/clock/px30-cru.h
 delete mode 100644 include/dt-bindings/clock/rockchip,rk808.h
 delete mode 100644 include/dt-bindings/power/px30-power.h
 delete mode 100644 include/dt-bindings/soc/rockchip,boot-mode.h
 delete mode 100644 include/dt-bindings/soc/rockchip,vop2.h
