Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA8CCD6E64
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37B0783FF5;
	Wed,  3 Jun 2026 11:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="uBrbZx7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D53583FF5; Wed,  3 Jun 2026 11:54:59 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE6A839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 2E00B1A37B7;
 Wed,  3 Jun 2026 09:54:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F0F1C5FFA8;
 Wed,  3 Jun 2026 09:54:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1A13210888CC5; 
 Wed,  3 Jun 2026 11:54:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780480494; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=CwQI0JHkc8rYWXWPDyuKJVY7VKN11vss6U1AhW5Gk40=;
 b=uBrbZx7HCQSTzYMU0hxjjddPB/iC8ekCUwQYXN2QrGmdigHcxrXbP8PF/zTTgWqs5nAqRI
 +bS81TfLnPOnC2NoFew0ceO+nTFQ/R+47iNSnmv+VhgiWCIokjsNjHjR6HqsuXlTdfa9/6
 nHy8h1aOBTSRTuVY+pczO3S7SmTmgbPwpL0weYshFs3TgBV3ZEtnzvcOwP1XBs1+Dk0CLm
 2cvgUQKF3uAkauSq9yUcSxRvmxF+eOYa1lSVg37ZMICqyxBD0OWp2GJ0YPwrWH+/3KvnTr
 rNJgm7dZ+Ch28eduaNx4JzoLDXPYmheCsSJejrJyURgOLmATBwa2ajRJTvYWGg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v2 00/16] Introduce resume for J7xx SoCs
Date: Wed,  3 Jun 2026 11:54:33 +0200
Message-ID: <20260603095449.2089514-1-richard.genoud@bootlin.com>
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

Patches 1-3 add LPM helpers for all SoCs
Patch 4 adds the resume detection for all SoCs
Patch 5 detects IO+DDR resume state for j7200/j784s4
Patch 6 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
Patches 7-9 add the DDR resume sequence for all SoCs
Patches 10-13 add the resume flow for all SoCs
Patch 14 updates the pm-cfg and schema to a new version
Patch 15 removes now unneeded background firewall on DDR for j7200/j784s4
Patch 16 extends the firewall for ATF region to TIFS

Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP

BEWARE: This series is based on v2026.04 + AM62 LPM series:
https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/

It needs lpm_memory_regions described in DTS:
https://lore.kernel.org/lkml/20260427160326.370415-1-richard.genoud@bootlin.com/

Open points:
- DM should clean the PMIC LPM magic flag for robustness.
- The PMIC LPM magic should be one one bit, or kept as a 8bit value.

Changes from v1:
- drop uneeded patch: configs: j784s4_evm_r5: enable TI_SCI_POWER_DOMAIN
- factorize j7xx_board_is_resuming (that lead to patch renumbering)
- drop From: field duplication from patch 1
- use SYS_K3_SCRATCH_LPM_ADDR config option instead of hardcoded value
- add missing board/ti/j722s/pm-cfg.yaml
- migrate missing K3 platforms to new pm-boardcfg
- remove struct lpm_addr_info mem_addr_lpm; (globals are forbidden at this stage)
- rework ti_secure_image_auth_apply_fwls()
- Fix pointer arithmetic: mem_addr_lpm->context_save_addr + FW_IMAGE_SIZE
- Fix K3_LPM_WAKE_SOURCE_PMIC_GPIO value
- Fix spellings/comments

Abhash Kumar Jha (3):
  board: evm: Enable de-isolation of IOs at resume for j7200 and j784s4
  board: ti: evm: Store wakeup reason on scratchpad memory
  arm: mach-k3: Update pm-boardcfg for all k3 platforms

Prasanth Babu Mantena (3):
  firmware: ti_sci: add low power mode operations
  arm: dts: k3-j7200: Remove background firewall on DDR
  arm: dts: k3-j7200: Extend firewall for ATF region to TIFS

Richard Genoud (TI) (7):
  mach-k3: r5: common: add helper functions needed in LPM resume
    sequence
  global: k3: use gd to store the resume state
  mach-k3: r5: common: introduce j7xx_board_is_resuming()
  ram: k3-ddrss: Add j722s DDR resume sequence
  ram: k3-ddrss: support j784s4/j721e/j721s2 DDR resume
  arm: mach-k3: j784s4: Enable LPM resume flow for J784s4/J742s2 SOCs
  arm: mach-k3: j722s: Enable LPM resume flow

Thomas Richard (TI) (3):
  ram: k3-ddrss: Add exit retention support
  arm: mach-k3: j721e: Enable LPM resume flow for J7200/J721e SOC
  arm: mach-k3: j721s2: Enable LPM resume flow

 arch/arm/dts/k3-binman.dtsi                   |   7 +-
 arch/arm/dts/k3-j7200-binman.dtsi             |  14 -
 arch/arm/dts/k3-j722s-r5-evm.dts              |   4 +
 arch/arm/dts/k3-security.h                    |   1 +
 arch/arm/include/asm/global_data.h            |  19 +
 arch/arm/mach-k3/Kconfig                      |  10 +
 arch/arm/mach-k3/common.h                     |  16 +
 .../arm/mach-k3/include/mach/j721e_hardware.h |  11 +
 .../mach-k3/include/mach/j784s4_hardware.h    |  10 +
 arch/arm/mach-k3/include/mach/k3-ddr.h        |  16 +
 arch/arm/mach-k3/include/mach/security.h      |   1 +
 arch/arm/mach-k3/j721e/j721e_init.c           |  64 ++++
 arch/arm/mach-k3/j721s2/j721s2_init.c         |  73 +++-
 arch/arm/mach-k3/j722s/j722s_init.c           |  11 +-
 arch/arm/mach-k3/j784s4/j784s4_init.c         |  70 +++-
 arch/arm/mach-k3/lpm-common.h                 |  16 +
 arch/arm/mach-k3/r5/Kconfig                   |   4 +
 arch/arm/mach-k3/r5/Makefile                  |   1 +
 arch/arm/mach-k3/r5/common.c                  |  17 +-
 arch/arm/mach-k3/r5/lpm-common.c              | 347 ++++++++++++++++++
 arch/arm/mach-k3/schema.yaml                  | 146 +++++++-
 arch/arm/mach-k3/security.c                   |  62 ++++
 board/beagle/beagleboneai64/pm-cfg.yaml       |   5 +-
 board/beagle/beagleplay/pm-cfg.yaml           |   7 +-
 board/beagle/beagley-ai/pm-cfg.yaml           |   7 +-
 board/phytec/phycore_am62ax/pm-cfg.yaml       |   7 +-
 board/phytec/phycore_am62x/pm-cfg.yaml        |   7 +-
 board/phytec/phycore_am64x/pm-cfg.yaml        |   5 +-
 board/phytec/phycore_am68x/pm-cfg.yaml        |   7 +-
 board/ti/am62ax/pm-cfg.yaml                   |   7 +-
 board/ti/am62px/pm-cfg.yaml                   |   7 +-
 board/ti/am62x/pm-cfg.yaml                    |   7 +-
 board/ti/am64x/pm-cfg.yaml                    |   5 +-
 board/ti/am65x/pm-cfg.yaml                    |   7 +-
 board/ti/j7200/pm-cfg.yaml                    |  92 ++++-
 board/ti/j721e/evm.c                          |  25 ++
 board/ti/j721e/pm-cfg.yaml                    |  92 ++++-
 board/ti/j721s2/pm-cfg.yaml                   |  94 ++++-
 board/ti/j722s/pm-cfg.yaml                    |  94 ++++-
 board/ti/j784s4/evm.c                         |  25 ++
 board/ti/j784s4/pm-cfg.yaml                   |  94 ++++-
 board/toradex/aquila-am69/pm-cfg.yaml         |   7 +-
 board/toradex/verdin-am62/pm-cfg.yaml         |   7 +-
 board/toradex/verdin-am62p/pm-cfg.yaml        |   7 +-
 drivers/firmware/ti_sci.c                     | 179 +++++++++
 drivers/firmware/ti_sci.h                     |  92 +++++
 drivers/ram/k3-ddrss/k3-ddrss.c               | 273 ++++++++++++++
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h          |  94 +++++
 include/linux/soc/ti/ti_sci_protocol.h        |   8 +
 tools/binman/etype/ti_board_config.py         |   4 +-
 50 files changed, 2085 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/mach-k3/lpm-common.h
 create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h

-- 
2.47.3

