Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F55ECF58ED
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76CED88B11;
	Wed, 25 Sep 2024 15:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oPH/bgkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B8588B31; Wed, 25 Sep 2024 15:41:03 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C148897F
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 15:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so4961703b3a.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727271651; x=1727876451; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T41NmNrrA4I9+5oTm2kLfLKDS+1oLV30y1HEIe1yWgI=;
 b=oPH/bgkQbibXnzC1zV3Ubs4eLvGvgHYYXE9Z/BUzZ4K2ivpLa71O3xJ6P2YzHc/NvI
 JCTvrZ6yqKqzWSR66jsEQ/H98qtBySzvG+GSjg+dyRNWRDjGO1oEH4PmI5xDgyzeTFDD
 E0o/Av8HwNqnUjwsvOk1iaCprTe7prNlMYC+yqMLIAQWeWOdXn/qGh16DKT3gkh3us/e
 ffwAKsHrkmh+824IzxgmkaOZuSNsDFbEjXcCH7XdRpd+FikKkcumdShaPTgC6oPM2+Do
 gjYwoUBdNYDngRAIbLhE2cuK7qI02HExOPA/EN5f4UJ7xtPbLS2++oJOacvxBjEBXa80
 cruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727271651; x=1727876451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T41NmNrrA4I9+5oTm2kLfLKDS+1oLV30y1HEIe1yWgI=;
 b=X8bEfNLHqeM5+SGElBdIQtU1oYdKt3lfu7+sBE7PS+IwYsc9bEO6b9UEUQSUOnLvl1
 mCCFmQL2DagSOjjmZyHV0rTB/ddHluNPzPToazYArJFefpCkcDT+iZTne9+BzRPhCNTi
 RNsdzkpGyBF5HuZ1i0jtm/bD5s8U9kINhWH0A2+F5KnQ1P9+KPmTPNNyADr+5kfJHr/u
 SGwybRQa79dzYyD3O+tV4saNGLHvzYxV7gY43Igw8GVXszHdjO+xxLqv9yzJw5xoQ9Og
 F6mXTBy9DvKmxzy6Wj7iFldVlDxw5KlkyMD2uAWZoq47S2NgUa/OnFywsmJdW//rIfOd
 0fDA==
X-Gm-Message-State: AOJu0YyOUgxyTzzqJi7KxERMPWgW2UYojFBAtw3FVOcS7GI4tUWDaMGy
 s6P13DOUNka9f/yfwNjL4O+knJF4k8XBHU8m+ft92fpD0r9RtLP/f1tDo6mGHlAgbZoDIJcjCce
 jZqC7R5gWGeSSb3yj/nqjpe3gnKuerW3ey/ddPsDoG/+VFvWzdPs=
X-Google-Smtp-Source: AGHT+IEiqqJ34NHfJjy52/xClqAluJHpKsUvnBxmLU5cAQigRtCZFgOFfXvAPe5EHCR4ZKXXDsVGnXXc1XymlyeUGrw=
X-Received: by 2002:a05:6a00:3cc2:b0:714:228d:e9f5 with SMTP id
 d2e1a72fcca58-71b0aaa5bc0mr4914614b3a.2.1727271650590; Wed, 25 Sep 2024
 06:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-10-sjg@chromium.org>
 <CAC_iWj+NMLSAmAqiDRMsSO+SWRKu=7rSFm+BkngO0kpOwRV1JQ@mail.gmail.com>
 <CAFLszTimWzK+fZToFzH4Ez+nE62GEPnHTOf2HYcTnemv_HKojQ@mail.gmail.com>
In-Reply-To: <CAFLszTimWzK+fZToFzH4Ez+nE62GEPnHTOf2HYcTnemv_HKojQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Sep 2024 16:40:14 +0300
Message-ID: <CAC_iWjJ1ggBTXkSSdaM8zktf-49MFELf3AynaMjG0XK5ZkVpSw@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] armv8: Support not having separate BSS
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Richard Henderson <richard.henderson@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Wed, 25 Sept 2024 at 15:48, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Mon, 23 Sept 2024 at 11:49, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Separate BSS is current mandatory on armv8 but this is not useful for
> > > early boot phases. Add support for the combined BSS.
> > >
> > > Use an #ifdef to avoid using CONFIG_SPL_BSS_START_ADDR which is not
> > > valid in this case.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  arch/arm/cpu/armv8/u-boot-spl.lds | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> > > index 215cedd69a8..fed69644b55 100644
> > > --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> > > +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> > > @@ -13,8 +13,10 @@
> > >
> > >  MEMORY { .sram : ORIGIN = IMAGE_TEXT_BASE,
> > >                 LENGTH = IMAGE_MAX_SIZE }
> > > +#ifdef CONFIG_SPL_SEPARATE_BSS
> > >  MEMORY { .sdram : ORIGIN = CONFIG_SPL_BSS_START_ADDR,
> > >                 LENGTH = CONFIG_SPL_BSS_MAX_SIZE }
> > > +#endif
> > >
> > >  OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
> > >  OUTPUT_ARCH(aarch64)
> > > @@ -56,12 +58,22 @@ SECTIONS
> > >         _end = .;
> > >         _image_binary_end = .;
> > >
> > > +#ifdef CONFIG_SPL_SEPARATE_BSS
> > >         .bss : {
> > >                 __bss_start = .;
> > >                 *(.bss*)
> > >                 . = ALIGN(8);
> > >                 __bss_end = .;
> > >         } >.sdram
> > > +#else
> > > +       .bss (NOLOAD) : {
> > > +               __bss_start = .;
> > > +               *(.bss*)
> > > +                . = ALIGN(8);
> > > +               __bss_end = .;
> > > +       } >.sram
> > > +#endif
> >
> > This is still going to be separate. The only difference isn't that
> > it's not loaded. If you want to combine it with a region, you got to
> > do something similar to what we have in armv7, where it overlaps with
> > rel.dyn
>
> I don't mind about combining it with a region, But SPL doesn't have
> relocation data, right?
>
> My meaning of 'separate' is as described in CONFIG_SPL_SEPARATE_BSS,
> i.e. being kept in SDRAM.

Ok, is the NOLOAD really needed? I would prefer the ifdef around .sdram/.sram

In any case
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
> >
> > Thanks
> > /Ilias
> > > +       __bss_size = __bss_end - __bss_start;
> > >
> > >         /DISCARD/ : { *(.rela*) }
> > >         /DISCARD/ : { *(.dynsym) }
> > > --
> > > 2.43.0
> > >
>
> Regards,
> Simon
