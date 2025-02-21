Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5219CC021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 07:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50564801DE;
	Fri, 21 Feb 2025 08:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CRKwabLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E1F8056B; Fri, 21 Feb 2025 08:20:16 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3AD8007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86949b5b5b1so461837241.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 23:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740122413; x=1740727213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=teD6AFUevD5g1WTq8bsf1F7PqL/OjR3JxMdGHe9hOdc=;
 b=CRKwabLJyHd137QlBROCq3G/e3ATSaGzuR5EI4V1+xYz4KkEQW7H1TXZHDKdUMloqI
 gFHRdN5U8MNCLvldGzLaPWXlGOD/gn52PDnfjT3r0COolq5WYZJKUpBJ1K0mQjMPbw4q
 NDqm6Y519EKu+wUr602KkiJupk38cGbxWf0iL6bWecKX4Pl0ZB7E6LjansugoVSgnYWW
 rSMzkXz+mTEwYo8xAl/FmloE4/8wNjEPuAlByUwWH5wNmELruEXWV5HjfsVuIySeJ8+c
 bf7RcjkzsNeX2D9wQY0uGbqb0oe2EzoAp60cfJjr8ctvLxW9Go6v70AX1NWpYQnm6SUR
 KROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740122413; x=1740727213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=teD6AFUevD5g1WTq8bsf1F7PqL/OjR3JxMdGHe9hOdc=;
 b=MsY4H02HSX9hfp83zetQOpLUPzi+H11DkMdvuXIbBMACkPTIPpOhjWG+R/bHM5RxmU
 lSroptnuZ8qMOI5a+fD4sZA/bf/iYMpqO/F4QwK0O0H1CIwx796Pam9bLMBwDjJywr/W
 Ohd45hzIzpuNlUKcXSGmR1RvvPQ9QKkZqwHGcabTzGZGszWvRuEWtKow6yBMO77owb6W
 sNguyXBeliwRayhsan7ymW9GMn8ptVbi23jqjr28lrE3CftzWc+3ZTYG9nng3PMnTZ/Q
 s96c1FehJWIRhwn7xxmB6llaxbYRsK5UjO5n+QSMPYFDa9swx0z6mTgJl+34K9S45ij/
 WRiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBc2/kM+2VQGGS0Xn4UhTClHtcFxgjH7E5oarx9WbuWivTGR2f36cVbEgSaRKDT8JKiTrZIVE=@lists.denx.de
X-Gm-Message-State: AOJu0YzdOk1MgoXqanQq8kgUWD2ox7r+wTnfEKVrgAE81ILLdTTWuaTL
 AiFIphA2T2kS51zBl0pPPxq3wEKf/1iQ2QhXYT8qZzCap3o4SGMDh3bsJCwWWkivpBaIhyfCBy8
 5R5xse2+4mDXT/rCr2DWh139tF41LnyDJqjpBqw==
X-Gm-Gg: ASbGncve1Wx1fFncB1RlbeQOAHdEVb8247gCLlEFUnvHTfhXHXTipEzBMxtOxV03dej
 Kq6PiXMxisJxafQZy8+e3vmtxynQDuAlRQX8UC6WaF1cHpY0Nr9e24DW8X87PwcyMw3WmdfSO/b
 Dsx4kClOHJ
X-Google-Smtp-Source: AGHT+IEWVgHr7e8cA1coRO4ii1O5jaXu39tiF2o3fB4PDhrf8gzKDc86LNMRp85TJaWzfIpzbw4Kh5WaoyVRIwlaRpM=
X-Received: by 2002:a05:6102:942:b0:4bb:ce42:40f5 with SMTP id
 ada2fe7eead31-4bfc0222fc3mr1546421137.18.1740122413420; Thu, 20 Feb 2025
 23:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20250220095654.121634-1-sughosh.ganu@linaro.org>
 <20250220095654.121634-5-sughosh.ganu@linaro.org>
 <d5a0ef6c-8b50-4f9e-96bc-68a5acbce269@canonical.com>
In-Reply-To: <d5a0ef6c-8b50-4f9e-96bc-68a5acbce269@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 21 Feb 2025 12:50:02 +0530
X-Gm-Features: AWEUYZmxuBwQ-5RqKTLQLFoGIplw257xm6ZKp6h95UR4cemxoplyR1KszDStYTc
Message-ID: <CADg8p943BE2XC3-uQo8dwgh49uBH-digqVim3wSGdjSn2zw7Gw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] lmb: remove superfluous address overlap check from
 lmb_add_region_flags()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Udit Kumar <u-kumar1@ti.com>, u-boot@lists.denx.de
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

On Thu, 20 Feb 2025 at 16:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 20.02.25 10:56, Sughosh Ganu wrote:
> > The lmb_reserve() function now does a check for a reservation request
> > with existing reserved regions, and returns -EEXIST in case of an
> > overlap. Remove this now redundant check from lmb_add_region_flags().
>
> We have numerous places where lmb_add_region_flags() is called,e.g.
> lmb_free_flags(), _lmb_alloc_base(). It is unclear to me if in all cases
> removing the check is allowable.

The reason this check had been put here was to handle the case of
request for the same memory region with a flag other than LMB_NONE.
With patch 1 of this series, this gets handled in lmb_reserve(). Also,
this will not be a scenario for lmb_free_flags() and
_lmb_alloc_base(). _lmb_free_flags() is freeing up memory, and
lmb_add_region_flags() gets called for adding a new memory region that
might be needed because the entire region has not been freed -- this
operation will not overlap with an existing region. Same for
_lmb_alloc_base(), as this function does not allocate existing in-use
memory -- it is designed to look for available memory. The
re-requesting of an existing region only happens through the
lmb_reserve() and lmb_alloc_addr() route.

>
> Could you, please, in the commit message provide an analysis for all
> callers that don't use LMB_NONE.

Will do. Thanks for your review.

-sughosh

>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: New patch
> >
> >   lib/lmb.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 45888989457..061f9a07541 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -199,9 +199,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> >                       coalesced++;
> >                       break;
> >               } else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> > -                     if (flags != LMB_NONE)
> > -                             return -EEXIST;
> > -
> >                       ret = lmb_resize_regions(lmb_rgn_lst, i, base, size);
> >                       if (ret < 0)
> >                               return -1;
>
