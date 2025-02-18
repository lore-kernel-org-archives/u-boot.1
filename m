Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF33C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 07:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213D880737;
	Tue, 18 Feb 2025 08:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YO4Ac/6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39EB807F1; Tue, 18 Feb 2025 08:07:41 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688C7800B3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4bd73f93215so1784936137.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 23:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739862458; x=1740467258; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q47odaLrkWGSu45hs9Fji+rESrM6GZmHI10/js6S+Uw=;
 b=YO4Ac/6JuQh7GEqabIZ7IQcNJON2agXn6QyYEy4ak3xGMiui5kPfjr0vDSPCz/GYEN
 ms+6sJFFZHbG0bBf8mCjzIhWL6EZ3t4p/3SrdpNWDL0id416+I1wYQ6ojBikeT0LBvxQ
 2C0y0kcKzuJHrW47Hc5uiYbZQo9EWVIfT6pLdMX87Y6ouZTd+/ppKSWS2RIfsrS5KzHf
 51OErGPttGWV8/FrSzaOBxyx3bPhQfayAwyQLwibNs+44AaKeGFHMVb1lovB3EHfPXj3
 SCOYCYGdeNQHPd+QTsIWswBw+NWU5fh6fHHt2kgqr6BSgLyuEBjNw512mqnOUTA6pv0z
 +N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739862458; x=1740467258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q47odaLrkWGSu45hs9Fji+rESrM6GZmHI10/js6S+Uw=;
 b=qHEOQ5rMnTBF6PdgSW784DJYcXMlc6PJszF0N8PzY9ZvHBkq0oQBO7dIHqUGbQIx7D
 hdDoLGjxgADayu1KILj/Vc3lR1+pWFvFLWQIDqSxGJP2DTFmAVd431ybinUlRMMh1RbL
 QhhPuo4QqwQMmf7y6SWfsKrWFvfiyiN4F4wo3r7lRG5FmXCIV9KqoXtMtbiga2g+tAu8
 dnQ2eA9sD1A1O4sr7w6vymArfoBpUMDIwhANjpuDIBzZY6nvg1LM1U+dzmEJj1lYaUuF
 fnVgyrvejkmXWjdXB6y4CDjReQlZNFH2pjLVHKxjgRhZ8uWZXPYr8LpVHeQlOquwyPYu
 Jhew==
X-Gm-Message-State: AOJu0YzZuxdvOHACGhXwDOMH5VEuS4ay3YRbCMyOiSr9zgtHI3U44oUl
 BQ1LB4KFnItEO8TnNXorYIwziPOQxiptgsXkMP00A7/LHWoJT+34g6RWHcb2Ca9Io7ObqRGMS05
 7Va9zkOtiK7ZckD2kaj0mg1weFOdlV6f8I2pDmw==
X-Gm-Gg: ASbGncsAB5RFpGMlcgyJcODd/pfyZEOToCf+I91ZYrA0vsveuns6eXLUXNWkFxYoUGL
 g1vt5Zoos4TI6na/K48S4Oxk2mFUokiBMn4lwYg/DRUsQZSxw7k8q7oeWVjg56Ui5uiAPH1qaAw
 ==
X-Google-Smtp-Source: AGHT+IH1FyP1vdnXGYz/Fhv6lk6qIeRhgtWYsGvaDLXMPIEMwU38OhxjzkUK6yIR+hfNycrYVUqw6pnQ8ygkzkySIa0=
X-Received: by 2002:a05:6102:6c8:b0:4bb:cbbc:4c with SMTP id
 ada2fe7eead31-4bd3fc6c608mr6110847137.2.1739862458229; Mon, 17 Feb 2025
 23:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-3-sughosh.ganu@linaro.org>
 <dae7cabe-9f4f-4f3e-a0e4-6af65dc96723@cherry.de>
In-Reply-To: <dae7cabe-9f4f-4f3e-a0e4-6af65dc96723@cherry.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 18 Feb 2025 12:37:25 +0530
X-Gm-Features: AWEUYZmfb5BHnFivSRLPGnHq9rZo-VZepfsNlHwcbXBCMdR2Qij4Heggj9XkHps
Message-ID: <CADg8p95BQYh6ZH04nMergbJFP3AGC+LzmED71qahv+PVZrS6yg@mail.gmail.com>
Subject: Re: [PATCH 2/4] lmb: handle scenario of of encompassing overlap
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Mon, 17 Feb 2025 at 20:51, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Sughosh,
>
> On 2/13/25 2:11 PM, Sughosh Ganu wrote:
> > The lmb_fix_over_lap_regions() function is called if the added region
> > overlaps with an existing region. The function then fixes the overlap
> > and removes the redundant region. However, it makes an assumption that
> > the overlap would not encompass the existing region, and in such a
> > scenario, it prints a message and returns without making the
> > fix. Handle the case of an encompassing overlap also in the function.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> >
> > Note: To be applied after an A-b/R-b/T-b from the original author
> > of the lmb_fix_over_lap_regions() function on this
> >
> >   lib/lmb.c | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index aeaf120f57d..a5216bdccc7 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -111,11 +111,9 @@ static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
> >       phys_addr_t base2 = rgn[r2].base;
> >       phys_size_t size2 = rgn[r2].size;
> >
> > -     if (base1 + size1 > base2 + size2) {
> > -             printf("This will not be a case any time\n");
> > -             return;
> > -     }
> > -     rgn[r1].size = base2 + size2 - base1;
> > +     if (base1 + size1 < base2 + size2)
> > +             rgn[r1].size = base2 + size2 - base1;
> > +
> >       lmb_remove_region(lmb_rgn_lst, r2);
>
> Mm I have a feeling this function was improperly named, this is
> essentially just merging two regions that are overlapping. Similarly to
> lmb_coalesce_regions except it handles overlaps too.
>
> I'm wondering if we shouldn't simply merge lmb_regions_adjacent and
> lmb_regions_overlap, and lmb_coalesce_regions and
> lmb_fix_over_lap_regions into one function each? e.g.
> lmb_regions_mergeable() and lmb_merge_regions()?

I will go through these functions and see what can be merged into a
single function. On these lines, for v2, I have made a change where
instead of calling lmb_fix_overlap_regions(), the same goal is being
achieved through lmb_resize_regions(). The current implementation of
lmb_fix_overlap_regions() only checks if the adjoining region is
overlapping, but there could be a scenario where more than one
existing regions are overlapping with what is being added. That will
get handled by calling lmb_resize_regions(). I am in the middle of
testing these changes, and will send the next version in a day or so.

>
> For what it's worth, I was able to trigger this printf with a pxe load
> at an address 0xb0b and have the kernel_addr_r at 0xb00 for example.
> What I don't understand is why
>
> 1) aside from the printf, it still booted seemingly properly
> 2) why interrupting the transfer and starting it again would not make
> those messages appear anymore

Although I have not tested this scenario, I suspect what happens is
that the region gets added during the first run, when it prints the
message. Then when the same command is run subsequently, the region
has already been added, so the condition in lmb_fix_overlap_regions()
is not hit, so no print. In any case, print or no print, the function
should be addressing the case of an encompassing overlap as well. But
like I mentioned above, a more generic fix for that would be a call to
lmb_resize_regions().

-sughosh

>
> Logically though, this patch seems to be ok if the purpose is to merge
> two regions.
>
> Thanks for looking into this,
> Quentin
