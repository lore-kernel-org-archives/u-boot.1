Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21595C98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B008081025;
	Thu, 24 Sep 2026 12:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mMmP1FnkKwmX; Thu, 24 Sep 2026 12:35:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E30AC810D8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253354;
	b=Ox8Nf8a6tGk0k08D8MxGfcQYNcbpXPjnoHwVwfb4TR/80heWwT2gyCHxq9+1LMVOUUPC
	 MUeznfzs4F6CGbd3X5W/Yl6ONro9k9Of9PBXxEashO9XMoqYh6x8fybZbo1M3fdpV0lZd
	 ynr4vbfUam+VWTyeJQxCuSxnl7Pg8x8Qirgz8hyrKM6SOv3zGW52yO2uVMHdtKAznVhzi
	 shbJPNw6pqhEgYJXFVAARP5Cwmclbd21TDqReczqH81wl0oYYxaXKp3RTxTeeisKoIbnw
	 mS0Ozmf6ex/gxVz44L3ZihJd6ZqFDkTBaF0VR/J9sJgRQn96ELJeLLTP3U4r1AQDoqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IT7YTFdTspSYEBmsLQj8Q09jCBJ4n+HDKYZE3cUmbmg=;
	b=YTxuIqj834cCAlDoOSf0uRtoPTFzb5HsA5nu79zLJKjhTW5qbIYi+OAJMvONFYIs/nzu
	 +01pgBuvd7L7LZhVpsj0CM4uMZEI/UAIuGzTUw3oB2i/zt+UJJ6atXjt6fAe6/r0gG6Qy
	 JydHKud7mPG1FP1CPomcgDxH+7c0XyDNZcdYdu6Q0Ot6scRMnKgk5Kq0TgAWWu85IziEa
	 cpllxZnJxNNWMdf6+rJbZKNa9lE7q8N8V4LrYHqjPaaY4t3GIGQLdC69JtUP/XpppvG5Q
	 zh4Dj0Z+eNKMyi/jv/QIkPUNRn+I8PVPrURccEbL3rUL05U2RZyT1M7vc1mK3I+UoZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253354;
	bh=IT7YTFdTspSYEBmsLQj8Q09jCBJ4n+HDKYZE3cUmbmg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mngRLc66xrLDq3r0dpkIsgHDpxL/YrFTkLWMCap9bCttYMHqBvKg6lyS4m8yNl1TY
	 6cLMInVuIGCC2T+gEugEwWVZXiR+Z0N9V+60IGvZrMNJ3JsCjZ6XLIhiQ9wDaD0ER2
	 /BsiRVLC22Kpd2O9c3+hEpUKsdVfKWribY1VIxChUl9IImTBu//XNujp2YJJLaV8U5
	 /jVyy6J7x+uGtgqOebbWnyWg6N9WRiRrSevgPTY05KWjOrcETkmnx24fExW+SyyHSF
	 cBdNTy93mL517Wf3u9BpPF5DLpTiIAuB65DgWIRC9+A+T2mEvqunIrTISgMO0YVqz+
	 vvcLf+TfIqRcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E30AC810D8;
	Thu, 24 Sep 2026 12:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A305392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59F876081B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dN-9cTB86eZ for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C38A607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253350;
 b=nUz+N0txyQPE4Qb87PYTsy/1bWLqAreFozSa65xf9Xu0vSMPi7lNfaRtdsCRzKwaBhLq
 bGbkiWZ/LjeO4BsnUV3km4QJjPTFNbLY9mDquf+ySS1WCLIjowwWDZ/aEfU8t3KjUO+TH
 oLLGuxJAmuN6N0YLQg/J2b+eK5nQq72e4ZC2/YCAgsXtU5DJ+j2dgzMDbwg2Q1BJ1MSML
 u+V4whsvJjkndN40BeCl17QbUV8AXFmiQTu2RxJuUvsg8xnwcWZuKyTYuDJfuOwjUr1K0
 i+AvRNL8/Z7H3BUkK6sSrET6F/6FdS2F0byXXtKQlkkMf8nnOd/k8laUeo836SP46Fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253350;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=IT7YTFdTspSYEBmsLQj8Q09jCBJ4n+HDKYZE3cUmbmg=;
 b=W4bRwrwEqqY+jPxm04SKJw8Uj4WzRB1X6Ow1r+A6H2n4GC18S2FeOvlBBBCEQVVjUh5/
 RIYsg/sqbId9eAwPO/29AjHrYvx7hcdiXIriCj/XvADf06pAvvlTLQEo+k9qaxg6cJGuy
 o8yFVZSAMz7609R0WEXFXW4BZXVlmzLplN6tYiUSyuCMzbLJ6K15sT6dYwZJSzLJVzyZZ
 kvxa0lwr3fBg3BU3VsQRZawMTx8t5zTB08N7LBgAOrfkQ9BGC5A1LR4jjxBWZgHB4bPcs
 9NyWWT+5xqAjZfY/T3IX/GBUZzgc/N6AaqqlRxL253r5ffUd8DYnqOS46vGy5RUvzFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=JqP6xpF4; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=JqP6xpF4
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C38A607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:35:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E77A0C211C1;
 Thu, 24 Sep 2026 12:36:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7EFD560341;
 Thu, 24 Sep 2026 12:35:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 02E6210329409; 
 Thu, 24 Sep 2026 14:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253339; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=IT7YTFdTspSYEBmsLQj8Q09jCBJ4n+HDKYZE3cUmbmg=;
 b=JqP6xpF42mEuJBwv0YPR6FopzNEg6uNTDqS7HrIWiqhXBHkYtQjM/UCORy4MhVBsDbQguy
 qLFK6gAop6k/KL795zYGmo0XxraflZ7N9JTmAlsZBQXjAHhhjxeOa+9mTZzRZ0dEQSTJ4u
 oiUOEKFmY3C/7jsWw8o7wr/gIpeEkyrpYX2s8xzVveY4lBF+enikEHv1duz0zcsR4e6cUj
 0Glm6E4QTTqL/uf3AAydk2L37SNWZMVV57SGOt3D2rM0fYSBNhraOrbPfD7Pp2SiVt4Afd
 Y9mk1SmbREO13blod6oIR1BZTFt+vmJpWSIxmm0o7013HTCipk3FIKnhl+WY0A==
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
Subject: [PATCH v6 00/22] Introduce resume for J7xx SoCs
Date: Thu, 24 Sep 2026 14:35:11 +0200
Message-ID: <20260924123533.2599438-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
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
Patch 22 add the resume flow documentation

Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-min-context-restore

It needs lpm_memory_regions described in DTS [updated to v4]:
https://lore.kernel.org/lkml/20260921145325.300025-1-richard.genoud@bootlin.com/T/#t

It also needs a bootph-pre-ram property in PMIC-B for j721s2:
https://lore.kernel.org/linux-arm-kernel/20260429-k3-j721s2-som-bootph-pre-ram-pmic-4c-v2-1-31a0e7677216@bootlin.com/

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
 arch/arm/mach-k3/common.h                     |   16 +
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
 arch/arm/mach-k3/r5/common.c                  |   20 +-
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
 drivers/firmware/ti_sci.c                     |  219 +++
 drivers/firmware/ti_sci.h                     |  108 ++
 drivers/ram/k3-ddrss/Makefile                 |    1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c           |  181 ++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h           |   20 +
 drivers/ram/k3-ddrss/k3-ddrss.c               |  295 ++-
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h          |   94 +
 drivers/remoteproc/ti_k3_arm64_rproc.c        |   10 +-
 include/linux/soc/ti/ti_sci_protocol.h        |   17 +
 tools/binman/etype/ti_board_config.py         |    4 +-
 61 files changed, 4501 insertions(+), 198 deletions(-)
 create mode 100644 arch/arm/mach-k3/lpm-common.h
 create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
 create mode 100644 doc/board/ti/img/resume_diagram_k3.svg
 create mode 100644 drivers/ram/k3-ddrss/k3-ddrss-lpm.c
 create mode 100644 drivers/ram/k3-ddrss/k3-ddrss-lpm.h
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h


base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.55.0

