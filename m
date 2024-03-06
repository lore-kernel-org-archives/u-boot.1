Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7FDC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 15:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DAD87666;
	Wed,  6 Mar 2024 16:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZEzgb9l+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DAA787666; Wed,  6 Mar 2024 16:00:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C761886BFA
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 16:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0EE3361804;
 Wed,  6 Mar 2024 15:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D57C433F1;
 Wed,  6 Mar 2024 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709737213;
 bh=2AJOvHbkHWAm1zBiGQK1yV5ZlfP2MMs0xcqalYrbL9Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZEzgb9l+BbjWdpzi/a5R7NuMZjjjNHIqtuoZjHEMipmXo4kSpnemusuBN33x5+mU+
 0hy9CrpIaXMuNNZ7D3ajo/Opjf1aBeI6xE8gVlplwoibXqxA8IskV3ORbsJjVXW8Lv
 QYFWoYFIetI0KmI87uFT7FSt/N8J3O4eRWBcy85uf2SFujdnRvrU6S09qHUoCeawLQ
 iZVpJ7Cf2FltHul75/PfZXtUZZ45jpb5QCjE+5p1nugHspGUrbmOJyWmRp+ip+hPUj
 j4xov61QiGQGqY7QOrQ7vjfcp8WtkoC4VFRaOXgcPtIqOedwbH/SqbpcHNC7QBm1vf
 xFOf+KPjcI7VA==
Date: Wed, 6 Mar 2024 15:00:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd: sbi: formatting PolarFire Hart Software
 Services version
Message-ID: <20240306-bootlace-distaste-9b766b0b4c98@spud>
References: <20240306144852.176337-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gl89mJMNkuWPkqVz"
Content-Disposition: inline
In-Reply-To: <20240306144852.176337-1-heinrich.schuchardt@canonical.com>
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


--gl89mJMNkuWPkqVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 03:48:52PM +0100, Heinrich Schuchardt wrote:
> The 'PolarFire Hart Software Services' SBI implementation returns the
> version of the incorporated OpenSBI. Format the number accordingly.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

FWIW, the reason we added a custom implementation ID is that because the
HSS doesn't run out of DDR we don't suffer from a bug that affects most
OpenSBI versions where it fails to mark the region it PMP protects as
reserved. That bug is present in the version of OpenSBI we use and
there's no plans to move to a more recent version because of space
constraints mostly. Since the bug prevents using some forms of suspend,
we moved to a custom implementation ID so that there could be
differentiation.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  cmd/riscv/sbi.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
> index dec7dd651d6..628ef3a591c 100644
> --- a/cmd/riscv/sbi.c
> +++ b/cmd/riscv/sbi.c
> @@ -80,6 +80,7 @@ static int do_sbi(struct cmd_tbl *cmdtp, int flag, int =
argc,
>  					break;
>  				switch (impl_id) {
>  				case 1: /* OpenSBI */
> +				case 8: /* PolarFire Hart Software Services */
>  					printf("%ld.%ld",
>  					       vers >> 16, vers & 0xffff);
>  					break;
> --=20
> 2.43.0
>=20

--gl89mJMNkuWPkqVz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeiE9gAKCRB4tDGHoIJi
0qhbAQCA4g/YZX0/wv3NSy55weLAQ0/l5nJ4RIrKgkw73diMRgD+KHrCnW+I8yhP
O9YyUY5MthfiS6PnGOco4AV/VK/5EQo=
=L3YX
-----END PGP SIGNATURE-----

--gl89mJMNkuWPkqVz--
