Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DFED1F9A1
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 09:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C18F83F82;
	Thu,  4 Dec 2025 10:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="l37P0RiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8911983F9A; Thu,  4 Dec 2025 10:57:47 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D60583F6E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 10:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E106B1A1F3F;
 Thu,  4 Dec 2025 09:57:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AB63A6068C;
 Thu,  4 Dec 2025 09:57:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 86D1D119221F9; Thu,  4 Dec 2025 10:57:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764842252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=yONLANitgL0uOiXgC1DvVklfWrPJPIv9I1j/tFwH+8k=;
 b=l37P0RiEYQiFNLMIDcbv/Js+S1O9f0JNveFnB9827L5Mua/GvRRlTEimRdIvKTlkeHgLNj
 vJgyQ6N624iqnmk5isB5469ZHSjWESvITFfeWsU44TbWKf+oj7FApqVN00lHlw32kC4p3J
 A/6AbfjKps5qnErhW1DLK93oebpTVpmnpbN786OIojzDxaPM8nWpYxezQ6IVtIrT16Ts4u
 RYPFaikrJH+DxvjOJJ+Ktjxl2DegHlFln2JCmIlNe/IHibf+JiV6bLljSn0xnMnzmCg2Qj
 DJAMg6sVnyyLVgx51+MdxLDzSPS60bfrGBBxJpQDbJTuZCEstsZ+Tq1d5wcJ5A==
Date: Thu, 4 Dec 2025 10:57:23 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patryk <pbiel7@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Peng Fan <peng.fan@nxp.com>, Simon Glass
 <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>, Duje
 =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>, Stefan Roese
 <stefan.roese@mailbox.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, Alif
 Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, E Shattow
 <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, Daniel
 Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Yao Zi <ziyao@disroot.org>, Leonard Anderweit <l.anderweit@phytec.de>
Subject: Re: [PATCH 0/6] Add support for fwumdata
Message-ID: <20251204105723.667d1806@kmaincent-XPS-13-7390>
In-Reply-To: <20251203172659.GS303283@bill-the-cat>
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
 <20251203110108.1d93975d@kmaincent-XPS-13-7390>
 <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
 <CA+DkFDbecwtJkX-7wHzQjhVbi-tpjzZVzc7N3kvhr5OtKivgWA@mail.gmail.com>
 <20251203155924.3dd3c5a0@kmaincent-XPS-13-7390>
 <20251203151048.GP303283@bill-the-cat>
 <20251203181329.7b33676c@kmaincent-XPS-13-7390>
 <20251203172659.GS303283@bill-the-cat>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Wed, 3 Dec 2025 11:26:59 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Wed, Dec 03, 2025 at 06:13:29PM +0100, Kory Maincent wrote:
> > On Wed, 3 Dec 2025 09:10:48 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >  =20
> > > On Wed, Dec 03, 2025 at 03:59:24PM +0100, Kory Maincent wrote: =20
> > > > On Wed, 3 Dec 2025 15:04:10 +0100
> > > > Patryk <pbiel7@gmail.com> wrote:
> > > >    =20
> > > > > Hi Ilias,
> > > > >    =20
> > > > > > > > Add a new fwumdata tool to allows users to read, display, a=
nd
> > > > > > > > modify FWU (Firmware Update) metadata from Linux userspace.=
 It
> > > > > > > > provides functionality similar to fw_printenv/fw_setenv but=
 for
> > > > > > > > FWU metadata. Users can view metadata, change active/previo=
us
> > > > > > > > bank indices, modify bank states, and set image acceptance
> > > > > > > > flags. Configuration is done via fwumdata.config file.
> > > > > > > >
> > > > > > > > Made a few change to mkfwumdata tool along the way.     =20
> > > > > > >
> > > > > > > Still wondering about the choice of putting this fwumdata too=
l in
> > > > > > > U-Boot instead of TF-A. TF-A is the boot part that manages the
> > > > > > > update process and rollback through the FWU metadata,
> > > > > > > therefore, this is where it should belong.
> > > > > > > Why, in the first place, mkfwumdata was accepted into U-boot
> > > > > > > instead of TF-A?     =20
> > > > > >
> > > > > > The actual update happens via capsule updates only, which runs =
in
> > > > > > BL33. TF-A needs to be aware in case it's involved in the boot
> > > > > > process and fails to boot. In that case BL2 is responsible for
> > > > > > booting via the other bank.
> > > > > > But generally speaking it's U-Boot that processes and usually
> > > > > > updates that file     =20
> > > > >=20
> > > > > If I may add something - actually for me this is not that obvious,
> > > > > e.g. on our platform we update the metadata directly from Linux, =
not
> > > > > from the u-boot capsule. As far as I'm aware, the ST, in their
> > > > > OpenstLinux does the same. I'm also not sure why it would be the =
bad
> > > > > idea to do this from Linux. Ofc the BL2 handles bank selection as=
 well
> > > > > as rollback in case of boot failure on a newly selected bank.   =
=20
> > > >=20
> > > > I agreed with Patryk. U-boot is only an update agent (as explained =
by
> > > > the standard) of FWU metadata as Barebox or Linux could be. FWU
> > > > metadata is an ARM standard which is related to the update of the
> > > > images that boot after the ARM firmware. It is not related to any
> > > > project. As TF-A is the mainstream project for ARM firmware having
> > > > mkfwumdata and fwumdata in it seems more suitable. I am not familiar
> > > > with these EFI capsule update, does it not rely on TF-A to select t=
he
> > > > boot image according to the FWU metadata state?
> > > >=20
> > > > Anyway, now it is too late and mkfwumdata has already landed in U-b=
oot
> > > > for 2 years. Not sure what we should do here. Put all in U-boot and=
 let
> > > > the other projects (barebox) copy the code if they need it? Or move=
 all
> > > > to TF-A while keeping a deprecated copy of mkfwumdata in U-boot to =
not
> > > > break things?   =20
> > >=20
> > > Perhaps in the medium term we can split that tooling out from the main
> > > project source tree itself, to make it easier for OSes to use this to=
ol
> > > (and other tools we have). There's nothing U-Boot specific about this,
> > > if I'm following the thread right. =20
> >=20
> > This isn't clear to me.
> > Are you saying that we should plan in removing mkfwumdata in the medium
> > term? And in the short time, sending the two tools to TF-A to get them
> > accepted. =20
>=20
> I mean in general, there are a lot of things in the u-boot source tree
> that may or may not really make sense to have, in tree. We also can't,
> right now, easily support or handle having multiple distinct projects
> under the u-boot umbrella. I'm wondering if we should figure out how
> to support a few source repositories under our umbrella, in a way that
> would make life easier for other projects too.

That seems indeed a good idea to have a sub repo for the tools but, for the
short term, where should I put my fwumdata tool TF-A or U-boot?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
