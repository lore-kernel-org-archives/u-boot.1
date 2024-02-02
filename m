Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00587C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D7887B7F;
	Fri,  2 Feb 2024 14:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dIfBXJMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480E787B7F; Fri,  2 Feb 2024 14:51:35 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C42877BB
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-604191522daso20734387b3.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706881891; x=1707486691; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a+AKf5Us8AL6QEs+i2cjyXi2mnORovjO0efCuGV6JCM=;
 b=dIfBXJMdpYU/Mni/nYQdINgofVp9V4nQbRYOtN8y1n5DTI3ZJRxRxMUiL7n5cjyBS6
 TYu3qkhWAzsMT672fMMvB/CBHcHvT0MzrpQIfj702mTDFbHAnisvd+rci/yD5gXNYX+e
 ZuWESuDwrONhWndZQVZFnZyuYWPQfczpadb94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706881891; x=1707486691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+AKf5Us8AL6QEs+i2cjyXi2mnORovjO0efCuGV6JCM=;
 b=Il492O46v3hM2YtQ/kSwQ2+iAuYf0XB8MiTkJDndwuycyelfv7psfctgDBkxQmUJ4t
 ta8PrrFkQrj5JQ5gXFnrVVvQv3/Msek864OAYmv1Kz/a6XSjEL2JRWKawaEKkGr24/ap
 rq8WQzf1Asp6wK2zU1cmVn9XTxFg9nelfEgmbRa89TakItUt3E/+TMiKV5yZN+POzPJG
 lIlyvHYWObeR2m281CQrS8LZfwkRyZ+rjoTknzhcN9HHj7c/RPffdVxGu11IoNmHJ/j6
 RriEZgwQMwu3ZBPKWK3fTfaEVAcnZdiU64HqmpAUit9NRvHJJUHYOjH5Tj/8rHFuzsnS
 /ucQ==
X-Gm-Message-State: AOJu0YxUwJ0nMg278SAd9Wn2+YLkSvB/ASQiLkt7JsJUNIf3m5wbi1SA
 1yrl2tDfvKgkOuYjoguwN1W0NsXmsL0u2ls79kxFfo0PCOTKK7DM/QJsb5JceM0=
X-Google-Smtp-Source: AGHT+IGKQX+F8MGUSRKWn2KpD6DORO3rpoHep4FJlwZ/iRdeLlLgxoy63tj/a9420RO8DcVRznpr7g==
X-Received: by 2002:a0d:e28a:0:b0:5f6:d2ee:2686 with SMTP id
 l132-20020a0de28a000000b005f6d2ee2686mr8837801ywe.2.1706881891683; 
 Fri, 02 Feb 2024 05:51:31 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXMYLwgvijP1m44Z8jXrSK52TSDYi07D7eHYk0xHTh4CF5xEVHu7HEWjAodbvQPhTa8f8lpjwbfU/kZkaLoc9AQu2gX9lRs7vnW+zseMCyij6hWEtXGLd9pFn1uT/vse3Mwnm11LgCc5X4=
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fl13-20020a05690c338d00b005ffc15cea80sm410415ywb.26.2024.02.02.05.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:51:29 -0800 (PST)
Date: Fri, 2 Feb 2024 08:51:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] mx6sabresd: Fix U-Boot corruption after saving the
 environment
Message-ID: <20240202135128.GA1152441@bill-the-cat>
References: <20240202014849.4022787-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SupZ30t2rJxGm7Pm"
Content-Disposition: inline
In-Reply-To: <20240202014849.4022787-1-festevam@gmail.com>
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


--SupZ30t2rJxGm7Pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 10:48:48PM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> U-Boot binary has grown in such a way that it goes beyond the reserved
> area for the environment variables.
>    =20
> Running "saveenv" and rebooting the board causes U-Boot to hang because
> of this overlap.
>    =20
> Fix this problem by increasing the CONFIG_ENV_OFFSET.
>    =20
> Also, to prevent this same problem to happen in the future, use
> CONFIG_BOARD_SIZE_LIMIT, which can detect the overlap in build-time.
>    =20
> CONFIG_BOARD_SIZE_LIMIT is calculated as follows:
>=20
> CONFIG_BOARD_SIZE_LIMIT =3D CONFIG_ENV_OFFSET - u-boot-img.dtb offset
> CONFIG_BOARD_SIZE_LIMIT =3D 0xd000 - 69 * 1024
> CONFIG_BOARD_SIZE_LIMIT =3D 781312
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  configs/mx6sabresd_defconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I don't like when we have to move the environment like this, can we trim
things down instead? Perhaps LTO?

--=20
Tom

--SupZ30t2rJxGm7Pm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW881wACgkQFHw5/5Y0
tyyPfQv9EzShBLp6DoElLl3Dkw0dKESYgJGr0h+MoGQxggeK16J8EjCbgdnsww8R
uqAlj4hKqqXDZ7sYzfa/5tKwTBRsnVZYztFEEoLuHCsNKmVIDCLHgVy4OKOu4wb6
TN/y7qdorChjPG0YhgboSsvoT/aIppvQTDjt1sG8XfhyuRBWi6+Egs6uUm1HKveW
36HuQ2Yqvz7P6cjlXhv8NwZ9gSXOGIWRqRW/MF3EmyELJ3N9xG6oCjRlDDqgrIsX
l0oJIWJqYGjuph/G6La+0OPUqNf8pGvR/3nbgQH9rwOF4AX0WdkSrnAMjJyZSmBP
Lvo0ngC5i+VEegMBPfdUYmPKcaxSu1rJk29f4cmp3negqa7G0kvJNSPBXaIBXL9o
dFODLGuA+SThn/cvMSj7R0yAcSE3dJkJ1b2EZGARgoJvPLaXWOUoaTKbubzFcBzX
hOsxCDI2EawRWoieRmEnqYab1ad94ifEWc7m7iprZ+jj+lBZnLGbHXC6X57bJ3Uj
6JK6Z0oo
=Z57T
-----END PGP SIGNATURE-----

--SupZ30t2rJxGm7Pm--
