Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B3BC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 21:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8CA8714E;
	Mon, 13 Nov 2023 22:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qnosHgTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE438711A; Mon, 13 Nov 2023 22:49:01 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C637C870BD
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 22:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c5210a1515so68931151fa.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699912138; x=1700516938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RxQqv35ePfgGgxobgMiPjvAQ1HI7wkpzzpeVJ3RB/6I=;
 b=qnosHgTgxjzCjR+PeRlmUhkPPT7lsmknsmCU8rR76KOQvpzmkxCD0skF+xInFvVZ5y
 QcVIjhQ94eqnK7H7QnKiqQMCbNNvz6GIBlKlyoT+LomGumT+gyjPxqkcOp3bMpuFg4Nk
 zCZmw5osL2Jn3IcGIIR2VNjpz43OWFBZcEUerOu5SBncaHmxkhGyzve7Mf8HZ6R57s36
 H4fqqtenHAnfpxi2VlffLbxfUg8d5UTtuSudmfg9/sMM2lKdGgvWjaARUgNis2gqcTkp
 bpgTrE5aS57DDBdaqknRxxAH7VZ3Lp1eEagSQ6xdCJDsXdsQXyrSGQCFYC6ZFF01T9Uy
 XGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699912138; x=1700516938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RxQqv35ePfgGgxobgMiPjvAQ1HI7wkpzzpeVJ3RB/6I=;
 b=TCfmOdCBV+ZSZRMKvr/ial2+YqoOArrB0tsJ4s+C8StG/uxvFdvkZx342Z3daOLSsP
 FIHAJ5/jYyTRoTx3JunSTHVhUdJEDPJtOwZmUOq/RCK+d86eieGgFYh4MYHGxGBbvpw4
 a2vjBtN1mopRxM4VUF25t0as9i887ZKWQTfFNlqtIQwYZ79DKJ4W4pV4fej5tzeOvemJ
 y+rt+NBTKz9dHQGtlW1L7duVXERy5QH+Qz0VL+GVUcDz2VN5ILYRHpyWkHmEkFBP14qg
 sfu1V6mj1Fx5sf78lkJV5SM5x3c9BFvTPUufcmm48rI+a/XTQmNs7h90EWpNcgkoSWQl
 5UFg==
X-Gm-Message-State: AOJu0YxaBA84U6aCA4dSR0vfLvftXQPoRyuPgUxKYygFePWqVV6RgPyI
 At27FzSpRu2iNNFrZti0md50BTYL+XOINr2j7+eM5w==
X-Google-Smtp-Source: AGHT+IFDTBei1kGCas/GpRx227VGN4IqXEHQe1K6vgt2meCFQulygY2NKOoGUYfKYCij6aHavJuqs9Q2IrZC+SBR93Y=
X-Received: by 2002:a05:651c:20c:b0:2c6:f711:cea1 with SMTP id
 y12-20020a05651c020c00b002c6f711cea1mr463323ljn.39.1699912137989; Mon, 13 Nov
 2023 13:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20231109125541.10845-1-o451686892@gmail.com>
 <4d5b922a-b633-4892-9f36-78935c553bef@gmx.de>
 <CAC_iWjJHRtuy3M2o61+tkZ+cMPHrizrQQrx9-r_3LCzJgQBjUg@mail.gmail.com>
 <67A55014-91EE-4C04-A228-52C5790DC910@gmx.de>
In-Reply-To: <67A55014-91EE-4C04-A228-52C5790DC910@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 13 Nov 2023 16:48:22 -0500
Message-ID: <CAC_iWjJd_88duw4tTYurmfXDKou5wFzE7vmiZe-0R7M5rQ2Uvw@mail.gmail.com>
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

On Fri, 10 Nov 2023 at 15:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 10. November 2023 11:04:24 MEZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> >Hi Heinrich, Weizhao
> >
> >On Thu, 9 Nov 2023 at 15:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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
> >> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
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
> >> U-Boot's UEFI variables can either be stored in file ubootefi.var in the
> >> ESP or in the RPMB (Replay Protected Memory Block) partition of the
> >> eMMC. The suggested changes are about handling of errors when reading or
> >> writing the file ubootefi.var. Security relevant variables (PK, KEK, db,
> >> dbx) are never read from file.
> >>
> >> On first boot a file ubootefi.var will not exist. It has to be created
> >> by U-Boot. If efi_var_from_file() would return an error if the file does
> >> not exist or is corrupted, we would never be able to boot such a system.
> >> This is why deliberately we return EFI_SUCCESS here. What is missing in
> >> the code is a comment explaining the design decision.
> >
> >Yes, that's correct. The function description tries to explain that
> >but is a bit vague.
> >
> >>
> >> >   #endif
> >> >       return EFI_SUCCESS;
> >> >   }
> >> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> >> > index be95ed44e6..13966297c6 100644
> >> > --- a/lib/efi_loader/efi_variable.c
> >> > +++ b/lib/efi_loader/efi_variable.c
> >> > @@ -350,17 +350,17 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >> >
> >> >       if (var_type == EFI_AUTH_VAR_PK)
> >> >               ret = efi_init_secure_state();
> >> > -     else
> >> > -             ret = EFI_SUCCESS;
> >>
> >> The two lines are unreachable code and should be removed.
> >>
> >> > +     if (ret != EFI_SUCCESS)
> >> > +             return ret;
> >>
> >> These new lines should only be reached if var_type == EFI_AUTH_VAR_PK.
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
> We are in SetVariable() and set, changed, or deleted PK in memory. But this has lead to some inconsistency. Should the prior state be restored?

Ah right.  As I said this code is basically there to allow us to run
self-tests. If setting the security state fails, those tests should
fail whether we revert or not. So I think we don't care. We could add
a comment explaining the situation with the secure boot state
transition when auth variables are not preseseded

Thanks
/Ilias


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
> >> >        * TODO: check if a value change has occured to avoid superfluous writes
> >> >        */
> >> >       if (attributes & EFI_VARIABLE_NON_VOLATILE)
> >> > -             efi_var_to_file();
> >> > +             ret = efi_var_to_file();
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
> >commit 77bb14758dcb1 explains some of the logic in that file but in short
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
