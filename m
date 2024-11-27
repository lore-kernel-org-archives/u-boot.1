Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51BFD6ACF7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356D1897BE;
	Wed, 27 Nov 2024 18:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L6T25X53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A136F897BF; Wed, 27 Nov 2024 18:52:05 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B8A8956D
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa55171d73cso205190066b.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732729922; x=1733334722; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D9UZfOLgc2cKRDRI9mapBdYVRJ2ipmXEyacaJbPlDs8=;
 b=L6T25X535TomjF9QBUUbN9ocjfsxg6m/snZVjZUy7CSFbkUumbQaJdqBr/QsMmaKzi
 UOFU8ZT7vBbDnoI5kUtmeHazpzz4XGIm4tev2Dk7nM9409PDFVi1SBfkjAhYbfOEvFvF
 EouVVWax+Q1m5rCdk0TAyZ2DADUB1Pc3nzB5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732729922; x=1733334722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9UZfOLgc2cKRDRI9mapBdYVRJ2ipmXEyacaJbPlDs8=;
 b=Cp1b1ebwYgxxz/tqlt1t8esa96IKA+aUOMXeiHuiGxBcTmWpRWxnutb0Ap3BdaYNE7
 zUI2MqGrKzjLETb34WUR4I+ML9A/aZzeKd4fv6HKEA3FdoKW1+aCw+IDO7CqgRuOWZSH
 QAI8qcDAgfAmnbrRHo1rJz8/dKZ6jV6dkMLrDxDVT/JlP3Kag8QDei8IgjVOoR37szJD
 pPp9g39ZeEPT9QTfBWW2WNUKMFPQ/gdyKYNB1aga50OyxcIMrn98XKJ9rTdINtz5tW6Q
 7wTtZUy8rB7BqjQkRTJALLmy3HlUCruLhURdwGkEjWftJF1tbbaB4M13pKFciDLCg/0r
 kRvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJlyZVuHUJh+4Jn+kepf/woE4wL3LGPcH5bhPKPQHl6ffHDB2a2fZmgnWudxLdHGkFVLRaXUc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6138VI+DpM0V5MfPI8vhf8G8Gi32AUcCXikEIQjtMNOAcdnQX
 QZU8p2BobnmJHKtiKhi/UqhUkxAozhksm2k0GZiVOkXmlLgfsG0e+m5+zusExI1NaLQNesP2DdU
 MJajNZWzAgX08nlZn90VWayd4wvVq0BCcFh5J
X-Gm-Gg: ASbGncu+P+7OrTk8IgQbAbr0jwRumtf8KEWX28RZI6oELS5SiJHGc2kr9cAIE5sTiGU
 AipnuZeqNpgNz9GT1QCOhe1E1asLzZAI=
X-Google-Smtp-Source: AGHT+IHbRSr0zURZwkUsRoJt6JkD2vi5zbeMWjzBO8EQ/Xh17xLB9ZOU3BoiK8+qpk0U6q30KMFqXCXH8AHqPoL1bhQ=
X-Received: by 2002:a17:907:7e97:b0:a9a:130e:11fd with SMTP id
 a640c23a62f3a-aa5944eb31dmr33888666b.5.1732729922140; Wed, 27 Nov 2024
 09:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20241113052050.1862420-1-caleb.connolly@linaro.org>
 <CAFLszThAmn_NU-PoYopjx17Bk6QxgbFaCWJjKdMAG5JzLJWdEg@mail.gmail.com>
 <d89d7d04-8ff9-460d-844f-c85129c5ba77@linaro.org>
In-Reply-To: <d89d7d04-8ff9-460d-844f-c85129c5ba77@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 10:51:50 -0700
Message-ID: <CAFLszThmRJZHzecSH1A9zS7f3oiS+kCB=jBarHOZG7RGv3gL_A@mail.gmail.com>
Subject: Re: [PATCH] dm: core: ofnode: safely fallback in ofnode_lookup_fdt
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Caleb,

On Wed, 27 Nov 2024 at 10:12, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 27/11/2024 17:52, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Tue, 12 Nov 2024 at 22:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Under some conditions it's possible to hit the null condition here like
> >> when running with OF_LIVE and using the ofnode API before
> >> initr_of_live() is called. There is very little null
> >> checking for this in the FDT framework, so returning null here can
> >> result in weird null pointer conditions.
> >>
> >> Instead let's return the control FDT in the fallback case, this is
> >> usually what the user was expecting.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>  drivers/core/ofnode.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> >> index 950895e72a99..7a7f25fc537c 100644
> >> --- a/drivers/core/ofnode.c
> >> +++ b/drivers/core/ofnode.c
> >> @@ -152,9 +152,9 @@ void *ofnode_lookup_fdt(ofnode node)
> >>                 uint i = OFTREE_TREE_ID(node.of_offset);
> >>
> >>                 if (i >= oftree_count) {
> >>                         log_debug("Invalid tree ID %x\n", i);
> >> -                       return NULL;
> >> +                       return (void *)gd->fdt_blob;
> >>                 }
> >>
> >>                 return oftree_list[i];
> >>         } else {
> >> --
> >> 2.47.0
> >>
> >
> > Eek I really don't like that, since it will silently return an
> > unexpected value.
> What's the unexpected value? The only caller for this is ofnode_to_fdt()
> and the return value for that is never checked. It seems clear to me
> that in practise NULL is the unexpected value here.

Firstly, it looks like ofnode_lookup_fdt() should be static

If a node offset cannot be found, that suggests that oftree_list[] is
empty, which suggests that oftree_reset() has not been called yet.

oftree_reset() is called after relocation. Before relocation, it just
assumes that the control FDT is being used.

I wonder if you are hitting this problem after relocation, in one of
the functions in init_sequence_r[] before initr_dm()?

In any case this does seem like a bug that we should fix.

>
> > I think we should panic. Do you know what code path
> > gets you here?
>
> Hmm, I don't exactly recall. Should really have made a note when I wrote
> this patch :/

Yes, I know that feeling :-(

>
> Guess I'll drop this from my dev branch and come back when I figure this
> out again.

Yes OK. A patch which panics would be fine for now, if you like.


> >
> > More work is needed in livetree to sort of the rough edges, sadly...

Regards,
Simon
