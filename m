Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEA0D2E9D0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 09:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF6E89342;
	Mon, 11 Nov 2024 10:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Eww/jQRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685A689363; Mon, 11 Nov 2024 10:58:09 +0100 (CET)
Received: from mail-m17238.xmail.ntesmail.com (mail-m17238.xmail.ntesmail.com
 [45.195.17.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF638930E
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 10:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2675d5b9;
 Mon, 11 Nov 2024 17:58:00 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20241111
Date: Mon, 11 Nov 2024 17:58:00 +0800
Message-Id: <20241111095800.293704-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhMQ1YdH0JDSB4fGh9NQ0pWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a931aa8a65403afkunm2675d5b9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6CCo5UTIfKCIhGh8sCikz
 MjRPFAJVSlVKTEhKSEpCS0NKSE9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQk1JNwY+
DKIM-Signature: a=rsa-sha256;
 b=Eww/jQRZJwdnpz1rtcLKskxUtKCfNJSeJvTGmhpu9Kn0muH06jg4lTw3CeMJCrGie1a++JmK6FUjzhlds0Fo6Jay+ymOn16uu/W/8msydEFsiJB0ZqX11A8q5U62y5q9PglKGGzEtrHV4PUJ0visQ7c2sstwe1A2L76xIsTGjnM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=F2XqdHSBZhQsLO/PKzhbuXcwzP7TyZqbEMO9eoGo6JY=;
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
- Add board:
	rk3328: FriendlyElec NanoPi R2S Plus
	rk3568: Qnap TS433
	rk3588: Cool Pi CM5 GenBook
- Move rk3399_force_power_on_reset to TPL for puma board;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/23280

Thanks,
- Kever

The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd271:

  bios_emulator: fix first argument of pci_{read,write}_config_* function calls (2024-11-04 18:01:58 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20241111

for you to fetch changes up to 0a17123dedf827f4ca9b158252279adf03906307:

  rockchip: rk3399: move sysreset-gpio logic to TPL (2024-11-11 15:14:15 +0800)

----------------------------------------------------------------
Andy Yan (3):
      arm64: dts: rockchip: Add support for rk3588 based Cool Pi CM5 GenBook
      rockchip: Make it possible to define per board boot_targets
      board: rockchip: Add support for rk3588 GenBook

Heiko Stuebner (17):
      arm64: dts: rockchip: add PCIe supply regulator to Qnap-TS433
      arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
      arm64: dts: rockchip: enable uart0 on Qnap-TS433
      arm64: dts: rockchip: enable usb ports on Qnap-TS433
      arm64: dts: rockchip: add stdout path on Qnap-TS433
      arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
      arm64: dts: rockchip: add board-aliases for Qnap-TS433
      arm64: dts: rockchip: add hdd leds to Qnap-TS433
      arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
      arm64: dts: rockchip: add gpio-keys to Qnap-TS433
      arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
      arm64: dts: rockchip: add missing pmic information on Qnap-TS433
      arm64: dts: rockchip: enable gpu on Qnap-TS433
      arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433
      arm64: dts: rockchip: actually enable pmu-io-domains on qnap-ts433
      arm64: dts: rockchip: add product-data eeproms to QNAP TS433
      board: rockchip: add support for Qnap TS433 devices

Jonas Karlman (2):
      board: rockchip: Add FriendlyElec NanoPi R2S Plus
      rockchip: rk35xx-generic: Disable late boardinfo

Quentin Schulz (4):
      pinctrl: rockchip: allow to build for TPL
      rockchip: rk3399: merge CRU check within rk3399_force_power_on_reset
      rockchip: tpl: allow to call board/SoC-specific code before DRAM init
      rockchip: rk3399: move sysreset-gpio logic to TPL

Sergey Bostandzhyan (1):
      arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus

Uwe Kleine-König (1):
      arm64: dts: rockchip: Simplify network PHY connection on qnap-ts433

 arch/arm/dts/rk3328-nanopi-r2s-plus-u-boot.dtsi    |   3 +
 arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi         |   6 +
 arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi |  20 +
 arch/arm/mach-rockchip/rk3399/rk3399.c             |  56 +-
 arch/arm/mach-rockchip/rk3568/Kconfig              |  14 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |  19 +
 arch/arm/mach-rockchip/tpl.c                       |   6 +
 board/coolpi/genbook_cm5_rk3588/Kconfig            |  12 +
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS        |   7 +
 board/qnap/ts433/Kconfig                           |  12 +
 board/qnap/ts433/MAINTAINERS                       |   8 +
 board/rockchip/evb_rk3328/MAINTAINERS              |   6 +
 configs/coolpi-cm5-genbook-rk3588_defconfig        | 101 ++++
 configs/generic-rk3568_defconfig                   |   2 +-
 configs/generic-rk3588_defconfig                   |   2 +-
 configs/nanopi-r2s-plus-rk3328_defconfig           | 108 ++++
 configs/puma-rk3399_defconfig                      |   3 +
 configs/qnap-ts433-rk3568_defconfig                |  87 ++++
 doc/board/coolpi/genbook_cm5_rk3588.rst            |  68 +++
 doc/board/coolpi/index.rst                         |   9 +
 doc/board/index.rst                                |   2 +
 doc/board/qnap/index.rst                           |   9 +
 doc/board/qnap/ts433.rst                           |  91 ++++
 doc/board/rockchip/rockchip.rst                    |   3 +
 drivers/pinctrl/Kconfig                            |   8 +
 drivers/pinctrl/rockchip/Kconfig                   |   7 +
 .../src/arm64/rockchip/rk3328-nanopi-r2s-plus.dts  |  32 ++
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts       | 571 ++++++++++++++++++++-
 .../arm64/rockchip/rk3588-coolpi-cm5-genbook.dts   | 349 +++++++++++++
 include/configs/genbook-cm5-rk3588.h               |  19 +
 include/configs/qnap_ts433.h                       |  10 +
 include/configs/rockchip-common.h                  |   2 +
 32 files changed, 1618 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/dts/rk3328-nanopi-r2s-plus-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
 create mode 100644 board/coolpi/genbook_cm5_rk3588/Kconfig
 create mode 100644 board/coolpi/genbook_cm5_rk3588/MAINTAINERS
 create mode 100644 board/qnap/ts433/Kconfig
 create mode 100644 board/qnap/ts433/MAINTAINERS
 create mode 100644 configs/coolpi-cm5-genbook-rk3588_defconfig
 create mode 100644 configs/nanopi-r2s-plus-rk3328_defconfig
 create mode 100644 configs/qnap-ts433-rk3568_defconfig
 create mode 100644 doc/board/coolpi/genbook_cm5_rk3588.rst
 create mode 100644 doc/board/coolpi/index.rst
 create mode 100644 doc/board/qnap/index.rst
 create mode 100644 doc/board/qnap/ts433.rst
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3328-nanopi-r2s-plus.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
 create mode 100644 include/configs/genbook-cm5-rk3588.h
 create mode 100644 include/configs/qnap_ts433.h
