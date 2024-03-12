Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C0FC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 10:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E7E87E20;
	Tue, 12 Mar 2024 11:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t4DBF5bV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B6387F00; Tue, 12 Mar 2024 11:14:33 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7422687D70
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 11:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mripard@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D782161173;
 Tue, 12 Mar 2024 10:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DC2C433F1;
 Tue, 12 Mar 2024 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710238467;
 bh=deGSuTO/IIVTZiHgBMlj9IFCW5+u1+PeSwEs6uBEKjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t4DBF5bVK9DNslv7fZbI1VFs7q3DpCXlZeH6CfUDKoTHuLnFXprefuaazosNx0gqO
 9pZFWLX5bnG0eUXRnelqBYfWQ5iIn3acd6m17rpoyO8rBi0dwL+yioK2MwfgbkvCpJ
 j8i2yrfTIgJYGBF5PUjxp46etIvGco+SkKWbxBJE8Zpy0mhEI47nD36Bt2XHQaQUoq
 fxcM5H1RYuZI1RkgkN5mQGjbtMi/bSKHreiF5ASim0+gLRkfwhdiyuazi0/FfunT+m
 frOHe7kGa6yAbfDHpUBaR2d0ShTtpJF1JKnO8wxs68wChNLQ9yC8zxUEVrvfic6mi9
 dSLPcwVQlQCMg==
Date: Tue, 12 Mar 2024 11:14:24 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] clk: set initial best mux parent to current parent
 with CLK_MUX_ROUND_CLOSEST
Message-ID: <20240312-helpful-judicious-monkey-ed27ba@houat>
References: <20240307-mux-v3-1-0885fc1ab2c9@outlook.com>
 <20240307-hot-hummingbird-of-atheism-87503c@houat>
 <SEZPR06MB6959882F5DA673456A3AA85D96202@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <20240311-speedy-bat-of-art-4facfc@houat>
 <SEZPR06MB69597C834C90FE1FBA1F1D83962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="awqbzhe5i5cs4dsy"
Content-Disposition: inline
In-Reply-To: <SEZPR06MB69597C834C90FE1FBA1F1D83962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
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


--awqbzhe5i5cs4dsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 04:52:29PM +0800, Yang Xiwen wrote:
> On 3/11/2024 5:34 PM, Maxime Ripard wrote:
> > On Thu, Mar 07, 2024 at 07:18:05PM +0800, Yang Xiwen wrote:
> > > On 3/7/2024 4:48 PM, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > On Thu, Mar 07, 2024 at 10:03:50AM +0800, Yang Xiwen via B4 Relay w=
rote:
> > > > > From: Yang Xiwen <forbidden405@outlook.com>
> > > > >=20
> > > > > Originally, the initial clock rate is hardcoded to 0, this can le=
ad to
> > > > > some problem when setting a very small rate with CLK_MUX_ROUND_CL=
OSEST.
> > > > >=20
> > > > > For example, if the lowest possible rate provided by the mux is 1=
000Hz,
> > > > > setting a rate below 500Hz will fail, because no clock can provid=
e a
> > > > > better rate than the non-existant 0Hz. But it should succeed with=
 1000Hz
> > > > > being set.
> > > > >=20
> > > > > Setting the initial best parent to current parent could solve thi=
s bug.
> > > > >=20
> > > > > Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> > > > I don't think it would be the way to go. The biggest issue to me is=
 that
> > > > it's inconsistent, and only changing the behaviour for a given flag
> > > > doesn't solve that.
> > >=20
> > > I think the current behavior is odd but conforms to the document if
> > > CLK_MUX_ROUND_CLOSEST is not specified.
> > clk_mux_determine_rate_flags isn't documented, and the determine_rate
> > clk_ops documentation doesn't mention it can return an error.
> >=20
> > > If i understand correctly, the default behavior of mux clocks is to
> > > select the closest rate lower than requested rate, and
> > > CLK_MUX_ROUND_CLOSEST removes the "lower than" limitation, which is
> > > what this version tries to accomplish.
> > The situation is not as clear-cut as you make it to be, unfortunately.
> > The determine_rate clk_ops implementation states:
> >=20
> >    Given a target rate as input, returns the closest rate actually
> >    supported by the clock, and optionally the parent clock that should =
be
> >    used to provide the clock rate.
> >=20
> > So CLK_MUX_ROUND_CLOSEST shouldn't exist, because that's what
> > determine_rate expects so it should always be there.
> >=20
> > Now, the "actually supported by the clock" can be interpreted in
> > multiple ways, and most importantly, doesn't state what the behaviour is
> > if we can't find a rate actually supported by the clock.
> >=20
> > But now, this situation has been ambiguous for a while and thus drivers
> > kind of relied on that ambiguity.
> >=20
> > So the way to fix it up is:
> >=20
> >    - Assess what drivers are relying on
> >    - Document the current behaviour in clk_ops determine_rate
>=20
>=20
> From my investigation, it's totally a mess, especially for platform clk
> drivers (PLL). Some drivers always round down, the others round to neares=
t,
> with or without a specific flag to switch between them, depend on the
> division functions they choose. Fixing all of them seems needs quite a lot
> of time and would probably introduce some regressions.

I agree it's a mess, but that's a mess you wanted to clean up in the
first place :)

> We'd probably only have to say both rounding to nearest and rounding down
> are acceptable, though either one is preferred.
>=20
>=20
> >    - Make clk_mux_determine_rate_flags consistent with that
>=20
>=20
> I think we must keep existing flags and document the current behavior
> correctly because of the massive existing users of clk_mux.
>
> That's why i'm going to only fix CLK_MUX_ROUND_CLOSEST users. Hopefully it
> won't cause too many regressions.

Which, without a documentation, makes it more of a mess.

>=20
> >    - Run that through kernelci to make sure we don't have any regression
>=20
>=20
> We don't. I run 'tools/testing/kunit/kunit.py run --kunitconfig
> drivers/clk/.kunitconfig' each time before i send patches.

That's kunit, not kernelci (https://linux.kernelci.org/job/)

>=20
> Over all, it seems quite a lot of work here.
>
> The situation here becomes even more complex when it comes to U-Boot clk
> framework. They chose slightly different prototypes and stated
> clk_set_rate() can fail with -ve. It's a great burden for clk driver auth=
ors
> and maintainers when they try to port their drivers to U-Boot. Let's Cc
> U-Boot clk maintainers as well, and see how we can resolve the mess here.

I mean, eventually, that's on them. If U-Boot chose to have a
somewhat-similar-but-not-really clock framework, there's nothing Linux
can solve here, even though I definitely can see the frustration for the
developpers that have to work on both.

Maxime

--awqbzhe5i5cs4dsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZfArAAAKCRDj7w1vZxhR
xZZwAP4+EGMEUglD/WVBtX1qrmRSTf6/9dYDeoxuCpfOgBw9cQEAjPJ3jhtBOsFR
RqxMxv5vLSy6XzxVLNAFL7q0DczXOQs=
=iWre
-----END PGP SIGNATURE-----

--awqbzhe5i5cs4dsy--
