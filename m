Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F6CC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 14:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4373F8293C;
	Tue, 29 Apr 2025 16:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fmd6DKGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D844682A0A; Tue, 29 Apr 2025 16:20:09 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DCA8272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 16:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso993800566b.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745936407; x=1746541207; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kza11D+6TwKVXwUyUKIpGPiTt4c4s2Vmb+q8ioCBW78=;
 b=fmd6DKGuzApn7ITExHo/wRXm6dZDTdpHwYtQx2jgzMyUErAggr7+okz0nLTmOmv9Ty
 Fk/2C0HHGdcn3Fv1jh6L/wFYbm930q+XLSc2uM5XrCbLmZvWhhMXkdwtRkoYLZWWwcPd
 0/8YA3YiHUiwKLSbpa3hX6873thMJ2b972NmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745936407; x=1746541207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kza11D+6TwKVXwUyUKIpGPiTt4c4s2Vmb+q8ioCBW78=;
 b=UiGxO7mo1ImgaPyOuZ6rpIpjm9g3HUugrcfPPK4Z1AKeqIgwoZN4DBW1DL869WnofQ
 pbC7MiLH6Lf0odt56MYgd9kgaSlBkap6OQ6I2WUdHmhscAa2giWQGOXSGfM7MsQxBju+
 fWVe5LYYIHtBgxLbpVlrjmYRHC57dn5rAjvwrBlEeYPvaGowaj56+q/aCypKaKJ6WUZH
 KRwu5IwfbfH7NBpaiexCOl9AyrhTGlc2mcZteWloOSvX72oLHtbgcJFpIFGfY5MusHP0
 EP0GL892Y28V56cbY2waZ2WkDfClEJaXsQPMPIU5tOLy+Q/8LXE9JsJ62fMt52CdK/Qb
 h6yQ==
X-Gm-Message-State: AOJu0YwRnr3+o5torss5wloYml4bMVsW4+2vrBpkQe+ya6/R8W8mSbgW
 EpgL5IQ6LR5cayNoUpeCldOloglGY9cVbSY9hlPbIk1IRat6jc56Z0/mTSTctCRFXN2+HjSLIT2
 95iMHo0QIymileOXZ+Kgna72SFBSXiJ2uJcfK
X-Gm-Gg: ASbGncuLfxRF6BNFpO3PQp9N5+AwUnE9ndvabxf2e22v3doaO7MhWoCojTF0tpojWfJ
 gXooKaTn4yi3NASyf1Qk57iE1GtpRWIHAuH0PN9DEyJy0CkFgFbwu3zXNucXBEX8KB725KnWUkf
 gKDwnMg+4nFQemvORO2+/csr8=
X-Google-Smtp-Source: AGHT+IGQiduXP5qmSnkgpSVLoLXthc1fw6MUS8e3qLe2TR59l5/arixGGquojzMRXbf6Kws7+flG3uDtJdKTKqIkbB8=
X-Received: by 2002:a17:907:1c10:b0:ac7:3918:50f3 with SMTP id
 a640c23a62f3a-acec87bb03amr306764166b.58.1745936406839; Tue, 29 Apr 2025
 07:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250405204409.420738-1-sjg@chromium.org>
 <0fe144dd-2885-4e13-bb09-4d939124a974@uni-duesseldorf.de>
In-Reply-To: <0fe144dd-2885-4e13-bb09-4d939124a974@uni-duesseldorf.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Apr 2025 08:19:54 -0600
X-Gm-Features: ATxdqUECLLM6uy7wbqJfeX1LOP4rQR0g9OzI4JEcpgcoMCKtHG5hU_RaoucPHMc
Message-ID: <CAFLszTjcV0e6AgRsbHdj2oW5o_4nE6KEEQ+QyxXgYVRgKtKn1Q@mail.gmail.com>
Subject: Re: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via EFI
To: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Niklas,

On Tue, 29 Apr 2025 at 05:30, Niklas Sombert
<niklas.sombert@uni-duesseldorf.de> wrote:
>
> Hi Simon,
>
> this solves my problem, thanks!
>
> Since SMBIOS is broken again in v2025.07-rc1 (and disabling bloblist
> doesn't work anymore), I applied this patch and it worked.
> I probably should have tried this sooner.

Thanks for testing this. Can you please reply with a 'Tested-by' tag?

Regards,
Simon


>
> Greetings,
> Niklas
>
> Simon Glass wrote:
> > The EFI-loader code has not been fully converted to use bloblist, so
> > relies on the SMBIOS-table address being set in global_data.
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
> >   arch/x86/lib/tables.c            | 2 ++
> >   board/emulation/qemu-x86/Kconfig | 1 +
> >   lib/efi_loader/efi_smbios.c      | 1 +
> >   3 files changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
> > index ec52992209f..d7f183f95dc 100644
> > --- a/arch/x86/lib/tables.c
> > +++ b/arch/x86/lib/tables.c
> > @@ -126,6 +126,8 @@ int write_tables(void)
> >                       use_high = true;
> >                       if (!gd->arch.table_start_high)
> >                               gd->arch.table_start_high = rom_addr;
> > +                     if (table->tag == BLOBLISTT_SMBIOS_TABLES)
> > +                             gd_set_smbios_start(rom_addr);
> >               }
> >               rom_table_end = table->write(rom_addr);
> >               if (!rom_table_end) {
> > diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
> > index b2a4e0891a4..c1564fba7cd 100644
> > --- a/board/emulation/qemu-x86/Kconfig
> > +++ b/board/emulation/qemu-x86/Kconfig
> > @@ -23,5 +23,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
> >       imply VIRTIO_PCI
> >       imply VIRTIO_NET
> >       imply VIRTIO_BLK
> > +     imply CMD_SMBIOS
> >
> >   endif
> > diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> > index 8d2ef6deb51..5275e966dfe 100644
> > --- a/lib/efi_loader/efi_smbios.c
> > +++ b/lib/efi_loader/efi_smbios.c
> > @@ -35,6 +35,7 @@ efi_status_t efi_smbios_register(void)
> >       void *buf;
> >
> >       addr = gd_smbios_start();
> > +     printf("register %lx\n", addr);
> >       if (!addr) {
> >               log_err("No SMBIOS tables to install\n");
> >               return EFI_NOT_FOUND;
>
