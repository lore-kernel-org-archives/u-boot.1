Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2B5C54FC6
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6928871A;
	Mon,  2 Sep 2024 03:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bc8B8uhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E618A886E5; Mon,  2 Sep 2024 03:18:36 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4D888606
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82a2c93cdcbso89097739f.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239913; x=1725844713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kf8V1sfqrQy2wl1o7Gf98XimNvHc+M9gzOBH7p45wyU=;
 b=bc8B8uhTjOR6gC85KfFLEnAjzzRzneZpa4/hIMD1tdJYvtNfaBxUFoD73iJXJ8N/W5
 Ruzfj7X33+eAXMUZPA9Rzi3oyH1nGgUxxNUKLYbyjcZs4tW4Ro9Q3lgKr1aIue2xHlyk
 qNzQuuNJTXYnLMd69s05EtTATX+ROpYDtdNZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239913; x=1725844713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kf8V1sfqrQy2wl1o7Gf98XimNvHc+M9gzOBH7p45wyU=;
 b=aQxSgQuUA4GDoQGj1+ttPjDIjVIDxQS+FzvIFZ5Mrr6XO3zCMkjeFn/esQbYdWAwIu
 3d1MjIVjOVZmVF1iGCywjHgwdVxhsvwj5llqnM2QJn1ks/Wbc7DA1HBeh7chCQ71vlo2
 9AIoNgv4wKvhM70DdIa0lyi58Pc1rJtliAYCItIcc16F6V51FrmCiN7axlYyw0NNzFz3
 cIyngUuvPulYZFeQzpDm1h3T9UNPV6MbeFFQGQ42wFSq8l9eb+sufQ0qaFQmRPO3qEmW
 rQc9Q3FaS/DGUPUlqUT7+Ph8VYKTMIyGQPby2vpyXS0TOPza6l+LA/MIl/sj1j8YNjac
 LtlQ==
X-Gm-Message-State: AOJu0YwAM4VNKEzVQ1ZnTTpvjrCMnQXBFHqJIAsq6QMDqKpTfZWhQ+fD
 FA/pWmqKgWbHcKZZgtFI1Qs+v5abhRnliCQIvfUfIBp+MrEYz+apOVR7uqss6goJWmBR6KnnPvo
 =
X-Google-Smtp-Source: AGHT+IEIzHyTA8qpMzSWwAvrfi8V7S4FEYimrGx7zJ4oKj0cnWoxqDEi4bhyqcvg1ajpBmRu9kNXhg==
X-Received: by 2002:a05:6e02:156f:b0:383:5520:cc48 with SMTP id
 e9e14a558f8ab-39f4f4bf529mr61351645ab.0.1725239912738; 
 Sun, 01 Sep 2024 18:18:32 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 00/14] efi: Add a test for EFI bootmeth
Date: Sun,  1 Sep 2024 19:18:11 -0600
Message-Id: <20240902011825.746421-1-sjg@chromium.org>
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

This series creates a simple test for this purpose. It includes a few
patches to make this work:

- ANSI output from the EFI loader confusing the unit-testing checker
- Hang in sandbox virtio due to EFI probing all block devices

Other necessary fixes have been split out into two other series.

Changes in v5:
- Drop Fixes tag
- Drop the Fixes tag
- Rebase on updated efif series
- Deal with sandbox CONFIG_LOGF_FUNC

Changes in v4:
- Add efi_loader tag to some patches
- Split out non-EFI patches into a different series

Changes in v3:
- Drop the extra- rules since scripts/Makefile.lib takes care of it
- Add new patch to drop crt0/relocal extra- rules
- Put back the Linaro copyright accidentally removed
- Add a Fixes tag
- Mention the issue created for this problem

Changes in v2:
- Fix 'use' typo
- Reword commit message
- Use 'Firmware vendor' instead of just 'Vendor'
- Add many new patches to resolve all the outstanding test issues

Simon Glass (14):
  efi_loader: Use puts() in cout so that console recording works
  efi_loader: Put back copyright message
  efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
  efi: arm: x86: riscv: Drop crt0/relocal extra- rules
  efi_loader: Shorten the app rules
  efi_loader: Shorten the app rules further
  efi_loader: Show the vendor in helloworld
  efi: Use the same filename for all sandbox builds
  bootstd: Add debugging for efi bootmeth
  efi_loader: Disable ANSI output for tests
  efi_loader: Add a test app
  efi_loader: Avoid using sandbox virtio devices
  test: efi: boot: Set up an image suitable for EFI testing
  test: efi: boot: Add a test for the efi bootmeth

 arch/arm/lib/Makefile               |   8 ----
 arch/riscv/lib/Makefile             |   4 --
 arch/sandbox/dts/test.dts           |   2 +-
 arch/x86/lib/Makefile               |  16 -------
 boot/bootmeth_efi.c                 |  11 ++++-
 cmd/Kconfig                         |  14 +-----
 configs/octeontx2_95xx_defconfig    |   2 +-
 configs/octeontx2_96xx_defconfig    |   2 +-
 configs/octeontx_81xx_defconfig     |   2 +-
 configs/octeontx_83xx_defconfig     |   2 +-
 doc/develop/uefi/uefi.rst           |   2 +-
 include/efi_default_filename.h      |  24 +---------
 include/efi_loader.h                |  21 ++++++++-
 lib/efi_loader/Kconfig              |  22 +++++++++
 lib/efi_loader/Makefile             |  47 ++++++-------------
 lib/efi_loader/efi_console.c        |  28 ++++++++----
 lib/efi_loader/efi_disk.c           |  14 +++++-
 lib/efi_loader/helloworld.c         |   6 +++
 lib/efi_loader/testapp.c            |  68 ++++++++++++++++++++++++++++
 test/boot/bootdev.c                 |  18 +++++++-
 test/boot/bootflow.c                |  66 ++++++++++++++++++++++++++-
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_efi_fit.py       |   2 +-
 test/py/tests/test_efi_loader.py    |   2 +-
 test/py/tests/test_ut.py            |  52 ++++++++++++++++++---
 25 files changed, 310 insertions(+), 125 deletions(-)
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.34.1

