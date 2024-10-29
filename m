Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B021D3A67B
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 18:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE5D88F12;
	Tue, 29 Oct 2024 19:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MH9yAdHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C248918B; Tue, 29 Oct 2024 16:45:53 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC90D88D29
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so833080566b.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216751; x=1730821551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jRN/S3AUnJGOURn6uf0T6dz2KXiAoC+VIhRsDJAb/rY=;
 b=MH9yAdHDHyVKpOUknlkANJsALIW8nfVKrKTeioW05NpPeOG6FKovvNt+pNeaI8somo
 C0+bsPXwe8XOx8hazc8IlXGwkYcroUv8XGjqYCaF+sMH3dLmkvQet2lFm24nu8cJZtQl
 hwRsq3a2rV0186I39BIPRUTXNs1/DHNQfBr8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216751; x=1730821551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jRN/S3AUnJGOURn6uf0T6dz2KXiAoC+VIhRsDJAb/rY=;
 b=ldC1KxItGS/Je+FDcffql1XtDv8/PWUmp3m+gyO2/mJq5NRraOeosdyYpVrpbCE7ew
 cXMF4l5+i8CDrnpn664yXF1CICz8054dzEpqb4pa1Y4AwCEwtg3XyhMZLBm+qvPfthaR
 kiU+ktYOawl1VloDUfROE6vguE7bj7Efk+R0GSsx6yQKg/yE7/ByFvDnD3AzlVYUS+Q+
 hYQ3BKuWMR9n0owNN5YQZXMqNWGPfCxMsUlw4FGujLeLKYpLVBNyajeqFat6PlTVX23y
 iyhUuWD/F4cPjg0W4sX/oH31VD/fbTWvWjgrxOWA0mlJlcPJyA+HFVOelmLSjtI36qMQ
 FAMQ==
X-Gm-Message-State: AOJu0YzIGZMmhopSXLnkFLRJvd2yVIsZz2aUvlCKG5ZKhbweMG8TLuoB
 3QWjRqJ1umDh/hVs2BpP3sbIKIWBWPd5Au5kiINHnkDmOoVuS8jJCGWrs3sTCknDXML5rUa0Wh/
 k01RTTHoExtA/KZbIeChxk5f9gG/VlPT4xLvE
X-Google-Smtp-Source: AGHT+IEax1C9yaKBrbUgNvOVvuV96+CCJqu5sGlZaUbOia6rptam7SdJMow3HqOb7TXEYTkv3KH9lTu+Q/81++Q+iDQ=
X-Received: by 2002:a17:907:7f06:b0:a99:fb56:39cc with SMTP id
 a640c23a62f3a-a9de5ee1998mr1068708866b.38.1730216750956; Tue, 29 Oct 2024
 08:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
In-Reply-To: <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:45:36 +0100
Message-ID: <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > It is a bit of a pain to log EFI boot-services calls at present. The
> > output goes to the console so cannot easily be inspected later. Also it
> > would be useful to be able to store the log and review it later, perhaps
> > after something has gone wrong.
> >
> > This series makes a start on implementing a log-to-buffer feature. It
> > provides a simple 'efidebug log' command to inspect the buffer. For now,
> > only memory allocations are logged.
>
> Why is this problem specific to EFI and no U-Boot in general? Do we
> have a similar machinery for malloc()?

Mostly because an app can make EFI calls and we want to know what they
are, e.g. to debug them and figure out what might be wrong when
something doesn't boot.

Regards,
Simon


>
> Thanks
> /Ilias
> >
> > This feature makes it possible to add tests to check which EFI calls are
> > made by U-Boot itself. It may also make it easier to figure out what is
> > needed for booting Windows.
> >
> > Some patches to help with debugging sandbox memory-mapping are included,
> > but for now EFI's use of mapping is not adjusted.
> >
> >
> > Simon Glass (15):
> >   log: Add a new category for tests
> >   test: Allow saving and restoring the bloblist
> >   bloblist: test: Mark tests with UTF_BLOBLIST
> >   sandbox: Convert sb command to use new macro
> >   doc: sandbox: Add docs for the sb command
> >   sandbox: Add a way to show the sandbox memory-mapping
> >   sandbox: Fix comment for nomap_sysmem() function
> >   lmb: Drop extra 16KB of stack space
> >   efi_loader: Fix free in ..._media_device_boot_option()
> >   efi_loader: Add support for logging EFI calls
> >   efi_loader: Create the log on startup
> >   efi_loader: Add a command to show the EFI log
> >   test: efi_loader: Add a simple test for the EFI log
> >   efi_loader: Use the log with memory-related functions
> >   efi_loader: Add documentation for the EFI log
> >
> >  MAINTAINERS                    |   7 +
> >  arch/sandbox/cpu/cpu.c         |  13 +
> >  arch/sandbox/include/asm/cpu.h |   3 +
> >  arch/sandbox/include/asm/io.h  |   2 +-
> >  cmd/efidebug.c                 |  53 +++-
> >  cmd/sb.c                       |  42 ++--
> >  common/log.c                   |   1 +
> >  configs/sandbox_defconfig      |   3 +
> >  doc/develop/uefi/uefi.rst      |  22 ++
> >  doc/usage/cmd/efidebug.rst     | 109 ++++++++
> >  doc/usage/cmd/sb.rst           |  79 ++++++
> >  doc/usage/index.rst            |   2 +
> >  include/bloblist.h             |   1 +
> >  include/efi.h                  |   1 +
> >  include/efi_log.h              | 316 +++++++++++++++++++++++
> >  include/log.h                  |   2 +
> >  include/test/test.h            |   3 +
> >  lib/efi_loader/Kconfig         |  19 ++
> >  lib/efi_loader/Makefile        |   1 +
> >  lib/efi_loader/efi_bootmgr.c   |   3 +-
> >  lib/efi_loader/efi_log.c       | 444 +++++++++++++++++++++++++++++++++
> >  lib/efi_loader/efi_memory.c    | 119 ++++++---
> >  lib/efi_loader/efi_setup.c     |   7 +
> >  lib/lmb.c                      |   2 -
> >  test/common/bloblist.c         |  28 +--
> >  test/lib/Makefile              |   1 +
> >  test/lib/efi_log.c             |  93 +++++++
> >  test/test-main.c               |  13 +
> >  28 files changed, 1305 insertions(+), 84 deletions(-)
> >  create mode 100644 doc/usage/cmd/efidebug.rst
> >  create mode 100644 doc/usage/cmd/sb.rst
> >  create mode 100644 include/efi_log.h
> >  create mode 100644 lib/efi_loader/efi_log.c
> >  create mode 100644 test/lib/efi_log.c
> >
> > --
> > 2.43.0
> >
