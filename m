Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2DFCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF8C868C1;
	Tue, 17 Oct 2023 00:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CCjd3wlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF9986DEB; Tue, 17 Oct 2023 00:29:10 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A3B803AE
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7741c5bac51so290473085a.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495342; x=1698100142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mLiY86zZAt8qjqATvugju+FGcGr9LW7TOJwkF0ThZAY=;
 b=CCjd3wlfgyqdR2kZ6C/mgaHLUsiUDFWzgfqhQR37tTWzUs7h/yOB7WIiEPTkkn3z9K
 rafsmLyaMNBYqZRCkrTscGfNWwTkF/lO4hNojF1JeV/5wEy7Vd+myGYUWKOpujO+PCtU
 +plDCYKDMPPvfd5FyNrEd7/+P5EffybWNjiCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495342; x=1698100142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mLiY86zZAt8qjqATvugju+FGcGr9LW7TOJwkF0ThZAY=;
 b=T2w0CkltRYH+yDeP0KDpvFSUra08FFJtFGYR0v1YSVSelJ82T0m/w8TiOe07tlzt6B
 vPaiiFVTlB+8xPCr2YYstTXMdEbCcVHOeqa9St82dNopNasuwrFEzyjiUbaNzWPfvWmj
 DUUg/vpBdPrPPZReapBl6mn/TXki/5Cv4MtvYJRZ6aGO3x2Ioqm+CQqKFCGTCIOoKP/q
 3FVecnLgszaZQtA2V8UYKASDvXClw8NJm54j/AwAqZgmdBcdN0M41xiMIo8K/5Ur/pri
 Y7/chC0UssEyFgiYQyIdfvytYHnI0FpTCnwFzF2UPzcGhNxFGAgzwobY2bNk9jrb39Pc
 hg6Q==
X-Gm-Message-State: AOJu0YyiZe7iE3swNZEzUt+8bTgin0SCU37t9JXzI1rygiVxc3VdnQP6
 +/fob97hNGza1AmEMDGhXGtJbDllnAKdAfKbKDkIIQ==
X-Google-Smtp-Source: AGHT+IH+ruPLDFDx8i8TqFtZnoftkwxWKLRbZcH1BNQUsupPosiDkCtpIZbVyG8DAqh3hzSwqGSs/w==
X-Received: by 2002:ae9:e30b:0:b0:765:aa35:f03f with SMTP id
 v11-20020ae9e30b000000b00765aa35f03fmr488224qkf.37.1697495342388; 
 Mon, 16 Oct 2023 15:29:02 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:29:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 00/32] Tidy up use of CONFIG_CMDLINE
Date: Mon, 16 Oct 2023 16:27:51 -0600
Message-ID: <20231016222835.596572-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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

Changes in v3:
- Reword commit message slightly
- Add an explation as to why this patch is here
- Fix 'ut' typo
- Just drop the condition instead
- Add new patch to rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
- Add new patch with a Kconfig for command-line entry
- Add new patch with a Kconfig for command-line entry
- Reorder the Kconfig options a little
- Add new patch to tidy up semicolon after command macros
- Rebase on Tom's LONGHELP series
- Correct 'of' typo

Changes in v2:
- Move AUTOBOOT_USE_MENUKEY under AUTOBOOT
- Change this to use a Kconfig dependency instead of code failing
- Adjust the depends on the commands, instead of EFI_LOADER
- Add new patch to update EFI_LOADER to depend on DM_ETH
- Add new patch to drop discarding of command linker-lists
- Add new patch to unify the U_BOOT_ENV_LOCATION conditions

Simon Glass (32):
  buildman: Use oldconfig when adjusting the config
  bootstd: Correct dependencies on CMDLINE
  autoboot: Correct dependencies on CMDLINE
  cmd: Add a few more dependencies on CMDLINE
  test: Make UNIT_TEST depend on CMDLINE
  sifive: Drop an unnecessary #ifdef
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
  efi: Make commands depend on CMDLINE
  efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
  efi: Update EFI_LOADER to depend on DM_ETH
  cli: Split command-line-editing into its own file
  Add a new Kconfig for command-line entry
  Add a new Kconfig for command-line history
  sandbox: Disable CONFIG_DISTRO_DEFAULTS
  cmd: Make all commands depend on CMDLINE
  sandbox: Avoid requiring cmdline
  arm: x86: Drop discarding of command linker-lists
  mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
  treewide: Tidy up semicolon after command macros
  sandbox: Add a test for disabling CONFIG_CMDLINE

 arch/Kconfig                       |  11 +-
 arch/arm/cpu/u-boot.lds            |   3 -
 arch/arm/lib/bootm.c               |   2 +
 arch/x86/cpu/u-boot-64.lds         |   4 -
 arch/x86/cpu/u-boot-spl.lds        |   4 -
 arch/x86/cpu/u-boot.lds            |   4 -
 board/freescale/common/vid.c       |   2 +-
 board/xilinx/common/fru.c          |   2 +-
 board/xilinx/versal/cmds.c         |   2 +-
 board/xilinx/zynqmp/cmds.c         |   2 +-
 boot/Kconfig                       |  58 ++--
 boot/bootm.c                       |  10 +-
 boot/fdt_support.c                 |   5 +
 cmd/Kconfig                        |  50 ++--
 cmd/Makefile                       |   2 +-
 cmd/btrfs.c                        |   2 +-
 cmd/eeprom.c                       |   2 +-
 cmd/ext2.c                         |   4 +-
 cmd/fdt.c                          |   5 -
 cmd/fs.c                           |   8 +-
 cmd/nvedit.c                       | 122 +--------
 cmd/pinmux.c                       |   2 +-
 cmd/qfw.c                          |   2 +-
 common/Kconfig                     |  12 +
 common/Makefile                    |  10 +-
 common/cli.c                       |   2 +
 common/cli_cread.c                 | 407 +++++++++++++++++++++++++++++
 common/cli_getch.c                 |   1 +
 common/cli_readline.c              | 384 +--------------------------
 common/log.c                       |   4 +-
 common/menu.c                      |  40 ---
 common/menu_key.c                  |  49 ++++
 configs/sandbox64_defconfig        |   1 -
 configs/sandbox_defconfig          |   1 -
 configs/sandbox_flattree_defconfig |   1 -
 configs/sandbox_noinst_defconfig   |   1 -
 configs/sandbox_spl_defconfig      |   1 -
 configs/sandbox_vpl_defconfig      |   1 -
 drivers/fastboot/Kconfig           |   1 +
 drivers/video/Kconfig              |   2 +-
 drivers/video/console_truetype.c   |   4 +
 env/Makefile                       |   1 +
 env/env_set.c                      | 132 ++++++++++
 env/mmc.c                          |   2 +-
 include/bootm.h                    |  15 +-
 include/cli.h                      |  31 +++
 include/command.h                  |   2 +-
 include/env_internal.h             |  23 ++
 include/k210/pll.h                 |   2 +-
 lib/efi_loader/Kconfig             |   7 +-
 lib/efi_loader/Makefile            |   2 +-
 net/Kconfig                        |   1 +
 test/Kconfig                       |   1 +
 test/py/tests/test_sandbox_opts.py |  20 ++
 tools/buildman/builder.py          |   2 +-
 tools/buildman/builderthread.py    |   6 +
 tools/buildman/func_test.py        |   4 +-
 57 files changed, 833 insertions(+), 648 deletions(-)
 create mode 100644 common/cli_cread.c
 create mode 100644 common/menu_key.c
 create mode 100644 env/env_set.c
 create mode 100644 test/py/tests/test_sandbox_opts.py

-- 
2.42.0.655.g421f12c284-goog

