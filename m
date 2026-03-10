Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4961FCC9A2
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D959A839DF;
	Tue, 10 Mar 2026 01:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OVULts7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338DA83BC8; Tue, 10 Mar 2026 01:48:41 +0100 (CET)
Received: from mail-m1973195.qiye.163.com (mail-m1973195.qiye.163.com
 [220.197.31.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F54183981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36525eaa0;
 Tue, 10 Mar 2026 08:48:32 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20260309
Date: Tue, 10 Mar 2026 08:48:32 +0800
Message-Id: <20260310004832.158893-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cd53789b403afkunm3909be18170e0e7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUseVkpDSE8aH0seTE9IH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=OVULts7RfVvjTD2/Cs/XSqpvmV60b7S7PdQscnFU6NFKxMRz4ReF+N+Gdp4RbgKf61efSkMsHG1BtJiuZD/vJzqL7B5vEsD7hUAL+vkKUnWGQdDvUYY3gFhdeRSjXQUH0dwso18PYVQqJByndM4Uu3tRFc8EaFoU5ILF+yD4I9g=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=G6lCrnu10HA2xeB8fiyuxKCYI6ruII12dQ+c1YfXm54=;
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
- New SoC support: RK3506, RK3582;
- New Board support: RK3528 FriendlyElec NanoPi Zero2;
- Other fixes

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/29452

Thanks,
- Kever

The following changes since commit b26cc03b7cecaabdb306c2f68eebde764161a545:

  Merge patch series "MAINTAINERS: Update ADI ADSP platform maintainers" (2026-03-04 14:25:30 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20260309

for you to fetch changes up to 17b6f20cfefd65987d6976c7356673787fd0ba32:

  arm: rockchip: don't use non-existent CONFIG_TPL_TINY_FRAMEWORK (2026-03-09 22:52:22 +0800)

----------------------------------------------------------------
Finley Xiao (2):
      dt-bindings: clock: rockchip: Add RK3506 clock and reset unit
      clk: rockchip: Add support for RK3506

Heinrich Schuchardt (1):
      arm: rockchip: don't use non-existent CONFIG_TPL_TINY_FRAMEWORK

Johan Jonker (6):
      ARM: dts: rockchip: Remove mshc aliases from RK3288
      ARM: dts: rockchip: Add spi_flash label to rk3288-veyron
      ARM: dts: rockchip: move edp assigned-clocks to edp node on rk3288
      rockchip: Switch rk3288-veyron boards to upstream devicetree
      rockchip: Switch remaining rk3288 boards to upstream devicetree
      rockchip: imply OF_UPSTREAM for rk3288 boards

Jonas Karlman (17):
      rockchip: sdram: Add fallback that fixup DRAM gaps on RK3588
      phy: rockchip: naneng-combphy: Enable U3 port for USB3OTG on RK3568
      rockchip: Add initial RK3582 support
      rockchip: rk3588-generic: Enable support for RK3582
      rockchip: rk3588s-rock-5c: Add support for ROCK 5C Lite variant
      rockchip: rk3576: Allow pmu sram access for non-secure masters
      rockchip: rk3576: Use DMA when loading FIT images
      board: rockchip: Add FriendlyElec NanoPi Zero2
      rockchip: spl: Add common handling of USB bootsource_id 0x81
      rockchip: mkimage: Re-sort the spl_infos list alphanumerically
      ram: rockchip: Add basic support for RK3506
      pinctrl: rockchip: Use syscon_regmap_lookup_by_phandle()
      rockchip: otp: Add support for RK3506
      phy: rockchip-inno-usb2: Add support for RK3506
      net: dwc_eth_qos_rockchip: Add support for RK3506
      arch: arm: rockchip: Add initial support for RK3506
      rockchip: Reduce size of ramboot usb472 payload

Quentin Schulz (2):
      rockchip: tiger-rk3588: disable HS400
      rockchip: rk3588: include all addressable DRAM in memory map

Xuhui Lin (1):
      rockchip: mkimage: Add support for RK3506

Ye Zhang (1):
      pinctrl: rockchip: Add support for RK3506

 arch/arm/dts/Makefile                              |   11 -
 arch/arm/dts/cros-ec-sbs.dtsi                      |   52 -
 ...vb-u-boot.dtsi => rk3288-evb-rk808-u-boot.dtsi} |    0
 arch/arm/dts/rk3288-evb.dts                        |   20 -
 arch/arm/dts/rk3288-evb.dtsi                       |  476 --------
 arch/arm/dts/rk3288-popmetal.dts                   |   20 -
 arch/arm/dts/rk3288-popmetal.dtsi                  |  547 ---------
 arch/arm/dts/rk3288-rock-pi-n8.dts                 |   17 -
 arch/arm/dts/rk3288-rock2-som.dtsi                 |  278 -----
 arch/arm/dts/rk3288-rock2-square.dts               |  181 ---
 arch/arm/dts/rk3288-veyron-chromebook.dtsi         |  205 ----
 arch/arm/dts/rk3288-veyron-jerry.dts               |  208 ----
 arch/arm/dts/rk3288-veyron-mickey.dts              |  266 -----
 arch/arm/dts/rk3288-veyron-minnie.dts              |  302 -----
 arch/arm/dts/rk3288-veyron-speedy.dts              |  143 ---
 arch/arm/dts/rk3288-veyron.dtsi                    |  795 -------------
 arch/arm/dts/rk3288-vmarc-som.dtsi                 |  361 ------
 arch/arm/dts/rk3288-vyasa.dts                      |  473 --------
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi       |   11 +
 arch/arm/dts/rk3576-u-boot.dtsi                    |    4 -
 arch/arm/dts/rk3588-generic.dts                    |    4 +-
 arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi    |  137 ---
 arch/arm/dts/rockchip-u-boot.dtsi                  |    6 +-
 arch/arm/include/asm/arch-rk3506/boot0.h           |    9 +
 arch/arm/include/asm/arch-rk3506/gpio.h            |    9 +
 arch/arm/include/asm/arch-rockchip/clock.h         |   10 +
 arch/arm/include/asm/arch-rockchip/cru_rk3506.h    |  181 +++
 arch/arm/mach-rockchip/Kconfig                     |   46 +-
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/rk3506/Kconfig              |   15 +
 arch/arm/mach-rockchip/rk3506/Makefile             |    5 +
 arch/arm/mach-rockchip/rk3506/clk_rk3506.c         |   16 +
 arch/arm/mach-rockchip/rk3506/rk3506.c             |  125 +++
 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c      |   19 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS          |    6 +
 arch/arm/mach-rockchip/rk3528/rk3528.c             |   15 -
 arch/arm/mach-rockchip/rk3576/rk3576.c             |    6 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |    9 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c             |  260 +++++
 arch/arm/mach-rockchip/sdram.c                     |    7 +-
 arch/arm/mach-rockchip/spl.c                       |   63 +-
 board/amarula/vyasa-rk3288/MAINTAINERS             |    1 -
 board/chipspark/popmetal_rk3288/MAINTAINERS        |    1 -
 board/google/veyron/MAINTAINERS                    |   10 +-
 board/rockchip/evb_rk3288/MAINTAINERS              |    6 +-
 configs/chromebit_mickey_defconfig                 |    4 +-
 configs/chromebook_jerry_defconfig                 |    4 +-
 configs/chromebook_minnie_defconfig                |    4 +-
 configs/chromebook_speedy_defconfig                |    4 +-
 ...rk3288_defconfig => evb-rk3288-rk808_defconfig} |    4 +-
 configs/firefly-rk3288_defconfig                   |    1 -
 configs/generic-rk3588_defconfig                   |    1 +
 configs/miqi-rk3288_defconfig                      |    1 -
 configs/nanopi-zero2-rk3528_defconfig              |   64 ++
 configs/phycore-rk3288_defconfig                   |    3 +-
 configs/popmetal-rk3288_defconfig                  |    4 +-
 configs/rock-5c-rk3588s_defconfig                  |    1 +
 configs/rock-pi-n8-rk3288_defconfig                |    2 +-
 configs/rock2_defconfig                            |    4 +-
 configs/tiger-rk3588_defconfig                     |    4 -
 configs/tinker-rk3288_defconfig                    |    1 -
 configs/tinker-s-rk3288_defconfig                  |    1 -
 configs/vyasa-rk3288_defconfig                     |    4 +-
 doc/board/rockchip/rockchip.rst                    |   13 +-
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk_rk3506.c                  | 1166 ++++++++++++++++++++
 drivers/misc/rockchip-otp.c                        |    4 +
 drivers/net/dwc_eth_qos.c                          |    4 +
 drivers/net/dwc_eth_qos_rockchip.c                 |   86 ++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   20 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |    8 +
 drivers/pinctrl/rockchip/Makefile                  |    1 +
 drivers/pinctrl/rockchip/pinctrl-rk3506.c          |  462 ++++++++
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c   |   46 +-
 drivers/pinctrl/rockchip/pinctrl-rockchip.h        |    1 +
 drivers/ram/rockchip/Makefile                      |    1 +
 drivers/ram/rockchip/sdram_rk3506.c                |   33 +
 drivers/reset/Makefile                             |    2 +-
 drivers/reset/rst-rk3506.c                         |  222 ++++
 drivers/usb/gadget/Kconfig                         |    1 +
 .../Bindings/clock/rockchip,rk3506-cru.yaml        |   55 +
 .../dt-bindings/clock/rockchip,rk3506-cru.h        |  285 +++++
 .../dt-bindings/reset/rockchip,rk3506-cru.h        |  211 ++++
 dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi   |    2 +-
 dts/upstream/src/arm/rockchip/rk3288.dtsi          |    9 +-
 include/configs/rk3506_common.h                    |   38 +
 tools/rkcommon.c                                   |    5 +-
 87 files changed, 3518 insertions(+), 4606 deletions(-)
 delete mode 100644 arch/arm/dts/cros-ec-sbs.dtsi
 rename arch/arm/dts/{rk3288-evb-u-boot.dtsi => rk3288-evb-rk808-u-boot.dtsi} (100%)
 delete mode 100644 arch/arm/dts/rk3288-evb.dts
 delete mode 100644 arch/arm/dts/rk3288-evb.dtsi
 delete mode 100644 arch/arm/dts/rk3288-popmetal.dts
 delete mode 100644 arch/arm/dts/rk3288-popmetal.dtsi
 delete mode 100644 arch/arm/dts/rk3288-rock-pi-n8.dts
 delete mode 100644 arch/arm/dts/rk3288-rock2-som.dtsi
 delete mode 100644 arch/arm/dts/rk3288-rock2-square.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-chromebook.dtsi
 delete mode 100644 arch/arm/dts/rk3288-veyron-jerry.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-mickey.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-minnie.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-speedy.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron.dtsi
 delete mode 100644 arch/arm/dts/rk3288-vmarc-som.dtsi
 delete mode 100644 arch/arm/dts/rk3288-vyasa.dts
 create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
 create mode 100644 arch/arm/include/asm/arch-rk3506/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3506/gpio.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3506.h
 create mode 100644 arch/arm/mach-rockchip/rk3506/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3506/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3506/clk_rk3506.c
 create mode 100644 arch/arm/mach-rockchip/rk3506/rk3506.c
 create mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
 rename configs/{evb-rk3288_defconfig => evb-rk3288-rk808_defconfig} (95%)
 create mode 100644 configs/nanopi-zero2-rk3528_defconfig
 create mode 100644 drivers/clk/rockchip/clk_rk3506.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3506.c
 create mode 100644 drivers/ram/rockchip/sdram_rk3506.c
 create mode 100644 drivers/reset/rst-rk3506.c
 create mode 100644 dts/upstream/Bindings/clock/rockchip,rk3506-cru.yaml
 create mode 100644 dts/upstream/include/dt-bindings/clock/rockchip,rk3506-cru.h
 create mode 100644 dts/upstream/include/dt-bindings/reset/rockchip,rk3506-cru.h
 create mode 100644 include/configs/rk3506_common.h
