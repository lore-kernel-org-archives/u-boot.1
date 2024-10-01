Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410D0CE7D05
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 09:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8B489164;
	Tue,  1 Oct 2024 11:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mmIagVOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6546189189; Tue,  1 Oct 2024 11:55:12 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B39F6890AE
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 11:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40AB41C0014;
 Tue,  1 Oct 2024 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1727776507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CO1yBvabWk+rQxCxyzO0P9+3hlbh53C3Zoo4qmqYGH8=;
 b=mmIagVOm6JvFQFmRBcFcaPgXVqeur6K6mmNU1b6kxij6ZxX4LdV+NR8QfVZjC7dS3pmWMJ
 aBnezVHytByB6GKnemWyUwl69ajteXBV0SY0phnBa/lbpOThczlRSqR/I8Y1LWeDPsb4QV
 U7+4etMS+14vnKYqsiEiJAV9FIpSbtGMg249a0S+0XzZ8UTNzNPLZ4ZEKr0K+bwVlwIQcW
 ScM0D8MCVWgIeE1WIUGvb1IGSXRAKlRBrCfPnleD2U1Iv9QU5ivSYdbUANW2mZ3j5aCLXx
 RN2OMoUNvc2pI0PUuNC8L3MKlJe070Rc6mtOd2fBjfEq8SASPFxtj764BUQ8Wg==
Date: Tue, 1 Oct 2024 11:55:05 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Heiko Schocher <hs@denx.de>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Dario
 Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de, Fabio
 Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com, Ye Li
 <ye.li@nxp.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
Message-ID: <20241001115505.5ae4d0e6@xps-13>
In-Reply-To: <a91171dd-a2f2-8df7-5b11-4a35a227ef2e@denx.de>
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

Hi Heiko,

hs@denx.de wrote on Tue, 1 Oct 2024 10:57:27 +0200:

> Hello Miquel,
>=20
> On 01.10.24 10:50, Miquel Raynal wrote:
> > Hi Michael,
> >=20
> > michael@amarulasolutions.com wrote on Tue, 1 Oct 2024 10:33:56 +0200:
> >  =20
> >> Hi Miguel
> >>
> >> On Tue, Oct 1, 2024 at 10:29=E2=80=AFAM Miquel Raynal <miquel.raynal@b=
ootlin.com> wrote: =20
> >>>
> >>> Hi Heiko,
> >>> =20
> >>>   >>>>>>> Hmm.. unfortunately ... I had applied your 2 clock patches,=
 which =20
> >>>>>>> fixed a problem with enabling parent clocks ... but they broke bo=
oting
> >>>>>>> on a carrier which has fec ethernet! After "Net: " output the boa=
rd hang...
> >>>>>>>
> >>>>>>> I reverted your 2 clock patches and it bootet again ... so there =
is
> >>>>>>> a problem ... try to get some more time to look into... =20
> >>>>>>>   >>>>>> =20
> >>>>>> We have a fec, but we had I think two patches more on it. I forget=
 to
> >>>>>> answer Marek
> >>>>>> about them because I don't have my board now and because he is
> >>>>>> partially right (or maybe right).
> >>>>>> Anyway when we boot we could have and we have clocks that are enab=
led
> >>>>>> by bootrom or SPL that
> >>>>>> we need to declare as enable like PLL2/PLL3 those clocks are parts=
 or
> >>>>>> could be part of reparent so,
> >>>>>> you need to have a reference counter on them that allow to not dis=
able
> >>>>>> during the down chain disable
> >>>>>> and up chain enable. I think that what happens to your ethernet it=
's
> >>>>>> that you disable some clock that is
> >>>>>> critical to the board to survive. I had a patch merged by Tom that=
 =20
> >>>>>
> >>>>> Yep, thats what I think too! If you access registers in a block for
> >>>>> which the clock is not enabled ... it just hang... =20
> >>>>>   >>>>>> prints the clock name so if you enable =20
> >>>>>> the debug of the clock you will find that your board stops working
> >>>>>> during one of this reparinting. =20
> >>>>>
> >>>>> I currently work on 2024.07... will rebase if 2024.10 is out...
> >>>>>
> >>>>> Ah, you mean:
> >>>>>
> >>>>> commit a70d991212c9684e09ed80ece69ce1ff7bfd9f08
> >>>>> Author: Michael Trimarchi <michael@amarulasolutions.com>
> >>>>> Date:   Tue Jul 9 08:28:13 2024 +0200
> >>>>>
> >>>>>       clk: clk-uclass: Print clk name in clk_enable/clk_disable
> >>>>>
> >>>>>       Print clk name in clk_enable and clk_disable. Make sense to k=
now
> >>>>>       what clock get disabled/enabled before a system crash or syst=
em
> >>>>>       hang.
> >>>>>
> >>>>>       Signed-off-by: Michael Trimarchi <michael@amarulasolutions.co=
m>
> >>>>>
> >>>>> I have the same change when I debug :-P
> >>>>>
> >>>>> IIRC I did not see the clock names ... but I will recheck! =20
> >>>>
> >>>> I see with your patch the clock names, so fine... and see [1]
> >>>>
> >>>> Hmm... I am on imx8mp, and I think the changes the patchset do in
> >>>>
> >>>> "clk: imx8mn: Prevent clock critical path from disabling during repa=
rent and set_rate"
> >>>>
> >>>> are in clk-imx8mp already ...
> >>>>
> >>>> Ported the patch from patchset
> >>>>
> >>>> "[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3=
 as enabled"
> >>>>
> >>>> to imx8mp [2] and fec ethernet works again for me on imx8mp!
> >>>>
> >>>> Could you add this if you post a v2 ? =20
> >>>
> >>> TBH I don't feel like the below change is the correct one, it is too
> >>> specific. The clock core is recursive and thus should handle the
> >>> reparenting situations gracefully.
> >>>
> >>> I posted a series that is targeting the LVDS output on imx8mp. You
> >>> should probably consider checking these patches as well if you work
> >>> on imx8mp as well. I also had similar breakages with Ethernet which
> >>> happened during the assigned-clocks handling. This patch, which is mo=
re
> >>> future and platform agnostic, fixed it:
> >>>
> >>> https://lore.kernel.org/u-boot/20240910101344.110633-3-miquel.raynal@=
bootlin.com/ =20
> >>>   >> =20
> >> The clock patches are not specific at all. You need to have it working
> >> for the parent for each component. =20
> >=20
> > The diff shown by Heiko is explicitly enabling PLLs by naming them in
> > the iMX driver. This is not the correct approach. The problem of
> > having non-enabled new parents is global. Parent clocks should be
> > enabled before changing muxes, and this should be enforced
> > by the clock core/uclass, not the SoC drivers. =20
>=20
> Okay, valid argument.
>=20
> >  =20
> >> This is a standard way to do it and nothing magic compared to other
> >> implementations. =20
> >=20
> > No, naming PLLs explicitly is not the correct approach.
> >  =20
> >> I don't see
> >> in your series any addressing or reparent clock or take in account
> >> that a clock should be enable before
> >> reparenting. =20
> >=20
> > That's exactly the link above, whose diff is pasted here for reference:
> >=20
> > @@ -595,6 +595,10 @@ int clk_set_parent(struct clk *clk, struct clk *pa=
rent)
> >   	if (!ops->set_parent)
> >   		return -ENOSYS; =20
> >   > +	ret =3D clk_enable(parent); =20
> > +	if (ret)
> > +		return ret; =20
>=20
> As I said before, I had *exact* the same patch and thought I made a big
> hack :-P

I don't think so :-)

> But I wonder ... if this a generic "problem", why nobody had yet problems
> with it...

It depends on your hardware and how you use it I guess. If you look into
the terribly complex clock slices explanation in the imx8mp manual,
you'll see what the target clock interface does behind the scenes when
you use it. There are like 25 steps internally to prevent glitch-free
changes. I suspect one of those actions to stall if the parent is not
enabled early enough during the reparenting procedure.

Now, the reason why parents might be disabled is because of the high
level of configurability this SoC offers which is likely higher than
many other SoCs. But in general, to avoid these stalls, there has been a
quite extensive use of assigned-clocks properties. I believe with yet
another entry in this list, we could probably make it work, but that's
not the correct approach either.

Thanks,
Miqu=C3=A8l
