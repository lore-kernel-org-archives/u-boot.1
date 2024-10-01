Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0A9CE8374
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213C888D5C;
	Tue,  1 Oct 2024 15:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZZ+JgxAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460E2891A6; Tue,  1 Oct 2024 15:03:12 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78A788D5C
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 15:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fac47f0b1aso29424201fa.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727787789; x=1728392589;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAASV4yzlnu9kqn+Dc8qpk1+N6GkzQ+YGpBXJwGk+z8=;
 b=ZZ+JgxAYQe6m6xPYd3lD8dE6+iXdK0csoiDXowPbByWrkCkVh7p3wRfT1xd11ScOAk
 z6dU+gOkbgzqq2Tiqs3bj8193StAFO3VTMwEWQu+27NryjhcEOMautHLiBwXSkxRzdzC
 9h+RytKEhBLnWq6n+NRtYuqIPBRqEucaOb0hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727787789; x=1728392589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAASV4yzlnu9kqn+Dc8qpk1+N6GkzQ+YGpBXJwGk+z8=;
 b=GMibXEDPqNZf9l6sZHl4HyLFAGjazrhPyvsY4w3ao2rPjwFGkHhNcatBmWH6AKlAYN
 h9qqxw5/dYSUv1j0S8m1h0q6dxVfbK9qUDKq402AGHONGdG4Dj9lcUap6Cvf7hUP7ogn
 X7r0mFPs27QFvCaLELPoyzi37pAci4ft81x7c3J1oh1+DOtOMy21+0IjZbsyrpL0OUt1
 YA1N1bKo8G8rwoZ2bt5vT1cSNnKkhSV+I+gDqyD/x+8CLB+faTZr5fgN1464l9eIJFji
 RL9dyrF5crZMlEon3/i2KRY4jJbRyr9FyepjLcIxLqQ/mA8a5qbbPY9+a6qWhqp4j3Xf
 S/SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAxXdNmSQmaxdK6/C+ME/tjrOaDSL0oWcCBvPNzBiaeVTPTuc7HkXSmlBmeDVf8u8wYso6Pg0=@lists.denx.de
X-Gm-Message-State: AOJu0YzqE1a8VkRPUAxBQGIUgtletFTnYb933stskNjSoJyOz7MZT2uK
 Urts+DOUo17FjrGhMISlDwhpW0rbdlHKbwb/QdlLknX9R2kr1aj69W4RdCdhYGDVmL8qiSc48rM
 gMaLpdJH2VHnJxGXb4BNm6kPpGUzkxFh0Qc7mYw==
X-Google-Smtp-Source: AGHT+IG12EYuNy9qScx+zfCxwvJCgb9fkn9tML6UURwsWLtfxr6TP0C1NJ09Yo8kMXYDL9eBP0O+5NkwCqMDOBTInIM=
X-Received: by 2002:a2e:bc0a:0:b0:2fa:d296:6fc6 with SMTP id
 38308e7fff4ca-2fad29673e4mr32660141fa.13.1727787787551; Tue, 01 Oct 2024
 06:03:07 -0700 (PDT)
MIME-Version: 1.0
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
 <20241001120111.181be2a4@xps-13>
In-Reply-To: <20241001120111.181be2a4@xps-13>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 1 Oct 2024 15:02:56 +0200
Message-ID: <CAOf5uw=jQEtQUGWzd40shLidcMNfkTsPjSbCQ7L=MJdBUTUbTw@mail.gmail.com>
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: hs@denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com, 
 Ye Li <ye.li@nxp.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

Hi

On Tue, Oct 1, 2024 at 12:01=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Michael,
>
> > > >>>> Ported the patch from patchset
> > > >>>>
> > > >>>> "[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_=
PLL3 as enabled"
> > > >>>>
> > > >>>> to imx8mp [2] and fec ethernet works again for me on imx8mp!
> > > >>>>
> > > >>>> Could you add this if you post a v2 ?
> > > >>>
> > > >>> TBH I don't feel like the below change is the correct one, it is =
too
> > > >>> specific. The clock core is recursive and thus should handle the
> > > >>> reparenting situations gracefully.
> > > >>>
> > > >>> I posted a series that is targeting the LVDS output on imx8mp. Yo=
u
> > > >>> should probably consider checking these patches as well if you wo=
rk
> > > >>> on imx8mp as well. I also had similar breakages with Ethernet whi=
ch
> > > >>> happened during the assigned-clocks handling. This patch, which i=
s more
> > > >>> future and platform agnostic, fixed it:
> > > >>>
> > > >>> https://lore.kernel.org/u-boot/20240910101344.110633-3-miquel.ray=
nal@bootlin.com/
> > > >>>
> > > >>
> > > >> The clock patches are not specific at all. You need to have it wor=
king
> > > >> for the parent for each component.
> > > >
> > > > The diff shown by Heiko is explicitly enabling PLLs by naming them =
in
> > > > the iMX driver. This is not the correct approach. The problem of
> > > > having non-enabled new parents is global. Parent clocks should be
> > > > enabled before changing muxes, and this should be enforced
> > > > by the clock core/uclass, not the SoC drivers.
> > >
> > > Okay, valid argument.
> > >
> > > >
> > > >> This is a standard way to do it and nothing magic compared to othe=
r
> > > >> implementations.
> > > >
> > > > No, naming PLLs explicitly is not the correct approach.
> > > >
> > > >> I don't see
> > > >> in your series any addressing or reparent clock or take in account
> > > >> that a clock should be enable before
> > > >> reparenting.
> > > >
> > > > That's exactly the link above, whose diff is pasted here for refere=
nce:
> > > >
> > > > @@ -595,6 +595,10 @@ int clk_set_parent(struct clk *clk, struct clk=
 *parent)
> > > >       if (!ops->set_parent)
> > > >               return -ENOSYS;
> > > >
> > > > +     ret =3D clk_enable(parent);
> > > > +     if (ret)
> > > > +             return ret;
> > >
> > > As I said before, I had *exact* the same patch and thought I made a b=
ig
> > > hack :-P
> > >
> > > But I wonder ... if this a generic "problem", why nobody had yet prob=
lems
> > > with it...
> >
> > I think that a generic approach that takes into account the reparent
> > is more valuable, then
> > this.
>
> I'm sorry I don't fully understand your answer. I assume you agree with
> the generic approach quoted above.
>
> > If a clock is enabled by another stage and we don't aware about
> > it we need to mark
> > as enabled.
>
> clk_enable() already handles this kind of situation.
>
> > I think that this force of enable it's just a short path
> > that does not solve the generic
> > problem.
>
> What "force of enable"? The parent needs to be enabled before we use it
> as parent. The logic is always the same:
> - clk_enable() the new parent
> - change the parent
> - clk_disable() the old parent
> I don't see any short path here.
>
> > I really tried to abstract what is really implemented in
> > other OS on the same topic.
>
> FYI, Linux does the clk_enable(parent) like above.
>

You mean linux enables a clock in set_parent even if the clock_chain
is not yet enabled.
clock a disable
clock b disable

clk_set_parent(a, b) b->a now b is enabled?

Michael

> Thanks,
> Miqu=C3=A8l



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
