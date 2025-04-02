Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B4C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D8C181703;
	Wed,  2 Apr 2025 16:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x/2bWGzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D818781F28; Wed,  2 Apr 2025 16:36:24 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECB180FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7023843e467so53952737b3.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743604581; x=1744209381; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PjgFYM0uOB6RrKHkou6uAGhSbLFq7tpKUPcnEpglEc=;
 b=x/2bWGzr499S8QkOtr4PeloXri4lpIPcq+Pd3ELAdyQPdum6wt+TLIkLYjqjZY0oMT
 8xfo6GCLTeFFvwbr0473fWJr+cZICDLxrWT4QyAM4/tpyiKfL1RMbDB0myt66Qbpgl45
 dzY2r2gpC6VpipFLEIAlYPd3cJOR0HJ1mX2TL/tGCuHmJoRKRQi2Ld0f8CE475fFUbxP
 AR2mZTgKObZ4xvSYGYi9nMAk6aqnZ0G790fIIbwlcZhAsT2SmZp1JLC1YuEwKEahq/nC
 8BcUaOC9PA4QJ7r8q/ctSDarg4CqqbJmm4zwzy3ztxWwIRYyNKp4upbDkC9OYziGCLyf
 hp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743604581; x=1744209381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PjgFYM0uOB6RrKHkou6uAGhSbLFq7tpKUPcnEpglEc=;
 b=OrLPFxGNtOGyu5tY0/l6VHRsa7+zKMxkZlETBzo9yahKeQs5rwc5ETto/nwtWDBgo1
 NHRMZ6S/c5HQ+XLsj0GAEMD9P+k82EAKwj4WHoOeIbLpSy2nLZAv0MtGs1pT5yhsUf11
 p1cn9VWnEkYoYAI/jqjqd3qEkyw+YDeFHkSebpojtrweQoxkVFX3Fv4jtxBEUZYBEhYz
 Kf8qJ7Hq4f1b8QUiSJg4uAEK5fRprzBPsPPnkXhyoXBnUqKaM95HCa57q4df3OelhJYo
 1DJdbvbvmmuA9G0Tk1CSKkQSjAhv9zWDxzikHC/+odjowyzCMSDPR5Q7AjLJHvLbPioj
 E1oQ==
X-Gm-Message-State: AOJu0YzSloQ4P7cXExZDH3B/6OX1K6bUBcBEgzDZ1N1xYYdxBjRFoYxB
 kUlvKICbMQkL6QPda1ZTqjwA/5T61OKeWnyO/d1ZegxRrv7sdBbWz3bMXRvF+NPC0zmpjtJayMr
 HNnjBjkvDjWQw0b/ZG4ZzPJtS/HHmHo8K3Kl7Fg==
X-Gm-Gg: ASbGncvDpRbIFvYvv08Nj/+ncuxleu6jB75tR5RqElmEYobOBrrepiconTF0YTh6gPX
 U7s2aJ0YFfDnyHKTncZk5BSyaynKgtkFtm1iDFxflmIU2+T/qjtB5sSt1GzqIxqenVVoVdfAlwo
 cJyp+aIxnSdown4AKpLHpebZ5M
X-Google-Smtp-Source: AGHT+IH0Rn+SujLWxizPi4jXJvIgJs9aFXR9YCdjNICBr9K0ctFlsqp1GHST9yX/MH3vQwkOfzHMJQLIvO3WI4QurGc=
X-Received: by 2002:a05:690c:680e:b0:6fe:c021:624 with SMTP id
 00721157ae682-702570e6851mr231328387b3.8.1743604580925; Wed, 02 Apr 2025
 07:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
 <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
In-Reply-To: <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Apr 2025 17:35:44 +0300
X-Gm-Features: AQ5f1JqfB47VHTZwOmQsVyQw_gafpHtmUpgLprroGuXJu4v-y9ZhfniotBzLIRk
Message-ID: <CAC_iWj+3cc5LxL-Xrh=gO0hHgj60Qs5DsZxfZheQC8QywdMYbA@mail.gmail.com>
Subject: Re: RISC-V UEFI/ACPI on QEMU regression?
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 2 Apr 2025 at 17:26, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hey Bjorn
>
> Long time, hope all is well!
>
> On Wed, 2 Apr 2025 at 16:22, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
> >
> > Hi,
> >
> > I think I got a regression from commit 53d5a221632e ("emulation: Use
> > bloblist to hold tables"), and v2024.10 for
> > qemu-riscv64_smode_defconfig + acpi.config booting Linux with UEFI.
> >
> > TL;DR: It seems like the RSDP is placed in the wrong EFI memory map
> > type (it should be "ACPI Reclaim").
> >
> > I might also be misunderstanding what config fragments should be
> > used -- I'm out in the weeds here! ;-)
> >
> > When I was using v2024.10, ACPI RSDP was in ACPI Reclaim memory. All
> > good, and e.g. a kexec would properly work. However, when using u-boot
> > with commit 53d5a221632e ("emulation: Use bloblist to hold tables") I
> > get the following when booting, and then kexec:
> >
> > First kernel:
> > [    0.000000] ACPI: Early table checksum verification disabled
> >                                                   [    0.000000] ACPI:
> > RSDP 0x000000047EED3000 000024 (v02 BOCHS )
> > Kexec kernel:
> > [    0.000000] ACPI: Early table checksum verification disabled
> > [    0.000000] ACPI:      0x000000047EED3000 000000 (v00
> >   00000000      00000000)
> > [    0.000000] Oops - load access fault [#1]
> >
> > RSDP reside in:
> > [    0.000000] efi:   0x00047ded1000-0x00047eee3fff [Boot Code   |   |
> >  |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
> >
> > (Boot Code vs ACPI Reclaimed)
> >
> > Now to get qemu-riscv64_smode_defconfig + acpi.config to build
> > post-2024.10, I needed to add the following fragments:
> >
> >   CONFIG_BLOBLIST=3Dy
> >   CONFIG_BLOBLIST_ALLOC=3Dy
> >   CONFIG_BLOBLIST_SIZE_RELOC=3D0x20000
> >
> > which is really just a "make the build not complain", guessing game
> > from my side.
> >
> > My guess would be that it's related to the change in
> > evt_write_acpi_tables(), where:
> >
> > -    ptr =3D memalign(SZ_4K, SZ_64K);
> > +    ptr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, SZ_64K, 12);
> >
> > is done.
> >
> > Is my config fragment broken, or is this a proper regression?
>
> I think it's a regression and I think what breaks it is commit cfb4aa2a75=
4ed1
>
> Can you apply the diff below and see if it fixes it for you?
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 4422b31ac6a7..afa5eee85484 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -34,8 +34,8 @@ efi_status_t efi_acpi_register(void)
>          * add_u_boot_and_runtime(). At some point that function could cr=
eate a
>          * more detailed map.
>          */
> -       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> -               return EFI_SUCCESS;
> +       //if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> +               ////return EFI_SUCCESS;
>
>         /* Mark space used for tables */
>         start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
>
> Simon, why that PR got sent with no ACKs from any of the EFI maintainers?

And please fix whatever tooling you use to CC the proper maintainers
next time [0] as I don't see my name in the CC list

[0] https://lore.kernel.org/u-boot/20250111000029.245022-27-sjg@chromium.or=
g/

>
> Thanks
> /Ilias
> >
> >
> > Thanks!
> > Bj=C3=B6rn
