Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B74D5B873
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 03:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341A489177;
	Tue, 29 Oct 2024 04:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UQjq75An";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6853389182; Tue, 29 Oct 2024 04:49:16 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC7089152
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 04:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cbb6166c06so4471873a12.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730173753; x=1730778553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ID4iBrzDMDKfzEAp5ipfBeecDdEtziXlZs5DnKIQVFQ=;
 b=UQjq75An58gUXydTB9B0ZXCLkzWHfIDdLn0xB2q/sFd+j0eCy5rvSEp9sQhBAMOeXq
 XMMyxiqKqnYp7RChLbl2bH8uVet3Ci/8H0MhuRstlqCN16itJN/bDjQlP4ejke3hjT94
 uh1iSCGi/nsSSXzsUqKlmJIZCGH9W5FMe0G0O6rDKMxai9j7WAqeBXDUOyaZ3wsgFe9E
 w+MQ6vT5HCo77HysRnh+Zh5ucckaTHWt04Vo5pqPZeK4fJ1rP3anqIA1J4TROC7seupg
 S0uWZV8yckphzuiR7Ilb7cEr/IHNlRMzv2NaTWLnjAEO1U1o+SXSrzFl2QmOsUvRsoH2
 jyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730173753; x=1730778553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ID4iBrzDMDKfzEAp5ipfBeecDdEtziXlZs5DnKIQVFQ=;
 b=WbVNSKQT7WVALLUex25CinEHDCUCOezfPXVZhs+4cBNcEvA8df2SuaHc5ZCOEysdYg
 QuZw+c6CNzOwEq+t3MmAkeA+2FcQCG8ObL1MJcQzdliv3ZNobRV/xG3HGbw2E/S66W/E
 OjKe1TT6BI+f75RsUQ3ouJHpMtba7yLnC809NDDtHTYsMAm0zfk1h6iqcwjekIA1I092
 0q90KuinJDOVSunRVm5iMP7CCIXLK8EFqx67sSXCELggMxttvGDQtvI4tsNnhk/wxaWb
 UHuP3B7LgGzd03ri8ArR1127liDaar9nkE6QrnxXCCzyLoQ7A1qGcHxZ0vvUwyGiH6r5
 3KYg==
X-Gm-Message-State: AOJu0Yx2e2dmFN5fvoSwID7va9AHRojN0Tl0yEr8E9ZKKLAoPv63ATEV
 rFb/E6O8CQuEk9WTBdN7u3xAladXVA3TeXU3KYclczHSmHzr3CBuDwCjutFsRMcZyrQn4TYVKXz
 l7UCvH4mlOQMlxXxjPOu+0O7Beln+hc18tCzUOg==
X-Google-Smtp-Source: AGHT+IHGPJrPOrrLFMzWs8whzxRHQ7p4La9YrH+XT6a2mY1B6sFh/UT5V6tZGMfE9qLdApG4tsAdmMd57cXbsRwXano=
X-Received: by 2002:a17:907:7e8f:b0:a99:d782:2e2b with SMTP id
 a640c23a62f3a-a9de5f24882mr948721966b.30.1730173753131; Mon, 28 Oct 2024
 20:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-6-sughosh.ganu@linaro.org> <ZyAAJsnV4uz2Btwy@robin>
In-Reply-To: <ZyAAJsnV4uz2Btwy@robin>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 29 Oct 2024 09:19:01 +0530
Message-ID: <CADg8p94MnjnPQ4Y8_OeQYfwk9W7L8vu+J1tHPcX079D87PzFDg@mail.gmail.com>
Subject: Re: [PATCH v4 05/27] lmb: make LMB memory map persistent and global
To: Janne Grunau <janne@jannau.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, asahi@lists.linux.dev
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

On Tue, 29 Oct 2024 at 02:50, Janne Grunau <janne@jannau.net> wrote:
>
> On Mon, Aug 26, 2024 at 05:29:18PM +0530, Sughosh Ganu wrote:
> > The current LMB API's for allocating and reserving memory use a
> > per-caller based memory view. Memory allocated by a caller can then be
> > overwritten by another caller. Make these allocations and reservations
> > persistent using the alloced list data structure.
> >
> > Two alloced lists are declared -- one for the available(free) memory,
> > and one for the used memory. Once full, the list can then be extended
> > at runtime.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [sjg: Optimise the logic to add a region in lmb_add_region_flags()]
> > [sjg: Use a stack to store pointer of lmb struct when running lmb tests]
> > ---
> > Changes since V3:
> > * Fix checkpatch warnings of spaces between function name and
> >   open parantheses.
> > * s/uint64_t/u64 as suggested by checkpatch.
> > * Remove unneccessary parantheses in lmb.c as suggested by checkpatch.
> > * Fix alignment in test/cmd/bdinfo.c as suggested by checkpatch.
>
> [...]
>
> >  drivers/iommu/apple_dart.c           |   8 +-
>
> [...]
>
> > diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> > index 9327dea1e3..611ac7cd6d 100644
> > --- a/drivers/iommu/apple_dart.c
> > +++ b/drivers/iommu/apple_dart.c
> > @@ -70,7 +70,6 @@
> >
> >  struct apple_dart_priv {
> >       void *base;
> > -     struct lmb lmb;
> >       u64 *l1, *l2;
> >       int bypass, shift;
> >
> > @@ -124,7 +123,7 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
> >       off = (phys_addr_t)addr - paddr;
> >       psize = ALIGN(size + off, DART_PAGE_SIZE);
> >
> > -     dva = lmb_alloc(&priv->lmb, psize, DART_PAGE_SIZE);
> > +     dva = lmb_alloc(psize, DART_PAGE_SIZE);
> >
> >       idx = dva / DART_PAGE_SIZE;
> >       for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
> > @@ -160,7 +159,7 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
> >                          (unsigned long)&priv->l2[idx + i]);
> >       priv->flush_tlb(priv);
> >
> > -     lmb_free(&priv->lmb, dva, psize);
> > +     lmb_free(dva, psize);
> >  }
> >
> >  static struct iommu_ops apple_dart_ops = {
> > @@ -213,8 +212,7 @@ static int apple_dart_probe(struct udevice *dev)
> >       priv->dvabase = DART_PAGE_SIZE;
> >       priv->dvaend = SZ_4G - DART_PAGE_SIZE;
> >
> > -     lmb_init(&priv->lmb);
> > -     lmb_add(&priv->lmb, priv->dvabase, priv->dvaend - priv->dvabase);
> > +     lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
>
> no. This breaks everything. apple_dart is an iommu and used struct lmb
> to manage the IO virtual address space. This has nothing to do
> with system memory.
> Depending on the allocation strategy this will cause all sorts of
> problems since the IO and the physical memory address space does not
> overlap on apple silicon devices. IOVA is for many devices only 32-bit
> but physical memory starts at 0x10_0000_0000 or 0x100_0000_0000.
> Every device has its own iommu / IOVA space so sharing the space between
> all of them is another problem. I'd assume only theoretical due to the
> limited driver support and memory use in u-boot.
>
> My current plan to fix this is to resurrect the old lmb code under a
> different name.

Firstly, apologies for breaking the driver. Looking at the code, it
looks like the driver works with a dva address range in the first 4GB.
I think what the driver expects is fairly straightforward, with a
top-down allocation scheme. I have sent a patch [1] which replaces the
LMB calls with a call to the allocation function. Can you please check
if this works on the board? Looking at how the driver is obtaining the
dva addresses, I think this logic should suffice. Thanks.

-sughosh

[1] - https://patchwork.ozlabs.org/project/uboot/patch/20241029033915.423211-1-sughosh.ganu@linaro.org/


-sughosh

>
> Not sure about the same change in sandbox_iommu but I guess it could be
> ok as there is no sandbox.
>
> Janne
