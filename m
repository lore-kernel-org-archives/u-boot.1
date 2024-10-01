Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E259BCE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6838914D;
	Tue,  1 Oct 2024 10:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KM+aMxEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2EC8916A; Tue,  1 Oct 2024 10:56:07 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50DA8914D
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C17C1C000F;
 Tue,  1 Oct 2024 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1727772964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0dzoVw4qnLoQ7OX1J+X92Ie2UHz7AfhF3omT2FTR9E=;
 b=KM+aMxEPb+tz4fNc32oWmT0nRGZUPmdHW9plZXlJGNAOhpZ71e4FAOFmZeaaZuUMlQqHxS
 jd9KiFjbXujBeU5Nls16ytjsGuStlexwLkqoQIa0eF/yCJIj0F6sugzrYWKNr/2WrN//LI
 B2YwmLmC/Nz3qhmNTcxaA2UcS1dbmARR2ATWM5UcHHtZsVCCE6mB+sIYNPMs8X+bzR8KSd
 +iMmDqMwU68xOAkD4VCz/VlvRMaCOgIa7wf7koDptfAIXZUfWHJQRJ1T8beqEymxR4vvN0
 Xwi3a2J19UEd+lv2GyJu1sfhkQ40V4jTzKFOB9xD+ImYoD3QsFJHZzakNqYxcQ==
Date: Tue, 1 Oct 2024 10:56:02 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Heiko Schocher <hs@denx.de>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Dario
 Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de, Fabio
 Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com, Ye Li
 <ye.li@nxp.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
Message-ID: <20241001105602.23dcc2a6@xps-13>
In-Reply-To: <ff13dbb5-47af-28c8-c44d-079ac475b977@denx.de>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
 <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
 <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
 <ebb734bd-bdf7-ffd2-d676-7eb6011466a3@denx.de>
 <CAOf5uwm13jyOb0M9Xvx_bO1RpXhDcWqKBC-4fhZGo61Q5cjnjw@mail.gmail.com>
 <3cb57821-30f0-6aa0-2dec-313381b1350a@denx.de>
 <9ce14505-6c37-f2e8-4b5d-44f1a55f0393@denx.de>
 <20241001102908.39b2d3a6@xps-13>
 <ff13dbb5-47af-28c8-c44d-079ac475b977@denx.de>
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

> >> I see with your patch the clock names, so fine... and see [1]
> >>
> >> Hmm... I am on imx8mp, and I think the changes the patchset do in
> >>
> >> "clk: imx8mn: Prevent clock critical path from disabling during repare=
nt and set_rate"
> >>
> >> are in clk-imx8mp already ...
> >>
> >> Ported the patch from patchset
> >>
> >> "[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 a=
s enabled"
> >>
> >> to imx8mp [2] and fec ethernet works again for me on imx8mp!
> >>
> >> Could you add this if you post a v2 ? =20
> >=20
> > TBH I don't feel like the below change is the correct one, it is too
> > specific. The clock core is recursive and thus should handle the
> > reparenting situations gracefully.
> >=20
> > I posted a series that is targeting the LVDS output on imx8mp. You
> > should probably consider checking these patches as well if you work
> > on imx8mp as well. I also had similar breakages with Ethernet which
> > happened during the assigned-clocks handling. This patch, which is more
> > future and platform agnostic, fixed it:
> >=20
> > https://lore.kernel.org/u-boot/20240910101344.110633-3-miquel.raynal@bo=
otlin.com/ =20
>=20
> Yes, I also had such a "fix" first, before seeing Darios patchset!
>=20
> Damn, I did not see your patches...
>=20
> regarding your patch ... I am unsure which version is the best one ...
> I fear of side effects for other plattforms adding this change in
> generic "drivers/clk/clk-uclass.c" file...

FYI, this is the same approach as Linux. I don't expect any hardware
related breakage, however if people have already tried to workaround
the core's mistakes by doing more than expected in the SoC drivers,
maybe we will observe issues.

> > My series is complimentary, even though there are some overlaps that we
> > need to merge. =20
>=20
> I try to find time to test them on my board!

Sure, let me know if you have troubles, it's still fresh :-) I will
rework it a bit as it received already interesting feedback, and will
note to Cc you (as well as Dario/Michael) in v2.

Thanks,
Miqu=C3=A8l
