Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9CEC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 17:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460FF88A75;
	Thu, 15 Aug 2024 19:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YkLb0nK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E5788A7D; Thu, 15 Aug 2024 19:01:27 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB145887D4
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 19:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db12a2f530so708708b6e.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723741272; x=1724346072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2iAYURPNYfS9Sj7rZsrHpKFY/1l1tHw//2d+0sl6eNA=;
 b=YkLb0nK6SNUxlsT3dphzIwU6LbE4xnwuliLI5zRlspBVRQHdeanoILjQYImLS0RGKO
 Xxv8XeTHAYJfW1A2jFkBWXl+jDBNOvtlYj2+qbfhpdXDfLwMKEM8yjwWnpfprxsWIn22
 MPqDyzErHh3eDgqrcJqRWpbPmZ4pYrPf7qof4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723741272; x=1724346072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iAYURPNYfS9Sj7rZsrHpKFY/1l1tHw//2d+0sl6eNA=;
 b=HtkKM50fnBYcr5dOR2cteipD5rPU4He3pphzfcJS8KOoxZbXInwyxj65/qSVAMCVVq
 XozG+a4LPn9liUyUZZMMwL9pltQMPlhb66Ov+7bZl+e75wYuXaP6fTMZgmBgxXp8DJwV
 Z6lJcZVzDXnVSGVp8BXloWjFxR3cqqrCk9S6zG9HpQr/drdQvCeJVU7uVwRN6q4Ag9LC
 6ktSbUGb8Lmf7u+OqnPcIFjtB3Hbvdp9X99XxvV/WmiJBfwiOnG25eW4epHv1MXOJknR
 YxTX0qIop+Dyg3ziofwjoLX136bH/5kesVoiDbLBF0cwaUbkyBHYfFT1J4dhGw1dJlIY
 HFKA==
X-Gm-Message-State: AOJu0YzKgn580wk3KpeefDgqjuDYxzTxLvvFpYC5vaWTcLmAqRbdtaHX
 y3ATWL9PQhfgeOuQq0zXEdrenIAB7xSKW5ZOv7l6HI/lZFzq/SWh7pUEz9gvWMjUX/zmjC72ELz
 MfGY=
X-Google-Smtp-Source: AGHT+IGwJElwBwHgvNOogaehy0UZtw+jRP0reuMMoqfLloMJuvNGWx+9N45sOfGLEorz3xppEu5mrw==
X-Received: by 2002:a05:6808:148a:b0:3da:e219:bf with SMTP id
 5614622812f47-3dd3ae320edmr9389b6e.43.1723741271614; 
 Thu, 15 Aug 2024 10:01:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33d884d4sm321460b6e.29.2024.08.15.10.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 10:01:11 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:01:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 06/21] mmc: Drop the blank line before accesses
Message-ID: <20240815170108.GU1626301@bill-the-cat>
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G6paFLoYM0jyxVqL"
Content-Disposition: inline
In-Reply-To: <20240810205205.3403177-7-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--G6paFLoYM0jyxVqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2024 at 02:51:50PM -0600, Simon Glass wrote:

> Several mmc subcommand print a blank line before starting and after
> finishing. It isn't necessary to do both, so drop the first one.
>=20
> It is questionable whether these command should produce any output at
> all, but leave it for now.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  cmd/mmc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 7244a90f4dc..ff7b8e555ba 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -238,7 +238,7 @@ static int do_mmcrpmb_read(struct cmd_tbl *cmdtp, int=
 flag,
>  	if (argc =3D=3D 5)
>  		key_addr =3D (void *)hextoul(argv[4], NULL);
> =20
> -	printf("\nMMC RPMB read: dev # %d, block # %d, count %d ... ",
> +	printf("MMC RPMB read: dev # %d, block # %d, count %d ... ",
>  	       curr_device, blk, cnt);
>  	n =3D  mmc_rpmb_read(mmc, addr, blk, cnt, key_addr);
> =20
> @@ -265,7 +265,7 @@ static int do_mmcrpmb_write(struct cmd_tbl *cmdtp, in=
t flag,
>  	cnt =3D hextoul(argv[3], NULL);
>  	key_addr =3D (void *)hextoul(argv[4], NULL);
> =20
> -	printf("\nMMC RPMB write: dev # %d, block # %d, count %d ... ",
> +	printf("MMC RPMB write: dev # %d, block # %d, count %d ... ",
>  	       curr_device, blk, cnt);
>  	n =3D  mmc_rpmb_write(mmc, addr, blk, cnt, key_addr);
> =20
> @@ -362,7 +362,7 @@ static int do_mmc_read(struct cmd_tbl *cmdtp, int fla=
g,
>  	if (!mmc)
>  		return CMD_RET_FAILURE;
> =20
> -	printf("\nMMC read: dev # %d, block # %d, count %d ... ",
> +	printf("MMC read: dev # %d, block # %d, count %d ... ",
>  	       curr_device, blk, cnt);
> =20
>  	n =3D blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
> @@ -411,7 +411,7 @@ static int do_mmc_sparse_write(struct cmd_tbl *cmdtp,=
 int flag,
>  	if (!mmc)
>  		return CMD_RET_FAILURE;
> =20
> -	printf("\nMMC Sparse write: dev # %d, block # %d ... ",
> +	printf("MMC Sparse write: dev # %d, block # %d ... ",
>  	       curr_device, blk);
> =20
>  	if (mmc_getwp(mmc) =3D=3D 1) {
> @@ -455,7 +455,7 @@ static int do_mmc_write(struct cmd_tbl *cmdtp, int fl=
ag,
>  	if (!mmc)
>  		return CMD_RET_FAILURE;
> =20
> -	printf("\nMMC write: dev # %d, block # %d, count %d ... ",
> +	printf("MMC write: dev # %d, block # %d, count %d ... ",
>  	       curr_device, blk, cnt);
> =20
>  	if (mmc_getwp(mmc) =3D=3D 1) {
> @@ -484,7 +484,7 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, int fl=
ag,
>  	if (!mmc)
>  		return CMD_RET_FAILURE;
> =20
> -	printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
> +	printf("MMC erase: dev # %d, block # %d, count %d ... ",
>  	       curr_device, blk, cnt);
> =20
>  	if (mmc_getwp(mmc) =3D=3D 1) {

Did you confirm things look right still, on hardware?

--=20
Tom

--G6paFLoYM0jyxVqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+NFQACgkQFHw5/5Y0
tywxzQv/bp4d0H5O28rgQ3Ob3RKhUFfeCZaaqTt27QJ3gaDFAtGoXT3d9qYXLP/M
T7lIiJsOCBiga11Ec2LSEXYdPk9y8TVfzJFeNLbAhEuZopv21lSdM1swAQ1vFBT9
YTgsDd/IYAKMG9pm3gBZDcBCtNhNTjJuHpce71dFJTsI6R6YPJ/eEqleGEWOJB9Z
xb9Rn9MKwURcvUUoZzXzSkwEitm+5ZOKyahPRwtDSrcPh4FKPjsn8qVKBNuKL6gu
JFDSuDGWrPvlGFz+Son+tqYRW5Gw7YgQaTm9mH3qfcNAjfxNlKgQF//uVyoUPBLX
fNiN7Ptapp6HWSUZ2duBl0JwRUtCZB/rzo1cIROxn92RT+nImKQDOTM2aIyF6+Jt
4nxLDwQM9erll7vJdVZA/334zI0m/G4mQK3hioBFY7X968cFIdbtZ9xAEcseaegS
c1sGX6D1v1xBO1R2gQxq1cutJY/sD/lVk7FIbhzJbLBOgHiKB4NpzeGGi5Tlvl33
yVcoX3Bs
=/ycx
-----END PGP SIGNATURE-----

--G6paFLoYM0jyxVqL--
