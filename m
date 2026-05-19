Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DF1CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D80848EB;
	Tue, 19 May 2026 18:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P9/Y0s0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA9B848F3; Tue, 19 May 2026 18:24:38 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66ECD848EE
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C53BE43F39;
 Tue, 19 May 2026 16:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F53C2BCB3;
 Tue, 19 May 2026 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779207874;
 bh=QV0mq1D/e9Z3kpvCvdaXf9+2umRta72HNhdKchctNFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P9/Y0s0u+pBC8PTKsMD5JpvmSaKD1t+zndLiaiy3KwQR8q7DymIskTA7LlKy24+BH
 Xhv1xudFwUrTFxJLOu0Z+xoPUHrDOFx0XOt6XzFU6hlKHkds6EAX3coAqQGIY07QP2
 JF42zBpqTZSXMDKZLfPxJjixaq5yhEeJYWIkpiAWD4qfKGtr2WzaiPs1UuiYu/iwMm
 sQQzuqYMrvZEwDdQRfPxeWLU1gZte+6pa/Jy8licLAWpFuDMyeMFUOFVdJk+JkeUmH
 mDeKzJyRpmgMVGymSdzS3FYuQb49NhQGi/PlzlREnJ8fozNrBDLi1TUW063E2B1gMi
 Nphy2+NsNYq4w==
Date: Tue, 19 May 2026 17:24:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>
Subject: Re: [PATCH 0/4] mailbox: mpfs-mbox: fixes and syscon support
Message-ID: <20260519-broadness-platypus-e4f17dcc42d9@spud>
References: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3nnxo5+//rllR9Pf"
Content-Disposition: inline
In-Reply-To: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
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


--3nnxo5+//rllR9Pf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 03:17:08PM +0100, Jamie Gibbons wrote:
> Hi all,
>=20
> This series updates the Microchip PolarFire SoC (MPFS) mailbox driver in
> U-Boot.
>=20
> The first three patches contain a set of bug fixes and cleanups to the
> existing driver, fixing MMIO size calculations, and removing invalid
> mailbox channel and private-data handling. These changes are independent
> of any devicetree updates and fix issues present in the legacy driver.
>=20
> The final patch adds support for the corrected, syscon-based devicetree
> bindings for the MPFS mailbox. Linux has moved to this binding to more
> accurately model the hardware, and U-Boot already supports the same
> approach for the MPFS clock controller. This patch updates the mailbox
> driver accordingly, while retaining support for the legacy binding for
> backwards compatibility.
>=20
> The final patch is required ASAP as boot is currently broken on master
> for MPFS generic boards.
>=20
> Tested on a PolarFire SoC Icicle Kit ES.
>=20
> Thanks,
> Jamie
>=20
> Jamie Gibbons (4):
>   mailbox: mpfs-mbox: fix MMIO mapping calculation
>   mailbox: mpfs-mbox: fix Driver Model private data handling
>   mailbox: mpfs-mbox: fix driver bug and cleanup
>   mailbox: mpfs-mbox: support new syscon based devicetree configuration

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--3nnxo5+//rllR9Pf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagyOvgAKCRB4tDGHoIJi
0qv6AP9bCmUYnVzZ2Fp57HduKvnKDCK8xJQELaLP+XT4nwIZwwEA0dl9teZwW4+Q
H3aIZidEG60eoL1ieS859LuXcq+CtAg=
=7Aur
-----END PGP SIGNATURE-----

--3nnxo5+//rllR9Pf--
