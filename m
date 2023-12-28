Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE0EC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F3A78774E;
	Thu, 28 Dec 2023 14:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hsi0DgVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA86587A29; Thu, 28 Dec 2023 14:37:19 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A60879A7
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7815fc8dd17so77614985a.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770636; x=1704375436; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHrfLwjsRKP+YEanEfeiEWJEcNMlgpGFaXT0epKq6PQ=;
 b=Hsi0DgVJlJZA7QfhrzO0KOPrVgjYRLsl8OdEtYsQUoZgvQz5HhJmxnnE6dipN28fT7
 48+ukCpYuW1b6ByMT4WuEFSOCCG8+WNYrf0vpp+m40HtK9XNFeOZbX3O8jNk6vqUAFNx
 AyMC3v21BpwG5THSyZHUg6Rd2vULWZm8vT5bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770636; x=1704375436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHrfLwjsRKP+YEanEfeiEWJEcNMlgpGFaXT0epKq6PQ=;
 b=ZafvaS1yz2fm7g21rQUVd5WIkohd8CaV6onK1gOlV4xh0NEe2089fODUettaDHUApM
 RwkkkgfWwo7bPSukNWlB6Ntc3LI/0GMs41oU83HbpKhRlMwlR/aUqiA3zvWF4xqcTEkE
 ZIvl33Pov6mJ9DtCjil+kE23ifa8ZSdi92/aG8OxFHXGqT62Cw9AOKsRzbYvlbBZ2iPL
 ckHB+Ux2h45n67k5CqszaN2C4Jd5pswDB9TZXJDipa82n2/69ZwuMVi/nxju2VMtaBtz
 oX3juJ8lLTLeMSJ9sP8N5A4eI7HocEEJf29wztp52n6OXeP8PeRGNkL2Mr7kpAVnrM8z
 1VCw==
X-Gm-Message-State: AOJu0YxukAgAacD5h9AbN+uvdotn/JIsb1t1TlPbvxGlDeRA3ZT+Xu8I
 ssL+xnyvmuiSXogQhNMz20Wr7FYdR+eMhwXNAB8/p1so2BG7
X-Google-Smtp-Source: AGHT+IFX8bZTZt9KnNjzY25rBkwozpJcFGw5+x0cpxyoN1/EYPh4Y+3t3QUS0cGJyMsc70ij1wd4DMLZGe4pECXC1vg=
X-Received: by 2002:ad4:58af:0:b0:67f:abe2:9c1d with SMTP id
 ea15-20020ad458af000000b0067fabe29c1dmr7224229qvb.87.1703770635910; Thu, 28
 Dec 2023 05:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
 <CAC_iWjKTmG=16_PZr-5TgmmPL8e4VStX3E4nLGXSxt0pJzUS3g@mail.gmail.com>
In-Reply-To: <CAC_iWjKTmG=16_PZr-5TgmmPL8e4VStX3E4nLGXSxt0pJzUS3g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:04 +0000
Message-ID: <CAFLszTi7DpEjRUcX3vaSJKRe1sBeZOWwgkGpjtoLYJ+_=_pw0g@mail.gmail.com>
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

On Thu, Dec 28, 2023 at 6:53=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 27 Dec 2023 at 19:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, Dec 27, 2023 at 6:44=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > > >
> > > > > Standard passage provides for a bloblist to be passed from one fi=
rmware
> > > > > phase to the next. That can be used to pass the devicetree along =
as well.
> > > > > Add an option to support this.
> > > > >
> > > > > Tests for this will be added as part of the Universal Payload wor=
k.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > > The discussion on this was not resolved and is now important due =
to the
> > > > > bloblist series from Raymond. So I am sending it again since I be=
lieve
> > > > > this is a better starting point than building on OF_BOARD
> > > >
> > > > I really don't like adding another option for "DT is given to us". =
Why
> > > > isn't adding another enum to fdt_source_t sufficient, and if we hav=
e
> > > > bloblist enabled, that will look for and use if found? Maybe some o=
ther
> > > > code needs to be restructured and cleaned up too?
> > >
> > > Same here. On top of that the bloblist has a few items in there, e.g =
a
> > > TPM eventlog. What are we going to do? Add a Kconfig for each item?
> >
> > No, but that is just a straw man. The DT is special and U-Boot reports
> > where it comes from.
>
> The story is identical to the EventLog. It's 'special' as well and
> U-Boot has to pick it up, otherwise the hardware and the EventLog will
> end up with different values

Why are you talking about event log? Let's stick to the topic at hand.

>
> >
> > >
> > > This has been going back and forth for a while. I've lost count of ho=
w
> > > many times I repeated the same proposal, but here it goes again. We
> > > have OF_BOARD and BLOBLIST options. The bloblist and its properties
> > > are scannable at runtime. Can't we use the combination of these 2 can
> > > be used to imply we expect things from a bloblist. If we want to be
> > > stricter in the future and explicitly expect the DT from a bloblist,
> > > we could add a Kconfig option failing the boot if that's missing.
> >
> > I would like to have that Kconfig option now, not later. In my mind,
> > the boot must be deterministic, so that if OF_BLOBLIST is enabled, the
> > DT must come from there, or it is an error.
>
> And how is what I proposed not deterministic? What prevents us from
> adding that Kconfig option now?
> The only difference is that by default, U-Boot will try bloblist ->
> board-specific method unless a Kconfig option prevents the fallback.
> I've been working with vendors and helping them implement the firmware
> handoff spec in their proprietary bootloaders and Raymond contributed
> the implementation for TF-A. At the same time, I am pretty sure
> vendors will need time to implement this properly. I don't see how
> adding an implicit Kconfig option will help them push this forward.
>
> IOW I prefer U-Boot to *always* scan for a bloblist as the first
> discovery DT method (unless the DT comes bundled with U-Boot), rather
> than expecting users to turn a Kconfig knob.

It is the 'unless the DT comes bundled with U-Boot' which I am talking
about, but I now have a better understanding of the problem here.

I don't want CONFIG_BLOBLIST to mean that the DT comes from a
bloblist. Simply put, I want to be able to use the U-Boot DT during
development, without needing to rebuild some prior stage or update
some other project. So I would like the use of bloblist to be behind
an OF_BLOBLIST option.

From Tom's email and your other reply, it seems that we could all live
with an OF_BLOBLIST option to enable DT-in-bloblist, making it
optional but default 'y'?

>
> >
> > Also, repeating it doesn't make the proposal good. We agreed that
> > OF_BOARD would eventually go away, so building on top of it is not
> > setting us up for the future.
>
> No, we didn't [0]. In fact, I said I don't see OF_BOARD *ever* going
> away. The only thing I suggested was to rename it

Well I'm just not sure what is going on. Use of bloblist should not
require board-specific code. It should be a generic mechanism, in
fdtdec_setup()

There are too many cooks in this kitchen right now, I'll try another
spin of my patch.

>
> [...]
>
> [0] https://lore.kernel.org/u-boot/CAC_iWjKrkTM4spyXpoDDartJ41a553VDE+XM5=
gz3+jsNTFqtbg@mail.gmail.com/
>

Regards,
Simon
