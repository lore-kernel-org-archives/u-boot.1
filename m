Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62338FD377D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E833882A9E;
	Wed, 25 Feb 2026 18:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qy4gfwGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF78A83D8A; Wed, 25 Feb 2026 18:57:27 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65C198003E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4ACE360097;
 Wed, 25 Feb 2026 17:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC82C116D0;
 Wed, 25 Feb 2026 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772042244;
 bh=Oy/dnG5o7YCc+kMJlXlea35TMJs2/qb8te2SBG0inQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qy4gfwGJ9C+wsIJAOKE4C6VwTZfGejYXPNp5ItOBAW/gurBoddUqE/xaDAeaIfmn9
 XeaxPX7dFcqNX3zSKu/JlGksGu3MWmSxoC4i62tdbaR4bVDjpmTapmfhKJet+RA+nk
 1Cb0w6rF4pl1A+L3nUN/NTiV3OchP47LbBHhEGweFsGqwE/6JUbt4sYo7cNtlL885T
 /SG4xQucjiSyn6OMs+rSbhR6OZFR5JWkZyeBg+N6WI07N8LVtsgHmeoXb1nCZUNb7T
 w+R15/nvcuWaNOHuDNTWDZRwkLbM2qBHtEWchXQjO74sJCuUUp1mLhf85E8HIsXrHa
 CtAaNavY6pa8Q==
Date: Wed, 25 Feb 2026 17:57:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Conor Dooley <conor.dooley@microchip.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT
 don't exist
Message-ID: <20260225-immovable-written-2928e53358ea@spud>
References: <20260225175229.88858-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JYdRKZgspZ8snmTx"
Content-Disposition: inline
In-Reply-To: <20260225175229.88858-1-heinrich.schuchardt@canonical.com>
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


--JYdRKZgspZ8snmTx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 06:52:29PM +0100, Heinrich Schuchardt wrote:
> Don't imply non-existent symbols CONFIG_SIFIVE_CLINT and SPL_SIFIVE_CLINT.
>=20
> MPFS boards neither use SPL nor do they run main U-Boot in M-mode.
> So we don't need CONFIG_(SPL_)ACLINT either.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	Describe why ACLINT is not relevant here.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--JYdRKZgspZ8snmTx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ84AAAKCRB4tDGHoIJi
0vpMAP0YZ/17PwlL6j+gVmP35EzGiHkgrZLq4EpmR/Dp16IELAEAx2PZivFDIIZU
emkmRBQGn1ou3Pc4Dq/BG9g8PRiy+AA=
=zMt/
-----END PGP SIGNATURE-----

--JYdRKZgspZ8snmTx--
