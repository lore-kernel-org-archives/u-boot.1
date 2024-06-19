Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146C1C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6FB881C6;
	Wed, 19 Jun 2024 14:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X5UBByKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86935882DC; Wed, 19 Jun 2024 14:41:38 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1A387E06
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57a30dbdb7fso11254562a12.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718800896; x=1719405696; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RjLSe6WCDu9mH507nKc01DVdBtopVAkJONTmdZ5oFS8=;
 b=X5UBByKt+DPFlv76UBWdhho8HOiTxV1DSzFTzu3bv0lZarc534NUmV9IxT4nD65N0N
 b3upXoO62Z77rvyFCS2JQk3BkDeZPLHeywDhnmfiiRF1zFeRvzcB77bMFlNbhgi50MYu
 O7/obhbOL4q5rsIlQ84VpGP1dEkhiHieYpJ7+ABqfIBidZS8PDDGZDF65FyuJiJKCrmb
 AFOkwimJ7vHp4wsjlUrxplbuPqm9bZq6hbEkyAoibNMmLBXnqOp0P/GNSb6mlKfHWWi/
 neWV73v8DGl0/KruL36JUJ+WMGaHnadgU//5Rh4+4gcXzUxe+CTJFuXvgtEZhGA6DnIz
 wncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718800896; x=1719405696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjLSe6WCDu9mH507nKc01DVdBtopVAkJONTmdZ5oFS8=;
 b=apHWF0NPltvhcv5bVjKwvRnWdMiKYPCDN36E0bYmLbSC70kDxJKgssN2PDYOQwC43c
 75aZg/qiWh+uDRtNwWiV9Q7LXfTLQZspL7gG5v2Wn1Y13D5pcchThA9shNV5Vc5HILcO
 En1oJfSvu6mKlESdS2MF+qWc/kKZkegqKHioR1ZanE5bWCq6eoTgbVVSzRNcGwdt97hY
 6Wvl3JQfWLbFm48PhfMYAXyVTfBgW2LV4XSDJpKJSWm8He5U5jL0NesKc+DRZpKPZ7ca
 Q0ohs+wZzoW4NQSc9bPWLygf/Xv7HWqWCWMmEyil9dxixpCC08i5ofkLbTBKrvvBnpW3
 edyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2dmcpE1uD7YekJp+pyD8Cmg1RbyQt6dWDTDo/jp/zcED4NgLTZezJ7LIutnzfy3yVlrlSZeRthhy74bnHTbgnkCUhIQ==
X-Gm-Message-State: AOJu0YxFL/pYfkwpc4V9RqoijCSQAxC7Vqn/WChRaFKmAQ/3xWaaZKXf
 tb3xND3qZhIYVH4+hIHSS7lXHJatcSeERnyYnFUNvHF+DNNdDtYzRP3a/sC4C0s=
X-Google-Smtp-Source: AGHT+IHncANyxkdxws+YIhmLPfgRlbsDv8qLVVeXK2NqVyVDPwvOChPEaEP1HipvijM0gxdDcOv3LQ==
X-Received: by 2002:a50:d5d0:0:b0:57c:61a3:546 with SMTP id
 4fb4d7f45d1cf-57d07e6d185mr1799836a12.21.1718800895639; 
 Wed, 19 Jun 2024 05:41:35 -0700 (PDT)
Received: from hera (ppp046103020130.access.hol.gr. [46.103.20.130])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb743ade6sm8338448a12.95.2024.06.19.05.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 05:41:35 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:41:32 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
Message-ID: <ZnLR_NnJY3hFBXcR@hera>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
 <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
 <CAC_iWj+M5uw1qaVcUFZpXDArdbF3jfJDXk1HiA1i4S2eEYbEig@mail.gmail.com>
 <CAFLszTgeKggZYaTRnH9xB7Uznf0=OS42aogg-rym7cp=QRjw+A@mail.gmail.com>
 <CAC_iWj+Y+hXwjgcVaMdEYrE_G9XuuhiZQnp2ckCYNkzYPZN3tQ@mail.gmail.com>
 <CAFLszThK_FnLxWrSzax_Jm7XMmmTanTmGrLjK3MfCM0uqKsNOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThK_FnLxWrSzax_Jm7XMmmTanTmGrLjK3MfCM0uqKsNOw@mail.gmail.com>
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

Hi Simon,

On Wed, Jun 12, 2024 at 02:24:31PM -0600, Simon Glass wrote:
> Hi Ilias,
>
> On Wed, 12 Jun 2024 at 00:02, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > [...]
> >
> > > > > >> ---
> > > > > >>
> > > > > >>  lib/fdtdec.c | 12 ++++++++++--
> > > > > >>  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > >>
> > > > > >> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > > >> index b2c59ab3818..b141244e3b9 100644
> > > > > >> --- a/lib/fdtdec.c
> > > > > >> +++ b/lib/fdtdec.c
> > > > > >> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
> > > > > >>  {
> > > > > >>         int ret = -ENOENT;
> > > > > >>
> > > > > >> -       /* If allowing a bloblist, check that first */
> > > > > >> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> > > > > >> +       /*
> > > > > >> +        * If allowing a bloblist, check that first. This would be better
> > > > > >> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> > > > > >> +        * argument, so add a hack here, used e.g. by chromebook_coral
> > > > > >
> > > > > > I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
> > > > > > but actually you are using it below. Is it a typo?
> > > > >
> > > > > Basically it would be cleaner to have a separate, phase-specific
> > > > > Kconfig control as to whether the DT can come from the bloblist (I
> > > > > can't remember the Kconfig name I suggested, nor the patch as it was
> > > > > last year sometime). But for now I am adding this hack to get a few
> > > > > boards working again.
> > > >
> > > > I am a bit confused.
> > > > First of all the comment is innapropriate. We went through a lengthy
> > > > discussion on BLOBLIST/OF_BLOSLIST etc and,  even Tom chimed in and we
> > > > made up our minds. Why are you adding this comment now? Why do code
> > > > comments have to illustrate your personal opinion -- which was
> > > > rejected?
> > >
> > > I'm sorry for the tone of the comment. I am not trying to offend
> > > anyone here and I'm happy to change the language.
> >
> > Yes please a comment explaining why that piece of code is there is far
> > more intuitive.
>
> OK, once we have agreed the below I can do that.
>
> >
> > >  As I probably
> > > mentioned at the time, my accepted patch breaks my workflow and
> > > several boards. I hope you can understand how frustrating that sort of
> > > thing can be.
> >
> > Yes, I do and I am fine with a short-term patch that fixes issues, as
> > long as its not too intrusive. There is a very thin line between quick
> > and dirty fixes to spaghetti unreadable code. But we should have
> > comments and/or commit messages indicating that this needs a proper
> > fix
>
> I spent a lot of time explaining this last time.
>
> >
> > > Also, now that I have my lab back up and running and I
> > > would like these boards to work again on mainline!
> > >
> > > >
> > > > Grepping for OF_BLOBLIST, I can't find any matches, so is the above if a typo?
> > >
> > > Remember, it was a patch you rejected :-)
> >
> > I don't maintain any of that. I only gave some feedback along the
> > lines of "bloblist was designed to be auto-discoverable, I don't see
> > how adding an explicit Kconfig helps". IIRC we eventually followed
> > what Tom suggested.
>
> I'm not trying to point the finger here. So far the boards are broken
> in mainline...I'm just trying to fix that,
>
> >
> > In any case, the amount of bike-shedding in the topic is too much. Do
> > you mind explaining the problem in your workflow again? Perhaps we can
> > find a solution that is integrated in bloblist_maybe_init() instead of
> > injecting ifs on when a bloblist should or should not be searched for
> > all over the place.
>
> TPL (or SPL) sets up a bloblist with bits of info in it, but no DT
> (which is in memory-mapped SPI flash)
> U-Boot proper starts up, it wants to get the bloblist but not hang if
> the bloblist doesn't have a DT

Sure, that's reasonable and IIRC that's the design we agreed a while back.
Looking at the code, if the DT isn't found in a bloblist and the feature is
enabled, we don't crash. We just print a debug message and continue to find
the DT as we used. Why do we have to skip the call to
bloblist_maybe_init()?

Thanks
/Ilias

>
> Regards,
> Simon
