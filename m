Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57930CEE35A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 21:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFD283966;
	Tue, 18 Nov 2025 22:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O9sDZkUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26D418397D; Tue, 18 Nov 2025 22:34:05 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FAA83957
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 22:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-450b3f60c31so1007760b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763501641; x=1764106441; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=px/An4ObsXDNJw43R6S6ZhNq6lUyFXNWEDC8spwDDpo=;
 b=O9sDZkUi0W6XkadqUV2+QjM07Lsc68+VhysDq8csmutP+KVj8uRZ1lvUOcJ3J7UG8G
 8Bgex69cFlGTiFv2FQTulYe92ifodQF4XIFvSqQ4/6+yzNsNG7BykURr9MBTseSyDc3I
 3/tiDP61uwUJVWVM/quMqV5GYWAF6+ohCmKOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763501641; x=1764106441;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=px/An4ObsXDNJw43R6S6ZhNq6lUyFXNWEDC8spwDDpo=;
 b=XZcWKy0PjpGXET4yLg3KpbR6DRgaM3lgiKRwCr6PjWhiCmucRwEjIYUFVt2KA9wZcu
 jRGD8VfsSygG8i89Ur8kacDjxvoSx9ARpW9yJz68u1gyA1MwgUODfkkz582AEXT20PKu
 nAzNFQUZaVktQifhhW7TpEVPl49leeRn8iHmynOW5ah3HCuIlVbrr3GIQHkVWRkby3kA
 Q6pVFWIsrYxxkKChyXieCHl5+rT5XFYCfMakQersZ6kAdT9aHvlfT0GrRB+oa8gLDlMs
 K4o9Yp/DvQgEUZszE5UTUE5vCKJYVG2a5Grrh0ZEsBHjrDqZwGfOizC6XCMyB3Y2FSQh
 Woug==
X-Gm-Message-State: AOJu0Yy2kjEBDl0j/TlTiK8lCOKOEqmTISOf/FKJxNemlO5VsHjtVLWN
 bqmeXUWPlacGmPCkxxMsKZDSX3gBsC1tpNsgl18h3nE3kwxA686Bo8g04wi/Lsbyyds=
X-Gm-Gg: ASbGncvp2RaKPdjP1EdHUOIhDF1pumJtSV3H4cEAJEH+DYPui7W/DqisxY5dAAVn+Gs
 /Ik8zddnhykZz/tceibDhPWUxuJw9uQ/2BZU0Zlyyr+jBajetAvNPWfQ+3aUgladXUOnXU1OQEy
 rhAox8QcwYiQt+7CGhh/w7D59wrF6YdYYPQbNE/OghlJINjAzf1Q7uTGOgO0ShUGIZllOV43gud
 WmFrCgrNe+55KDoHEMy4uh3K+EP73AT4OlbeVTdQA3zwqmDem5CdoRrjmhOq02fishxZ8Zk6THf
 EFo9DlWmvKz4bDfTfY4R/cUuTFgzi+oALd8vc3f+HaI+eaV4phZ3lyEouhyYKHVBxOzI/00OnT6
 k+n9NsZG4oeYo6qKAyYwogHoeZgr2gyY7arC9l0q04AMZIemMLZ7vl3Bf1L0pK4/V5V3r4sHJcv
 QE4f1DktOQfPInfbOE63OoUIS7M+v5+1pn8jxSPInaLj9rf/WObhmoAn4pwWAY
X-Google-Smtp-Source: AGHT+IHJshXsARfkx9iMToQePfrV7AdQ4tm5vavHnUebZArmCLXU2FvhOyvwJw/C2IORwkpjANtmdQ==
X-Received: by 2002:a05:6808:c2fb:b0:44d:b8d3:3214 with SMTP id
 5614622812f47-450973ba4f4mr6796005b6e.3.1763501641552; 
 Tue, 18 Nov 2025 13:34:01 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450d7740809sm1598004b6e.15.2025.11.18.13.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 13:34:01 -0800 (PST)
Date: Tue, 18 Nov 2025 15:33:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: Fix realloc error handling
Message-ID: <20251118213359.GA630712@bill-the-cat>
References: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9Fm4ewukLwA24G2W"
Content-Disposition: inline
In-Reply-To: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
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


--9Fm4ewukLwA24G2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 01:49:30PM +0100, Francois Berder wrote:

> If realloc failed, raw was not freed and thus memory
> was leaked.
>=20
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  fs/erofs/data.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 95b609d8ea8..b58ec6fcc66 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -319,12 +319,15 @@ static int z_erofs_read_data(struct erofs_inode *in=
ode, char *buffer,
>  		}
> =20
>  		if (map.m_plen > bufsize) {
> +			char *tmp;
> +
>  			bufsize =3D map.m_plen;
> -			raw =3D realloc(raw, bufsize);
> -			if (!raw) {
> +			tmp =3D realloc(raw, bufsize);
> +			if (!tmp) {
>  				ret =3D -ENOMEM;
>  				break;
>  			}
> +			raw =3D tmp;
>  		}
> =20
>  		ret =3D z_erofs_read_one_data(inode, &map, raw,

I'm not sure how this changes anything? The function is currently
(snipped for clarity):
static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
			     erofs_off_t size, erofs_off_t offset)
{
[snip]
	char *raw =3D NULL;
[snip]
		if (map.m_plen > bufsize) {
			bufsize =3D map.m_plen;
			raw =3D realloc(raw, bufsize);
			if (!raw) {
				ret =3D -ENOMEM;
				break;
			}
		}

		ret =3D z_erofs_read_one_data(inode, &map, raw,
					    buffer + end - offset, skip, length,
					    trimmed);
		if (ret < 0)
			break;
	}
	if (raw)
		free(raw);
	return ret < 0 ? ret : 0;
}

And per include/malloc.h, calling realloc with a null pointer is the
same as calling malloc. So we had nothing previously allocated to free
later when this failed. How did you find this particular issue? Thanks.

--=20
Tom

--9Fm4ewukLwA24G2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRzmQwAKCRAr4qD1Cr/k
CgLXAQDRdyhrDmbFJixMW8arOSH+Uw5JkdxDevERmNsHNtLcdQD+MAPbw1cM67WZ
pK8pXwLZxyflrzkyGSJ7XNVzPEEhdQQ=
=pP/h
-----END PGP SIGNATURE-----

--9Fm4ewukLwA24G2W--
