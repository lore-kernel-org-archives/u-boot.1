Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8CBE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 06:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C0F801EA;
	Thu, 12 Dec 2024 07:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wylknQUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4959801EB; Thu, 12 Dec 2024 07:16:09 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D5AE801DB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e3983f8ff40so127481276.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 22:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733984166; x=1734588966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m1ipZ16jhEJy96td6xKmdN6ehsP27RVTjaHW2LEZNqg=;
 b=wylknQUocSpGQOMUf6j3WZ9KDLrAokX752aPVnmqRjTKT7R7wGuDeujdMz6Nn0N5jW
 JT5C17Rp+x3gfFy7Y8plmzvLxPAaG0vizWM5qLjClMBNK1x8Ca+GD3m7L2v/th+FG3WV
 6rlAw6/y2z99Xg8LiYOz8+PbjiNnMv20BoL5sAT3FYkpp6uSjYLjveHtKuU8hZ8584Pk
 AaFviboqqgHRdvk8/Q7a34qNxl/XpslLVdZRzpHj9vOfusdTGZlG/37I31V5IPAs828B
 0mMZ7APqSwE6/ebQiyqP90NNHtcLCoFublr+AtOE0NA/AF/GUErIcSOFrESn5sSiWgvW
 RPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733984166; x=1734588966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m1ipZ16jhEJy96td6xKmdN6ehsP27RVTjaHW2LEZNqg=;
 b=MQWtYDPPIgowKxK89Y+sYmSMyGqasxIbHOh5IjjvT4wXYxUWw2StQVzu3/XlPY/t7c
 rhibQNnRHVy5kAXTC4kLzw0tmc+5d+Cfyg7auYREvj9ynKq4s20o6OzAa03L0RX5sU/1
 Ium4J3yxQQmxawKhkF2l+72c2/PGV3Ql7XcdqGqKj5ladiihU9Vh0UfY9Qa3v43ux45y
 bZDl2CdlCIQUy2uoSt3VSbCToHWXW6cHAQSm3blPOHexTrM+hpjiyasWTQnrWvdAaGM1
 hac9BgrUn31QbHzSDWd2914a4h8sotV1LU6HC1lQJPUltKUv6lt3r7BwT3EUN2q5T+Hu
 Ianw==
X-Gm-Message-State: AOJu0YzX0VD2V3FJPaIrwBJp4KJTlWKxD3JhGVpSDqj2Sybakwni55lN
 Jh297UYQ0KAmXA0k01giKmKCiKqTmXUdQUx0vKQUZ/WclId7bAifNn0DJdKOxN/j2Rqw7nhLjgD
 ACbCc8YFB+eT2tZq1JMb/oHAWfOb9BiThA6pmnA==
X-Gm-Gg: ASbGncsX+Sr2DO1IisCozEZXs6Xp5H1VchmFlrziY9mNqIGDTDoELXxE0D3m9da+4I2
 aE3Ak+hhfuFnp7er636MwsJZYwbfC18fBjd05/g==
X-Google-Smtp-Source: AGHT+IEvnkY4u+C1vpAcS1JiA+GjGEqMKnCGbIo8bsvG0+87xJXqF7MhkLNJDVrvENvYR06ptO6NRj6cfazbP/ylPVk=
X-Received: by 2002:a05:6902:e01:b0:e39:80c5:e81f with SMTP id
 3f1490d57ef6-e3da1eee2a1mr1486745276.35.1733984166324; Wed, 11 Dec 2024
 22:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-19-sjg@chromium.org>
 <CAC_iWj+warnOCWhpp9H4-AUc70Ft-6jRM9tRcZ3yVTKJ1_88FA@mail.gmail.com>
 <CAFLszTgT0tE=fU2W__n1Kz_yoAE32wnMcVOEb99XG4EZCzP3TQ@mail.gmail.com>
In-Reply-To: <CAFLszTgT0tE=fU2W__n1Kz_yoAE32wnMcVOEb99XG4EZCzP3TQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 08:15:30 +0200
Message-ID: <CAC_iWj+Yjg81CRvgt3hV0wFoudhD_QS4yOBRwBbJ0zq14jb-TQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] efi_loader: Don't try to add sandbox runtime code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Dec 2024 at 17:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 11 Dec 2024 at 08:19, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This cannot work since the code is not present in the emulated memory.
> > > In any case, sandbox cannot make use of the runtime code.
> > >
> > > For now, just drop it from sandbox. We can always adjust things to copy
> > > it into memory, if needed.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
> > >  1 file changed, 16 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index 0f149f99c7d..6475b94f951 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -767,16 +767,22 @@ static void add_u_boot_and_runtime(void)
> > >         runtime_mask = SZ_64K - 1;
> > >  #endif
> > >
> > > -       /*
> > > -        * Add Runtime Services. We mark surrounding boottime code as runtime as
> > > -        * well to fulfill the runtime alignment constraints but avoid padding.
> > > -        */
> > > -       runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> > > -       runtime_end = (uintptr_t)__efi_runtime_stop;
> > > -       runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> > > -       runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> > > -       efi_add_memory_map_pg(runtime_start, runtime_pages,
> > > -                             EFI_RUNTIME_SERVICES_CODE, false);
> >
> >
> > Can sandbox boot an OS? If not there's no point adding this. But if
> > you insist, I prefer
>
> No sandbox can't really boot an OS. The primary reason for this change
> is to avoid strange things appearing in the EFI memory map (and
> therefore the EFI log). I found it very confusing.
>
> > if (IS_ENABLED(CONFIG_SANDBOX)
> >     return
> >
> > at the top of the function
>
> OK

But can't we call ExitBootServices  from sandbox and test some of those?

Thanks
/Ilias
>
> >
> > Thanks
> > /Ilias
> >
> > > +       if (!IS_ENABLED(CONFIG_SANDBOX)) {
> > > +               /*
> > > +                * Add Runtime Services. We mark surrounding boottime code as
> > > +                * runtime as well to fulfill the runtime alignment constraints
> > > +                * but avoid padding.
> > > +                *
> > > +                * This is not enabled for sandbox, since we cannot map the
> > > +                * sandbox code into emulated SDRAM
> > > +                */
> > > +               runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> > > +               runtime_end = (uintptr_t)__efi_runtime_stop;
> > > +               runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> > > +               runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> > > +               efi_add_memory_map_pg(runtime_start, runtime_pages,
> > > +                                     EFI_RUNTIME_SERVICES_CODE, false);
> > > +       }
> > >  }
> > >
> > >  int efi_memory_init(void)
> > > --
> > > 2.34.1
> > >
>
> Regards,
> Simon
