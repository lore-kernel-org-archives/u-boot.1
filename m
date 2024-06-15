Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A133C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 12:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A52A87ABC;
	Sat, 15 Jun 2024 14:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QQPHXneH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679FE87CF1; Sat, 15 Jun 2024 14:22:23 +0200 (CEST)
Received: from mail-m11867.qiye.163.com (mail-m11867.qiye.163.com
 [115.236.118.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808418796B
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 14:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QQPHXneHQo0XAgl/y0pnQ+NtiQ076o6T8n1Hc3vU2wNEE8QzsJGKoT7oiahlWwesH/nkeAMwWJhrZBpMZU5b0L5THBbJZX9Q0bN3I+cEEXn6+OsAc71Z/Q7IR4CglQfnK52od7Adh513IKzNE76Cx6M7Fj2Eyvt1zHxxYxITjf0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=w2vXTM/zJSmrQPrVnGkl03uDKxiPD03Pv1B6ywVEzC0=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [59.56.82.162])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A827C9002CD;
 Sat, 15 Jun 2024 20:22:13 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-next-20240615
Date: Sat, 15 Jun 2024 20:22:13 +0800
Message-Id: <20240615122213.2203637-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx1OVkMZSB9NQx5ITElKT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
 pCS0tZBg++
X-HM-Tid: 0a901bd923f203a9kunma827c9002cd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6IQw5HTNNPAkoPD4iOS4*
 VgkwCSFVSlVKTEpDT05PSkhPSU9IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQlVOTVVDSVVKTUlZV1kIAVlBQkpJSDcG
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

Please pull the updates for next on rockchip platform:
- New board: Theobroma Systems SOM-RK3588-Q7 Tiger, ArmSoM Sige7 Rk3588;
- PX30 dts migrate to OF_UPSTREAM;
- Some other update on board or config;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/21113

Thanks,
- Kever

The following changes since commit 3db3a6ba7b0cb09757fc631ccc9d4445eb101dc7:

  Merge patch series "Enable OSPI boot for j721s2" (2024-06-13 08:20:30 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-next-20240615

for you to fetch changes up to ae4aaa44977cbe522e9f38f2ac2ac07a784bf867:

  rockchip: puma-rk3399: get closer to other Theobroma defconfigs (2024-06-14 17:35:45 +0800)

----------------------------------------------------------------
Boris Brezillon (1):
      arm64: dts: rockchip: Add rk3588 GPU node

Diederik de Haas (1):
      arm64: dts: rockchip: Fix ordering of nodes on rk3588s

Heiko Stuebner (6):
      arm64: dts: rockchip: enable gpu on rk3588-tiger
      arm64: dts: rockchip: move uart2 pinmux to dtsi on rk3588-tiger
      arm64: dts: rockchip: fix pcie-refclk frequency on rk3588 tiger
      arm64: dts: rockchip: fix comment for upper usb3 port
      arm64: dts: rockchip: add usb-id extcon on rk3588 tiger
      arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou

Jianfeng Liu (3):
      arm64: dts: rockchip: Add ArmSom Sige7 board
      rockchip: rk3588: Remove USB3 DRD nodes in u-boot.dtsi
      board: rockchip: add ArmSoM Sige7 Rk3588 board

Jing Luo (1):
      arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boards

Niklas Cassel (1):
      arm64: dts: rockchip: add rk3588 pcie and php IOMMUs

Quentin Schulz (17):
      rockchip: evb-px30: Use common bss and stack addresses
      rockchip: firefly-px30: Use common bss and stack addresses
      rockchip: odroid-go2: Use common bss and stack addresses
      rockchip: px30-core-*: Use common bss and stack addresses
      rockchip: px30: make UART pinmux accessible to TPL/SPL DTB
      rockchip: evb-px30: do not remove pinctrl nodes from SPL DTB
      rockchip: evb-px30: make UART5 the debug UART
      rockchip: px30/rk3326: migrate to OF_UPSTREAM
      rockchip: jaguar-rk3588: use default env size for Rockchip on MMC
      rockchip: rk3399-puma: remove default value from defconfig
      rockchip: rk3399-puma: remove unnecessary simple-bin:fit:offset override
      rockchip: px30-ringneck: Update SPL_PAD_TO Kconfig option
      power: rk8xx: properly print all supported PMICs name
      rockchip: ringneck-px30: fix TPL_MAX_SIZE
      rockchip: add support for Theobroma Systems SOM-RK3588-Q7 Tiger module
      rockchip: ringneck-px30: get closer to other Theobroma defconfigs
      rockchip: puma-rk3399: get closer to other Theobroma defconfigs

Sebastian Reichel (4):
      arm64: dts: rockchip: fix usb2phy nodename for rk3588
      arm64: dts: rockchip: reorder usb2phy properties for rk3588
      arm64: dts: rockchip: add USBDP phys on rk3588
      arm64: dts: rockchip: add USB3 DRD controllers on rk3588

 MAINTAINERS                                        |   1 +
 arch/arm/dts/Makefile                              |   8 -
 arch/arm/dts/px30-engicam-common.dtsi              | 129 ----
 arch/arm/dts/px30-engicam-ctouch2.dtsi             |  30 -
 arch/arm/dts/px30-engicam-edimm2.2.dtsi            |  66 --
 .../dts/px30-engicam-px30-core-ctouch2-of10.dts    |  77 ---
 arch/arm/dts/px30-engicam-px30-core-ctouch2.dts    |  22 -
 arch/arm/dts/px30-engicam-px30-core-edimm2.2.dts   |  43 --
 arch/arm/dts/px30-engicam-px30-core.dtsi           | 241 -------
 arch/arm/dts/px30-evb.dts                          | 634 ------------------
 arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi      |   8 -
 arch/arm/dts/px30-ringneck-haikou.dts              | 232 -------
 arch/arm/dts/px30-ringneck.dtsi                    | 382 -----------
 arch/arm/dts/px30-u-boot.dtsi                      |  16 +
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi         |  15 +
 arch/arm/dts/rk3326-odroid-go2.dts                 | 642 ------------------
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi        |   6 -
 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi       |   6 +
 arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi       |  37 ++
 arch/arm/dts/rk3588-u-boot.dtsi                    |  74 ---
 arch/arm/dts/rk3588s-u-boot.dtsi                   |  85 ---
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |  57 ++
 board/armsom/sige7-rk3588/Kconfig                  |  12 +
 board/armsom/sige7-rk3588/MAINTAINERS              |   7 +
 board/theobroma-systems/tiger_rk3588/Kconfig       |  16 +
 board/theobroma-systems/tiger_rk3588/MAINTAINERS   |  13 +
 board/theobroma-systems/tiger_rk3588/Makefile      |  10 +
 .../theobroma-systems/tiger_rk3588/tiger_rk3588.c  |  53 ++
 configs/evb-px30_defconfig                         |  24 +-
 configs/firefly-px30_defconfig                     |  19 +-
 configs/jaguar-rk3588_defconfig                    |   1 -
 configs/odroid-go2_defconfig                       |  20 +-
 configs/puma-rk3399_defconfig                      |  10 +-
 configs/px30-core-ctouch2-of10-px30_defconfig      |  20 +-
 configs/px30-core-ctouch2-px30_defconfig           |  20 +-
 configs/px30-core-edimm2.2-px30_defconfig          |  20 +-
 configs/ringneck-px30_defconfig                    |  21 +-
 configs/sige7-rk3588_defconfig                     |  93 +++
 configs/tiger-rk3588_defconfig                     | 113 ++++
 doc/board/rockchip/rockchip.rst                    |   2 +
 doc/board/theobroma-systems/index.rst              |   1 +
 doc/board/theobroma-systems/tiger_rk3588.rst       | 102 +++
 drivers/power/pmic/rk8xx.c                         |   6 +-
 .../src/arm64/rockchip/rk3588-armsom-sige7.dts     | 721 +++++++++++++++++++++
 .../src/arm64/rockchip/rk3588-coolpi-cm5.dtsi      |   2 +-
 .../rockchip/rk3588-edgeble-neu6a-common.dtsi      |   2 +-
 dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts  |   2 +-
 .../src/arm64/rockchip/rk3588-tiger-haikou.dts     |  65 +-
 dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi  |  29 +-
 .../src/arm64/rockchip/rk3588-turing-rk1.dtsi      |   2 +-
 dts/upstream/src/arm64/rockchip/rk3588.dtsi        |  72 ++
 .../src/arm64/rockchip/rk3588s-coolpi-4b.dts       |   2 +-
 .../src/arm64/rockchip/rk3588s-indiedroid-nova.dts |   2 +-
 .../src/arm64/rockchip/rk3588s-orangepi-5.dts      |   2 +-
 .../src/arm64/rockchip/rk3588s-rock-5a.dts         |   2 +-
 dts/upstream/src/arm64/rockchip/rk3588s.dtsi       | 377 ++++++++---
 include/configs/sige7-rk3588.h                     |  15 +
 include/configs/tiger_rk3588.h                     |  15 +
 59 files changed, 1795 insertions(+), 2910 deletions(-)
 delete mode 100644 arch/arm/dts/px30-engicam-common.dtsi
 delete mode 100644 arch/arm/dts/px30-engicam-ctouch2.dtsi
 delete mode 100644 arch/arm/dts/px30-engicam-edimm2.2.dtsi
 delete mode 100644 arch/arm/dts/px30-engicam-px30-core-ctouch2-of10.dts
 delete mode 100644 arch/arm/dts/px30-engicam-px30-core-ctouch2.dts
 delete mode 100644 arch/arm/dts/px30-engicam-px30-core-edimm2.2.dts
 delete mode 100644 arch/arm/dts/px30-engicam-px30-core.dtsi
 delete mode 100644 arch/arm/dts/px30-evb.dts
 delete mode 100644 arch/arm/dts/px30-ringneck-haikou.dts
 delete mode 100644 arch/arm/dts/px30-ringneck.dtsi
 delete mode 100644 arch/arm/dts/rk3326-odroid-go2.dts
 create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
 create mode 100644 board/armsom/sige7-rk3588/Kconfig
 create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
 create mode 100644 board/theobroma-systems/tiger_rk3588/Kconfig
 create mode 100644 board/theobroma-systems/tiger_rk3588/MAINTAINERS
 create mode 100644 board/theobroma-systems/tiger_rk3588/Makefile
 create mode 100644 board/theobroma-systems/tiger_rk3588/tiger_rk3588.c
 create mode 100644 configs/sige7-rk3588_defconfig
 create mode 100644 configs/tiger-rk3588_defconfig
 create mode 100644 doc/board/theobroma-systems/tiger_rk3588.rst
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
 create mode 100644 include/configs/sige7-rk3588.h
 create mode 100644 include/configs/tiger_rk3588.h
