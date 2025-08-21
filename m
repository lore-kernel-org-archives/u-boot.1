Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D054CA0EF8
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 06:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA0080B9B;
	Thu, 21 Aug 2025 08:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ygyhp4n+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4CE81E13; Thu, 21 Aug 2025 08:21:10 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BEA380422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 08:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e931c71a1baso805298276.0
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755757266; x=1756362066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2gOf5fWCT3vtUT/qu3PjQhxI58FwQ9Max16dlVPBbTs=;
 b=ygyhp4n+WsQUTQLzh8H5puKfr6LdMP7PGtX47+McaHDIRjBWhg7RvwFSxx3celDKHN
 uOW1bntrsciLjjAf5/vMoPD0KT7LQVIhsNHnbgkp8ZIXGaGf7cCr8VSUpQYBwRmt+s+Q
 RD1peAnRwulAG6jN8fOQ7bgtzVKfyXQTtYVVrSSlHHUfLZzrBDFBPfilLruzqZ4yT6Ul
 U1jATyIcDsZMWne8BNHDpHptnSqy2hexR8pR2FBajZvvFydfFtpJdfnJrN+0rrqWcenj
 BnLM9P+JzUxNIJLJy0TcnYYsKibVG9GWsX+jAUNi0eoExwzN91Yjuem0O8RSXMwJhTzC
 0Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755757266; x=1756362066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2gOf5fWCT3vtUT/qu3PjQhxI58FwQ9Max16dlVPBbTs=;
 b=PUb4Xjb/HyknX9ak4i5isL6rJwhcJ27XipT1hQfdKpai8vh1A2+vcMTFpMSLkG0e5x
 0ibbhENB/TVTDxAeZcNOQ830gaQCk+W9Egwkd4O00aF6gUp/9wOQjKuBTuwtp+A3DdLl
 ksNfnnFnHZOmG2f/iDhfwKMz7L6jR7J0K9FX+2X1nYq97QxaluhIDxUVc2c3nKiDFbWS
 ga885NmUa5ccfu46pE2/6RP3bEN8jjVQlu7DWKQTgmRnUt/jwvrFHfRScXA4zK1r8Leg
 IRZk6Uy239BXsK0BPrOa/Sdi3Yl25C11cHgd6AQpK5QQVUv1iPhhelzA2m+DXOpLbp+e
 8Nfg==
X-Gm-Message-State: AOJu0YzATZ5y+OEHn48e1jnCVUg8EeoiZduM5h8E/lvmBb7UYHnxCliz
 Xzt06KBv44pi2jhF0BuQu36YJUkAkRgjN9ZEA+7pramo9uKoylXuGSv0jZ3BWfGJ75kD9M71p0t
 XYxZDVaHurZPOTALIorqek7CJTw/YslaHXJrF1lNqNg==
X-Gm-Gg: ASbGnct71eirChu4gVFr4vaD4AXMthdi6Qm7+Tk5kRnvbmjE7U2UiSGQE03ZPDqgAJJ
 nhMg0fa9kNw50lpBTbZFnyX55SE6qZo+Xic0HLevWEN4LNF7QJTVutxzdLFPx01xiIGVvd2iQ/k
 3vqqE7V3IOWbRRshW+yNB9UFmagvZ4tym5ZWasuxZc32HfaYMO0u5gXpNl6/CQjFsDJHofq78zE
 KTiEb8onXbFNZFQ0f2w6jNDO3DCGfuDNW4OUDVV
X-Google-Smtp-Source: AGHT+IHCkg1oa9am+Khulvl98h09ce3e87jG+/UBwup3phPc5hvCdaNQ9kD5LzxzoeM4rk/qlx9/oCn8ZarsqpGi3WQ=
X-Received: by 2002:a05:6902:2b89:b0:e93:2de7:7453 with SMTP id
 3f1490d57ef6-e9509a7a85cmr1356012276.48.1755757266294; Wed, 20 Aug 2025
 23:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250703133533.104758-1-anshuld@ti.com>
 <20250703133533.104758-3-anshuld@ti.com>
 <DB63KZ89ZWMY.3KGIHVA42RGM4@linaro.org> <DC27M9DO6JP0.2ZG4RG8ZUIRMP@ti.com>
In-Reply-To: <DC27M9DO6JP0.2ZG4RG8ZUIRMP@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Aug 2025 09:20:30 +0300
X-Gm-Features: Ac12FXz0N5mVttm6c5fHKim1BrggJOz4bEXSZ83ly9bCE1UsB3nIBdjrs_52OTE
Message-ID: <CAC_iWjJ9Ra6x=J3F4_yVJrh-YvLP-_Bi_QkpPfR3oaiSbftLig@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mach-k3: add runtime configuration of MMU table
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, trini@konsulko.com, nm@ti.com, 
 robertcnelson@gmail.com, w.egorov@phytec.de, francesco.dolcini@toradex.com, 
 ggiordano@phytec.com, m-chawdhry@ti.com, a-nandan@ti.com, afd@ti.com, 
 bb@ti.com, u-kumar1@ti.com, devarsht@ti.com
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

On Thu, 14 Aug 2025 at 17:12, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Tue Jul 8, 2025 at 1:45 AM IST, Ilias Apalodimas wrote:
> > Hi Anshul,
> >
> > On Thu Jul 3, 2025 at 4:35 PM EEST, Anshul Dalal wrote:
> >> k3_mem_map is used by u-boot to configure the MMU on k3 devices but
> >> currently it's a static array which does not scale for platforms with
> >> non-standard load addresses for ATF and OP-TEE. Additionally on systems
> >> with limited DRAM, more space is mapped than is available on the device.
> >>
> >> Therefore this patch adds a new k3_mem_map_init function which can
> >> be called from dram_init to configure the table at runtime where we
> >> can query the required DDR information and reserved regions from the
> >> device-tree.
> >
> > Is this a problem for k3 only? This kind of code should be aimed at the mmu
> > support and improving armv8 overall, not specific platforms
> >
>
> In K3 we try to support a wide array of SoCs with a single memory map.
> Since the requirements are similar across all K3 devices i.e:
>
> 1. Map all DDR banks
> 2. Create carveouts for ATF and OPTEE
> 3. At SPL stage, map framebuffer region for VIDEO enabled devices
>
> Of the 3 here, #1 and #3 could be useful for ARMv8 overall but #2 is
> quite specific to the platform's boot flow.

Option is also very common across platforms. I don't remember the
details, but we do have code adding op-tee reserved-memory nodes etc.

>
> As I see it, since most of the existing platforms are using a static map
> and thus won't benefit from a generic way to handle #1 and #3.

 I think this is just a limitation of the current code. I've seen
enough platforms only mapping one of their banks for example.
I am not asking you to fix the entire codebase, just extend it to the
part were k3 is supported, but anyone who wishes to do something
similar can re-use your work

> The few
> that do have runtime fixups for the memory map, only seem to have #1 in
> common (imx and renesas).
>
> >>
> >> A dummy implementation is also added in r5/common.c to allow the build
> >> to pass without masking each call to k3_mem_map_init behind an ifdef
> >> CONFIG_ARM64.
> >>
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >
> > [...]
> >
> >> +
> >> +static void k3_mmu_add_cachable_entry(u64 start, u64 end, unsigned int *map_idx)
> >> +{
> >> +    if (start >= end)
> >> +            return;
> >> +
> >> +    k3_mem_map[*map_idx].virt = start,
> >> +    k3_mem_map[*map_idx].phys = start,
> >> +    k3_mem_map[*map_idx].size = end - start,
> >> +    k3_mem_map[*map_idx].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> >> +                                 PTE_BLOCK_INNER_SHARE;
> >> +    (*map_idx)++;
> >> +}
> >
> > Doesn't this need a break-before-make?
> > Also why does it have to be a board specific function? Is there something mmu_change_region_attr()
> > doesn't do ?
> >
>
> Oh, I wasn't aware of that API, I'll update in my next revision.

Great, thanks.

>
> Thanks for the review,

yw
/Ilias
> Anshul
