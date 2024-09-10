Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D553ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226EC890CE;
	Tue, 10 Sep 2024 14:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oDHbiZNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 429D5890A7; Tue, 10 Sep 2024 14:56:41 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7735389087
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E88E9C0012;
 Tue, 10 Sep 2024 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725972997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2AAoSXRHot+98XhJOLReHpp3weQLuYYi35/7BBPr2Dc=;
 b=oDHbiZNHDLB1cZABaStLFE7c080zO+z3gHigsq2WxhqONofUca+VeiE89HVfBWpJsfC7Ha
 reFcst8eIUzcJla+UCKB50MSxZqCI2WVP6Q4IShxxMqIrafrSgBCQIpH49kA/0WtuMsVgP
 iaPzlaWmftwxG2PLAYSY7nlQKyLRY8KLIHTy+ai4j1jrgsg04LIbeaeVctv5X4AmlvNHI1
 gCpyN94fTvKXbetPmhVMcHu+1UFgGXdYKrTCKe3F4QRrzxRTgB9M9FNFAroLOnoUlPZq/F
 PV5QC5htvbdMA7PISSOdLkJIrCiF6Ff3qg9EnvRdDTuNuQ5Fos/5MNdQveuGPQ==
Date: Tue, 10 Sep 2024 14:56:34 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ian
 Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 0/8] Add imx8mp video support
Message-ID: <20240910145634.2ada70ad@xps-13>
In-Reply-To: <CAOf5uwmzm=9=Vsu5cTbziyPG=KAqDGTcmrW0A36a2ix_+2WjNA@mail.gmail.com>
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <CAOf5uwmzm=9=Vsu5cTbziyPG=KAqDGTcmrW0A36a2ix_+2WjNA@mail.gmail.com>
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

michael@amarulasolutions.com wrote on Tue, 10 Sep 2024 12:30:42 +0200:

> Hi Miquel
>=20
> On Tue, Sep 10, 2024 at 12:13=E2=80=AFPM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > In order to display a boot picture or an error message, the i.MX8MP
> > display pipeline must be enabled. The SoC has support for various
> > interfaces (LVDS, HDMI, DSI). The one supported in this series is the
> > standard 4-lane LVDS output. The minimal setup is thus composed of:
> > * An LCD InterFace (LCDIF) with an AXI/APB interface, generating a pixel
> >   stream
> > * One LVDS Display Bridge (LDB), also named pixel mapper, which receives
> >   the pixel stream and route it to one or two (possibly combined) LVDS
> >   displays.
> > * All necessary clocks and power controls coming from the MEDIAMIX
> >   control block.
> >
> > Patch 1 adds a very useful helper to the core in order to grab devices
> > through endpoints instead of being limited to phandles. Video pipelines
> > being often described using graphs endpoints, the introduced helper is
> > used several times in the serires (there are 3 LCDIF, one of them being
> > connected to the LDB, itself having 2 ports).
> >
> > Patch 2 is a fix which is necessary for this series to work properly,
> > but is way broader than just this use case. In practice, when assigned
> > clocks are defined in the device tree, the clock uclass tries to assign
> > the parents first and then sets them to the correct frequency. This only
> > works if the parents have been enabled themselves. Otherwise we end-up
> > with a non-clocked parent. I believe this is not the intended behavior
> > in general, but more importantly on the i.MX8MP, there are "clock
> > slices" which have pre-requisites in order to be modified and selecting
> > an ungated parent is one of them.
> >
> > All the other patches progressively build support for the whole video
> > pipeline. Regarding the LCDIF driver, there is already a similar driver
> > for older i.MX SoCs but I didn't manage to get it to work. It was
> > written more than a decade ago while device-model, clocks and others
> > were not yet generically supported. Thus, numerous ad-hoc solutions
> > were implemented, which no longer fit today's requirements. I preferred
> > to add a new "clean" driver instead of modifying the existing one
> > because of the too high risk of breaking these platforms. Once proper
> > clocks/power-domain descriptions will be added to them they might be
> > converted (and tested) to work with the "new" implementation, but going
> > the opposite way felt drawback.
> > =20
>=20
> Thank you for adding those patches. We are working on mipi support
> here and some of the clock patches
> are there too. I will try to look and rebase our patchset
>=20
> https://patchwork.amarulasolutions.com/patch/3401/

Thanks for letting me know. Indeed there are a couple of conflicts.
- My patch 2 can easily be replaced by your approach.=20
- Regarding the power domain we had two different approaches, I
  didn't look in details, but again one or the other seems fine, I
  guess.
- The LDB driver in my series is new.
- Finally regarding the LCDIF changes, the approach taken on your
  side follows the somewhat too ad-hoc logic and would probably benefit
  from being migrated to the driver I propose, which does make use of
  the (DM) clock, power domain and DT API. I am really happy with the
  core helper I've added retrieving a device in front of a graph
  endpoint, which makes the whole "get panel/bridge" approach much more
  flexible and adapted to today's needs.

What is the status of your patchset? How shall we handle the conflicts?

Thanks,
Miqu=C3=A8l
