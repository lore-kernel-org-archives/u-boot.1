Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F955C54E66
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 07:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803C887D12;
	Fri, 15 Mar 2024 08:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OLlUBW9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B03887F48; Fri, 15 Mar 2024 08:04:27 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52B186F1E
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d46c44dcc0so22578151fa.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710486264; x=1711091064; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVqh98ThNc/CefY3SicFexM7I7oLfRq3K3wfOIQ46pc=;
 b=OLlUBW9DHrftOFSELKh56OCEA4mJysI/b8IXWU7gGxCJCXrWQIZggGoY1dGkeabTub
 g4Y47wBenLfzfPsSffUzHwB3ATYvAfGKMfonHSrYqvr8oJs6xeGC23E7/Dd8CFUFVSDu
 Ws8TTlx5/uFyP1Bs+4byKhxgdFqi9mqLrvZRa/x7bI/OFUx0HtH9D2ZTe5xAOUKWxTd+
 7AkN6o/YnhUCbVaK2Z5JYbfqfS1huq4iwFHZPdpE/i209N51MuXP6RslVR7G3T540U1n
 hLsQZtjWiD1FdcSovmD0rZsBQE1ad8cyaYrk2nyOUmi+8QfTR43RAXkwsD5S22t0M7fd
 FVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710486264; x=1711091064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVqh98ThNc/CefY3SicFexM7I7oLfRq3K3wfOIQ46pc=;
 b=hfbjJHPNnfHaLUG7QeVIXS7MeS8X7yOfK6goDGh++AGQ6snT3erOydI5k6jWAdjtvW
 YSUYl+mDd/sPISnPbI7FRli9T+ueFEYlXljSegnKcWVynsNdnU3yeBbLYUP32xUSVqar
 N1+GNiLZPMgORBZVmhQnyZbhx/p0+ynReiuG2P/8c850JmF8KF7DSc0tNuHXGRRjsV9z
 /14CXs3n8RJRn75fu+amjFjNkcN+4HrICFn+wja1whtdYnz9TMXPgT0Zq5yLCsK8PTmg
 9EjZaUkl8ELyVpD3Swy5/TkLKlUGXAZI9PrPDOlXXOTm82mmZijdbiKnkDS9gDrRmeMx
 +JSQ==
X-Gm-Message-State: AOJu0YwnCrYmQHrckkCcu2mnHwYUDtDsjXutl53YXdaaFZdGRWB03kTh
 yu/FIUGFBIVVDn7qXGBhZHB7jTOuCJWoLbfeCFDlTWxc66BV7YuNBgxFZG2KWTY0VU5ELSgM8Ny
 F8X7KqYj1VgLfkQEQivuIzkYrJb7jXbH5Jrz73z9sOP6rqmoC
X-Google-Smtp-Source: AGHT+IFRkdQl1ojCVR1cqp9rmI+k8FGftjfOHALguZN5ni8vGgzh9asMOWn0FOwWjC3eG7p+f5HaXXzB41neoz+J+ww=
X-Received: by 2002:a2e:9f4c:0:b0:2d2:3810:552 with SMTP id
 v12-20020a2e9f4c000000b002d238100552mr2359097ljk.53.1710486263883; Fri, 15
 Mar 2024 00:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240304061100.2386856-1-kojima.masahisa@socionext.com>
 <CAC_iWjL1P0HLv+PJ6aH+=n-PBtaq=dqYujzVA+J+_yp1x20Nkg@mail.gmail.com>
 <TYCPR01MB83750A2962738D3D4C8BFC5EE3282@TYCPR01MB8375.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB83750A2962738D3D4C8BFC5EE3282@TYCPR01MB8375.jpnprd01.prod.outlook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Mar 2024 09:03:47 +0200
Message-ID: <CAC_iWj+jpjn17yAvBDi3Q+j-YrZyeo4sXzSYJay63HY4iZSeqg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: accept append write with valid size and data
To: kojima.masahisa@socionext.com, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
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

Hi Kojima-san

On Fri, 15 Mar 2024 at 02:10, <kojima.masahisa@socionext.com> wrote:
>
> Hi Ilias,
>
> > -----Original Message-----
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Sent: Thursday, March 14, 2024 10:54 PM
> > To: Kojima, Masahisa/=E5=B0=8F=E5=B3=B6 =E9=9B=85=E4=B9=85 <kojima.masa=
hisa@socionext.com>
> > Cc: u-boot@lists.denx.de; Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Subject: Re: [PATCH] efi_loader: accept append write with valid size an=
d data
> >
> > Hi Kojima-san
> >
> > Apologies for the late reply
> >
> > On Mon, 4 Mar 2024 at 08:10, Masahisa Kojima
> > <kojima.masahisa@socionext.com> wrote:
> > >
> > > Current "variables" efi_selftest result is inconsistent
> > > between the U-Boot file storage and the tee-based StandaloneMM
> > > RPMB secure storage.
> > > U-Boot file storage implementation does not accept SetVariale
> > > call to non-existent variable with EFI_VARIABLE_APPEND_WRITE
> > > attribute and valid size and data, however it is accepted
> > > in EDK II StandaloneMM implementation.
> >
> > Yes,
> >
> > >
> > > Since UEFI specification does not clearly describe the behavior
> > > of the append write to non-existent variable, let's update
> > > the U-Boot file storage implementation to get aligned with
> > > the EDK II reference implementation.
> > >
> > > Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> > > ---
> > >  lib/efi_loader/efi_variable.c             | 13 +++++-----
> > >  lib/efi_selftest/efi_selftest_variables.c | 30
> > +++++++++++++++++++++--
> > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_varia=
ble.c
> > > index 40f7a0fb10..1693c3387b 100644
> > > --- a/lib/efi_loader/efi_variable.c
> > > +++ b/lib/efi_loader/efi_variable.c
> > > @@ -282,11 +282,8 @@ efi_status_t efi_set_variable_int(const u16
> > *variable_name,
> > >                 }
> > >                 time =3D var->time;
> > >         } else {
> > > -               if (delete || append)
> > > -                       /*
> > > -                        * Trying to delete or to update a non-existe=
nt
> > > -                        * variable.
> > > -                        */
> > > +               if (delete)
> > > +                       /* Trying to delete a non-existent variable. =
*/
> > >                         return EFI_NOT_FOUND;
> >
> > I am not sure about this tbh. The UEFI spec says
> > "When the EFI_VARIABLE_APPEND_WRITE attribute is set, then a
> > SetVariable() call with a DataSize of zero will not cause any change
> > to the variable value (the timestamp
> > associated with the variable may be updated however, even if no new
> > data value is provided;see the description
> > of the EFI_VARIABLE_AUTHENTICATION_2 descriptor below). In this case
> > the DataSize will not be zero
> > since the EFI_VARIABLE_AUTHENTICATION_2 descriptor will be populated)"
> >
> > I think this assumes the variable exists. Is there a different chapter
> > in the spec that describes the behavior?
>
> No, I could not find it.
> I'm also not sure what the UEFI spec expects.

I don't have any objections to aligning this with EDK2. But can we add
a comment about it as well?
Heinrich any preference here?

[...]

> > non-existent variable returns wrong code\n");
> > > +               efi_st_error("Variable was not deleted\n");
> > >                 return EFI_ST_FAILURE;
> >
> > This used to fail as well [0]. Does it work now?
>
> Yes. With this patch applied, both U-Boot file storage and StMM
> pass the efi selftest.

Yes, that's obviously a hack. The reason we didn't bother fixing it
back then is because stmm is not running in our CI, but I should have
added a comment on that instead of having it on email history...

Thanks
/Ilias
>
> Thanks,
> Masahisa Kojima
>
> >
> > >         }
> > >         /* Enumerate variables */
> > > --
> > > 2.34.1
> > >
> >
> > [0]
> > https://lore.kernel.org/u-boot/CAC_iWjL2G2mvQb6WNGLTxr+xj64xrYuOKr8G
> > 3-3z8Lv7yX5XSg@mail.gmail.com/
> >
> > Regards
> > /Ilias
