Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBA5CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128ED8840C;
	Thu,  4 Apr 2024 11:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pfgs4k4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F5F88413; Thu,  4 Apr 2024 11:00:53 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796B68646E
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490eWf126631;
 Thu, 4 Apr 2024 04:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221240;
 bh=9GEyYxg/ile3xz5pLL8r0sRVkS6JQtbe8Y5fsKe8qwc=;
 h=From:To:CC:Subject:Date;
 b=Pfgs4k4ih48RMjkTWeCWiwFAQbbZCWargi8UcwaShr3u4aF1EGvfCnTTnkq3w6eZF
 kty/Za2fJVMg8JPLzl1+/BFdEUMmvBTviXOlih6I+fJ6NgjSLdNSXpCcl2ADc9+4Ds
 b6+MfnsckgsZ13ermkRq69DzYSGkkWkN54D8OgCg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490eTp091238
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:40 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:40 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490dQf010568;
 Thu, 4 Apr 2024 04:00:40 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 00/15] Add basic U-Boot Support for J722S-EVM
Date: Thu, 4 Apr 2024 14:30:24 +0530
Message-ID: <20240404090039.87458-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
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

Hello there,

This series add the U-Boot support for our new platform of K3-SOC
family - J722S-EVM which is a superset of AM62P. It shares the same
memory map and thus the nodes are being reused from AM62P includes
instead of duplicating the definitions.

Some highlights of J722S SoC (in addition to AM62P SoC features) are:

- Two Cortex-R5F for Functional Safety or general-purpose usage and
  two C7x floating point vector DSP with Matrix Multiply Accelerator
  for deep learning.
  
- Vision Processing Accelerator (VPAC) with image signal processor
  and Depth and Motion Processing Accelerator (DMPAC).

- 7xUARTs, 3xSPI, 5xI2C, 2xUSB2, 2xCAN-FD, 3xMMC and SD, GPMC for
  NAND/FPGA connection, OSPI memory controller, 5xMcASP for audio,
  4xCSI-RX for Camera, 1 PCIe Gen3 controller, USB3.0 eCAP/eQEP,
  ePWM, among other peripherals.
  
TRM: <https://www.ti.com/lit/zip/sprujb3>
Schematics: <https://www.ti.com/lit/zip/sprr495>

Bootlog test:
<https://gist.github.com/Jayesh2000/3a662b380e64aaa227256dbbcef3fe0d>

NOTE: This series depends on the latest dts pull form upstream that will
add the dts changes for J722S-EVM. So the first patch adds the relavent
dts updates which is *NOT SUPPOSED TO BE MERGED*

Jayesh Choudhary (15):
  DO-NOT-MERGE: dts: upstream: src: Necessary pulls from upstream dts
  arm: mach-k3: Sort CONFIG_SOC* and K3_SOC_ID entries
  soc: ti: k3-socinfo: Fix SOC JTAG entry order
  soc: add info to identify the J722S SoC family
  clk: ti: clk-k3: use IS_ENABLED macro and fix the clock-data order
  power: domain: ti: Fix the order for platform data entries
  arm: mach-k3: r5: Makefile: Fix the order for entries
  arm: mach-k3: j722s: introduce clock and device files for wkup spl
  ram: k3-ddrss: Enable the am62ax's DDR controller for J722S
  arch: mach-k3: Introduce basic files to support J722S SoC family
  board: ti: Introduce basic board files for the J722S family
  firmware: ti_sci_static_data: Add static DMA channel
  arm: dts: Introduce J722S U-Boot dts files
  configs: introduce configs needed for the J722S
  doc: board: ti: Add J722S-EVM documentation

 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/k3-j722s-binman.dtsi             |  171 +
 arch/arm/dts/k3-j722s-ddr-lp4-50-3733.dtsi    | 2795 +++++++++++++++++
 arch/arm/dts/k3-j722s-evm-u-boot.dtsi         |   36 +
 arch/arm/dts/k3-j722s-r5-evm.dts              |   82 +
 arch/arm/mach-k3/Kconfig                      |    7 +-
 arch/arm/mach-k3/Makefile                     |    1 +
 arch/arm/mach-k3/include/mach/hardware.h      |   43 +-
 .../arm/mach-k3/include/mach/j722s_hardware.h |   83 +
 arch/arm/mach-k3/include/mach/j722s_spl.h     |   49 +
 arch/arm/mach-k3/include/mach/spl.h           |    4 +
 arch/arm/mach-k3/j722s/Kconfig                |   32 +
 arch/arm/mach-k3/j722s_init.c                 |  276 ++
 arch/arm/mach-k3/r5/Makefile                  |    7 +-
 arch/arm/mach-k3/r5/j722s/Makefile            |    6 +
 arch/arm/mach-k3/r5/j722s/clk-data.c          |  312 ++
 arch/arm/mach-k3/r5/j722s/dev-data.c          |   69 +
 board/ti/j722s/Kconfig                        |   26 +
 board/ti/j722s/MAINTAINERS                    |    9 +
 board/ti/j722s/Makefile                       |    7 +
 board/ti/j722s/board-cfg.yaml                 |   36 +
 board/ti/j722s/evm.c                          |   29 +
 board/ti/j722s/j722s.env                      |   15 +
 board/ti/j722s/pm-cfg.yaml                    |   12 +
 board/ti/j722s/rm-cfg.yaml                    | 1119 +++++++
 board/ti/j722s/sec-cfg.yaml                   |  379 +++
 board/ti/j722s/tifs-rm-cfg.yaml               |  981 ++++++
 configs/j722s_evm_a53_defconfig               |  177 ++
 configs/j722s_evm_r5_defconfig                |  137 +
 doc/board/ti/j722s_evm.rst                    |  262 ++
 doc/board/ti/k3.rst                           |    1 +
 drivers/clk/ti/clk-k3.c                       |   41 +-
 drivers/firmware/ti_sci_static_data.h         |    2 +-
 drivers/power/domain/ti-power-domain.c        |   36 +-
 drivers/ram/Kconfig                           |    2 +-
 drivers/soc/soc_ti_k3.c                       |   29 +-
 dts/upstream/Bindings/arm/ti/k3.yaml          |    6 +
 dts/upstream/src/arm64/ti/k3-j722s-evm.dts    |  383 +++
 dts/upstream/src/arm64/ti/k3-j722s.dtsi       |   89 +
 dts/upstream/src/arm64/ti/k3-pinctrl.h        |    3 +
 include/configs/j722s_evm.h                   |   14 +
 include/k3-clk.h                              |    1 +
 include/k3-dev.h                              |    1 +
 43 files changed, 7703 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/dts/k3-j722s-binman.dtsi
 create mode 100644 arch/arm/dts/k3-j722s-ddr-lp4-50-3733.dtsi
 create mode 100644 arch/arm/dts/k3-j722s-evm-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-j722s-r5-evm.dts
 create mode 100644 arch/arm/mach-k3/include/mach/j722s_hardware.h
 create mode 100644 arch/arm/mach-k3/include/mach/j722s_spl.h
 create mode 100644 arch/arm/mach-k3/j722s/Kconfig
 create mode 100644 arch/arm/mach-k3/j722s_init.c
 create mode 100644 arch/arm/mach-k3/r5/j722s/Makefile
 create mode 100644 arch/arm/mach-k3/r5/j722s/clk-data.c
 create mode 100644 arch/arm/mach-k3/r5/j722s/dev-data.c
 create mode 100644 board/ti/j722s/Kconfig
 create mode 100644 board/ti/j722s/MAINTAINERS
 create mode 100644 board/ti/j722s/Makefile
 create mode 100644 board/ti/j722s/board-cfg.yaml
 create mode 100644 board/ti/j722s/evm.c
 create mode 100644 board/ti/j722s/j722s.env
 create mode 100644 board/ti/j722s/pm-cfg.yaml
 create mode 100644 board/ti/j722s/rm-cfg.yaml
 create mode 100644 board/ti/j722s/sec-cfg.yaml
 create mode 100644 board/ti/j722s/tifs-rm-cfg.yaml
 create mode 100644 configs/j722s_evm_a53_defconfig
 create mode 100644 configs/j722s_evm_r5_defconfig
 create mode 100644 doc/board/ti/j722s_evm.rst
 create mode 100644 dts/upstream/src/arm64/ti/k3-j722s-evm.dts
 create mode 100644 dts/upstream/src/arm64/ti/k3-j722s.dtsi
 create mode 100644 include/configs/j722s_evm.h

-- 
2.25.1

