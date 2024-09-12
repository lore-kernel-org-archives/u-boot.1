Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383B7EE57C7
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B921D88E1B;
	Thu, 12 Sep 2024 08:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D071588E5D; Thu, 12 Sep 2024 08:39:36 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F77788AA4
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 48C6dQFQ094040
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 12 Sep 2024 14:39:26 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:39:27 +0800
Date: Thu, 12 Sep 2024 14:39:24 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <rick@andestech.com>
Subject: [PULL] u-boot-riscv/next
Message-ID: <ZuKMnMooFpwVVhy7@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 48C6dQFQ094040
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

The following changes since commit 78d898eec080b02059c8dc09318b8761044fea85:

  Merge patch series "phycore-am62/4: Add more boot sources" (2024-09-10 14:56:12 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to 2db018d2ca5ebd7acc717f0b1959ee67fcd2b0a1:

  configs: ibex-ast2700: Enable DRAM and timer driver (2024-09-11 20:35:04 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/22315
----------------------------------------------------------------
- Aspeed: Add AST2700 board (Ibex RISC-V core) support
	- Add timer, dram controller, network support
- Sophgo: Add clock controller support for Milk-V Duo
----------------------------------------------------------------
Chia-Wei Wang (8):
      riscv: Make A ISA extension selectable
      riscv: Make stack size shift configurable
      riscv: u-boot-spl.lds: Remove _image_binary_end alignment
      riscv: Add AST2700 SoC initial platform support
      timer: Add AST2700 IBEX timer support
      board: ibex_ast2700: Add FMC header support
      ram: ast2700: Add DRAM controller initialization
      configs: ibex-ast2700: Enable DRAM and timer driver

Jacky Chou (5):
      net: ftgmac100: Fixed the cache coherency issues of rx memory
      net: ftgmac100: Fixed NC-SI PHY device cannot get
      net: ftgmac100: Modify desc. size to cache line
      net: ftgmac100: Add Aspeed AST2700 support
      driver: net: Add Aspeed AST2700 MDIO support

Kongyang Liu (4):
      dt-bindings: clk: import header for clock controller of sophgo CV1800B
      clk: sophgo: cv1800b: Add clock controller driver for cv1800b SoC
      configs: milkv_duo: Enable clock controller
      riscv: dts: sophgo: Replace device clocks with real clocks.

 arch/riscv/Kconfig                                 |   12 +-
 arch/riscv/cpu/ast2700/Kconfig                     |    6 +
 arch/riscv/cpu/ast2700/Makefile                    |    1 +
 arch/riscv/cpu/ast2700/cpu.c                       |   23 +
 arch/riscv/cpu/u-boot-spl.lds                      |    2 -
 arch/riscv/dts/Makefile                            |    1 +
 arch/riscv/dts/ast2700-ibex.dts                    |   22 +
 arch/riscv/dts/ast2700-u-boot.dtsi                 |   40 +
 arch/riscv/dts/ast2700.dtsi                        |   76 +
 arch/riscv/dts/cv18xx.dtsi                         |   40 +-
 arch/riscv/include/asm/arch-ast2700/fmc_hdr.h      |   52 +
 arch/riscv/include/asm/arch-ast2700/scu.h          |  145 +
 arch/riscv/include/asm/arch-ast2700/sdram.h        |  137 +
 arch/riscv/include/asm/arch-ast2700/sli.h          |   82 +
 board/aspeed/ibex_ast2700/Kconfig                  |   21 +
 board/aspeed/ibex_ast2700/MAINTAINERS              |    7 +
 board/aspeed/ibex_ast2700/Makefile                 |    3 +
 board/aspeed/ibex_ast2700/fmc_hdr.c                |   64 +
 board/aspeed/ibex_ast2700/ibex_ast2700.c           |   85 +
 board/aspeed/ibex_ast2700/sli.c                    |   72 +
 configs/ibex-ast2700_defconfig                     |   94 +
 configs/milkv_duo_defconfig                        |    3 +-
 doc/board/aspeed/ibex-ast2700.rst                  |   26 +
 doc/board/aspeed/index.rst                         |    9 +
 doc/board/index.rst                                |    1 +
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/sophgo/Kconfig                         |   14 +
 drivers/clk/sophgo/Makefile                        |    6 +
 drivers/clk/sophgo/clk-common.h                    |   74 +
 drivers/clk/sophgo/clk-cv1800b.c                   |  754 +++
 drivers/clk/sophgo/clk-cv1800b.h                   |  123 +
 drivers/clk/sophgo/clk-ip.c                        |  594 ++
 drivers/clk/sophgo/clk-ip.h                        |  288 +
 drivers/clk/sophgo/clk-pll.c                       |  275 +
 drivers/clk/sophgo/clk-pll.h                       |   74 +
 drivers/net/aspeed_mdio.c                          |    1 +
 drivers/net/ftgmac100.c                            |   89 +-
 drivers/net/ftgmac100.h                            |   17 +-
 drivers/ram/Makefile                               |    2 +-
 drivers/ram/aspeed/Kconfig                         |   27 +-
 drivers/ram/aspeed/Makefile                        |    1 +
 .../dwc_ddrphy_phyinit_ddr4-3200-nodimm-train2D.c  | 2700 ++++++++
 .../dwc_ddrphy_phyinit_ddr5-3200-nodimm-train2D.c  | 6930 ++++++++++++++++++++
 drivers/ram/aspeed/sdram_ast2700.c                 | 1036 +++
 drivers/timer/Kconfig                              |    6 +
 drivers/timer/Makefile                             |    1 +
 drivers/timer/ast_ibex_timer.c                     |   45 +
 include/configs/ibex_ast2700.h                     |   12 +
 include/dt-bindings/clock/sophgo,cv1800.h          |  176 +
 50 files changed, 14220 insertions(+), 51 deletions(-)
 create mode 100644 arch/riscv/cpu/ast2700/Kconfig
 create mode 100644 arch/riscv/cpu/ast2700/Makefile
 create mode 100644 arch/riscv/cpu/ast2700/cpu.c
 create mode 100644 arch/riscv/dts/ast2700-ibex.dts
 create mode 100644 arch/riscv/dts/ast2700-u-boot.dtsi
 create mode 100644 arch/riscv/dts/ast2700.dtsi
 create mode 100644 arch/riscv/include/asm/arch-ast2700/fmc_hdr.h
 create mode 100644 arch/riscv/include/asm/arch-ast2700/scu.h
 create mode 100644 arch/riscv/include/asm/arch-ast2700/sdram.h
 create mode 100644 arch/riscv/include/asm/arch-ast2700/sli.h
 create mode 100644 board/aspeed/ibex_ast2700/Kconfig
 create mode 100644 board/aspeed/ibex_ast2700/MAINTAINERS
 create mode 100644 board/aspeed/ibex_ast2700/Makefile
 create mode 100644 board/aspeed/ibex_ast2700/fmc_hdr.c
 create mode 100644 board/aspeed/ibex_ast2700/ibex_ast2700.c
 create mode 100644 board/aspeed/ibex_ast2700/sli.c
 create mode 100644 configs/ibex-ast2700_defconfig
 create mode 100644 doc/board/aspeed/ibex-ast2700.rst
 create mode 100644 doc/board/aspeed/index.rst
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv1800b.c
 create mode 100644 drivers/clk/sophgo/clk-cv1800b.h
 create mode 100644 drivers/clk/sophgo/clk-ip.c
 create mode 100644 drivers/clk/sophgo/clk-ip.h
 create mode 100644 drivers/clk/sophgo/clk-pll.c
 create mode 100644 drivers/clk/sophgo/clk-pll.h
 create mode 100644 drivers/ram/aspeed/dwc_ddrphy_phyinit_ddr4-3200-nodimm-train2D.c
 create mode 100644 drivers/ram/aspeed/dwc_ddrphy_phyinit_ddr5-3200-nodimm-train2D.c
 create mode 100644 drivers/ram/aspeed/sdram_ast2700.c
 create mode 100644 drivers/timer/ast_ibex_timer.c
 create mode 100644 include/configs/ibex_ast2700.h
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h


Best regards,
Leo
