Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1D2C5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 06:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC08481FEE;
	Wed,  4 Jun 2025 08:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L78bKRL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9143682103; Wed,  4 Jun 2025 08:33:45 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1014781F0D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 08:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4a58ba6c945so4750811cf.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 23:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749018822; x=1749623622; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pdq5K5EzFVE6C/5gg3l2ajTAM8dIxNahDdUQ5nKkwaA=;
 b=L78bKRL6VTRkWbaJHAcQoGzZ5HGKIJfI4XEckNFLcYNb3FkpthgXlITcpIdNWt/izw
 /l7G1gjib0KghI9U3dx3d8x0cd6CZ4p7BiTF2YVpo4L7UV2C2lL9ggkpQXY8hCt0cGRo
 pWRXBxOXf4ewi5Dn1yuy/mndb9Gdf3ZV4i/GuM/tKPtMVNlI8NOFUkzlPfhOOw7foP+a
 N91oiWPddWWcEE+TGGo/lDccGxVBEHBtmrzREaD2HM5D7XXx7oniQIv+jch/na4baW5z
 zQVf4Rsd2q4aosMx257IYVfHj/TNL8CwkjL6ZAGrmKYoZ3U9mGBCGLP8hBGOWA2iQtN1
 mucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749018822; x=1749623622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pdq5K5EzFVE6C/5gg3l2ajTAM8dIxNahDdUQ5nKkwaA=;
 b=a5MI5MYYrmMNvFeZNKHDRnp3nxCWUBHzBzI0rWwSHIb5p7Pa/yFCIm2fmyRiZ8pXqR
 ZHvy1lU3wp48CNSzeGB5Q2Ys+KGQ77ajltyZpcfroNSud4akORqcbGZ96SOffYl4wb4W
 eCHA8p5t4Hf/YdNX8klrlWpPUtFGvLApi6W+KuJCxLV9Cz165GEk9E5r96bSyyUJ31Jt
 yTeuKgQYGd4SQmQ/eTzv2AxKTN9t9tRk4gT/XjidINzQVs9KABZrvrvAo8xtpH7mortX
 SZ4dQa30rv+mh7IvUUiPX/LENNDqqDU+LpFKAwrGgKZKgUFBcTsJKTRZZeAqg8DbP/sb
 6a3w==
X-Gm-Message-State: AOJu0YwmdXcygEm/4OZeZ05akmr+aXzB3nvRyKBN1bdWEbCqkdB9gh/L
 Cwtfu/2kYrBumS1KheRJMjFoRgG/Jz1+EZ63Ow3qG81QqQrP5tuUp8hN83VTuW19AW3bxoOWonu
 H3jUwchOW6yZkwG3vccLD/YdkCu1KDdvOtOgsoAcLHw==
X-Gm-Gg: ASbGncvt5Aw3bDdAsMX75K5R7055H+rDDBRYotDAeRncsy20Ld8wDrZvn5jT8Ngs9s2
 4rlgEOIzDIBlnRXscJjPogzwxWipPZxic2Mqcoceoz/Fx0SAMXkTE6g5CtgreQEZaeZ0ZYMgqLN
 qpyQ6CYsyB890d8qVvU9O+4JLqSa+zseqIyc6hsFnqm0NJ
X-Google-Smtp-Source: AGHT+IERAd57QfDMJf+rsmSeCw0w/kIZaK17dQmLfF3b56P/uK2KZ6wIEH7oxe13VZZzIiE7mkjipqz3WHe4ZFcTICk=
X-Received: by 2002:a05:622a:1b22:b0:4a4:41c0:b256 with SMTP id
 d75a77b69052e-4a5a5806c0amr30136201cf.11.1749018821819; Tue, 03 Jun 2025
 23:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
 <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
 <CAC_iWj+Mzskthf1dLSX6NPyzWiRGzfbcekCs_c_mT3GpFH6gTg@mail.gmail.com>
In-Reply-To: <CAC_iWj+Mzskthf1dLSX6NPyzWiRGzfbcekCs_c_mT3GpFH6gTg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 4 Jun 2025 12:03:30 +0530
X-Gm-Features: AX0GCFueFMfifxyIhw4LfFUYjkjpTk452axyTQKagTARXxi6TqVfb6Ix0EzDrHk
Message-ID: <CADg8p95CnQnj2_Wh6D05hCtZh75PDU-S-_MkSvzBdGFAgKJiug@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Tue, 3 Jun 2025 at 23:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 3 Jun 2025 at 09:44, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 30 May 2025 at 15:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 30 May 2025 at 13:17, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > > +static phys_addr_t lmb_alloc(phys_size_t size)
> > > > > +{
> > > > > +       int ret;
> > > > > +       phys_addr_t addr;
> > > > > +
> > > > > +       /* All memory regions allocated with a 2MiB alignment */
> > > > > +       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
> > > > > +       if (ret)
> > > > > +               return 0;
> > > > > +
> > > > > +       return addr;
> > > > > +}
> > > > > +
> > > >
> > > > I think we  need a better naming for these. Right now we have
> > > > lmb_alloc() here and in tests, addr_alloc() in snapdragon code.
> > > > I'd say either export them as API if you think they would be useful,
> > > > or get rid of the wrappers.
> > >
> > > I kept these functions as is to reduce the amount of change resulting
> > > from introducing the API. Also, the newly introduced API has
> > > parameters which are common across all the callers, which also was why
> > > I kept a wrapper. This is especially true in the tests, where it would
> > > be required to change the function names in a bunch of places without
> > > much benefit.
> > >
> > > >
> > > > [...]
> > > >
> > > > > +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> > > > > +{
> > > > > +       int err;
> > > > > +       phys_addr_t addr;
> > > > > +
> > > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
> > > > > +       if (err)
> > > > > +               return 0;
> > > >
> > > >
> > > > This tends to blow up in random ways. See
> > > > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
> > >
> > > Yes, I see your point. I think the calling function will have to be
> > > re-written such that the env variables get stored only when the API
> > > returns successfully. Then at least the platform will not have an env
> > > variable with some junk value.
> >
> > Thinking about this a bit, I think in these two instances, returning a
> > value of 0 might not be an issue if the DRAM memory does not start at
> > 0x0. Don't get me wrong, what you are suggesting is definitely
> > correct. I am only thinking about increasing code size on these
> > platforms if 0x0 is not a valid address, and moreover since the
> > platforms were already setting 0x0 in case of an error.
>
> what kind of code size increase are we talking about?

Let me check the actual size impact with the changes and get back to you.

> It's returning
> na int instead of a physical address so that should be close to zero?

Sorry, I do not understand what you are suggesting, but even the above
static function is returning a phys_addr_t value, which is 0 in case
of an error. And I have kept this to mimic the existing behaviour.
Thanks.

-sughosh

>
> Thanks
> /Ilias
> > If it is okay
> > to increase code size on these platforms, I will change the calling
> > function, such that the variable does not get set in case of an error.
> > Maybe Casey and Mark can comment? Thanks.
> >
> > -sughosh
> >
> > >
> > > -sughosh
> > >
> > > >
> > > > > +
> > > > > +       return addr;
> > > > > +}
> > > > > +
> > > > > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > > > > +                                 phys_addr_t max_addr, u32 flags)
> > > > > +{
> > > > > +       int err;
> > > > > +       phys_addr_t addr;
> > > > > +
> > > > > +       addr = max_addr;
> > > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > > > > +       if (err)
> > > > > +               return 0;
> > > > > +
> > > > > +       return addr;
> > > > > +}
> > > > > +
> > > > >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> > > > >
> > > > >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > > Cheers
> > > > /Ilias
