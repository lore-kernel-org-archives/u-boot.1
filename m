Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D43C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 10:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1DD582E31;
	Wed, 21 May 2025 12:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dcn22fuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B4F82E81; Wed, 21 May 2025 12:03:03 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D830482E2D
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 12:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c9677cd6d7so676165385a.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747821780; x=1748426580; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/duUTZ1TdpIYDBvfYEAJAVPbybmJCsU0CHrNNTU1prc=;
 b=dcn22fuLwDP1U+agIS6R04BzbKh3WCkN8V3dB2OmDqwZ19huffArjLskKMPS7UQLP/
 sCf0KQeM1Kl9DgbkRu6Nxp/h9m3udo+mFhX0PVqysrM1KaR5I7li88B97Y+NTMqMW2VE
 ZB4fQTmw5cO4NGt5d3l49zrEFmGyGO7I6RnTZ5g5Z/DPIwjmqR3A0Ctq4QA0p0F6T35E
 ZCYUA0EOnCxoxe8/OF+lhUlZGBF6TfbpK+vt28JHpEBOMXH11Eceki8Tx+PnxTVPcRF9
 NKygjbnsC6E7Cde1kF93u6b5gbIUZOKLhkfqX+/Ngi1dkop/y45r3TIer1QmTLkWJDdB
 1QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747821780; x=1748426580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/duUTZ1TdpIYDBvfYEAJAVPbybmJCsU0CHrNNTU1prc=;
 b=nk7aFZkdrHDEVcYA4ymHQTtYAOYf31gWUWKfwnkyzH2zjw4YVxleOqUf15d+0/YyRJ
 Rhw6sd+pbX9Lp/1cmxwrXrgQo+tiBTlxrMB8ORkleFf4KGo5VWWWpEiP2w6qkQvCySZP
 kch0OtOc8hoNuiOINrnFeiyc1Ay8eb5ZI4mc16evHaa54QRRBYjVYcuBX4UtdlJDKat4
 DGEpdUPUXIYSCFyjR0NW7EZB6DNM0vUU20haSj+s2UwFOM6t0b30t26mTt77+HzO32/7
 st/eCpPlxM5wTogEymtfkoRPa3/Rz9JW4fWbd4botRq9RXWPE1u8N9UpVoj2J4WVZXM8
 5Kvg==
X-Gm-Message-State: AOJu0YxdUH80UhSTHfqvbYnuvne0xqGdn/8Ub3d9DloCe5wRyI87COGt
 nffDMEb5kSVVhcvwIHxDJq+ECOdY57JoxdKQNadTQ3/n5zqWAkTfIMzMF1fpLPWYSYnuMZuU73H
 WgEIiHHl48BX1lSspWmYAyMqr592MJ1l8do5NRK+VrA==
X-Gm-Gg: ASbGnctdgt3LEYLRdADOSiBUGvz6ROoqmgvVdhR18F+jcLcxpupM+mWEFOJi92EScDt
 zwMVKJbEjgpS9EkW/ndxpPEkyKLp/eO7qyupNk6T12RGmNfHJV4szLb/H9fxaTikfXkYsz5hqlR
 khq/Q34SAnDjfFoLJdsrrNzRRH4vhLW+lM6Q==
X-Google-Smtp-Source: AGHT+IGpZqGGBIR+VG1/gdRs8/7nccvHM8X21h7Dg+zU2Z35QdvptI5L8eEve483knR7F7o3Co5Oii3LjORYl9+ppkQ=
X-Received: by 2002:a05:620a:2910:b0:7ca:cc88:bcef with SMTP id
 af79cd13be357-7cd4672d904mr3021067085a.15.1747821779290; Wed, 21 May 2025
 03:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250520120606.173228-1-sughosh.ganu@linaro.org>
 <20250520120606.173228-2-sughosh.ganu@linaro.org>
 <DA1OCJCRJ6KI.1X5DUMJDQ6913@linaro.org>
 <CADg8p97UZVCUoYe3wzykVMDc+wpVJuz06+vJuJvG6WsMRRto3g@mail.gmail.com>
In-Reply-To: <CADg8p97UZVCUoYe3wzykVMDc+wpVJuz06+vJuJvG6WsMRRto3g@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 21 May 2025 15:32:47 +0530
X-Gm-Features: AX0GCFvKjtaCSIadaRPrUiX59jqne6_Am2zu2w64EcvJsVFzqVpUjySUObANv-o
Message-ID: <CADg8p95TjKPJKLF1+vSVRRh5_a67tUZAs0YSjDaSBrMumqnjGA@mail.gmail.com>
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

On Wed, 21 May 2025 at 14:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 21 May 2025 at 13:23, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sughosh
> >
> > On Tue May 20, 2025 at 3:06 PM EEST, Sughosh Ganu wrote:
> > > There currently are multiple allocation API's in the LMB module. There
> > > are a couple of API's for allocating memory(lmb_alloc() and
> > > lmb_alloc_base()), and then there are two for requesting a reservation
> > > for a particular memory region (lmb_reserve() and
> > > lmb_alloc_addr()). Introduce a single API lmb_allocate_mem() which
> > > will cater to all types of allocation requests and replace
> > > lmb_reserve() and lmb_alloc_addr() with the new API.
> > >
> > > Moreover, the lmb_reserve() API is pretty similar to the
> > > lmb_alloc_addr() API, with the one difference being that the
> > > lmb_reserve() API allows for reserving any address passed to it --
> > > the address need not be part of the LMB memory map. The
> > > lmb_alloc_addr() does check that the address being requested is
> > > actually part of the LMB memory map.
> > >
> > > There is no need to support reserving memory regions which are outside
> > > the LMB memory map. Remove the lmb_reserve() API functionality and use
> > > the functionality provided by lmb_alloc_addr() instead. The
> > > lmb_alloc_addr() will check if the requested address is part of the
> > > LMB memory map and return an error if not.
> > >
> > >        * there's no need to check the result
> > >        */
> > >       arm_smccc_smc(MTK_SIP_GET_BL31_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
> > > -     lmb_reserve(res.a1, res.a2, LMB_NOMAP);
> > > +     addr = (phys_addr_t)res.a1;
> > > +     lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, res.a2, LMB_NOMAP);
> >
> > In some case you check the return value and in others you ignore it.
> > Since you are changing this, check the return address everywhere
>
> Yes, I mentioned this in the cover-letter. I have kept the code in
> arch-specific functions as is when it comes to error checking, as I do
> not have the associated boards with me. I am not sure what side
> effects erroring out would have. It would be better if the respective
> custodians/maintainers fix this, as it would ensure no breakage.
>
>
> >
> > > + * be -EINVAL if the requested memory region is not part of the LMB memory
> > > + * map, and -EEXIST if the requested region is already allocated.
> > > + */
> > > +int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
> >
> > Nit, but can you rename it to lmb_alloc_mem() so it uses abbreviations everywhere?
>
> You mean a shorter name? I had pondered over using lmb_alloc_mem()
> instead earlier, but thought about using the current one, as this is a
> globally visible API.
>
> >
> > > +/**
> > > + * lmb_can_reserve_region() - check if the region can be reserved
> > > + * @base: base address of region to be reserved
> > > + * @size: size of region to be reserved
> > > + * @flags: flag of the region to be reserved
> > > + *
> > > + * Go through all the reserved regions and ensure that the requested
> > > + * region does not overlap with any existing regions. An overlap is
> > > + * allowed only when the flag of the request region and the existing
> > > + * region is LMB_NONE.
> > > + *
> > > + * Return: true if region can be reserved, false otherwise
> > > + */
> > > +static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
> > > +                                u32 flags)
> >
> > Overall this is a good cleanup. But I was hoping we can rid of this as well.
> > This is almost identical to lmb_overlaps_region() with very small differences.
> > One of these takes the lmb list as an argument and the other is also checking some flags.
> > It's better if we keep one.
>
> I can get rid of the above function. It would require putting the
> checks for the flags in the calling function, but we can indeed use
> lmb_overlaps_region() instead. I will put this in a separate patch.
> Thanks.

Sorry, I replied here in haste. The reason I introduced
lmb_can_reserve_region() is because there is a subtle difference
between what lmb_overlaps_region() does. The lmb_overlaps_region() is
used primarily to check if an address can be allocated. So it stops
iterating through the regions as soon as it finds an overlap -- this
makes sense as we cannot allocate memory over already reserved memory.
The lmb_can_reserve_region() is used for reserving memory, which might
already have been reserved. This function then checks if the requested
region overlaps one or multiple regions, and if the flags of all the
existing regions match (all regions have flag LMB_NONE) so that the
reservation can go through. I have depicted the scenario in a diagram
[1]. So, in case of code re-use, there will have to be some tweaks
made to lmb_overlaps_region(), so that in case of a reservation
request, it should not stop iterating through the loop in case of an
overlap. I will check if it can be cleanly implemented.

-sughosh

[1] - https://gist.github.com/sughoshg/accfad55244fa0f3965e2137db8062b2

>
> >
> > [...]
> >
> > Overall this is moving towards thr gith direction
>
> Good to know :)
>
> -sughosh
>
> >
> > Cheers
> > /Ilias
