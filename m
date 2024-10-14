Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B391D1813F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E8189192;
	Mon, 14 Oct 2024 22:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eO1swzTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271678918E; Mon, 14 Oct 2024 22:21:08 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94386891A5
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a9c3a4e809so379727885a.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728937262; x=1729542062; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=spy8jmHi3mmlTewGz4yR5ILSZqEE5YviKZSUYN/BQao=;
 b=eO1swzTockaN2mBSrEuCpoENeyj2XNSWhq0zgHzZnutY0wsEr3ZfCnIEFglb8oQPGR
 saMDY+5ydwWuH4P3Jae9IMAF7hJebUFLwRzL+uqx60EN58lCq/vzcqP/MdE1nzj9PZU7
 MkKfmoDdVm98bZhEqYpY6dM5n5hBI1NU7Fe9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728937262; x=1729542062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spy8jmHi3mmlTewGz4yR5ILSZqEE5YviKZSUYN/BQao=;
 b=C24Qu9Fa8aWuIOaFBJZpVM9Hw7UG2q5qk3yECrCkiSqiSLk9Dr5JhYCEw6/m2A0k+y
 z4RFc7aQAYIv+pIHPSMzMj/oanHFHUTWDEOy19TGiXPJWmavCjeIZurVPLaImVZXqjfv
 oYZpGGRDVtZAF8RpaRUxuBFyJGR805aBBOYb60YwClJy1cevgwGeg8sXv06oVyZJRcku
 ilrBMI7XAMOtJE3aIGqsojRoFNy/wIznR06lwT9OgcpCjaMMLixZVqnFdGzW95ai4kmR
 bfNYspSunNPi1ukzUC6KwRWTwGlzegJAQ/zeCEfiqRWuzPA0732NQVpAyqLUX5QmlCBg
 7uNA==
X-Gm-Message-State: AOJu0YwSGUw65Vx9hK0A0XtT6lcZcMXLqb7vHHd5Bf1LgPYW660WTcJT
 gNaf9gPb493B2KNrlGf+qZ2J5L0YbOnTXne+SxeqwUzzR4zb04pPnF8mTx8vy7F16GXdijnnp/E
 uKYsgcx799By8jHrEybmzF0HFormB98DZgtw9
X-Google-Smtp-Source: AGHT+IH9keMOrQJHU9LsECLmAYGaml9sPadhKzrzev8R6pq4CYyJfGitM8tV3VHPg/VxJShatMb76pfBxuoyqSEg2qo=
X-Received: by 2002:a05:6214:5703:b0:6cb:f12e:90a9 with SMTP id
 6a1803df08f44-6cbf9d0c9abmr126736486d6.9.1728937262468; Mon, 14 Oct 2024
 13:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-4-sjg@chromium.org>
 <20241012013713.GH14210@bill-the-cat>
In-Reply-To: <20241012013713.GH14210@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 14:20:51 -0600
Message-ID: <CAFLszThz3uPk_qvN574GZWqQrkKrWpVvuWtyLLN4XDSqg47GvQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] am65x: Use map_to_sysmem() to convert from pointer
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, Nishanth Menon <nm@ti.com>
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

Hi Tom,

On Fri, 11 Oct 2024 at 19:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 11, 2024 at 03:40:27PM -0600, Simon Glass wrote:
>
> > The board_init_f() function for am65x is a bit confusing, since it uses
> > the variable name 'pool_addr' to hold a pointer. It then casts it to an
> > address to pass to mem_alloc_init()
> >
> > Rename the variable and use mapmem to convert to an address.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/mach-k3/am65x/am654_init.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-k3/am65x/am654_init.c b/arch/arm/mach-k3/am65x/am654_init.c
> > index a4f038029d7..ddcc1355210 100644
> > --- a/arch/arm/mach-k3/am65x/am654_init.c
> > +++ b/arch/arm/mach-k3/am65x/am654_init.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <fdt_support.h>
> >  #include <init.h>
> > +#include <mapmem.h>
> >  #include <asm/global_data.h>
> >  #include <asm/io.h>
> >  #include <spl.h>
> > @@ -165,7 +166,7 @@ void board_init_f(ulong dummy)
> >  #if defined(CONFIG_K3_LOAD_SYSFW) || defined(CONFIG_K3_AM654_DDRSS)
> >       struct udevice *dev;
> >       size_t pool_size;
> > -     void *pool_addr;
> > +     void *pool;
> >       int ret;
> >  #endif
> >       /*
> > @@ -204,14 +205,14 @@ void board_init_f(ulong dummy)
> >        * malloc pool of which we use all that's left.
> >        */
> >       pool_size = CONFIG_VAL(SYS_MALLOC_F_LEN) - gd->malloc_ptr;
> > -     pool_addr = malloc(pool_size);
> > -     if (!pool_addr)
> > +     pool = malloc(pool_size);
> > +     if (!pool)
> >               panic("ERROR: Can't allocate full malloc pool!\n");
> >
> > -     mem_malloc_init((ulong)pool_addr, (ulong)pool_size);
> > +     mem_malloc_init(map_to_sysmem(pool), (ulong)pool_size);
> >       gd->flags |= GD_FLG_FULL_MALLOC_INIT;
> >       debug("%s: initialized an early full malloc pool at 0x%08lx of 0x%lx bytes\n",
> > -           __func__, (unsigned long)pool_addr, (unsigned long)pool_size);
> > +           __func__, (unsigned long)pool, (unsigned long)pool_size);
> >       /*
> >        * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
> >        * regardless of the result of pinctrl. Do this without probing the
>
> I'm confused since I thought patch 2 removed the need for doing
> map_to_sysmem() games more widely.

Right, this patch is not actually needed. It just avoids a cast from a
pointer, which is always suspicious.

> You also forgot to CC anyone from TI
> that might have comments on if they find "pool" rather than "pool_addr"
> more or less confusing and given the recent patch from them about what's
> printed out about memory size, I would think their feedback would
> be important.

I did cc them on the first version. I don't mind adding maintainers on
follow-on patches, but don't want to spam people. I'll try adding
maintainers always, for now.

>
> --
> Tom

Regards,
Simon
