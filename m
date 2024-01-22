Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A041CC47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 18:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39A68792D;
	Mon, 22 Jan 2024 19:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YmlIKnmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD5C878BA; Mon, 22 Jan 2024 19:55:11 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 556028792D
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 19:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id DD38BB81061;
 Mon, 22 Jan 2024 18:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C53C433F1;
 Mon, 22 Jan 2024 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705949707;
 bh=xaidsXJK/F/kdZbDdma5CodD/FTx3CAdWMCAPlqJ0ug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YmlIKnmhA9byiFkmOi8Czwg6Fqz5vMjUo2aRolsSWoa7WSZZt7HYqaQ/zg84/GcQ0
 k98KxLakP6IcuBm7dk4pjzVDudKBT/GymBQptyZQbPhfMcqatgV75hghD1oNuwgwPr
 fw9pWnSweFOOcadpV0VpcjD4EM0la/16u73PQS1vmC+Rv6JEDnfKn2O50ybEZwRc2V
 TLoSCI/n1+l9x3BCHXHmn/GKe3F81HlQYJmqbRk+eci5mgycGfs9w1pyeB69pob5Pg
 ru2GP3ZNGIbfKTAQJG0TqGPBia6z2jq3unTmP+Cq+zKzZOYhui+NUyJbcL5AjOOyKU
 +OjfGHRxe861w==
Date: Mon, 22 Jan 2024 18:55:01 +0000
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
Message-ID: <20240122-finicky-ancient-797ba048f927@spud>
References: <20240104014919.413568-1-sjg@chromium.org>
 <20240116-snowbound-symptom-aa07c4dcf736@wendy>
 <20240122-pranker-shininess-8953eb6182b4@spud>
 <20240122184717.GQ3652023@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VQbWJaZHF9qf2CAu"
Content-Disposition: inline
In-Reply-To: <20240122184717.GQ3652023@bill-the-cat>
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


--VQbWJaZHF9qf2CAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 01:47:17PM -0500, Tom Rini wrote:
> On Mon, Jan 22, 2024 at 06:36:31PM +0000, Conor Dooley wrote:
> > Hey,
> >=20
> > On Tue, Jan 16, 2024 at 01:48:06PM +0000, Conor Dooley wrote:
> > > Yo,
> > >=20
> > > On Wed, Jan 03, 2024 at 06:49:19PM -0700, Simon Glass wrote:
> > > > Standard passage provides for a bloblist to be passed from one firm=
ware
> > > > phase to the next. That can be used to pass the devicetree along as=
 well.
> > > > Add an option to support this.
> > > >=20
> > > > Tests for this will be added as part of the Universal Payload work.
> > > >=20
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >=20
> > > Since this was merged into master, U-Boot is no longer booting on my
> > > icicle kit (At least that's what my bisection tells me). This is a
> > > RISC-V board and U-Boot for it is built from
> > > microchip_mpfs_icicle_defconfig.
> > >=20
> > > There's zero output on the console from U-Boot at all, the last thing
> > > that I see is OpenSBI before things grind to a halt.
> >=20
> > Just wondering if there's anything I can do to help this one along?
> > Got a red CI complaining at me every morning about it :|
>=20
> Well, can you please look in to what part of this is causing the
> failure? I don't really see what would have changed on
> microchip_mpfs_icicle_defconfig from this as BLOBLIST isn't set before
> nor after this change.

Sure. I'll try to look into it more tomorrow.

--VQbWJaZHF9qf2CAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa66BQAKCRB4tDGHoIJi
0pDWAP4yDw4ADzrG3EBVmcKF2Kee+luQQ6puQryuo7apYSLFLwEA1Vbo7mxvcfus
2jMkUq8KYa3mvAFME33q6SKBdN8asAc=
=LQoo
-----END PGP SIGNATURE-----

--VQbWJaZHF9qf2CAu--
