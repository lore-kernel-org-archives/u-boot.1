Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C13C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0113F88BD2;
	Wed, 25 Sep 2024 14:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TzpeH2Tr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6373188BCF; Wed, 25 Sep 2024 14:48:32 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F6488B79
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c3603292abso60874566d6.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268505; x=1727873305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TWGriK42eOW6lEKtc5yMfBnvHqZTd5xPn+Jrnbw/GU0=;
 b=TzpeH2TrQrgNFpX69pk3ptPLcsTz/Xs7bNvRHKRa9j7rycS2+nz8xgZ+905+2nK897
 8VSAv0l+7u3i0iMJohnx1e9nokjmxbHRPfq56/fUP4z58NZ5ctptvye2C8U7nob2oMPD
 BUvQyzLQgHiDVj8H7Dpf/yUEr94hEbbtkgBOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268505; x=1727873305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TWGriK42eOW6lEKtc5yMfBnvHqZTd5xPn+Jrnbw/GU0=;
 b=N61TGtHwirOYJKy1v14adVaFxuXVXW2iWxYUhf6TIPn1bKFY5t8B65JzGmx/EkRoDs
 orwLL/NEy44wN2FuWYPbhBySSm+7KZ3j+u2XKq6lW488HcXok8C+FcW9JcF4pH6UCHz1
 R1HOi6dclBzHw9ajmn6Mh2Q7VxML2RpNbNXEUwmA5hbIEqY7FgTAqUrk4eKb6X6MAFMk
 Uj9rgMFAq+hU00Sn9G8Pu9pWnE7p/9CfG2ilHT5oxFrB2YlUoUSC7pY2CMr1PDIm893i
 Mi1eWLWSTxfK/tCTvHIuTLu7u2j76RsBmJCJLuYTgCEyTh2VTBq7+0OlFUGB6h1keVYs
 9k7Q==
X-Gm-Message-State: AOJu0Yy1vUIZFn3OHXTYA3r3dlP6/V00j7VzKF9oP5u/mSfNHggI7cEL
 XGDWqqJkr/puV4n8kF2WU/jb26cvWPRw8FQe7NypixmbsrzbmXc8oSsoxOkWOzJ5duu8HVChzf5
 j53tONRG20t9FPJxkuJN6vZVc8eP3H7+WcbWi7e3HOZ+su/IqsQ==
X-Google-Smtp-Source: AGHT+IHPdvxcxsOWYKgMh1p0l0Rw73WCvmel+m3eSRBTNynGPnZxPul1UyWR0IRmf+r2I6m/PfTiiqlwaA7v+xrKKFo=
X-Received: by 2002:a05:6214:3b89:b0:6c5:b9a7:f3c5 with SMTP id
 6a1803df08f44-6cb1dd84719mr42115076d6.14.1727268504979; Wed, 25 Sep 2024
 05:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-10-sjg@chromium.org>
 <CAC_iWj+NMLSAmAqiDRMsSO+SWRKu=7rSFm+BkngO0kpOwRV1JQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+NMLSAmAqiDRMsSO+SWRKu=7rSFm+BkngO0kpOwRV1JQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:48:11 +0200
Message-ID: <CAFLszTimWzK+fZToFzH4Ez+nE62GEPnHTOf2HYcTnemv_HKojQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] armv8: Support not having separate BSS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Mon, 23 Sept 2024 at 11:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
> >
> > Separate BSS is current mandatory on armv8 but this is not useful for
> > early boot phases. Add support for the combined BSS.
> >
> > Use an #ifdef to avoid using CONFIG_SPL_BSS_START_ADDR which is not
> > valid in this case.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/cpu/armv8/u-boot-spl.lds | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> > index 215cedd69a8..fed69644b55 100644
> > --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> > +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> > @@ -13,8 +13,10 @@
> >
> >  MEMORY { .sram : ORIGIN = IMAGE_TEXT_BASE,
> >                 LENGTH = IMAGE_MAX_SIZE }
> > +#ifdef CONFIG_SPL_SEPARATE_BSS
> >  MEMORY { .sdram : ORIGIN = CONFIG_SPL_BSS_START_ADDR,
> >                 LENGTH = CONFIG_SPL_BSS_MAX_SIZE }
> > +#endif
> >
> >  OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
> >  OUTPUT_ARCH(aarch64)
> > @@ -56,12 +58,22 @@ SECTIONS
> >         _end = .;
> >         _image_binary_end = .;
> >
> > +#ifdef CONFIG_SPL_SEPARATE_BSS
> >         .bss : {
> >                 __bss_start = .;
> >                 *(.bss*)
> >                 . = ALIGN(8);
> >                 __bss_end = .;
> >         } >.sdram
> > +#else
> > +       .bss (NOLOAD) : {
> > +               __bss_start = .;
> > +               *(.bss*)
> > +                . = ALIGN(8);
> > +               __bss_end = .;
> > +       } >.sram
> > +#endif
>
> This is still going to be separate. The only difference isn't that
> it's not loaded. If you want to combine it with a region, you got to
> do something similar to what we have in armv7, where it overlaps with
> rel.dyn

I don't mind about combining it with a region, But SPL doesn't have
relocation data, right?

My meaning of 'separate' is as described in CONFIG_SPL_SEPARATE_BSS,
i.e. being kept in SDRAM.

>
> Thanks
> /Ilias
> > +       __bss_size = __bss_end - __bss_start;
> >
> >         /DISCARD/ : { *(.rela*) }
> >         /DISCARD/ : { *(.dynsym) }
> > --
> > 2.43.0
> >

Regards,
Simon
