Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874E7C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E01687FCD;
	Sun, 21 Jul 2024 12:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lz+GcM8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6D787F7D; Sun, 21 Jul 2024 12:09:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5430E87B8D
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso14978375e9.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556586; x=1722161386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kS6aLBTsVtIDYgmWztIQWA0s5KVUKYNwIMeTY1YFVeg=;
 b=lz+GcM8tU803MzcEkWRp1sZVXApwAMz9tZK5E1bLggHTmykqWMh2UEtZZ+5T/o2y97
 8NdqpCouhbtt/rnxtrdCT7MlcIEZGu4Xs+RCophqv5ztG+vnOJpnqYNnK//VpZIEZAML
 eagQ1rA/iKD1suCbxOQpXOoWdy9m1niTdoXbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556586; x=1722161386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kS6aLBTsVtIDYgmWztIQWA0s5KVUKYNwIMeTY1YFVeg=;
 b=wOBP4riuO/jmeM6Od16QmNSkqVx80yGHrpsUrDL1nTnWFfqdBOgKo8YUmCRiZHS8RY
 JUweysbhsI5KwCk4eWpgXW4RBfr6HDKgcWT9XStZuoaRQ/ypVQj9uQ8S0MPF+vgopvT1
 tOfqofp24Ik4h9YL1wYRvIXg6u2RgAvXpzCkpq0S3V74md3XLamv2ZTznpc5Zc4eawEZ
 Dx/T95x+R549s4NayeGL+di3BqINCIEZChznUr5gnspnFfjJlUDdj2Z0FFbiIZcAV2Ol
 BsmZjQf0GojwI1XovAA+93ue6YpA/0cdgmgoHQjiL69uO8gYMcG3YWS1TusdXc0KNu6e
 qh3g==
X-Gm-Message-State: AOJu0Yzs9eMCgb6idN/XXmr0FiKz8hEc6PL6Q/VewmB1L08qXdtUv7mI
 y9JDnXGX9pAqfuJrYRvvasfvLBIB/Ni16QBNkghAXMk/GTcVxaT59EObNp4/FnY2ZTWqf53wlaY
 =
X-Google-Smtp-Source: AGHT+IGMIGOLNBiEE0swKD1hL4tyYt1UjSbfs9O/QHFfqHJ0fFoJtvnQtdgLNB9/xaJHVZSdpjmC5g==
X-Received: by 2002:a05:600c:1e19:b0:424:a401:f012 with SMTP id
 5b1f17b1804b1-427da7f3d1amr23393095e9.3.1721556586124; 
 Sun, 21 Jul 2024 03:09:46 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:09:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v3 00/21] Universal Payload initial series
Date: Sun, 21 Jul 2024 11:09:18 +0100
Message-Id: <20240721100940.3202027-1-sjg@chromium.org>
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

Universal Payload (UPL) is an Industry Standard for firmware
components[1]. UPL is designed to improve interoperability within the
firmware industry, allowing mixing and matching of projects with less
friction and fewer project-specific implementations. UPL is
cross-platform, supporting ARM, x86 and RISC-V initially.

This series provides some initial support for this, targeting 0.9.1 and
sandbox only.

Features still to come include:
- Support for architectures
- FIT validation
- Handoff validation
- Interoperability tests

This series is available at dm/uplb-working and requires the alist
series at dm/alist-working[2]

[1] https://universalpayload.github.io/spec/
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=414642

Changes in v3:
- Use longer error messages
- Use -errno instead of inventing a new error
- Use sizeof(*header) instead of 512
- Use a block size of 1 if !CONFIG_SPL_LOAD_BLOCK
- Fix 'handed' typo
- Rebase on earlier change
- Allow up.h to be built by the host build
- Split out into its own commit

Changes in v2:
- Put the upl tests under their own subcommand to avoid bootstd init
- Add a function to init the UPL process in SPL
- Hang when something goes wrong, to avoid a broken boot
- Add a runtime flag to enable UPL
- Put upl_image() calls in a common place
- Add a link to the spec
- Add a link to the command
- Support CI testing
- Rework to use alist instead of fixed-length arrays

Simon Glass (21):
  sandbox: Use const in os_jump_to_file()
  sandbox: Fix a comment in os_find_u_boot()
  test: Move some SPL-loading test-code into sandbox common
  fdt: Don't overwrite bloblist devicetree
  sandbox: fdt: Avoid overwriting an existing fdt
  sandbox: Return error code from read/write/seek
  sandbox: Add ELF file to VPL u-boot.img
  sandbox: Set up global_data earlier
  upl: Add support for reading a upl handoff
  upl: Add support for writing a upl handoff
  upl: Add basic tests
  upl: Add a command
  upl: Add support for Universal Payload in SPL
  spl: Set SPL_FIT_FOUND for full FIT also
  spl: Plumb in the Universal Payload handoff
  upl: Plumb in universal payload to the init process
  sandbox_vpl: Enable Universal Payload
  upl: Add initial documentation
  sandbox: Add a flag to enable UPL
  sandbox: Add an SPL loader for UPL
  upl: Add an end-to-end test

 MAINTAINERS                       |  13 +
 Makefile                          |   4 +-
 arch/sandbox/cpu/cpu.c            |   2 +
 arch/sandbox/cpu/os.c             |  30 +-
 arch/sandbox/cpu/spl.c            | 120 +++++-
 arch/sandbox/cpu/start.c          |  18 +-
 arch/sandbox/include/asm/spl.h    |  15 +
 arch/sandbox/include/asm/state.h  |   1 +
 boot/Kconfig                      |  70 ++++
 boot/Makefile                     |   4 +
 boot/image-fit.c                  |   4 +
 boot/upl_common.c                 |  60 +++
 boot/upl_common.h                 |  24 ++
 boot/upl_read.c                   | 588 ++++++++++++++++++++++++++++
 boot/upl_write.c                  | 622 ++++++++++++++++++++++++++++++
 cmd/Kconfig                       |   7 +
 cmd/Makefile                      |   1 +
 cmd/upl.c                         | 118 ++++++
 common/board_f.c                  |  22 ++
 common/board_r.c                  |   2 +
 common/spl/Makefile               |   2 +
 common/spl/spl.c                  |   8 +
 common/spl/spl_fit.c              |  10 +
 common/spl/spl_upl.c              | 171 ++++++++
 configs/sandbox_defconfig         |   1 +
 configs/sandbox_vpl_defconfig     |   4 +
 doc/usage/cmd/upl.rst             | 186 +++++++++
 doc/usage/index.rst               |   2 +
 doc/usage/upl.rst                 |  46 +++
 drivers/block/sandbox.c           |   4 +-
 drivers/usb/emul/sandbox_flash.c  |   2 +-
 fs/sandbox/sandboxfs.c            |   6 +-
 include/asm-generic/global_data.h |  19 +
 include/os.h                      |   6 +-
 include/spl.h                     |  16 +
 include/test/suites.h             |   1 +
 include/upl.h                     | 364 +++++++++++++++++
 lib/fdtdec.c                      |   1 +
 test/boot/Makefile                |   2 +
 test/boot/upl.c                   | 437 +++++++++++++++++++++
 test/cmd_ut.c                     |   3 +
 test/image/spl_load_os.c          |  53 +--
 test/py/tests/test_upl.py         |  38 ++
 43 files changed, 3035 insertions(+), 72 deletions(-)
 create mode 100644 boot/upl_common.c
 create mode 100644 boot/upl_common.h
 create mode 100644 boot/upl_read.c
 create mode 100644 boot/upl_write.c
 create mode 100644 cmd/upl.c
 create mode 100644 common/spl/spl_upl.c
 create mode 100644 doc/usage/cmd/upl.rst
 create mode 100644 doc/usage/upl.rst
 create mode 100644 include/upl.h
 create mode 100644 test/boot/upl.c
 create mode 100644 test/py/tests/test_upl.py

-- 
2.34.1

