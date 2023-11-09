Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2591C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 15:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C26871FB;
	Thu,  9 Nov 2023 16:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lPcrC/Of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA338719B; Thu,  9 Nov 2023 16:10:11 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0986C86F73
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 16:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso1522471a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 07:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699542607; x=1700147407; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlnL8rVjbBj/AetlG8zcnG5Ahw8w2/wayCfQ52RDve0=;
 b=lPcrC/Of+RH9jvius8henltbJodvCf/Qjn7tL8y+1ngU4L4d3Q3hcqsWJw+Tv28NHu
 VpkyUDUovKGdan+TxcLqUde72zIUYfL/9sD2dGOZzxO+9SeQW73n07fQk0VwV7R56il7
 /+pPiw9dcDrgKk2B691+oewBmGLt5hHAAsTkBIkG7QQi3mtzlsQX74JKbKcQXHKDs2ly
 Cy4csnbpP8x1Qj6rya9YhbRlYeD//OjyFsp0zTnPuYmMfFqtc4n1MSt1Ni9SnsnDv8y4
 HePzE8SxAksrlLDX6T+KtVN4vmAdblq3m09bmmVgRcqcHi/KiSU7IQ3QHixR5WUpZszV
 7EFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699542607; x=1700147407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlnL8rVjbBj/AetlG8zcnG5Ahw8w2/wayCfQ52RDve0=;
 b=TePJMP0nEroJecUftA35FYSDbIlBxBPUa3nywqvTxRcjgBpGq3TlNoyS+VgPst7Ah9
 1Eg2vYOI6uMjjTU10JrqO/JCEsHSLdfJ+qpvsTrJpHvCB7TsXmYhEkPyiH3OKyK1KO5F
 QFRkX3yGlIbUyc6ie/bmgq1NiTwmRzJN0vGrGeb2Guy0mNe7Gkx3XaMihg4PyZUmeJC1
 qamGY6AIuTrzllW1xtJiiYvNwrYFUgbXH9x8NLsmDGcPE1sS13FQJmsYYiMHjpNBfxvP
 UsqheQIS0wL3LMdbbfZpBqbiSxtZx5nnZ61g8f+JTz4Yz/Ct3rhyFgsvfp4lo8vBkWVt
 cRAQ==
X-Gm-Message-State: AOJu0YzVGWgyyovsyS7F8gkuersTMWS+hdHOVJmdVZ3T3y3wBuoUvlD0
 +s8WNt1uGosCv9U0KgIA7tCqhMNKFLAOXKSU+bY=
X-Google-Smtp-Source: AGHT+IENwJafQp12ZKT7YxhI+1fdUi+pXYcQs3QeAle2tEysYgp6HbxCew9/o5O6Z7MTAywN+uFel1O6W6GrnJ2+QsU=
X-Received: by 2002:a05:6402:348e:b0:545:554c:b0e6 with SMTP id
 v14-20020a056402348e00b00545554cb0e6mr1688410edc.42.1699542607066; Thu, 09
 Nov 2023 07:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20231109125541.10845-1-o451686892@gmail.com>
 <4d5b922a-b633-4892-9f36-78935c553bef@gmx.de>
In-Reply-To: <4d5b922a-b633-4892-9f36-78935c553bef@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 9 Nov 2023 23:09:55 +0800
Message-ID: <CAHk0HovVxdaPtd9ufFYZrfpvO=uwktfY+NaSsjMWnMbjBXbW6w@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Fix UEFI variable error handling
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

On Thu, Nov 9, 2023 at 9:57=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>
> On 11/9/23 04:55, Weizhao Ouyang wrote:
> > Correct some UEFI variable error handing code paths.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >   lib/efi_loader/efi_var_file.c | 1 +
> >   lib/efi_loader/efi_variable.c | 8 ++++----
> >   2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_fil=
e.c
> > index 62e071bd83..dbb9b1f3fc 100644
> > --- a/lib/efi_loader/efi_var_file.c
> > +++ b/lib/efi_loader/efi_var_file.c
> > @@ -236,6 +236,7 @@ efi_status_t efi_var_from_file(void)
> >               log_err("Invalid EFI variables file\n");
> >   error:
> >       free(buf);
> > +     return ret;
>
> Hello Weizhao,
>
> thank you for looking into the error handling.
>
> U-Boot's UEFI variables can either be stored in file ubootefi.var in the
> ESP or in the RPMB (Replay Protected Memory Block) partition of the
> eMMC. The suggested changes are about handling of errors when reading or
> writing the file ubootefi.var. Security relevant variables (PK, KEK, db,
> dbx) are never read from file.
>

Hi Heinrich,

Yes, my intention was to check for errors related to non-volatile
variables.

> On first boot a file ubootefi.var will not exist. It has to be created
> by U-Boot. If efi_var_from_file() would return an error if the file does
> not exist or is corrupted, we would never be able to boot such a system.
> This is why deliberately we return EFI_SUCCESS here. What is missing in
> the code is a comment explaining the design decision.

Sorry, I missed this scene. Maybe a comment is needed or we can split
the scene.

>
> >   #endif
> >       return EFI_SUCCESS;
> >   }
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variabl=
e.c
> > index be95ed44e6..13966297c6 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -350,17 +350,17 @@ efi_status_t efi_set_variable_int(const u16 *vari=
able_name,
> >
> >       if (var_type =3D=3D EFI_AUTH_VAR_PK)
> >               ret =3D efi_init_secure_state();
> > -     else
> > -             ret =3D EFI_SUCCESS;
>
> The two lines are unreachable code and should be removed.
>
> > +     if (ret !=3D EFI_SUCCESS)
> > +             return ret;
>
> These new lines should only be reached if var_type =3D=3D EFI_AUTH_VAR_PK=
.
>
> I am not sure what Would be the right error handling if
> efi_init_secure_state() fails:
>
> * Do we have to set PK to the old value?
> * Should we still persist PK to ubootefi.var?
>
> However we decide we should describe our decisions in a code comment.

IMO, efi_init_secure_state() is not just dealing with PK but also
includes Secure Boot mode transitions. So it may returns some
appropriate error when dealing with variable authentication.

>
> >
> >       /*
> >        * Write non-volatile EFI variables to file
> >        * TODO: check if a value change has occured to avoid superfluous=
 writes
> >        */
> >       if (attributes & EFI_VARIABLE_NON_VOLATILE)
> > -             efi_var_to_file();
> > +             ret =3D efi_var_to_file();
>
> The discussion here should focus on the treatment of errors in the
> file-system.
>
> The following error cases come to my mind:
>
> * ESP partition is missing
> * ESP FAT file system is corrupted
> * There is no space on the ESP.
> * The medium (e.g. SD card) is in write only mode
>
> The current code gives priority to enable booting in all adverse
> situations. Do you think this is a bad choice?

I think the ESP status (including fs corruption) is the most likely
situation to have an effect. But we should catch it earlier anyway.

BR,
Weizhao

>
> @Ilias: Please, chime in.
>
> Best regards
>
> Heinrich
>
> >
> > -     return EFI_SUCCESS;
> > +     return ret;
> >   }
> >
> >   efi_status_t efi_query_variable_info_int(u32 attributes,
>
