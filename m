Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F293DE95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A273186F32;
	Sun,  8 Oct 2023 01:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i28nudpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B186386EF3; Sun,  8 Oct 2023 01:13:14 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2198886DCB
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-351574aca7bso12197565ab.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720384; x=1697325184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mbNrL1YrJCVzC4lY2j9JAwMzDGmmIVrdum5tgWWkWvE=;
 b=i28nudpCSO07d70WpM8VD3r8TvmpP8LH6aM/T3IvuOwCd290GDvyWuuIZSIQZhrg1W
 dt8ShjlG/hDd7JBvinaijc8ZiiClEtmgVeWu6ZmDiv+xsgX6ekGvgFZeu6sF8455rlKR
 ZNMIC/C3AsO/aY8vhfDw0wRibHypB52jCVnag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720384; x=1697325184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbNrL1YrJCVzC4lY2j9JAwMzDGmmIVrdum5tgWWkWvE=;
 b=A8VpNvFfrQavmRZ/dney2zHjhOidVLkJoaihejF6ZQ4rnXlGj8Z+yCpPSITr3auS05
 BwhWwR1WxTEgX9VU63JZ/YyVc6n3P+xxsL0bDcu5kAFSF/VijD25QxAzrNQNXgoo52Sg
 IS0+YP2e/ep8dSGzxP1IIiADdWo4JEDlsjuOloFqnMaEWCO0zMmyPi3GWsxJxa53ErhY
 mvpIaA6W/tgrYMpP6INr5EQwsKdyoFPt4/0s/yCv+6zFgNP3oyZpLYVp52Dvm7xk715Z
 lp/OSmFCXH9xE0MUs3E/eTOVXTlnMV108V4xzEytdUuOgTSx9XfUMZ4uVpjVbxiV3miQ
 bHng==
X-Gm-Message-State: AOJu0YyrfLA8nOkhoNR22rpzD/vF8VEGD91PJzeSrjmT7/RQQdZrRw/W
 mLFGo+FBwrjZqgDxONYnDnv/qHIoygOTl3gUW38=
X-Google-Smtp-Source: AGHT+IHpJHxLOxKsvB/fDJGeoJ3vR8ppglTwlkeG+Lpwpu7BnlWepvB0fi+/QBKIrUJLqt9w1gMV6A==
X-Received: by 2002:a05:6e02:1248:b0:351:134d:ce46 with SMTP id
 j8-20020a056e02124800b00351134dce46mr9848795ilq.24.1696720383982; 
 Sat, 07 Oct 2023 16:13:03 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 00/27] Tidy up use of CONFIG_CMDLINE
Date: Sat,  7 Oct 2023 17:12:19 -0600
Message-ID: <20231007231255.277623-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It should be possible to disable CONFIG_CMDLINE and have all commands
and related functionality dropped from U-Boot. This is useful when
trying to reduce the size of U-Boot.

Recent changes have stopped this from working.

This series repairs the feature for sandbox and adds a test to stop it
breaking again.

Note that quite a lot of functionality is lost if CONFIG_CMDLINE is
disabled, e.g. networking and most booting options. Further work is
needed to make the option more generally useful.

Changes in v2:
- Move AUTOBOOT_USE_MENUKEY under AUTOBOOT
- Change this to use a Kconfig dependency instead of code failing
- Add new patch to drop discarding of command linker-lists
- Add new patch to unify the U_BOOT_ENV_LOCATION conditions
- Rebase on Tom's LONGHELP series
- Correct 'of' typo

Simon Glass (25):
  buildman: Use oldconfig when adjusting the config
  bootstd: Correct dependencies on CMDLINE
  autoboot: Correct dependencies on CMDLINE
  cmd: Add a few more dependencies on CMDLINE
  test: Make UNIT_TEST depend on CMDLINE
  sifive: Change #ifdef for nop
  fastboot: Declare a dependency on CMDLINE
  cli: Always build cli_getch
  cmd: Use an #ifdef around run_commandf()
  Move bootmenu_conv_key() into its own file
  pxe: Depend on CMDLINE
  env: Split out non-command code into a new file
  console: Move SYS_PBSIZE into common/
  bootm: Allow building when cleanup functions are missing
  fdt: Move working_fdt into fdt_support
  net: Depend on CONFIG_CMDLINE
  log: Allow use without CONFIG_CMDLINE
  video: Allow use without CONFIG_CMDLINE
  video: Dont require the font command
  efi: Depend on CMDLINE for efi_loader
  cmd: Make all commands depend on CMDLINE
  sandbox: Avoid requiring cmdline
  arm: x86: Drop discarding of command linker-lists
  mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
  sandbox: Add a test for disabling CONFIG_CMDLINE

Tom Rini (2):
  command.h: Add a U_BOOT_LONGHELP macro
  cmd: Convert existing long help messages to the new macro

 arch/Kconfig                                  |   6 +-
 arch/arm/cpu/u-boot.lds                       |   3 -
 arch/arm/lib/bootm.c                          |   2 +
 arch/arm/mach-imx/cmd_nandbcb.c               |   6 +-
 arch/x86/cpu/u-boot-64.lds                    |   4 -
 arch/x86/cpu/u-boot-spl.lds                   |   4 -
 arch/x86/cpu/u-boot.lds                       |   4 -
 board/freescale/common/ngpixis.c              |   6 +-
 .../work_92105/work_92105_display.c           |  12 +-
 board/xilinx/common/fru.c                     |   7 +-
 board/xilinx/versal/cmds.c                    |   7 +-
 board/xilinx/zynq/cmds.c                      |   6 +-
 board/xilinx/zynqmp/cmds.c                    |   6 +-
 boot/Kconfig                                  |  48 ++++---
 boot/bootm.c                                  |  10 +-
 boot/fdt_support.c                            |   5 +
 cmd/Kconfig                                   |  25 ++--
 cmd/Makefile                                  |   2 +-
 cmd/acpi.c                                    |   6 +-
 cmd/aes.c                                     |   6 +-
 cmd/armffa.c                                  |   4 +-
 cmd/axi.c                                     |   4 +-
 cmd/bloblist.c                                |   6 +-
 cmd/bootcount.c                               |   9 +-
 cmd/bootdev.c                                 |   6 +-
 cmd/bootefi.c                                 |   6 +-
 cmd/bootflow.c                                |   9 +-
 cmd/booti.c                                   |   6 +-
 cmd/bootm.c                                   |   6 +-
 cmd/bootmeth.c                                |   6 +-
 cmd/bootz.c                                   |   6 +-
 cmd/cat.c                                     |   6 +-
 cmd/cedit.c                                   |   6 +-
 cmd/clk.c                                     |   6 +-
 cmd/conitrace.c                               |   4 +-
 cmd/cpu.c                                     |   7 +-
 cmd/cyclic.c                                  |   4 +-
 cmd/dm.c                                      |   7 +-
 cmd/efidebug.c                                |   6 +-
 cmd/event.c                                   |   6 +-
 cmd/fdt.c                                     |  11 +-
 cmd/font.c                                    |   6 +-
 cmd/help.c                                    |   5 +-
 cmd/i2c.c                                     |   6 +-
 cmd/kaslrseed.c                               |   6 +-
 cmd/log.c                                     |   7 +-
 cmd/mp.c                                      |   6 +-
 cmd/mtd.c                                     |   6 +-
 cmd/mtdparts.c                                |   6 +-
 cmd/mux.c                                     |   4 +-
 cmd/nand.c                                    |   6 +-
 cmd/nvedit.c                                  | 128 +----------------
 cmd/osd.c                                     |   4 +-
 cmd/pcap.c                                    |   4 +-
 cmd/pci.c                                     |   6 +-
 cmd/pci_mps.c                                 |   6 +-
 cmd/riscv/sbi.c                               |   7 +-
 cmd/rng.c                                     |   6 +-
 cmd/sandbox/exception.c                       |   5 +-
 cmd/scp03.c                                   |   7 +-
 cmd/sf.c                                      |   8 +-
 cmd/source.c                                  |   9 +-
 cmd/ti/pd.c                                   |  10 +-
 cmd/vbe.c                                     |   6 +-
 cmd/wdt.c                                     |   4 +-
 cmd/ximg.c                                    |   6 +-
 cmd/xxd.c                                     |   6 +-
 common/Kconfig                                |   5 +
 common/Makefile                               |   3 +-
 common/cli.c                                  |   2 +
 common/cli_getch.c                            |   1 +
 common/log.c                                  |   4 +-
 common/menu.c                                 |  40 ------
 common/menu_key.c                             |  49 +++++++
 drivers/fastboot/Kconfig                      |   1 +
 drivers/video/Kconfig                         |   2 +-
 drivers/video/console_truetype.c              |   4 +
 env/Makefile                                  |   1 +
 env/env_set.c                                 | 132 ++++++++++++++++++
 env/mmc.c                                     |   2 +-
 include/bootm.h                               |  15 +-
 include/command.h                             |   3 +
 include/env_internal.h                        |  23 +++
 include/k210/pll.h                            |   2 +-
 lib/efi_loader/Kconfig                        |   2 +
 net/Kconfig                                   |   1 +
 test/Kconfig                                  |   1 +
 test/cmd_ut.c                                 |   6 +-
 test/fuzz/cmd_fuzz.c                          |   7 +-
 test/py/tests/test_sandbox_opts.py            |  20 +++
 tools/buildman/builder.py                     |   2 +-
 tools/buildman/builderthread.py               |   6 +
 tools/buildman/func_test.py                   |   4 +-
 93 files changed, 462 insertions(+), 462 deletions(-)
 create mode 100644 common/menu_key.c
 create mode 100644 env/env_set.c
 create mode 100644 test/py/tests/test_sandbox_opts.py

-- 
2.42.0.609.gbb76f46606-goog

