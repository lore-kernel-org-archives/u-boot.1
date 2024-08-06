Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6454C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239AB886F0;
	Tue,  6 Aug 2024 15:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GU4mP5ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B381787EED; Tue,  6 Aug 2024 14:59:12 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82FAD8811A
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81fd9251d99so22527439f.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949136; x=1723553936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GfZ9t3xLlxEzw6xi+fL91T+M6aXLw83ytGhZc1X3Pa4=;
 b=GU4mP5ZHBlGQLlpOzYdaYleqe3wD51edx+LxejxjKPmrucZpuVem2baIFW1l0+hkZV
 iAXEq6IsUydw1Eio/sDqsE6xsb3xImkUXUcUQDVwECU04gU324Z+6dpXt9gU/6qvj4ef
 d+p8krg3IQRN+57K89r3GdS1OwptkYpviMMqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949136; x=1723553936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfZ9t3xLlxEzw6xi+fL91T+M6aXLw83ytGhZc1X3Pa4=;
 b=hmQdsk7rBw3Jsx26a1jDEA/pBmCZuBZ6Te2iZtC60SZrNahNF3Hni1ZtdeqHLvxNfw
 v0yYEMF/JwKk8mO0RCwz1yJr+vFF3KKBieYKZ6W8qffcFUv5X42LexnJ02wRfIEGDB2R
 6dyxBYJdMwReeAjOrFa2sGW7vLjY4l/iNQtE7rg5ld6panno1oXixk0r/HdycPjVNTcg
 JyiuBj947C9kOKgzMUedLDIxpKTbi/CPdhSiwzTiG+xn0TK16kf5M7Z77RwFPX4xGtEG
 Fc44G+qDa7LoQhr/uL3ofWPr+HymMAGax/voRDo1aum/ihXGS+KmGwi/a6blCtj6yRWz
 74jQ==
X-Gm-Message-State: AOJu0YzoTm2MYdCZQajgU2/QMKZxhgqrmkbi6Sw2+Q8PFkGqp5cqq4J5
 TTxt555wlXbo/CAEqcCiNyMaNP6Zg32dovSytbHGzaEUAhiDUnjTQF6W2VDS4SUH6kwvKNspWSc
 =
X-Google-Smtp-Source: AGHT+IGAUgq3XoOzKjz5/KQlgkeMHn8hbMAqGE/jeacsXN6DnsGqs16f9GuvYgNO/sXtaPsa1eFw/w==
X-Received: by 2002:a05:6e02:58a:b0:39b:3e01:cbd4 with SMTP id
 e9e14a558f8ab-39b3e01cc55mr70502985ab.14.1722949135971; 
 Tue, 06 Aug 2024 05:58:55 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:58:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Aaron Williams <awilliams@marvell.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Heiko Schocher <hs@denx.de>,
 Ion Agorria <ion@agorria.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Neal Gompa <neal@gompa.dev>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Stephen Warren <swarren@nvidia.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 William Zhang <william.zhang@broadcom.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 00/39] efi: Add a test for EFI bootmeth
Date: Tue,  6 Aug 2024 06:58:11 -0600
Message-Id: <20240806125850.2316956-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Aug 2024 15:18:15 +0200
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

Changes in v2:
- Fix 'use' typo
- Add many new patches to resolve all the outstanding test issues

Simon Glass (39):
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
  read: Use map_sysmem() with buffers in the read command
  cmd: Fix memory-mapping in cmp command
  test: mbr: Unmap the buffers after use
  test: mbr: Use a constant for the block size
  test: mbr: Use RAM for the buffers
  test: mbr: Drop a duplicate test
  efi: Use puts() in cout so that console recording works
  efi_loader: Put back copyright message
  efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
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

 arch/arm/lib/Makefile               |   2 +-
 arch/riscv/lib/Makefile             |   2 +-
 arch/sandbox/cpu/cpu.c              |  38 ++-
 arch/sandbox/cpu/state.c            |   9 +-
 arch/sandbox/dts/test.dts           |   2 +-
 arch/sandbox/include/asm/state.h    |   3 +
 arch/sandbox/lib/pci_io.c           |   9 +-
 arch/x86/lib/Makefile               |   2 +-
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
 include/efi_default_filename.h      |  25 +-
 include/efi_loader.h                |  21 +-
 include/log.h                       |   2 +
 include/usb.h                       |  20 +-
 lib/efi_loader/Kconfig              |  22 ++
 lib/efi_loader/Makefile             |  47 +--
 lib/efi_loader/efi_console.c        |  28 +-
 lib/efi_loader/efi_disk.c           |  14 +-
 lib/efi_loader/helloworld.c         |   6 +
 lib/efi_loader/testapp.c            |  68 ++++
 scripts/pylint.base                 | 461 ++++++++++++++++------------
 test/boot/bootdev.c                 |  37 ++-
 test/boot/bootflow.c                | 119 +++++--
 test/boot/bootstd_common.c          |  12 +
 test/boot/bootstd_common.h          |   8 +
 test/cmd/mbr.c                      | 132 ++++----
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_efi_fit.py       |   2 +-
 test/py/tests/test_efi_loader.py    |   2 +-
 test/py/tests/test_ut.py            | 146 +++++----
 test/test-main.c                    |  38 +++
 48 files changed, 949 insertions(+), 610 deletions(-)
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.34.1

