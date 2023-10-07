Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B6E95A60
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 08:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6756786AA8;
	Sat,  7 Oct 2023 10:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aKUZlCzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D67D86B0C; Sat,  7 Oct 2023 10:47:17 +0200 (CEST)
Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com
 [45.254.49.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BAF8868AE
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 10:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=aKUZlCzfMBlTb1LQvGECbqCW+dz8XMTAdKfz6O/T+dsJqTZaaFnZY2lyL3HrGmIZy4mEPPgxb0NcMRNyzPA9MWAnmtfiAK+tmcQg9SPcDxz5D7wJBM1NTaP+BFmdMN/Fb/QwAkBAT9GEPmjofPwFFm/9KVnjSYnTVg7T53Zf4to=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=zzwHhM1p5GRcUKRUIBHeqD04UWWiU4xQuGfM8OmtEvo=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id EF0214002FD;
 Sat,  7 Oct 2023 16:47:06 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20231007
Date: Sat,  7 Oct 2023 16:47:06 +0800
Message-Id: <20231007084706.554420-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkMfGFYaTB1LHRkaTxpCS0pVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8b0951a30a2eb3kusnef0214002fd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mww6Cxw6Fjw3GBhIFUwVHk0u
 SUtPCglVSlVKTUJNTU1DT0lMTUhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTUJLNwY+
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
- Add Board: rk3568 Bananapi R2Pro;
- Update pcie bifurcation support;
- dwc_eth_qos controller support for rk3568 and rk3588;
- Compressed binary support for U-Boot on rockchip platform;
- dts and config updates for different board and soc;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18045

Thanks,
- Kever

The following changes since commit be2abe73df58a35da9e8d5afb13fccdf1b0faa8e:

  Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2023-10-05 13:26:44 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20231007

for you to fetch changes up to a7c86c57fb404df0a807c2ad9717c510150b8ebb:

  configs: rockchip: rk3308: enable CONFIG_OF_LIBFDT_OVERLAY (2023-10-07 10:48:16 +0800)

----------------------------------------------------------------
FUKAUMI Naoki (5):
      configs: rockchip: rock-pi-s: use default bootdelay (2s)
      arm: dts: rockchip: sync DT for RK3588 series with Linux
      arm: dts: rockchip: rock-5b: add support for PCIe3 and NVMe
      configs: rockchip: rk3308: use CONFIG_DEFAULT_FDT_FILE
      configs: rockchip: rk3308: enable CONFIG_OF_LIBFDT_OVERLAY

Frank Wunderlich (1):
      board: rockchip: Add Bananapi R2Pro Board

Jonas Karlman (19):
      pci: pcie_dw_rockchip: Configure number of lanes and link width speed
      phy: rockchip: snps-pcie3: Refactor to use clk_bulk API
      phy: rockchip: snps-pcie3: Refactor to use a phy_init ops
      phy: rockchip: snps-pcie3: Add bifurcation support for RK3568
      phy: rockchip: snps-pcie3: Add support for RK3588
      phy: rockchip: naneng-combphy: Use signal from comb PHY on RK3588
      rockchip: rk3568-nanopi-r5: Update defconfig for NanoPi R5C and R5S
      rockchip: rk3568-nanopi-r5: Enable PCIe on NanoPi R5C and R5S
      rockchip: rk356x: Enable poweroff command
      power: regulator: Only run autoset once for each regulator
      rockchip: Port IO-domain driver for RK3568 from linux
      rockchip: board: Add minimal generic RK3566/RK3568 board
      net: dwc_eth_qos: Drop unused rx_pkt from eqos_priv
      net: dwc_eth_qos: Return error code when start fails
      net: dwc_eth_qos: Stop spam of RX packet not available message
      net: dwc_eth_qos: Add glue driver for GMAC on Rockchip RK3568
      net: dwc_eth_qos_rockchip: Add support for RK3588
      configs: rockchip: Enable ethernet driver on RK356x boards
      configs: rockchip: Enable ethernet driver on RK3588 boards

Joseph Chen (1):
      regulator: rk8xx: Return correct voltage for buck converters

Manoj Sai (4):
      spl: fit: support for booting a GZIP-compressed U-boot binary
      spl: fit: support for booting a LZMA-compressed U-boot binary
      rockchip: Add support to generate GZIP compressed U-boot binary
      rockchip: Add support to generate LZMA compressed U-boot binary

Massimo Pegorer (3):
      rockchip: Kconfig: Enable external TPL binary for rk3308
      doc: rockchip: Update and improve info on rk3308, TPL and TF-A
      configs: rockchip: add DOS_PARTITION to RK3308 boards defconfig

shengfei Xu (1):
      regulator: rk8xx: Return correct voltage for switchout converters

 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi         |  19 +
 arch/arm/dts/rk3568-bpi-r2-pro.dts                 | 852 +++++++++++++++++++++
 arch/arm/dts/rk3568-generic-u-boot.dtsi            |  14 +
 arch/arm/dts/rk3568-generic.dts                    |  38 +
 arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi         |   4 +
 arch/arm/dts/rk3568-nanopi-r5c.dts                 |   2 +-
 arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi         |  10 +-
 arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi   |   1 -
 arch/arm/dts/rk3588-edgeble-neu6a.dtsi             |   1 -
 arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi   |   6 -
 arch/arm/dts/rk3588-edgeble-neu6b-io.dts           |  66 ++
 arch/arm/dts/rk3588-edgeble-neu6b.dtsi             | 359 ++++++++-
 arch/arm/dts/rk3588-evb1-v10.dts                   | 720 ++++++++++++++++-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi            | 142 ++--
 arch/arm/dts/rk3588-rock-5b.dts                    | 448 ++++++++++-
 arch/arm/dts/rk3588.dtsi                           | 215 ++++++
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi           |  12 -
 arch/arm/dts/rk3588s-rock-5a.dts                   | 665 +++++++++++++++-
 arch/arm/dts/rk3588s-u-boot.dtsi                   | 162 ----
 arch/arm/dts/rk3588s.dtsi                          | 367 +++++++++
 arch/arm/dts/rockchip-u-boot.dtsi                  |  11 +
 arch/arm/mach-rockchip/Kconfig                     |   3 +-
 board/rockchip/evb_rk3568/MAINTAINERS              |  14 +
 common/spl/spl_fit.c                               |  20 +-
 configs/bpi-r2-pro-rk3568_defconfig                |  93 +++
 configs/evb-rk3308_defconfig                       |   3 +-
 configs/evb-rk3568_defconfig                       |   6 +-
 configs/evb-rk3588_defconfig                       |   5 +-
 configs/generic-rk3568_defconfig                   |  64 ++
 configs/lubancat-2-rk3568_defconfig                |   3 +
 configs/nanopi-r5c-rk3568_defconfig                |  18 +-
 configs/nanopi-r5s-rk3568_defconfig                |  22 +-
 configs/neu6a-io-rk3588_defconfig                  |   2 -
 configs/neu6b-io-rk3588_defconfig                  |   2 -
 configs/odroid-m1-rk3568_defconfig                 |   3 +
 configs/quartz64-a-rk3566_defconfig                |   4 +
 configs/quartz64-b-rk3566_defconfig                |   4 +
 configs/radxa-cm3-io-rk3566_defconfig              |   6 +-
 configs/roc-cc-rk3308_defconfig                    |   3 +-
 configs/rock-3a-rk3568_defconfig                   |   6 +-
 configs/rock-pi-s-rk3308_defconfig                 |   5 +-
 configs/rock5a-rk3588s_defconfig                   |   5 +-
 configs/rock5b-rk3588_defconfig                    |   4 +-
 configs/soquartz-blade-rk3566_defconfig            |   3 +
 configs/soquartz-cm4-rk3566_defconfig              |   3 +
 configs/soquartz-model-a-rk3566_defconfig          |   4 +
 doc/README.rockchip                                |  10 +-
 doc/board/rockchip/rockchip.rst                    |  45 +-
 drivers/misc/Kconfig                               |   9 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/rockchip-io-domain.c                  | 167 ++++
 drivers/net/Kconfig                                |   8 +
 drivers/net/Makefile                               |   1 +
 drivers/net/dwc_eth_qos.c                          |  33 +-
 drivers/net/dwc_eth_qos.h                          |   3 +-
 drivers/net/dwc_eth_qos_rockchip.c                 | 531 +++++++++++++
 drivers/pci/pcie_dw_rockchip.c                     |  58 +-
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |   6 +
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     | 230 ++++--
 drivers/power/pmic/Kconfig                         |   1 +
 drivers/power/regulator/regulator-uclass.c         |  18 +-
 drivers/power/regulator/rk8xx.c                    |  95 ++-
 include/configs/rk3308_common.h                    |   4 +-
 include/dt-bindings/ata/ahci.h                     |  20 +
 include/power/regulator.h                          |   1 +
 include/spl.h                                      |  10 +
 67 files changed, 5206 insertions(+), 465 deletions(-)
 create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro.dts
 create mode 100644 arch/arm/dts/rk3568-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3568-generic.dts
 create mode 100644 configs/bpi-r2-pro-rk3568_defconfig
 create mode 100644 configs/generic-rk3568_defconfig
 create mode 100644 drivers/misc/rockchip-io-domain.c
 create mode 100644 drivers/net/dwc_eth_qos_rockchip.c
 create mode 100644 include/dt-bindings/ata/ahci.h
