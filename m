Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941C9EE6456
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D174888DEC;
	Thu, 12 Sep 2024 09:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fZQSBlkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B5F88D7E; Thu, 12 Sep 2024 09:03:15 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB1788D09
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71781f42f75so469296b3a.1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124589; x=1726729389; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OvU2LXwAxnjtX35WcXTkcI2NnGkP5Qv/9HZoXYl1BnQ=;
 b=fZQSBlkxH8zjjAFQb9h3ecXGrZdpf39MZciyEt4tmDHHMKL/b0yVD9FFiGKKaefj+b
 oOxJK1lMveNFfZ7nszavshcu4TKDc5aLdunOFzTPzOQnUAw/h8MRfofp3pwtVRCX9cSH
 lvmSsn3wMfJqwu+vTYhclzl7WA6AyJRRz1yCgVXpOafpOFj39P6Nu3q+jeFLHY1Sj08u
 oWjNLFYAcePRtWr21CQTk9IIkFR/9I3qtBzFe4hTunc2v7XMHJCNShHop9Fb12Npux9X
 uAZ9R8zA6p8mTCA3t6MGG1tXZmp/YHKA3yM1D3gVK7SL3c869INeP4xOaBKkQ8UDzhXH
 R2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124589; x=1726729389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvU2LXwAxnjtX35WcXTkcI2NnGkP5Qv/9HZoXYl1BnQ=;
 b=tZNeSHTvL7YNwM17P7w6uo8mo7HvGTG8Ce6/zvPsZCvvUMBqN9rVmBzaUJBN/RohTJ
 uOMmK1BMDWQ/r1UhVA+2FJ9Xy1A1B4CkVqaKECqxw8A8CIYkThWswIjC3xU2ZDdkw4Mm
 AUMIOpnglivDZcgA6xjqVZMm2zclvXjPGNGIUIaGE/TqeM4KE+m7nywzB9zqolYE/Xu6
 W4PE8FYRqsL3a+q1TRrra5jwwPuYt2hGt4CTKSjwnOmRvLz44guLoprK9gWkZmcDZjrv
 5HsEZy7r0vtX2q1cskPYNX9qxD60PZ3WZWjQcCgLcK1+/b/0gGtnEFj5TcEwIM4fbuU0
 Jq9g==
X-Gm-Message-State: AOJu0YxvhHV+nHjWYTbX4OZ4pRdTGy29TBjSuLLTzTQQYh/K8264SFty
 C2cHql0pOdRe93EUGep1DQXfCSxcVoCACJxKjWMWMD0St2OSlp82fT1ro/9MXeXeX2XPurcpL66
 N38GVts6dQeSdIeiqMRaDoEoljHanoHtKDdzQWA==
X-Google-Smtp-Source: AGHT+IGCKq/AnmMNCGmanspwDNaID7nDmM39UBxk+0sgHkOrXrnpwV2Rs7Ao1+1/OMHyEXhcKnjcScxI3cL26Bb6dWA=
X-Received: by 2002:a05:6a00:3e29:b0:70d:2b95:d9c0 with SMTP id
 d2e1a72fcca58-71926090ecdmr2882607b3a.14.1726124589219; Thu, 12 Sep 2024
 00:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <CAFLszThwBsy3FCgRpB5TZu+_m0k83-_stA1OqySRNyR_5kGxeQ@mail.gmail.com>
In-Reply-To: <CAFLszThwBsy3FCgRpB5TZu+_m0k83-_stA1OqySRNyR_5kGxeQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Sep 2024 10:02:32 +0300
Message-ID: <CAC_iWjLBHyFqW9fLaA5qewEA1swV7H-KOqh8BiC52PVafte43g@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] efi: Add a test for EFI bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Simon,

On Thu, 12 Sept 2024 at 04:01, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Sun, 1 Sept 2024 at 19:18, Simon Glass <sjg@chromium.org> wrote:
> >
> > The test coverage for the EFI bootmeth is incomplete since it does not
> > actually boot the application.
> >
> > This series creates a simple test for this purpose. It includes a few
> > patches to make this work:
> >
> > - ANSI output from the EFI loader confusing the unit-testing checker
> > - Hang in sandbox virtio due to EFI probing all block devices
> >
> > Other necessary fixes have been split out into two other series.
> >
> > Changes in v5:
> > - Drop Fixes tag
> > - Drop the Fixes tag
> > - Rebase on updated efif series
> > - Deal with sandbox CONFIG_LOGF_FUNC
> >
> > Changes in v4:
> > - Add efi_loader tag to some patches
> > - Split out non-EFI patches into a different series
> >
> > Changes in v3:
> > - Drop the extra- rules since scripts/Makefile.lib takes care of it
> > - Add new patch to drop crt0/relocal extra- rules
> > - Put back the Linaro copyright accidentally removed
> > - Add a Fixes tag
> > - Mention the issue created for this problem
> >
> > Changes in v2:
> > - Fix 'use' typo
> > - Reword commit message
> > - Use 'Firmware vendor' instead of just 'Vendor'
> > - Add many new patches to resolve all the outstanding test issues
> >
> > Simon Glass (14):
> >   efi_loader: Use puts() in cout so that console recording works
> >   efi_loader: Put back copyright message
> >   efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
> >   efi: arm: x86: riscv: Drop crt0/relocal extra- rules
> >   efi_loader: Shorten the app rules
> >   efi_loader: Shorten the app rules further
> >   efi_loader: Show the vendor in helloworld
> >   efi: Use the same filename for all sandbox builds
> >   bootstd: Add debugging for efi bootmeth
> >   efi_loader: Disable ANSI output for tests
> >   efi_loader: Add a test app
> >   efi_loader: Avoid using sandbox virtio devices
> >   test: efi: boot: Set up an image suitable for EFI testing
> >   test: efi: boot: Add a test for the efi bootmeth
> >
> >  arch/arm/lib/Makefile               |   8 ----
> >  arch/riscv/lib/Makefile             |   4 --
> >  arch/sandbox/dts/test.dts           |   2 +-
> >  arch/x86/lib/Makefile               |  16 -------
> >  boot/bootmeth_efi.c                 |  11 ++++-
> >  cmd/Kconfig                         |  14 +-----
> >  configs/octeontx2_95xx_defconfig    |   2 +-
> >  configs/octeontx2_96xx_defconfig    |   2 +-
> >  configs/octeontx_81xx_defconfig     |   2 +-
> >  configs/octeontx_83xx_defconfig     |   2 +-
> >  doc/develop/uefi/uefi.rst           |   2 +-
> >  include/efi_default_filename.h      |  24 +---------
> >  include/efi_loader.h                |  21 ++++++++-
> >  lib/efi_loader/Kconfig              |  22 +++++++++
> >  lib/efi_loader/Makefile             |  47 ++++++-------------
> >  lib/efi_loader/efi_console.c        |  28 ++++++++----
> >  lib/efi_loader/efi_disk.c           |  14 +++++-
> >  lib/efi_loader/helloworld.c         |   6 +++
> >  lib/efi_loader/testapp.c            |  68 ++++++++++++++++++++++++++++
> >  test/boot/bootdev.c                 |  18 +++++++-
> >  test/boot/bootflow.c                |  66 ++++++++++++++++++++++++++-
> >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> >  test/py/tests/test_efi_fit.py       |   2 +-
> >  test/py/tests/test_efi_loader.py    |   2 +-
> >  test/py/tests/test_ut.py            |  52 ++++++++++++++++++---
> >  25 files changed, 310 insertions(+), 125 deletions(-)
> >  create mode 100644 lib/efi_loader/testapp.c
> >  create mode 100644 test/py/tests/bootstd/flash1.img.xz
> >
> > --
> > 2.34.1
> >
>
> ping on this series, please.

Most of the patches have been reviewed.
There were questions and feedback on v4 that haven't changed on v5 AFAICT [0]

[0] https://lore.kernel.org/u-boot/20240826181826.GI2479150@bill-the-cat/

Regards
/Ilias
>
> Regards,
> SImon
