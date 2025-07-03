Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA3EC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 08:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F86B8091A;
	Thu,  3 Jul 2025 10:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dsMuwgBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E31181FEE; Thu,  3 Jul 2025 10:42:10 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0344880194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 10:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so5318438276.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751532127; x=1752136927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6pdqG/QblyWqt7A2pyEzYsY7aTrS2tnW/YB5mMWEnkA=;
 b=dsMuwgBXNQKdFLormK58bhoWlL1bUyUj0DZ1y2HBoYYdU30gP5ea1cQ9vH9vjcvRmf
 M3u6LPjx7Hqo722TYuChV5CEA5T/NdLk9lNm+eAA9+WXl5r2nPg1d0/A9Y+99M7skWNf
 f0Jf0k4M2MyR0+ik5hjL/PbEY4LhU01j5oS60P2Gj7nBrvhUvKGGw5dAkF6ls4ONYuUc
 I1lju0it9+Q00PWE8bJA+4RSkLzRorqHsd5DBeTuHjxXt3t6zT2QyAkQUpyUDalT+6KU
 fxSRUV0hQFWKZLiRem6j28cts2k8lEXYkm2X9Dxnw+V+J9h61WWvpGzEgTZXuEFaSAkh
 CxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532127; x=1752136927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6pdqG/QblyWqt7A2pyEzYsY7aTrS2tnW/YB5mMWEnkA=;
 b=jzBwCiSctU/mXoaYOkQc15SKEtNDroJwcl0mimMn7o62PjoT5ZVpvs/uxWW3Dm2q0r
 t7v3M2amChGRw/TepwxAU0V0V07loX1ItamG+a/RS/j7jAdVXF8EN09mvk7IXmT1DoNY
 /cp5qStnfelJqhNyS4JPpnoqj8aH/BYPdLt9tUSTMX9/uiYgNW+lDgx11AgGCKmTwBj1
 5eCKYoo46YKsNz4O+IJbpp8PtKaCc7dDW6fQkNOvTzTjKaxVHTmWu8ehd0qi6MA1U9Wo
 koVNg9ucgJuQl1tDzlysbIF59qMYIs572+7OuncbUrzqFa7+iwdfhJsph2uH8CPzL2cJ
 Gdpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfRdKeMGLpG/9wZvPMXV4pKWerQcQopSJ8eaAwFyRYY+U1pADwMYtPhvwocQ093w+dmwdLt9Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzsX91hlAF+5z6eTKxdGn70zBaAzlRJiSW40FIZO3zXxFw69LQi
 ib87QEjdRehZxyzEQ34rZuxr7uBRZwKkzLuVUkpZ/TyEuaD8aXfo+0KXeLnAZP1+/Gx7//UOUcI
 Ys4XKhMHIxZQMqsP6NQxmcdjOgahQOSW1B3lr749umg==
X-Gm-Gg: ASbGncsa4H4roN518NJaPu8arUO6o9GCofEJKI/SDm96552unOI+HuqzmaS1BqBT7KG
 hy/nN1CR43zTp2pTHWu5xBmoE3GvbuM5ybnDRx0IM7H6TKWfmApFNbUpwTmLEseUfYKyegLMnGo
 eOPCXC09JNEnLIdcEgRvtvLGdjSAHjZdMp48QvJnv4hjJj
X-Google-Smtp-Source: AGHT+IEsz6albGbKT4nWsP64CPvMmFGTiaZ/pwpBZO+tpuVfOAeNQxRAc8fnX6dPe9NWYS7I+4wDzWIk92QxTbey4qo=
X-Received: by 2002:a05:690c:48c6:b0:70c:a5c2:ceed with SMTP id
 00721157ae682-716590e59ccmr38776037b3.25.1751532126843; Thu, 03 Jul 2025
 01:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-2-paulliu@debian.org>
 <1e2e7d6d-2704-467a-b2a0-58a99600378f@gmx.de>
In-Reply-To: <1e2e7d6d-2704-467a-b2a0-58a99600378f@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Jul 2025 11:41:30 +0300
X-Gm-Features: Ac12FXyGWH-sJDfaDrViXBhR-H6n_JFVsKf8VKbsobz1eXUiovcbXEY5Ey9J5nM
Message-ID: <CAC_iWjKmQpzD-DbDRTs1UbZoQheqFNpLEoWCR6m1iEZwHfyuLg@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Thu, 3 Jul 2025 at 10:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 03.07.25 08:28, Ying-Chun Liu (PaulLiu) wrote:
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
> > the address of EFI_SYSTEM_TABLE.
> >
> > This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
> > The implementation ensures support for hardware-assisted debugging and
> > provides a standardized mechanism for debuggers to discover the EFI
> > system table.
> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > V2: add Kconfig options to turn on/off this feature.
> > V3: make efi_initialize_system_table_pointer() do the job as described.
> > V4: use efi_alloc_aligned_pages() for system_table_pointer.
> > V5: move the code into a separate module.
> > V6: Use macros to replace size_4MB
> > V7: Fix the code based on the review. Update license field.
> > V8: Fix pointer casting that causes qemu_arm_defconfig failed. Modify KConfig
> >      so that more defconfigs enabled by default.
> > ---

[...]

> > +
> > +     if (!systab_pointer) {
> > +             log_err("Installing EFI system table pointer failed\n");
> > +             return EFI_OUT_OF_RESOURCES;
> > +     }
> > +
> > +     memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
>
> systab_pointer->crc32 = 0;
>
> would have been an alternative. Maybe Ilias wants to change that when
> merging.
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks Heinrich. I'll have a look at the patches shortly and queue
them. I'll change the line above on my PR

/Ilias
>
> > +
> > +     systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
> > +     systab_pointer->efi_system_table_base = (uintptr_t)&systab;
> > +     systab_pointer->crc32 = crc32(0,
> > +                                   (const unsigned char *)systab_pointer,
> > +                                   sizeof(struct efi_system_table_pointer));
> > +
> > +     return EFI_SUCCESS;
> > +}
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index 48f91da5df7..78c5059256a 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -278,6 +278,13 @@ efi_status_t efi_init_obj_list(void)
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >
> > +     /* Initialize system table pointer */
> > +     if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> > +             ret = efi_initialize_system_table_pointer();
> > +             if (ret != EFI_SUCCESS)
> > +                     goto out;
> > +     }
> > +
> >       if (IS_ENABLED(CONFIG_EFI_ECPT)) {
> >               ret = efi_ecpt_register();
> >               if (ret != EFI_SUCCESS)
>
