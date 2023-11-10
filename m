Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8B3C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 10:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD1F877B1;
	Fri, 10 Nov 2023 11:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PBFvpcYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B43877CA; Fri, 10 Nov 2023 11:05:03 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E1B88779A
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 11:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507c5249d55so2610566e87.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699610700; x=1700215500; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rvth0ZKm/Jot1819nipJOpjpEzOXLm5bULZMA7GCZp8=;
 b=PBFvpcYCsHtoAf/w7KTRQ46rws4Gl6/2PCwFDJXgWMZz8GepOKrR3QgLQvpwt32IZY
 LpST1Z6M3cNWXbaFDnmHdvH0HJU+nRoy5uJhRvJMNcMp0ygeEdtjUj8Ox5X+4JyOd3cY
 qMabiuGOJuxVnhmxdgska1UQZky3zKEySAYenjWi4BNVue+1av8XMb4ZGbkZcJp2MuHF
 c5MgIcr2j5fmuNcg78j4RG0Z/39v39UN4Gr79NnUtL0TSnxZkP0rfzO74AlAiGb15h51
 1GqjhjdBWWAtQUSp87k0Cvt57LvrqavgBcR5ZrtoYob6LqNUXSOv8kt1x+YwMRWJvv9c
 ucSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699610700; x=1700215500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rvth0ZKm/Jot1819nipJOpjpEzOXLm5bULZMA7GCZp8=;
 b=kOS+fh++6cf9fVp+BxRjVrGx+b4IQ7IdNOsbUcvdLgwyGBaeA+IT6jwP3P5Y1IwsYi
 XtGZMxMHITguu2ij0REJb5Re2wnpcquA6sRrMtJcYrYlpRyTEgs88g+xKuD6DbWmR4Lx
 B5NFsAYcQqR93RHUgtR9ldKqklQRCuV4sSRVLVM7noNSZLqY5rRpwz9Hk9u23gCth7DM
 vnQqB4WfNqIxmC2H4DrHkrJZqQRcdfb+Xji6JynQ1IONP7xj2XzwB7aW6NKj8GvJ5OED
 s+56qoAidHw5QuEX13MBuk5N0C9q/imL+6dGFEui7aR4XW/xBD6YqKTyz/aGh891dHIl
 cjfQ==
X-Gm-Message-State: AOJu0YxG7iW9rR8oHnldsnz5nF1jURHoU26YEXfll26QFhd6+b2Yym0G
 3ZdH5iiWtgosfwx+gVIBfs19KK46d4PvtQxOBNz3BQ==
X-Google-Smtp-Source: AGHT+IGhA2IHyMyBpEFP0LJBTk6HjUYt1FbO46291C6peHr/5wn6lw+StBf9nFwz8ez44V60Algt92Eii9r7cODfeV8=
X-Received: by 2002:a2e:851a:0:b0:2c5:2191:3f35 with SMTP id
 j26-20020a2e851a000000b002c521913f35mr6817625lji.2.1699610700417; Fri, 10 Nov
 2023 02:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20231109125541.10845-1-o451686892@gmail.com>
 <4d5b922a-b633-4892-9f36-78935c553bef@gmx.de>
In-Reply-To: <4d5b922a-b633-4892-9f36-78935c553bef@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Nov 2023 12:04:24 +0200
Message-ID: <CAC_iWjJHRtuy3M2o61+tkZ+cMPHrizrQQrx9-r_3LCzJgQBjUg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Fix UEFI variable error handling
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich, Weizhao

On Thu, 9 Nov 2023 at 15:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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
> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
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
> On first boot a file ubootefi.var will not exist. It has to be created
> by U-Boot. If efi_var_from_file() would return an error if the file does
> not exist or is corrupted, we would never be able to boot such a system.
> This is why deliberately we return EFI_SUCCESS here. What is missing in
> the code is a comment explaining the design decision.

Yes, that's correct. The function description tries to explain that
but is a bit vague.

>
> >   #endif
> >       return EFI_SUCCESS;
> >   }
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index be95ed44e6..13966297c6 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -350,17 +350,17 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >
> >       if (var_type == EFI_AUTH_VAR_PK)
> >               ret = efi_init_secure_state();
> > -     else
> > -             ret = EFI_SUCCESS;
>
> The two lines are unreachable code and should be removed.
>
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
>
> These new lines should only be reached if var_type == EFI_AUTH_VAR_PK.
>

Yea agree here

> I am not sure what Would be the right error handling if
> efi_init_secure_state() fails:
>
> * Do we have to set PK to the old value?

What do you mean by old value?

> * Should we still persist PK to ubootefi.var?

I would argue that we don't really care about what happens in this
case. Writing authenticated variables on a file is only supported if
preseeding is disabled and it *never* gets restored. We basically
allow that code to test EFI secure boot by writing PK, KEK, DB on the
fly, but once we reboot those variables are gone.
If preseeding is enabled we don't write that at all. We return
EFI_WRITE_PROTECTED.  We could do that regardless.  But since we have
those tests, the memory backend should still be allowed to write
those.

>
> However we decide we should describe our decisions in a code comment.

I think the logic here should be
1. If variables are preseeded and restoring any authenticated
variables fails, the EFI subsystem should refuse to start (which it
already does)
2. If preseeding is not configured we can continue as best effort and
try to recover the board and rewrite variables. We don't trust
variables stored in a file and we should keep it that way

>
> >
> >       /*
> >        * Write non-volatile EFI variables to file
> >        * TODO: check if a value change has occured to avoid superfluous writes
> >        */
> >       if (attributes & EFI_VARIABLE_NON_VOLATILE)
> > -             efi_var_to_file();
> > +             ret = efi_var_to_file();
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
>
> @Ilias: Please, chime in.

I think we should continue doing that *unless* preseeding is enabled.
If we preseed authenticated variables and the restoration of the
switching of the secure boot mode fails we must stop the EFI
subsystem.
The first function that gets called is efi_init_variables().
commit 77bb14758dcb1 explains some of the logic in that file but in short
- We load variables from a file first, excluding authenticated ones
- We load preseeded variables. That step allows you to load PK, KEK,
db etc that are stored as part of the u-boot binary.  We assume that
in a sane design a chain of trust *will* authenticate u-boot prior to
loading, so we 'trust' those variables.  If this fails which includes
setting the secure state we correctly stop the EFI subsystem
- efi_var_restore() is checking for duplicates. So a non-authenticated
variable set by the file load won't be overwritten by built-in ones.
This allows users to override built-in variables (apart from auth ones
obviously)

Cheers
/Ilias






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
