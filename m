Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAAAC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 06:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC2987823;
	Tue, 26 Dec 2023 07:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JFyp7rlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E5687847; Tue, 26 Dec 2023 07:21:44 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F088771E
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a26ea1e88b7so136666466b.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 22:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703571702; x=1704176502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YhZ/LjN6VUv2UxmoulbBcT2Rx8yIl05i9wBzA7BDGi0=;
 b=JFyp7rlJqiuRhzjBBdkoY/MMjg3m5ejNGNGrvEMs4ls9MoWUFZXO5WDDB+dYfAcSo7
 uHFYGm+cXWliOrok+FEeDSkCkYrmYPfDlshekfSEeYLfHiWbyPx0qUNP/ajb5yHSVBr6
 AqRwvQFgrtuAE1sLi2fD7LOb92n+7UjbvKR/B6UO96zN15516ZUV++Obg4EuSKqibTfs
 uXqmCgIcxuDKg2FE+JrLDCAcA2Hw6CHYH5ISke6mxLBcSjhuX4jDFIupVNSxrPnpO7ib
 zYghvd/TIX8FGJvIwbS1kNYX97YHgkgUchFYpmbQDcUmyNMbuDSJ2/KB/ZSlOtKEAdjb
 xLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703571702; x=1704176502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhZ/LjN6VUv2UxmoulbBcT2Rx8yIl05i9wBzA7BDGi0=;
 b=tXI18KNo74kLu9yvP0TLcN5CKSB+cfa8qbZpMxnxPETo8gPZwVuZNc2uc0B7XodyzN
 6vt0qbEJPq5hVP9NWxYGYKKz07MMnb//0hM/IwZj15GVcu0xlrbE29x8O5ANsbx5qCLe
 J1JtNkJqoHNIItRem5FCjIyYcB3cwBDzKigXmnziLMhA7YV4K1a9O3gUqtWFPmYDSbJW
 Y+/wVVSJVUI4yAghRBl4J8ki/QKjLVNZuw7VAaD8j48MOUuN+aPc7IGBtJq3v+lpvGOj
 n+bVbXQ0w9ojw9MdafgohDyg71oWxk8c48pgyeSUNdNp2+gKhOnUtVRiw7KLyYxT5Wdq
 f0Gw==
X-Gm-Message-State: AOJu0Yw12pysrw+7zOWfsKFG0L+1ahx1MAsZv3Io1ihaROtkJiuXinsQ
 aMcvQVbRnsKDmEnfNrwgxtIQPsPgD6dB19OcX9CqXy6ueklQog==
X-Google-Smtp-Source: AGHT+IFifWRyv1wGXzVCl7kjVnuN/91wOl8qWTsRTea5mLaGZ49JGnqXUMhIBqP2pMUW0fbLtofpRYIEGETDKMKyDMA=
X-Received: by 2002:a17:906:284:b0:a26:f7f6:6dcf with SMTP id
 4-20020a170906028400b00a26f7f66dcfmr680030ejf.72.1703571701603; Mon, 25 Dec
 2023 22:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-9-maxim.uvarov@linaro.org>
 <7bbe53d3-3ef7-b9de-472e-cb9c25c6cc06@gmail.com>
In-Reply-To: <7bbe53d3-3ef7-b9de-472e-cb9c25c6cc06@gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 26 Dec 2023 12:21:29 +0600
Message-ID: <CAD8XO3YN4e4zqNKJJACPjrDAP_d-Ddn_+aQ_ifyQ13LnU4oJBw@mail.gmail.com>
Subject: Re: [PATHv2 8/9] omap3: use device specific naming for mem_init
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, sjg@chromium.org, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, bharat.gooty@broadcom.com, 
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 26 Dec 2023 at 04:49, Sean Anderson <seanga2@gmail.com> wrote:

> On 12/25/23 10:39, Maxim Uvarov wrote:
> > Use device specific naming for functions so as to not overlap
> > with common function names.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > ---
> >   arch/arm/include/asm/arch-omap3/mem.h | 2 +-
> >   arch/arm/mach-omap2/omap3/board.c     | 2 +-
> >   arch/arm/mach-omap2/omap3/emif4.c     | 4 ++--
> >   arch/arm/mach-omap2/omap3/sdrc.c      | 6 +++---
> >   4 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-omap3/mem.h
> b/arch/arm/include/asm/arch-omap3/mem.h
> > index 569779c55e..fce3568eca 100644
> > --- a/arch/arm/include/asm/arch-omap3/mem.h
> > +++ b/arch/arm/include/asm/arch-omap3/mem.h
> > @@ -475,7 +475,7 @@ enum {
> >   #ifndef __ASSEMBLY__
> >
> >   /* Function prototypes */
> > -void mem_init(void);
> > +void omap3_mem_init(void);
> >
> >   u32 is_mem_sdr(void);
> >   u32 mem_ok(u32 cs);
> > diff --git a/arch/arm/mach-omap2/omap3/board.c
> b/arch/arm/mach-omap2/omap3/board.c
> > index 8b70251457..c76a95dd5d 100644
> > --- a/arch/arm/mach-omap2/omap3/board.c
> > +++ b/arch/arm/mach-omap2/omap3/board.c
> > @@ -216,7 +216,7 @@ void s_init(void)
> >   void board_init_f(ulong dummy)
> >   {
> >       early_system_init();
> > -     mem_init();
> > +     omap3_mem_init();
> >       /*
> >       * Save the boot parameters passed from romcode.
> >       * We cannot delay the saving further than this,
> > diff --git a/arch/arm/mach-omap2/omap3/emif4.c
> b/arch/arm/mach-omap2/omap3/emif4.c
> > index 7e5a281922..4fbfb387ab 100644
> > --- a/arch/arm/mach-omap2/omap3/emif4.c
> > +++ b/arch/arm/mach-omap2/omap3/emif4.c
> > @@ -159,10 +159,10 @@ int dram_init_banksize(void)
> >   }
> >
> >   /*
> > - * mem_init() -
> > + * omap3_mem_init() -
> >    *  - Initialize memory subsystem
> >    */
> > -void mem_init(void)
> > +void omap3_mem_init(void)
> >   {
> >       do_emif4_init();
> >   }
> > diff --git a/arch/arm/mach-omap2/omap3/sdrc.c
> b/arch/arm/mach-omap2/omap3/sdrc.c
> > index 5d43e7c9cf..f2a0769b9d 100644
> > --- a/arch/arm/mach-omap2/omap3/sdrc.c
> > +++ b/arch/arm/mach-omap2/omap3/sdrc.c
> > @@ -4,7 +4,7 @@
> >    *
> >    * This file has been created after exctracting and consolidating
> >    * the SDRC related content from mem.c and board.c, also created
> > - * generic init function (mem_init).
> > + * generic init function (omap3_mem_init).
> >    *
> >    * Copyright (C) 2004-2010
> >    * Texas Instruments Incorporated - https://www.ti.com/
> > @@ -232,11 +232,11 @@ int dram_init_banksize(void)
> >   }
> >
> >   /*
> > - * mem_init -
> > + * map3_mem_init -
>
> nit: omap3
>
>
thanks, will add to v3.



> >    *  - Init the sdrc chip,
> >    *  - Selects CS0 and CS1,
> >    */
> > -void mem_init(void)
> > +void omap3_mem_init(void)
> >   {
> >       /* only init up first bank here */
> >       do_sdrc_init(CS0, EARLY_INIT);
>
>
