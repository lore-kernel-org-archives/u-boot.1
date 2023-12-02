Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48167C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 22:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A97787756;
	Sat,  2 Dec 2023 23:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="pePNKJUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA3687763; Sat,  2 Dec 2023 23:45:16 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC728876CB
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 23:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a00f67f120aso461225666b.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 14:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701557114; x=1702161914;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WochP481W7ixSvoMpmOFwOjyQmFDI9++b5VWmERII4=;
 b=pePNKJUbXK4Hn720cbYa1f5knUhjL9W67YSvbUpxXt/PvdQNZdhBHOwYX5qR4Yhuf9
 NG+YtRgFY+uQox/qPDAtkaGWlgkPzVr/xjODlCl3qQMb5csvu2YHja1OSj8Ag310kdtD
 x6EhmmqI8JT1uLwjzKZpltvLyZoupU02Nl2hzn6rV0I3hix2Ki/V3KReTFXyCJLJ5PKL
 uHuwPPR/CTzkQyyKayi2MRllHHsrl6tEY00kvmUiQOMskXE0tkNUz3DhYSzf1cWQRf3U
 gI8ruvnaPPGKi5IrUavI/+EfiYEKiaMuY4tW3WPsuNQtVQkT3/W42XJtV25wzqZYae1c
 zXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701557114; x=1702161914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WochP481W7ixSvoMpmOFwOjyQmFDI9++b5VWmERII4=;
 b=OkgCa+rlLtiHNPkfk3NHHGqoG6twuGXzDdnZ88q2p/CiXE/yDvMOWhd4TiEIQbsnAO
 gcRtXJEoewYZioXSg8o3KecvHGks01entnLWMM+8MB4FY9cuicNK7YudvwFKkS5bX+wz
 yVCJbAv3ewuKKeA6jweXfLAr+Rn4YUtnWUz9UIklVPg8cGkbCPs8leQ060HpJc2YRLg7
 r/kdD9yPkPw3X6XFX1RcZMNt7FaueN+hL+cfQ/uJawJhKHLXEeJaAbOR+o4+DsJt+En0
 ruXti1vJTPx8pHBMjAli+In/A70wuzILAwlS6d5BYPPMZdb+bA+Tn6jSLFnpxywVteBG
 x6mg==
X-Gm-Message-State: AOJu0YxoIVIv/u9HGPG7CdxH5ClVSyT7WXxs02o44zcsm9uIPwi4ZKte
 GCnB1gJp37+6AIHDzpOh2t8j7+0q3Jv2mmFqvmaYnQ==
X-Google-Smtp-Source: AGHT+IFXdntMBeZlovTt3MmDHc32slJn3+w7psvjmNb6zSDtPOyMIFoYH9favO6Ev9krDFlNnSsjJA==
X-Received: by 2002:a17:906:1c50:b0:a18:d79a:1d06 with SMTP id
 l16-20020a1709061c5000b00a18d79a1d06mr1803487ejg.37.1701557113967; 
 Sat, 02 Dec 2023 14:45:13 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 j21-20020a170906279500b00a0949d4f66fsm3521020ejc.54.2023.12.02.14.45.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 14:45:13 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-54c901c4853so709497a12.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 14:45:12 -0800 (PST)
X-Received: by 2002:a50:d7d4:0:b0:547:9f26:e581 with SMTP id
 m20-20020a50d7d4000000b005479f26e581mr42374edj.37.1701557112310; Sat, 02 Dec
 2023 14:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20231126220836.374956-1-i@shantur.com>
 <20231126220836.374956-3-i@shantur.com>
 <CAC_iWjKyyo2mri1706wB0XmGGDQqocvaNkYRpWNxeH_tvXUh_g@mail.gmail.com>
In-Reply-To: <CAC_iWjKyyo2mri1706wB0XmGGDQqocvaNkYRpWNxeH_tvXUh_g@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 2 Dec 2023 22:45:01 +0000
X-Gmail-Original-Message-ID: <CAHc5_t07NULVxNVChRRg-qLzRehX2JMYe_4wt-MTWh33DZsGAw@mail.gmail.com>
Message-ID: <CAHc5_t07NULVxNVChRRg-qLzRehX2JMYe_4wt-MTWh33DZsGAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi_vars: Implement SPI Flash store
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
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

Hi Ilias,

On Thu, Nov 30, 2023 at 10:10=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Shantur
>
> I have a few remarks on the architecture.
> Up to now, we are supporting
> 1. Variables on a file
> 2. Variables on an RPMB
>
> The reason those two are in different files is that we generally
> expect to use different bootime services and few differences in
> efi_variables_boot_exit_notify() and efi_init_variables().
> Whatever is common, for example the runtime functions are common
> across those two since they both implement variable runtime service
> via the memory backend, goes into efi_var_common.c, the memory backend
> operations should go in efi_var_mem.c.
>
> Since the SPI and file storage are similar -- and probably any storage
> medium controlled by the non-secure world, I am fine treating treat
> efi_variable.c as the variable management for the non-secure world and
> see if that needs changing in the future.
>
> As Heinrich pointed out the functions you are moving are better off
> moved into efi_var_mem.c.
>
> [...]

Happy to move them efi_var_mem.c
I will do that as part of v4

>
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variabl=
e.c
> > index adc5ac6a80..f73fb40061 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -354,14 +354,16 @@ efi_status_t efi_set_variable_int(const u16 *vari=
able_name,
> >                 ret =3D EFI_SUCCESS;
> >
> >         /*
> > -        * Write non-volatile EFI variables to file
> > +        * Write non-volatile EFI variables to file or SPI Flash
> >          * TODO: check if a value change has occured to avoid superfluo=
us writes
> >          */
> > -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> >         if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> > +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> >                 efi_var_to_file();
> > -       }
> > +#elif CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> > +               efi_var_to_sf();
> >  #endif
> > +       }
> >
> >         return EFI_SUCCESS;
> >  }
> > @@ -471,9 +473,14 @@ efi_status_t efi_init_variables(void)
> >
> >  #if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> >         ret =3D efi_var_from_file();
> > +#elif CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> > +       ret =3D efi_var_from_sf();
> > +#else
> > +       ret =3D EFI_SUCCESS;
> > +#endif
>
> Instead of those ifdefs can we do something different?
> Define a structure with two function callbacks for read/write(). Add
> the same function in both efi_var_file.c and efi_var_sp.c which fills
> in those callbacks and have an efi_init_variable() call to that
> function (obviously the SPI and file will be mutually exclusive)
>

Sure, will add to v4 too.

Thanks,
Shantur
