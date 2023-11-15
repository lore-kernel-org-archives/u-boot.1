Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EB7C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 10:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD433804CE;
	Wed, 15 Nov 2023 11:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XWgyGZ6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4700185C98; Wed, 15 Nov 2023 11:45:58 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E2F8037B
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso10272647a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700045156; x=1700649956; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgdsqNPdjquiH5wJOzIliEOEDZ/i7h4XfQ78gIIxJrQ=;
 b=XWgyGZ6vQmvU9zd1hGgopSoGUyoGHSrxhOfZ9ExrU6jEC+Ypl6Wl+YQ0Sq3Sopd28q
 mM3DnFLPAe7uGrF7AwOAvkYqO1dlLlDMOTlfnWeuS90yA2feR3gTtrq6ZD5ad/9iOxGN
 kP9G6h9upDAHFBNkYeyvEKJyO9PRub39WZGFZ0uayc4u6L2wKAiG2wWsd6H2iyELhBa7
 wncIassZrCkPuupLQqGOYXZU1ZW+lhKiLNmgiyYsrKebM+CpMR/yKFJJnMk6uKfBZGcS
 hxcrHTRoMpuh0FFfH/PwVqeF6ZRS3rGOYp2gLgrlTYh+dUCn4LIrk00rleOao8/zsJ9o
 PL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700045156; x=1700649956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgdsqNPdjquiH5wJOzIliEOEDZ/i7h4XfQ78gIIxJrQ=;
 b=EjLvBKuCpiVWdiVIwRehOUZ4G3s2fQT8G22aVyDCIZW1dzp972mqOhYo1TY2gnjr6t
 0e0H3MUCA+eTYt+af4HUtGw3WbXggSNkAPsuk4AnloKVb7ZvvE9TTGWMIoV5+xKrUkd4
 P8mXxXdlAzaZ9Quc+WjIpceh9luLWnPb/VFId15pNUouU6WUroBkD+8DeJMlpVN32ugS
 xi+crZsM6NP/BDsEhmeDw0CcmUlpA5OHG0BEHdwSa7iIlHsiUNNhu/MsNIkMzbkSNahe
 8aqNW1h8ENBN8uUXpLcL2kzI/6OoLN/zAMX3k69DBLF4yZOfafn1Est5Bo3LSrDSUIwk
 tvBg==
X-Gm-Message-State: AOJu0YyXT7WwE5syYY5cLAntpkBlqOtAnK5pRTSKNqpSSfcianP/Q3Cc
 KRp5laJRdaKJUNVVnlb/dO4+qAjbGomeZTcTL7o=
X-Google-Smtp-Source: AGHT+IFCy4mMFmZSL4+rSmIb9MC22mGht15DcpJne4PmaOdKsundlgA93loEaHRW+uGAz0NfS94iNMKIYf08Cg+i9Ic=
X-Received: by 2002:aa7:d648:0:b0:53e:bb41:7506 with SMTP id
 v8-20020aa7d648000000b0053ebb417506mr10067138edr.33.1700045155414; Wed, 15
 Nov 2023 02:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20231113161031.138304-1-o451686892@gmail.com>
 <d852fadd-9217-4718-a750-fb82dc586bd3@gmx.de>
In-Reply-To: <d852fadd-9217-4718-a750-fb82dc586bd3@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 15 Nov 2023 18:45:44 +0800
Message-ID: <CAHk0HosNEF54SWwsYPkr78fsAQn2U3GP96x_9dzs8VL2yto1JQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] efi_loader: Fix UEFI variable error handling
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, Nov 15, 2023 at 6:15=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 11/13/23 17:10, Weizhao Ouyang wrote:
> > Try to catch error the earlier way.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >   lib/efi_loader/efi_var_file.c | 4 +++-
> >   lib/efi_loader/efi_variable.c | 2 --
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_fil=
e.c
> > index 62e071bd83..fe1c462f17 100644
> > --- a/lib/efi_loader/efi_var_file.c
> > +++ b/lib/efi_loader/efi_var_file.c
> > @@ -192,8 +192,10 @@ efi_status_t efi_var_restore(struct efi_var_file *=
buf, bool safe)
> >               ret =3D efi_var_mem_ins(var->name, &var->guid, var->attr,
> >                                     var->length, data, 0, NULL,
> >                                     var->time);
> > -             if (ret !=3D EFI_SUCCESS)
> > +             if (ret !=3D EFI_SUCCESS) {
> >                       log_err("Failed to set EFI variable %ls\n", var->=
name);
> > +                     return ret;
>
> This change implies that if a failure occurs, initialization of the EFI
> sub-system fails and you will not be able to boot via EFI.
>
> Such a failure will occur if ubootefi.var contains more variables than
> fit into the memory buffer.
>
> Please, describe why you want to disable U-Boot's EFI sub-system in this
> case.

Hi Heinrich,

In my case, if a variable wants to persist as a non-volatile variable to
ubootefi.var, we should keep the same behavior as runtime variable does.
Otherwise the ubootefi.var cannot be trusted.

BR,
Weizhao

>
> > +             }
> >       }
> >       return EFI_SUCCESS;
> >   }
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variabl=
e.c
> > index be95ed44e6..2b2ca8c090 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -350,8 +350,6 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
> >
> >       if (var_type =3D=3D EFI_AUTH_VAR_PK)
> >               ret =3D efi_init_secure_state();
> > -     else
> > -             ret =3D EFI_SUCCESS;
>
> This change is ok.
>
> Best regards
>
> Heinrich
>
> >
> >       /*
> >        * Write non-volatile EFI variables to file
>
