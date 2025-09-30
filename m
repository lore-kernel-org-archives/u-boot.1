Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD5ACAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 17:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6EB3800D7;
	Tue, 30 Sep 2025 19:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iUHT6HcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE5F5802C1; Tue, 30 Sep 2025 19:22:32 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96154800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 19:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C643743F62;
 Tue, 30 Sep 2025 17:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2904C4CEF0;
 Tue, 30 Sep 2025 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759252948;
 bh=KNS5ycjw0j/84B0Fl6XvKl+f/2KGxfxAqk13RxGoUaY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iUHT6HcXbjKwSQYUcdcnOlZmuad9zu7fpb7Qw/qzqKVeVeU0y762Te+bX/SGesj5B
 LF7V/GAQ/A1OXrAsaooLmglK9SQmN1vRddsk87w03ZsAWW4DfWsX/DgheEOJdnPnfe
 f0EqWZ3/LyHvNU1D3bcvY5s5Rbq0JXbVV7tELQBDGkv9XriMhGNPZKrVYqQE7+koVy
 luqjlFnLeGkSB2tKl0/DMzb3bhMeE+nDL2jWXpvJRAVI0WsdW4dA1aOn7SaPSdt1wD
 IEQt5fWhyOquv+e9Xg2aUarphk61a8SqHhNaO3slOm27cUHzaOq2F29DcgfmST/ghI
 jA/4eXkVfV74w==
Date: Tue, 30 Sep 2025 18:22:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Manish Tomar <Manish.Tomar@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aaron Williams <awilliams@marvell.com>,
 Mathew McBride <matt@traverse.com.au>
Subject: Re: U-Boot PHY_MSCC vs PHY_VITESSE
Message-ID: <20250930-quarterly-explicit-08af1938f535@spud>
References: <20250929224336.GS6093@bill-the-cat>
 <20250930-ramble-babied-1dbf34a778df@spud>
 <20250930171227.GG6093@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v8tOVo8U5TtxLkoM"
Content-Disposition: inline
In-Reply-To: <20250930171227.GG6093@bill-the-cat>
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


--v8tOVo8U5TtxLkoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:12:27AM -0600, Tom Rini wrote:
> On Tue, Sep 30, 2025 at 05:41:34PM +0100, Conor Dooley wrote:
> > On Mon, Sep 29, 2025 at 04:43:36PM -0600, Tom Rini wrote:
> > > Hey all,
> > >=20
> > > As part of working on "allyesconfig" support I ran into the following
> > > problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
> > > implement support for the VSC8584 PHY. The vitesse.c driver is much
> > > older and only had VSC8584 support added for a specific Freescale
> > > Layerscape platform whereas mscc.c is modern and been updated with
> > > newer PHYs as well. And we need one driver to support this phy, not t=
wo.
> > > I am inclined to remove support from vitesse.c. However, only 4
> > > platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.
> > >=20
> > > I'm cc'ing all of the board maintainers (other than PowerPC platforms)
> > > that use PHY_VITESEE today to see what their feedback is on which way=
 to
> > > go here. I'm ignoring PowerPC because that can just stay on the
> > > PHY_VITESSE driver based on timing of changes in git log.
> >=20
> > The mpfs icicle board is using PHY_VITESSE because the phy it has
> > (vsc8662) is only supported by that driver. Same in Linux for that phy.
> > We've got no users of the model you're talking about.
> >=20
> > FWIW, I checked our "in house" linux config and it uses the generic phy
> > driver, rather than the vitesse one. I wonder if we can get away with
> > that in U-Boot too?
>=20
> I was a little unclear in my wording of the problem, sorry. So just
> staying on PHY_VITESSE is fine (it's not being removed) or switching to
> the generic phy driver (likely smaller binary in the end?) is fine.

No no, I got what you were saying. Was just also wondering if the
"imply PHY_VITESSE" that we have on the board could be removed. I'd
never paid attention to that before and implying it seems a bit unneeded
if the generic driver works fine.

--v8tOVo8U5TtxLkoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwRzwAKCRB4tDGHoIJi
0vpaAP4qKoowLUQfpmAaDwmhsHCEDvL0eFEyHla3sk0+H6/ikAEAt2A5by5dgN/G
bOEDlncObzKLvs3nbNbXiFV15F55GQc=
=jl9T
-----END PGP SIGNATURE-----

--v8tOVo8U5TtxLkoM--
