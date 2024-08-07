Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54A7C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D45888FB;
	Thu,  8 Aug 2024 00:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iGKR/Hhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2C8888CF; Thu,  8 Aug 2024 00:48:08 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792F6881E7
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39aeccc6377so1563355ab.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070884; x=1723675684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RKizqlHluTFStJCp36zOy0ZoZaV1jlvFv8zaZg4CYX8=;
 b=iGKR/HhiLLjtouSr3H5TXzxyssrwtYpOA0xJJRRDEttMuuCImgctPVxVp1PWpWtRk4
 onyCqJVJ7ZK1Xal6S6OhLncJw1QlePm1gdy1jYVzf+gAlfTm3RA8/jn8UvnxP2Jku8TY
 IGy4uT4FK2gjde8B7pedIs+iqvfLG9KsRojdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070884; x=1723675684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RKizqlHluTFStJCp36zOy0ZoZaV1jlvFv8zaZg4CYX8=;
 b=vkLYqqZNvBnOvn3YDDyW1ozf92c0PI9BAAQ/i28cQTmw57jrXiJfKsFglL5pAx16pN
 kL2HWUJ1oVvUv3T4PNGlKGJ36upHaOzkudOb4zOb5ZAAw6baxWeJ4nax3QghCLWqUhfb
 lGp6lUL2jNPHDUk4WZQ0sYnQaq5E944egIQ62saehtp+MI1L5JWzXKEB5sBSXuRtG1YQ
 xZdlhwXSfYtKFoiN+reoa08FMfidA38VOwRWYDsy+qL78ra1/yf1veVvbl5Tvi1nA0RM
 KFrr5ohPxMOhzDiJyNCDWV306dI3XnX3Iu+P1JrodRANarr/SvduqRPvkcofLbEgbxvW
 +QWA==
X-Gm-Message-State: AOJu0YwaESkYc22dSpyAeiPvesxOeiNAllm8qE2gLk3uUXkmky++tIR7
 0LHApXhlEMBtafLmI2At3y7q/VKElloBNkfm6taHCDBDnK2CP+50PWFSPY4aw7uOqrYYOlz4uPc
 =
X-Google-Smtp-Source: AGHT+IGw0dl2Y9GFfZPxDrvIjWmMH9ozClErDZoMQt2JCAa02B8e2/E6+zCIgA98+ppPDLUB4+ykwg==
X-Received: by 2002:a05:6e02:1a4d:b0:39b:37b9:6a8f with SMTP id
 e9e14a558f8ab-39b5ec804d9mr910385ab.7.1723070884055; 
 Wed, 07 Aug 2024 15:48:04 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v4 00/21] Universal Payload initial series
Date: Wed,  7 Aug 2024 16:47:18 -0600
Message-Id: <20240807224739.3858517-1-sjg@chromium.org>
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

Changes in v4:
- Mention the return value in upl_add_image()
- Rebase to -next
- Update alist_add() calls
- Update upl_add_image()  to avoid code-size increase with fdt_getprop()

Changes in v3:
- Allow upl.h to be built by the host build
- Fix 'handed' typo
- Rebase on earlier change
- Split out into its own commit
- Use -errno instead of inventing a new error
- Use a block size of 1 if !CONFIG_SPL_LOAD_BLOCK
- Use longer error messages
- Use sizeof(*header) instead of 512

Changes in v2:
- Add a function to init the UPL process in SPL
- Add a link to the command
- Add a link to the spec
- Add a runtime flag to enable UPL
- Hang when something goes wrong, to avoid a broken boot
- Put the upl tests under their own subcommand to avoid bootstd init
- Put upl_image() calls in a common place
- Rework to use alist instead of fixed-length arrays
- Support CI testing

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
 boot/image-fit.c                  |   3 +
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
 common/spl/spl_fit.c              |   9 +
 common/spl/spl_upl.c              | 172 +++++++++
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
 include/upl.h                     | 382 ++++++++++++++++++
 lib/fdtdec.c                      |   1 +
 test/boot/Makefile                |   2 +
 test/boot/upl.c                   | 437 +++++++++++++++++++++
 test/cmd_ut.c                     |   3 +
 test/image/spl_load_os.c          |  53 +--
 test/py/tests/test_upl.py         |  38 ++
 43 files changed, 3052 insertions(+), 72 deletions(-)
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

