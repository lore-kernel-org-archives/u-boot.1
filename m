Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA47AC36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482B781F0D;
	Wed,  2 Apr 2025 21:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E+B0+LCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B7F81F30; Wed,  2 Apr 2025 21:27:41 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F06D81E1F
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e6dd991a0e6so126354276.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743622058; x=1744226858; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWlGt+CT5eFAnc1BqUoQw2Cug5BauIB2VLsQ/24bKH8=;
 b=E+B0+LCo+Qf/BeLtBWLdrEid4728tY5C9ptfyEkxPzY3unMAKPiDxsV1X14AgtfRaQ
 V18SY81MNinyiq8oRxkELovh6wJQaD2C3uwi9sN5LLK8PONJiwSnar6XMMmd8mul/CFj
 5yL/6MlyTWqQsRGWwUIYdpavY3LytoopRe4zLmiqKeaUVFDaBUzkvFGT2koWuIyAiafl
 BCuJUBw5Y99kx0Lm2dkDQjWhtS+vONxQ5T7Tj+Qemq3uUIYUgpn52Mzsj1flhhJzC9Bu
 QR3yBg+zXezgGWaChriqCNIJi+XZM1So7I/UM9WsidR7L7qiKsFxagilxfQexOERONDq
 om/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743622058; x=1744226858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWlGt+CT5eFAnc1BqUoQw2Cug5BauIB2VLsQ/24bKH8=;
 b=WjFFrjE6WtyAY7NLYS8sH2SmHtpznxKCcYL/17FaFMneUIG7Smp3cmbwUnzRUxuWl0
 0YZgk96VJiyW/F2wZXY9wB2/X5R7fnFgMyAWfRdFSfQzs5FcbFHyBRquQsdQmakRyvny
 w/QfLOOl9YcWghsjD/IeAOUMru6cbRMTvCr4nKIO3I6V1027WQER+04gDweShJkPR1tI
 5DjhiNnganh5LJvbsgqgvf1IwiXng2dexAKUFEyWud5AvaEQmQd9uBL0zeCi2yw1TXq3
 SOiYhR53SPzq8Ehe3wQh5+3M5bz2eMF7rjcrWdbQNcKYt6wh9GtX73Hf89vH4Ao1zDVL
 6dPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm5Uuitkft/jFYkY4jR4ihc528JouRa+ANyFtVV5iptGokxm0yXt636fVD5aynzNg6Um82b54=@lists.denx.de
X-Gm-Message-State: AOJu0Ywkb9N/PWvhSOk50n3v6AP4EtM2Zo9HbrdF2V1AOkEYOlXIeDt1
 k1qPfSxFqh+S7FJzk2JxoIZ/JgX7kmFiErTQ6XfecnmpQKOh43LdQx4h4Egni0ZrxcA6K1zbp/6
 8SXMNx1+c4hVHGHgI7JgJaEknydLh+BKIQsJH5w==
X-Gm-Gg: ASbGncu8CvaJmh/Y2fr119GB5MVLGSXsL/66EZy72TAyVJtwcg/+bzl760Hx4vRfdgt
 k07X9rPWyFBQS5HvDFjTboOi/sMVvfm5s5fEM33hztW5Q26aoTM4xssO6Dz+1JLv+LdzAEZxDoH
 Fdv0vfEQfKIpzt8x+L8MV0VZOP6xmz4Q/MzLk=
X-Google-Smtp-Source: AGHT+IGF927OyouTs9d8I4dS6rHS2tSujLKTXaUXbPseoW5ZsxhWAgtDbyrAScFIyFIabx9F9eY/bOpJg3MhknnBEjg=
X-Received: by 2002:a05:6902:200e:b0:e69:18e6:69df with SMTP id
 3f1490d57ef6-e6b83acc94fmr24247286276.47.1743622057708; Wed, 02 Apr 2025
 12:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
 <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
 <CAC_iWj+3cc5LxL-Xrh=gO0hHgj60Qs5DsZxfZheQC8QywdMYbA@mail.gmail.com>
 <CAFLszTjtDHCCm-RCv=WnUdHCSQ5ghTafmT2P576ED6A34ARPRQ@mail.gmail.com>
In-Reply-To: <CAFLszTjtDHCCm-RCv=WnUdHCSQ5ghTafmT2P576ED6A34ARPRQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Apr 2025 22:27:01 +0300
X-Gm-Features: AQ5f1JopGpiqBZ3rPEkAFYGURSWbg6fXuDZJMpKzKI8RJpWz5crPybcK-dwpt2M
Message-ID: <CAC_iWjLsbeG7fL1oWfarSU0e+ow5gxbxOJurT7=XmfkH_ojVvQ@mail.gmail.com>
Subject: Re: RISC-V UEFI/ACPI on QEMU regression?
To: Simon Glass <sjg@chromium.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 2 Apr 2025 at 22:19, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Thu, 3 Apr 2025 at 03:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 2 Apr 2025 at 17:26, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hey Bjorn
> > >
> > > Long time, hope all is well!
> > >
> > > On Wed, 2 Apr 2025 at 16:22, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>=
 wrote:
> > > >
> > > > Hi,
> > > >
> > > > I think I got a regression from commit 53d5a221632e ("emulation: Us=
e
> > > > bloblist to hold tables"), and v2024.10 for
> > > > qemu-riscv64_smode_defconfig + acpi.config booting Linux with UEFI.
> > > >
> > > > TL;DR: It seems like the RSDP is placed in the wrong EFI memory map
> > > > type (it should be "ACPI Reclaim").
> > > >
> > > > I might also be misunderstanding what config fragments should be
> > > > used -- I'm out in the weeds here! ;-)
> > > >
> > > > When I was using v2024.10, ACPI RSDP was in ACPI Reclaim memory. Al=
l
> > > > good, and e.g. a kexec would properly work. However, when using u-b=
oot
> > > > with commit 53d5a221632e ("emulation: Use bloblist to hold tables")=
 I
> > > > get the following when booting, and then kexec:
> > > >
> > > > First kernel:
> > > > [    0.000000] ACPI: Early table checksum verification disabled
> > > >                                                   [    0.000000] AC=
PI:
> > > > RSDP 0x000000047EED3000 000024 (v02 BOCHS )
> > > > Kexec kernel:
> > > > [    0.000000] ACPI: Early table checksum verification disabled
> > > > [    0.000000] ACPI:      0x000000047EED3000 000000 (v00
> > > >   00000000      00000000)
> > > > [    0.000000] Oops - load access fault [#1]
> > > >
> > > > RSDP reside in:
> > > > [    0.000000] efi:   0x00047ded1000-0x00047eee3fff [Boot Code   | =
  |
> > > >  |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
> > > >
> > > > (Boot Code vs ACPI Reclaimed)
> > > >
> > > > Now to get qemu-riscv64_smode_defconfig + acpi.config to build
> > > > post-2024.10, I needed to add the following fragments:
> > > >
> > > >   CONFIG_BLOBLIST=3Dy
> > > >   CONFIG_BLOBLIST_ALLOC=3Dy
> > > >   CONFIG_BLOBLIST_SIZE_RELOC=3D0x20000
> > > >
> > > > which is really just a "make the build not complain", guessing game
> > > > from my side.
> > > >
> > > > My guess would be that it's related to the change in
> > > > evt_write_acpi_tables(), where:
> > > >
> > > > -    ptr =3D memalign(SZ_4K, SZ_64K);
> > > > +    ptr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, SZ_64K, 12);
> > > >
> > > > is done.
> > > >
> > > > Is my config fragment broken, or is this a proper regression?
> > >
> > > I think it's a regression and I think what breaks it is commit cfb4aa=
2a754ed1
>
> Yes, that's right. It was reported by Patrick Rudolph in mid-Feb and I
> sent a patch about a month ago [1]
>
> It seems to be in Heinrich's queue in patchwork.
>
> > >
> > > Can you apply the diff below and see if it fixes it for you?
> > >
> > > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > > index 4422b31ac6a7..afa5eee85484 100644
> > > --- a/lib/efi_loader/efi_acpi.c
> > > +++ b/lib/efi_loader/efi_acpi.c
> > > @@ -34,8 +34,8 @@ efi_status_t efi_acpi_register(void)
> > >          * add_u_boot_and_runtime(). At some point that function coul=
d create a
> > >          * more detailed map.
> > >          */
> > > -       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > > -               return EFI_SUCCESS;
> > > +       //if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > > +               ////return EFI_SUCCESS;
> > >
> > >         /* Mark space used for tables */
> > >         start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> > >
> > > Simon, why that PR got sent with no ACKs from any of the EFI maintain=
ers?
>
> I didn't send a PR, but it's not clear that anyone would have spotted
> this bug as it is pretty subtle. It would be good to have testing for
> this case. We can actually do that by expanding the bootflow_efi()
> test.
>
> >
> > And please fix whatever tooling you use to CC the proper maintainers
> > next time [0] as I don't see my name in the CC list
>
> You had asked not to be cc'd on my patches anymore,

Are you sure?

> so I just cc
> Heinrich now, unless I manually override it.

I asked not to be cc'ed on patches that don't apply to -master or
-next and are for your tree. I obviously want to be CC'ed for anything
related to subsystems I help maintain.

Thanks
/Ilias

>  Let me know what you'd
> like me to do.
>
> Regards,
> Simon
>
> >
> > [0] https://lore.kernel.org/u-boot/20250111000029.245022-27-sjg@chromiu=
m.org/
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250306143134.25498=
15-1-sjg@chromium.org/
