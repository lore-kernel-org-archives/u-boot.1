Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32D6CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 12:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F20B8483C;
	Wed, 20 May 2026 14:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7708C844CF; Wed, 20 May 2026 10:24:56 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB098844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 20 May
 2026 16:24:48 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 20 May 2026 16:24:48 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v2 0/5] arm: aspeed: add initial AST2700 SoC support
Date: Wed, 20 May 2026 16:24:47 +0800
Message-ID: <20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9vDWoC/1XMQQrCMBCF4auUWRuZTmmSuvIeUiSmow1qU5ISl
 JK7G+vK5f/gfStEDo4jHKoVAicXnZ9K0K4CO5rpxsINpYGQJDakhIkLKcSzfdwFtZqNvXSDwgb
 KYw58da9NO/WlRxcXH94bnurv+nNa1H9OqkUtSHXKSJKGGn00cWYeFrbj3von9DnnD1UJG8KrA
 AAA
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
 "Ryan Chen" <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779265488; l=3146;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=5I4ZyeE27MreXSz3wa7E54oBUJTEVY9uLkfzDNvo63g=;
 b=YQm2XKCJoddAh2QoZD0m+3YhC4dQiSLhLgo4hNS2vYmXR2znqgxba+7OJDGkhppH6v1zsSPov
 FbuLDX/6LqBAoCoojYIiPVvkuyUovz1kUk2Xnw0uMw/hDIHAXmwVXV/
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Wed, 20 May 2026 14:49:56 +0200
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
SoC1 ("IO" die with peripherals) each SoC have its own SCU PLLs, clock
dividers and reset domains.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v2:
  * v1 only have clk driver, v2 apply full AST2700 platform and
    reset, clk, ram driver.
  * Move scu_ast2700.h from the clk patch into the mach-aspeed
    patch so the SoC header is provided alongside the SoC code
    that consumes it.
  * Link to v1: https://lore.kernel.org/r/20260508-ast2700_clk-v1-1-2797a626a238@aspeedtech.com

---
Ryan Chen (5):
      arm: aspeed: add ASPEED AST2700 SoC family support
      arm: dts: aspeed: Add initial AST27xx SoC device tree
      clk: ast2700: add clock driver support
      reset: ast2700: add reset driver support
      ram: aspeed: add SDRAM controller driver for AST2700

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
 configs/evb-ast2700_defconfig                  | 149 ++++
 drivers/clk/aspeed/Makefile                    |   1 +
 drivers/clk/aspeed/clk_ast2700.c               | 952 +++++++++++++++++++++++++
 drivers/ram/aspeed/Kconfig                     |   4 +-
 drivers/ram/aspeed/Makefile                    |   2 +-
 drivers/ram/aspeed/sdram_ast2700.c             |  15 +-
 drivers/reset/Kconfig                          |   9 +
 drivers/reset/Makefile                         |   1 +
 drivers/reset/reset-ast2700.c                  |  82 +++
 include/configs/evb_ast2700.h                  |  58 ++
 31 files changed, 3462 insertions(+), 9 deletions(-)
---
base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
change-id: 20260327-ast2700_clk-258eacb9d703

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

