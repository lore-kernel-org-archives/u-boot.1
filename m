Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B34CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9842588E5F;
	Fri, 27 Sep 2024 00:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XpH9s025";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC24E88E77; Fri, 27 Sep 2024 00:00:28 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D16088E51
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb321145easo10008476d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388024; x=1727992824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qPTOJ/MPb5haIOT7DpPoaaYgQiZtC/gjLPP/HPSEP+0=;
 b=XpH9s025cDz2iz3ymSpMjKeDLitWww6c2W6q8ue66815h1MfqcfOc742OfMl9aOHur
 KxPz3tR4hhHETomGMrPZJWVMNspgYkHQypPT3cRgeq2+hXojSjUyPNe617+EAbrtFShT
 2gh4fp9x+XSajRPC5+WhgpEjYvZ0sp6GQ8uOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388024; x=1727992824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPTOJ/MPb5haIOT7DpPoaaYgQiZtC/gjLPP/HPSEP+0=;
 b=afsZ06W/HwLUOgPzT2foIu3LhuzzbNoxL9xMBqxjPHUJ9z8LrSG0PkxnNfPR21J09D
 lez8HT4G1fwi0UD8tPee28HXcGtyh+QsMg4I93nnms8d6/l/bllxVserTdRfiQ+Bwgzk
 oiM6lsIA7p8lAKm2TO/1qN9gMOJFSVk0CNKVE/WbmH/cdJ4zPGTrRp/9P30mPVSggs2W
 S0H98/39Q8/K/nwvK2uytudhkJGAtntX6/05uhLTxwel2mG6kUlu7y929iOOAHp7YEAV
 BMU8rWI3t/L1AL8DCgfvvSur55EgiQWv1CYeXsfb5uyPcdsD55K8COWrB0ioxOFy6jrc
 qtUQ==
X-Gm-Message-State: AOJu0Yye43pwVuTXJ5pqUY6aHKwpa92sq4NT+JrIhCt0ObswrwcHT2VK
 i9ZPJgBkED871n6Kd2FGmuZuGeQdGas1ugOufbqLmCD21YGnNYf1VFzLG91By3YW8vMaZdGzaix
 RIJ2bKGc=
X-Google-Smtp-Source: AGHT+IE05ElOPrxS49xPAthTjLeu4hwcXJg1NN85aq/7e3jj/aleEZf5OJ3Qn8f4dmlNvd2QZVDZ7g==
X-Received: by 2002:ad4:4ea7:0:b0:6c3:5ff2:7db3 with SMTP id
 6a1803df08f44-6cb2f27069emr84169286d6.9.1727388024576; 
 Thu, 26 Sep 2024 15:00:24 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b632366sm3079696d6.71.2024.09.26.15.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:00:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v6 00/12] efi: Add a test for EFI bootmeth
Date: Thu, 26 Sep 2024 23:59:30 +0200
Message-ID: <20240926215950.1265143-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Changes in v6:
- Expand the debug messages to be more descriptive
- Drop the patch to disable sandbox virtio blk with EFI
- Add new patch to disable the sandbox virtio blk device
- Deal with sandbox CONFIG_LOGF_FUNC
- Rebase on -next
- Drop patches previously applied
- Drop mention of helloworld since it is no-longer used by this test

Changes in v5:
- Drop the Fixes tag

Changes in v4:
- Add efi_loader tag to some patches
- Split out non-EFI patches into a different series

Changes in v3:
- Drop the extra- rules since scripts/Makefile.lib takes care of it
- Add new patch to drop crt0/relocal extra- rules
- Put back the Linaro copyright accidentally removed

Changes in v2:
- Reword commit message
- Use 'Firmware vendor' instead of just 'Vendor'
- Add many new patches to resolve all the outstanding test issues

Simon Glass (12):
  efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
  efi: arm: x86: riscv: Drop crt0/relocal extra- rules
  efi_loader: Shorten the app rules
  efi_loader: Shorten the app rules further
  efi_loader: Show the vendor in helloworld
  efi: Use the same filename for all sandbox builds
  bootstd: Add debugging for efi bootmeth
  efi_loader: Disable ANSI output for tests
  efi_loader: Add a test app
  sandbox: virtio: Disable the sandbox virtio blk device
  test: efi: boot: Set up an image suitable for EFI testing
  test: efi: boot: Add a test for the efi bootmeth

 arch/Kconfig                        |   3 +-
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
 lib/efi_loader/efi_console.c        |  26 +++++++----
 lib/efi_loader/helloworld.c         |   3 ++
 lib/efi_loader/testapp.c            |  68 ++++++++++++++++++++++++++++
 test/boot/bootdev.c                 |  18 +++++++-
 test/boot/bootflow.c                |  65 +++++++++++++++++++++++++-
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_efi_fit.py       |   2 +-
 test/py/tests/test_efi_loader.py    |   2 +-
 test/py/tests/test_ut.py            |  52 ++++++++++++++++++---
 25 files changed, 294 insertions(+), 124 deletions(-)
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.43.0

