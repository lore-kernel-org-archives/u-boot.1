Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62542C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 18:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D8488791;
	Mon, 29 Jul 2024 20:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jSpFvRmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70A7B87BF4; Mon, 29 Jul 2024 20:06:00 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9E488791
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a156556fb4so5988872a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722276357; x=1722881157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vIC8K9emuJ4rM7l2Dp3IQw7KqdqSxQk7+u7Kminrf7I=;
 b=jSpFvRmtUe8aI5KOO4eudLEmwzUseYdHLcUPfZ+xV1SF2WV9dvBcgNRhVWWVP5cO3c
 5bM0WxSbtHobwvZJWP9EO0UBa/sv0LATpxyTKea6378uLKNvzcAp9tp6zQexwsH9J5Ei
 Gga28Pn3hKNz1IZzzrfsS76aBSxtCfAJkpr7cmSwk1j9ejeKElVnHtATTQ33+8LPCHy/
 PmL8ptg7AtmUVQRCIXeX0fOnRpBSmHXbuHdC8nJcyrDeOLFIXJSdtyGt5TIKlywWjcbC
 dwR7gbbInZvMcQ0rWcNvg1agiCAuqWg9iqGVMMhwq/7o4Q5rwtkWjbzO29owv+5vsKlE
 eihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722276357; x=1722881157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vIC8K9emuJ4rM7l2Dp3IQw7KqdqSxQk7+u7Kminrf7I=;
 b=NuFzLeaPMhNL2OWhkgxxR8OM32Di68+G3IjjKAPWdFZeSfsXbOJE/C6IAxs0G1aMNO
 5JRH4TCgrEWbciWpN9vpCX9J8J2hFw1me2D17u0JPrnw0IYXw7kcArb0+/T0ZcisEisS
 o3Zn4ijQKxZcckrqltk9tshpd1aRNkqcxdMfe00YyGDwcrrkSHdTRcRGTe/qHiVzPkGz
 6f137O/Eu7aZFpwTQ4M5TIrdeNSks4z049va2HxLEyZ3vWGWpgIBa25SBRKgIvzDrLIM
 wl2j+G4vO3sXwGpveaJz985TLe3l8FXlLD9egGUlEnzOsiEP1cpbf8klB0/0sla3TZ1w
 zv0Q==
X-Gm-Message-State: AOJu0YyVMwALMesi+0YHuB07i4YRgLVGiRTTFhI7Eoofl+r8hPrSQ9Pt
 zy4wk+iUIW0vTs1X/H/7xyCrQtvOHz9hhco1sAHLApgDnjZZG43Fp4rC7hqzWmoAgpkf2wYqsTv
 x+dpTZpiNBnf03XO0mwuTSTEbdOIFGaT4taoKHw==
X-Google-Smtp-Source: AGHT+IFpbFrGgsdJ92793BxAdYtNS23OFWLdg6FCY6SoSYVt22rpGirVVNTBB1O859DJsJaO1unvtAIAkA0FFHuQ45A=
X-Received: by 2002:a50:ab11:0:b0:57d:2659:9141 with SMTP id
 4fb4d7f45d1cf-5b022003c65mr5177502a12.24.1722276357167; Mon, 29 Jul 2024
 11:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-7-sughosh.ganu@linaro.org>
 <CAFLszTgwmQTwRzBuOJvh-=qBGuq+5fRc6vxBptqgQuJyHyuP6w@mail.gmail.com>
In-Reply-To: <CAFLszTgwmQTwRzBuOJvh-=qBGuq+5fRc6vxBptqgQuJyHyuP6w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 23:35:46 +0530
Message-ID: <CADg8p94zPZVFq3Snus8EPT58xPK1AXiNk227uqOstNtZ0NWx1g@mail.gmail.com>
Subject: Re: [PATCH 06/40] alist: add a couple of helper functions
To: Simon Glass <sjg@chromium.org>
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

On Fri, 26 Jul 2024 at 05:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add a couple of helper functions to detect an empty and full alist.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >  include/alist.h | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
>
> I had to hunt around to see why these are needed. It's fine to add new
> functions to the API, but in this case I want to make a few points.
>
> >
> > diff --git a/include/alist.h b/include/alist.h
> > index 6cc3161dcd..06ae137102 100644
> > --- a/include/alist.h
> > +++ b/include/alist.h
> > @@ -82,6 +82,28 @@ static inline bool alist_err(struct alist *lst)
> >         return lst->flags & ALISTF_FAIL;
> >  }
> >
> > +/**
> > + * alist_full() - Check if the alist is full
> > + *
> > + * @lst: List to check
> > + * Return: true if full, false otherwise
> > + */
> > +static inline bool alist_full(struct alist *lst)
> > +{
> > +       return lst->count == lst->alloc;
> > +}
>
> In general I see you manually modifying the members of the alist,
> rather than using the API to add a new item. I think it is better to
> use the API.
>
> struct lmb_region rgn;
>
> rgn.base = ...
> rgn.size = ...
> rgn.flags = ...
> if (!alist_add(&lmb.used, rgn. struct lmb_region))
>    return -ENOMEM;

Yes, I had seen this usage of the API in another of your patch.
However, my personal opinion of the API's is that alist_expand_by()
gives more clarity on what the function is doing. One gets a feeling
that alist_add() is only adding the given node to the list, whereas it
is doing a lot more under the hood. I feel that using the
alist_expand_by() API makes the code much easier to understand, but
that's my personal opinion.

>
> or you could make a function to add a new region to a list, with base,
> size & flags as args.
>
> > +
> > +/**
> > + * alist_empty() - Check if the alist is empty
> > + *
> > + * @lst: List to check
> > + * Return: true if empty, false otherwise
> > + */
> > +static inline bool alist_empty(struct alist *lst)
> > +{
> > +       return !lst->count && lst->alloc;
> > +}
>
> I would argue that this is a surprising definition of 'empty'. Why the
> second term? It seems to be because you want to know if it is safe to
> set values in item[0]. But see above for how to use the API.

I want the initialisation of the list to be kept separate from adding
more 'nodes' to the list. Hence my usage.

-sughosh

>
> > +
> >  /**
> >   * alist_get_ptr() - Get the value of a pointer
> >   *
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
