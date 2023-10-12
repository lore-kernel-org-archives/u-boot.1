Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A5CCDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E602686EBF;
	Fri, 13 Oct 2023 01:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FJ/cVmv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2653186AE6; Fri, 13 Oct 2023 01:08:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E5686E69
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6JTv067497;
 Thu, 12 Oct 2023 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697151979;
 bh=D0LWDTj+o+UiWhITqN6FPfpf22en7kFukPzVR7RATG8=;
 h=From:To:CC:Subject:Date;
 b=FJ/cVmv2IjxVnd3iXnxEAVl1/zUYxi//Cv7Avi/bQ+vdjAEucntG6yifAG8KeqaOM
 Yu/eEUM9vkm3OGhBb5pQ+lAf9OMMevvEa51M2PzxS5tqV7f7rugVuT7EPKYUmXP4Fx
 SJbwU6cYcoM2SjjJqYbzeYXpX3f/kHVktepebJ2A=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39CN6JG8020811
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 18:06:19 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 18:06:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 18:06:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6Ijs032136;
 Thu, 12 Oct 2023 18:06:18 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 00/11] Introduce basic support for TI's AM62Px SoC family
Date: Thu, 12 Oct 2023 18:06:17 -0500
Message-ID: <20231012230616.2101992-13-bb@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7082; i=bb@ti.com;
 h=from:subject; bh=HD4eC21h0XKMax1QhGeYQlxIXJjLaCw1ra2l0Oafvj8=;
 b=owNCWmg5MUFZJlNZCHOrXAAAZP///r/vs//+/seWfD8nN6/P9Yv/fa3zv8+vy/nNnZ7mj/ywA
 RtgIeoA0aADEAAyAAAaGjQNAaDQYgeoGgaA0B6QaG0g0B6g0aHpG1GjI0PJihyDTQ00aAyMQ0AG
 hkxoEeoGgAZDQaBpiNGmAJgIBoAaA0BggAPU0ACGh6QGQBkyYhoA0xMmJkYhoaAADRiYjCMQDBA
 A0ZDRhAZMIGgMgAYAA5j7WNjE4AXGrwkp7k00VPxzH7kZeSiAfmr7ATHPq7+C1/mXHnbmRQQRFQ
 B6AqtFbgLLUYFHkO/Bb4R1GvAcowR1UDQdTvJDO3tyEEDhoSJQzybmRqoTou2ZGGHnzKbrupuFz
 Qa35QPxglPEnJMIdciUMtMVnR12kMzScUxvMl+fHztealjgp9OiVLY32JmloWQy6YTyNB1SdiWm
 PX+05JA2C9VEA89hsWU4OQIHzJaIeRgQfp2R2akrl6lYj13BqJNhHPWsfb0y68sBxoL1Y9O4cLb
 ZlcAEKhhs+F72sN7rPgQx51DxAXYzYU91oRaNG0E2W5gn1VfPwirXk6W+mWv45vNO4NgUKsYB++
 4WiBBaHWs2Ozh3AB+IJNl7p3nKMkPAb3flaVwlpAiUCEjOceG19ELSMgBdgwia8KN7JSzDuiSi/
 8XckU4UJAIc6tcA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

The AM62Px is an extension of the existing Sitara AM62x low-cost family
of application processors built for Automotive and Linux Application
development. Scalable Arm Cortex-A53 performance and embedded features,
such as: multi high-definition display support, 3D-graphics
acceleration, 4K video acceleration, and extensive peripherals make the
AM62Px well-suited for a broad range of automation and industrial
application, including automotive digital instrumentation, automotive
displays, industrial HMI, and more.

Some highlights of AM62P SoC are:

* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
  Dual/Single core variants are provided in the same package to allow HW
  compatible designs.

* One Device manager Cortex-R5F for system power and resource
  management, and one Cortex-R5F for Functional Safety or
  general-purpose usage.

* One 3D GPU up to 50 GLFOPS

* H.264/H.265 Video Encode/Decode.

* Display support: 3x display support over OLDI/LVDS (1x OLDI-DL, 1x or
  2x OLDI-SL), DSI, or DPI. Up to 3840x1080 @ 60fps resolution

* Integrated Giga-bit Ethernet switch supporting up to a total of two
  external ports (TSN capable).

* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3xMMC and SD, GPMC for
  NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
  1xCSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.

* Dedicated Centralized Hardware Security Module with support for secure
  boot, debug security and crypto acceleration and trusted execution
  environment.

* One 32-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.

* Multiple low power modes support, ex: Deep sleep, Standby, MCU-only,
  enabling battery powered system design.

For those interested, more details about this SoC can be found in the
Technical Reference Manual here: https://www.ti.com/lit/pdf/spruj83

Proof-of-Life: https://paste.sr.ht/~bryanb/af2ac108a9362549aa326f182e87918d52bf2d71

Currently, while more peripherals are being added in Linux[0], this
series will only support UART boot.

Thanks for reviewing!
~Bryan

[0] https://lore.kernel.org/lkml/20231010035903.520635-4-bb@ti.com/

Bryan Brattlof (10):
  soc: add info to identify the am62p SoC family
  arm: mach-k3: am62px: introduce clock and device files for wkup spl
  ram: k3-ddrss: enable the am62ax's DDR controller for am62px
  arm: mach-k3: invert logic for split DM firmware config
  arch: mach-k3: introduce basic files to support the am62px SoC family
  board: ti: introduce basic board files for the am62px family
  arm: dts: add am62p5 dtbs from linux
  arm: dts: introduce am62p5 uboot dts files
  configs: introduce configs needed for the am62px
  doc: board: ti: introduce am62px documentation

Hari Nagalla (1):
  firmware: ti_sci_static_data: add static DMA channel data

 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi    | 2798 +++++++++++++++++
 arch/arm/dts/k3-am62p-main.dtsi               |  136 +
 arch/arm/dts/k3-am62p-mcu.dtsi                |   15 +
 arch/arm/dts/k3-am62p-sk-binman.dtsi          |  425 +++
 arch/arm/dts/k3-am62p-wakeup.dtsi             |   32 +
 arch/arm/dts/k3-am62p.dtsi                    |  122 +
 arch/arm/dts/k3-am62p5-r5-sk.dts              |   88 +
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         |   14 +
 arch/arm/dts/k3-am62p5-sk.dts                 |  116 +
 arch/arm/dts/k3-am62p5.dtsi                   |  107 +
 arch/arm/mach-k3/Kconfig                      |    9 +-
 arch/arm/mach-k3/Makefile                     |    2 +
 arch/arm/mach-k3/am62p5_init.c                |  261 ++
 arch/arm/mach-k3/am62px/Makefile              |    6 +
 arch/arm/mach-k3/am62px/clk-data.c            |  325 ++
 arch/arm/mach-k3/am62px/dev-data.c            |   71 +
 arch/arm/mach-k3/arm64-mmu.c                  |    5 +-
 .../arm/mach-k3/include/mach/am62p_hardware.h |   83 +
 arch/arm/mach-k3/include/mach/am62p_spl.h     |   49 +
 arch/arm/mach-k3/include/mach/hardware.h      |    6 +
 arch/arm/mach-k3/include/mach/spl.h           |    4 +
 board/ti/am62px/Kconfig                       |   52 +
 board/ti/am62px/MAINTAINERS                   |    9 +
 board/ti/am62px/Makefile                      |    7 +
 board/ti/am62px/am62px.env                    |   18 +
 board/ti/am62px/board-cfg.yaml                |   37 +
 board/ti/am62px/evm.c                         |   30 +
 board/ti/am62px/pm-cfg.yaml                   |   12 +
 board/ti/am62px/rm-cfg.yaml                   | 1150 +++++++
 board/ti/am62px/sec-cfg.yaml                  |  378 +++
 board/ti/am62px/tifs-rm-cfg.yaml              | 1010 ++++++
 configs/am62px_evm_a53_defconfig              |  176 ++
 configs/am62px_evm_r5_defconfig               |  137 +
 doc/board/ti/am62px_sk.rst                    |  289 ++
 doc/board/ti/k3.rst                           |    1 +
 drivers/clk/ti/clk-k3.c                       |    6 +
 drivers/firmware/ti_sci_static_data.h         |    5 +-
 drivers/power/domain/ti-power-domain.c        |    6 +
 drivers/ram/Kconfig                           |    2 +-
 drivers/soc/soc_ti_k3.c                       |    3 +
 include/configs/am62px_evm.h                  |   18 +
 include/k3-clk.h                              |    1 +
 include/k3-dev.h                              |    1 +
 43 files changed, 8015 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
 create mode 100644 arch/arm/dts/k3-am62p-main.dtsi
 create mode 100644 arch/arm/dts/k3-am62p-mcu.dtsi
 create mode 100644 arch/arm/dts/k3-am62p-sk-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am62p-wakeup.dtsi
 create mode 100644 arch/arm/dts/k3-am62p.dtsi
 create mode 100644 arch/arm/dts/k3-am62p5-r5-sk.dts
 create mode 100644 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62p5-sk.dts
 create mode 100644 arch/arm/dts/k3-am62p5.dtsi
 create mode 100644 arch/arm/mach-k3/am62p5_init.c
 create mode 100644 arch/arm/mach-k3/am62px/Makefile
 create mode 100644 arch/arm/mach-k3/am62px/clk-data.c
 create mode 100644 arch/arm/mach-k3/am62px/dev-data.c
 create mode 100644 arch/arm/mach-k3/include/mach/am62p_hardware.h
 create mode 100644 arch/arm/mach-k3/include/mach/am62p_spl.h
 create mode 100644 board/ti/am62px/Kconfig
 create mode 100644 board/ti/am62px/MAINTAINERS
 create mode 100644 board/ti/am62px/Makefile
 create mode 100644 board/ti/am62px/am62px.env
 create mode 100644 board/ti/am62px/board-cfg.yaml
 create mode 100644 board/ti/am62px/evm.c
 create mode 100644 board/ti/am62px/pm-cfg.yaml
 create mode 100644 board/ti/am62px/rm-cfg.yaml
 create mode 100644 board/ti/am62px/sec-cfg.yaml
 create mode 100644 board/ti/am62px/tifs-rm-cfg.yaml
 create mode 100644 configs/am62px_evm_a53_defconfig
 create mode 100644 configs/am62px_evm_r5_defconfig
 create mode 100644 doc/board/ti/am62px_sk.rst
 create mode 100644 include/configs/am62px_evm.h


base-commit: 86700279645921fb2c28c41711deb7d7ed75bc29
-- 
2.42.0

