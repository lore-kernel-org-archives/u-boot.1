Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A845ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0962788F74;
	Tue, 10 Sep 2024 11:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7192688F9B; Tue, 10 Sep 2024 11:39:29 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4875C88F45
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 10 Sep
 2024 17:39:20 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 10 Sep 2024 17:39:20 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <ryan_chen@aspeedtech.com>, <joel@jms.id.au>, <u-boot@lists.denx.de>
Subject: [PATCH v2 0/8] riscv: Add AST2700 platform support
Date: Tue, 10 Sep 2024 17:39:12 +0800
Message-ID: <20240910093920.1142455-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

AST2700 is the 7th generation of Aspeed BMC SoCs.

A 32-bits Ibex RISC-V core is integrated as the boot MCU to run the
first stage bootloader, SPL, for the platform initialization.

This patch series starts by revising RISC-V common code to relax certain
restrictions for finer platform resource tuning. As this MCU adopts the
"small" configuration provided by Ibex and has limited SRAM space.

In addition to the RV common code revision, the other patches provides the
basic AST2700 platform code and DRAM/Timer drivers to succuessfully boot
SPL and U-Boot on this Ibex-based MCU.

v2:
  - collect Reviewed-by and Acked-by tags
  - add the build document for ibex-ast2700 board as suggested

Chia-Wei Wang (8):
  riscv: Make A ISA extension selectable
  riscv: Make stack size shift configurable
  riscv: u-boot-spl.lds: Remove _image_binary_end alignment
  riscv: Add AST2700 SoC initial platform support
  timer: Add AST2700 IBEX timer support
  board: ibex_ast2700: Add FMC header support
  ram: ast2700: Add DRAM controller initialization
  configs: ibex-ast2700: Enable DRAM and timer driver

 arch/riscv/Kconfig                            |   12 +-
 arch/riscv/cpu/ast2700/Kconfig                |    6 +
 arch/riscv/cpu/ast2700/Makefile               |    1 +
 arch/riscv/cpu/ast2700/cpu.c                  |   23 +
 arch/riscv/cpu/u-boot-spl.lds                 |    2 -
 arch/riscv/dts/Makefile                       |    1 +
 arch/riscv/dts/ast2700-ibex.dts               |   22 +
 arch/riscv/dts/ast2700-u-boot.dtsi            |   40 +
 arch/riscv/dts/ast2700.dtsi                   |   76 +
 arch/riscv/include/asm/arch-ast2700/fmc_hdr.h |   52 +
 arch/riscv/include/asm/arch-ast2700/scu.h     |  145 +
 arch/riscv/include/asm/arch-ast2700/sdram.h   |  137 +
 arch/riscv/include/asm/arch-ast2700/sli.h     |   82 +
 board/aspeed/ibex_ast2700/Kconfig             |   21 +
 board/aspeed/ibex_ast2700/MAINTAINERS         |    7 +
 board/aspeed/ibex_ast2700/Makefile            |    3 +
 board/aspeed/ibex_ast2700/fmc_hdr.c           |   64 +
 board/aspeed/ibex_ast2700/ibex_ast2700.c      |   85 +
 board/aspeed/ibex_ast2700/sli.c               |   72 +
 configs/ibex-ast2700_defconfig                |   94 +
 doc/board/aspeed/ibex-ast2700.rst             |   26 +
 doc/board/aspeed/index.rst                    |    9 +
 doc/board/index.rst                           |    1 +
 drivers/ram/Makefile                          |    2 +-
 drivers/ram/aspeed/Kconfig                    |   27 +-
 drivers/ram/aspeed/Makefile                   |    1 +
 ..._ddrphy_phyinit_ddr4-3200-nodimm-train2D.c | 2700 +++++++
 ..._ddrphy_phyinit_ddr5-3200-nodimm-train2D.c | 6930 +++++++++++++++++
 drivers/ram/aspeed/sdram_ast2700.c            | 1036 +++
 drivers/timer/Kconfig                         |    6 +
 drivers/timer/Makefile                        |    1 +
 drivers/timer/ast_ibex_timer.c                |   45 +
 include/configs/ibex_ast2700.h                |   12 +
 33 files changed, 11732 insertions(+), 9 deletions(-)
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
 create mode 100644 drivers/ram/aspeed/dwc_ddrphy_phyinit_ddr4-3200-nodimm-train2D.c
 create mode 100644 drivers/ram/aspeed/dwc_ddrphy_phyinit_ddr5-3200-nodimm-train2D.c
 create mode 100644 drivers/ram/aspeed/sdram_ast2700.c
 create mode 100644 drivers/timer/ast_ibex_timer.c
 create mode 100644 include/configs/ibex_ast2700.h

-- 
2.25.1

