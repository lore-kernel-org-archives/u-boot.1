Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AFFC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C25588883;
	Sun, 11 Aug 2024 16:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mBu+dzjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E67A688883; Sun, 11 Aug 2024 16:52:33 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37E6884DB
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39b4f847a5eso11660005ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387950; x=1723992750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jdcnXbUPwvOGRzmKwzZOcYD5r9cRZQk1vmQR/KcAzq4=;
 b=mBu+dzjn9XDCLLuhakq6YlNhazSRvK0ZrROePH/o6Ecoo4y9yx71me2P0N4+1zV0Bj
 WkkFyJyMsExOe9xBFdDCEGRBgkVqbzMyakbEopwJpFQylnBS7sLclw7ssqfZCUtQQrKa
 9jGd75P6iLK5FxpbS2svhZPyryul4iTQZZYSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387950; x=1723992750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jdcnXbUPwvOGRzmKwzZOcYD5r9cRZQk1vmQR/KcAzq4=;
 b=Vd4p1tkTyQGpHDbcH3PBQswIRto3d7OzNa2stK51e/qHoyzNawwuVYerFpQYaxUGH2
 AD+vvO6U9lQ+mKuFOc9KWninGkppKDha7JDRz0oVxclsFklIHkIAwfDYDlvDANPaecEx
 PJeKVSSerraJG5iFRWx3AYkFLxMLy/jXBsoBwPTP3+LNHxoZ77DofLa2X+3twUzzsvSx
 VlH+ERS6CxS9g7snM3go6cvTmMa/WDt7j2RZe6IbFRWknX+23A/eCfWP+nZhRcxilV3U
 0oFOfj71qtq/ZYD61z7BgLEg5hE5hbYvG9NfTZVcEcl6qq5yfTkje0BL36mrWmq3Gh1K
 vxpg==
X-Gm-Message-State: AOJu0YzO4c8rIpPnH0Dfj2DFACoxdH1mGo5hkIBvC8jYAINf3rPhXRzD
 z+tPuGU1bjR3zxZ/4+uJIkeGxuvYrr4Go5X29UMc2pgFyn70JeqCA0mAs/Se9hRke4jMbDhVfjg
 =
X-Google-Smtp-Source: AGHT+IHGO7pISOwhD5bAfzibM043Drwy7Ac2x8wZMvpgYVp+OZKXh5TbuwFCX24WVDbpZWhZKJpoQA==
X-Received: by 2002:a05:6e02:1807:b0:39b:362f:e6b5 with SMTP id
 e9e14a558f8ab-39b6c2285d1mr107896365ab.0.1723387950370; 
 Sun, 11 Aug 2024 07:52:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v3 00/40] efi: Add a test for EFI bootmeth
Date: Sun, 11 Aug 2024 08:51:29 -0600
Message-Id: <20240811145209.4191404-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

The test coverage for the EFI bootmeth is incomplete since it does not
actually boot the application.

This series creates a simple test for this purpose. It includes a
surprising number patches to make this work:

- sandbox memory-mapping conflict with PCI
- the fix for that causes the mbr test to crash as it sets up pointers
  instead of addresses for its 'mmc' commands
- the mmc and read commands which cast addresses to pointers
- ANSI output from the EFI loader confusing the unit-testing checker
- bug in bootdev_next_prio() which causes an infinite loop in EFI test
- Hang in sandbox virtio due to EFI probing all block devices
- a tricky bug to do with USB keyboard and stdio
- a few other minor things

Changes in v3:
- Include the usb.h header file in all cases
- Correct the commit subject and message
- Add a Fixes tag
- use SZ_512 instead of 0x200
- Drop the extra- rules since scripts/Makefile.lib takes care of it
- Add new patch to drop crt0/relocal extra- rules
- Update commit message to describe how the problem will be addressed
- Fix 'virtual' typo
- Put back the Linaro copyright accidentally removed
- Add a Fixes tag
- Mention the issue created for this problem

Changes in v2:
- Fix 'use' typo
- Reword commit message
- Use 'Firmware vendor' instead of just 'Vendor'
- Add many new patches to resolve all the outstanding test issues

Simon Glass (40):
  nvmxip: Drop the message on probe
  nvmxip: Avoid probing on boot
  bootstd: Add UT_TESTF_CONSOLE_REC to bootflow tests
  test/py: Fix some pylint warnings in test_ut.py
  scripts: Update pylint.base
  bootstd: Create a function to reset USB
  usb: Drop old non-DM code
  log: Add a new log category for the console
  usb: Add DEV_FLAGS_DM to stdio for USB keyboard
  dm: usb: Deal with USB keyboard persisting across tests
  test: mbr: Adjust test to use lower-case hex
  test: mbr: Adjust test to drop 0x
  sandbox: Change the range used for memory-mapping tags
  sandbox: Update cpu to use logging
  sandbox: Unmap old tags
  sandbox: Add some debugging to pci_io
  sandbox: Implement reference counting for address mapping
  mmc: Use map_sysmem() with buffers in the mmc command
  read: Tidy up use of map_sysmem() in the read command
  cmd: Fix memory-mapping in cmp command
  test: mbr: Unmap the buffers after use
  test: mbr: Use a constant for the block size
  test: mbr: Use RAM for the buffers
  test: mbr: Drop a duplicate test
  efi: Use puts() in cout so that console recording works
  efi_loader: Put back copyright message
  efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
  efi: arm: x86: riscv: Drop crt0/relocal extra- rules
  efi_loader: Shorten the app rules
  efi_loader: Shorten the app rules further
  efi: Show the vendor in helloworld
  Revert "bootdev: avoid infinite probe loop"
  bootstd: Make bootdev_next_prio() continue after failure
  efi: Use the same filename for all sandbox builds
  bootstd: Add debugging for efi bootmeth
  efi: Disable ANSI output for tests
  efi: Add a test app
  efi: Avoid using sandbox virtio devices
  test: Set up an image suitable for EFI testing
  efi: Add a test for the efi bootmeth

 arch/arm/lib/Makefile               |   8 -
 arch/riscv/lib/Makefile             |   4 -
 arch/sandbox/cpu/cpu.c              |  38 ++-
 arch/sandbox/cpu/state.c            |   9 +-
 arch/sandbox/dts/test.dts           |   2 +-
 arch/sandbox/include/asm/state.h    |   3 +
 arch/sandbox/lib/pci_io.c           |   9 +-
 arch/x86/lib/Makefile               |  16 -
 boot/bootdev-uclass.c               |  23 +-
 boot/bootmeth_efi.c                 |  11 +-
 cmd/Kconfig                         |  14 +-
 cmd/mem.c                           |  26 +-
 cmd/mmc.c                           |  15 +-
 cmd/read.c                          |  10 +-
 cmd/usb.c                           |  20 --
 common/console.c                    |  36 +++
 common/log.c                        |   1 +
 common/usb_kbd.c                    |  74 +----
 configs/octeontx2_95xx_defconfig    |   2 +-
 configs/octeontx2_96xx_defconfig    |   2 +-
 configs/octeontx_81xx_defconfig     |   2 +-
 configs/octeontx_83xx_defconfig     |   2 +-
 doc/arch/sandbox/sandbox.rst        |  21 +-
 doc/develop/uefi/uefi.rst           |   2 +-
 drivers/mtd/nvmxip/nvmxip-uclass.c  |  10 +-
 drivers/usb/Kconfig                 |   3 +-
 include/console.h                   |   8 +
 include/efi_default_filename.h      |  24 +-
 include/efi_loader.h                |  21 +-
 include/log.h                       |   2 +
 include/usb.h                       |  20 +-
 lib/efi_loader/Kconfig              |  22 ++
 lib/efi_loader/Makefile             |  47 +--
 lib/efi_loader/efi_console.c        |  28 +-
 lib/efi_loader/efi_disk.c           |  14 +-
 lib/efi_loader/helloworld.c         |   6 +
 lib/efi_loader/testapp.c            |  68 ++++
 scripts/pylint.base                 | 462 ++++++++++++++++------------
 test/boot/bootdev.c                 |  37 ++-
 test/boot/bootflow.c                | 119 +++++--
 test/boot/bootstd_common.c          |   6 +
 test/boot/bootstd_common.h          |   8 +
 test/cmd/mbr.c                      | 173 ++++++-----
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_efi_fit.py       |   2 +-
 test/py/tests/test_efi_loader.py    |   2 +-
 test/py/tests/test_ut.py            | 146 +++++----
 test/test-main.c                    |  38 +++
 48 files changed, 962 insertions(+), 654 deletions(-)
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.34.1

