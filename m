Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B4FC54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C213482D59;
	Wed, 21 May 2025 11:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jm+qmGHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A05D82D6C; Wed, 21 May 2025 11:18:16 +0200 (CEST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1BCD82D2B
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-87be2373596so1935999241.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747819092; x=1748423892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lIIX1my3hcLMxf/sE98i2MEEpuyIcbZAQbYjb9DgwgY=;
 b=jm+qmGHXW0hvGLZS02ekAaqX0I8rdXJOV+TmL6s3Kfpnrj+B/Bb89vt08abyp1+Z4M
 kdm4iSARiTpYxpjMsY0KIQhO15PCAsGuWsv4SIr3tTNxflz0nzYLuUvAQNFZHOd4F0oR
 AeYfG6y3iILzxi6yG+bdOEFP4qaRRKsYk2E1Do4T0wkkmKwSREbQDhffqnsF7ACkhZhR
 OOMj1Gqi73byQwyKdjkFY+94tUjHnL47eR2VWATvk+yOU8FtvydyeffFmgOdroETSfGq
 ENiUBFUjR30mLANiM9mDrN4p4me3pV18KyqJ+Qy8S6il/QhCe7dkQJD9PMjTXcNuVwxd
 qkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747819092; x=1748423892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lIIX1my3hcLMxf/sE98i2MEEpuyIcbZAQbYjb9DgwgY=;
 b=kEF7M23iHd1QF+BKAHhNk9kCkC9fbxFRxp/zAj8HpJlSQwizaDEU895uoFSg33o/Ag
 dpAohuTVdzKMCVWI3xXkgIsnxBzL2Rks8xLHlK8C3cWoNDfXQsVV+dpyyxctMjzFqOyE
 oYd5Xvomuzii4maAsI4QeZjIt9jU8EZ5wZs1KvMhzFOsByy2P9xndk24KE10rSH1w9VN
 Tk714m1ltWkEmAoOW5fcSO0PKuWQiIg95QuebHufEdH3wWc5ijRIvU4A4NS3Y2e9hO/o
 nL0Kh8xHizKgODey9kBJTOwSAnWZH9FMXzle6LWSrts/X4anhC2Zul4sVohD3ldSoo8p
 ddsg==
X-Gm-Message-State: AOJu0Yzhsg2tlkdeurf5BHlgI827fg24DoXbLy2Pq5zsQA0Z9MR/A8Ju
 F6pcEwiTTLtdU8nsosQI77rYN1Aze9mzr34E/2jTvL+8yage/G2qqRZMQXD2TTCLCiM3evvIjpp
 I3uDwKOgH/qVpS2lLvPyqsaySd1eVXBhYhfTqIHjHoQ==
X-Gm-Gg: ASbGncucoDwsZ9hIfWh6UmB5+IpeDeABpN6/8AHXpun34zNuH3dhfAVuymN5/kHmndE
 fKA4QsBIYLvx1qLKOF+wvVfB+3uuiif3+lDfCpMQsndh12Ko66FurwX5JFjH8bfot38WZ/es48W
 8S318P7YvEDlixfzU9VroUGFGIynUfkwLATg==
X-Google-Smtp-Source: AGHT+IG/tC21DfLKb0XIty+HVI94WyvKHHX+mmZepBlCgylO5PegwRvxpwR9oHD3pfEcAjTMTWY4sGTV4CG7376eu/Q=
X-Received: by 2002:a05:6102:8005:b0:4dd:ad20:a334 with SMTP id
 ada2fe7eead31-4e049d57331mr18861433137.7.1747819092496; Wed, 21 May 2025
 02:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250520120606.173228-1-sughosh.ganu@linaro.org>
 <20250520120606.173228-2-sughosh.ganu@linaro.org>
 <DA1OCJCRJ6KI.1X5DUMJDQ6913@linaro.org>
In-Reply-To: <DA1OCJCRJ6KI.1X5DUMJDQ6913@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 21 May 2025 14:48:01 +0530
X-Gm-Features: AX0GCFuKYSni_N69Svu6Gc_JnfBahuT7N5cxJQKjYPmMT24UJurwvwklj8JN8Eo
Message-ID: <CADg8p97UZVCUoYe3wzykVMDc+wpVJuz06+vJuJvG6WsMRRto3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lmb: replace lmb_reserve() and lmb_alloc_addr()
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

On Wed, 21 May 2025 at 13:23, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> On Tue May 20, 2025 at 3:06 PM EEST, Sughosh Ganu wrote:
> > There currently are multiple allocation API's in the LMB module. There
> > are a couple of API's for allocating memory(lmb_alloc() and
> > lmb_alloc_base()), and then there are two for requesting a reservation
> > for a particular memory region (lmb_reserve() and
> > lmb_alloc_addr()). Introduce a single API lmb_allocate_mem() which
> > will cater to all types of allocation requests and replace
> > lmb_reserve() and lmb_alloc_addr() with the new API.
> >
> > Moreover, the lmb_reserve() API is pretty similar to the
> > lmb_alloc_addr() API, with the one difference being that the
> > lmb_reserve() API allows for reserving any address passed to it --
> > the address need not be part of the LMB memory map. The
> > lmb_alloc_addr() does check that the address being requested is
> > actually part of the LMB memory map.
> >
> > There is no need to support reserving memory regions which are outside
> > the LMB memory map. Remove the lmb_reserve() API functionality and use
> > the functionality provided by lmb_alloc_addr() instead. The
> > lmb_alloc_addr() will check if the requested address is part of the
> > LMB memory map and return an error if not.
> >
> >        * there's no need to check the result
> >        */
> >       arm_smccc_smc(MTK_SIP_GET_BL31_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
> > -     lmb_reserve(res.a1, res.a2, LMB_NOMAP);
> > +     addr = (phys_addr_t)res.a1;
> > +     lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, res.a2, LMB_NOMAP);
>
> In some case you check the return value and in others you ignore it.
> Since you are changing this, check the return address everywhere

Yes, I mentioned this in the cover-letter. I have kept the code in
arch-specific functions as is when it comes to error checking, as I do
not have the associated boards with me. I am not sure what side
effects erroring out would have. It would be better if the respective
custodians/maintainers fix this, as it would ensure no breakage.


>
> > + * be -EINVAL if the requested memory region is not part of the LMB memory
> > + * map, and -EEXIST if the requested region is already allocated.
> > + */
> > +int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
>
> Nit, but can you rename it to lmb_alloc_mem() so it uses abbreviations everywhere?

You mean a shorter name? I had pondered over using lmb_alloc_mem()
instead earlier, but thought about using the current one, as this is a
globally visible API.

>
> > +/**
> > + * lmb_can_reserve_region() - check if the region can be reserved
> > + * @base: base address of region to be reserved
> > + * @size: size of region to be reserved
> > + * @flags: flag of the region to be reserved
> > + *
> > + * Go through all the reserved regions and ensure that the requested
> > + * region does not overlap with any existing regions. An overlap is
> > + * allowed only when the flag of the request region and the existing
> > + * region is LMB_NONE.
> > + *
> > + * Return: true if region can be reserved, false otherwise
> > + */
> > +static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
> > +                                u32 flags)
>
> Overall this is a good cleanup. But I was hoping we can rid of this as well.
> This is almost identical to lmb_overlaps_region() with very small differences.
> One of these takes the lmb list as an argument and the other is also checking some flags.
> It's better if we keep one.

I can get rid of the above function. It would require putting the
checks for the flags in the calling function, but we can indeed use
lmb_overlaps_region() instead. I will put this in a separate patch.
Thanks.

>
> [...]
>
> Overall this is moving towards thr gith direction

Good to know :)

-sughosh

>
> Cheers
> /Ilias
