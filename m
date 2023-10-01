Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8A4E748F3
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 16:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF6B86D2E;
	Sun,  1 Oct 2023 18:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s6OMI8it";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F354986D1E; Sun,  1 Oct 2023 18:56:15 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB75E86D41
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 18:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 391GtsW0018528;
 Sun, 1 Oct 2023 11:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696179354;
 bh=+AJH1EhLSJcIcCx4mkc1G2zm+C2n3NbPBfoMQq6FsQY=;
 h=From:To:Subject:Date;
 b=s6OMI8itj9w8CUCM6xhik3lJUzF5/9SoHibHA8P3tM0XcMAZxSDYd6yJCPTyAQTuF
 A3ZtTxJiwX5kbfrSS4tNl6+1vwb8hxThe3Q5du8A0kyfQHmLda6VTmFylJq+k1Itgb
 kl2K1iXrTduZnS+5JIEn8WpoMRPae1xYO/8BaXnQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 391Gtsig000436
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 1 Oct 2023 11:55:54 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Oct 2023 11:55:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Oct 2023 11:55:53 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 391GtkAN002403;
 Sun, 1 Oct 2023 11:55:47 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v4 00/16] Introduce initial TI's J784S4 and AM69 support
Date: Sun, 1 Oct 2023 22:25:29 +0530
Message-ID: <20231001165545.494212-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hello Everyone!

This series will introduce basic support (SD and UART) support for Texas
Instruments J784S4 EVM.

The J784S4 SoC device tree patches are taken from kernel patch submissions
and will be updated as they are accepted and merged to the kernel tree.
All other patches are specific to SPL and u-boot and do not have
dependency on other trees. Appreciate a review for acceptance to u-boot
tree.

Here are some of the salient features of the J784S4 automotive grade 
application processor:

The J784S4 SoC belongs to the K3 Multicore SoC architecture
platform, providing advanced system integration in automotive,
ADAS and industrial applications requiring AI at the network edge.
This SoC extends the K3 Jacinto 7 family of SoCs with focus on
raising performance and integration while providing interfaces,
memory architecture and compute performance for multi-sensor, high
concurrency applications.

Some highlights of this SoC are:
* Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F MCUs,
  4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) for
  deep learning and CNN.
* 3D GPU: Automotive grade IMG BXS-4-64 MC1                 
* Vision Processing Accelerator (VPAC) with image signal processor and Depth
  and Motion Processing Accelerator (DMPAC)
* Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and one
  DPI interface.
* Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
  support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role
  device subsystems, Up to 20 MCANs, among other peripherals.

See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
for further details: http://www.ti.com/lit/zip/spruj52

In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It 
supports the following interfaces:
* 32 GB DDR4 RAM
* x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
* x1 Input Audio Jack, x1 Output Audio Jack
* x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
* x2 4L PCIe connector
* x1 UHS-1 capable micro-SD card slot
* 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
  UFS flash.
* x6 UART through UART-USB bridge
* XDS110 for onboard JTAG debug using USB
* Temperature sensors, user push buttons and LEDs
* 40-pin User Expansion Connector
* x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
* x1 15-pin CSI header
* x6 MCAN instances

Schematics: https://www.ti.com/lit/zip/sprr458

bootlog: https://gist.githubusercontent.com/apurvanandan1997/f3475b58306dbfc600b0ad91288e5186/raw/

Changes in v4:
1) Cleaned up Copyright and SPDX identifiers
2) Synced the device trees to Linux v6.6-rc1 tag
3) Added cleanup patch for sorting SoC JTAG ID entries
4) Removed EEPROM board detect from evm.c and added am69 config fragments
5) Updated MAINTAINERS files and commit messages
6) Removed struct renaming in ti_k3_r5f_rproc driver

Link to v3:
https://lore.kernel.org/u-boot/20230908110551.861575-1-a-nandan@ti.com/

Changes in v3:
1) Added AM69 SK support in the series
2) Switched from distroboot to bootstd support
3) Added remoteproc support for J784S4
4) Added documentation for both SoCs
5) Added binman support
6) Removed unnecessarry nodes from r5-evm.dts and evm-u-boot.dtsi
7) Added HS device support
8) Added env file for environement variables
9) Removed ti-serdes-mux bindings
10) Cleaned up all files and synced with latest
11) Addressed all previous review comments

Note: The base dts files have been sync from next-20230905 linux tag as per review comment received
on previous re-roll:
https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/

Link to v2:
https://lore.kernel.org/u-boot/20230321141028.24456-1-hnagalla@ti.com/

Changes in v2:
- Refactored environement scripts to 'j784s4.env' and removed scripts not
  needed for basic board bootup.
- Imported the J7874S4 basic device tree files from v6.2 linux kernel.
- Moved j784s4 clock definitions and clock data into one patch/commit.
- coalesce board commits into one commit.

Apurva Nandan (10):
  arm: dts: Introduce j784s4 dts from linux kernel
  arm: mach-k3: Add basic support for J784S4 SoC definition
  arm: mach-k3: Sort SoC JTAG_ID entries
  soc: ti: k3-socinfo: Add entry for J784S4 SoC
  arm: mach-k3: j784s4: Add clk and power support
  drivers: dma: Add support for J784S4 SoC
  board: ti: j784s4: Add board support for J784S4 EVM
  arm: dts: Introduce j784s4 u-boot dts files
  configs: j784s4_evm: Add defconfig for j784s4 evm board
  doc: board: ti: k3: Add J784S4 EVM and AM69 SK documentation

Dasnavis Sabiya (4):
  arm: dts: Introduce am69-sk dts from linux kernel
  board: ti: j784s4: Update env to use am69-sk dtb
  arm: dts: Introduce am69-sk u-boot dts files
  configs: Add am69_sk_* defconfig fragments

Hari Nagalla (2):
  remoteproc: k3-r5: Extend support for R5F clusters on J784S4 SoCs
  remoteproc: k3-dsp: Extend support for C71x DSPs on J784S4 SoCs

 arch/arm/dts/Makefile                         |    4 +
 arch/arm/dts/k3-am69-r5-sk.dts                |  105 +
 arch/arm/dts/k3-am69-sk-u-boot.dtsi           |   48 +
 arch/arm/dts/k3-am69-sk.dts                   |  364 +
 arch/arm/dts/k3-j784s4-binman.dtsi            |  505 +
 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi  | 8757 ++++++++++++++++
 arch/arm/dts/k3-j784s4-ddr.dtsi               | 8858 +++++++++++++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |   25 +
 arch/arm/dts/k3-j784s4-evm.dts                |  864 ++
 arch/arm/dts/k3-j784s4-main.dtsi              | 1571 +++
 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi        |  703 ++
 arch/arm/dts/k3-j784s4-r5-evm.dts             |  105 +
 arch/arm/dts/k3-j784s4-thermal.dtsi           |  101 +
 arch/arm/dts/k3-j784s4.dtsi                   |  294 +
 arch/arm/mach-k3/Kconfig                      |   17 +-
 arch/arm/mach-k3/Makefile                     |    3 +
 arch/arm/mach-k3/arm64-mmu.c                  |   52 +
 arch/arm/mach-k3/include/mach/hardware.h      |   13 +-
 .../mach-k3/include/mach/j784s4_hardware.h    |   60 +
 arch/arm/mach-k3/include/mach/j784s4_spl.h    |   47 +
 arch/arm/mach-k3/include/mach/spl.h           |    4 +
 arch/arm/mach-k3/j784s4/Makefile              |    7 +
 arch/arm/mach-k3/j784s4/clk-data.c            |  428 +
 arch/arm/mach-k3/j784s4/dev-data.c            |   98 +
 arch/arm/mach-k3/j784s4_fdt.c                 |   15 +
 arch/arm/mach-k3/j784s4_init.c                |  332 +
 board/ti/j784s4/Kconfig                       |   63 +
 board/ti/j784s4/MAINTAINERS                   |   23 +
 board/ti/j784s4/Makefile                      |    7 +
 board/ti/j784s4/board-cfg.yaml                |   37 +
 board/ti/j784s4/evm.c                         |   82 +
 board/ti/j784s4/j784s4.env                    |   37 +
 board/ti/j784s4/pm-cfg.yaml                   |   13 +
 board/ti/j784s4/rm-cfg.yaml                   | 3058 ++++++
 board/ti/j784s4/sec-cfg.yaml                  |  380 +
 board/ti/j784s4/tifs-rm-cfg.yaml              | 2656 +++++
 configs/am69_sk_a72.config                    |    5 +
 configs/am69_sk_r5.config                     |    3 +
 configs/j784s4_evm_a72_defconfig              |  180 +
 configs/j784s4_evm_r5_defconfig               |  163 +
 doc/board/ti/j784s4_evm.rst                   |  339 +
 doc/board/ti/k3.rst                           |    1 +
 drivers/clk/ti/clk-k3.c                       |    6 +
 drivers/dma/ti/Makefile                       |    1 +
 drivers/dma/ti/k3-psil-j784s4.c               |  166 +
 drivers/dma/ti/k3-psil-priv.h                 |    1 +
 drivers/dma/ti/k3-psil.c                      |    2 +
 drivers/firmware/ti_sci_static_data.h         |   34 +
 drivers/power/domain/ti-power-domain.c        |    6 +
 drivers/ram/Kconfig                           |    2 +-
 drivers/remoteproc/ti_k3_dsp_rproc.c          |    4 +-
 drivers/remoteproc/ti_k3_r5f_rproc.c          |    2 +
 drivers/soc/soc_ti_k3.c                       |    3 +
 include/configs/j784s4_evm.h                  |   20 +
 include/k3-clk.h                              |    1 +
 include/k3-dev.h                              |    1 +
 56 files changed, 30663 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
 create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am69-sk.dts
 create mode 100644 arch/arm/dts/k3-j784s4-binman.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4-ddr.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4-evm.dts
 create mode 100644 arch/arm/dts/k3-j784s4-main.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4-r5-evm.dts
 create mode 100644 arch/arm/dts/k3-j784s4-thermal.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4.dtsi
 create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
 create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
 create mode 100644 arch/arm/mach-k3/j784s4/Makefile
 create mode 100644 arch/arm/mach-k3/j784s4/clk-data.c
 create mode 100644 arch/arm/mach-k3/j784s4/dev-data.c
 create mode 100644 arch/arm/mach-k3/j784s4_fdt.c
 create mode 100644 arch/arm/mach-k3/j784s4_init.c
 create mode 100644 board/ti/j784s4/Kconfig
 create mode 100644 board/ti/j784s4/MAINTAINERS
 create mode 100644 board/ti/j784s4/Makefile
 create mode 100644 board/ti/j784s4/board-cfg.yaml
 create mode 100644 board/ti/j784s4/evm.c
 create mode 100644 board/ti/j784s4/j784s4.env
 create mode 100644 board/ti/j784s4/pm-cfg.yaml
 create mode 100644 board/ti/j784s4/rm-cfg.yaml
 create mode 100644 board/ti/j784s4/sec-cfg.yaml
 create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
 create mode 100644 configs/am69_sk_a72.config
 create mode 100644 configs/am69_sk_r5.config
 create mode 100644 configs/j784s4_evm_a72_defconfig
 create mode 100644 configs/j784s4_evm_r5_defconfig
 create mode 100644 doc/board/ti/j784s4_evm.rst
 create mode 100644 drivers/dma/ti/k3-psil-j784s4.c
 create mode 100644 include/configs/j784s4_evm.h

-- 
2.34.1

