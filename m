Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2609C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD9C87DEF;
	Mon, 26 Feb 2024 22:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="akHYv+kE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F9387A80; Mon, 26 Feb 2024 22:19:42 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897BC87F63
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJUCm069699;
 Mon, 26 Feb 2024 15:19:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708982370;
 bh=7obETOzIhaUXFfUOCPwZNsgi1V7fBGc7eMzKJSQsh5Q=;
 h=From:Subject:Date:To:CC;
 b=akHYv+kE+PiVW41mOr5vXK0I6IgTeWrAmOII73IFZtVIOoomwv8LO/LELjO1QVSlk
 WZVX1t7lqgnEM70PzPWZKS/X12cmVmTcn+Gj8Zkr0K9H54cFk/Hc+sWeQ+J38rtiBj
 TMbPFfyj6uJUVkG2ijN2mjGyyqLnBGIhkM81YzXA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QLJUog017553
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Feb 2024 15:19:30 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 15:19:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 15:19:29 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJTw8058297;
 Mon, 26 Feb 2024 15:19:29 -0600
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 00/13] Hello Again Everyone!
Date: Mon, 26 Feb 2024 15:19:06 -0600
Message-ID: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEoA3WUC/03MsQ6CMBCA4VchN3vk2kJRJt/DOLR4hRsKpCVKQ
 nh3GyfHb/j/AzIn4Qx9dUDit2RZ5gJzqWCY3DwyyqsYNOmGNLXootXrjh9ZMbF3WeYR2bWd7Sh
 wMzgo5Zo4yP67Pp7FIS0Rtymx+38pMmRNUyul6WYNqit6f9+kHpYI5/kFSaQV8JsAAAA=
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7036; i=bb@ti.com;
 h=from:subject:message-id; bh=J7jvvNwUWsaNo0m8hNPYm9ueeofhWcg4jsJZP7brnfE=;
 b=owNCWmg5MUFZJlNZ38ABaQAAaP///7/r1/v7fK3cL3/2H37+63c2Vt33+9ZH+//72z1t7/+wA
 RswHaRoDQGTTTQABkNDQA00GjQAaDQ00BkMgABoyNANDQA0BoxDamgyMhhMTNRBo0DQ0aaNNBkD
 E0DIGgaNGg9RpkAeoDJpoAGRo00aDQMIeoeoADQGgDQGmhiDIdBpkNGTQaZMjQDQNNMgxDRoGTQ
 MQA0NDQNDQaDQAaAYmmgANGTJkNMjQxBoMAgaV/YAGtSDQtQQeB6D0LriJmaP88mEQ8YwkdDyww
 QABKe54yfnGj8QaQQe4SvKeLiFLLUk+k+UuPVQU2GgRhmZ5sPAE9IkxkjmBbl3qT69H+3MUyaS0
 gYHybBEsxQbT9ei33bVjqD3WtwinqiTI5OUX8KjIO8zEIFP3OwGbuBBsgUoC1E5MN9vDP2gadsg
 OlF8CJaoFKUopHcglWBM25a4T1jytQWL+hclxJ58Fl+87QwCOXj2kMeVJnukV+aSHPv/L1EivH2
 A79BnsVfslObsbNrFOnoyKEdYEvGBD+4hIqR26sg3ATslpojKHF61qWPDGCprVjS7AgyPojZ2jP
 iW6FoxWR81zS4uq71xBAmXMzAIC58UPHyAz7Tq9iGakTLYAtwqkA/7DDrNmFs1/8N5NKIcFGwTQ
 IztFAgHAkQEhgnAX4TGf4u5IpwoSG/gALSA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

**Note:**  This series depends on the v6 OF_UPSTREAM work from Sumit[0].
Patch #11 was added to fix some Makefile.spl targets to allow SPL builds
to complete with the OF_UPSTREAM series.

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

Changes from v2: [2]
 - dropped the extra ARCH_K3 not needed for the K3_DM_FW option
 - removed the extra &main_pktdma and &main_bcdma nodes already
   present in the kernel dtbs
 - corrected a few patch fixup errors
 - rebased ontop op OF_UPSTREAM v5 [0]
 - %s/uboot/U-Boot/g

Changes from v1: [1]
 - squashed all clk and lpsc tree updates into a single commit
 - corrected SOC_K3_AM642 typo with DM firmware Kconfig option
 - updated RM configs and dma nodes to enable IP that need DMA
 - added the dtb targets to the dts/Makefile
 - rebased the series on top of v2024.01-rc1
 - switched to bootstd rather than use distro boot scripts.
 - enabled OF_UPSTREAM instead of using the arch/arm/dts directory

[0] https://lore.kernel.org/u-boot/20240222093607.3085545-1-sumit.garg@linaro.org/
[1] https://lore.kernel.org/all/20231012230616.2101992-13-bb@ti.com/
[2] https://lore.kernel.org/u-boot/20240201030634.1120963-17-bb@ti.com/

---
Bryan Brattlof (11):
      soc: add info to identify the am62p SoC family
      power: domain: ti: use IS_ENABLED macro
      arm: mach-k3: am62px: introduce clock and device files for wkup spl
      ram: k3-ddrss: enable the am62ax's DDR controller for am62px
      arm: mach-k3: invert logic for split DM firmware config
      arch: mach-k3: introduce basic files to support the am62px SoC family
      board: ti: introduce basic board files for the am62px family
      arm: dts: introduce am62p5 U-Boot dts files
      Makefile: remove hardcoded device tree source directory
      configs: introduce configs needed for the am62px
      doc: board: ti: introduce am62px documentation

Hari Nagalla (1):
      firmware: ti_sci_static_data: add static DMA channel data

Vignesh Raghavendra (1):
      dma: ti: k3-udma: Add DMA PSIL mappings for AM62P and J722S

 Makefile                                       |   18 +-
 arch/arm/dts/Makefile                          |    2 +
 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi     | 2800 ++++++++++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi           |  173 ++
 arch/arm/dts/k3-am62p5-r5-sk.dts               |  101 +
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi          |   23 +
 arch/arm/mach-k3/Kconfig                       |    9 +-
 arch/arm/mach-k3/Makefile                      |    1 +
 arch/arm/mach-k3/am62p5_init.c                 |  280 +++
 arch/arm/mach-k3/am62px/Kconfig                |   32 +
 arch/arm/mach-k3/include/mach/am62p_hardware.h |   83 +
 arch/arm/mach-k3/include/mach/am62p_spl.h      |   49 +
 arch/arm/mach-k3/include/mach/hardware.h       |    6 +
 arch/arm/mach-k3/include/mach/spl.h            |    4 +
 arch/arm/mach-k3/r5/Makefile                   |    1 +
 arch/arm/mach-k3/r5/am62px/Makefile            |    6 +
 arch/arm/mach-k3/r5/am62px/clk-data.c          |  325 +++
 arch/arm/mach-k3/r5/am62px/dev-data.c          |   71 +
 board/ti/am62px/Kconfig                        |   26 +
 board/ti/am62px/MAINTAINERS                    |    9 +
 board/ti/am62px/Makefile                       |    7 +
 board/ti/am62px/am62px.env                     |   15 +
 board/ti/am62px/board-cfg.yaml                 |   37 +
 board/ti/am62px/evm.c                          |   29 +
 board/ti/am62px/pm-cfg.yaml                    |   12 +
 board/ti/am62px/rm-cfg.yaml                    |  987 +++++++++
 board/ti/am62px/sec-cfg.yaml                   |  378 ++++
 board/ti/am62px/tifs-rm-cfg.yaml               |  879 ++++++++
 configs/am62px_evm_a53_defconfig               |  178 ++
 configs/am62px_evm_r5_defconfig                |  137 ++
 doc/board/ti/am62px_sk.rst                     |  289 +++
 doc/board/ti/k3.rst                            |    1 +
 drivers/clk/ti/clk-k3.c                        |    6 +
 drivers/dma/ti/Makefile                        |    2 +
 drivers/dma/ti/k3-psil-am62p.c                 |  325 +++
 drivers/dma/ti/k3-psil-priv.h                  |    1 +
 drivers/dma/ti/k3-psil.c                       |    4 +
 drivers/firmware/ti_sci_static_data.h          |    5 +-
 drivers/power/domain/ti-power-domain.c         |   13 +-
 drivers/ram/Kconfig                            |    2 +-
 drivers/soc/soc_ti_k3.c                        |    3 +
 include/configs/am62px_evm.h                   |   14 +
 include/k3-clk.h                               |    1 +
 include/k3-dev.h                               |    1 +
 scripts/Makefile.spl                           |   17 +-
 45 files changed, 7346 insertions(+), 16 deletions(-)
---
base-commit: 4569d5acd1e59e333d07321eb4975e3cdaa6ae92
change-id: 20240205-am62px-wip-rebasing-ea57670fe4ca

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

