Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AECC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38B25889F8;
	Thu, 15 Aug 2024 22:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WsaPIVhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D302C8870B; Thu, 15 Aug 2024 22:24:33 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9991F88A76
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so51723139f.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753467; x=1724358267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKztAFb8qvZRWa4uZhRFNhmnBfXGk2Gj1MZe1Mv1AzM=;
 b=WsaPIVhzR9BW7MEuK/XM2KttpyYCSSaf6AxI2AJOY71/Y6TCLh+TgVoKXBnvcSKsks
 xBtYE6uMjlKAHBx9iTdbDNAtzL0RQlYj7+p+ILLlF0n/wX8E8Xp4cCv2STt0vqMg63r9
 a5JJvogsF5UsJ+aHcZeXsXjm4JL8lCacvpZgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753467; x=1724358267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKztAFb8qvZRWa4uZhRFNhmnBfXGk2Gj1MZe1Mv1AzM=;
 b=ORihuaub/emEOYr2QHOyKz0rXCIXKT7yZ+NSGwEcbppPkLe3am5frlS70AJaMRfkKt
 3jEQuTgI06S9M7tq789Vwxl6lVq5Krlk9XtynVxfy0rmU1weYDXiq2pKzqVkffu6srxA
 fZB9OqHj6P44qBn+ESYNPnlilkeFK7bN/1cJFWwaNAuMDab4YoCZ6m/BvqHxsobAEhQh
 p7JkmnpIKWUo2sA+kO8LlMdmVrLL8E8GqhlhRf2urcOKqTL0VMVi/tNtvfVjXtbOYxaE
 S/CMpQ8Zk7wuv92dSv7hryLzzXUykjhTM/VgRcOh3QlxzO+bSB9/NZJUnIBRmnl6b7h4
 3hQg==
X-Gm-Message-State: AOJu0YwBqD1iu8U6UD+b4kdD4TmMkFoD+LudBuoo/28BDH8Xz/SjJlvY
 LDtV4LyCGa5DbYSj7VSkYiUBhtoZlkFaPdJUSJKLj5gl+/zk3IQJnvssjZEw5hrAPD2v/qoOyoc
 YtA==
X-Google-Smtp-Source: AGHT+IG1qtUzR/k2ZBAD2leDsHpRMMtyS+s2hydi+HxIT3Da+OKXAOMdgCxb+SeaCu7zTIAfA6XyEw==
X-Received: by 2002:a05:6e02:1a8f:b0:39a:12d7:2849 with SMTP id
 e9e14a558f8ab-39d26cdbf47mr13141645ab.5.1723753467281; 
 Thu, 15 Aug 2024 13:24:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v4 00/14] efi: Add a test for EFI bootmeth
Date: Thu, 15 Aug 2024 14:24:10 -0600
Message-Id: <20240815202424.766778-1-sjg@chromium.org>
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
 test/boot/bootflow.c                |  60 +++++++++++++++++++++++-
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_efi_fit.py       |   2 +-
 test/py/tests/test_efi_loader.py    |   2 +-
 test/py/tests/test_ut.py            |  52 ++++++++++++++++++---
 25 files changed, 304 insertions(+), 125 deletions(-)
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.34.1

