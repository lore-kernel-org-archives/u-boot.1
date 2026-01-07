Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6196D0D16D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E532983A2D;
	Wed,  7 Jan 2026 21:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ogGeP6aO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D2C8405F; Wed,  7 Jan 2026 20:02:17 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3F983A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b736d883ac4so450437566b.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767812535; x=1768417335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2q+YEM8omsK2pnvbn1ZF+KPrgRIx47d/vgOdLYsb3bQ=;
 b=ogGeP6aOSfY8vUkwyHMbhLJwebDSSZND0d/N//Id/NunfvVoQj0h7bSASuzlXz7sCp
 yUjwBlKe1d6MPfXDAOj85uKQdgZljN+H0xD8ktCrSnMW6E1Nzb6VLnFHVPpDvIABEMaw
 f5gapb/pYp/B2U1NejQdgJ+WAfrPNSEo9UEEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767812535; x=1768417335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2q+YEM8omsK2pnvbn1ZF+KPrgRIx47d/vgOdLYsb3bQ=;
 b=dDVb0uIbee5iQRHytID2mDpUN+je6iZ7INYWEZxVgktrX14pMisPkNKM9VgpcGPUbH
 Av+GQsKcbXB71XllADB+G/GJGHwWwtzWMgiovMp0PGfHckzWvFfPNizdoQLE73Ow4Ih4
 lZE+XZgktuXQ9wzHbc8h9TQedrQoLRpSLEnoe8qI4Wodqj1TOJdLqpG5QyK4mI5IS77M
 C33xxcOT7M9lLtJGIN6hhoO6KwBZ5wqe1lGbECGG3OvfnxQYyvomd/SVEeBWn8MtOD/R
 0V9wdZ+0nznsKsHegrqTrS1ySo1y+MDZcA9v0DpOEUcWew5j8q/Jj1Wtsdcj/NJDZDcE
 eh9g==
X-Gm-Message-State: AOJu0Yxqzdtj5ri/NxW8RtoqQlWjSukCLT8noDiKEZDYDMMWsBiIVJjz
 ODiXFIzT13h7uw5/1A96UtL/xSbEG2XAX81BNQ7INT/gp71EAB2+TJa3M8GbqgPNZrkhxm8XVqM
 +LLSryLNsCn9nohfx4VjzPgD3sVQLBdpCp4UF94xB
X-Gm-Gg: AY/fxX5aRk0NCqLUwTlLCoI31pJzZu+J15kCHCoF+eLxa2IDRqZWlOKKF6QgIMLqqg/
 /lphrVZwu7Sxa2JlOt80sp+jJ45DXrlH+0MivZjCZQG6HTGWPQ4vvWFJnMYpfQMWF5ESKVIhWfP
 AJXBFUBjiVkMdV80AUAy+xyuUxjNGphT49cUkfQi1KTrd4sxv03Dn0FRCcyZSSmmcrZeLkRMwTc
 at7Bgdd981vrQK/BIn1/py1H3dhouVgR7mjNbAuhdGioT/9e15w4KToDrpGvITbwsotvg==
X-Google-Smtp-Source: AGHT+IFYl8JkIfE20N2RA2QuSAlvVlnQG2EBfKSJEqxlY6Yv+b9mkLnvTYiF1OHZ/mj9Bnn18YkfeYYansxAuJVATGA=
X-Received: by 2002:a17:907:a49:b0:b7c:e4e9:b13f with SMTP id
 a640c23a62f3a-b8444f4e435mr382702666b.39.1767812534897; Wed, 07 Jan 2026
 11:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <CALeDE9OP8qZAtWykrBDu95qx=Sp0jP7BK2BE0H1d1pfz6_YJNw@mail.gmail.com>
In-Reply-To: <CALeDE9OP8qZAtWykrBDu95qx=Sp0jP7BK2BE0H1d1pfz6_YJNw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Jan 2026 12:01:59 -0700
X-Gm-Features: AQt7F2pch1G-gvD0mXayX9vSn2YXZlA6C4rj8EV-ahOhZcgixNvryw0ulKCpOVw
Message-ID: <CAFLszTjQB1NBAKzTxsXKW-0d-V11BbzaLHswxSDAdbZ=3zbsTg@mail.gmail.com>
Subject: Re: [PATCH 00/10] bootm: Clean up arch-specific, pre-OS clean-up
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Adriano Cordova <adrianox@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ian Roberts <ian.roberts@timesys.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Weijie Gao <weijie.gao@mediatek.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:27 +0100
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

Hi Peter,

On Tue, 6 Jan 2026 at 19:29, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > Each arch does something slightly different before booting the OS. Some
> > archs even do different things depending on the CPU type.
> >
> > EFT_LOADER has its own special code, regardless of which arch is being
> > booted.
> >
> > It is quite hard to know what actually happens in the final milliseconds
> > before the OS boot.
> >
> > This series attempts to clean up U-Boot in this area.
> >
> > The basic approach is to create a new bootm_final() function which is
> > called by all archs. It provides some flags for a couple of necessary
> > variations but otherwise it is generic.
> >
> > RISC-V, x86 and ARM are converted over to use this new function. For
> > consistency, EFI loader is converted as well.
> >
> > A noteable change is that EFI_LOADER now does bootstage processing
> > before boot, if enabled, thus producing a report.
>
> Why is the change needed, I don't see it explained in the patches or
> here and what the implications might be.

At present EFI_LOADER ignores bootstage and so there is no timing
report produced even if enabled. It was probably an oversight.

>
> > There is also a patch to drop EFI_GRUB_ARM32_WORKAROUND, as discussed
> > recently on the mailing list.
>
> That appears to be unrelated to this series, it should be a separate
> standalone patch else it needs to be described here why it's a
> dependency, and even then likely still posted separately as a
> dependency of this series.

In what way is it unrelated? In my view this is related as it is a
pre-OS cleanup. What do you mean by dependency here?

>
> > Future work could take this a little further:
> > - Drop board_quiesce_devices() and rely on driver model for that
> > - Similarly with udc_disconnect(),
> > - cleanup_before_linux() could use more details as to what it is
> > supposed to do, to reduce the number of arch-specific variations
>
> What do you mean by that statement.

Well, the function does different things on differents archs and is
mostly uncommented (apart from an ARM-specific note in a README).
Ideally it would be commented with exactly what it should do, ideally
at a high level so it is not just arch-specific.


>
> > Note: This is the first 10 patches for an 18-part series from the
> > Concept tree, as requested. The patches after that complete the cleanup
> > on ARM and RISC-V.
> >
> >
> > Simon Glass (10):
> >   boot: Create a function for final pre-boot steps
> >   efi: Make use of bootm_final()
> >   bootm: Add a message when booting
> >   bootstage: Add some missing dummy functions
> >   bootm: Do bootstage processing in bootm_final()
> >   x86: Call bootm_final()
> >   riscv: Drop board_quiesce_devices()
> >   riscv: Call bootm_final()
> >   efi: Drop EFI_GRUB_ARM32_WORKAROUND
> >   x86: Add cleanup_before_linux()
> >
> >  MAINTAINERS                           |  1 +
> >  arch/riscv/include/asm/u-boot-riscv.h |  1 -
> >  arch/riscv/lib/bootm.c                | 24 +------------------
> >  arch/x86/cpu/cpu.c                    |  5 ++++
> >  arch/x86/lib/bootm.c                  | 14 +----------
> >  boot/Makefile                         |  2 +-
> >  boot/bootm_final.c                    | 34 +++++++++++++++++++++++++++
> >  configs/mt7623n_bpir2_defconfig       |  1 -
> >  include/bootm.h                       | 17 ++++++++++++++
> >  include/bootstage.h                   |  8 +++++++
> >  lib/efi_loader/Kconfig                | 10 --------
> >  lib/efi_loader/efi_boottime.c         | 30 +----------------------
> >  test/boot/bootflow.c                  |  2 +-
> >  13 files changed, 70 insertions(+), 79 deletions(-)
> >  create mode 100644 boot/bootm_final.c
> >
> > --
> > 2.43.0
> >
> > base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> > branch: bootma-us
