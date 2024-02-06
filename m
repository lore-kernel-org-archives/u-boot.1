Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F64C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 17:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE627876AE;
	Tue,  6 Feb 2024 18:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uDd569ZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E383C870A4; Tue,  6 Feb 2024 18:20:32 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2310875E9
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 18:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1CB81615E4;
 Tue,  6 Feb 2024 17:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8956C433F1;
 Tue,  6 Feb 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707240028;
 bh=nOtHy9gE55bxD12SUrL+WoDMjhL5Xjk19weAJCXu4zg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uDd569ZLz4ddnZy9QRIUHD6D1WIW7zs0OcJGlMVWrZFKkqPVwTY3usZn6SLkI9k9F
 02O3mKP5PTHVONwdj451SBfShDRgw53KgZLwVSgnROrrbL5WTpK0BzN2Z1RiO3A/YI
 cUNIVjQAl45J9K6Xy2SPp6yuiBQvR8gEMbLugneQ3IbGJM99EcWrjo+WFgVgMCSGxd
 mlJZaqQdZeAG+Wj5Fweuc4+EwtuHAAdzU9PJFphgzoMNebamLNuxd+2m92pWhwmj34
 suNF2IDAMZ67DKyuCoNszdo4zqpTWOtj1rNTyzJtzNEqbaw45YJrkw1zpPjgod6uUw
 xtyBaKPuAeHCA==
Date: Tue, 6 Feb 2024 17:20:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20240206-trusting-arguable-1d7ac134b5db@spud>
References: <20240104014919.413568-1-sjg@chromium.org>
 <20240116-snowbound-symptom-aa07c4dcf736@wendy>
 <20240122-pranker-shininess-8953eb6182b4@spud>
 <20240122184717.GQ3652023@bill-the-cat>
 <20240122-finicky-ancient-797ba048f927@spud>
 <20240123-aviation-caretaker-3c49d8da42dd@spud>
 <20240123180300.GW3652023@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zvnq5J0GNC/mBjH6"
Content-Disposition: inline
In-Reply-To: <20240123180300.GW3652023@bill-the-cat>
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


--zvnq5J0GNC/mBjH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:03:00PM -0500, Tom Rini wrote:
> On Tue, Jan 23, 2024 at 11:27:57AM +0000, Conor Dooley wrote:
> > On Mon, Jan 22, 2024 at 06:55:01PM +0000, Conor Dooley wrote:
> > > On Mon, Jan 22, 2024 at 01:47:17PM -0500, Tom Rini wrote:
> > > > On Mon, Jan 22, 2024 at 06:36:31PM +0000, Conor Dooley wrote:
> > > > > Hey,
> > > > >=20
> > > > > On Tue, Jan 16, 2024 at 01:48:06PM +0000, Conor Dooley wrote:
> > > > > > Yo,
> > > > > >=20
> > > > > > On Wed, Jan 03, 2024 at 06:49:19PM -0700, Simon Glass wrote:
> > > > > > > Standard passage provides for a bloblist to be passed from on=
e firmware
> > > > > > > phase to the next. That can be used to pass the devicetree al=
ong as well.
> > > > > > > Add an option to support this.
> > > > > > >=20
> > > > > > > Tests for this will be added as part of the Universal Payload=
 work.
> > > > > > >=20
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >=20
> > > > > > Since this was merged into master, U-Boot is no longer booting =
on my
> > > > > > icicle kit (At least that's what my bisection tells me). This i=
s a
> > > > > > RISC-V board and U-Boot for it is built from
> > > > > > microchip_mpfs_icicle_defconfig.
> > > > > >=20
> > > > > > There's zero output on the console from U-Boot at all, the last=
 thing
> > > > > > that I see is OpenSBI before things grind to a halt.
> > > > >=20
> > > > > Just wondering if there's anything I can do to help this one alon=
g?
> > > > > Got a red CI complaining at me every morning about it :|
> > > >=20
> > > > Well, can you please look in to what part of this is causing the
> > > > failure? I don't really see what would have changed on
> > > > microchip_mpfs_icicle_defconfig from this as BLOBLIST isn't set bef=
ore
> > > > nor after this change.
> > >=20
> > > Sure. I'll try to look into it more tomorrow.
> >=20
> > I gave it a try, it seems to be the FDTSRC_BLOBLIST additions that kill
> > it, not the actual code in fdtdec_setup().
>=20
> Well that's very unexpected. Can you see what boundary we're crossing or
> whatever has overflowed now or something on your platform?

And you know what else was not expected? The issue randomly disappearing
a few days after I sent this email. Or maybe that should be expected
given how the issue actually cropped up in the first place.
I didn't have a chance yet to see how this particular patch may have
interacted with the sections etc, but looking into it is still on my
todo list, just much lower down now that things actually boot again for
me...

Thanks,
Conor.

--zvnq5J0GNC/mBjH6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcJqVwAKCRB4tDGHoIJi
0oyYAQDbbFP8qlbOSjG1PCyIULrZ8V3gT7y8oZ/VmXjJm1IxmwEAyTBZTFHsJZ3G
u53+h3GXno1KLScemCobZ1T7Ux7f9gE=
=yvVf
-----END PGP SIGNATURE-----

--zvnq5J0GNC/mBjH6--
