Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE3BEE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8975C88DE4;
	Thu, 12 Sep 2024 03:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m2WPMCyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE2B88DE4; Thu, 12 Sep 2024 03:01:49 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E756B88D09
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7191901abd6so234389b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102904; x=1726707704; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cmingIA5oOiuKDTR6KPOvmgPUtAoAzTPuPV4+BqTz7Y=;
 b=m2WPMCyVzuYQOB9A3F3JmZ2+kie7WlJWz7rDVd9kPx1vhOryLNqzJo3ubFQ2g8OM4c
 a/P756X3vifgFAvUNtcOV4L4Mw3DLHb7nAc/AyeuvgETh+t5PUGoCTdzx/3bIqSA/u7f
 7A10LUvE6vHgvmIvlByLs4Cu9Jy4gkwIrq95w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102904; x=1726707704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmingIA5oOiuKDTR6KPOvmgPUtAoAzTPuPV4+BqTz7Y=;
 b=C73Gj3BjSMZOAZFlZmt/nLizJsrj8KnB9bY/cB5CScWY3Yn+oBEzNCusA0fM+R0Ah2
 Km/1jOKzIybhu/qlDzMlRR+gg8rlM5xMP7CfDvtH0KDTC24ki7qVQPPmA2MiZhA10P1+
 EPQqcnBNrwCiCMadF7pDxPBm89BzpjH+8ax356kKwNpETitHhFzaGhYB9PJdtM33pJCL
 rvGgmo64GP+0s11rTRJrDJygbHPXwvsRxQ8U7NFhR63UQpOEUMgSuHpLG0InapJKZ1gZ
 PvxCOY3QfuqY2ydWf7k/tMkbMp91TYtM0b56y6O/s//Y3vV2HlpNVgX+JFWJTy6wzOrG
 KlWw==
X-Gm-Message-State: AOJu0Yy3053zk6Zq1jcvzCjb1JTsv+kj7NdyYczKzRyxDtWSAYmVYH2p
 mwFsCyszBpIvpmIikwykgBoXbLaq+JAuwr/Ai3mvihW3GtoW82FoIaPBhC9eu0oQANdk5oPXb0V
 U72gc8Cxrr6SozO4buOvxWTqQn+LfsmtSjvcyGXrQp6ysWxg=
X-Google-Smtp-Source: AGHT+IFLhG98U60MkLwg6awVhiQLoGCuFKys/bglJEZZrGKMIYV/WPslEXHutANkAHFwEQc40UzFzz3k8Ovx/stfHxA=
X-Received: by 2002:a05:6a20:43a0:b0:1c4:9ef6:499b with SMTP id
 adf61e73a8af0-1cf75f676cemr1438117637.29.1726102904314; Wed, 11 Sep 2024
 18:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:32 -0600
Message-ID: <CAFLszThwBsy3FCgRpB5TZu+_m0k83-_stA1OqySRNyR_5kGxeQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] efi: Add a test for EFI bootmeth
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Sun, 1 Sept 2024 at 19:18, Simon Glass <sjg@chromium.org> wrote:
>
> The test coverage for the EFI bootmeth is incomplete since it does not
> actually boot the application.
>
> This series creates a simple test for this purpose. It includes a few
> patches to make this work:
>
> - ANSI output from the EFI loader confusing the unit-testing checker
> - Hang in sandbox virtio due to EFI probing all block devices
>
> Other necessary fixes have been split out into two other series.
>
> Changes in v5:
> - Drop Fixes tag
> - Drop the Fixes tag
> - Rebase on updated efif series
> - Deal with sandbox CONFIG_LOGF_FUNC
>
> Changes in v4:
> - Add efi_loader tag to some patches
> - Split out non-EFI patches into a different series
>
> Changes in v3:
> - Drop the extra- rules since scripts/Makefile.lib takes care of it
> - Add new patch to drop crt0/relocal extra- rules
> - Put back the Linaro copyright accidentally removed
> - Add a Fixes tag
> - Mention the issue created for this problem
>
> Changes in v2:
> - Fix 'use' typo
> - Reword commit message
> - Use 'Firmware vendor' instead of just 'Vendor'
> - Add many new patches to resolve all the outstanding test issues
>
> Simon Glass (14):
>   efi_loader: Use puts() in cout so that console recording works
>   efi_loader: Put back copyright message
>   efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
>   efi: arm: x86: riscv: Drop crt0/relocal extra- rules
>   efi_loader: Shorten the app rules
>   efi_loader: Shorten the app rules further
>   efi_loader: Show the vendor in helloworld
>   efi: Use the same filename for all sandbox builds
>   bootstd: Add debugging for efi bootmeth
>   efi_loader: Disable ANSI output for tests
>   efi_loader: Add a test app
>   efi_loader: Avoid using sandbox virtio devices
>   test: efi: boot: Set up an image suitable for EFI testing
>   test: efi: boot: Add a test for the efi bootmeth
>
>  arch/arm/lib/Makefile               |   8 ----
>  arch/riscv/lib/Makefile             |   4 --
>  arch/sandbox/dts/test.dts           |   2 +-
>  arch/x86/lib/Makefile               |  16 -------
>  boot/bootmeth_efi.c                 |  11 ++++-
>  cmd/Kconfig                         |  14 +-----
>  configs/octeontx2_95xx_defconfig    |   2 +-
>  configs/octeontx2_96xx_defconfig    |   2 +-
>  configs/octeontx_81xx_defconfig     |   2 +-
>  configs/octeontx_83xx_defconfig     |   2 +-
>  doc/develop/uefi/uefi.rst           |   2 +-
>  include/efi_default_filename.h      |  24 +---------
>  include/efi_loader.h                |  21 ++++++++-
>  lib/efi_loader/Kconfig              |  22 +++++++++
>  lib/efi_loader/Makefile             |  47 ++++++-------------
>  lib/efi_loader/efi_console.c        |  28 ++++++++----
>  lib/efi_loader/efi_disk.c           |  14 +++++-
>  lib/efi_loader/helloworld.c         |   6 +++
>  lib/efi_loader/testapp.c            |  68 ++++++++++++++++++++++++++++
>  test/boot/bootdev.c                 |  18 +++++++-
>  test/boot/bootflow.c                |  66 ++++++++++++++++++++++++++-
>  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
>  test/py/tests/test_efi_fit.py       |   2 +-
>  test/py/tests/test_efi_loader.py    |   2 +-
>  test/py/tests/test_ut.py            |  52 ++++++++++++++++++---
>  25 files changed, 310 insertions(+), 125 deletions(-)
>  create mode 100644 lib/efi_loader/testapp.c
>  create mode 100644 test/py/tests/bootstd/flash1.img.xz
>
> --
> 2.34.1
>

ping on this series, please.

Regards,
SImon
