Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F5606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jSzjdyMX;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=udUgqr29
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE3C780DA9;
	Wed, 18 Nov 2026 13:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmRdf6ZY6PHo; Wed, 18 Nov 2026 13:18:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5BAC80F4E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007905;
	b=HgxZFeRi+JtrzRB5Ojm963XV5NMfNHagSvPFDIi3LdD6OfYj4JXAEjf6wGdftJEU0Aoy
	 fnmtqVK8rYawHh5/M107leFbv60rzmCGg/acPW8XPGNjC+mEJFMaYgsPpCioQvFnO0lpa
	 KJLJiNJ3lrdhfDkZZJP13dtpNQtlyjph1QDd3YmejSBCYuwVMQYZeek8zeyG7a0+yP1Hz
	 eq9/ELfwz1OIaaA/hXCtW8SEga0d2vJrTgnr2/m6ihthUpZmHmZ1v6zP13DyRQ+/BFDVQ
	 ZSKy7IATFuRDL+yCUjR4v+dxS99OJAIBJ0qkCEXgdoPUW72UYBgJJLg03jQtGLjzjsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IESqVCzFfEywFZMN+GJuVr/aZjjFl/9d50Nf03pJC4k=;
	b=TeRjzNhFsjnk+0Nej711CsdHlnFYpNJT62dbdW8lvH7nqKfvCB+bcnZmzYgfqrl/SWSb
	 Gq67LjNuyac8Hk7hI9OzMmh3WfN2sHvf1wfWd5INuqqKVwfnJQIyxC/py8INBAqcuC+ZS
	 fBLRQmy4QzVH6X8SmjjxJBRaZbt0fE6wwBeUumFn9bhM/8PZouz4+yVoIb7bjyw47Wd/c
	 P8r9HJiXq5nZ1bKq/CVwgjzjXcQAHJjvDrFLSeSm2yiMM6ziw/Wjn5yAif4P0L+UhVZ+3
	 M5YmuHglWit8/TezKhT7CnMeSrtP18pSl99MvmbdCDLXM4oUwUwrwsYty5I6kqZUqVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=udUgqr29;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007904;
	bh=IESqVCzFfEywFZMN+GJuVr/aZjjFl/9d50Nf03pJC4k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jSzjdyMXtP5n4Qle++SC7jDTv+x0XxqMz4JRLwmHanSB6OTfSha7NuKwAwsisB31W
	 LK5CVGl8wBT7+7gpim4uF2VuhkW+XFA6GPwRY1uSURrk3bCWi2iddHim5yYqW38SFe
	 4r0B3Oaoe/nBuyHrfIPOWi5HkpTLoCzJOOQ45SK9ACcn4FOsmCDEqOWFPg1Jx8XCja
	 hDYAt9PAofdEIaDzYR6+rZ/zUWllQiJUc+fce0qQ83GWxpUzHJigHdiUNLxjTJTdb4
	 7XZAIt/07khF1T40Kl8mQ4XFblE7pih6Ygl58fWOPnakrDgjTUtlun+NOU27gh5r8P
	 CWSUF9TX7VPfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5BAC80F4E;
	Wed, 18 Nov 2026 13:18:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A541BA0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B34780F4E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vp4IlO20SBBn for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B6B380DA9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=udUgqr29
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B6B380DA9
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DF4911A16D0;
 Wed, 18 Nov 2026 13:18:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A3F425FE9B;
 Wed, 18 Nov 2026 13:18:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EC54A11BC1F9B; Wed, 18 Nov 2026 14:18:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007892; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=IESqVCzFfEywFZMN+GJuVr/aZjjFl/9d50Nf03pJC4k=;
 b=udUgqr29aMKOKFeZqyqGt3UJ5UKDSwJEvmKT7VC+KJnGcM6DsncgzjeuD84L8ThplfTzHL
 p1FW6dnwe5rkIs2h69vG+8/bMXu5RrkZa0P750QANQsWqNFhtV/ulFSfQZAtO2KFQlmkV4
 3WBg4oCS2hsLvnstSPHBoKh0aAkp2CT5oraI234wFPBPokCm4mBEMBmXC1dwrlU03QrMUg
 zBW3bTiR3m5dHQ8JLhjG8yFr3h7DzueJVROso7LKwyREVNWvaukpJ2C3CnN/UfpLANes3l
 tTNrvFLjPrHIkq1WVqzdt/BT+bwZ2F85A5xbMa/kcJpl4N/AarttJEw8IOxwzQ==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 00/20] Introduce resume for J7xx SoCs
Date: Wed, 18 Nov 2026 14:17:47 +0100
Message-ID: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series allows J7200/J721s2/J784s4/J722s to resume from suspend.

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

Disclaimer:
---------
There's a potential attack vector in this sequence, because OPTEE could
be modified before being reloaded.
Also, if the certificate replay is skipped, then TFA can be read from
MSMC.

Patches 1-3 add LPM helpers for all SoCs
Patch 4 adds the resume detection for all SoCs
Patch 5 adds common code for DDR retention pin
Patch 6 enables GTC at resume
Patch 7 detects IO+DDR resume state for j7200/j784s4
Patch 8 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
Patch 9 sets the PMIC NSLEEP triggers
Patches 10-12 add the DDR resume sequence for all SoCs
Patches 13-16 add the resume flow for all SoCs
Patch 17 updates the pm-cfg and schema to a new version
Patch 18 removes now unneeded background firewall on DDR for j7200/j784s4
Patch 19 extends the firewall for ATF region to TIFS
Patch 20 add the resume flow documentation

Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-min-context-restore

It needs lpm_memory_regions described in DTS [updated to v6]:
https://lore.kernel.org/lkml/20261117130737.141993-1-richard.genoud@bootlin.com/

Changes from v6:
- rebase on u-boot/next:
    commit 6201222134cd ("lzma: Update LZMA SDK code from 25.01 to 26.05")
- drop patches from am62 LPM series (merged in u-boot/next)
- apply errata i2487 as am62 does (indeed, the memory was seen as
  corrupted when the first suspend was longer than 40 seconds)
  in patch 11 ("ram: k3-ddrss: Add j722s DDR resume sequence")

Changes from v5:
- gather {Acked,Reviewed}-bys
- remove j721e support
- Check lpm image size retrieved from DTS
- Fix size when loading optee+certificate
- Update U-Boot documentation TODO
- drop resume state from global data since EARLY_BSS is set, using
  static variable is ok
- make CONFIG_K3_LPM default n to prevent from breaking configs with older
  TIFS
- check lpm_reg_size in extract_lpm_region
- replay DM certificate with ti_secure_image_auth_apply_fwls()
- drop special hanling for j722s in j7xx_board_is_resuming by adding
  another call to ctrl_mmr_unlock()
- add missing calls to k3_set_lpm_core_* for each soc
- panic if clearing isolation fails
- add resume boot flow and disclaimer in uboot docs

Changes from v4:
- rebase onto v2026.10-rc2
- add disclaimer in do_resume() for 2 potential attack vectors
- include needed patches from AM62 LPM series
- fix minor checkpatch warning (!xxx instead of == NULL)

Changes from v3:
- rebase on:
    commit 8d5f30b52f7c ("Merge patch series "env: migrate static flags list to Kconfig"")
    + AM62 LPM series

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

Prasanth Babu Mantena (4):
  firmware: ti_sci: add low power mode operations
  mach-k3: r5: common: add helper functions needed in LPM resume
    sequence
  arm: dts: k3-j7200: Remove background firewall on DDR
  arm: dts: k3-j7200: Extend firewall for ATF region to TIFS

Richard Genoud (TI) (9):
  arm: mach-k3: security: introduce ti_secure_skip_cert()
  mach-k3: r5: common: introduce j7xx_board_is_resuming()
  mach-k3: r5: common: introduce k3_deassert_ddr_ret()
  board: mach-k3: r5: common: Set PMIC NSLEEP triggers bits at resume
  ram: k3-ddrss: Add j722s DDR resume sequence
  ram: k3-ddrss: support j784s4/j721s2 DDR resume
  arm: mach-k3: j784s4: Enable LPM resume flow for J784s4/J742s2 SOCs
  arm: mach-k3: j722s: Enable LPM resume flow
  doc: board: ti: Add Jacinto resume flow

Thomas Richard (TI) (3):
  ram: k3-ddrss: Add exit retention support
  arm: mach-k3: j721e: Enable LPM resume flow for J7200 SOC
  arm: mach-k3: j721s2: Enable LPM resume flow

 arch/arm/dts/k3-binman.dtsi                   |    7 +-
 arch/arm/dts/k3-j7200-binman.dtsi             |    4 +
 arch/arm/dts/k3-j722s-r5-evm.dts              |    4 +
 arch/arm/dts/k3-security.h                    |    1 +
 arch/arm/mach-k3/Kconfig                      |   10 +
 arch/arm/mach-k3/common.c                     |    6 +
 arch/arm/mach-k3/common.h                     |   17 +
 arch/arm/mach-k3/include/mach/hardware.h      |    1 +
 .../arm/mach-k3/include/mach/j721e_hardware.h |   11 +
 .../mach-k3/include/mach/j784s4_hardware.h    |   10 +
 arch/arm/mach-k3/include/mach/k3-ddr.h        |   16 +
 arch/arm/mach-k3/include/mach/security.h      |    2 +
 arch/arm/mach-k3/j721e/j721e_init.c           |   32 +
 arch/arm/mach-k3/j721s2/j721s2_init.c         |   57 +-
 arch/arm/mach-k3/j722s/j722s_init.c           |    8 +
 arch/arm/mach-k3/j784s4/j784s4_init.c         |   52 +-
 arch/arm/mach-k3/lpm-common.h                 |   33 +
 arch/arm/mach-k3/r5/Kconfig                   |    8 +
 arch/arm/mach-k3/r5/Makefile                  |    1 +
 arch/arm/mach-k3/r5/common.c                  |   21 +-
 arch/arm/mach-k3/r5/lpm-common.c              |  444 +++++
 arch/arm/mach-k3/schema.yaml                  |  146 +-
 arch/arm/mach-k3/security.c                   |  108 +-
 board/beagle/beagleboneai64/pm-cfg.yaml       |    5 +-
 board/beagle/beagleplay/pm-cfg.yaml           |    7 +-
 board/beagle/beagley-ai/pm-cfg.yaml           |    7 +-
 board/phytec/phycore_am62ax/pm-cfg.yaml       |    7 +-
 board/phytec/phycore_am62x/pm-cfg.yaml        |    7 +-
 board/phytec/phycore_am64x/pm-cfg.yaml        |    5 +-
 board/phytec/phycore_am68x/pm-cfg.yaml        |    7 +-
 board/ti/am62ax/pm-cfg.yaml                   |    7 +-
 board/ti/am62px/pm-cfg.yaml                   |    7 +-
 board/ti/am62x/pm-cfg.yaml                    |    7 +-
 board/ti/am64x/pm-cfg.yaml                    |    5 +-
 board/ti/am65x/pm-cfg.yaml                    |    7 +-
 board/ti/j7200/pm-cfg.yaml                    |   92 +-
 board/ti/j721e/evm.c                          |   25 +
 board/ti/j721e/pm-cfg.yaml                    |   92 +-
 board/ti/j721s2/pm-cfg.yaml                   |   94 +-
 board/ti/j722s/pm-cfg.yaml                    |   94 +-
 board/ti/j784s4/evm.c                         |   25 +
 board/ti/j784s4/pm-cfg.yaml                   |   94 +-
 board/toradex/aquila-am69/pm-cfg.yaml         |    7 +-
 board/toradex/verdin-am62/pm-cfg.yaml         |    7 +-
 board/toradex/verdin-am62p/pm-cfg.yaml        |    7 +-
 doc/board/ti/img/boot_diagram_k3_current.svg  |  444 ++++-
 doc/board/ti/img/resume_diagram_k3.svg        | 1638 +++++++++++++++++
 doc/board/ti/j7200_evm.rst                    |   14 +
 doc/board/ti/j721s2_evm.rst                   |   14 +
 doc/board/ti/j722s_evm.rst                    |   14 +
 doc/board/ti/j784s4_evm.rst                   |   14 +
 drivers/firmware/ti_sci.c                     |  181 ++
 drivers/firmware/ti_sci.h                     |   92 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c           |    2 +-
 drivers/ram/k3-ddrss/k3-ddrss.c               |  270 +++
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h          |   94 +
 drivers/remoteproc/ti_k3_arm64_rproc.c        |   10 +-
 include/linux/soc/ti/ti_sci_protocol.h        |    8 +
 tools/binman/etype/ti_board_config.py         |    4 +-
 59 files changed, 4214 insertions(+), 199 deletions(-)
 create mode 100644 arch/arm/mach-k3/lpm-common.h
 create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
 create mode 100644 doc/board/ti/img/resume_diagram_k3.svg
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h


base-commit: 6201222134cd704b5717211fc917e2ca6263577a
