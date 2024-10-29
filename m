Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F2FD3A67C
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 18:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C198918A;
	Tue, 29 Oct 2024 19:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pRCPzXx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B7A88E96; Tue, 29 Oct 2024 19:32:18 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE2488F12
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 19:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so4400620b3a.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730226734; x=1730831534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fkjt2SwGiLkbin6e5MFpst3blZNGMRjjQcHVS7Hi4Jo=;
 b=pRCPzXx3vJMXkEJTVJc4f4+xgsiKd569j+Wn5FOyCgSnZd2IucAtfBArGyYnUKXHBt
 nTdjv10Kwe1Rs2V3NEzHx8VQdhcm3qQ6x8F0r1T/fIi3V1ugVYFkcLzXmjGgzgX12zOe
 r8p8JNd3KrDXgH2Dq1J5aDybSaBn+RfuM4Nxkhaw+9AcX/3f/ba9CfMeefDdlwcC1Hnm
 Pb2pQntnGgwkOSZSAKLK5MQsrdzK5OxRojIcz8S8IEEkm7DO3y46Y/3c5bZO2yCd/Q/H
 0Y/Xmp/ypRZKd91WC6crJvpUuQ96qk0fls164W6pIzDLAdJ5coMYRiUuiMxAkt+WCbkS
 209g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730226734; x=1730831534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fkjt2SwGiLkbin6e5MFpst3blZNGMRjjQcHVS7Hi4Jo=;
 b=QOA2rEiNsqcDYUpq+McP3N0RKAuzLzcAYeQlCQ0cZ+6U/Fzs+9dRj7PKA/7JwDl/uh
 UHARleK8wx+3cXyscmv08NAt0RC6PA8wxOnUp98C1KMVGwyNVAEiFZN6xXLfrmETVsfy
 TZXNkf8fTW82i89utMsavCRav/OeDYc3DKyJASkWLWS+wr9jWyqvDo63bbqlL8XCjLGb
 7n87INFSvq660Zef8qfrJFsrYpqlFHK/ijcknL9PdJL/let0yyIsFtxowALcmyDITd5a
 i+55v/ovMinpxRqyLPzOOi88DUhJvw9SJQlyS4MbWhtz635HHqkc6uuxFv4rRMIeMzT/
 PdAw==
X-Gm-Message-State: AOJu0YycK1kjmPWmjkI21/oHSBaqWOK5WPmkzyeZVzcl1Q1Pq/HZSlaG
 UPmKcglQwS5VduuljhiygKLbo3XA2md6X80kKAaRH8e5IgmrCAEKOaNKzg5lxBd9j/Q4QIyzxjA
 W/Svj+IykDr8bMg+Go29urBeoaqRm1Y/YPJBJSg==
X-Google-Smtp-Source: AGHT+IE6Q4u1xrJyXnL060D5Im97BWoxTMcvSOapYIuIKXLKo2OUnB5r2O86Xeus2r98ixn3GnEJf5+Ud05AKrKsEiw=
X-Received: by 2002:aa7:8891:0:b0:71e:44f6:6904 with SMTP id
 d2e1a72fcca58-72062fd9eb7mr17907080b3a.13.1730226734119; Tue, 29 Oct 2024
 11:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
 <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
In-Reply-To: <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 20:31:37 +0200
Message-ID: <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 29 Oct 2024 19:34:43 +0100
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

On Tue, 29 Oct 2024 at 17:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > It is a bit of a pain to log EFI boot-services calls at present. The
> > > output goes to the console so cannot easily be inspected later. Also it
> > > would be useful to be able to store the log and review it later, perhaps
> > > after something has gone wrong.
> > >
> > > This series makes a start on implementing a log-to-buffer feature. It
> > > provides a simple 'efidebug log' command to inspect the buffer. For now,
> > > only memory allocations are logged.
> >
> > Why is this problem specific to EFI and no U-Boot in general? Do we
> > have a similar machinery for malloc()?
>
> Mostly because an app can make EFI calls and we want to know what they
> are, e.g. to debug them and figure out what might be wrong when
> something doesn't boot.

EFI_PRINT() has been proven pretty useful for this. I don't personally
see the point of adding ~1300 lines of code to replace a print.
What would make more sense is teach EFI_PRINT to log errors in a buffer.


Thanks
/Ilias

/Ilias
>
> Regards,
> Simon
>
>
> >
> > Thanks
> > /Ilias
> > >
> > > This feature makes it possible to add tests to check which EFI calls are
> > > made by U-Boot itself. It may also make it easier to figure out what is
> > > needed for booting Windows.
> > >
> > > Some patches to help with debugging sandbox memory-mapping are included,
> > > but for now EFI's use of mapping is not adjusted.
> > >
> > >
> > > Simon Glass (15):
> > >   log: Add a new category for tests
> > >   test: Allow saving and restoring the bloblist
> > >   bloblist: test: Mark tests with UTF_BLOBLIST
> > >   sandbox: Convert sb command to use new macro
> > >   doc: sandbox: Add docs for the sb command
> > >   sandbox: Add a way to show the sandbox memory-mapping
> > >   sandbox: Fix comment for nomap_sysmem() function
> > >   lmb: Drop extra 16KB of stack space
> > >   efi_loader: Fix free in ..._media_device_boot_option()
> > >   efi_loader: Add support for logging EFI calls
> > >   efi_loader: Create the log on startup
> > >   efi_loader: Add a command to show the EFI log
> > >   test: efi_loader: Add a simple test for the EFI log
> > >   efi_loader: Use the log with memory-related functions
> > >   efi_loader: Add documentation for the EFI log
> > >
> > >  MAINTAINERS                    |   7 +
> > >  arch/sandbox/cpu/cpu.c         |  13 +
> > >  arch/sandbox/include/asm/cpu.h |   3 +
> > >  arch/sandbox/include/asm/io.h  |   2 +-
> > >  cmd/efidebug.c                 |  53 +++-
> > >  cmd/sb.c                       |  42 ++--
> > >  common/log.c                   |   1 +
> > >  configs/sandbox_defconfig      |   3 +
> > >  doc/develop/uefi/uefi.rst      |  22 ++
> > >  doc/usage/cmd/efidebug.rst     | 109 ++++++++
> > >  doc/usage/cmd/sb.rst           |  79 ++++++
> > >  doc/usage/index.rst            |   2 +
> > >  include/bloblist.h             |   1 +
> > >  include/efi.h                  |   1 +
> > >  include/efi_log.h              | 316 +++++++++++++++++++++++
> > >  include/log.h                  |   2 +
> > >  include/test/test.h            |   3 +
> > >  lib/efi_loader/Kconfig         |  19 ++
> > >  lib/efi_loader/Makefile        |   1 +
> > >  lib/efi_loader/efi_bootmgr.c   |   3 +-
> > >  lib/efi_loader/efi_log.c       | 444 +++++++++++++++++++++++++++++++++
> > >  lib/efi_loader/efi_memory.c    | 119 ++++++---
> > >  lib/efi_loader/efi_setup.c     |   7 +
> > >  lib/lmb.c                      |   2 -
> > >  test/common/bloblist.c         |  28 +--
> > >  test/lib/Makefile              |   1 +
> > >  test/lib/efi_log.c             |  93 +++++++
> > >  test/test-main.c               |  13 +
> > >  28 files changed, 1305 insertions(+), 84 deletions(-)
> > >  create mode 100644 doc/usage/cmd/efidebug.rst
> > >  create mode 100644 doc/usage/cmd/sb.rst
> > >  create mode 100644 include/efi_log.h
> > >  create mode 100644 lib/efi_loader/efi_log.c
> > >  create mode 100644 test/lib/efi_log.c
> > >
> > > --
> > > 2.43.0
> > >
