Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCB4C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7DC86FCE;
	Tue, 12 Mar 2024 21:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k2UmwXdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DD2C87F30; Tue, 12 Mar 2024 21:20:47 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BBB87F6A
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKStQ088764;
 Tue, 12 Mar 2024 15:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=PcI4cXXqFl2ibbjz7eLYoie8rOzcNSYT+lDbUTNFYl8=;
 h=From:Subject:Date:To:CC;
 b=k2UmwXdd1Vj1annQF+xatUbUN+FgJ2Kz1ZBpkkz4nIssJpf+Hl51/WRni+fFd4G+G
 s1kH0ai30NFkL6dRQemI7vNJvD6TwYkKHHIfEwXELNIhd+bDvVSvQpoKBAG+s5BMwF
 bx2YuN5wwkRZjNVhRkvZ280jiJ5AC4pKKM9Xf7vM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKSlA027340
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:28 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:28 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKSaf091669;
 Tue, 12 Mar 2024 15:20:28 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v4 00/13] Introduce basic support for TI's AM62Px SoC
 family
Date: Tue, 12 Mar 2024 15:20:18 -0500
Message-ID: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAK58GUC/33Oyw6CMBCF4VcxXTtkeqGoK9/DsGhxCrPgkpYgh
 vDuAomJK5f/4nw5i0gUmZK4nRYRaeLEfbeFOZ9E1biuJuDn1kKhMqgwB9daNczw4gEieZe4q4F
 cXtgCA5nKiW05RAo8H+qj3DrEvoWxieR+LYkarTaZlAqvVoO8gPf3kbOqb3el4TT28X1cm/Ru/
 X8xaUBAU3lvFDlnw9cq13X9AI3pw6HpAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7272; i=bb@ti.com;
 h=from:subject:message-id; bh=W+NT8eDVOrpvxWOyOTNzfwC10p71a9xBTPUuY/oObFA=;
 b=owNCWmg5MUFZJlNZDaKVvQAAaH/////5d3f33Pr779OxM6NfXmv7/61i7mupbz7/3f/v0H2wA
 RmYHeqD1AAAAAaADQADQNGgAAaZAaAAA00GgNA0eoGgADQ9Eep6mT9UzU/RRAGgMgNGjIPU0A0Y
 gyNNMQaGhoaABowgBhGgwg2oNqYINAaNMmmINGjEAMZTR6mgxHqZGTRpkGhoGQZMaRoAGQGgAGT
 RkwE0YTIGgANGmgBkGQAAGQBBAhxyEUJcJcSEOjTVEFoD9S/dhwRspMC/ZuXByBpIgAE7AiRGPG
 caVk+EM5e1/KYun7oA25xRIVgO348gKzIOo3g06FASKMrbN1jVOG+wIZm44G9or66pf9/G95CDZ
 J9ZXzOJS867zZDeqP3XwO+Eu+SXSszjj+8PW6nuQYgC/PRnAo1pDOFbhZhMQXaekW5RQDxPqn7E
 IalbgxFe1P4Aj7Ap4ptwcTdtyqwzR3YnbBr/Raeg5iPW/WDlzXROfxk/ALVY2mi0HpXcDZsdfbM
 sIST38yE+CplEe2YA76NDiwQslK3dQlBYB4qg4erWKf9dy7DwiyutLVZDeUu9uBpWUAlyBn1yRd
 QRwZaY1AmByEpUh75XhVfUjXwK8QEbh3jOjJ9Ci3IgyeKusLOYlvGoWWZx1go86cNJAOaRJKlDU
 ohSP8XckU4UJANopW9A
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

Hello Again Everyone!

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

Thanks for reviewing!
~Bryan

Changes from v3: [2]
 - rebased on current -next
 - moved remove_fwl_configs() inside the 'has rom loaded the sysfw' 
   check to avoid removing the firewalls when the A53 SPL is executed.
 - added the TFA address for the AM62Px to the ATF_LOAD_ADDR Kconfig
 - fixed formatting issues with clk and dev auto-generated files

 Changes from v2: [1]
 - dropped the extra ARCH_K3 not needed for the K3_DM_FW option
 - removed the extra &main_pktdma and &main_bcdma nodes already
   present in the kernel dtbs
 - corrected a few patch fixup errors
 - rebased ontop op OF_UPSTREAM v5 [0]
 - %s/uboot/U-Boot/g

Changes from v1: [0]
 - squashed all clk and lpsc tree updates into a single commit
 - corrected SOC_K3_AM642 typo with DM firmware Kconfig option
 - updated RM configs and dma nodes to enable IP that need DMA
 - added the dtb targets to the dts/Makefile
 - rebased the series on top of v2024.01-rc1
 - switched to bootstd rather than use distro boot scripts.
 - enabled OF_UPSTREAM instead of using the arch/arm/dts directory

[0] https://lore.kernel.org/all/20231012230616.2101992-13-bb@ti.com/
[1] https://lore.kernel.org/u-boot/20240201030634.1120963-17-bb@ti.com/
[2] https://lore.kernel.org/u-boot/20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com/

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
      configs: introduce configs needed for the am62px
      doc: board: ti: introduce am62px documentation
      arm: mach-k3: fixup whitespace in SPDX License IDs

Hari Nagalla (1):
      firmware: ti_sci_static_data: add static DMA channel data

Vignesh Raghavendra (1):
      dma: ti: k3-udma: Add DMA PSIL mappings for AM62P and J722S

 arch/arm/dts/Makefile                          |    2 +
 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi     | 2800 ++++++++++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi           |  173 ++
 arch/arm/dts/k3-am62p5-r5-sk.dts               |  101 +
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi          |   23 +
 arch/arm/mach-k3/Kconfig                       |    9 +-
 arch/arm/mach-k3/Makefile                      |    1 +
 arch/arm/mach-k3/am62p5_init.c                 |  281 +++
 arch/arm/mach-k3/am62px/Kconfig                |   32 +
 arch/arm/mach-k3/include/mach/am62p_hardware.h |   83 +
 arch/arm/mach-k3/include/mach/am62p_spl.h      |   49 +
 arch/arm/mach-k3/include/mach/hardware.h       |    6 +
 arch/arm/mach-k3/include/mach/spl.h            |    4 +
 arch/arm/mach-k3/r5/Makefile                   |    1 +
 arch/arm/mach-k3/r5/am62ax/Makefile            |    2 +-
 arch/arm/mach-k3/r5/am62px/Makefile            |    6 +
 arch/arm/mach-k3/r5/am62px/clk-data.c          |  325 +++
 arch/arm/mach-k3/r5/am62px/dev-data.c          |   71 +
 arch/arm/mach-k3/r5/am62x/Makefile             |    2 +-
 arch/arm/mach-k3/r5/j7200/Makefile             |    2 +-
 arch/arm/mach-k3/r5/j721e/Makefile             |    2 +-
 arch/arm/mach-k3/r5/j721s2/Makefile            |    2 +-
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
 configs/am62px_evm_a53_defconfig               |  177 ++
 configs/am62px_evm_r5_defconfig                |  137 ++
 doc/board/ti/am62px_sk.rst                     |  289 +++
 doc/board/ti/k3.rst                            |    1 +
 drivers/clk/ti/clk-k3.c                        |    6 +
 drivers/dma/ti/Makefile                        |    2 +
 drivers/dma/ti/k3-psil-am62p.c                 |  325 +++
 drivers/dma/ti/k3-psil-priv.h                  |    1 +
 drivers/dma/ti/k3-psil.c                       |    4 +
 drivers/firmware/ti_sci_static_data.h          |    5 +-
 drivers/power/domain/ti-power-domain.c         |   15 +-
 drivers/ram/Kconfig                            |    2 +-
 drivers/soc/soc_ti_k3.c                        |    3 +
 include/configs/am62px_evm.h                   |   14 +
 include/k3-clk.h                               |    1 +
 include/k3-dev.h                               |    1 +
 48 files changed, 7325 insertions(+), 14 deletions(-)
---
base-commit: 20a0ce574d6642e0dfe651467159039fac48cc4f
change-id: 20240205-am62px-wip-rebasing-ea57670fe4ca

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

