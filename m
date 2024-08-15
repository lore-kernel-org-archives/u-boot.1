Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65219C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA0488ADE;
	Thu, 15 Aug 2024 22:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iEXa4MuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A58D88A95; Thu, 15 Aug 2024 22:25:48 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3680688ABE
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39834949f27so5318715ab.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753541; x=1724358341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RDTnOAdGeWuTQeN+2p5lb9vNqxMcWQBo7C6zL7Zdeoc=;
 b=iEXa4MuCqPAk1IHBIeEoiqZx2pqxLHBGDX8k4m1OaLw4/89gE0eBv+iIG/FE8o2xNC
 mIHHq5gi7N/zmHPMBEgDjZ6X1kY+KxMEWa5OIqeUQ1jrayxF8QUlngYhfZC3yb1qWNZS
 WRM3ogGa1rAkvfi5BW9kep7j57Zp7vqSD1CkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753541; x=1724358341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDTnOAdGeWuTQeN+2p5lb9vNqxMcWQBo7C6zL7Zdeoc=;
 b=neb3/sG4On07ckufkJnVqIGe3tKpYv2O9mqSyTNY0ni+/dA5mp8DYkIsgNYWCTzSWS
 dRC/fVyb0YZtjHQb0dWMXefYrsKpKQox7XwK9kiE6+JIyyaLfKdPt8sp0NEHPhpQJFXY
 tiN9+Vdgxb8bmpjhJ+IAUg1iZFvuz9MOypwdL2meL9IBhzPHmxCnpVVoj99WR47PwrKI
 AnTTZBTjSR01rDRp7JZplfetqneTIbSSnzQscGH3lvVEzU0XQKTmxfHw3FhUmIOVTFUy
 dmTvBv9QoRgVjMtZ9NvkevmGaC9g2txRI45wF1N2K1cruhr/K2Z7kKdI+k1JfKrjWjFz
 MH9g==
X-Gm-Message-State: AOJu0Ywc3YLAvWYLnaxql+2DNuEEweTPhbAT51RxtJbiIji2+utS4UMs
 5r5xzlPdryheaXqKL5FOsuNPxFdzfch94kF3L/L+t/kCdiMKXJo04yEZFgyMLD2BIhEpJc3vDWN
 Qag==
X-Google-Smtp-Source: AGHT+IE+pqtc3GmZK4tCENwBoRJtlloKTvH3JS/kBn0S/KYB0VvyudjlPgjvnh0k/r5AaDlSj2UI+g==
X-Received: by 2002:a05:6e02:1d1d:b0:39b:2aec:6729 with SMTP id
 e9e14a558f8ab-39d26d0499amr8684935ab.12.1723753541366; 
 Thu, 15 Aug 2024 13:25:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v3 00/24] Fix various bugs
Date: Thu, 15 Aug 2024 14:25:11 -0600
Message-Id: <20240815202535.767869-1-sjg@chromium.org>
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

Changes in v3:
- Include the usb.h header file in all cases
- Correct the commit subject and message
- Add a Fixes tag
- use SZ_512 instead of 0x200

Changes in v2:
- Add many new patches to resolve all the outstanding test issues

Simon Glass (24):
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
 test/boot/bootflow.c               |  59 ++--
 test/boot/bootstd_common.c         |   6 +
 test/boot/bootstd_common.h         |   8 +
 test/cmd/mbr.c                     | 173 +++++------
 test/py/tests/test_ut.py           |  94 +++---
 test/test-main.c                   |  38 +++
 25 files changed, 651 insertions(+), 513 deletions(-)

-- 
2.34.1

