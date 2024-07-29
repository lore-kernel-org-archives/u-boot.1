Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83782C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AD6887D6;
	Mon, 29 Jul 2024 10:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BPA+Kj6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9B388747; Mon, 29 Jul 2024 10:00:26 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB03288056
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so135293a12.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722240024; x=1722844824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z4dtmTXO/LGJM6D599e6iexnj83QyJtbAa1qzp5d30A=;
 b=BPA+Kj6RjqJoUKIAqJgeJjFlrCxW5qX2EkCdVt6agLKhfdEHhEkujZZmoQLcxIhaUC
 BbKB4RMeY905lw3Krglz7RO7PI/WvU6l3REGF82hePW822z0rkq3YzoQfNeIjk9nQsL4
 Id6iiVdZwsYnP/28wxCjnohQqKUHapYIqo8lRQWnFFNoNVQiXJfzGhPC+GTWDr+YeY4m
 ND+x4jYgNK9NnuGeT6DH8RmU5F1XsMcTZ3bN0OPBbdCsNSEkPz+/lrbzjDtA4uwGi4lj
 EdOeyB55WTl6wwVGVNT+00ZKQdO/ZgQsVUkdl+VCZt5FFSNkfLyKmn3+k6FHnnvRmrNe
 /+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722240024; x=1722844824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4dtmTXO/LGJM6D599e6iexnj83QyJtbAa1qzp5d30A=;
 b=tBTMwWLZuzAsuWMJByL7H6GDuOGaTVIs6z2Zp5qIu9i76bK6XrdvKC70TkT8H2i/5R
 3+z6CEcwp8B9oZOwXusRXv+OOm3Xas4c4ONl0Zzk/FyLCzLIlXvPtblVeDEefoiYzsOe
 CzOz/uFV0towPvHl3wdlJYy0dfLX0ANfnmezM/yh5N02wRNC0o6R5p9Is5DFwLYYXYhj
 6mNZzQqxg2IU4kcY3n+89uiROYch9OsVO97ieyJnETpD6Ew88MdaFY4DPPzUtx942RsH
 GsmKYLpvFvOY9VsxmhbJQwTqwk9H99Y3SpcDt5OeCjZY6f+pJsLLnnxUEyHZ4KnHVe75
 jR1g==
X-Gm-Message-State: AOJu0Yy1ay7j4XuIwxsbEv2eA6LHmWZ4mc8nl0UbMuckTsUZqzWXLYnn
 H2z3iLmUtUYHdNH3JiEh1JbCaHK4h+VetTrYbGagsmiQud7LbqgoB9SvXHOjAKh+SOeMgcxSzLc
 nOTHus6bGF6M8twTWSu/xycVFXFxRKB93H/oeeA==
X-Google-Smtp-Source: AGHT+IEn+cEuarewcLDYTtAPcIW6qV70R/g+mJxcjlUJmEVusS0tZVbUUudKhxfZAlZxC5K7eiCGTO3fBLVlqWztha4=
X-Received: by 2002:a50:9b58:0:b0:5af:2e08:d362 with SMTP id
 4fb4d7f45d1cf-5b0224cef1dmr4089405a12.23.1722240024048; Mon, 29 Jul 2024
 01:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-18-sughosh.ganu@linaro.org>
 <CAFLszTgrxZBkOgcrq0cwtrGs7UdFsqxH9srg0rBmxLfummg9qw@mail.gmail.com>
In-Reply-To: <CAFLszTgrxZBkOgcrq0cwtrGs7UdFsqxH9srg0rBmxLfummg9qw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 13:30:13 +0530
Message-ID: <CADg8p94zgPCfEFMCKRaZ9PkD5kn7Sb2vfU4m73KGnoWmqjrfeg@mail.gmail.com>
Subject: Re: [PATCH 17/40] lmb: introduce a function to add memory to the lmb
 memory map
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Introduce a function lmb_add_memory() to add available memory to the
> > LMB memory map. Call this function during board init once the LMB data
> > structures have been initialised.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >  include/lmb.h | 12 ++++++++++++
> >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index a308796d58..77e2a23c0d 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -40,6 +40,18 @@ struct lmb_region {
> >  void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
> >  void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> >                                 void *fdt_blob);
> > +
> > +/**
> > + * lmb_add_memory() - Add memory range for LMB allocations
> > + *
> > + * Add the entire available memory range to the pool of memory that
> > + * can be used by the LMB module for allocations.
> > + *
> > + * Return: None
> > + *
> > + */
> > +void lmb_add_memory(void);
> > +
> >  long lmb_add(phys_addr_t base, phys_size_t size);
> >  long lmb_reserve(phys_addr_t base, phys_size_t size);
> >  /**
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 88352e9a25..db0874371a 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -239,6 +239,46 @@ void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
> >         lmb_reserve_common(fdt_blob);
> >  }
> >
> > +/**
> > + * lmb_add_memory() - Add memory range for LMB allocations
> > + *
> > + * Add the entire available memory range to the pool of memory that
> > + * can be used by the LMB module for allocations.
> > + *
> > + * This can be overridden for specific boards/architectures.
>
> Why is this needed?

There is a definition of this function for the freescale layerscape
platforms, and the e820 platform.

>  I'm really not a fan of weak functions...it often
> means we should have a proper API for it.

Is there some coding style guideline which prohibits using weak
function definitions? I see it being used all across U-Boot. Moreover,
I don't think that this particular case asks for adding an API for
this one function. That would just add to the size without much
benefit.

-sughosh

>
> > + *
> > + * Return: None
> > + *
> > + */
> > +__weak void lmb_add_memory(void)
> > +{
> > +       int i;
> > +       phys_size_t size;
> > +       phys_addr_t rgn_top;
> > +       u64 ram_top = gd->ram_top;
> > +       struct bd_info *bd = gd->bd;
> > +
> > +       /* Assume a 4GB ram_top if not defined */
> > +       if (!ram_top)
> > +               ram_top = 0x100000000ULL;
> > +
> > +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > +               size = bd->bi_dram[i].size;
> > +               if (size) {
> > +                       if (bd->bi_dram[i].start > ram_top)
> > +                               continue;
> > +
> > +                       rgn_top = bd->bi_dram[i].start +
> > +                               bd->bi_dram[i].size;
> > +
> > +                       if (rgn_top > ram_top)
> > +                               size -= rgn_top - ram_top;
> > +
> > +                       lmb_add(bd->bi_dram[i].start, size);
> > +               }
> > +       }
> > +}
> > +
> >  /* Initialize the struct, add memory and call arch/board reserve functions */
> >  void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> >                                 void *fdt_blob)
> > @@ -728,5 +768,7 @@ int lmb_mem_regions_init(void)
> >                 return -1;
> >         }
> >
> > +       lmb_add_memory();
> > +
> >         return 0;
> >  }
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
