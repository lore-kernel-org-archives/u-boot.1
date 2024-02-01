Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A48C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF2887C88;
	Thu,  1 Feb 2024 04:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M8mzNdI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF7B87CA5; Thu,  1 Feb 2024 04:06:52 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B6187CCF
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bwF078941;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=RTUcEUCU/3nDkDFX4h1aInyTq5Y7fzUGUn+QVVn2LWU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=M8mzNdI4hpi9jsrtW/8Ys2M7FDMWo1GL979ovICRC/DywepZ3bvLl8kDr0DeVLD6G
 sm1lyholad1wj+XsbYbUF7e8NAz6DVt1++uQt2FYVoQwNd5JpQfhI2Wydip9fUjcRp
 Gf9t8cZk6+PNpSckDLoihKZvuKA7/8uopNCh+eAE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136b2Y008927
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136bma043564;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 00/13] Introduce basic support for TI's AM62Px SoC family
Date: Wed, 31 Jan 2024 21:06:36 -0600
Message-ID: <20240201030634.1120963-17-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8749; i=bb@ti.com;
 h=from:subject; bh=Y7aZyG29trL6RWMFy3ayhMnNS3u+7DN14qfWipv3nVk=;
 b=owNCWmg5MUFZJlNZd7BP6wAAZ////v5/W/vr70vm/+R8//d2jjcq7+2V/1rb7Nq/mltb+9+wA
 RmzRD1BoAAAAAGgAAPUAAaGgAaAADQ00DJ6g9R6g0DRoNqaaeSABp6T9UbNKHJoANGRoGmhoaNG
 mgGJkNMEyAMQZGg00AAABowExDRkxMjRpoaBiYmJiDJNPUeo0xGR6mgyAyDR6QBtQBoxD1DQBoD
 QMhoDQ0NGQaAA0AZDRo9QNPUMh6gAgzhZKMpC01nKEbNv8CzlmcMgfAEhCISeGRLTVYeOAJG4BL
 xjoEzJkOUDxeaa2yryq1UPZBOucNXjTAU66IKneLL6i0kofTxxytEGbqyfWnYW0UHqZtiXOvUYE
 wHcLfUzOG4cP+/mygjaqMpedXYANhzwIxWObDEdoEi07ThzmdJC/u2vb8gJyhUCjJ2vjIN7oJ8m
 ilaqKFZGE2RfStHVpmPXjDfuCX583fyejrOKpVMY86yhZCLxfLsYX38COpPHtpSURFyhtkANKtQ
 BrykS/AMR+7wl3FlYIMDHW+v2zMKoT8HTKjTi9JFqwB0ov8RYcBlh8j+DhNrSdHGV4r2Dw4fGZL
 ud8RQvP/q/7QlFjECSfv6bwEHZFp9k4Q6xgWcWpmzzQLlx1XPGEhOUo7Ng0behChNcz8VLMJBAh
 PkR9oiu/xdyRThQkHewT+s=
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

Hello Again Everyone!

**Note:**  This series depends on the OF_UPSTREAM work from Sumit [0].
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

Changes from v1: [1]
 - squashed all clk and lpsc tree updates into a single commit
 - corrected SOC_K3_AM642 typo with DM firmware Kconfig option
 - updated RM configs and dma nodes to enable IP that need DMA
 - added the dtb targets to the dts/Makefile
 - rebased the series on top of v2024.01-rc1
 - switched to bootstd rather than use distro boot scripts.
 - enabled OF_UPSTREAM instead of using the arch/arm/dts directory

[0] https://lore.kernel.org/u-boot/20240110103547.719757-1-sumit.garg@linaro.org/
[1] https://lore.kernel.org/all/20231012230616.2101992-13-bb@ti.com/

Bryan Brattlof (11):
  soc: add info to identify the am62p SoC family
  power: domain: ti: use IS_ENABLED macro
  arm: mach-k3: am62px: introduce clock and device files for wkup spl
  ram: k3-ddrss: enable the am62ax's DDR controller for am62px
  arm: mach-k3: invert logic for split DM firmware config
  arch: mach-k3: introduce basic files to support the am62px SoC family
  board: ti: introduce basic board files for the am62px family
  arm: dts: introduce am62p5 uboot dts files
  Makefile: remove hardcoded device tree source directory
  configs: introduce configs needed for the am62px
  doc: board: ti: introduce am62px documentation

Hari Nagalla (1):
  firmware: ti_sci_static_data: add static DMA channel data

Vignesh Raghavendra (1):
  dma: ti: k3-udma: Add DMA PSIL mappings for AM62P and J722S

 Makefile                                      |   18 +-
 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi    | 2800 +++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi          |  173 +
 arch/arm/dts/k3-am62p5-r5-sk.dts              |  101 +
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         |   49 +
 arch/arm/mach-k3/Kconfig                      |    9 +-
 arch/arm/mach-k3/Makefile                     |    1 +
 arch/arm/mach-k3/am62p5_init.c                |  280 ++
 arch/arm/mach-k3/am62px/Kconfig               |   32 +
 .../arm/mach-k3/include/mach/am62p_hardware.h |   83 +
 arch/arm/mach-k3/include/mach/am62p_spl.h     |   49 +
 arch/arm/mach-k3/include/mach/hardware.h      |    6 +
 arch/arm/mach-k3/include/mach/spl.h           |    4 +
 arch/arm/mach-k3/r5/Makefile                  |    1 +
 arch/arm/mach-k3/r5/am62px/Makefile           |    6 +
 arch/arm/mach-k3/r5/am62px/clk-data.c         |  325 ++
 arch/arm/mach-k3/r5/am62px/dev-data.c         |   71 +
 board/ti/am62px/Kconfig                       |   26 +
 board/ti/am62px/MAINTAINERS                   |    9 +
 board/ti/am62px/Makefile                      |    7 +
 board/ti/am62px/am62px.env                    |   16 +
 board/ti/am62px/board-cfg.yaml                |   37 +
 board/ti/am62px/evm.c                         |   29 +
 board/ti/am62px/pm-cfg.yaml                   |   12 +
 board/ti/am62px/rm-cfg.yaml                   |  987 ++++++
 board/ti/am62px/sec-cfg.yaml                  |  378 +++
 board/ti/am62px/tifs-rm-cfg.yaml              |  879 ++++++
 configs/am62px_evm_a53_defconfig              |  178 ++
 configs/am62px_evm_r5_defconfig               |  137 +
 doc/board/ti/am62px_sk.rst                    |  289 ++
 doc/board/ti/k3.rst                           |    1 +
 drivers/clk/ti/clk-k3.c                       |    6 +
 drivers/dma/ti/Makefile                       |    2 +
 drivers/dma/ti/k3-psil-am62p.c                |  325 ++
 drivers/dma/ti/k3-psil-priv.h                 |    1 +
 drivers/dma/ti/k3-psil.c                      |    4 +
 drivers/firmware/ti_sci_static_data.h         |    5 +-
 drivers/power/domain/ti-power-domain.c        |   13 +-
 drivers/ram/Kconfig                           |    2 +-
 drivers/soc/soc_ti_k3.c                       |    3 +
 dts/arch/arm64/ti                             |    1 +
 include/configs/am62px_evm.h                  |   14 +
 include/k3-clk.h                              |    1 +
 include/k3-dev.h                              |    1 +
 scripts/Makefile.spl                          |   17 +-
 46 files changed, 7374 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
 create mode 100644 arch/arm/dts/k3-am62p-sk-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am62p5-r5-sk.dts
 create mode 100644 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
 create mode 100644 arch/arm/mach-k3/am62p5_init.c
 create mode 100644 arch/arm/mach-k3/am62px/Kconfig
 create mode 100644 arch/arm/mach-k3/include/mach/am62p_hardware.h
 create mode 100644 arch/arm/mach-k3/include/mach/am62p_spl.h
 create mode 100644 arch/arm/mach-k3/r5/am62px/Makefile
 create mode 100644 arch/arm/mach-k3/r5/am62px/clk-data.c
 create mode 100644 arch/arm/mach-k3/r5/am62px/dev-data.c
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
 create mode 100644 drivers/dma/ti/k3-psil-am62p.c
 create mode 120000 dts/arch/arm64/ti
 create mode 100644 include/configs/am62px_evm.h


base-commit: b6d8969bcb94321dfed1399f2eaa8768ba42caaa
prerequisite-patch-id: a2fa61937f80658611e0a2cdf88a11a6214b3645
prerequisite-patch-id: 1a31af706136646f62e98e88919802b1379feb39
prerequisite-patch-id: 54b40f9e042ef51755b4fb33ba6f8c4f6af9c17f
prerequisite-patch-id: d2199c72fa11aea6e478f5a846f8ad786b0afc38
prerequisite-patch-id: 00e954105cf966b9527bb6ea11373e3da2d4c26d
prerequisite-patch-id: bb58fb490183bfd836c492ec18590d9ec3b97457
prerequisite-patch-id: 99cb64427f3b8b401f32cd1d4cc68cd74aaa8733
prerequisite-patch-id: c461c9afad63446e824d00017c5faab7860de0e9
prerequisite-patch-id: fdc8c1c111e6329345f0b5c7609f2751e542d2fa
prerequisite-patch-id: e07cf9612f806d28af7628573d73fefdd4144e63
prerequisite-patch-id: 15ee392282a7e0d2b99bcf9cded71f965fc32a5b
prerequisite-patch-id: 91cdc33aa65dd1d205fb8fea5de2980fe2ab2f62
-- 
2.43.0

