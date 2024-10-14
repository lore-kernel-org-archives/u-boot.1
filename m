Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBADD18133
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 17:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3602888D51;
	Mon, 14 Oct 2024 19:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wskmj4fQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F9788D72; Mon, 14 Oct 2024 19:16:44 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F67688CA1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 19:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e31af47681so1624257a91.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728926201; x=1729531001; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROepkrZLgm2/qdW/IxCAsNJtUSPGi0BXj3Gt+tzMOM4=;
 b=Wskmj4fQ02y1P74nQMfvFghsj3xnWhw4zyKMzvXRzj3j+bsvV/aJsD/8VVF6s1wmSm
 EoST4Xnom1IlaIP9Uxt5nVRI7e0pPZYmd/4GM+40gCUg1JZ3ngLZYCa+U1MgZznuV7ea
 A2milcAqpZq2SBMKprRQP1N7c5MppxD/6f8r9Car/neV8o+BHhrQfvNxJCam7HB0zOab
 S4m2g13l6oNOSZfFoRyt3rKqP9T4qOpBE0+noQs+EkRjq3c8rPXbB6rJSdDqdq585Bz8
 WC3WyRuA/OgUUqAnm2KwvAVzxqDbOzf7MY/P2CNH2hurpNae7B9Ab1UScMFgCZYko1iI
 ZR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728926201; x=1729531001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROepkrZLgm2/qdW/IxCAsNJtUSPGi0BXj3Gt+tzMOM4=;
 b=Nco3W76uf1NQ5D/bTiO+NJIfQhxQ5r/tglDYOFtOXFRyF+4t8d9rtTM5zGVyzeUf4L
 TmQOqmhBwDnNjX+lb1M2q0PnAW1CHrVA8TOLMMKQJqdmC++jYSaAgS3kbAZSwsoWbhnu
 EPXByZnYEZRvkXc6mWwuCFYoLSKefE6w9nDnGqQ0+IV2aPr/P/WeklFiHx5TKc6CWfi7
 b0YqWdXfABfHORtBx8zA11R9suv8k0IM9TBYLulPk3KY+FypWgJhRByN/roeYW+IRsKN
 ulkRMkHHEMWzLxVPzcZ6pnGnPyiahysMqDaPk+FmK+ZmoILf2DenO77k/ywuG16+8n5/
 CmLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnsr9gZls7ZVbZVMNAVJAjckm3184sID4yGU33dD6oQleu2USJYfdrfDijBiE7J+kS9hf8SP0=@lists.denx.de
X-Gm-Message-State: AOJu0YyvmGcLS0Tsi0Dam1Zo4dxUnOH/hoaso7pF21893KFNqfpW8f1S
 9HA61uFywL/8khP3eMK3MNsWXRSq37Ho5jlYXoUn1Mmpo6uNY1sCijJSsqQc83nk8+/wiWgYIeL
 LrBkM+xsL/ZJmuIwJB+pNPEryyB+tL6g4eiRqfw==
X-Google-Smtp-Source: AGHT+IGheymr+6wNGl+wlw8wxEJE5ZGFUsKJRoVIbn75y4gXwIYnjMaRSVY00GljMbbTLiNVEXWi41cO2JD9zrJn7aQ=
X-Received: by 2002:a17:90a:b383:b0:2e2:eacc:3227 with SMTP id
 98e67ed59e1d1-2e2f0b01fddmr14039279a91.23.1728926200643; Mon, 14 Oct 2024
 10:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241011173341.24330-1-heinrich.schuchardt@canonical.com>
 <875xpyle5k.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <875xpyle5k.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 20:16:04 +0300
Message-ID: <CAC_iWjJ6DPe9Fif0cbL12Fc54vhap6Z4NZ+JA0Phr_VthP=7jA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: provide variable BootOptionSupport
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 vincent.stehle@arm.com, u-boot@lists.denx.de
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

Hi Mark,

On Fri, 11 Oct 2024 at 20:53, Mark Kettenis <mark.kettenis@xs4all.nl> wrote=
:
>
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Date: Fri, 11 Oct 2024 19:33:40 +0200
>
> Hi Heinrich,
>
> > The UEFI variable BootOptionSupport is required by the UEFI specificati=
on
> > [1]. It reports if specific types of boot options are honored.
> >
> > We don't support any of these extras. So we should set the value 0.
>
> It also says:
>
>   "If the global variable is not present, then an installer or
>    application must act as if a value of 0 was returned."
>
> So until we support any of those extras, we don't have to provide that
> variable.
>
> > [1] 3.1.4 Boot Manager Capabilities, UEFI Specification 2.10 Errata A,

It does, but is there a problem with being explicit? Are you concerned
about the size growth?

Thanks
/Ilias
> >
> > Cc: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_loader/efi_setup.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index a610e032d2f..05d035f4eb5 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -179,6 +179,22 @@ static efi_status_t efi_init_os_indications(void)
> >                                   &os_indications_supported, false);
> >  }
> >
> > +/**
> > + * efi_init_boot_options_support() - indicate supported boot option ty=
pes
> > + */
> > +static efi_status_t efi_init_boot_options_support(void)
> > +{
> > +     u32 boot_options_support =3D 0;
> > +
> > +     return efi_set_variable_int(u"BootOptionSupport",
> > +                                 &efi_global_variable_guid,
> > +                                 EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                 EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                 EFI_VARIABLE_READ_ONLY,
> > +                                 sizeof(boot_options_support),
> > +                                 &boot_options_support, false);
> > +}
> > +
> >  /**
> >   * efi_init_early() - handle initialization at early stage
> >   *
> > @@ -261,6 +277,13 @@ efi_status_t efi_init_obj_list(void)
> >       if (ret !=3D EFI_SUCCESS)
> >               goto out;
> >
> > +     /* Indicate supported boot option types */
> > +     if (IS_ENABLED(CONFIG_EFI_BOOTMGR)) {
> > +             ret =3D efi_init_boot_options_support();
> > +             if (ret !=3D EFI_SUCCESS)
> > +                     goto out;
> > +     }
> > +
> >       /* Initialize system table */
> >       ret =3D efi_initialize_system_table();
> >       if (ret !=3D EFI_SUCCESS)
> > --
> > 2.45.2
> >
> >
