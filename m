Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E6BCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D36984653;
	Thu, 30 Apr 2026 10:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PzQKU/dx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDB48466B; Thu, 30 Apr 2026 10:44:30 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3823A8460D
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9AADAC5CD62;
 Thu, 30 Apr 2026 08:45:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0E52260495;
 Thu, 30 Apr 2026 08:44:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA5191072B7A9; 
 Thu, 30 Apr 2026 10:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777538665; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=YNC93x7U+AnXgwcex1n/EFt/aXgg2QYvocUoCCqmNOI=;
 b=PzQKU/dxIIj1zdDORpuWLmtsUw84ebnfjzurjCM8hIP1hHVTWzOq7vd5QRVcMo0bNLJ8B0
 T6EIFsUPYo2WjTumGDbUp+qMERxzVlIQitteBczTZqeFsEFgOCG13xwW61MsrBQ9agUATS
 n/JdzAMjDlFvTfnTemUfQcNX5o4BtC9N56PZUQvABnl9W1hH2QliLxpxCRQlg9VeBWos1A
 j2WlKZquJeeLu+uqGeYNecJjsFGdttkQ3DFHJ7yXeLdury8mEf3wSK6mBKGcdTzhDLG69d
 BzZ4j3LWIZgNdP/nn43XYzdwfCl7JAm/rIyGTa41fBz1tFKyOpzbtb5VFR+CGA==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH 00/20] Introduce resume for J7xx SoCs
Date: Thu, 30 Apr 2026 10:43:53 +0200
Message-ID: <20260430084414.1354490-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This series allows J7200/J721e/J721s2/J784s4/J722s to resume from
suspend.

On those SoCs, a magic value is set in a PMIC register by the DM
firmware just before suspend, then everything but the PMIC and DDR is
powered off.
At resume/boot time, the magic value has to be read back by U-Boot SPL in
order to know if we are indeed in a resume situation.
That's the purpose of j7xx_board_is_resuming() introduced here.

Then, if the SoC is resuming, the DDR has to be be brought out of
retention, at full speed and get out of low power mode.
Between those steps, the DDR_RET pin has to be de-asserted. But the
DDR_RET pins of all DDR chips are tied together on a single GPIO, so
it's impossible to resume one DDR chip after the other, they must be all
resumed at once.
That's why it's orchestrated from board_init_f() and not in the k3ddrss
driver.

Once the DDR is fully functional, the next steps are:
  - retrieve the LPM memory region from DTS
  - authenticate certificates from LPM memory region and apply firewalls
  - ask TIFS to restore TFA and its own minimal context
  - start TFA on remote proc
  - load and jump to DM

Patch 1 adds a missing config option for j784s4
Patches 2-6 add the resume detection for all SoCs
Patches 7-9 add the DDR resume sequence for all SoCs
Patches 10-15 add the resume flow for all SoCs
Patch 16 updates the pm-cfg and schema to a new version
Patch 17 detects IO+DDR resume state for j7200/j784s4
Patch 18 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
Patch 19 removes now unneeded background firewall on DDR for j7200/j784s4
Patch 20 extends the firewall for ATF region to TIFS

Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP

BEWARE: This series is based on v2026.04 + AM62 LPM series:
https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/

It needs lpm_memory_regions described in DTS:
https://lore.kernel.org/lkml/20260427160326.370415-1-richard.genoud@bootlin.com/

Abhash Kumar Jha (3):
  arm: mach-k3: Update pm-boardcfg for all k3 platforms
  board: evm: Enable de-isolation of IOs at resume for j7200 and j784s4
  board: ti: evm: Store wakeup reason on scratchpad memory

Prasanth Babu Mantena (3):
  firmware: ti_sci: add low power mode operations
  arm: dts: k3-j7200: Remove background firewall on DDR
  arm: dts: k3-j7200: Extend firewall for ATF region to TIFS

Richard Genoud (TI) (9):
  configs: j784s4_evm_r5: enable TI_SCI_POWER_DOMAIN
  global: k3: use gd to store the resume state
  board: ti: j784s4: Add resume detection
  board: ti: j722s: Add resume detection
  ram: k3-ddrss: Add j722s DDR resume sequence
  ram: k3-ddrss: support j784s4/j721e/j721s2 DDR resume
  mach-k3: r5: common: add helper functions needed in LPM resume
    sequence
  arm: mach-k3: j784s4: Enable LPM resume flow for J784s4/J742s2 SOCs
  arm: mach-k3: j722s: Enable LPM resume flow

Thomas Richard (TI) (5):
  board: ti: j721e: Add resume detection for J721e/J7200
  board: ti: j721s2: Add resume detection
  ram: k3-ddrss: Add exit retention support
  arm: mach-k3: j721e: Enable LPM resume flow for J7200/J721e SOC
  arm: mach-k3: j721s2: Enable LPM resume flow

 arch/arm/dts/k3-binman.dtsi                   |  18 +-
 arch/arm/dts/k3-j7200-binman.dtsi             |  18 +-
 arch/arm/dts/k3-j722s-r5-evm.dts              |   4 +
 arch/arm/dts/k3-security.h                    |   1 +
 arch/arm/include/asm/global_data.h            |  19 ++
 arch/arm/mach-k3/common.h                     |  16 +
 .../arm/mach-k3/include/mach/j721e_hardware.h |  12 +
 .../mach-k3/include/mach/j784s4_hardware.h    |  11 +
 arch/arm/mach-k3/include/mach/k3-ddr.h        |  16 +
 arch/arm/mach-k3/include/mach/security.h      |   1 +
 arch/arm/mach-k3/j721e/j721e_init.c           |  64 ++++
 arch/arm/mach-k3/j721s2/j721s2_init.c         |  73 ++++-
 arch/arm/mach-k3/j722s/j722s_init.c           |  11 +-
 arch/arm/mach-k3/j784s4/j784s4_init.c         |  70 ++++-
 arch/arm/mach-k3/lpm-common.h                 |  15 +
 arch/arm/mach-k3/r5/Kconfig                   |   4 +
 arch/arm/mach-k3/r5/Makefile                  |   1 +
 arch/arm/mach-k3/r5/common.c                  |  17 +-
 arch/arm/mach-k3/r5/lpm-common.c              | 228 +++++++++++++++
 arch/arm/mach-k3/schema.yaml                  | 195 ++++++++++---
 arch/arm/mach-k3/security.c                   |  64 ++++
 board/phytec/phycore_am62ax/pm-cfg.yaml       |   7 +-
 board/ti/am62ax/pm-cfg.yaml                   |   7 +-
 board/ti/am62px/pm-cfg.yaml                   |   7 +-
 board/ti/am62x/pm-cfg.yaml                    |   7 +-
 board/ti/am64x/pm-cfg.yaml                    |   5 +-
 board/ti/am65x/pm-cfg.yaml                    |   7 +-
 board/ti/common/k3-lpm.h                      |  22 ++
 board/ti/j7200/pm-cfg.yaml                    |  92 +++++-
 board/ti/j721e/evm.c                          |  75 +++++
 board/ti/j721e/pm-cfg.yaml                    |  92 +++++-
 board/ti/j721s2/evm.c                         |  37 +++
 board/ti/j721s2/pm-cfg.yaml                   |  94 +++++-
 board/ti/j722s/evm.c                          |  51 ++++
 board/ti/j722s/pm-cfg.yaml                    |   7 +-
 board/ti/j784s4/evm.c                         |  78 +++++
 board/ti/j784s4/pm-cfg.yaml                   |  94 +++++-
 configs/j784s4_evm_r5_defconfig               |   1 +
 drivers/firmware/ti_sci.c                     | 179 ++++++++++++
 drivers/firmware/ti_sci.h                     |  92 ++++++
 drivers/ram/k3-ddrss/k3-ddrss.c               | 273 ++++++++++++++++++
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h          |  94 ++++++
 include/linux/soc/ti/ti_sci_protocol.h        |   8 +
 tools/binman/etype/ti_board_config.py         |   4 +-
 44 files changed, 2088 insertions(+), 103 deletions(-)
 create mode 100644 arch/arm/mach-k3/lpm-common.h
 create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
 create mode 100644 board/ti/common/k3-lpm.h
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h

