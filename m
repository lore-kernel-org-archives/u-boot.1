Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410D7D5B879
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 04:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80BEB890D1;
	Tue, 29 Oct 2024 05:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MB0WbEnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC378907E; Tue, 29 Oct 2024 05:32:26 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74258915D
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 05:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso6482277a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 21:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730176342; x=1730781142; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AHisBmZIqD1WUehKAZeuNl2Ng/Be5LL7FzX7jrmjtp8=;
 b=MB0WbEnAB/RvODoGHowhaWq1qK8SkBarzIssd/KfY/cgvFLMpy9jQaZz9U9nRrUFPF
 rGAcq+ne930e/Fu2rONQWynGZHbj6a+YzXOm5UXTQHrmkqscZKWmaEpuL9u7+8WUS6AY
 gB9PF1WA97nR+64yzK9NDXtV02oGfQ/falCW8N2RxDAJgLNG9HrTca6NLPzn/HXGybkL
 2Jrxni7GLn2SN0GCCTmn5yi0SAbtW2p8dqEUjwd1oXT4BubiYav4x+9tX4CJZf+VjlTx
 8RZJeKCOVbCDS0RLXk2ajkGqrKH02AQTrXlSzO0ilzDYxDUGgqfDPaPkNsjoQj9eX9a8
 /4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730176342; x=1730781142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AHisBmZIqD1WUehKAZeuNl2Ng/Be5LL7FzX7jrmjtp8=;
 b=bIwwrjLpihWEPAZgCEwlCf+VqNn1bIdoNvIyNTwNMz8LEBPVmNXvpaE8CrMBRhF/Se
 A0atEDNrzV52Hqc5NCKd0s2sl/RHDr5z59okYkH0R83uDRQ7I3KHSKzlLCktPKjzBV08
 wAywu4NqSKUDtQCH+QfnPatOBjqN62/lGprbCRzmhuiZuRU9kWuF8pv7QwU2BprgKnYs
 gL+XdPayHCPMZDJ4uF1LVSTD7IK1aJ2s7795o6cSJcFFNNJ3mSFFSg8BsCEDsJLIZi4R
 LfOKidsNMYZLkygrp5mS20/8bgl9DoeeQRkJOzk3G8P8gA2ye3ByTQp3+z9yWBBN3wu1
 aMPQ==
X-Gm-Message-State: AOJu0Yzb+yPB8zmg9TUIjkteTNMtgcbXzH++N88rlGc7KiLgbITxxUJL
 arckHu3nhXhezQJjHmG2/Qoznip9oc58VUgfNhKRgbFjMecVhuaQahmsNQXJ46Z4y0VOflmwPR7
 xijoFG0lIgShJc16xUsB5il2QnWwkRBOqsW5MRA==
X-Google-Smtp-Source: AGHT+IHzkmHoYo6cKXrFc/0+tIh7l37zDtVXatuK6B3EpCnpdm/aSH2ajez5kV1ntfYzteClcenNsxJosNovfo+IRyw=
X-Received: by 2002:a05:6402:34d4:b0:5c9:8a06:3420 with SMTP id
 4fb4d7f45d1cf-5cbbf94eba0mr8534163a12.35.1730176342059; Mon, 28 Oct 2024
 21:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-6-sughosh.ganu@linaro.org> <ZyAAJsnV4uz2Btwy@robin>
 <CADg8p94MnjnPQ4Y8_OeQYfwk9W7L8vu+J1tHPcX079D87PzFDg@mail.gmail.com>
In-Reply-To: <CADg8p94MnjnPQ4Y8_OeQYfwk9W7L8vu+J1tHPcX079D87PzFDg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 29 Oct 2024 10:02:10 +0530
Message-ID: <CADg8p97LDnBBDpaWG-f_Qw303BYzZp3VkNeGU93xOZ2aOWsC3g@mail.gmail.com>
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

On Tue, 29 Oct 2024 at 09:19, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 29 Oct 2024 at 02:50, Janne Grunau <janne@jannau.net> wrote:
> >
> > On Mon, Aug 26, 2024 at 05:29:18PM +0530, Sughosh Ganu wrote:
> > > The current LMB API's for allocating and reserving memory use a
> > > per-caller based memory view. Memory allocated by a caller can then be
> > > overwritten by another caller. Make these allocations and reservations
> > > persistent using the alloced list data structure.
> > >
> > > Two alloced lists are declared -- one for the available(free) memory,
> > > and one for the used memory. Once full, the list can then be extended
> > > at runtime.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > [sjg: Optimise the logic to add a region in lmb_add_region_flags()]
> > > [sjg: Use a stack to store pointer of lmb struct when running lmb tests]
> > > ---
> > > Changes since V3:
> > > * Fix checkpatch warnings of spaces between function name and
> > >   open parantheses.
> > > * s/uint64_t/u64 as suggested by checkpatch.
> > > * Remove unneccessary parantheses in lmb.c as suggested by checkpatch.
> > > * Fix alignment in test/cmd/bdinfo.c as suggested by checkpatch.
> >
> > [...]
> >
> > >  drivers/iommu/apple_dart.c           |   8 +-
> >
> > [...]
> >
> > > diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> > > index 9327dea1e3..611ac7cd6d 100644
> > > --- a/drivers/iommu/apple_dart.c
> > > +++ b/drivers/iommu/apple_dart.c
> > > @@ -70,7 +70,6 @@
> > >
> > >  struct apple_dart_priv {
> > >       void *base;
> > > -     struct lmb lmb;
> > >       u64 *l1, *l2;
> > >       int bypass, shift;
> > >
> > > @@ -124,7 +123,7 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
> > >       off = (phys_addr_t)addr - paddr;
> > >       psize = ALIGN(size + off, DART_PAGE_SIZE);
> > >
> > > -     dva = lmb_alloc(&priv->lmb, psize, DART_PAGE_SIZE);
> > > +     dva = lmb_alloc(psize, DART_PAGE_SIZE);
> > >
> > >       idx = dva / DART_PAGE_SIZE;
> > >       for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
> > > @@ -160,7 +159,7 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
> > >                          (unsigned long)&priv->l2[idx + i]);
> > >       priv->flush_tlb(priv);
> > >
> > > -     lmb_free(&priv->lmb, dva, psize);
> > > +     lmb_free(dva, psize);
> > >  }
> > >
> > >  static struct iommu_ops apple_dart_ops = {
> > > @@ -213,8 +212,7 @@ static int apple_dart_probe(struct udevice *dev)
> > >       priv->dvabase = DART_PAGE_SIZE;
> > >       priv->dvaend = SZ_4G - DART_PAGE_SIZE;
> > >
> > > -     lmb_init(&priv->lmb);
> > > -     lmb_add(&priv->lmb, priv->dvabase, priv->dvaend - priv->dvabase);
> > > +     lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
> >
> > no. This breaks everything. apple_dart is an iommu and used struct lmb
> > to manage the IO virtual address space. This has nothing to do
> > with system memory.
> > Depending on the allocation strategy this will cause all sorts of
> > problems since the IO and the physical memory address space does not
> > overlap on apple silicon devices. IOVA is for many devices only 32-bit
> > but physical memory starts at 0x10_0000_0000 or 0x100_0000_0000.
> > Every device has its own iommu / IOVA space so sharing the space between
> > all of them is another problem. I'd assume only theoretical due to the
> > limited driver support and memory use in u-boot.
> >
> > My current plan to fix this is to resurrect the old lmb code under a
> > different name.
>
> Firstly, apologies for breaking the driver. Looking at the code, it
> looks like the driver works with a dva address range in the first 4GB.
> I think what the driver expects is fairly straightforward, with a
> top-down allocation scheme. I have sent a patch [1] which replaces the
> LMB calls with a call to the allocation function. Can you please check
> if this works on the board? Looking at how the driver is obtaining the
> dva addresses, I think this logic should suffice. Thanks.
>
> -sughosh
>
> [1] - https://patchwork.ozlabs.org/project/uboot/patch/20241029033915.423211-1-sughosh.ganu@linaro.org/

This would not work as it does not consider freeing of the va
addresses. So there might be a need for a parallel lmb instance for
this.

-sughosh

>
>
> -sughosh
>
> >
> > Not sure about the same change in sandbox_iommu but I guess it could be
> > ok as there is no sandbox.
> >
> > Janne
