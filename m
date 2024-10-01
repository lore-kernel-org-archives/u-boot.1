Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E490CE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B7A88CFB;
	Tue,  1 Oct 2024 10:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BWr/LrK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A549A88BD6; Tue,  1 Oct 2024 10:34:11 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8239D88CFB
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c8a2579d94so1012508a12.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727771648; x=1728376448;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4LSfSRthX6cWjmi5OByp2egfrXoIiisqkYmiVJXBmA=;
 b=BWr/LrK30eGO3WRjbfu8ks8CRpHOL06oAsh4K3pz92+7jdMOoLgmcpJFeL3m23SJc/
 EQdQCUCVMoeUFNw+l6iV+Af3IbSTX/xy9CZKwIzI1JX1umvLtxHdOyxV70FrNUa1ItZm
 kpc7XvEV0M7ealKfOMb6BG5FPFCMVZa2KQxQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727771648; x=1728376448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4LSfSRthX6cWjmi5OByp2egfrXoIiisqkYmiVJXBmA=;
 b=wuOM5aSwsYOIVNrY3fiEk0+J+GM4+liHU+kEcJ4dfZ0WmS4Q8MZ7bH1ySp3rg5McRM
 qS4GGISe9Q9XHQIsonYds7bu2wWFS4V1q78io6EhZsvzUVMFnhHI0pL60v0ab28mzgY5
 by35o5BTJl90KGNhU1QwRUWHHn421hg8NCyfpeJ4tXpsL43s0zxh6cpMBqXU09uMqdPo
 Si0UcO73rPRcAW3sDO0eKrTzd8P1dkaG24y+UHEcdc2vwv9DdPQWsBZ3wOrMS8+eEDcO
 jhkxTJORYiRs3IskBJz+6sn4CTX0bn2Glar8Og+X3PF9Wn2gJq4PJtsSeZP+kSpWVaTi
 pR3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe5RueCzLImu33UfLyXMMKbtZRrdNx1Fi13lwii8GZj50Jp5tg5M0bUhnR/htnLnIuBjCFQ2U=@lists.denx.de
X-Gm-Message-State: AOJu0YwSFPZjfkzFibRxsIrpWk6AgQhd/aBoGr88iApr5V8CgkLff+Q+
 ygR+QkoUHeVQswFj+UjFh2J7ZxDrkz8x+inxjCqDQpMzYOSGC9i8l/JPRty+iXlvymcjWp0JSv4
 KURlHXwWwhoWmuCtoJTfviaMZ4YNzQoMr8anSNQ==
X-Google-Smtp-Source: AGHT+IFWfIM0TsFSr9vED1edfZpSqbyUHsODL2Jrc5GJZ6Y9XurYm85ONlxzpfd8QMq6rtpaCcNxG+aSRV/AwpS5rng=
X-Received: by 2002:a05:6402:40d0:b0:5c5:cd34:48d6 with SMTP id
 4fb4d7f45d1cf-5c8824d0111mr11740891a12.1.1727771647930; Tue, 01 Oct 2024
 01:34:07 -0700 (PDT)
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
In-Reply-To: <20241001102908.39b2d3a6@xps-13>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 1 Oct 2024 10:33:56 +0200
Message-ID: <CAOf5uwn8vhozjtMqXmWL=3Jaf05UhV7cnGn15Ywj07-PmwW_9w@mail.gmail.com>
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 linux-amarula@amarulasolutions.com, 
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

Hi Miguel

On Tue, Oct 1, 2024 at 10:29=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Heiko,
>
>
> > >>> Hmm.. unfortunately ... I had applied your 2 clock patches, which
> > >>> fixed a problem with enabling parent clocks ... but they broke boot=
ing
> > >>> on a carrier which has fec ethernet! After "Net: " output the board=
 hang...
> > >>>
> > >>> I reverted your 2 clock patches and it bootet again ... so there is
> > >>> a problem ... try to get some more time to look into...
> > >>>
> > >>
> > >> We have a fec, but we had I think two patches more on it. I forget t=
o
> > >> answer Marek
> > >> about them because I don't have my board now and because he is
> > >> partially right (or maybe right).
> > >> Anyway when we boot we could have and we have clocks that are enable=
d
> > >> by bootrom or SPL that
> > >> we need to declare as enable like PLL2/PLL3 those clocks are parts o=
r
> > >> could be part of reparent so,
> > >> you need to have a reference counter on them that allow to not disab=
le
> > >> during the down chain disable
> > >> and up chain enable. I think that what happens to your ethernet it's
> > >> that you disable some clock that is
> > >> critical to the board to survive. I had a patch merged by Tom that
> > >
> > > Yep, thats what I think too! If you access registers in a block for
> > > which the clock is not enabled ... it just hang...
> > >
> > >> prints the clock name so if you enable
> > >> the debug of the clock you will find that your board stops working
> > >> during one of this reparinting.
> > >
> > > I currently work on 2024.07... will rebase if 2024.10 is out...
> > >
> > > Ah, you mean:
> > >
> > > commit a70d991212c9684e09ed80ece69ce1ff7bfd9f08
> > > Author: Michael Trimarchi <michael@amarulasolutions.com>
> > > Date:   Tue Jul 9 08:28:13 2024 +0200
> > >
> > >      clk: clk-uclass: Print clk name in clk_enable/clk_disable
> > >
> > >      Print clk name in clk_enable and clk_disable. Make sense to know
> > >      what clock get disabled/enabled before a system crash or system
> > >      hang.
> > >
> > >      Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > >
> > > I have the same change when I debug :-P
> > >
> > > IIRC I did not see the clock names ... but I will recheck!
> >
> > I see with your patch the clock names, so fine... and see [1]
> >
> > Hmm... I am on imx8mp, and I think the changes the patchset do in
> >
> > "clk: imx8mn: Prevent clock critical path from disabling during reparen=
t and set_rate"
> >
> > are in clk-imx8mp already ...
> >
> > Ported the patch from patchset
> >
> > "[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as=
 enabled"
> >
> > to imx8mp [2] and fec ethernet works again for me on imx8mp!
> >
> > Could you add this if you post a v2 ?
>
> TBH I don't feel like the below change is the correct one, it is too
> specific. The clock core is recursive and thus should handle the
> reparenting situations gracefully.
>
> I posted a series that is targeting the LVDS output on imx8mp. You
> should probably consider checking these patches as well if you work
> on imx8mp as well. I also had similar breakages with Ethernet which
> happened during the assigned-clocks handling. This patch, which is more
> future and platform agnostic, fixed it:
>
> https://lore.kernel.org/u-boot/20240910101344.110633-3-miquel.raynal@boot=
lin.com/
>

The clock patches are not specific at all. You need to have it working
for the parent for each component.
This is a standard way to do it and nothing magic compared to other
implementations. I don't see
in your series any addressing or reparent clock or take in account
that a clock should be enable before
reparenting.

> My series is complimentary, even though there are some overlaps that we
> need to merge.

The only collision I can see from your series is that you re-write the
imx approach of power domain.
Can you please expand here a bit your point?

Michael

>
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
