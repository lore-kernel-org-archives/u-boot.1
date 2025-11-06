Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AB8CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 18:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C24D83BEB;
	Thu,  6 Nov 2025 19:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="O01MWE0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6424583BF1; Thu,  6 Nov 2025 19:00:09 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9508D83BE1
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 19:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E6B184E41576;
 Thu,  6 Nov 2025 18:00:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8F233606EE;
 Thu,  6 Nov 2025 18:00:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB98111850A25; Thu,  6 Nov 2025 19:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762452004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XP2JqzW1hFPNpxXiWJet+JKO0CbBXfSV2lCwsRDayVw=;
 b=O01MWE0/F7qbfJkHM//tjurqaslgoDO+gZmtM6u16aM9rpHBCpE62h3JSb/L8qyBsk7GuM
 zNMzdJTl+sop8/5nwJkt2r+ML0eMD8veRFpQ1nqOkf7wnXg770rTrZ6LDNVs2tfiP2kL4z
 wY9ih/xY1sOBmYu1yX23kz7EG+mEoSOk/xz/6XK5uMAewtljSABGDyXVYS43FrB9eT8kgs
 YpWnrVVBPSXNsGWw9o7PRwv/MvH+toMpyO3FwqPi9scpLLAZtwnBsz7h+4685r13e3cheL
 EqIUfdTrJ6ufLymHjKIHinH6QUPkjilVlDEhIuJwMmZAXn21cA6uilrkOQvkFw==
Date: Thu, 6 Nov 2025 19:00:01 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
Message-ID: <20251106190001.0e5a4504@kmaincent-XPS-13-7390>
In-Reply-To: <20251104163816.GB6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
 <20251103161905.GP6688@bill-the-cat>
 <20251104102916.3df33d55@kmaincent-XPS-13-7390>
 <20251104163816.GB6688@bill-the-cat>
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

On Tue, 4 Nov 2025 10:38:16 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Tue, Nov 04, 2025 at 10:29:16AM +0100, Kory Maincent wrote:
> > On Mon, 3 Nov 2025 10:19:05 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >  =20
> > > On Mon, Nov 03, 2025 at 05:16:30PM +0100, Kory Maincent wrote: =20
> > > > On Mon, 3 Nov 2025 11:52:25 +0100
> > > > Kory Maincent <kory.maincent@bootlin.com> wrote:
> > > > > > >       =20
> > > > > >=20
> > > > > > How about moving to standard boot and look at this there?     =
=20
> > > > >=20
> > > > > Ok, I will take a look at it.   =20
> > > >=20
> > > > There is a custom nand boot target [1], and I have not any am335x b=
oard
> > > > with nand memory to test it. I am afraid to break it during the upd=
ate
> > > > to bootstd. Not sure we can accept that. What do you think?
> > > >=20
> > > > [1]https://elixir.bootlin.com/u-boot/v2025.10/source/include/config=
s/am335x_evm.h#L27
> > > >   =20
> > >=20
> > > I think we can risk it. I'd even be OK with not migrating that portion
> > > and letting anyone still using those platforms, with NAND only, to ju=
st
> > > use a custom boot command instead as I have strong doubts there's any=
one
> > > doing anything other than that currently. =20
> >=20
> > Ok.
> >=20
> > Small questions related to standard boot:
> > Why do we have a lot of bootmeth selected by default like
> > BOOTMETH_EFILOADER, BOOTMETH_EFI_BOOTMGR, BOOTMETH_VBE ..., but
> > BOOTSTD_DEFAULTS not selected by default? Shouldn't it be the contrary?=
 =20
>=20
> Hard to say. We got stuck on trying to find the right balance between
> features and size growth.

I still think we should disable these as default, moreover they are run fir=
st
in the bootstd process as they are global bootmeth.

> > Moreover it is explicitly described that global bootmeth can be slow:
> > https://elixir.bootlin.com/u-boot/v2025.10/source/doc/develop/bootstd/o=
verview.rst#L103
> >=20
> > The bootmeths environment variable is never read.
> > Changing this environment in the prompt allows to change the bootmeth o=
rder
> > thanks to this callback:
> > https://elixir.bootlin.com/u-boot/v2025.10/source/boot/bootmeth-uclass.=
c#L459
> > But if we set bootmeths in the board environment it doesn't work at all.
> > Is it intended? =20
>=20
> Standard boot is still in development. We're still in the process of
> getting more SoCs migrated and in turn finding and fixing the rough
> spots. Global boot meths have changed a bit since v2025.10 as part of
> hopefully addressing the feedback Andre P. had as part of migrating
> sunxi, but I think there's still the ordering half of his concerns to be
> figured out.

Ok thanks for your replies.

Other question: Is it possible to not add the environment to SPL image using
the new text environment format. I have tried to update am335_evm board to =
it
but I got a SPL too big error.
I have tried to add "#if !defined(XPL_BUILD)" but it is not working.
It seems the same generated environment file is used for all images.
I still haven't found were it is included in the build of the SPL image.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
