Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED465C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 13:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188768801E;
	Fri,  8 Mar 2024 14:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="RCD/S8zQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417FC8801E; Fri,  8 Mar 2024 14:22:18 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6BF8804E
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 14:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1709904134; x=1741440134;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=j05N392Te/X27WAsYHaVwZgvY9+CZrbe26Kk/ssk+IU=;
 b=RCD/S8zQBdP3iSUkOaD3WMJXh8xRILGo9aLfsdhHn9kuQ+UhQKJZntCS
 D47kClHZW1ykyUQe/s6CJDLJW+PT6wsshNtsfIeAMCO91UqNd8vpoKHdT
 CWn5gQTK2qcR7cp8a53dKEbN6GeR8cJjEkqxuroj1/xbQOk/+sg4acAjV
 fLA3RE9pT7cc8wcYTjJYS/x9qJQJGGTv5Oyvak7GrDiP+nuzjnwC66b9h
 K9c5EVXIk3+YWd3KHZ6bBfmHzt7I1YlKrYyZPgRLc3d6dXQBYqGXeO7GK
 Fb7FARvOpA+ROWMrFLQD0AoXtzeu2DSHy45HmH4VNhR7JleEGrJx20xsK g==;
X-CSE-ConnectionGUID: k93E/RKDScy08hrC4TtQxA==
X-CSE-MsgGUID: U4ArTu3GTVmFff/Ne7dzkw==
X-IronPort-AV: E=Sophos;i="6.07,109,1708412400"; 
 d="asc'?scan'208";a="19066326"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 08 Mar 2024 06:22:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 06:22:02 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Mar 2024 06:22:00 -0700
Date: Fri, 8 Mar 2024 13:21:15 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Tom Rini <trini@konsulko.com>
CC: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, 
 Sumit Garg <sumit.garg@linaro.org>, <shawnguo@kernel.org>, Fabio Estevam
 <festevam@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor@kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Rob Herring <robh@kernel.org>,
 <u-boot@lists.denx.de>, Stefano Babic <sbabic@denx.de>, "NXP i . MX U-Boot
 Team" <uboot-imx@nxp.com>, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240308-amends-deskbound-c12ed63859e5@wendy>
References: <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
 <20240229134242.GR3040305@bill-the-cat>
 <20240229140140.GS3040305@bill-the-cat>
 <CAFA6WYPkSd=roYiZrK-9oKOse+zTsbtBj8mrgV=HHFVHtCwHGg@mail.gmail.com>
 <3f6e7fef-b1ee-4c1a-9ca6-fad4959631b3@armadeus.com>
 <20240301-unstuffed-sixtyfold-0a875a031043@wendy>
 <20240301185413.GF3040305@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="he9nRIel5jiaoosX"
Content-Disposition: inline
In-Reply-To: <20240301185413.GF3040305@bill-the-cat>
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

--he9nRIel5jiaoosX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 01:54:13PM -0500, Tom Rini wrote:
> On Fri, Mar 01, 2024 at 01:32:53PM +0000, Conor Dooley wrote:
> > > > > > > > > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > > I think the commit in question can be
> > > > > > > > > > summarized as "remove a bunch of explicit HW informatio=
n because there's
> > > > > > > > > > now a Linux Kernel driver that determines that dynamica=
lly". What do we
> > > > > > > > > > do next? The old information is in a presumably valid b=
inding still, can
> > > > > > > > > > we just put it back and comment that consumers outside =
of Linux use this
> > > > > > > > > > still so it's not removed again later? Or am I just mis=
sing where we can
> > > > > > > > > > instead get this information from the DT still and not =
need to come up
> > > > > > > > > > with a new driver and subsystems?
> >=20
> > I don't think this is an accurate summary. The "explict hw information"
> > was never allowed for an imx6ul, only for some older devices, so "the
> > old information is in a presumably valid binding" is not accurate.
> > See 7b920aae917d ("dt-bindings: mxsfb: Add new bindings for the MXSFB
> > driver") for when doing things that way was deprecated. The imx6ul was
> > only documented several years after it was introduced (so likely several
> > years after it started incorrectly using that binding).
> >=20
> > Seeing that, I am not sure that I would even question the kernel patch
> > cited above, the change was done for binding compliance and I would not
> > be inclined to think twice, given the bindings are the ABI.

Reading this back today, it took me second to recall what I meant by
"question". What I meant was that during a review I would would see a
patch changing this to comply with the bindings and think nothing of it,
not that removing it was a unquestionably correct thing to do.

> So part of the problem I see here is that legacy platforms (which to me
> is a large chunk of 32bit ARM) are trickier. I'm not asking for anything
> more to be done in this example to be clear (I think the new panel-dpi
> binding is what U-Boot needs to implement and solve the issue here).
>=20
> But I don't think the fact that the old binding was handled
> suboptimally means that its usage should be ignored.

What often happens is that Linux retains support for the old way of
doing things but the dts is updated to the documented way. I'm not
really sure how to deal with this kind of thing, other than being extra
diligent about reviewing cleanup work that may impact other users of the
dts sources and letting the linux platform maintainers know if something
gets broken in U-Boot.

> They were added in
> 2017 which is after they were deprecated and not caught then. I consider
> that to mean it was still valid.

I don't agree that that makes it valid, but I can see how it would be
assumed to be valid by other users of the dts file.

> And I also assume that today we have
> the tooling to catch that and not let it in, in the first place.

Unfortunately, not really. The tooling is capable of spotting these
things, but it totally depends on the effort people have put in to
that platform as to whether or not the single to noise ratio actually
allows a maintainer to spot when these things are introduced.
The RISC-V platforms, Samsung and some others have really good
compliance, but other platforms like aspeed or at91 have so many
warnings etc that it is very very difficult for the platform maintainers
to actually spot things like these being added.

> Time will tell now how bumpy a ride things end up being as I do agree
> that getting all the DTS files following the ABI correctly is an
> important goal.

Fixing up a platform is utterly mind-numbing work that requires
understanding datasheets and bindings for really varied hardware, so
it's best done by either the platform maintainers or piecemeal by people
that want to improve one particular board. It's gonna take a long time
to get "all" files following the ABI, particularly away from the ones
the linux dt-maintainers take more of an interest in.
Next time we get a new grad starting I might subject them to some
cleanup activities, they'll have to learn about dt at some point anyway
;)

Sorta unrelated to the above, but related to the OF_UPSTREAM stuff is
that I do notice a bit of an attitude of "U-Boot bundles the dtb with
the binary, so it's okay to break U-Boot because they have a copy of
the old dts and we can update both code and dts at the same time in
the 'future'". I can't cite anything off the top of my head, but I've
not been reviewing binding patches for all that long and it has been
said multiple times.
I'm not entirely sure how to handle that sort of situation, "force" the
submitter to send patches to U-Boot before I ack the binding?

I do skim all the patch subjects that get sent to the U-Boot ML, so I'll
at least try to keep an eye out for any fallout caused by the
OF_UPSTREAM stuff.

--he9nRIel5jiaoosX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZesQywAKCRB4tDGHoIJi
0k0CAP9f8uu3j7MrpdQSCAVXVdoyNl9zOvinZ60fn4nysGWTbAD+JJ+4r2EXLoTJ
8K2i4BHnQ35wS8DCWckm5aELoYbMlQU=
=G//Z
-----END PGP SIGNATURE-----

--he9nRIel5jiaoosX--
