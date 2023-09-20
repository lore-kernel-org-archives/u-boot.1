Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD5CE79D0
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A60E867D6;
	Wed, 20 Sep 2023 14:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A0F86A30; Wed, 20 Sep 2023 14:42:37 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id DB461867D6
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; d="scan'208";a="176658332"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 20 Sep 2023 21:42:31 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.83])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1ABE8433CFB6;
 Wed, 20 Sep 2023 21:42:28 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 00/16] Add support for the Renesas RZ/G2L SMARC EVK
Date: Wed, 20 Sep 2023 13:41:56 +0100
Message-Id: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

These patches add initial support for the RZ/G2L SMARC Evaluation board
kit (EVK), consisting of the RZ/G2L System-on-Module (SOM) based on the
R9A07G044L2 SoC, and a common SMARC carrier board. Support is included
for the CPG (clock & reset control module), PFC (pinctrl & gpio module),
SDHI (eMMC & SD card interfaces) & SCIF (serial port) modules. Enough
functionality is included to boot a modern Linux kernel from the eMMC or
SD card interfaces.

The first patch in the series is an updated version of a patch I've sent
previously [1]. It's included here as the later patch to enable RZ/G2L
SCIF support depends on it.

Further work will follow in time to add support for other interfaces on
the RZ/G2L (such as Ethernet) and other SoCs in the RZ/G2L family
(including the RZ/G2UL, RZ/G2LC, RZ/V2L & RZ/Five).

[1]: https://lore.kernel.org/all/20230822181025.339748-2-paul.barker.ct@bp.renesas.com/

Paul Barker (16):
  serial: sh: Fix compile error when lacking HSCIF support
  dt-bindings: Add RZ/G2L CPG bindings
  dt-bindings: Add RZ/G2L PFC bindings
  dt-bindings: Add RZ/G2L IRQC bindings
  arm: rmobile: Add basic RZ/G2L family support
  arm: rmobile: Add basic R9A07G044L SoC support
  clk: renesas: Add RZ/G2L CPG driver
  arm: rmobile: Restrict PINCTRL_PFC selection to R-Car gen3/gen4
  pinctrl: renesas: Add RZ/G2L PFC driver
  serial: sh: Add RZ/G2L SCIF support
  mmc: renesas-sdhi: Initialize module on RZ/G2L
  arm: rmobile: Include <asm/types.h> in header
  arm: rmobile: Add CPU detection for RZ/G2L
  arm: rmobile: Support RZ/G2L memory map
  arm: dts: Import RZ/G2L SMARC EVK device tree
  board: rzg2l: Add RZ/G2L SMARC EVK board

 arch/arm/dts/Makefile                         |    3 +
 arch/arm/dts/r9a07g044.dtsi                   | 1273 +++++++++++++++++
 arch/arm/dts/r9a07g044l2-smarc.dts            |   18 +
 arch/arm/dts/r9a07g044l2.dtsi                 |   13 +
 arch/arm/dts/rz-smarc-common.dtsi             |  183 +++
 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi     |  137 ++
 arch/arm/dts/rzg2l-smarc-som.dtsi             |  353 +++++
 arch/arm/dts/rzg2l-smarc.dtsi                 |  144 ++
 arch/arm/mach-rmobile/Kconfig                 |   19 +-
 arch/arm/mach-rmobile/Kconfig.rzg2l           |   32 +
 arch/arm/mach-rmobile/Makefile                |    5 +-
 arch/arm/mach-rmobile/cpu_info-rzg2l.c        |   63 +
 arch/arm/mach-rmobile/include/mach/rmobile.h  |    5 +
 arch/arm/mach-rmobile/include/mach/rzg2l.h    |   13 +
 arch/arm/mach-rmobile/memmap-rzg2l.c          |  115 ++
 board/renesas/rzg2l/Kconfig                   |   18 +
 board/renesas/rzg2l/MAINTAINERS               |    6 +
 board/renesas/rzg2l/Makefile                  |    4 +
 board/renesas/rzg2l/rzg2l.c                   |   76 +
 configs/renesas_rzg2l_smarc_defconfig         |   52 +
 drivers/clk/renesas/Kconfig                   |    9 +
 drivers/clk/renesas/Makefile                  |    2 +
 drivers/clk/renesas/r9a07g044-cpg.c           |  384 +++++
 drivers/clk/renesas/rzg2l-cpg.c               |  502 +++++++
 drivers/clk/renesas/rzg2l-cpg.h               |  318 ++++
 drivers/mmc/renesas-sdhi.c                    |   61 +
 drivers/pinctrl/renesas/Kconfig               |    9 +
 drivers/pinctrl/renesas/Makefile              |    1 +
 drivers/pinctrl/renesas/rzg2l-pfc.c           |  906 ++++++++++++
 drivers/serial/serial_sh.c                    |   34 +-
 drivers/serial/serial_sh.h                    |   19 +-
 include/configs/rzg2l-smarc.h                 |   14 +
 include/dt-bindings/clock/r9a07g044-cpg.h     |  220 +++
 .../interrupt-controller/irqc-rzg2l.h         |   25 +
 include/dt-bindings/pinctrl/rzg2l-pinctrl.h   |   23 +
 35 files changed, 5054 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/r9a07g044.dtsi
 create mode 100644 arch/arm/dts/r9a07g044l2-smarc.dts
 create mode 100644 arch/arm/dts/r9a07g044l2.dtsi
 create mode 100644 arch/arm/dts/rz-smarc-common.dtsi
 create mode 100644 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi
 create mode 100644 arch/arm/dts/rzg2l-smarc-som.dtsi
 create mode 100644 arch/arm/dts/rzg2l-smarc.dtsi
 create mode 100644 arch/arm/mach-rmobile/Kconfig.rzg2l
 create mode 100644 arch/arm/mach-rmobile/cpu_info-rzg2l.c
 create mode 100644 arch/arm/mach-rmobile/include/mach/rzg2l.h
 create mode 100644 arch/arm/mach-rmobile/memmap-rzg2l.c
 create mode 100644 board/renesas/rzg2l/Kconfig
 create mode 100644 board/renesas/rzg2l/MAINTAINERS
 create mode 100644 board/renesas/rzg2l/Makefile
 create mode 100644 board/renesas/rzg2l/rzg2l.c
 create mode 100644 configs/renesas_rzg2l_smarc_defconfig
 create mode 100644 drivers/clk/renesas/r9a07g044-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.h
 create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
 create mode 100644 include/configs/rzg2l-smarc.h
 create mode 100644 include/dt-bindings/clock/r9a07g044-cpg.h
 create mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h
 create mode 100644 include/dt-bindings/pinctrl/rzg2l-pinctrl.h


base-commit: b9b83a86f0e84e837191db120c279a9cc0e3434b
-- 
2.34.1

