Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0807EE7FF3
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A83C86A2F;
	Fri,  8 Sep 2023 16:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="du+4rSrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40C2186410; Fri,  8 Sep 2023 13:06:15 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE2386A26
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B602L000607;
 Fri, 8 Sep 2023 06:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171160;
 bh=yWnLsyKSmnFQqHON5c8rltPNI57LcGfURPwWz76GI1U=;
 h=From:To:Subject:Date;
 b=du+4rSrnkSRecQNonSpwuuiyCc3hDutphfTO81hX68+gsXNXj6FyvwmmqgrU2F8iE
 Cl+rAopEgxyOdii10zkKsgypO5gSfWjVxq9hU8PUN3UoUh+qWnoAq9WjIrvSe/F1Iv
 7eYkdwwkM+25BHvotjNDdgqBqnzwgeK/FhN8/uwA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B60GM094043
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:06:00 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:05:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:05:59 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B5qED018063;
 Fri, 8 Sep 2023 06:05:52 -0500
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
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v3 00/16]Introduce initial TI's J784S4 and AM69 support
Date: Fri, 8 Sep 2023 16:35:35 +0530
Message-ID: <20230908110551.861575-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 16:01:41 +0200
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
* 3D GPU: Automotive grade IMG BXS-4-64
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

bootlog: https://paste.sr.ht/~hnagalla/f14840abc854519f912923662f1fdc8075d92107

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

Apurva Nandan (9):
  arm: dts: Introduce j784s4 dts from linux kernel
  arm: mach-k3: Add basic support for J784S4 SoC definition
  soc: ti: k3-socinfo: Add entry for J784S4 SoC
  arm: mach-k3: j784s4: Add clk and power support
  drivers: dma: Add support for J784S4 SoC
  board: ti: j784s4: Add board support for J784S4 EVM
  arm: dts: Introduce j784s4 u-boot dts files
  configs: j784s4_evm: Add defconfig for j784s4 evm and am69 sk
  doc: board: ti: k3: Add J784S4 EVM and AM69 SK documentation

Dasnavis Sabiya (5):
  arm: dts: Introduce am69-sk dts from linux kernel
  board: ti: j784s4: Add support for board detection by EEPROM read
  board: ti: j784s4: Update env to use am69-sk dtb
  arm: dts: Introduce am69-sk u-boot dts files
  arm: dts: k3-j784s4-binman: Add support for AM69 SK

Hari Nagalla (2):
  remoteproc: k3-r5: Extend support for R5F clusters on J784S4 SoCs
  remoteproc: k3-dsp: Extend support for C71x DSPs on J784S4 SoCs

 arch/arm/dts/Makefile                         |    4 +
 arch/arm/dts/k3-am69-r5-sk.dts                |  105 +
 arch/arm/dts/k3-am69-sk-u-boot.dtsi           |   25 +
 arch/arm/dts/k3-am69-sk.dts                   |  364 +
 arch/arm/dts/k3-j784s4-binman.dtsi            |  597 ++
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
 arch/arm/mach-k3/include/mach/hardware.h      |    5 +
 .../mach-k3/include/mach/j784s4_hardware.h    |   60 +
 arch/arm/mach-k3/include/mach/j784s4_spl.h    |   46 +
 arch/arm/mach-k3/include/mach/spl.h           |    6 +-
 arch/arm/mach-k3/j784s4/Makefile              |    5 +
 arch/arm/mach-k3/j784s4/clk-data.c            |  428 +
 arch/arm/mach-k3/j784s4/dev-data.c            |   98 +
 arch/arm/mach-k3/j784s4_fdt.c                 |   15 +
 arch/arm/mach-k3/j784s4_init.c                |  332 +
 board/ti/j784s4/Kconfig                       |   63 +
 board/ti/j784s4/MAINTAINERS                   |   21 +
 board/ti/j784s4/Makefile                      |    8 +
 board/ti/j784s4/board-cfg.yaml                |   36 +
 board/ti/j784s4/evm.c                         |  183 +
 board/ti/j784s4/j784s4.env                    |   37 +
 board/ti/j784s4/pm-cfg.yaml                   |   12 +
 board/ti/j784s4/rm-cfg.yaml                   | 3057 ++++++
 board/ti/j784s4/sec-cfg.yaml                  |  379 +
 board/ti/j784s4/tifs-rm-cfg.yaml              | 2655 +++++
 configs/j784s4_evm_a72_defconfig              |  181 +
 configs/j784s4_evm_r5_defconfig               |  164 +
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
 drivers/remoteproc/ti_k3_r5f_rproc.c          |    6 +-
 drivers/soc/soc_ti_k3.c                       |    3 +
 include/configs/j784s4_evm.h                  |   20 +
 include/k3-clk.h                              |    1 +
 include/k3-dev.h                              |    1 +
 54 files changed, 30817 insertions(+), 12 deletions(-)
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
 create mode 100644 configs/j784s4_evm_a72_defconfig
 create mode 100644 configs/j784s4_evm_r5_defconfig
 create mode 100644 doc/board/ti/j784s4_evm.rst
 create mode 100644 drivers/dma/ti/k3-psil-j784s4.c
 create mode 100644 include/configs/j784s4_evm.h

-- 
2.34.1

