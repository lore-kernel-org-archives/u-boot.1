Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCCC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92A4080E8C;
	Fri, 28 Aug 2026 13:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fNiBNuD_UESX; Fri, 28 Aug 2026 13:57:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925467;
	bh=8W9e6YXqmjhvqoM6jZtAqOkC+NGrWxe3di7tam40I58=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wF0GJm6wijrAR5UUJNv8RpKmEnzlCu8YF1gbf7jgVSVEZ8yC5ng/YGlKTbiVdG7C7
	 ZqeEHS7heTj7iCw2X/KoDXy8lWzcF9V4YxcdC5yuLTU2Acxt1JiWlvXuO9d0DCRRnZ
	 N2JXGjRTTC/Cc7Jznz2mW6zyETcTB7OMgEJCLbINaWmG9omqtIz7X//FzsrRngGv3a
	 VFF7j/O1azeeEl56ApovFXzYXrUmBWMNd4LZ9kMlwnhK+57JnDuyz3569U4Hs6Apm9
	 i1vhSHW7AYo+s6DeMycPt9sDLAc0gxj+3hXohXcz58/SmZzns7xpV3Gd+Y0MTsUWNP
	 +L3dHGx8qKsMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C0F380E90;
	Fri, 28 Aug 2026 13:57:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F816127
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 710BB60727
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sc2QumwDGbBx for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:57:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=QOmVH/d7
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D603360705
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:57:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 86F1C1A18A3;
 Fri, 28 Aug 2026 13:57:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5895760537;
 Fri, 28 Aug 2026 13:57:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 77F4B11C781F3; 
 Fri, 28 Aug 2026 15:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925456; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=8W9e6YXqmjhvqoM6jZtAqOkC+NGrWxe3di7tam40I58=;
 b=QOmVH/d7SV1f9c4Hgk8a4Zl8FNMopcly33TPDFESFdI1DoUFlARMd6UQGLe63MXAAjT6Fd
 RbmcvtvrHKdgODtBbsTOOJGcK+KmhSgUjUgGO8z9KLMhCKPv5qEjtUX6jq6mIAqg7k+KqP
 ql60YsYaN31AF6t9FrnF3J07exAn5i7ZLpa8XHFT2xK6EeFQVA0Ufid5EFGFeuzkR4LSNY
 SVmyvigcnqrLyYFofgZ9uOthVXN55bdPIv96V/YSMTfPr51Mwo3DIYFrr1Mur/58Q93Jlq
 EbBR4X3PklnQQzODHsCHu8R+W2QdGPp/Dcz0gK8TYnMHn0FJCqAPPT6BwSn79g==
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
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 00/21]  Introduce resume for J7xx SoCs
Date: Fri, 28 Aug 2026 15:57:09 +0200
Message-ID: <20260828135730.1565643-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series allows J7200/J721e/J721s2/J784s4/J722s to resume from
suspend.

On those SoCs, a magic value is set in a PMIC register by the DM
firmware just before suspend, then everything but the PMIC and DDR is
powered off.
At resume/boot time, the magic value has to be read back by U-Boot SPL in
order to know if we are indeed in a resume situation.
That's the purpose of j7xx_board_is_resuming() introduced here.

Then, if the SoC is resuming, the DDR has to be brought out of
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

Disclamer:
---------
There's a potential attack vector in this sequence, because OPTEE could
be modified before being reloaded.
Also, if the certificate replay is skipped, then TFA can be read from
MSMC.

Patch 1 and 2 are from AM62 LPM series:
https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/
Patch 1 adds support for DDR in self-refresh for am62/j722s
Patch 2 adds capability to call TI_SCI_MSG_MIN_CONTEXT_RESTORE
Patches 3-5 add LPM helpers for all SoCs
Patch 6 adds the resume detection for all SoCs
Patch 7 adds common code for DDR retention pin
Patch 8 enables GTC at resume
Patch 9 detects IO+DDR resume state for j7200/j784s4
Patch 10 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
Patch 11 sets the PMIC NSLEEP triggers
Patches 12-14 add the DDR resume sequence for all SoCs
Patches 15-18 add the resume flow for all SoCs
Patch 19 updates the pm-cfg and schema to a new version
Patch 20 removes now unneeded background firewall on DDR for j7200/j784s4
Patch 21 extends the firewall for ATF region to TIFS

Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-min-context-restore

It needs lpm_memory_regions described in DTS:
https://lore.kernel.org/lkml/20260427160326.370415-1-richard.genoud@bootlin.com/

It also needs a bootph-pre-ram property in PMIC-B for j721s2:
https://lore.kernel.org/linux-arm-kernel/20260429-k3-j721s2-som-bootph-pre-ram-pmic-4c-v2-1-31a0e7677216@bootlin.com/

Changes from v4:
- rebase onto v2026.10-rc2
- add disclaimer in do_resume() for 2 potential attack vectors
- include needed patches from AM62 LPM series
- fix minor checkpatch warning (!xxx instead of == NULL)

Changes from v3:
- rebase on 8d5f30b52f7c ("Merge patch series "env: migrate static flags list to Kconfig"") + AM62 LPM series

Changes from v2:
- enable GTC counter at resume
- factorise __weak j7xx_board_is_resuming()
- reset PMIC NSLEEP triggers register in one place
- gather Reviewed-by
- fix comment style in k3-ddrss.c
- clean and Factorize k3_deassert_ddr_ret()
- change printf in dev_err in ti_sci_cmd_proc_auth_apply_fwls()

Changes from v1:
- drop unneeded patch: configs: j784s4_evm_r5: enable TI_SCI_POWER_DOMAIN
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

Abhash Kumar Jha (4):
  board: mach-k3: r5: common: enable GTC after core_resume
  board: evm: Enable de-isolation of IOs at resume for j7200 and j784s4
  board: mach-k3: r5: common: Store wakeup reason on scratchpad memory
  arm: mach-k3: Update pm-boardcfg for all k3 platforms

Markus Schneider-Pargmann (TI) (2):
  ram: k3-ddrss: Add support for DDR in self-refresh
  firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE

Prasanth Babu Mantena (3):
  firmware: ti_sci: add low power mode operations
  arm: dts: k3-j7200: Remove background firewall on DDR
  arm: dts: k3-j7200: Extend firewall for ATF region to TIFS

Richard Genoud (TI) (9):
  mach-k3: r5: common: add helper functions needed in LPM resume
    sequence
  global: k3: use gd to store the resume state
  mach-k3: r5: common: introduce j7xx_board_is_resuming()
  mach-k3: r5: common: introduce k3_deassert_ddr_ret()
  board: mach-k3: r5: common: Set PMIC NSLEEP triggers bits at resume
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
 arch/arm/mach-k3/common.c                     |   6 +
 arch/arm/mach-k3/common.h                     |  16 +
 arch/arm/mach-k3/include/mach/hardware.h      |   1 +
 .../arm/mach-k3/include/mach/j721e_hardware.h |  11 +
 .../mach-k3/include/mach/j784s4_hardware.h    |  10 +
 arch/arm/mach-k3/include/mach/k3-ddr.h        |  16 +
 arch/arm/mach-k3/include/mach/security.h      |   1 +
 arch/arm/mach-k3/j721e/j721e_init.c           |  24 +
 arch/arm/mach-k3/j721s2/j721s2_init.c         |  49 +-
 arch/arm/mach-k3/j722s/j722s_init.c           |   6 +-
 arch/arm/mach-k3/j784s4/j784s4_init.c         |  44 +-
 arch/arm/mach-k3/lpm-common.h                 |  19 +
 arch/arm/mach-k3/r5/Kconfig                   |   4 +
 arch/arm/mach-k3/r5/Makefile                  |   1 +
 arch/arm/mach-k3/r5/common.c                  |  17 +-
 arch/arm/mach-k3/r5/lpm-common.c              | 446 ++++++++++++++++++
 arch/arm/mach-k3/schema.yaml                  | 146 +++++-
 arch/arm/mach-k3/security.c                   |  62 +++
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
 board/ti/j7200/pm-cfg.yaml                    |  92 +++-
 board/ti/j721e/evm.c                          |  25 +
 board/ti/j721e/pm-cfg.yaml                    |  92 +++-
 board/ti/j721s2/pm-cfg.yaml                   |  94 +++-
 board/ti/j722s/pm-cfg.yaml                    |  94 +++-
 board/ti/j784s4/evm.c                         |  25 +
 board/ti/j784s4/pm-cfg.yaml                   |  94 +++-
 board/toradex/aquila-am69/pm-cfg.yaml         |   7 +-
 board/toradex/verdin-am62/pm-cfg.yaml         |   7 +-
 board/toradex/verdin-am62p/pm-cfg.yaml        |   7 +-
 drivers/firmware/ti_sci.c                     | 219 +++++++++
 drivers/firmware/ti_sci.h                     | 108 +++++
 drivers/ram/k3-ddrss/Makefile                 |   1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c           | 181 +++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h           |  20 +
 drivers/ram/k3-ddrss/k3-ddrss.c               | 295 +++++++++++-
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h          |  94 ++++
 drivers/remoteproc/ti_k3_arm64_rproc.c        |  10 +-
 include/linux/soc/ti/ti_sci_protocol.h        |  17 +
 tools/binman/etype/ti_board_config.py         |   4 +-
 56 files changed, 2395 insertions(+), 103 deletions(-)
 create mode 100644 arch/arm/mach-k3/lpm-common.h
 create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
 create mode 100644 drivers/ram/k3-ddrss/k3-ddrss-lpm.c
 create mode 100644 drivers/ram/k3-ddrss/k3-ddrss-lpm.h
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h


base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
