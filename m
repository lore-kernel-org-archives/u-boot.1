Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00513CA0FFE
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 01:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F78D83542;
	Sun, 31 Aug 2025 03:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iZrQ/S5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50676836AB; Sun, 31 Aug 2025 03:11:25 +0200 (CEST)
Received: from mail-m8172.xmail.ntesmail.com (mail-m8172.xmail.ntesmail.com
 [156.224.81.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB24F83487
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 03:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 21283d7a7;
 Sun, 31 Aug 2025 09:11:15 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20250831
Date: Sun, 31 Aug 2025 09:11:15 +0800
Message-Id: <20250831011115.463678-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98fdadb23403afkunm136290244c58ff
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0hKVkJDTx4fSEtCThlLGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=iZrQ/S5pBH+nGZD24+w0gyN80w1OVPSVzgGgBpBp5QvBEiTEnMlXCH8RlXH4XOoopoqY90QhTuGt7+4hSuCBoFZqzcKJWU9JFiTVz2bI9rsQCGkkha0yoLenCtT4wwdl7rOpccg25BwsxMooVsrM2Ro02oof5bbDmzbVvF6bpyI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=v6tN+oBivrgGsryHXrtyeMYMGQ7PNGgtJ6utesm1Gsc=;
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
- New Board support: 
  rk3588 Xunlong Orange Pi 5 Ultra;
  rk3588s GameForce Ace;
  rk3576 ArmSoM Sige5;

- rk3328 soc fixes;
- usb controller and phy fixes;
- new rk3328 ddr timing;
- other board level updates;


CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/27522

Thanks,
- Kever

The following changes since commit e4c8b32d03d7ecffd586b7d33336603ad639d7c0:

  Merge branch 'master' of git://source.denx.de/u-boot-usb (2025-08-29 14:58:45 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250831

for you to fetch changes up to 0e68a93d7c220e37cf6ffe88ba47373e39fe5001:

  rockchip: rk3588-generic: Move usb nodes to board dts (2025-08-31 00:48:15 +0800)

----------------------------------------------------------------
Alex Shumsky (1):
      rockchip: rockchip-inno-usb2: Fix Synchronous Abort on usb start

Andrew Goodbody (1):
      mmc: rockchip_sdhci: Do not test unsigned for being less than 0

Chris Morgan (1):
      rockchip: Add support for GameForce Ace

Da Xue (2):
      ram: rk3328: add ddr4-1600 sdram timing
      arm64: dts: rockchip: roc-3328-cc: use 1600 ddr4 timing

Diederik de Haas (1):
      rockchip: rk3568-nanopi-r5s: Enable ROCKUSB on NanoPi R5S

Frank Wang (2):
      phy: rockchip-inno-usb2: Add support for RK3576
      phy: rockchip: usbdp: Add support for RK3576

Jakob Unterwurzacher (1):
      board: rockchip: unblock CAN bus in spl_board_init on Jaguar

Jianwei Zheng (1):
      phy: rockchip: naneng-combphy: Add support for RK3528

Jon Lin (1):
      phy: rockchip: naneng-combphy: Add support for RK3576

Jonas Karlman (25):
      rng: rockchip_rng: Add compatible for RK3576
      rockchip: Add default USB_GADGET_PRODUCT_NUM for RK3576
      board: rockchip: Add minimal generic RK3576 board
      rockchip: rk3576: Implement checkboard() to print SoC variant
      arm: dts: rockchip: Include OTP in U-Boot pre-reloc phase for RK3576
      usb: dwc3-generic: Use combined glue and ctrl node for RK3576
      rockchip: clk: clk_rk3576: Add dummy CLK_REF_PCIEx_PHY support
      board: rockchip: Add ArmSoM Sige5
      rockchip: rk3528-generic: Fix boot after dts/upstream v6.16-dts merge
      arm: dts: rockchip: Use sdmmc node from dts/upstream on RK3528
      arm: dts: rockchip: Set init-microvolt for pwm-regulators on Radxa E20C
      rockchip: rk3528: Disable USB3OTG U3 port early
      rockchip: clk: clk_rk3528: Add dummy CLK_REF_PCIE_INNER_PHY support
      usb: dwc3-generic: Use combined glue and ctrl node for RK3528
      rockchip: rk3528-radxa-e20c: Enable USB gadget Kconfig options
      phy: rockchip: usbdp: Fix Generic PHY reference counting
      phy: rockchip: usbdp: Simplify init ops
      phy: rockchip: naneng-combphy: Fix Generic PHY reference counting
      phy: rockchip: naneng-combphy: Simplify init ops
      phy: rockchip: naneng-combphy: Use syscon_regmap_lookup_by_phandle
      phy: rockchip: inno-usb2: Fix improper use of UCLASS_PHY
      phy: rockchip: typec: Fix improper use of UCLASS_PHY
      rockchip: rk3588: Disable USB3OTG U3 ports early
      rockchip: rk3576: Disable USB3OTG0 U3 port early
      rockchip: rk3588-generic: Move usb nodes to board dts

Marius Dinu (1):
      rk3288: add fdtoverlay_addr_r to default env

Niu Zhihong (1):
      board: rockchip: Add Xunlong Orange Pi 5 Ultra

Quentin Schulz (10):
      rockchip: px30/rk3326: Implement checkboard() to print SoC variant
      rockchip: tiger-rk3588: enable "env erase" command
      rockchip: jaguar-rk3588: enable "env erase" command
      rockchip: ringneck-px30: enable "env erase" command
      rockchip: puma-rk3399: enable "env erase" command
      dt-bindings: mfd: rk806: Allow to customize PMIC reset mode
      arm64: dts: rockchip: add header for RK8XX PMIC constants
      arm64: dts: rockchip: force PMIC reset behavior to restart PMU on RK3588 Jaguar
      arm64: dts: rockchip: force PMIC reset behavior to restart PMU on RK3588 Tiger
      power: rk8xx: allow to customize RK806 reset mode

Tom Rini (2):
      usb: gadget: rockchip: Add missing dependency
      usb: gadget: rockchip: Fix spacing around the Kconfig option

 arch/arm/dts/px30-u-boot.dtsi                      |   4 +
 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi             |   2 +-
 arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi           | 226 +++++++++++++
 arch/arm/dts/rk3528-generic-u-boot.dtsi            |   9 -
 arch/arm/dts/rk3528-generic.dts                    |  17 +-
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi         |  13 +-
 arch/arm/dts/rk3528-u-boot.dtsi                    |  18 -
 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi       |  18 +
 arch/arm/dts/rk3576-generic-u-boot.dtsi            |   3 +
 arch/arm/dts/rk3576-generic.dts                    |  63 ++++
 arch/arm/dts/rk3576-u-boot.dtsi                    |   4 +
 arch/arm/dts/rk3588-generic-u-boot.dtsi            |  18 -
 arch/arm/dts/rk3588-generic.dts                    |  16 +
 arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi   |  20 ++
 arch/arm/mach-rockchip/px30/px30.c                 |  61 ++++
 arch/arm/mach-rockchip/rk3528/rk3528.c             |   6 +
 arch/arm/mach-rockchip/rk3576/MAINTAINERS          |  11 +
 arch/arm/mach-rockchip/rk3576/rk3576.c             |  54 +++
 arch/arm/mach-rockchip/rk3588/Kconfig              |  18 +
 arch/arm/mach-rockchip/rk3588/rk3588.c             |   8 +
 board/gameforce/ace-rk3588s/Kconfig                |   9 +
 board/gameforce/ace-rk3588s/MAINTAINERS            |   5 +
 board/rockchip/evb_rk3588/MAINTAINERS              |   6 +
 .../jaguar_rk3588/jaguar_rk3588.c                  |  19 ++
 board/xunlong/orangepi-5-ultra-rk3588/Kconfig      |  12 +
 board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS  |   6 +
 configs/gameforce-ace-rk3588s_defconfig            |  67 ++++
 configs/generic-rk3576_defconfig                   |  50 +++
 configs/generic-rk3588_defconfig                   |   1 -
 configs/jaguar-rk3588_defconfig                    |   2 +
 configs/nanopi-r5s-rk3568_defconfig                |   7 +
 configs/orangepi-5-ultra-rk3588_defconfig          |  88 +++++
 configs/puma-rk3399_defconfig                      |   1 +
 configs/radxa-e20c-rk3528_defconfig                |  10 +
 configs/ringneck-px30_defconfig                    |   1 +
 configs/sige5-rk3576_defconfig                     |  66 ++++
 configs/tiger-rk3588_defconfig                     |   1 +
 doc/board/rockchip/rockchip.rst                    |   4 +
 drivers/clk/rockchip/clk_rk3528.c                  |   1 +
 drivers/clk/rockchip/clk_rk3576.c                  |   2 +
 drivers/mmc/rockchip_sdhci.c                       |   2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |  47 ++-
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 368 +++++++++++++++------
 drivers/phy/rockchip/phy-rockchip-typec.c          |   2 +-
 drivers/phy/rockchip/phy-rockchip-usbdp.c          | 101 +++---
 drivers/power/pmic/rk8xx.c                         |  21 +-
 drivers/rng/rockchip_rng.c                         |   4 +
 drivers/usb/dwc3/dwc3-generic.c                    |   2 +
 drivers/usb/gadget/Kconfig                         |  14 +-
 dts/upstream/Bindings/mfd/rockchip,rk806.yaml      |  21 ++
 dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts  |   2 +
 dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi  |   2 +
 dts/upstream/src/arm64/rockchip/rk8xx.h            |  18 +
 include/configs/rk3288_common.h                    |   3 +-
 include/power/rk8xx_pmic.h                         |   2 +
 55 files changed, 1322 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi
 create mode 100644 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-generic.dts
 create mode 100644 arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi
 create mode 100644 arch/arm/mach-rockchip/rk3576/MAINTAINERS
 create mode 100644 board/gameforce/ace-rk3588s/Kconfig
 create mode 100644 board/gameforce/ace-rk3588s/MAINTAINERS
 create mode 100644 board/xunlong/orangepi-5-ultra-rk3588/Kconfig
 create mode 100644 board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
 create mode 100644 configs/gameforce-ace-rk3588s_defconfig
 create mode 100644 configs/generic-rk3576_defconfig
 create mode 100644 configs/orangepi-5-ultra-rk3588_defconfig
 create mode 100644 configs/sige5-rk3576_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk8xx.h
