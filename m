Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B68C369AF
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C897836E7;
	Fri, 11 Apr 2025 17:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n/trAKlr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 180CD83E7A; Fri, 11 Apr 2025 17:22:56 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEDF82B3F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac7bd86f637so630191866b.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744384973; x=1744989773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9wW4FPSop6rhe++Un6KwUrCNU20MXEXbpiQDx84mkwU=;
 b=n/trAKlrbsSvLE1Vojht22yPkuov+naA1O7ES1PTNQ8uWq0hIzJsP0425hdd1l1h7k
 et0YqdsgZX2jyTWl7uhrE6avrSmyPBj/EkDt+znISx6iJkCOh5qX3lZr/8ghrrqAi2b8
 KCckKdldJ+QpQROujN0KCj44NvF4d5SmrliTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744384973; x=1744989773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9wW4FPSop6rhe++Un6KwUrCNU20MXEXbpiQDx84mkwU=;
 b=bBOyDOf9XMymu8PhpziC/QGqaJJCnAJOZovwSDa8v6U0RySsWUUduS/VC5hPNaI5Xo
 Q22tYiVyZDmIiAOh3snDh4fBUDFJuBR8LZGVopm9OvKg868bOlBFg9hDgfBLvm4F8XqT
 kP6Q8EKmYMncRiv7WusP2v51SBWdqcpVvcDLh6RSBil5FLHKSBh0DX+tlWkbQS+o6ZA3
 Bssos3J2R8pgITtb+6TUOP3COYXMYXna57cWGmF8nFexUKGK+UBGA5Q1IE0q7mnxbEOy
 xFfRvpbjIY5YYfAlflVs18+Vt6btNwnp4EuVcUQxPiG3+LwHbMqiBIQtqm1H/LHidzc3
 x9sQ==
X-Gm-Message-State: AOJu0Ywp26CKgdscburybf7814Duem8LaAnd7n3Om6CN9lVxdtZBQ+lj
 djHKnK3djtCVMqFVYGPga7yFcaw/IyVDgdGeOGEpHwZEdgaXsXrk3cE9jKhp1q6MSv5qGNIOAXs
 9qr8Fd2k1sGZwj1nzssAKX6sh//djs5b7p8f5
X-Gm-Gg: ASbGncv0zGReUhIolJR7vzEzGZFrITJSBDanJEhcXVFtg+bxywZqgjYYu3ICvpk9GP/
 RDH1bVt4YOAx5BGTh910/2K1Ks0DPP3IAdua9pe2cGOLnzOkF3X3Laz32m3AMmZydFs36iajAF5
 fbzk/lfeK0GwQIo7WM/+8X/d+KyGXdMeUM9OYavgqwMmDpoWxj22olxeI=
X-Google-Smtp-Source: AGHT+IFOoNPFplsuGkBFqsKlJ7neHIpogBYB7vgIdqBZ/7a7Wezy/InqmSkF7201uAGoxIGsJm5fxvzeD32YL3xa3Ts=
X-Received: by 2002:a17:907:8694:b0:aca:95eb:12e with SMTP id
 a640c23a62f3a-acad17d0177mr319859866b.24.1744384972806; Fri, 11 Apr 2025
 08:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250405204409.420738-1-sjg@chromium.org>
 <CAC_iWjJ07Z4PqZa9mXSnzp5TjsgXr3RL6FxSL2EV0oX7p8uN_g@mail.gmail.com>
In-Reply-To: <CAC_iWjJ07Z4PqZa9mXSnzp5TjsgXr3RL6FxSL2EV0oX7p8uN_g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Apr 2025 09:22:39 -0600
X-Gm-Features: ATxdqUFJjmyIxS8sI7xswcsMGJxbvnUweBZmFnCZpg5ZDLZEQbw6n5nlHvWGa9E
Message-ID: <CAFLszTg8BON21uopaDvNT+jkoq_O405arCnTp9ncSN1-cHjnEw@mail.gmail.com>
Subject: Re: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via EFI
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Niklas Sombert <niklas.sombert@uni-duesseldorf.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Ilias,

On Fri, 11 Apr 2025 at 04:04, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Sat, 5 Apr 2025 at 23:46, Simon Glass <sjg@chromium.org> wrote:
> >
> > The EFI-loader code has not been fully converted to use bloblist, so
> > relies on the SMBIOS-table address being set in global_data.
>
> Can you explain a bit more what this means?

It means that the EFI-loader code is still using gd->arch.smbios_start
to find the SMBIOS table. At some point we should move it to use
bloblist_get_blob().

> The SMBIOS tables for EFI
> are supposed to be on EFI allocated memory

Not allocated by EFI, just added to the EFI memory map. See
efi_smbios_register(). We still want to support SMBIOS tables if not
booting with EFI.

>
> >
> > Set this up in write_tables() so that the SMBIOS tables are actually
> > available.
> >
> > Enable the command for x86 QEMU so that the SMBIOS tests actually run.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 83ce35d6ebb ("emulation: Use bloblist to hold tables")
> > Reported-by: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
> > ---
> >
> >  arch/x86/lib/tables.c            | 2 ++
> >  board/emulation/qemu-x86/Kconfig | 1 +
> >  lib/efi_loader/efi_smbios.c      | 1 +
> >  3 files changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
> > index ec52992209f..d7f183f95dc 100644
> > --- a/arch/x86/lib/tables.c
> > +++ b/arch/x86/lib/tables.c
> > @@ -126,6 +126,8 @@ int write_tables(void)
> >                         use_high = true;
> >                         if (!gd->arch.table_start_high)
> >                                 gd->arch.table_start_high = rom_addr;
> > +                       if (table->tag == BLOBLISTT_SMBIOS_TABLES)
> > +                               gd_set_smbios_start(rom_addr);
> >                 }
> >                 rom_table_end = table->write(rom_addr);
> >                 if (!rom_table_end) {
> > diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
> > index b2a4e0891a4..c1564fba7cd 100644
> > --- a/board/emulation/qemu-x86/Kconfig
> > +++ b/board/emulation/qemu-x86/Kconfig
> > @@ -23,5 +23,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
> >         imply VIRTIO_PCI
> >         imply VIRTIO_NET
> >         imply VIRTIO_BLK
> > +       imply CMD_SMBIOS
> >
> >  endif
> > diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> > index 8d2ef6deb51..5275e966dfe 100644
> > --- a/lib/efi_loader/efi_smbios.c
> > +++ b/lib/efi_loader/efi_smbios.c
> > @@ -35,6 +35,7 @@ efi_status_t efi_smbios_register(void)
> >         void *buf;
> >
> >         addr = gd_smbios_start();
> > +       printf("register %lx\n", addr);
>
> I don't think this print is useful at all, why isn't the log_err()
> right below enough?

This was left in inadvertently and should be removed.

>
> >         if (!addr) {
> >                 log_err("No SMBIOS tables to install\n");
> >                 return EFI_NOT_FOUND;
> > --
> > 2.43.0
> >
>

Regards,
Simon
