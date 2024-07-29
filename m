Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2975BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D22CE88905;
	Mon, 29 Jul 2024 17:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DKWQY9Yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A416988896; Mon, 29 Jul 2024 17:29:12 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA6E888EE
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b7b28442f9so38623786d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266949; x=1722871749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o3aE40oc3918+uMN9dACTtVYcM0aaq4TGPRsJpCWmrs=;
 b=DKWQY9YcFd7+G2L+/XIEvbYpldT63piJs7MFIZWdYEBOxjaVONmkmRcze+qJ48w1XU
 dDG2echdSiJJuqIBEpnn/obCan62qsDoSdy+mGW/mae4lyNs+i5MjlbY0dDxC6YsaI7v
 VAthf1m2Z5Qo4P09Vx+ozfVEFU1qTF8Qlu9S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266949; x=1722871749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3aE40oc3918+uMN9dACTtVYcM0aaq4TGPRsJpCWmrs=;
 b=bDx4nguTSh724FzGipLlB8mfMYKcnyrJqdvxmd/JOjbsxIaA5NnZ5bRoW32aAdX6dX
 fl6/JixJlpWbvYVH+51zu9BaF68lkL0tfjxjcbb7VYY2OFtsUhO1jaQ0caH0Ajaf5mRw
 jab0GsrL53oCso0d+zKkqvli1VGtGsNYJp9CW7ehKs6K8AIVmoKO7XQKEFOBK8b2m/v7
 QNBM3ycjhE0vT+1Ub6u2uB4ZbeCfb469BxGQi6jockSR8J5e3siHEBpSr6HPtPswgvqU
 btixsYyv0vnoSje/lkyLnmB9qOp5M/wEYX/IfGlrNdeJhtSV4JMm0Bkq6YV4pER5ez2x
 h9VQ==
X-Gm-Message-State: AOJu0YzGGEufrAUdWeWYxRCfBkYLPve8905WGD5mu1ixBEfZoAnyrNhw
 yG5/UBvPyWFiZAlmQShJiK3e8Ixc93VAzi0gMoPr3iHBjNb8pCN9eKm53WHCIdtTqrGhyJ+ncQ9
 +4A5pEx6z590L00b+wHoHwOjyf6nGw4jBiKFP
X-Google-Smtp-Source: AGHT+IHcX9MChU/z5emUnPczTjAIk17ozeuOjg07SR8kJCaUzqzDxnflPIoX+QJ66BtUBIZe02rMrGJ0vDmUgo2V498=
X-Received: by 2002:a05:6214:1c05:b0:6b5:4bc:6eed with SMTP id
 6a1803df08f44-6bb55ada349mr119493846d6.44.1722266949289; Mon, 29 Jul 2024
 08:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-18-sughosh.ganu@linaro.org>
 <CAFLszTgrxZBkOgcrq0cwtrGs7UdFsqxH9srg0rBmxLfummg9qw@mail.gmail.com>
 <CADg8p94zgPCfEFMCKRaZ9PkD5kn7Sb2vfU4m73KGnoWmqjrfeg@mail.gmail.com>
In-Reply-To: <CADg8p94zgPCfEFMCKRaZ9PkD5kn7Sb2vfU4m73KGnoWmqjrfeg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:58 -0600
Message-ID: <CAFLszTik0CpoLoKt=C+zdw9F6d3FzktUB4AXoY-RV15AnbyThA@mail.gmail.com>
Subject: Re: [PATCH 17/40] lmb: introduce a function to add memory to the lmb
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 02:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Introduce a function lmb_add_memory() to add available memory to the
> > > LMB memory map. Call this function during board init once the LMB data
> > > structures have been initialised.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: None
> > >
> > >  include/lmb.h | 12 ++++++++++++
> > >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 54 insertions(+)
> > >
> > > diff --git a/include/lmb.h b/include/lmb.h
> > > index a308796d58..77e2a23c0d 100644
> > > --- a/include/lmb.h
> > > +++ b/include/lmb.h
> > > @@ -40,6 +40,18 @@ struct lmb_region {
> > >  void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
> > >  void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> > >                                 void *fdt_blob);
> > > +
> > > +/**
> > > + * lmb_add_memory() - Add memory range for LMB allocations
> > > + *
> > > + * Add the entire available memory range to the pool of memory that
> > > + * can be used by the LMB module for allocations.
> > > + *
> > > + * Return: None
> > > + *
> > > + */
> > > +void lmb_add_memory(void);
> > > +
> > >  long lmb_add(phys_addr_t base, phys_size_t size);
> > >  long lmb_reserve(phys_addr_t base, phys_size_t size);
> > >  /**
> > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > index 88352e9a25..db0874371a 100644
> > > --- a/lib/lmb.c
> > > +++ b/lib/lmb.c
> > > @@ -239,6 +239,46 @@ void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
> > >         lmb_reserve_common(fdt_blob);
> > >  }
> > >
> > > +/**
> > > + * lmb_add_memory() - Add memory range for LMB allocations
> > > + *
> > > + * Add the entire available memory range to the pool of memory that
> > > + * can be used by the LMB module for allocations.
> > > + *
> > > + * This can be overridden for specific boards/architectures.
> >
> > Why is this needed?
>
> There is a definition of this function for the freescale layerscape
> platforms, and the e820 platform.

Can you please point me to that? I cannot see it. I am looking for
lmb_add_memory().

>
> >  I'm really not a fan of weak functions...it often
> > means we should have a proper API for it.
>
> Is there some coding style guideline which prohibits using weak
> function definitions? I see it being used all across U-Boot.

In fact, before driver model, almost everything was a weak function.

I am not a fan of them in general...it can be a useful get-of-jail
card, but we should not base things on it. It is hard to figure out
what is actually being called...sometimes I have to resort to
disassembly to work it out. Normally there is a better way.

Events were created to reduce the need for weak functions. The
overhead is small, so long as events are already enabled.

> Moreover,
> I don't think that this particular case asks for adding an API for
> this one function. That would just add to the size without much
> benefit.

That's what everyone says :-) Good design is very important,
particularly the project is under rapid development.

Regards,
Simon
