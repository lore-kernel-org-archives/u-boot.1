Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53331CA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8826488970;
	Mon,  2 Sep 2024 00:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jrL3IOL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A7987CF8; Mon,  2 Sep 2024 00:26:47 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF56D888B2
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82a1af43502so175542739f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229603; x=1725834403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3/xvD2BTz5Y548kO4IIoefy3PnlxFbeD9MWRbyb0e4Y=;
 b=jrL3IOL5iOTUN3c6GwLCk9fA9XXttdtOmqYV23wFsrEBN3I9sBDKXqCteL+xleaNs0
 AWG87yjXMljdIrk7cVHHavXlbhkgDDJUFcDAmJXdV3ar5m4HPalknXp097ooRsq3pSZh
 aImA74CsWodei0RELV9dDifE6V5Ox19qOxRSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229603; x=1725834403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/xvD2BTz5Y548kO4IIoefy3PnlxFbeD9MWRbyb0e4Y=;
 b=XYNLYDt468BnpLW9dJ9q6o/ZFg2Cpq8L89WSY1gLIkqaiExGPyXp7tx2SpCob/L3fu
 6d5IpXJYVSbFjEKV7uo/j7NcCa8N5xQR8/WWvwgaTcqjR+MtU45Xa1gp6P91A1kdZAOw
 Q6gdeSemN0rG9yAPJbjqgYhM7NFQiy+P9BOSDe0gPL/urEkrZ6SjclETp1JpKXw7+6lE
 y52bLsmqMX0bcACq4h5yfioF0Tg0UqvdASfAdq5qLRskmzMXy2ITgoEl8xEQ5hcARc3R
 qHwlF0DG4LtyCjfxP9hW/3pjMAJbAb8foD+Sj/zrndCh1MU97AY6jloZDn138Ozxkbhh
 Mv4g==
X-Gm-Message-State: AOJu0Yw1FGU1aU3qwF/vvKFIR0sTFssUmCQMRvTexoP28z3AkKYwP5Nz
 yPexkArUuEDFYJ1DHzv5qffxCvoBgthuEdQDsqMgn595yw/F7ibIHuhoPT4AUibSM9dmKj09zuc
 =
X-Google-Smtp-Source: AGHT+IGT43lW18Ft++tgEKq3HT8FKIfV7gHtDAy2j24i2xQArUfQyBUeURCLUSDLImCCGA564C8suA==
X-Received: by 2002:a05:6602:60c7:b0:807:f0fb:11a2 with SMTP id
 ca18e2360f4ac-82a11094588mr1529332039f.13.1725229603092; 
 Sun, 01 Sep 2024 15:26:43 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v4 00/23] Fix various bugs
Date: Sun,  1 Sep 2024 16:26:11 -0600
Message-Id: <20240901222634.460873-1-sjg@chromium.org>
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

This series includes the patches needed to make make the EFI 'boot' test
work. That test has now been split off into a separate series along with
the EFI patches.

This series fixes these problems:
- sandbox memory-mapping conflict with PCI
- the fix for that causes the mbr test to crash as it sets up pointers
  instead of addresses for its 'mmc' commands
- the mmc and read commands which cast addresses to pointers
- a tricky bug to do with USB keyboard and stdio
- a few other minor things

Note that I would like to get this series applied before the change to
running unprivileged, since it has been almost a month and it will be a
trivial change once that is applied.

Changes in v4:
- Rebase to -next (on top of testc series)
- Drop patch to add UT_TESTF_CONSOLE_REC to bootflow tests

Changes in v3:
- Include the usb.h header file in all cases
- Correct the commit subject and message
- Add a Fixes tag
- use SZ_512 instead of 0x200

Changes in v2:
- Add many new patches to resolve all the outstanding test issues

Simon Glass (23):
  nvmxip: Drop the message on probe
  nvmxip: Avoid probing on boot
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

 arch/sandbox/cpu/cpu.c             |  38 ++-
 arch/sandbox/cpu/state.c           |   9 +-
 arch/sandbox/include/asm/state.h   |   3 +
 arch/sandbox/lib/pci_io.c          |   9 +-
 cmd/mem.c                          |  26 +-
 cmd/mmc.c                          |  15 +-
 cmd/read.c                         |  10 +-
 cmd/usb.c                          |  20 --
 common/console.c                   |  36 +++
 common/log.c                       |   1 +
 common/usb_kbd.c                   |  74 +----
 doc/arch/sandbox/sandbox.rst       |  21 +-
 drivers/mtd/nvmxip/nvmxip-uclass.c |  10 +-
 drivers/usb/Kconfig                |   3 +-
 include/console.h                  |   8 +
 include/log.h                      |   2 +
 include/usb.h                      |  20 +-
 scripts/pylint.base                | 462 +++++++++++++++++------------
 test/boot/bootdev.c                |  19 +-
 test/boot/bootstd_common.c         |   6 +
 test/boot/bootstd_common.h         |   8 +
 test/cmd/mbr.c                     | 172 +++++------
 test/py/tests/test_ut.py           |  94 +++---
 test/test-main.c                   |  38 +++
 24 files changed, 620 insertions(+), 484 deletions(-)

-- 
2.34.1

