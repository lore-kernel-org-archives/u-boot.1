Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD75EC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA3087A37;
	Thu, 28 Dec 2023 14:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fsC9WyEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D81887A3A; Thu, 28 Dec 2023 14:58:38 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059EA8751B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e7c6e3c63so2820286e87.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703771915; x=1704376715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RntlsIPMA1khaCQN55BlrFgfoIDkHb3fP6ppWH7HNzE=;
 b=fsC9WyEh2JBOxBh7brM1Fxw8ZwTwebX9gF9jM6UsrqUYWMnXORhxuUZ/FrdY6ofvGB
 pwcDZS0ns206ciZrYjfsCEyYOBdwJ82wa9UnMjgpfhPpurRVXRRAixnQp0YY+fy9PIXi
 4OVA7aJqjxYg3SEdook39116Xsj9fysb06Q2xUdH1Y27rTiosI2k57Pu4qJLhIgdms+Q
 JO3tebKbaooYklVC+Y7XBP7YKLGPOSkXDdlkLO8AUtO8glize2YPjqtEBLRnvQvSrcqA
 qGxzKpss9AZlgDJJcdsyPgDOirjx26LQkiNq2d+03DF7tIQXvbpJx4C++4Jgc8b8XFvF
 vBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703771915; x=1704376715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RntlsIPMA1khaCQN55BlrFgfoIDkHb3fP6ppWH7HNzE=;
 b=fLlo820hcbmYs9X/Mni0l5wuJxpuNn6haGswSd93qToCrbVObhYMoxxmct7dhg0bUr
 ois9UTY7jxBGKnGc9w28YJGgN7xfrJdDCglz8jmplnCUbGsJtnTpNNN/Osidkn0m2w5L
 KSs1KOXqXe1Qi3G6nBZYm1qYCg/mKN5xl0h0Y1aR5LFf9KqlMcXFSlkR/74AXWLACwRY
 XxYHe/1u3pwC9ssFS5kEOvTFyKN5UMrKMh2xJIMoh4kCKVRE5Tj4VA0hcZU03NNOqto4
 C/u3FFh7kyCaprAHWFaj590NUAm6bg3vxaqUPkfYlU4o4ilfVlu7XZi/PTCjKppEcOrv
 4TpA==
X-Gm-Message-State: AOJu0YzavlmGy6nwAQtVbg4Xb4XzyPiBV8Pt/u/pnJp1W2R/+1AX3mEL
 zjLYYCqCFqocvGzQfYVJ7o9AR3hROQ9CPkadZQdcCiD4qRzCgw==
X-Google-Smtp-Source: AGHT+IFRKimDV9SwIH43SiCBujGzITfSKpoxjrUzHXpYVpQGXWPGZtv6nlm0iqTsi68SKE/ytM+uLEQNqHvo3V709A0=
X-Received: by 2002:ac2:4836:0:b0:50e:7dfe:fe7c with SMTP id
 22-20020ac24836000000b0050e7dfefe7cmr1022727lft.278.1703771915093; Thu, 28
 Dec 2023 05:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
 <CAC_iWjKTmG=16_PZr-5TgmmPL8e4VStX3E4nLGXSxt0pJzUS3g@mail.gmail.com>
 <CAFLszTi7DpEjRUcX3vaSJKRe1sBeZOWwgkGpjtoLYJ+_=_pw0g@mail.gmail.com>
In-Reply-To: <CAFLszTi7DpEjRUcX3vaSJKRe1sBeZOWwgkGpjtoLYJ+_=_pw0g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 15:57:59 +0200
Message-ID: <CAC_iWjJvOxt6Lhr7phYgEb8=jk_DrJzOD+W7ZT3vQoRkosC1pw@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
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

[...]

> > > >
> > > > Same here. On top of that the bloblist has a few items in there, e.g a
> > > > TPM eventlog. What are we going to do? Add a Kconfig for each item?
> > >
> > > No, but that is just a straw man. The DT is special and U-Boot reports
> > > where it comes from.
> >
> > The story is identical to the EventLog. It's 'special' as well and
> > U-Boot has to pick it up, otherwise the hardware and the EventLog will
> > end up with different values
>
> Why are you talking about event log? Let's stick to the topic at hand.

We are. The reason I bring this up is pretty obvious. It has identical
properties to the DT, and I *dont* want a Kconfig option to enable or
disable it.

>
> >
> > >
> > > >
> > > > This has been going back and forth for a while. I've lost count of how
> > > > many times I repeated the same proposal, but here it goes again. We
> > > > have OF_BOARD and BLOBLIST options. The bloblist and its properties
> > > > are scannable at runtime. Can't we use the combination of these 2 can
> > > > be used to imply we expect things from a bloblist. If we want to be
> > > > stricter in the future and explicitly expect the DT from a bloblist,
> > > > we could add a Kconfig option failing the boot if that's missing.
> > >
> > > I would like to have that Kconfig option now, not later. In my mind,
> > > the boot must be deterministic, so that if OF_BLOBLIST is enabled, the
> > > DT must come from there, or it is an error.
> >
> > And how is what I proposed not deterministic? What prevents us from
> > adding that Kconfig option now?
> > The only difference is that by default, U-Boot will try bloblist ->
> > board-specific method unless a Kconfig option prevents the fallback.
> > I've been working with vendors and helping them implement the firmware
> > handoff spec in their proprietary bootloaders and Raymond contributed
> > the implementation for TF-A. At the same time, I am pretty sure
> > vendors will need time to implement this properly. I don't see how
> > adding an implicit Kconfig option will help them push this forward.
> >
> > IOW I prefer U-Boot to *always* scan for a bloblist as the first
> > discovery DT method (unless the DT comes bundled with U-Boot), rather
> > than expecting users to turn a Kconfig knob.
>
> It is the 'unless the DT comes bundled with U-Boot' which I am talking
> about, but I now have a better understanding of the problem here.
>
> I don't want CONFIG_BLOBLIST to mean that the DT comes from a
> bloblist.

But it doesn't mean that. It means 'try to scan the bloblist for a DT first'.

> Simply put, I want to be able to use the U-Boot DT during
> development, without needing to rebuild some prior stage or update
> some other project. So I would like the use of bloblist to be behind
> an OF_BLOBLIST option.

That's easy instead of OF_BOARD use OF_EMBED or OF_SEPARATE?

>
> From Tom's email and your other reply, it seems that we could all live
> with an OF_BLOBLIST option to enable DT-in-bloblist, making it
> optional but default 'y'?
>
> >
> > >
> > > Also, repeating it doesn't make the proposal good. We agreed that
> > > OF_BOARD would eventually go away, so building on top of it is not
> > > setting us up for the future.
> >
> > No, we didn't [0]. In fact, I said I don't see OF_BOARD *ever* going
> > away. The only thing I suggested was to rename it
>
> Well I'm just not sure what is going on. Use of bloblist should not
> require board-specific code. It should be a generic mechanism, in
> fdtdec_setup()

It doesn't, we never asked for that. There's even code in a previous
iteration from me showing exactly what I had in mind. We always said
scan for a bloblist if OF_BOARD is selected, in priority, and if you
don't find a DT try a board-specific method (and add a Kconfig option
to fail the boot if required).

>
> There are too many cooks in this kitchen right now, I'll try another
> spin of my patch.

I really don't like another OF_XXXXXXX for determining where the DT
comes from, but I've explained my opinion way too many times.  I'll
let you and Tom decide on this

Thanks
/Ilias
>
> >
> > [...]
> >
> > [0] https://lore.kernel.org/u-boot/CAC_iWjKrkTM4spyXpoDDartJ41a553VDE+XM5gz3+jsNTFqtbg@mail.gmail.com/
> >
>
> Regards,
> Simon
