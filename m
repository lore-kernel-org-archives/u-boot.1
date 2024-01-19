Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA07C47DB7
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 08:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED32F87730;
	Fri, 19 Jan 2024 09:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fcO1GMiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA148774E; Fri, 19 Jan 2024 09:20:34 +0100 (CET)
Received: from mail-m6014.netease.com (mail-m6014.netease.com [210.79.60.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53358718F
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 09:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fcO1GMiRbmUOFE83xySuhHVyOJh3QRzGZU+/g2R78waxkoI5mXKEKX33fd96A5JXnUS4Zs23RfnX8/2L1yAFju1dVaOhgJ3VzNGbmKIvjuQMukJHZw9ZnVUGdFxzSjO8b9SfUP/iW1iRCwd21RwZdEpN8o+MeObA6uZgLR3mqGI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=bEVwo5vzIOf/1ZETaYn8B4HHzUiV04/o1bqPf57sARY=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [103.29.142.67])
 by mail-m12758.qiye.163.com (Hmail) with ESMTPA id 1AAA7AE2EE2;
 Fri, 19 Jan 2024 16:20:26 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240119
Date: Fri, 19 Jan 2024 16:20:23 +0800
Message-Id: <20240119082023.552165-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE4eVhgdHRofGU0YGBpKTVUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8d20ce95ecb225kuuu1aaa7ae2ee2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhg6DRw4AzwvTRUiHSItSA04
 IjUwCx5VSlVKTEtOTU5JT0lNQ0JJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUJDSEM3Bg++
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
- Add board: rk3328 FriendlyARM NanoPi R2C Plus, rk3588 Turing RK1 SoM;
- Enable SPI boot for rk3588 and rk3528;
- Set boot device in SPL as common code;
- other misc fixes;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/19374

Thanks,
- Kever

The following changes since commit f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3:

  Revert "test: hush: dollar: fix bugous behavior" (2024-01-18 11:38:25 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240119

for you to fetch changes up to c16c7ac2fe69f3cebbfc921c5b023dccc12cd198:

  rockchip: rk3128: remove noop file (2024-01-19 10:57:36 +0800)

----------------------------------------------------------------
Chris Morgan (4):
      board: rockchip: Refactor panel auto-detect code
      rockchip: board: Add board_rng_seed() for all Rockchip devices
      board: rockchip: Add support for new boards to RGxx3
      doc: board: anbernic: Update rgxx3 to add new boards

Hugh Cole-Baker (1):
      rockchip: rk35xx: expand space for decompressed kernel

Johan Jonker (1):
      arm: dts: rockchip: rk3288: move to 64 bit reg size

John Clark (1):
      rockchip: rk3588-nanopc-t6: Build SPI image

Jonas Karlman (5):
      configs: rockchip: Use dwc3-generic driver on RK3328 and RK3399
      rockchip: board: Remove dwc3 usb init and gadget handler functions
      rockchip: rk3588: Fix boot from SPI flash
      rockchip: rk3588s-orangepi-5: Build SPI image
      rockchip: rk3328: Set efuse auto mode and timing control

Joshua Riek (1):
      board: rockchip: Add the Turing RK1 SoM

Quentin Schulz (12):
      rockchip: ringneck-px30: do not hardcode MMC controller paths
      rockchip: puma-rk3399: do not hardcode MMC controller paths
      rockchip: ringneck-px30/puma-rk3399: factor out storage medium selection
      env: allow to copy value from default environment into a buffer
      env: migrate env_get_default to call env_get_default_into
      rockchip: theobroma-systems: fix modified boot_targets detection
      rockchip: rk3399: simplify logic for getting SPL boot medium DT node
      rockchip: px30: simplify logic for getting SPL boot medium DT node
      rockchip: factor out spl_perform_fixups into common spl-boot-order
      rockchip: find U-boot proper boot device by inverting the logic that sets it
      rockchip: remove unused global data ptr
      rockchip: rk3128: remove noop file

Slawomir Stepien (1):
      rockchip: rk3588-orangepi-5-plus: Build SPI image

Tianling Shen (1):
      board: rockchip: Add support for FriendlyARM NanoPi R2C Plus

 arch/arm/Kconfig                                   |   1 +
 arch/arm/dts/Makefile                              |   2 +
 arch/arm/dts/rk3288-evb.dtsi                       |   2 +-
 arch/arm/dts/rk3288-firefly.dtsi                   |   2 +-
 arch/arm/dts/rk3288-miqi.dtsi                      |   2 +-
 arch/arm/dts/rk3288-phycore-som.dtsi               |   2 +-
 arch/arm/dts/rk3288-popmetal.dtsi                  |   2 +-
 arch/arm/dts/rk3288-rock2-som.dtsi                 |   2 +-
 arch/arm/dts/rk3288-tinker.dtsi                    |   2 +-
 arch/arm/dts/rk3288-u-boot.dtsi                    |  14 +-
 arch/arm/dts/rk3288-veyron.dtsi                    |   2 +-
 arch/arm/dts/rk3288.dtsi                           | 259 +++++----
 arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi    |   9 +
 arch/arm/dts/rk3328-nanopi-r2c-plus.dts            |  33 ++
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi         |  25 +
 arch/arm/dts/rk3588-turing-rk1.dts                 |  21 +
 arch/arm/dts/rk3588-turing-rk1.dtsi                | 614 +++++++++++++++++++++
 arch/arm/include/asm/arch-rockchip/bootrom.h       |   1 -
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 arch/arm/mach-rockchip/board.c                     |  65 +--
 arch/arm/mach-rockchip/px30/px30.c                 |  49 --
 arch/arm/mach-rockchip/rk3128/Makefile             |   1 -
 arch/arm/mach-rockchip/rk3128/rk3128.c             |  16 -
 arch/arm/mach-rockchip/rk3308/rk3308.c             |   3 -
 arch/arm/mach-rockchip/rk3328/rk3328.c             |  41 +-
 arch/arm/mach-rockchip/rk3368/rk3368.c             |   3 -
 arch/arm/mach-rockchip/rk3399/rk3399.c             |  51 --
 arch/arm/mach-rockchip/rk3588/Kconfig              |  24 +
 arch/arm/mach-rockchip/rk3588/rk3588.c             |  18 +-
 arch/arm/mach-rockchip/spl-boot-order.c            | 111 ++++
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c         | 188 ++++---
 board/rockchip/evb_rk3328/MAINTAINERS              |   6 +
 board/theobroma-systems/common/common.c            | 151 +++++
 board/theobroma-systems/common/common.h            |  19 +
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   1 +
 board/theobroma-systems/puma_rk3399/Makefile       |   3 +
 board/theobroma-systems/puma_rk3399/puma-rk3399.c  | 143 +----
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   1 +
 board/theobroma-systems/ringneck_px30/Makefile     |   3 +
 .../ringneck_px30/ringneck-px30.c                  | 142 +----
 board/turing/turing-rk1-rk3588/Kconfig             |  15 +
 board/turing/turing-rk1-rk3588/MAINTAINERS         |   9 +
 board/turing/turing-rk1-rk3588/Makefile            |   6 +
 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c |  39 ++
 configs/chromebook_bob_defconfig                   |   2 +-
 configs/chromebook_kevin_defconfig                 |   2 +-
 configs/eaidk-610-rk3399_defconfig                 |   4 +-
 configs/evb-rk3399_defconfig                       |   1 -
 configs/firefly-rk3399_defconfig                   |   1 -
 configs/khadas-edge-captain-rk3399_defconfig       |   4 +-
 configs/khadas-edge-rk3399_defconfig               |   4 +-
 configs/khadas-edge-v-rk3399_defconfig             |   4 +-
 configs/leez-rk3399_defconfig                      |   4 +-
 configs/nanopc-t4-rk3399_defconfig                 |   3 +-
 configs/nanopc-t6-rk3588_defconfig                 |   2 +-
 configs/nanopi-m4-2gb-rk3399_defconfig             |   4 +-
 configs/nanopi-m4-rk3399_defconfig                 |   4 +-
 configs/nanopi-m4b-rk3399_defconfig                |   4 +-
 configs/nanopi-neo4-rk3399_defconfig               |   4 +-
 configs/nanopi-r2c-plus-rk3328_defconfig           | 114 ++++
 configs/nanopi-r4s-rk3399_defconfig                |   3 +-
 configs/orangepi-5-plus-rk3588_defconfig           |   2 +-
 configs/orangepi-5-rk3588s_defconfig               |   2 +-
 configs/orangepi-r1-plus-lts-rk3328_defconfig      |   3 +-
 configs/orangepi-r1-plus-rk3328_defconfig          |   3 +-
 configs/orangepi-rk3399_defconfig                  |   4 +-
 configs/pinebook-pro-rk3399_defconfig              |   1 -
 configs/pinephone-pro-rk3399_defconfig             |   1 -
 configs/puma-rk3399_defconfig                      |   1 -
 configs/roc-pc-mezzanine-rk3399_defconfig          |   1 -
 configs/roc-pc-rk3399_defconfig                    |   1 -
 configs/rock-4c-plus-rk3399_defconfig              |   1 -
 configs/rock-4se-rk3399_defconfig                  |   1 -
 configs/rock-pi-4-rk3399_defconfig                 |   1 -
 configs/rock-pi-4c-rk3399_defconfig                |   1 -
 configs/rock-pi-n10-rk3399pro_defconfig            |   1 -
 configs/rock5a-rk3588s_defconfig                   |   1 -
 configs/rock5b-rk3588_defconfig                    |   1 -
 configs/rock960-rk3399_defconfig                   |   3 +-
 configs/rockpro64-rk3399_defconfig                 |   1 -
 configs/turing-rk1-rk3588_defconfig                | 133 +++++
 doc/board/anbernic/rgxx3.rst                       |  20 +-
 doc/board/rockchip/rockchip.rst                    |   1 +
 drivers/usb/host/Kconfig                           |   1 -
 env/common.c                                       |  16 +-
 include/configs/rk3568_common.h                    |  12 +-
 include/configs/rk3588_common.h                    |  12 +-
 include/configs/turing-rk1-rk3588.h                |  15 +
 include/env.h                                      |  10 +
 89 files changed, 1815 insertions(+), 703 deletions(-)
 create mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus.dts
 create mode 100644 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-turing-rk1.dts
 create mode 100644 arch/arm/dts/rk3588-turing-rk1.dtsi
 delete mode 100644 arch/arm/mach-rockchip/rk3128/rk3128.c
 create mode 100644 board/theobroma-systems/common/common.c
 create mode 100644 board/theobroma-systems/common/common.h
 create mode 100644 board/turing/turing-rk1-rk3588/Kconfig
 create mode 100644 board/turing/turing-rk1-rk3588/MAINTAINERS
 create mode 100644 board/turing/turing-rk1-rk3588/Makefile
 create mode 100644 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c
 create mode 100644 configs/nanopi-r2c-plus-rk3328_defconfig
 create mode 100644 configs/turing-rk1-rk3588_defconfig
 create mode 100644 include/configs/turing-rk1-rk3588.h
