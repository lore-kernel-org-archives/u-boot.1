Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6889EC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6C688AE5;
	Thu, 18 Jul 2024 10:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MfnyN1Yd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08ED88B11; Thu, 18 Jul 2024 10:33:53 +0200 (CEST)
Received: from mail-m121153.qiye.163.com (mail-m121153.qiye.163.com
 [115.236.121.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B623488AE5
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MfnyN1Ydry6mGjxD3Tu1QJLmKta9CYHsNME7FIVzTpcjZt5PyGUiizOs3ooPSduqYLb7DHqeNQku5ik/tNX/XmgmP4ZlLM7jWaGZsNRkebBGl0VxCubBlvsDc07Hxhcan7RSCMJt5XwHguPIr43yNu/EWBfxQB9F0S4J2z45mws=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=o6Dr8hLWgH9rEtjnypxMVQwiCyXATJJhJACX2IT2Ln4=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E65599005D7;
 Thu, 18 Jul 2024 16:33:41 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240718
Date: Thu, 18 Jul 2024 16:33:41 +0800
Message-Id: <20240718083341.401564-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlPTVYZQ0NMTBhPTBgaGU1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90c4f9c69903a9kunme65599005d7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6Ihw*HjIzLhUBEzYrORwc
 LjZPFCtVSlVKTElKSUJKTUlJTEhJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMQkNPNwY+
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
- Add boards: 
  rk3328: Radxa ROCK Pi E v3;
  rk3588s: FriendlyElec NanoPi R6C/S;
- Remove board: Theobroma Systems RK3368 Lion;
- Add rk3588 pcie support;
- Misc updates for board and config;


CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/21635

Thanks,
- Kever

The following changes since commit b182816c1fb436916661949213c543bf4d42250b:

  turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240718

for you to fetch changes up to e8b3f6c1018e1401bcc697a8aed8120061e4f189:

  configs: rockchip: imply OF_LIBFDT_OVERLAY for rk3308 and rk3328 (2024-07-17 16:26:55 +0800)

----------------------------------------------------------------
FUKAUMI Naoki (5):
      rockchip: include cru_rk3588.h and define rockchip_cru for RK3588
      rockchip: add support for Radxa ROCK Pi E v3.0
      configs: rockchip: reduce diff for rk3308, rk3328, rk3399, rk3568, and rk3588
      configs: rockchip: sync ENV_MEM_LAYOUT_SETTINGS for rk3308, rk3328, and rk3399
      configs: rockchip: imply OF_LIBFDT_OVERLAY for rk3308 and rk3328

Heiko Stuebner (1):
      arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar

Jagan Teki (1):
      phy: rockchip: inno-hdmi: Fix missing readl base addr

Quentin Schulz (14):
      rockchip: ringneck-px30: disable broken USB gadget
      rockchip: ringneck-px30: enable FIT verification in SPL
      rockchip: px30: imply ARMV8_CRYPTO
      rockchip: puma-rk3399: add button support
      rockchip: px30: bind sub-nodes for GRF (syscon)
      rockchip: io-domain: add support for PX30
      rockchip: ringneck-px30: enable IO domain
      rockchip: rk3399: fix SPI-NOR flash not found in U-Boot pre-reloc
      power: rk8xx: fix display name for RK808
      rockchip: puma-rk3399: increase Ethernet PHY timeout to 30s
      rockchip: theobroma-systems: migrate git URLs to HTTPS
      rockchip: remove support for Theobroma Systems RK3368 Lion
      rockchip: jaguar-rk3588: add PCIe M.2 M-KEY NVMe support
      rockchip: tiger-rk3588: add PCIe support

Sebastian Kropatsch (6):
      board: rockchip: Add FriendlyElec NanoPi R6C
      board: rockchip: Add FriendlyElec NanoPi R6S
      phy: rockchip: naneng-combphy: Fix "rockchip" spelling
      phy: rockchip: snps-pcie3: Fix "rockchip" spelling
      phy: rockchip: snps-pcie3: Fix bifurcation for RK3588
      phy: rockchip: snps-pcie3: Fix clearing PHP_GRF_PCIESEL_CON bits

 arch/arm/dts/Makefile                              |   1 -
 arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi     |  42 +++
 arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi          |  41 +--
 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi       |   4 +
 arch/arm/dts/rk3328-rock-pi-e-v3.dts               |   4 +
 arch/arm/dts/rk3368-lion-haikou-u-boot.dtsi        | 119 --------
 arch/arm/dts/rk3368-lion-haikou.dts                | 144 ----------
 arch/arm/dts/rk3368-lion.dtsi                      | 318 ---------------------
 arch/arm/dts/rk3399-u-boot.dtsi                    |   5 +
 arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi        |   3 +
 arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi        |   3 +
 arch/arm/include/asm/arch-rockchip/cru.h           |   2 +
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h    |   2 +
 arch/arm/mach-rockchip/Kconfig                     |   4 +
 arch/arm/mach-rockchip/px30/syscon_px30.c          |   3 +
 arch/arm/mach-rockchip/rk3368/Kconfig              |  22 --
 arch/arm/mach-rockchip/rk3588/Kconfig              |  26 ++
 board/friendlyelec/nanopi-r6c-rk3588s/Kconfig      |  12 +
 board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS  |   7 +
 board/friendlyelec/nanopi-r6s-rk3588s/Kconfig      |  12 +
 board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS  |   7 +
 board/rockchip/evb_rk3328/MAINTAINERS              |   4 +-
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS  |   2 +-
 board/theobroma-systems/lion_rk3368/Kconfig        |  18 --
 board/theobroma-systems/lion_rk3368/MAINTAINERS    |  10 -
 board/theobroma-systems/lion_rk3368/README         |  78 -----
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   2 +-
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   2 +-
 board/theobroma-systems/tiger_rk3588/MAINTAINERS   |   2 +-
 configs/evb-rk3308_defconfig                       |   1 -
 configs/jaguar-rk3588_defconfig                    |   5 +
 configs/nanopi-r6c-rk3588s_defconfig               |  83 ++++++
 configs/nanopi-r6s-rk3588s_defconfig               |  82 ++++++
 configs/puma-rk3399_defconfig                      |   3 +
 configs/ringneck-px30_defconfig                    |  11 +-
 configs/roc-cc-rk3308_defconfig                    |   1 -
 ...368_defconfig => rock-pi-e-v3-rk3328_defconfig} |  83 +++---
 configs/rock-pi-s-rk3308_defconfig                 |   1 -
 configs/tiger-rk3588_defconfig                     |   4 +
 doc/board/rockchip/rockchip.rst                    |   3 +-
 drivers/misc/rockchip-io-domain.c                  |  66 +++++
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |   8 +-
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |   4 +-
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     |  42 ++-
 drivers/power/pmic/rk8xx.c                         |   2 +
 dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts  |  59 ++++
 include/configs/lion_rk3368.h                      |  16 --
 include/configs/nanopi-r6c-rk3588s.h               |  12 +
 include/configs/nanopi-r6s-rk3588s.h               |  12 +
 include/configs/rk3308_common.h                    |  32 ++-
 include/configs/rk3328_common.h                    |  31 +-
 include/configs/rk3399_common.h                    |  40 +--
 include/configs/rk3568_common.h                    |  14 +-
 include/configs/rk3588_common.h                    |  12 +-
 54 files changed, 605 insertions(+), 921 deletions(-)
 create mode 100644 arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3.dts
 delete mode 100644 arch/arm/dts/rk3368-lion-haikou-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3368-lion-haikou.dts
 delete mode 100644 arch/arm/dts/rk3368-lion.dtsi
 create mode 100644 arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
 create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/Kconfig
 create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS
 create mode 100644 board/friendlyelec/nanopi-r6s-rk3588s/Kconfig
 create mode 100644 board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS
 delete mode 100644 board/theobroma-systems/lion_rk3368/Kconfig
 delete mode 100644 board/theobroma-systems/lion_rk3368/MAINTAINERS
 delete mode 100644 board/theobroma-systems/lion_rk3368/README
 create mode 100644 configs/nanopi-r6c-rk3588s_defconfig
 create mode 100644 configs/nanopi-r6s-rk3588s_defconfig
 rename configs/{lion-rk3368_defconfig => rock-pi-e-v3-rk3328_defconfig} (50%)
 delete mode 100644 include/configs/lion_rk3368.h
 create mode 100644 include/configs/nanopi-r6c-rk3588s.h
 create mode 100644 include/configs/nanopi-r6s-rk3588s.h
