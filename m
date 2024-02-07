Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEDDC4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 08:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD2187BC3;
	Wed,  7 Feb 2024 09:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DvcFKRss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF5F87C7D; Wed,  7 Feb 2024 09:03:06 +0100 (CET)
Received: from mail-m17224.xmail.ntesmail.com (mail-m17224.xmail.ntesmail.com
 [45.195.17.224])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9626387BC1
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 09:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DvcFKRssintARNhIGlnKHTfLmOPwQvnZu6Gq/lt3vUTxVUYO81IioprBnp4EQm2wzgU7EWcQJk26Z2Tgsz/7BH12OY2O9yAf3+A5FXpuYFodKVV1dKLJau95UJ4O8TVltBZ8TfBzL7W+TkV+d7bzYcL4dnt2YZ+pYYIPurHrp+w=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=FUT7BKW7q67BF7DHAdQAgVej41UCsyP9TEJ1MG4KZiI=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 322779001B3;
 Wed,  7 Feb 2024 16:02:56 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240207
Date: Wed,  7 Feb 2024 16:02:55 +0800
Message-Id: <20240207080255.2154861-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJMSlYZSkpDTUJKTR4YGkJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d829764ae03a9kunm322779001b3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6Tio*SzMKLTAdMzQcSkkr
 M1YwCiFVSlVKTEtMSUJJQkxNTEpOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS09ITDcG
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
- Add board: rv1126 Sonoff iHost board
- rv1126 ddr4 support;
- Enable BOOTSTD_FULL for RK3399 and RK3588;
- rk3036 spl stack addr fix;
- dts sync from linux v6.8-rc1 for rk356x, rk3588, rv1126;
- Enable eMMC HS200 mode by default for rk3568 and rk3588;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/19556

Thanks,
- Kever

The following changes since commit 819abd0a1eaff9a921f5b917e152b85dab302e33:

  Merge tag 'smbios-2024-04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-02-03 09:11:25 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240207

for you to fetch changes up to b8f1f60c23c9b3edb70159c4e2b1be232a008ee3:

  arm: dts: rockpro64: Add RockPro64 smbios (2024-02-07 10:49:13 +0800)

----------------------------------------------------------------
Andy Yan (1):
      rockchip: rk3588-evb: Enable USB support

Jonas Karlman (15):
      net: designware: Reset eth phy before phy connect
      rockchip: rk3328-rock-pi-e: Enable DM_ETH_PHY and PHY_REALTEK
      rockchip: rk356x: Sync device tree from linux v6.7
      rockchip: rk356x: Sync device tree from linux v6.8-rc1
      rockchip: rk356x: Move common uart2 props to rk356x-u-boot.dtsi
      rockchip: rk3588: Sync device tree with linux v6.7
      rockchip: rk3588: Sync device tree from linux v6.8-rc1
      rockchip: rk3588: Add default u-boot,spl-boot-order prop
      rockchip: rk35xx: Remove unnecessary status props
      rockchip: rk3588: Enable eMMC HS200 mode
      rockchip: rk3588-quartzpro64: Enable AHCI, PCI and USB
      rockchip: rk35xx: Remove use of eMMC DDR52 mode
      rockchip: rk35xx: Enable eMMC HS200 mode by default
      mmc: rockchip_sdhci: Fix HS400 mode write on RK3568
      rockchip: rk3568-generic: Enable eMMC HS200 mode

Kever Yang (2):
      spl: Make SPL_STACK available for ROCKCHIP_RK3036 without spl framework
      configs: rockchip: rk3036: Fix CONFIG_SPL_STACK define

Shantur Rathore (2):
      arch: arm: mach-rockchip: Kconfig: Enable BOOTSTD_FULL for RK3399 and RK3588
      arm: dts: rockpro64: Add RockPro64 smbios

Tim Lunn (6):
      arm: dts: rockchip: Sync rv1126 dts from linux 6.8-rc1
      ram: rockchip: Add rv1126 ddr4 support
      rockchip: Convert rv1126 to standard boot
      board: rockchip: Add Sonoff iHost board
      rockchip: rv1126: select SPL_OPTEE_IMAGE
      rockchip: rv1126: Move RAM disk address

YouMin Chen (1):
      rockchip: sdram: fix LPDDR5 bank info for sys_reg version 3

 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi          |  22 ++
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi     |   7 -
 arch/arm/dts/rk3566-anbernic-rgxx3.dtsi            |  42 ++-
 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi         |  13 -
 arch/arm/dts/rk3566-quartz64-a.dts                 |   7 +-
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi         |  13 -
 arch/arm/dts/rk3566-quartz64-b.dts                 |   2 -
 arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi       |  13 -
 arch/arm/dts/rk3566-radxa-cm3-io.dts               |   5 +-
 arch/arm/dts/rk3566-soquartz-blade.dts             |   4 +
 arch/arm/dts/rk3566-soquartz-cm4.dts               |   4 +
 arch/arm/dts/rk3566-soquartz-model-a.dts           |   4 +
 arch/arm/dts/rk3566-soquartz-u-boot.dtsi           |  13 -
 arch/arm/dts/rk3566-soquartz.dtsi                  |   4 -
 arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi         |  13 -
 arch/arm/dts/rk3568-evb-u-boot.dtsi                |  17 -
 arch/arm/dts/rk3568-evb.dts                        |   3 -
 arch/arm/dts/rk3568-generic-u-boot.dtsi            |  11 -
 arch/arm/dts/rk3568-generic.dts                    |  12 +-
 arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi         |  13 -
 arch/arm/dts/rk3568-lubancat-2.dts                 |   3 -
 arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi         |  13 -
 arch/arm/dts/rk3568-nanopi-r5s.dtsi                |   3 -
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi          |  13 -
 arch/arm/dts/rk3568-odroid-m1.dts                  |   3 -
 arch/arm/dts/rk3568-radxa-cm3i.dtsi                |   3 -
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi          |  13 -
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi            |  13 -
 arch/arm/dts/rk3568-rock-3a.dts                    |   7 +-
 arch/arm/dts/rk356x-u-boot.dtsi                    |  12 +-
 arch/arm/dts/rk356x.dtsi                           |  20 +-
 arch/arm/dts/rk3588-edgeble-neu6a-io.dts           |   4 -
 arch/arm/dts/rk3588-edgeble-neu6b-io.dts           |   6 +-
 arch/arm/dts/rk3588-evb1-v10.dts                   |  99 ++++-
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi          |   6 -
 arch/arm/dts/rk3588-nanopc-t6.dts                  |  10 +-
 arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi    |   6 -
 arch/arm/dts/rk3588-orangepi-5-plus.dts            |   1 -
 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi        |   6 -
 arch/arm/dts/rk3588-quartzpro64.dts                |   2 +-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi            |  13 -
 arch/arm/dts/rk3588-rock-5b.dts                    |  13 +-
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi         |   8 -
 arch/arm/dts/rk3588-turing-rk1.dtsi                |   6 +-
 arch/arm/dts/rk3588-u-boot.dtsi                    |   2 +-
 arch/arm/dts/rk3588s-orangepi-5.dts                |   9 +-
 arch/arm/dts/rk3588s-pinctrl.dtsi                  |   2 +-
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi           |   7 -
 arch/arm/dts/rk3588s-rock-5a.dts                   |  10 +-
 arch/arm/dts/rk3588s-u-boot.dtsi                   |  49 +--
 arch/arm/dts/rk3588s.dtsi                          | 152 ++++++++
 arch/arm/dts/rv1126-edgeble-neu2-io.dts            |  70 ++++
 arch/arm/dts/rv1126-edgeble-neu2.dtsi              |  27 +-
 arch/arm/dts/rv1126-pinctrl.dtsi                   | 130 +++++++
 arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi       |  13 +
 arch/arm/dts/rv1126-sonoff-ihost.dts               |  29 ++
 arch/arm/dts/rv1126-sonoff-ihost.dtsi              | 404 +++++++++++++++++++++
 arch/arm/dts/rv1126.dtsi                           | 185 ++++++++++
 arch/arm/mach-rockchip/Kconfig                     |   7 +
 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c      |   2 +-
 arch/arm/mach-rockchip/rv1126/Kconfig              |   8 +
 arch/arm/mach-rockchip/sdram.c                     |   9 +-
 board/itead/sonoff-ihost/Kconfig                   |  16 +
 board/itead/sonoff-ihost/MAINTAINERS               |   6 +
 common/spl/Kconfig                                 |   3 +-
 configs/evb-rk3036_defconfig                       |   1 +
 configs/evb-rk3588_defconfig                       |  14 +
 configs/generic-rk3568_defconfig                   |   5 +-
 configs/kylin-rk3036_defconfig                     |   1 +
 configs/nanopc-t6-rk3588_defconfig                 |   2 +
 configs/nanopi-r5c-rk3568_defconfig                |   2 -
 configs/nanopi-r5s-rk3568_defconfig                |   2 -
 configs/neu6a-io-rk3588_defconfig                  |   2 +
 configs/neu6b-io-rk3588_defconfig                  |   2 +
 configs/orangepi-5-plus-rk3588_defconfig           |   2 +
 configs/quartzpro64-rk3588_defconfig               |  27 ++
 configs/radxa-e25-rk3568_defconfig                 |   2 -
 configs/rock-pi-e-rk3328_defconfig                 |   2 +
 configs/rock5a-rk3588s_defconfig                   |   2 +
 configs/rock5b-rk3588_defconfig                    |   2 +
 configs/rockpro64-rk3399_defconfig                 |   2 +
 configs/sonoff-ihost-rv1126_defconfig              |  60 +++
 configs/turing-rk1-rk3588_defconfig                |   2 +
 doc/board/rockchip/rockchip.rst                    |   1 +
 drivers/mmc/rockchip_sdhci.c                       |   9 +-
 drivers/net/designware.c                           |   7 +
 .../ram/rockchip/sdram-rv1126-ddr4-detect-1056.inc |  75 ++++
 .../ram/rockchip/sdram-rv1126-ddr4-detect-328.inc  |  75 ++++
 .../ram/rockchip/sdram-rv1126-ddr4-detect-396.inc  |  75 ++++
 .../ram/rockchip/sdram-rv1126-ddr4-detect-528.inc  |  75 ++++
 .../ram/rockchip/sdram-rv1126-ddr4-detect-664.inc  |  75 ++++
 .../ram/rockchip/sdram-rv1126-ddr4-detect-784.inc  |  75 ++++
 .../ram/rockchip/sdram-rv1126-ddr4-detect-924.inc  |  75 ++++
 drivers/ram/rockchip/sdram_rv1126.c                |   8 +
 include/configs/neural-compute-module-2.h          |   6 -
 include/configs/rv1126_common.h                    |   5 +-
 include/configs/sonoff-ihost.h                     |  10 +
 include/dt-bindings/clock/rk3568-cru.h             |   1 +
 include/dt-bindings/soc/rockchip,vop2.h            |   4 +
 100 files changed, 1984 insertions(+), 370 deletions(-)
 create mode 100644 arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dts
 create mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dtsi
 create mode 100644 board/itead/sonoff-ihost/Kconfig
 create mode 100644 board/itead/sonoff-ihost/MAINTAINERS
 create mode 100644 configs/sonoff-ihost-rv1126_defconfig
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-1056.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-328.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-396.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-528.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-664.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-784.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-924.inc
 create mode 100644 include/configs/sonoff-ihost.h
