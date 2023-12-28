Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7B1C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CEB87A83;
	Thu, 28 Dec 2023 16:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YJB2YGFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715B587A70; Thu, 28 Dec 2023 16:09:52 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02819879E5
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-781716c1291so52834885a.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703776189; x=1704380989; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxycsKHMm8NmNewRzZQ+YJlXWMv6Vht8LkKFhHHm9hE=;
 b=YJB2YGFKspyfmD70PHk7qyi5rYaBQzMTKg7Kg6HAUFKBuhKnPuQNQrKGApimF/tFIw
 3kgUDFBwAMbr6nz3nOKR3jTY41O8Z51EqYoGZ8ofoYetL/1grvx9TqS/I5f13hhZstbU
 qBhFC5JwjHenic7ROz/WhCtEIejB315jAfy88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703776189; x=1704380989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxycsKHMm8NmNewRzZQ+YJlXWMv6Vht8LkKFhHHm9hE=;
 b=Z891FzSA7ayIVA9kpU3AhjrU/OrmpMZ9FyJfuVr9fmD4LVaKccks+X+S6b7ZizBucx
 VKfqL48M0+KEN7/NKSBBix7P9Gw2+99eKJMIsdh7bphWObezE7Swn+xkaFv9IY06sw5b
 mQ5Tt/NgChBKTBamXICvoQg4ciNV7WrFfZoL1iq5LnxhLKrhztpdEJTTVHl112DD/Fy6
 5W9GJP93WbEvpQNOEr9qHQ7K63L5ibWtFpFiELH/F9Fxx/aNs2R3w/Pu4B26qCZFMN0d
 EgCmpP4wdFlHRz3NpCEiWxQ78pofaOYwQk2nuR900witSGsqQjyvj8x+yA49JBMYI3FB
 5SZA==
X-Gm-Message-State: AOJu0Ywr1/4YaSJNgDComeXAz7Fc0mv1YnG6SZXna/rKsZ0ryg+aXrxp
 vT3uwZ4vFAjsJi+Ui3TJu7KbKc51ERutkV3zl7VJ/DmbNZU0
X-Google-Smtp-Source: AGHT+IELoqTiT/FfPGcdCbBkWKsClGVvYYheDLjxR3uutmFxWUmrQnDCm47WE1oHrjEb5AmTVWwKpEwiZTAf7ECuPFQ=
X-Received: by 2002:ad4:5c8c:0:b0:67a:a5ca:e3f5 with SMTP id
 o12-20020ad45c8c000000b0067aa5cae3f5mr17319785qvh.5.1703776188780; Thu, 28
 Dec 2023 07:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
 <CAC_iWjKTmG=16_PZr-5TgmmPL8e4VStX3E4nLGXSxt0pJzUS3g@mail.gmail.com>
 <CAFLszTi7DpEjRUcX3vaSJKRe1sBeZOWwgkGpjtoLYJ+_=_pw0g@mail.gmail.com>
 <CAC_iWjJvOxt6Lhr7phYgEb8=jk_DrJzOD+W7ZT3vQoRkosC1pw@mail.gmail.com>
In-Reply-To: <CAC_iWjJvOxt6Lhr7phYgEb8=jk_DrJzOD+W7ZT3vQoRkosC1pw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 15:09:37 +0000
Message-ID: <CAFLszThXAYNt=MBgP90hMfA8N5uSoaW1GwfTqnuKAQDfM9g52g@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ilias,

On Thu, Dec 28, 2023 at 1:58=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > >
> > > > > Same here. On top of that the bloblist has a few items in there, =
e.g a
> > > > > TPM eventlog. What are we going to do? Add a Kconfig for each ite=
m?
> > > >
> > > > No, but that is just a straw man. The DT is special and U-Boot repo=
rts
> > > > where it comes from.
> > >
> > > The story is identical to the EventLog. It's 'special' as well and
> > > U-Boot has to pick it up, otherwise the hardware and the EventLog wil=
l
> > > end up with different values
> >
> > Why are you talking about event log? Let's stick to the topic at hand.
>
> We are. The reason I bring this up is pretty obvious. It has identical
> properties to the DT, and I *dont* want a Kconfig option to enable or
> disable it.

It is completely different to the devicetree. I don't even know how to
respond to this, or what properties might be common between a
devicetree and a TPL log.

>
> >
> > >
> > > >
> > > > >
> > > > > This has been going back and forth for a while. I've lost count o=
f how
> > > > > many times I repeated the same proposal, but here it goes again. =
We
> > > > > have OF_BOARD and BLOBLIST options. The bloblist and its properti=
es
> > > > > are scannable at runtime. Can't we use the combination of these 2=
 can
> > > > > be used to imply we expect things from a bloblist. If we want to =
be
> > > > > stricter in the future and explicitly expect the DT from a blobli=
st,
> > > > > we could add a Kconfig option failing the boot if that's missing.
> > > >
> > > > I would like to have that Kconfig option now, not later. In my mind=
,
> > > > the boot must be deterministic, so that if OF_BLOBLIST is enabled, =
the
> > > > DT must come from there, or it is an error.
> > >
> > > And how is what I proposed not deterministic? What prevents us from
> > > adding that Kconfig option now?
> > > The only difference is that by default, U-Boot will try bloblist ->
> > > board-specific method unless a Kconfig option prevents the fallback.
> > > I've been working with vendors and helping them implement the firmwar=
e
> > > handoff spec in their proprietary bootloaders and Raymond contributed
> > > the implementation for TF-A. At the same time, I am pretty sure
> > > vendors will need time to implement this properly. I don't see how
> > > adding an implicit Kconfig option will help them push this forward.
> > >
> > > IOW I prefer U-Boot to *always* scan for a bloblist as the first
> > > discovery DT method (unless the DT comes bundled with U-Boot), rather
> > > than expecting users to turn a Kconfig knob.
> >
> > It is the 'unless the DT comes bundled with U-Boot' which I am talking
> > about, but I now have a better understanding of the problem here.
> >
> > I don't want CONFIG_BLOBLIST to mean that the DT comes from a
> > bloblist.
>
> But it doesn't mean that. It means 'try to scan the bloblist for a DT fir=
st'.

I'm OK with that and it is how the v5 patch works.

>
> > Simply put, I want to be able to use the U-Boot DT during
> > development, without needing to rebuild some prior stage or update
> > some other project. So I would like the use of bloblist to be behind
> > an OF_BLOBLIST option.
>
> That's easy instead of OF_BOARD use OF_EMBED or OF_SEPARATE?

OF_EMBED doesn't help - things have moved on a lot from those days (e.g. Bi=
nman)
OF_SEPARATE is already enabled

>
> >
> > From Tom's email and your other reply, it seems that we could all live
> > with an OF_BLOBLIST option to enable DT-in-bloblist, making it
> > optional but default 'y'?
> >
> > >
> > > >
> > > > Also, repeating it doesn't make the proposal good. We agreed that
> > > > OF_BOARD would eventually go away, so building on top of it is not
> > > > setting us up for the future.
> > >
> > > No, we didn't [0]. In fact, I said I don't see OF_BOARD *ever* going
> > > away. The only thing I suggested was to rename it
> >
> > Well I'm just not sure what is going on. Use of bloblist should not
> > require board-specific code. It should be a generic mechanism, in
> > fdtdec_setup()
>
> It doesn't, we never asked for that. There's even code in a previous
> iteration from me showing exactly what I had in mind. We always said
> scan for a bloblist if OF_BOARD is selected, in priority, and if you
> don't find a DT try a board-specific method (and add a Kconfig option
> to fail the boot if required).
>
> >
> > There are too many cooks in this kitchen right now, I'll try another
> > spin of my patch.
>
> I really don't like another OF_XXXXXXX for determining where the DT
> comes from, but I've explained my opinion way too many times.  I'll
> let you and Tom decide on this

I sent a v5 patch which I believe provides what we both want, so PTAL.

[..]


> > > [0] https://lore.kernel.org/u-boot/CAC_iWjKrkTM4spyXpoDDartJ41a553VDE=
+XM5gz3+jsNTFqtbg@mail.gmail.com/

Regards,
Simon
