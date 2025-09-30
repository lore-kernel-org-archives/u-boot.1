Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B59DCCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3E7802C1;
	Tue, 30 Sep 2025 18:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RvduktbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12BD80819; Tue, 30 Sep 2025 18:41:43 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A3E9800D7
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 746616112A;
 Tue, 30 Sep 2025 16:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330B8C4CEF0;
 Tue, 30 Sep 2025 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759250500;
 bh=ucMT4tCmH3UlU472o4DVQHh8y5GNR9J5Qpn2bjgN+VE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RvduktbTNmQXdqki+ZOrAJShvqtzGOGOqbjP1zPGPQFSxXyzW4nwR+UwbITjBLMTI
 l5xAIlvK+0TKfZf/Y2cII6Lh5Af69Bc410yu5/cZcsMVtDVf7wK7ylM+9Mm0d1SoWO
 /iLWVX2oUKtByqC6vPgnF4HMRMYTYm0TsXhP6OqhZ38pPbcjIA9KHxS9bZJuEGMY2o
 Yl9INuSspFBm2sOq5joahikuvg+kLEHs6eei7UPpcyQfh2ZgYARGybOcmeMVXCzkDu
 1VVUrDfGRkop1H7IKukbCbDGePWxPV2J0PDyv3dcgqukaorrJ6z8FlxoIaawCXgtRK
 Be8n39GcNbLrQ==
Date: Tue, 30 Sep 2025 17:41:34 +0100
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
Message-ID: <20250930-ramble-babied-1dbf34a778df@spud>
References: <20250929224336.GS6093@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oqDjt6cNWBXV8r3Q"
Content-Disposition: inline
In-Reply-To: <20250929224336.GS6093@bill-the-cat>
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


--oqDjt6cNWBXV8r3Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 04:43:36PM -0600, Tom Rini wrote:
> Hey all,
>=20
> As part of working on "allyesconfig" support I ran into the following
> problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
> implement support for the VSC8584 PHY. The vitesse.c driver is much
> older and only had VSC8584 support added for a specific Freescale
> Layerscape platform whereas mscc.c is modern and been updated with
> newer PHYs as well. And we need one driver to support this phy, not two.
> I am inclined to remove support from vitesse.c. However, only 4
> platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.
>=20
> I'm cc'ing all of the board maintainers (other than PowerPC platforms)
> that use PHY_VITESEE today to see what their feedback is on which way to
> go here. I'm ignoring PowerPC because that can just stay on the
> PHY_VITESSE driver based on timing of changes in git log.

The mpfs icicle board is using PHY_VITESSE because the phy it has
(vsc8662) is only supported by that driver. Same in Linux for that phy.
We've got no users of the model you're talking about.

FWIW, I checked our "in house" linux config and it uses the generic phy
driver, rather than the vitesse one. I wonder if we can get away with
that in U-Boot too?

--oqDjt6cNWBXV8r3Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwIPgAKCRB4tDGHoIJi
0loQAP0fTDlyXYy+RclZhTXk20u8BGHCYGenTaTSww5zcCnXowD/VnRGyGoEKjDf
uc9QKh/56Lt68HmYAl7KOHz4xOTRXQs=
=d6k0
-----END PGP SIGNATURE-----

--oqDjt6cNWBXV8r3Q--
