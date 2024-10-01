Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34502CE7D05
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 10:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0AF8910B;
	Tue,  1 Oct 2024 12:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BpxyEk9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23CD89184; Tue,  1 Oct 2024 12:01:15 +0200 (CEST)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D5B88B1F
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 12:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 042474000C;
 Tue,  1 Oct 2024 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1727776872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQ+8zDbhxauG3Ubk6n1trLCZslz9fKrmEUCaOYMA3ok=;
 b=BpxyEk9aTh6RpwNW7Dc6G1877z0AMFmFMqr1Kx4lYD/uvQuavz2kIv5v6rp/MkmG0E2Ox/
 JuKwfnwBND9dv5mnDSPC0Vyfvv7lw+Vrmmuu7Uy87uKgG+ay56wZjC+ZefvD7PHDKE2yTa
 /1wseGZJq0fS2JoGUo0eZLSJHBsthIpy8PYC7s9YvUof9jIguDxHGUCpuRwIk4IsWNMwp7
 PiaRbVwxo2nMCSh6yEoelbZQOG99CtLHifpKQn6fyt43WRzQ2Mbo/wwU/hkIT4RIgodZ2V
 pqF68KN5mVKyby7+rEac+B6YOFHnskkjCW/9JZTdzfN2N/mHUrR0Me64FLFe/w==
Date: Tue, 1 Oct 2024 12:01:11 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: hs@denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 linux-amarula@amarulasolutions.com, Ye Li <ye.li@nxp.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
Message-ID: <20241001120111.181be2a4@xps-13>
In-Reply-To: <CAOf5uwkw-NcSq6NDROsUJVfCTdYZcshxFyUJRW9Q-f1wcKmz=w@mail.gmail.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
 <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
 <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
 <ebb734bd-bdf7-ffd2-d676-7eb6011466a3@denx.de>
 <CAOf5uwm13jyOb0M9Xvx_bO1RpXhDcWqKBC-4fhZGo61Q5cjnjw@mail.gmail.com>
 <3cb57821-30f0-6aa0-2dec-313381b1350a@denx.de>
 <9ce14505-6c37-f2e8-4b5d-44f1a55f0393@denx.de>
 <20241001102908.39b2d3a6@xps-13>
 <CAOf5uwn8vhozjtMqXmWL=3Jaf05UhV7cnGn15Ywj07-PmwW_9w@mail.gmail.com>
 <20241001105057.2992e124@xps-13>
 <a91171dd-a2f2-8df7-5b11-4a35a227ef2e@denx.de>
 <CAOf5uwkw-NcSq6NDROsUJVfCTdYZcshxFyUJRW9Q-f1wcKmz=w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Michael,

> > >>>> Ported the patch from patchset
> > >>>>
> > >>>> "[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PL=
L3 as enabled"
> > >>>>
> > >>>> to imx8mp [2] and fec ethernet works again for me on imx8mp!
> > >>>>
> > >>>> Could you add this if you post a v2 ? =20
> > >>>
> > >>> TBH I don't feel like the below change is the correct one, it is too
> > >>> specific. The clock core is recursive and thus should handle the
> > >>> reparenting situations gracefully.
> > >>>
> > >>> I posted a series that is targeting the LVDS output on imx8mp. You
> > >>> should probably consider checking these patches as well if you work
> > >>> on imx8mp as well. I also had similar breakages with Ethernet which
> > >>> happened during the assigned-clocks handling. This patch, which is =
more
> > >>> future and platform agnostic, fixed it:
> > >>>
> > >>> https://lore.kernel.org/u-boot/20240910101344.110633-3-miquel.rayna=
l@bootlin.com/
> > >>> =20
> > >>
> > >> The clock patches are not specific at all. You need to have it worki=
ng
> > >> for the parent for each component. =20
> > >
> > > The diff shown by Heiko is explicitly enabling PLLs by naming them in
> > > the iMX driver. This is not the correct approach. The problem of
> > > having non-enabled new parents is global. Parent clocks should be
> > > enabled before changing muxes, and this should be enforced
> > > by the clock core/uclass, not the SoC drivers. =20
> >
> > Okay, valid argument.
> > =20
> > > =20
> > >> This is a standard way to do it and nothing magic compared to other
> > >> implementations. =20
> > >
> > > No, naming PLLs explicitly is not the correct approach.
> > > =20
> > >> I don't see
> > >> in your series any addressing or reparent clock or take in account
> > >> that a clock should be enable before
> > >> reparenting. =20
> > >
> > > That's exactly the link above, whose diff is pasted here for referenc=
e:
> > >
> > > @@ -595,6 +595,10 @@ int clk_set_parent(struct clk *clk, struct clk *=
parent)
> > >       if (!ops->set_parent)
> > >               return -ENOSYS;
> > >
> > > +     ret =3D clk_enable(parent);
> > > +     if (ret)
> > > +             return ret; =20
> >
> > As I said before, I had *exact* the same patch and thought I made a big
> > hack :-P
> >
> > But I wonder ... if this a generic "problem", why nobody had yet proble=
ms
> > with it... =20
>=20
> I think that a generic approach that takes into account the reparent
> is more valuable, then
> this.

I'm sorry I don't fully understand your answer. I assume you agree with
the generic approach quoted above.

> If a clock is enabled by another stage and we don't aware about
> it we need to mark
> as enabled.

clk_enable() already handles this kind of situation.

> I think that this force of enable it's just a short path
> that does not solve the generic
> problem.

What "force of enable"? The parent needs to be enabled before we use it
as parent. The logic is always the same:
- clk_enable() the new parent
- change the parent
- clk_disable() the old parent
I don't see any short path here.

> I really tried to abstract what is really implemented in
> other OS on the same topic.

FYI, Linux does the clk_enable(parent) like above.

Thanks,
Miqu=C3=A8l
