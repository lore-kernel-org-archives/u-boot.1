Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCD4C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 09:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59571870EA;
	Tue, 24 Oct 2023 11:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LByM6MWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28FF38711F; Tue, 24 Oct 2023 11:12:32 +0200 (CEST)
Received: from mail-m118103.qiye.163.com (mail-m118103.qiye.163.com
 [115.236.118.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1440870CA
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LByM6MWBShHBk96I9snh1fAKy84z3Nx9dRZ+RyqzEnF185UZcc/ho9oHQmNbYf5ZtX3PI4YB8ZInicXDlkDELdFYSB3vYvsxkGn5o3LNZzaNIA+7ddZRIVxetE1zA9V17wVOsmAePkHfoKrqE3c5gxGvBMtmwH681VxbsRIvzMI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=j4t7xE/gp4G8YMSpAlC0Vw/DAGLHr/MNs0hEJ8uS8wI=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 0DF854003F8;
 Tue, 24 Oct 2023 17:12:24 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20231024
Date: Tue, 24 Oct 2023 17:12:23 +0800
Message-Id: <20231024091223.2193416-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkMZH1YZGUgaGU0ZTB8dTB5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8b60f4e5202eb3kusn0df854003f8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6HQw5ETw3MT08PDBJLTw2
 SC0aCxNVSlVKTUJDSkhDTE9PTUhOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMQ0pLNwY+
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
- Add Board: rk3588 NanoPC-T6, Orange Pi 5, Orange Pi 5 Plus;
- clk driver fix for rk3568 and rk3588;
- rkmtd cmd support for rockchip nand device;
- dts update and sync from linux;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18275

Thanks,
- Kever

The following changes since commit 9a3a58396b78b1f9d0c14580dc03f81d29207dd2:

  Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2023-10-20 12:54:33 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20231024

for you to fetch changes up to d039b1b551e8dbb2c309d35bb19b7866caa4dcc1:

  rockchip: configs: sandbox: enable rkmtd command (2023-10-24 15:55:17 +0800)

----------------------------------------------------------------
Elaine Zhang (4):
      clk: rockchip: rk3568: support dclk_vop select more parent clks
      clk: rockchip: rk3588: support aclk_top_root set 750M
      clk: rockchip: rk3588: Avoid re-setting the pll rate of dclk_vop's parent
      clk: rockchip: rk3588: fix up the frac pll calculation

Guochun Huang (1):
      clk: rk3588: Add 742.5M parameter for PLL

Johan Jonker (8):
      mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN option
      rockchip: dm: prepare rkmtd UCLASS
      rockchip: block: add rkmtd class and drivers
      rockchip: block: blk-uclass: add bounce buffer flag to blk_desc
      rockchip: cmd: add rkmtd command
      rockchip: test: dm: add rkmtd test
      rockchip: doc: add rkmtd.rst
      rockchip: configs: sandbox: enable rkmtd command

John Clark (1):
      board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board

Jonas Karlman (7):
      rockchip: rk3568-radxa-e25: Enable pcie3x1 node
      rockchip: rk3588: Sync device tree from v6.7-rockchip-dts64-1 tag
      rockchip: rk3588-rock-5a: Enable support for USB 2.0 ports
      rockchip: rk3588-rock-5b: Enable support for PCIe SATA cards
      rockchip: rk3588-rock-5b: Sync USB3 nodes from mainline linux patches
      board: rockchip: Add Xunlong Orange Pi 5
      board: rockchip: Add Xunlong Orange Pi 5 Plus

Matwey V. Kornilov (1):
      rockchip: dts: rk3328: Sync rock64 device tree file from Linux

Ricardo Pardini (1):
      mtd: spi-nor: Add support for XMC XM25QU128C

Tom Fitzhenry (1):
      dt-bindings: leds: import common led bindings from linux v6.5

 arch/arm/dts/Makefile                              |    3 +
 arch/arm/dts/rk3328-rock64.dts                     |   14 +-
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi          |   11 +-
 arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi           |   11 +-
 arch/arm/dts/rk3588-evb1-v10.dts                   |  136 +++
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi          |   36 +
 arch/arm/dts/rk3588-nanopc-t6.dts                  |  916 ++++++++++++++++
 arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi    |   27 +
 arch/arm/dts/rk3588-orangepi-5-plus.dts            |  848 ++++++++++++++
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi            |  204 +---
 arch/arm/dts/rk3588-rock-5b.dts                    |  145 +++
 arch/arm/dts/rk3588-u-boot.dtsi                    |   40 +-
 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi        |   22 +
 arch/arm/dts/rk3588s-orangepi-5.dts                |  662 +++++++++++
 arch/arm/dts/rk3588s-pinctrl.dtsi                  |   44 +
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi           |    4 -
 arch/arm/dts/rk3588s-u-boot.dtsi                   |   78 +-
 arch/arm/dts/rk3588s.dtsi                          |   24 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |   46 +
 board/friendlyelec/nanopc-t6-rk3588/Kconfig        |   15 +
 board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS    |    9 +
 board/friendlyelec/nanopc-t6-rk3588/Makefile       |    6 +
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c            |   39 +
 board/rockchip/evb_rk3588/MAINTAINERS              |   14 +
 cmd/Kconfig                                        |    8 +
 cmd/Makefile                                       |    1 +
 cmd/rkmtd.c                                        |  204 ++++
 configs/nanopc-t6-rk3588_defconfig                 |  108 ++
 configs/orangepi-5-plus-rk3588_defconfig           |  105 ++
 configs/orangepi-5-rk3588s_defconfig               |  102 ++
 configs/radxa-e25-rk3568_defconfig                 |    1 -
 configs/rock5a-rk3588s_defconfig                   |   16 +-
 configs/rock5b-rk3588_defconfig                    |    7 +-
 configs/sandbox64_defconfig                        |    1 +
 configs/sandbox_defconfig                          |    1 +
 disk/part.c                                        |    4 +
 doc/board/rockchip/index.rst                       |    1 +
 doc/board/rockchip/rkmtd.rst                       |  105 ++
 doc/board/rockchip/rockchip.rst                    |    3 +
 drivers/block/Kconfig                              |    7 +
 drivers/block/Makefile                             |    2 +
 drivers/block/blk-uclass.c                         |    5 +-
 drivers/block/rkmtd.c                              | 1152 ++++++++++++++++++++
 drivers/clk/rockchip/clk_pll.c                     |  102 +-
 drivers/clk/rockchip/clk_rk3568.c                  |   10 +-
 drivers/clk/rockchip/clk_rk3588.c                  |   35 +-
 drivers/mtd/nand/raw/Kconfig                       |    9 +
 drivers/mtd/nand/raw/rockchip_nfc.c                |    3 +
 drivers/mtd/spi/spi-nor-ids.c                      |    1 +
 drivers/scsi/scsi.c                                |    4 +
 include/blk.h                                      |    1 +
 include/configs/nanopc-t6-rk3588.h                 |   15 +
 include/dm/uclass-id.h                             |    1 +
 include/dt-bindings/leds/common.h                  |    7 +-
 include/rkmtd.h                                    |  191 ++++
 test/dm/Makefile                                   |    1 +
 test/dm/rkmtd.c                                    |  200 ++++
 57 files changed, 5472 insertions(+), 295 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-nanopc-t6.dts
 create mode 100644 arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-orangepi-5-plus.dts
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5.dts
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Kconfig
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
 create mode 100644 cmd/rkmtd.c
 create mode 100644 configs/nanopc-t6-rk3588_defconfig
 create mode 100644 configs/orangepi-5-plus-rk3588_defconfig
 create mode 100644 configs/orangepi-5-rk3588s_defconfig
 create mode 100644 doc/board/rockchip/rkmtd.rst
 create mode 100644 drivers/block/rkmtd.c
 create mode 100644 include/configs/nanopc-t6-rk3588.h
 create mode 100644 include/rkmtd.h
 create mode 100644 test/dm/rkmtd.c
