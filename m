Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE63C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 15:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B77876E4;
	Wed,  6 Mar 2024 16:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rr6uA1Yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26730877FB; Wed,  6 Mar 2024 16:22:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30D5875FC
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 16:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BD4CF6182E;
 Wed,  6 Mar 2024 15:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBA9C433F1;
 Wed,  6 Mar 2024 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709738526;
 bh=AXjNrYceTkb2xMRi1UGACEXwcWmbjz+TAGf8VwbIr4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rr6uA1Yuu0JsHqcF4DQJCFDX3tPhV/41V4l8oQ0uR4OxsR/hE/upKMG0qbXR82Rkb
 rVSuBvj7IJcQf+JwYxFhy6dywLsnKUsNb+yo0nvsAVR7VJViclL38B9MHy+RmRj4Xa
 hHCY6xbqQs3U9SppQ1cGCWCy7Gaj1YuY/g7ABUbHd2jxQqpRv5/MZNpFiHak6KTqRs
 REQ+JKjPxuQaKMwS9a9Tem5AUAWkySCG0ddLcbVtggzPtLUG902UIzpCzq355+qTmD
 gXozevQNuYka9zPQYZ/7JQmj6irZn5PqO5tsGl4zJeMw1sbHJ/eMG3wBqqqRKGlPiI
 22SW/80bFV4BA==
Date: Wed, 6 Mar 2024 15:22:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: sbi: Correctly display unknown implementation IDs
Message-ID: <20240306-thank-swell-8956436a56a7@spud>
References: <20240306144402.175957-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SJPpb0POgHzdzNKs"
Content-Disposition: inline
In-Reply-To: <20240306144402.175957-1-heinrich.schuchardt@canonical.com>
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


--SJPpb0POgHzdzNKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 03:44:02PM +0100, Heinrich Schuchardt wrote:
> For an unknown implementation ID an output like
>=20
>     SBI 1.0Unknown implementation ID 16777216
>     Extensions:
>       sbi_set_timer
>       ...
>=20
> was shown. The number 16777216 is not the implementation ID.
>=20
> * Show the correct number
> * Use a hexadecimal output format
> * Add a missing line feed
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>  cmd/riscv/sbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
> index 9daf0e247ad..87f7966f06b 100644
> --- a/cmd/riscv/sbi.c
> +++ b/cmd/riscv/sbi.c
> @@ -99,7 +99,7 @@ static int do_sbi(struct cmd_tbl *cmdtp, int flag, int =
argc,
>  			}
>  		}
>  		if (i =3D=3D ARRAY_SIZE(implementations))
> -			printf("Unknown implementation ID %ld", ret);
> +			printf("\nUnknown implementation ID 0x%x", impl_id);
>  	}
>  	printf("\nMachine:\n");
>  	ret =3D sbi_get_mvendorid(&mvendorid);
> --=20
> 2.43.0
>=20

--SJPpb0POgHzdzNKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeiKGwAKCRB4tDGHoIJi
0to8AP95KX3JmET3hrJgkSaxo54dQOoqUShWCHh5VNXRTnv1pwEA41CgbNAhYmJc
Lgg0kI/PexSP7lhfZK0RtvFFne8kfwY=
=YduW
-----END PGP SIGNATURE-----

--SJPpb0POgHzdzNKs--
