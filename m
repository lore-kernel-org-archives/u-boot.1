Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05468C54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 22:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 342E387E3E;
	Mon,  4 Mar 2024 23:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WrDW8cJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B47287E4F; Mon,  4 Mar 2024 23:10:58 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0567687E1D
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 23:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5AE6561058;
 Mon,  4 Mar 2024 22:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D324C433C7;
 Mon,  4 Mar 2024 22:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709590254;
 bh=yWKELBRBqesTAOFLwNiNijD3O3CetsWniWL5e3guPEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WrDW8cJ1e8/hlNdPWdFpj2jscM5KCKhaT+azRpzuAnpvmHE95yKe6tPSb5e8ppKX+
 1uXLHn1701hK1V+sfImq6NcgLmVgRg9lkhTXkZe0stEA7uFvWEBnLkunkAaKXckS74
 sSl+jbw9MhSkVYTbXH0PVj+7Ur95mRIoRnepEUQByTZ8qPMzT5i+IFhj3KKIQPX9Ha
 oIT77DbWyB5F2Bi3Cfl2MvBIZXGYovzV+AGSkox5NgRL1MSXm6EeMCndKis6JoCNDt
 c6Gtkf04lmda+C8LiCWOnxO4Ci8dJEVAQOK/3pjjSz5SbO4vfZkZcwUrmDlj3QN7S3
 BjFn3OrANBRmA==
Date: Mon, 4 Mar 2024 22:10:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: riscv: supports_extension() broken for long isa strings
Message-ID: <20240304-erasure-circling-4591736b70f8@spud>
References: <20240221-daycare-reliably-8ec86f95fe71@spud>
 <d6ce764a-e04d-46d4-bb28-84323f250eaf@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CauiKzpVDJbH07LJ"
Content-Disposition: inline
In-Reply-To: <d6ce764a-e04d-46d4-bb28-84323f250eaf@gmx.de>
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


--CauiKzpVDJbH07LJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Apologies for the delay replying here.

On Thu, Feb 22, 2024 at 01:36:41PM +0100, Heinrich Schuchardt wrote:
> On 21.02.24 18:59, Conor Dooley wrote:
> > I mentioned this last night to Heinrich on IRC, supports_extension() is
> > broken for ISA strings longer than 32 characters. M-Mode U-Boot doesn't
> > parse a devicetree, so this doesn't apply there, but for S-mode
> > supports_extension() looks like:
> >=20
> > static inline bool supports_extension(char ext)
> > {
> >=20
> > 	struct udevice *dev;
> > 	char desc[32];
> > 	int i;
> >=20
> > 	uclass_find_first_device(UCLASS_CPU, &dev);
> > 	if (!dev) {
> > 		debug("unable to find the RISC-V cpu device\n");
> > 		return false;
> > 	}
> > 	if (!cpu_get_desc(dev, desc, sizeof(desc))) {
> > 		/*
> > 		 * skip the first 4 characters (rv32|rv64) and
> > 		 * check until underscore
> > 		 */
> > 		for (i =3D 4; i < sizeof(desc); i++) {
> > 			if (desc[i] =3D=3D '_' || desc[i] =3D=3D '\0')
> > 				break;
> > 			if (desc[i] =3D=3D ext)
> > 				return true;
> > 		}
> > 	}
> >=20
> > 	return false;
> > }
> >=20
> > cpu_get_desc is implemented by riscv_cpu_get_desc():
> > static int riscv_cpu_get_desc(const struct udevice *dev, char *buf, int=
 size)
>=20
> Thanks Conor for reporting the issue. We should change all cpu_get_desc
> implementations to:
>=20
> int riscv_cpu_get_desc(const struct udevice *dev, char *buf, size_t *size)
> {
> 	size_t old_size =3D *size;
>=20
> 	*size =3D snprintf(buf, *size, "%s", info) + 1;
> 	if (*size > old_size)
> 		return -ENOSPC;
> 	return 0;
> }
>=20
> With this change
>=20
> size =3D 0;
> cpu_get_desc(dev, desc, &size);
>=20
> can be used to get the size of the information before allocating a buffer.
>=20
> desc =3D malloc(size);
> cpu_get_desc(dev, desc, size);

That seems overcomplicated to me, if we are just looking to fix this in
the short term. Could we just write to the provided buffer up to a max
of size and report ENOSPC if it does not fit?
That way the calling code in 90% of cases does not need to change and
the supports_extension() code, which does not care about anything other
than single-letter extensions that have to be in the first 32 characters
of the string, can opt to ignore the ENOSPC?

Cheers,
Conor.

--CauiKzpVDJbH07LJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeZG6gAKCRB4tDGHoIJi
0vcGAQCaLoUFt6eVTD4xBeE7iRwQkSS1oBbm85ktjH4MEEL0RQD+O1K/sfMgvlc9
Vl7hypXLy1TwLsb1nAr4H553TalU5AY=
=quIq
-----END PGP SIGNATURE-----

--CauiKzpVDJbH07LJ--
