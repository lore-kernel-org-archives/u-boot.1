Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D682C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229458212A;
	Fri, 25 Apr 2025 16:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R+S6GvFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FF482115; Fri, 25 Apr 2025 16:19:44 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B478B8212A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3f8df49e75fso606713b6e.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745590780; x=1746195580; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ReNb1hPirEiPj5LvzEOanT6YocRGN47irSMZm6kretM=;
 b=R+S6GvFfJGkR1Z0ZqPTA9Ck7VhwhzapqmLd1/bckZ6J34N1vyEz5kBC7Lqr6GOaAMl
 fTvDugyB66JkuaBP+wa2vQgMXGbDkz6CMoSWaP/vdAVNH1au2VbCB3pEc3RqAQXEbMBm
 9mTlxshSP2NmRpxHeQu/OWTUVMPM29lf3yM9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745590780; x=1746195580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReNb1hPirEiPj5LvzEOanT6YocRGN47irSMZm6kretM=;
 b=lSy79pzNykBFuT9TUKUYUFw3frllPc9Edb0vy53UXbS+L7d2ZiUasysN+B767YlAHZ
 H9glhUgVdaV/Lhm/lWzco3bvVAyUheaHE8dGE9bxsJXt9AsxhPjlae8p1OwLo6E34JQl
 ow24RNdfXxYzmo2GkY4LA+RLsp0akvG+c1llh6PUUNXBFYJxf2fPQmPdRrSOyDuJ/Pe7
 8A/VNuV/wvQxlnLHGsnWZNa6hToXV381/BdQLCD8bq/Hq6gX/8VgA+jHywXhK3BtIXy1
 QpjXpL62Idqi0wndI/4r/TzxoAmu7FxDG1BF4sLGOfSDr/bE/FBxyMo5iM2PaPD+g45I
 fbfg==
X-Gm-Message-State: AOJu0YxoOXfACwGTOdiUgnrROy3rKPm6fPmOuQniDRmgo6WqugwZAMaH
 9OSjIYdgVzze1wm7FfIzDFfy64AH1ZxMB90KhsDKIC9SMEhDWHPGL2Tc/slBjWSuXXq4+86RolO
 A
X-Gm-Gg: ASbGncvDVpz9Ieafi/XVVA/4bPjFrYKoXXeBanv1PxYODvE0OevTFRzt26DfEHkY5kM
 vIXDCz4yb0OSPQM8eC9PTX2TLBqxxRe2MzvEXEICKxpzPsD5kUkm0s30k/Ayi56oLlOX8Kha8nA
 aaPrnZeQ6rITkIigQnyP7YEqWi5PbYk+0nyuEm6KUpjKJGTzKR4Vk19blbdNASgy+5KZMeQBjk1
 ySIuVvZ/LrLXDXE4sW1MX0tGR4b19+BgJhD5kYyBeIINX0ITow9DNeMI+jMkeAFQ4aiOmwcosdu
 kBfpb2z0TxgWTAgSmmBlzs3D6RWkj+JyAdnQ98FKX7Qgltw4gA/RralHl9vyxw2JSSbziliAfx6
 YQWfbUnBOQtgl
X-Google-Smtp-Source: AGHT+IFDDFg/OqNO+g3MX7VytKm4YhGzF7DNkdUjJQk6Ttp5LqYmHK1kHM8nhmd7Fy7j7ovnj1HkoQ==
X-Received: by 2002:a05:6808:318e:b0:3fb:54b0:caf6 with SMTP id
 5614622812f47-401f2b10715mr1656604b6e.36.1745590780471; 
 Fri, 25 Apr 2025 07:19:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60646862ec5sm726336eaf.3.2025.04.25.07.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 07:19:39 -0700 (PDT)
Date: Fri, 25 Apr 2025 08:19:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] mtd: mtdparts: calculate mtd partition offset before
 calculating size
Message-ID: <20250425141937.GT5495@bill-the-cat>
References: <20250425034303.77100-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jN//C3c4yh+0NJX0"
Content-Disposition: inline
In-Reply-To: <20250425034303.77100-1-weijie.gao@mediatek.com>
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


--jN//C3c4yh+0NJX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:43:03AM +0800, Weijie Gao wrote:

> The mtd partition offset must be calculated first as it will be
> referenced when calculating the mtd partition size.
>=20
> Change-Id: Iccfd101b0a9597ac240c25670da638a82af28980
> Fixes: 1ca97ee9039 (mtd: mtdpart: Support MTD_SIZE_REMAINING with unalloc=
ated memory area)
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Reported-by: Francesco Dolcini <francesco@dolcini.it>

> ---
>  drivers/mtd/mtdpart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 3f8edeb5093..99bea6f1c85 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -236,6 +236,10 @@ int mtd_parse_partitions(struct mtd_info *parent, co=
nst char **_mtdparts,
>  		if (ret)
>  			return ret;
> =20
> +		if (parts[idx].offset =3D=3D MTD_OFFSET_NOT_SPECIFIED)
> +			parts[idx].offset =3D cur_off;
> +		cur_off +=3D parts[idx].size;
> +
>  		if (parts[idx].size =3D=3D MTD_SIZE_REMAINING)
>  			parts[idx].size =3D parent->size - parts[idx].offset;
> =20
> @@ -246,10 +250,6 @@ int mtd_parse_partitions(struct mtd_info *parent, co=
nst char **_mtdparts,
>  			return -EINVAL;
>  		}
> =20
> -		if (parts[idx].offset =3D=3D MTD_OFFSET_NOT_SPECIFIED)
> -			parts[idx].offset =3D cur_off;
> -		cur_off +=3D parts[idx].size;
> -
>  		parts[idx].ecclayout =3D parent->ecclayout;
>  	}
> =20
> --=20
> 2.34.1
>=20

--=20
Tom

--jN//C3c4yh+0NJX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgLmfkACgkQFHw5/5Y0
tywh2gv/XB6R8ngIinIkQevhi7nq5ug9SVJhQojcP4Zkhof6Svhg2/riTspsX0xZ
lwK+b3Y/NL+vgdY/pV17GQQi5G9hTdMNWNILQMEGAKJlve0oz/ujPi0EyAXoQWs7
7Cg08Xa0H5lYWPF+0YNZIdvIMlXb391N8daiX4TBcJtj/oiYz6st9sxw9DwbBR5Q
ChRcskDduA5FPVbV/PubDUFkbmDR6qV6TEXeUE65PDraY68EQH+AVk0CM5NfPlwS
OY/yUKAr4S1mK0JiGRt9KpC8A6vd7XfxCldYEWkI6iyM71Fg//9QUCoWM2ZY/0Rb
/pYGV3Jd5KzqcDt4POa6FVcGGWgMxF6zVxWXvX2zNMn4S/uMjktijyKKCQeSuNFX
B+M8M0Gc71+AsX+MVRfIlbI/ttX4aboWC650Gjb/bXQGnanZZ9DSQZEx0ixLbEE9
jkjb0aQDYl63PprIj25KiVELFOaFA3lA+ZrrVQp8HYvPN9GeCRR9oyb/QgZ4L7ll
g1nB6Zdq
=zTwK
-----END PGP SIGNATURE-----

--jN//C3c4yh+0NJX0--
