Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238CED41156
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 10:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A18580325;
	Thu, 15 Jan 2026 11:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="erLwW4AO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8AC803F5; Thu, 15 Jan 2026 11:02:13 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F11180077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 11:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-652fdd043f9so1350957a12.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 02:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768471329; x=1769076129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FPye/GokQBPu62YiDsIgVRmufQWQtUWcYp9VZr/tL3A=;
 b=erLwW4AOVxy9TZEZP/NahDBwtBEtr0LEIz0TNjaugAd0hxwSiTdySJLpGCp0TPYM/j
 4UphZWX5ZFr2PhyfD99RvzJkkVWbeQ/DFJ2XMqMBc69GV/A38dJcbh4DBp0nMGWM/qeK
 ywqbOAnyNxqDyffIgDqPtJur7p5ZgbOWyu2iW9BpiEk1imV3Ui0hPLWNOLbaEoy1bxRK
 9bjs1n40W2Gx5Uni/CcT7wTsOwDJZB6PFtBn973SvHZFqk7PXcDACxrReuQ4VVXwp4I+
 FIYXSTPnjrcfE1oYhJOzXWu536mpvNKvz1sYG6b4/dq2sd2V6K/l6vz49o9fWaY3+5LF
 fOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768471329; x=1769076129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPye/GokQBPu62YiDsIgVRmufQWQtUWcYp9VZr/tL3A=;
 b=Eiknnn0iMEDOkmJQrrTEN47b580NOw0nqkq0sdgayvnIJRPg7s2gFGZte7xdbACips
 EAn23Va4FsE59LcpV7x0dcLMf/Q6RdAMVzuUaNYcMVq7+eTUpUj9/ZtlzXNwRcHTX+MV
 vMnL2MtvkGQ/9Utis1CgYeQHkR54/8OgWyToWeLXzBRdwMiM6KvY5fhmRt4bYnckxR9n
 RzCslXHQLhXM/cJXMZ3yUP4Uscl59eWzm0lJwfCFZ/N6P62C17L8yGHL1PNq0o1a8as1
 7hdc2M57dMFMnEDOMyO6gHAbpLdg//KtfDxXUmVwninfAluD/DtXkv0mBeSImvCn98NI
 6nuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpIpY9uptPAXECJY090aHlqClpGFh0AMaNp0BrORWKrEn9tCGtwfV521smKguqT9KOcBKfJVg=@lists.denx.de
X-Gm-Message-State: AOJu0YxgbL8Yjdh3y5SPBQZw/p1BpVlsA4YoNtnQvocURebZl7l4MYN7
 uPyCLztzvTZOs4glgoCpRboqcI+nkH4L7YUL4Ea+mX0AHw8SiMvAUmd5SquyHFVineIByp7SJEv
 PyUJkIgiiZUGVeIarpYYFhkipVigdbXM=
X-Gm-Gg: AY/fxX4YWfjB/uhN1cK8HTLIdRmGKR21epxCtOXhc5PdWMFR5/8J3z40I78Xj56SjKZ
 OKFqBaBIvYCTcUEWCKN8dJaqUg34xs4oauLuZvKo8TPEq8oBeg7e+I+9wBRV3dKRqDHCOYFDbiJ
 Fq6MCQuTsmheHHN9zBl1+Fb2O1lqzMsJ38EKm/7yFWxBgAyIUZ6OJzyW0YXwAx5ZO/EEdYcFSl6
 j4hurNU6xSfKdC1bo996pv4zY+h07yQCwDvyg692haEDJjp2Vr4N8gjnvtIIobszEx6FnMd1nOm
 uEbMcVz5b+fU2+l+h8TQaVINE6w/OC6h4HfnRhq9DFnj4owPW4nf+VHp4MXjj/48MSBm5u2lE8Z
 AnSLsYhwo6D7oWhzX7jS1+371fBhKQZEfGFzG
X-Received: by 2002:a05:6402:268a:b0:64b:6e20:c92e with SMTP id
 4fb4d7f45d1cf-653ee15f0ebmr4154338a12.10.1768471328451; Thu, 15 Jan 2026
 02:02:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
 <CAC_iWj+_VfEAE3NRr9QxJHtR0oq3JdqrO3vj583TxBDetH6QkA@mail.gmail.com>
In-Reply-To: <CAC_iWj+_VfEAE3NRr9QxJHtR0oq3JdqrO3vj583TxBDetH6QkA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 15 Jan 2026 10:01:55 +0000
X-Gm-Features: AZwV_QjJGYd8x3flDYrqQPlBL3kpdDDNHHnu_W5CbvbcZsAKI444j1xclTtbN-k
Message-ID: <CALeDE9NbsotYjk7RdUmu4OPO71_cN9_TuoFwUmJD8Zuff49XnQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com, 
 Shantur Rathore <i@shantur.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Thu, 15 Jan 2026 at 08:05, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Michal
>
> Thanks for taking the time.
>
> [...]
>
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index be670a8e7c25..feab212b245b 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >                 ret = EFI_SUCCESS;
> >
> >         /*
> > -        * Write non-volatile EFI variables to file
> > +        * Write non-volatile EFI variables to file or SPI Flash
> >          * TODO: check if a value change has occured to avoid superfluous writes
> >          */
> >         if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> > -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> > +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> >                 efi_var_write();
> >  #else
> >                 return EFI_NOT_READY;
> > @@ -599,7 +599,7 @@ efi_status_t efi_init_variables(void)
> >         if (ret != EFI_SUCCESS)
> >                 return ret;
> >
> > -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> > +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
>
> So I think this is might to come back and bite us in the future.
> The name of the file is a bit misleading, but efi_variable.c is
> supposed to handle the variables with a file backed storage and
> efi_variable_tee.c is handling the variables when the storage is
> isolated in the secure world.
> The problem is that each case defines the boottime and runtime
> services. The functions that are common across cases live in
> efi_var_common.c. That files defines the boottime and runtime calls,
> by calling the *_int() variants.
>
> The file backed and SPI flash storage seem to have a lot in common.
> e.g they both use the memory backend to expose the vairables the the
> OS, query the available storage etc. But I am not they will end up
> being 100% identical. If they do this approach is ok. But ifthey don't
> it's better to expand the efi_var_sf.c you added and add code for
> efi_variables_boot_exit_notify(), and any *_int() functions that are
> different.
>
> Heinrich any opinions? I'll need to think through the SPI case
> inclduing runtime support before taking this in

Do we also need to consider the case where the SPI flash remains owned
by the firmware/secure world, and the case where it's handed over to
the OS?
