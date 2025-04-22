Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB3C369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 16:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D49810E8;
	Tue, 22 Apr 2025 18:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Me/+VoLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369DF815D1; Tue, 22 Apr 2025 18:29:56 +0200 (CEST)
Received: from mail-m8357.xmail.ntesmail.com (mail-m8357.xmail.ntesmail.com
 [156.224.83.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB1F780FF7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 18:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12c09da99;
 Wed, 23 Apr 2025 00:29:45 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20250422
Date: Wed, 23 Apr 2025 00:29:45 +0800
Message-Id: <20250422162945.26797-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkNLVkJJSB0YSR5KSE5ISlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
 VLWQY+
X-HM-Tid: 0a965e55871803afkunm12c09da99
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PUk6Sgw5QjJNOEkfLCgqER00
 KhIwFBFVSlVKTE9OSEhCSENNSE5NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUpOSENJNwY+
DKIM-Signature: a=rsa-sha256;
 b=Me/+VoLzA6Fk0lK+uUxlpA3MPdr7DqZZJ3O4VQSZnJA9e0CbWs/e0zr8VAc9E/Qm0q4sXy7wr5xavPzeAfW5BKa9TWXuZdenkpaLl1PAOwLG1N2vwV6OpoWurwn2L9KOvNo2gjGeGRwudV8owLnsTePqa6jOtGOoW0gJGwvAMCc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=+pBlK38znEG0IuJg4j/961tVHyidXXP9QW+rzxHcFJQ=;
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
- New SoC support: RK3528, RK3576
- New Board support: rk3528 Radxa E20C, rk3576 Firefly ROC-RK3576-PC;
- Add generic board for rk3288 and rk3399;
- rng driver binding update;
- misc updates on board level or header files;


CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/25886

Thanks,
- Kever


The following changes since commit 185fdf5e94731df05748b1c576effb52ff7a3ec5:

  fs/squashfs: avoid illegal free() in sqfs_opendir() (2025-04-21 11:08:03 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250422

for you to fetch changes up to 30ac31ab1f167f55bb1206e3ec95048b6fc88371:

  rng: rockchip_rng: Update compatible for RK3588 (2025-04-22 23:31:02 +0800)

----------------------------------------------------------------
Chukun Pan (2):
      arm64: dts: rockchip: Add rk3528 QoS register node
      arm64: dts: rockchip: enable SCMI clk for RK3528 SoC

Elaine Zhang (2):
      clk: rockchip: Add rk3576 clk support
      reset: rockchip: implement rk3576 lookup table

Heiko Stuebner (10):
      rockchip: sdram: honor CFG_SYS_SDRAM_BASE when defining ram regions
      ram: rockchip: Add rk3576 ddr driver support
      rockchip: otp: Add support for RK3576
      mmc: rockchip_sdhci: Add support for RK3576
      mmc: rockchip_dw_mmc: Add support for rk3576
      net: dwc_eth_qos_rockchip: Add support for RK3576
      arm64: dts: rockchip: add rk3576 otp node
      dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
      arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC
      rockchip: rk3576: Add support for ROC-RK3576-PC board

Jonas Karlman (42):
      rockchip: rk3308: Drop unused rk_board_init()
      rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD under SoC Kconfig symbol
      rockchip: Make ROCKCHIP_COMMON_STACK_ADDR depend on TPL
      rockchip: Improve ARMv7 support for ROCKCHIP_COMMON_STACK_ADDR
      rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR under SoC Kconfig symbol
      rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symbol
      rockchip: Add RK3576 support for ROCKCHIP_COMMON_STACK_ADDR
      rockchip: rk3588: Use hptimer reg names in rockchip_stimer_init
      rockchip: Remove partitions env variable for RK356x
      rockchip: Remove partitions env variable for RK3588
      rockchip: Ensure device settings is defined before rk3568_common.h
      rockchip: Ensure device settings is defined before rk3588_common.h
      rockchip: Use rk3568_common.h by default for RK356x boards
      rockchip: Use rk3588_common.h by default for RK3588 boards
      rockchip: rk3568: Drop BOARD_LATE_INIT from target config
      rockchip: rk3588: Drop BOARD_LATE_INIT from target config
      rockchip: Enable meminfo and rng commands for Generic RK3566/RK3568
      rockchip: Enable meminfo and rng commands for Generic RK3588
      arm64: dts: rockchip: Add pinctrl and gpio nodes for RK3528
      arm64: dts: rockchip: Add SARADC node for RK3528
      arm64: dts: rockchip: Add SDHCI controller for RK3528
      arm64: dts: rockchip: Add uart0 pinctrl to Radxa E20C
      arm64: dts: rockchip: Add leds node to Radxa E20C
      arm64: dts: rockchip: Add user button to Radxa E20C
      arm64: dts: rockchip: Add maskrom button to Radxa E20C
      arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C
      ram: rockchip: Add basic support for RK3528
      arm: dts: rockchip: Add rk3528-u-boot.dtsi
      arch: arm: rockchip: Add initial support for RK3528
      mmc: rockchip_sdhci: Extend variant configuration
      mmc: rockchip_sdhci: Add initial support for RK3528
      mmc: rockchip_sdhci: Gate clock for glitch free phase switching
      rockchip: otp: Add support for RK3528
      adc: rockchip-saradc: Add support for RK3528
      phy: rockchip-inno-usb2: Add support for clkout_ctl_phy
      phy: rockchip-inno-usb2: Add support for RK3528
      net: dwc_eth_qos_rockchip: Add support for RK3528
      board: rockchip: Add minimal generic RK3528 board
      board: rockchip: Add Radxa E20C
      rng: rockchip_rng: Add compatible for RK3568
      rockchip: rk356x: Remove rng node from u-boot.dtsi
      rng: rockchip_rng: Update compatible for RK3588

Joseph Chen (1):
      clk: rockchip: Add support for RK3528

Nicolas Frattaroli (1):
      arm64: dts: rockchip: Add rng node to RK3588

Quentin Schulz (7):
      rockchip: theobroma-systems: use HAVE_VENDOR_COMMON_LIB to simplify Makefile
      rockchip: px30: enable RNG for all boards
      rockchip: px30: add fdtoverlay_addr_r default value to support FDTO
      rockchip: ringneck-px30: enable DT overlay support
      rockchip: rk3399: do not generate u-boot.rom anymore
      rockchip: rk3288: do not generate u-boot.rom anymore
      rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin

Steven Liu (2):
      pinctrl: rockchip: Add support for RK3528
      pinctrl: rockchip: support rk3576 pinctrl

Xuhui Lin (2):
      rockchip: mkimage: Add rk3576 support
      arm: rockchip: Add RK3576 arch core support

Yao Zi (3):
      dt-bindings: clock: Document clock and reset unit of RK3528
      arm64: dts: rockchip: Add clock generators for RK3528 SoC
      arm64: dts: rockchip: Add UART clocks for RK3528 SoC

Yifeng Zhao (1):
      rockchip: mkimage: Add support for RK3528

 arch/arm/dts/px30-evb-u-boot.dtsi                  |   10 -
 arch/arm/dts/px30-u-boot.dtsi                      |    1 -
 arch/arm/dts/rk3288-u-boot.dtsi                    |   24 -
 arch/arm/dts/rk3288-veyron-u-boot.dtsi             |    8 +
 arch/arm/dts/rk3399-gru-u-boot.dtsi                |    4 +-
 arch/arm/dts/rk3399-u-boot.dtsi                    |   35 -
 arch/arm/dts/rk3528-generic-u-boot.dtsi            |   12 +
 arch/arm/dts/rk3528-generic.dts                    |   31 +
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi         |   12 +
 arch/arm/dts/rk3528-u-boot.dtsi                    |  148 ++
 arch/arm/dts/rk356x-u-boot.dtsi                    |    9 +-
 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi             |   11 +
 arch/arm/dts/rk3576-u-boot.dtsi                    |  131 +
 arch/arm/dts/rk3588s-u-boot.dtsi                   |    5 -
 arch/arm/dts/rockchip-u-boot.dtsi                  |   10 +
 arch/arm/include/asm/arch-rk3528/boot0.h           |    9 +
 arch/arm/include/asm/arch-rk3528/gpio.h            |    9 +
 arch/arm/include/asm/arch-rk3576/boot0.h           |   11 +
 arch/arm/include/asm/arch-rk3576/gpio.h            |   11 +
 arch/arm/include/asm/arch-rockchip/clock.h         |   27 +
 arch/arm/include/asm/arch-rockchip/cru_rk3528.h    |  388 +++
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h    |  491 ++++
 arch/arm/mach-rockchip/Kconfig                     |  170 +-
 arch/arm/mach-rockchip/Makefile                    |    2 +
 arch/arm/mach-rockchip/px30/Kconfig                |    3 -
 arch/arm/mach-rockchip/rk3288/Kconfig              |    5 -
 arch/arm/mach-rockchip/rk3308/Kconfig              |    3 -
 arch/arm/mach-rockchip/rk3308/rk3308.c             |   69 +-
 arch/arm/mach-rockchip/rk3328/Kconfig              |    3 -
 arch/arm/mach-rockchip/rk3399/Kconfig              |    5 -
 arch/arm/mach-rockchip/rk3528/Kconfig              |   15 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS          |   11 +
 arch/arm/mach-rockchip/rk3528/Makefile             |    5 +
 arch/arm/mach-rockchip/rk3528/clk_rk3528.c         |   16 +
 arch/arm/mach-rockchip/rk3528/rk3528.c             |  137 ++
 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c      |   19 +
 arch/arm/mach-rockchip/rk3568/Kconfig              |    7 +-
 arch/arm/mach-rockchip/rk3576/Kconfig              |   23 +
 arch/arm/mach-rockchip/rk3576/Makefile             |    9 +
 arch/arm/mach-rockchip/rk3576/clk_rk3576.c         |   18 +
 arch/arm/mach-rockchip/rk3576/rk3576.c             |  155 ++
 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c      |   22 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |   26 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c             |   19 +-
 arch/arm/mach-rockchip/sdram.c                     |   16 +-
 board/firefly/roc-pc-rk3576/Kconfig                |   12 +
 board/firefly/roc-pc-rk3576/MAINTAINERS            |    7 +
 board/theobroma-systems/common/Makefile            |    9 +
 board/theobroma-systems/jaguar_rk3588/Makefile     |    3 -
 board/theobroma-systems/puma_rk3399/Makefile       |    3 -
 board/theobroma-systems/ringneck_px30/Makefile     |    3 -
 board/theobroma-systems/tiger_rk3588/Makefile      |    3 -
 configs/generic-rk3528_defconfig                   |   40 +
 configs/generic-rk3568_defconfig                   |    3 +
 configs/generic-rk3588_defconfig                   |    3 +
 configs/radxa-e20c-rk3528_defconfig                |   56 +
 configs/ringneck-px30_defconfig                    |    1 +
 configs/roc-pc-rk3576_defconfig                    |   45 +
 doc/board/rockchip/rockchip.rst                    |   25 +
 drivers/adc/rockchip-saradc.c                      |   10 +
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk_pll.c                     |   23 +-
 drivers/clk/rockchip/clk_rk3528.c                  | 1754 ++++++++++++++
 drivers/clk/rockchip/clk_rk3576.c                  | 2513 ++++++++++++++++++++
 drivers/misc/rockchip-otp.c                        |   15 +
 drivers/mmc/rockchip_dw_mmc.c                      |    1 +
 drivers/mmc/rockchip_sdhci.c                       |   54 +-
 drivers/net/dwc_eth_qos.c                          |    8 +
 drivers/net/dwc_eth_qos_rockchip.c                 |  292 ++-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   63 +-
 drivers/pinctrl/rockchip/Makefile                  |    2 +
 drivers/pinctrl/rockchip/pinctrl-rk3528.c          |  273 +++
 drivers/pinctrl/rockchip/pinctrl-rk3576.c          |  278 +++
 drivers/pinctrl/rockchip/pinctrl-rockchip.h        |    3 +
 drivers/ram/rockchip/Makefile                      |    2 +
 drivers/ram/rockchip/sdram_rk3528.c                |   33 +
 drivers/ram/rockchip/sdram_rk3576.c                |   35 +
 drivers/reset/Makefile                             |    2 +-
 drivers/reset/rst-rk3528.c                         |  302 +++
 drivers/reset/rst-rk3576.c                         |  647 +++++
 drivers/rng/rockchip_rng.c                         |    6 +-
 drivers/usb/gadget/Kconfig                         |    1 +
 dts/upstream/Bindings/arm/rockchip.yaml            |    5 +
 .../Bindings/clock/rockchip,rk3528-cru.yaml        |   64 +
 .../dt-bindings/clock/rockchip,rk3528-cru.h        |  453 ++++
 .../dt-bindings/reset/rockchip,rk3528-cru.h        |  241 ++
 .../src/arm64/rockchip/rk3528-pinctrl.dtsi         | 1397 +++++++++++
 .../src/arm64/rockchip/rk3528-radxa-e20c.dts       |  133 ++
 dts/upstream/src/arm64/rockchip/rk3528.dtsi        |  378 ++-
 dts/upstream/src/arm64/rockchip/rk3576-roc-pc.dts  |  736 ++++++
 dts/upstream/src/arm64/rockchip/rk3576.dtsi        |   39 +
 dts/upstream/src/arm64/rockchip/rk3588-base.dtsi   |    8 +
 include/configs/anbernic-rgxx3-rk3566.h            |    4 +-
 include/configs/evb_rk3568.h                       |    4 +-
 include/configs/evb_rk3588.h                       |    4 +-
 include/configs/khadas-edge2-rk3588s.h             |    4 +-
 include/configs/powkiddy-x55-rk3566.h              |    4 +-
 include/configs/px30_common.h                      |    1 +
 include/configs/rk3528_common.h                    |   38 +
 include/configs/rk3568_common.h                    |    5 +-
 include/configs/rk3576_common.h                    |   41 +
 include/configs/rk3588_common.h                    |    5 +-
 include/configs/roc-pc-rk3576.h                    |   15 +
 include/configs/toybrick_rk3588.h                  |    4 +-
 tools/rkcommon.c                                   |    2 +
 105 files changed, 11998 insertions(+), 274 deletions(-)
 delete mode 100644 arch/arm/dts/px30-evb-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-generic.dts
 create mode 100644 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-rk3528/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3528/gpio.h
 create mode 100644 arch/arm/include/asm/arch-rk3576/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3576/gpio.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3528.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3576.h
 create mode 100644 arch/arm/mach-rockchip/rk3528/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3528/MAINTAINERS
 create mode 100644 arch/arm/mach-rockchip/rk3528/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3528/clk_rk3528.c
 create mode 100644 arch/arm/mach-rockchip/rk3528/rk3528.c
 create mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
 create mode 100644 arch/arm/mach-rockchip/rk3576/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3576/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
 create mode 100644 arch/arm/mach-rockchip/rk3576/rk3576.c
 create mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
 create mode 100644 board/firefly/roc-pc-rk3576/Kconfig
 create mode 100644 board/firefly/roc-pc-rk3576/MAINTAINERS
 create mode 100644 board/theobroma-systems/common/Makefile
 create mode 100644 configs/generic-rk3528_defconfig
 create mode 100644 configs/radxa-e20c-rk3528_defconfig
 create mode 100644 configs/roc-pc-rk3576_defconfig
 create mode 100644 drivers/clk/rockchip/clk_rk3528.c
 create mode 100644 drivers/clk/rockchip/clk_rk3576.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3528.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3576.c
 create mode 100644 drivers/ram/rockchip/sdram_rk3528.c
 create mode 100644 drivers/ram/rockchip/sdram_rk3576.c
 create mode 100644 drivers/reset/rst-rk3528.c
 create mode 100644 drivers/reset/rst-rk3576.c
 create mode 100644 dts/upstream/Bindings/clock/rockchip,rk3528-cru.yaml
 create mode 100644 dts/upstream/include/dt-bindings/clock/rockchip,rk3528-cru.h
 create mode 100644 dts/upstream/include/dt-bindings/reset/rockchip,rk3528-cru.h
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-pinctrl.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-roc-pc.dts
 create mode 100644 include/configs/rk3528_common.h
 create mode 100644 include/configs/rk3576_common.h
 create mode 100644 include/configs/roc-pc-rk3576.h
