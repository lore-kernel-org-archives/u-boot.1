Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ED6C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7A336088C;
	Tue, 21 Jul 2026 15:55:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jz-mB4SNX2tk; Tue, 21 Jul 2026 15:55:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CA746086B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649350;
	bh=RduhReR6wnWMfPesYQ6R516Q/n5Tx2qXA0muaA1jMMA=;
	h=Date:To:CC:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=cW9vRMxVi0dTMIlHvBMhU76fTaKHF0EyJEovOVgzN27KjPDHa5j2nDzoWxa5XUej1
	 QAFIUgSjX3HmAuBhqn8rPlr85kIvEls9MhcpBPt7KG5sjP2oFbqwwNFsHB5lExlnvA
	 zTxJ99rcSdAnSogBlVBBdoaBAjDmSvbi7teIgdtAbsE0awVZzDCHFHIF2/N09XSxKx
	 n5iy5C09gxuCLooCay1biFUAT0mfGlWnM+Cl0YW1SHwsvejN/h8SSorted/3okKHNC
	 756vg/yAZHjW7mNOGP7UOost7/ks8epie7rDseoysmPIxv4i4teoTmKvFNNHQwV5pS
	 DMZT2zOtCFP4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CA746086B;
	Tue, 21 Jul 2026 15:55:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B0B67109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A228F80D09
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wduwOroKXzpZ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:26:01 +0000 (UTC)
X-Greylist: delayed 2078 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 15:25:58 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A804F80B49
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A804F80B49
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=tim609@andestech.com;
 receiver=<UNKNOWN> 
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A804F80B49
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:25:57 +0000 (UTC)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 66LEpXW7024915
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 22:51:33 +0800 (+08)
 (envelope-from tim609@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 66LEoiKN024551
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 21 Jul 2026 22:50:44 +0800 (+08)
 (envelope-from tim609@andestech.com)
Received: from swlinux01 (10.0.15.55) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jul
 2026 22:50:44 +0800
Date: Tue, 21 Jul 2026 22:50:37 +0800
To: <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, <guodong@riscstar.com>,
 <raymond.mao@riscstar.com>, <tanmay.kathpalia@altera.com>,
 <junhui.liu@pigmoral.tech>, <peng.fan@nxp.com>, <leo.liang@sifive.com>,
 <sszhang@vsit.ai>, <oyst.lnx@gmail.com>
Subject: [GIT PULL] Please pull riscv-for-v2026.10-rc1
Message-ID: <jf3kajqvl7zz3xgrhxsmwlki6el6udc3r5drlzuylfrxj4g4u3@uhy5mr6b2cd7>
User-Agent: Mutt/2.2.12 (2023-09-09)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.15.55]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 66LEpXW7024915
X-Mailman-Approved-At: Tue, 21 Jul 2026 15:55:46 +0000
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=andestech.com
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tim Ouyang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tim Ouyang <tim609@andestech.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

This is my first RISC‑V PR. It adds support for the SpacemiT K1 and
updates the MAINTAINERS.

CI result:
https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines/676

Thanks,
Tim Ouyang

The following changes since commit 042e45e026c77227319a426940577856ffe62e7b:

  global: Switch from source.denx.de to git.u-boot-project.org (2026-07-20 11:13:21 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git tags/riscv-for-v2026.10-rc1

for you to fetch changes up to 0926356edd68e180bbb214f0bb277037d9415129:

  MAINTAINERS: update RISC-V maintainers (2026-07-21 17:47:52 +0800)

----------------------------------------------------------------
Guodong Xu (12):
      reset: spacemit: k1: introduce syscon-bound reset driver
      clk: spacemit: k1: spawn reset device from per-syscon clock drivers
      configs: bananapi-f3: enable Spacemit K1 clock driver
      dts: k1: switch BPI-F3 build to upstream DT
      dts: k1: drop legacy local DT files
      reset: spacemit: k1: drop legacy spacemit,k1-reset driver
      dt-bindings: reset: drop spacemit-k1-reset.h
      clk: spacemit: k1: prune SPL clock tree
      doc: spacemit: add K1 SPL build and test guide
      spl: k1: enable SPI NOR flash detection and boot
      spacemit: k1: Add multiple device tree support
      configs: k1: enable pinctrl and gpio

Junhui Liu (1):
      clk: spacemit: Add support for K1 SoC

Raymond Mao (18):
      spacemit: k1: support multi-board infrastructure
      spacemit: k1: enable SPL with debug UART
      configs: k1: enable early timer support
      configs: k1: add default option for clock driver in SPL
      dts: k1: enable clocks in SPL
      board: k1: initialize clock and serial devices in SPL
      i2c: k1: add I2C driver support
      spacemit: k1: add TLV EEPROM support in SPL
      spacemit: k1: Add DDR firmware support to SPL
      power: pmic: add support for Spacemit P1 PMIC
      power: regulator: add support for Spacemit P1 SoC
      board: k1: enable pmic in spl
      mtd: spi: select SPL_SPI_FLASH_TINY in SPL stage
      mtd: spi: enable spi_nor_remove() in soft reset config
      spi: fsl: add support for Spacemit K1 SoC
      riscv: binman: Always set default configuration in FIT image
      pinctrl: add pinctrl driver for Spacemit K1 SoC
      gpio: add gpio driver for Spacemit K1 SoC

Tim Ouyang (1):
      MAINTAINERS: update RISC-V maintainers

 MAINTAINERS                                     |    4 +-
 arch/riscv/Kconfig                              |    8 +-
 arch/riscv/cpu/k1/Kconfig                       |    6 +
 arch/riscv/dts/Makefile                         |    1 -
 arch/riscv/dts/binman.dtsi                      |    2 -
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi       |  113 +++++++++++
 arch/riscv/dts/k1-bananapi-f3.dts               |   28 ---
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi        |  273 ++++++++++++++++++++++++++
 arch/riscv/dts/k1-pinctrl.dtsi                  |   19 --
 arch/riscv/dts/k1.dtsi                          |  480 ----------------------------------------------
 board/spacemit/bananapi-f3/MAINTAINERS          |    6 -
 board/spacemit/bananapi-f3/Makefile             |    5 -
 board/spacemit/{bananapi-f3 => k1}/Kconfig      |    6 +-
 board/spacemit/k1/MAINTAINERS                   |   14 ++
 board/spacemit/k1/Makefile                      |   28 +++
 board/spacemit/{bananapi-f3 => k1}/board.c      |    0
 board/spacemit/k1/spl.c                         |  391 ++++++++++++++++++++++++++++++++++++++
 board/spacemit/k1/tlv_codes.h                   |   22 +++
 configs/bananapi-f3_defconfig                   |   24 ---
 configs/spacemit_k1_defconfig                   |   95 ++++++++++
 doc/board/spacemit/bananapi-f3.rst              |    2 +-
 doc/board/spacemit/index.rst                    |    1 +
 doc/board/spacemit/k1-spl.rst                   |  243 ++++++++++++++++++++++++
 drivers/clk/Kconfig                             |    5 +-
 drivers/clk/Makefile                            |    1 +
 drivers/clk/spacemit/Kconfig                    |   23 +++
 drivers/clk/spacemit/Makefile                   |    7 +
 drivers/clk/spacemit/clk-k1.c                   | 1878 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/spacemit/clk_common.h               |   79 ++++++++
 drivers/clk/spacemit/clk_ddn.c                  |   93 +++++++++
 drivers/clk/spacemit/clk_ddn.h                  |   53 ++++++
 drivers/clk/spacemit/clk_mix.c                  |  403 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/spacemit/clk_mix.h                  |  224 ++++++++++++++++++++++
 drivers/clk/spacemit/clk_pll.c                  |  157 +++++++++++++++
 drivers/clk/spacemit/clk_pll.h                  |   81 ++++++++
 drivers/gpio/Kconfig                            |    8 +
 drivers/gpio/Makefile                           |    1 +
 drivers/gpio/spacemit_gpio.c                    |  253 ++++++++++++++++++++++++
 drivers/i2c/Kconfig                             |    7 +
 drivers/i2c/Makefile                            |    1 +
 drivers/i2c/k1_i2c.c                            |  523 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/k1_i2c.h                            |   69 +++++++
 drivers/mtd/spi/Makefile                        |    5 +-
 drivers/mtd/spi/sf_probe.c                      |    8 +-
 drivers/pinctrl/Kconfig                         |    1 +
 drivers/pinctrl/Makefile                        |    1 +
 drivers/pinctrl/spacemit/Kconfig                |    9 +
 drivers/pinctrl/spacemit/Makefile               |    2 +
 drivers/pinctrl/spacemit/pinctrl-k1.c           |  550 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/pmic/Kconfig                      |    8 +
 drivers/power/pmic/Makefile                     |    1 +
 drivers/power/pmic/pmic_spacemit_p1.c           |   94 +++++++++
 drivers/power/regulator/Kconfig                 |    7 +
 drivers/power/regulator/Makefile                |    1 +
 drivers/power/regulator/spacemit_p1_regulator.c |  464 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/reset/Kconfig                           |    7 -
 drivers/reset/Makefile                          |    2 +-
 drivers/reset/reset-spacemit-k1.c               |  548 ----------------------------------------------------
 drivers/reset/spacemit/Makefile                 |    5 +
 drivers/reset/spacemit/reset-spacemit-k1.c      |  289 ++++++++++++++++++++++++++++
 drivers/spi/fsl_qspi.c                          |    9 +
 include/configs/bananapi-f3.h                   |   13 --
 include/configs/k1.h                            |   20 ++
 include/dt-bindings/reset/spacemit-k1-reset.h   |  118 ------------
 include/power/spacemit_p1.h                     |  163 ++++++++++++++++
 include/soc/spacemit/k1-reset.h                 |   23 +++
 include/soc/spacemit/k1-syscon.h                |  149 +++++++++++++++
 67 files changed, 6864 insertions(+), 1270 deletions(-)
 create mode 100644 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
 create mode 100644 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/k1-pinctrl.dtsi
 delete mode 100644 arch/riscv/dts/k1.dtsi
 delete mode 100644 board/spacemit/bananapi-f3/MAINTAINERS
 delete mode 100644 board/spacemit/bananapi-f3/Makefile
 rename board/spacemit/{bananapi-f3 => k1}/Kconfig (79%)
 create mode 100644 board/spacemit/k1/MAINTAINERS
 create mode 100644 board/spacemit/k1/Makefile
 rename board/spacemit/{bananapi-f3 => k1}/board.c (100%)
 create mode 100644 board/spacemit/k1/spl.c
 create mode 100644 board/spacemit/k1/tlv_codes.h
 delete mode 100644 configs/bananapi-f3_defconfig
 create mode 100644 configs/spacemit_k1_defconfig
 create mode 100644 doc/board/spacemit/k1-spl.rst
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/clk-k1.c
 create mode 100644 drivers/clk/spacemit/clk_common.h
 create mode 100644 drivers/clk/spacemit/clk_ddn.c
 create mode 100644 drivers/clk/spacemit/clk_ddn.h
 create mode 100644 drivers/clk/spacemit/clk_mix.c
 create mode 100644 drivers/clk/spacemit/clk_mix.h
 create mode 100644 drivers/clk/spacemit/clk_pll.c
 create mode 100644 drivers/clk/spacemit/clk_pll.h
 create mode 100644 drivers/gpio/spacemit_gpio.c
 create mode 100644 drivers/i2c/k1_i2c.c
 create mode 100644 drivers/i2c/k1_i2c.h
 create mode 100644 drivers/pinctrl/spacemit/Kconfig
 create mode 100644 drivers/pinctrl/spacemit/Makefile
 create mode 100644 drivers/pinctrl/spacemit/pinctrl-k1.c
 create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
 create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c
 delete mode 100644 drivers/reset/reset-spacemit-k1.c
 create mode 100644 drivers/reset/spacemit/Makefile
 create mode 100644 drivers/reset/spacemit/reset-spacemit-k1.c
 delete mode 100644 include/configs/bananapi-f3.h
 create mode 100644 include/configs/k1.h
 delete mode 100644 include/dt-bindings/reset/spacemit-k1-reset.h
 create mode 100644 include/power/spacemit_p1.h
 create mode 100644 include/soc/spacemit/k1-reset.h
 create mode 100644 include/soc/spacemit/k1-syscon.h
