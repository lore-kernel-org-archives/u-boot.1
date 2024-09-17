Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1981C36015
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 11:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBAAA88D06;
	Tue, 17 Sep 2024 13:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R96ceALm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D180E88D06; Tue, 17 Sep 2024 13:41:52 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93DDF88CC9
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 13:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7db4c1a54easo1645599a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726573306; x=1727178106; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4JpJMfaxBdATSlGM3HrDSXuJ66VVcJsTMBA2WGkSnY=;
 b=R96ceALmwV5TzHFhXPNWIiR4PCIBLZ9nF6iJZeuCq/UGVgxPJxB+dLcp77ucsxzm2H
 9ZTBHhTHLa6BV8nAxswt3C6fF3jDQrLvcd0sAghqUfD50wvFKo/rpppDo4kKJmjQANgo
 0R5GsThGAmEQ1bBEkc9ZGLGCn6ph+mdoVibv5/zBo7RLu6IMt+mp5Puv5UMo9IIaC1Pz
 Mq4etnbA6UVQPblYRnAfd40Gp/MQGmkPin1DX9dfu7b9mNyY5HvFCl7K+CdXPnmgGFDc
 dpQ0E5xfIjmh/snI0RqLDEU8dgwVhpPuXwyWMKfuNJnJgt5erFhkE1F7Rk/PwPXhSxvx
 kacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726573306; x=1727178106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4JpJMfaxBdATSlGM3HrDSXuJ66VVcJsTMBA2WGkSnY=;
 b=jZBO5RfK2nVTq5E1Hek9bhWZH75YudQEQ5+DNuob8GyTeIjp9IRv1vjFQicMo2CprI
 hwKJGqM1gVz+O1oZoVS079yeyHR9vVap7ukurrnAuonjpAigcvxo6iq9d8MZbUoCDd0f
 u9x0OpqJSEF12oteQE8EXNMJKc4b/v5wp8IgwIfNwv7+kTwG75fkE7nqP3N9zwYPhe0q
 hFzmIwVu3dy4GVqus0LK+skmUcAE37aKMgwTM4jk2hQMziSMC0chbpqmkP85S+zy55YK
 cWT7H8v2dZkpVhxHSGh5Q9Q8yAdC3bk85n98+m+41F2GMs9at5Wmn8bmWR2hi18LHsRe
 Glqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIE64NEHn3P2vGSRQ0GB25JEZ96jvyjbVYd3Ya3hac482Dz52yBXmngqDoLWHNakDNwAADc2s=@lists.denx.de
X-Gm-Message-State: AOJu0YxZKJ19+rTTswA87/5RAe22HE5pZSOhkKMHbi3qJIHPqQ8+Atwk
 KNGpyFuzB406BCoV7q+Zb/U6T9iqhCcepni/dhBqa207y7gbOjUCbjqtiFFX1gR0A+jtNB7VxAE
 CeXJOkCO6EwVGviTS9ao4Azn3EeEitrYzinZEKw==
X-Google-Smtp-Source: AGHT+IFEdG/iNeZ1P4+kVxI/PYH9J2iAkc/sjrIUIZn61kVzwUwa3wZq0P/CrO8+OZtEgfonREU1AsPfNMmKue4nSLE=
X-Received: by 2002:a05:6a20:c888:b0:1cf:4102:9762 with SMTP id
 adf61e73a8af0-1cf76244cbemr22438142637.42.1726573305893; Tue, 17 Sep 2024
 04:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240917090218.77246-1-ilias.apalodimas@linaro.org>
 <CADg8p968=pmYLm-b+Q+zJhjXJRguyyH-XazPo5pH_hxY8Kbijg@mail.gmail.com>
In-Reply-To: <CADg8p968=pmYLm-b+Q+zJhjXJRguyyH-XazPo5pH_hxY8Kbijg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Sep 2024 14:41:09 +0300
Message-ID: <CAC_iWjLzxVovnqqv8M6EU2ct+BAK6KD0y9g=Y6K9Y9J9NqZcKw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Don't allocate from Special purpose memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Tue, 17 Sept 2024 at 13:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote=
:
>
> On Tue, 17 Sept 2024 at 14:32, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > The EFI spec defines special-purpose memory in =C2=A77.2. That memory
> > serves as a hint to the OS to avoid allocating this memory for core
> > OS data or code that can not be relocated. So let's ignore it when
> > allocating from conventional memory.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
>
> Can we rebase this patch on top of the LMB/EFI series patches that are
> currently under review. I believe if we consider the direction that
> the EFI allocation functionality is going to take, that of relying on
> LMB for allocating conventional memory, we will have to take a
> different route to this problem, whereby 1) the LMB module needs to be
> intimated that the region of memory is reserved so that it does not
> get allocated by LMB and 2) then adding this region of memory as
> special-purpose in the EFI memory map.

So, the problem here is LMB (outside EFI) trying to allocate a piece
of memory right? Because the EFI subsystem should do this check an
exit before it allocates memory.
I don't mind waiting, since I discovered the problem while working on
a patch series for persistent memory. I can send it then.
The EFI memory attributes can change at any point in time. So we will
need to augment the notification to the LMB subsystem that marks that
memory as reserved for LMB whenever memory attributes change.

Thanks
/Ilias


>
> -sughosh
>
>
> >  lib/efi_loader/efi_memory.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index c6f1dd09456e..74732e37f8aa 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -422,7 +422,8 @@ static efi_status_t efi_check_allocated(u64 addr, b=
ool must_be_allocated)
> >
> >                 if (addr >=3D start && addr < end) {
> >                         if (must_be_allocated ^
> > -                           (item->desc.type =3D=3D EFI_CONVENTIONAL_ME=
MORY))
> > +                           (item->desc.type =3D=3D EFI_CONVENTIONAL_ME=
MORY) &&
> > +                           !(item->desc.attribute & EFI_MEMORY_SP))
> >                                 return EFI_SUCCESS;
> >                         else
> >                                 return EFI_NOT_FOUND;
> > @@ -460,6 +461,9 @@ static uint64_t efi_find_free_memory(uint64_t len, =
uint64_t max_addr)
> >                 if (desc->type !=3D EFI_CONVENTIONAL_MEMORY)
> >                         continue;
> >
> > +               if (desc->attribute & EFI_MEMORY_SP)
> > +                       continue;
> > +
> >                 /* Out of bounds for max_addr */
> >                 if ((ret + len) > max_addr)
> >                         continue;
> > --
> > 2.45.2
> >
