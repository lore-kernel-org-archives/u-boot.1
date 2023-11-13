Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E77FC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 05:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB2B86B54;
	Mon, 13 Nov 2023 06:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X2KYn3Uw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC0C86BAC; Mon, 13 Nov 2023 06:47:48 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3BC786B2E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 06:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso5991749a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699854466; x=1700459266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYeN/97DQxFphPBuyx3dQhZ2nbfkMv5eHMUj7xPBOks=;
 b=X2KYn3UwbE+TOmFyTiCOtAvS1ePNPW5XrjiWnzvDhvMqlGKjrpNjoRWFyUouYFeYZK
 BlsUdgn+I4rB/CLRM6CynIr5JWGAyr7tQziv7F/a5UHhefpCwNmq7bE/LBB58y6HV+Vk
 W8AJlhJYN9szuOcBHwr6I1uiiIqfMo93s0a2S6DZkVPGESHIAlmitAlVb5UczyVFgLg4
 rZYaJEv6F288zPx9TGIXS9vqCwFvCdJRqnASAy9mFcdfiOR1SlcTfxHvniV9u46G7SS3
 PaH5v3VVmxCDfQe4XIKBiQZjtRqQrKzthlQBaSA60hRdO/YLMaBykbVrUWNCyuPTn0Cy
 MP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699854466; x=1700459266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYeN/97DQxFphPBuyx3dQhZ2nbfkMv5eHMUj7xPBOks=;
 b=FcErjlIfx7a+moGEnRE5LTklP23J3P6p8uT9GIy1BYjTfI5bKXOlLU2nqvxTol04Yr
 IvQwUiVyhlSlod/mdjLeXe5qa3fAZ5Gxr4K+i/oZfEeUd0uAF/9R9z9fCLhKuMDJ+KA+
 54VbA4eBE9D3U2kZZJL7OU9oH/GEXwnXho+cor48pfvGVsZJ4xicK8kZjhJMa+wMb/xO
 4e3PI624zcFhW9oK9op8GaSOxIqRVBccZH1GMcE08pJWMJub649UEdVaOTx66z/MCtj3
 kv6cIgmw55qygDFUOIDsGiMeC/kPxShG9eq7TVj+2/7bnXy/GYYEBBqIaeu7QZXiSgrp
 qTwg==
X-Gm-Message-State: AOJu0YzWpq5wWGfYW4UwxX9ceYTU9ZAC+bQEkIo/AmghFpYoj4Rq4pQO
 PS+Xq0yUjMC4e1bdQDrrRm92z5Stg4VYtXSdLOU=
X-Google-Smtp-Source: AGHT+IFi0O0hMAz4z/vLRg2zBnsOF9+l26CdHwccWyrK/801hbyZiOHuX3l4ThO81RH+KcrgNwBrXeKmKHMpD1DN9yw=
X-Received: by 2002:aa7:d60b:0:b0:53e:6239:a04a with SMTP id
 c11-20020aa7d60b000000b0053e6239a04amr3780389edr.24.1699854465808; Sun, 12
 Nov 2023 21:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20231109125541.10845-1-o451686892@gmail.com>
 <4d5b922a-b633-4892-9f36-78935c553bef@gmx.de>
 <CAC_iWjJHRtuy3M2o61+tkZ+cMPHrizrQQrx9-r_3LCzJgQBjUg@mail.gmail.com>
 <67A55014-91EE-4C04-A228-52C5790DC910@gmx.de>
In-Reply-To: <67A55014-91EE-4C04-A228-52C5790DC910@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 13 Nov 2023 13:47:34 +0800
Message-ID: <CAHk0HosMaYVTfSwf42Lpzr1d0uKJw+odMJqQ9PyXFhTLyO1E_A@mail.gmail.com>
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

On Fri, Nov 10, 2023 at 9:12=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
>
>
> Am 10. November 2023 11:04:24 MEZ schrieb Ilias Apalodimas <ilias.apalodi=
mas@linaro.org>:
> >Hi Heinrich, Weizhao
> >
> >On Thu, 9 Nov 2023 at 15:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >>
> >> On 11/9/23 04:55, Weizhao Ouyang wrote:
> >> > Correct some UEFI variable error handing code paths.
> >> >
> >> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> >> > ---
> >> >   lib/efi_loader/efi_var_file.c | 1 +
> >> >   lib/efi_loader/efi_variable.c | 8 ++++----
> >> >   2 files changed, 5 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_=
file.c
> >> > index 62e071bd83..dbb9b1f3fc 100644
> >> > --- a/lib/efi_loader/efi_var_file.c
> >> > +++ b/lib/efi_loader/efi_var_file.c
> >> > @@ -236,6 +236,7 @@ efi_status_t efi_var_from_file(void)
> >> >               log_err("Invalid EFI variables file\n");
> >> >   error:
> >> >       free(buf);
> >> > +     return ret;
> >>
> >> Hello Weizhao,
> >>
> >> thank you for looking into the error handling.
> >>
> >> U-Boot's UEFI variables can either be stored in file ubootefi.var in t=
he
> >> ESP or in the RPMB (Replay Protected Memory Block) partition of the
> >> eMMC. The suggested changes are about handling of errors when reading =
or
> >> writing the file ubootefi.var. Security relevant variables (PK, KEK, d=
b,
> >> dbx) are never read from file.
> >>
> >> On first boot a file ubootefi.var will not exist. It has to be created
> >> by U-Boot. If efi_var_from_file() would return an error if the file do=
es
> >> not exist or is corrupted, we would never be able to boot such a syste=
m.
> >> This is why deliberately we return EFI_SUCCESS here. What is missing i=
n
> >> the code is a comment explaining the design decision.
> >
> >Yes, that's correct. The function description tries to explain that
> >but is a bit vague.
> >
> >>
> >> >   #endif
> >> >       return EFI_SUCCESS;
> >> >   }
> >> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_vari=
able.c
> >> > index be95ed44e6..13966297c6 100644
> >> > --- a/lib/efi_loader/efi_variable.c
> >> > +++ b/lib/efi_loader/efi_variable.c
> >> > @@ -350,17 +350,17 @@ efi_status_t efi_set_variable_int(const u16 *v=
ariable_name,
> >> >
> >> >       if (var_type =3D=3D EFI_AUTH_VAR_PK)
> >> >               ret =3D efi_init_secure_state();
> >> > -     else
> >> > -             ret =3D EFI_SUCCESS;
> >>
> >> The two lines are unreachable code and should be removed.
> >>
> >> > +     if (ret !=3D EFI_SUCCESS)
> >> > +             return ret;
> >>
> >> These new lines should only be reached if var_type =3D=3D EFI_AUTH_VAR=
_PK.
> >>
> >
> >Yea agree here
> >
> >> I am not sure what Would be the right error handling if
> >> efi_init_secure_state() fails:
> >>
> >> * Do we have to set PK to the old value?
> >
> >What do you mean by old value?
>
> We are in SetVariable() and set, changed, or deleted PK in memory. But th=
is has lead to some inconsistency. Should the prior state be restored?

Shall we restore the variable "SecureBoot"?

>
> Regards
>
> Heinrich
>
> >
> >> * Should we still persist PK to ubootefi.var?
> >
> >I would argue that we don't really care about what happens in this
> >case. Writing authenticated variables on a file is only supported if
> >preseeding is disabled and it *never* gets restored. We basically
> >allow that code to test EFI secure boot by writing PK, KEK, DB on the
> >fly, but once we reboot those variables are gone.
> >If preseeding is enabled we don't write that at all. We return
> >EFI_WRITE_PROTECTED.  We could do that regardless.  But since we have
> >those tests, the memory backend should still be allowed to write
> >those.
> >
> >>
> >> However we decide we should describe our decisions in a code comment.
> >
> >I think the logic here should be
> >1. If variables are preseeded and restoring any authenticated
> >variables fails, the EFI subsystem should refuse to start (which it
> >already does)
> >2. If preseeding is not configured we can continue as best effort and
> >try to recover the board and rewrite variables. We don't trust
> >variables stored in a file and we should keep it that way
> >
> >>
> >> >
> >> >       /*
> >> >        * Write non-volatile EFI variables to file
> >> >        * TODO: check if a value change has occured to avoid superflu=
ous writes
> >> >        */
> >> >       if (attributes & EFI_VARIABLE_NON_VOLATILE)
> >> > -             efi_var_to_file();
> >> > +             ret =3D efi_var_to_file();
> >>
> >> The discussion here should focus on the treatment of errors in the
> >> file-system.
> >>
> >> The following error cases come to my mind:
> >>
> >> * ESP partition is missing
> >> * ESP FAT file system is corrupted
> >> * There is no space on the ESP.
> >> * The medium (e.g. SD card) is in write only mode
> >>
> >> The current code gives priority to enable booting in all adverse
> >> situations. Do you think this is a bad choice?
> >>
> >> @Ilias: Please, chime in.
> >
> >I think we should continue doing that *unless* preseeding is enabled.
> >If we preseed authenticated variables and the restoration of the
> >switching of the secure boot mode fails we must stop the EFI
> >subsystem.
> >The first function that gets called is efi_init_variables().
> >commit 77bb14758dcb1 explains some of the logic in that file but in shor=
t
> >- We load variables from a file first, excluding authenticated ones
> >- We load preseeded variables. That step allows you to load PK, KEK,
> >db etc that are stored as part of the u-boot binary.  We assume that
> >in a sane design a chain of trust *will* authenticate u-boot prior to
> >loading, so we 'trust' those variables.  If this fails which includes
> >setting the secure state we correctly stop the EFI subsystem
> >- efi_var_restore() is checking for duplicates. So a non-authenticated
> >variable set by the file load won't be overwritten by built-in ones.
> >This allows users to override built-in variables (apart from auth ones
> >obviously)

nit: currently if efi_var_restore() fails to set the EFI variable, it
will still return EFI_SUCCESS.

BR,
Weizhao

> >
> >Cheers
> >/Ilias
> >
> >
> >
> >
> >
> >
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >> >
> >> > -     return EFI_SUCCESS;
> >> > +     return ret;
> >> >   }
> >> >
> >> >   efi_status_t efi_query_variable_info_int(u32 attributes,
> >>
