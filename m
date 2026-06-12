Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF39CD98D9
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E8F849A1;
	Fri, 12 Jun 2026 14:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCF68005D; Fri, 12 Jun 2026 11:43:19 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25425839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 12 Jun
 2026 17:43:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 12 Jun 2026 17:43:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v4 0/6] arm: aspeed: add initial AST2700 SoC support
Date: Fri, 12 Jun 2026 17:43:07 +0800
Message-ID: <20260612-ast2700_clk-v4-0-9bea29cfdc39@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvUK2oC/23MQQ6CMBCF4auQrq0ZptAWV97DGFPaURoVCCVEQ
 7i7BTcQXf4ved/IAnWeAjskI+to8ME3dYxslzBbmfpG3LvYDAElCFTchB4VwMU+7hxzTcaWhVM
 gWHy0HV39a9FO59iVD33TvRd8SOf16+SgN86Q8pSjKpSRKA0KfTShJXI92WpvmyebsQFXAMIWQ
 A7cKqVLLEBTTn8BsQbkFhARMJl1mFlMMyd/gGmaPok+KiktAQAA
X-Change-ID: 20260327-ast2700_clk-258eacb9d703
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Chia-Wei
 Wang" <chiawei_wang@aspeedtech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Andre Przywara
 <andre.przywara@arm.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, "Johan
 Jonker" <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David
 Lechner <dlechner@baylibre.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, Paul
 Kocialkowski <contact@paulk.fr>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, "Kuan-Wei
 Chiu" <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 "Quentin Schulz" <quentin.schulz@cherry.de>, Stefan Roese
 <stefan.roese@mailbox.org>, Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781257392; l=3808;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=+WD3fAdP5cndqfftdVyfJ88npM91IMA2zhiD7f4zr/Q=;
 b=O5ryOzB8ZpoUY/it8LqHWiIgs6FP11QlpS+LNovJqr8+0MbhZJcfZxk/P7boxsVpXlkjBNaQK
 0d+lpAF/ciTB8V7XnGQx+9fzh2/TSQRbxisGklssyWasY6uwVoXsCZC
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

AST2700 is the 8th generation of Integrated Remote Management
Processor introduced by ASPEED Technology Inc. It is a Board
Management Controller (BMC) SoC family with a dual-die architecture:
SoC0 ("CPU" die with four ARM Cortex-A35 application cores) and
SoC1 ("IO" die with peripherals) each SoC have its own SCU PLLs,
clock dividers and reset domains.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v4:
- Rebase onto latest master.
- spi: add AST2700 support to the spi-aspeed-smc driver, rework AHB
  addresses to uintptr_t for the 64-bit AST2700.
- configs: enable SPI flash support in evb-ast2700_defconfig.
- Link to v3: https://lore.kernel.org/r/20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com

Changes in v3:
  - mach: add "N: ast2700" to the ARM ASPEED MAINTAINERS entry.
  - Link to v2: https://lore.kernel.org/r/20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com
Changes in v2:
  - v1 only have clk driver, v2 apply full AST2700 platform and
    reset, clk, ram driver.
  - Move scu_ast2700.h from the clk patch into the mach-aspeed
  - patch so the SoC header is provided alongside the SoC code
    that consumes it.
  Link to v1: https://lore.kernel.org/r/20260508-ast2700_clk-v1-1-2797a626a238@aspeedtech.com

---
Ryan Chen (6):
      spi: aspeed: add AST2700 support
      arm: aspeed: add ASPEED AST2700 SoC family support
      arm: dts: aspeed: Add initial AST27xx SoC device tree
      clk: ast2700: add clock driver support
      reset: ast2700: add reset driver support
      ram: aspeed: add SDRAM controller driver for AST2700

 MAINTAINERS                                    |   5 +-
 arch/arm/dts/Makefile                          |   2 +
 arch/arm/dts/ast2700-evb.dts                   |  88 +++
 arch/arm/dts/ast2700-u-boot.dtsi               |  25 +
 arch/arm/dts/ast2700.dtsi                      | 693 ++++++++++++++++++
 arch/arm/include/asm/arch-aspeed/fmc_hdr.h     |  52 ++
 arch/arm/include/asm/arch-aspeed/platform.h    |  30 +-
 arch/arm/include/asm/arch-aspeed/scu.h         | 145 ++++
 arch/arm/include/asm/arch-aspeed/scu_ast2700.h | 514 +++++++++++++
 arch/arm/include/asm/arch-aspeed/sdram.h       | 137 ++++
 arch/arm/mach-aspeed/Kconfig                   |  11 +
 arch/arm/mach-aspeed/Makefile                  |   1 +
 arch/arm/mach-aspeed/ast2700/Kconfig           |  36 +
 arch/arm/mach-aspeed/ast2700/Makefile          |   2 +
 arch/arm/mach-aspeed/ast2700/arm64-mmu.c       |  43 ++
 arch/arm/mach-aspeed/ast2700/board_common.c    |  90 +++
 arch/arm/mach-aspeed/ast2700/cpu-info.c        | 114 +++
 arch/arm/mach-aspeed/ast2700/lowlevel_init.S   | 132 ++++
 arch/arm/mach-aspeed/ast2700/platform.c        |  64 ++
 board/aspeed/evb_ast2700/Kconfig               |  13 +
 board/aspeed/evb_ast2700/Makefile              |   1 +
 board/aspeed/evb_ast2700/evb_ast2700.c         |   5 +
 configs/evb-ast2700_defconfig                  | 160 +++++
 drivers/clk/aspeed/Makefile                    |   1 +
 drivers/clk/aspeed/clk_ast2700.c               | 952 +++++++++++++++++++++++++
 drivers/ram/aspeed/Kconfig                     |   2 +-
 drivers/ram/aspeed/Makefile                    |   1 +
 drivers/ram/aspeed/sdram_ast2700.c             |  15 +-
 drivers/reset/Kconfig                          |   9 +
 drivers/reset/Makefile                         |   1 +
 drivers/reset/reset-ast2700.c                  |  82 +++
 drivers/spi/spi-aspeed-smc.c                   | 219 ++++--
 include/configs/evb_ast2700.h                  |  58 ++
 33 files changed, 3634 insertions(+), 69 deletions(-)
---
base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
change-id: 20260327-ast2700_clk-258eacb9d703

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

