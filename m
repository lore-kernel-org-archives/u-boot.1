Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B9DCEFCE1
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 17:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B063883B86;
	Tue,  6 Jan 2026 18:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hRpTSAzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3062583B9D; Tue,  6 Jan 2026 18:16:44 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 084DE838E6
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 18:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cdae63171aso823461a34.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767719796; x=1768324596; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4kyYNVzNIwojnCgAmyq+GEJPPf3uD5aSrCAbDsPbKEA=;
 b=hRpTSAznF681Ondsnv1T7oD1GGGGK/WqVWz0yMBJMX4X7AVX10lesZ6iLHtFCCnMCu
 Pt85EfMElLRW3irJF5hIovyEpnUVzmfQ5c8XBuoK+9RZc2MbczduIeTVR+qD0IzDVQEw
 u2OO0sX1wwo/5GaJEgrqG8JH5JA3sGLw4eHmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767719796; x=1768324596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kyYNVzNIwojnCgAmyq+GEJPPf3uD5aSrCAbDsPbKEA=;
 b=B3xyTh7T0HsDgbN4kdUGwt6mLB3M/y+KdjdzfhZfLd3J7FoeyxX7hhQFH9rrYhdzPh
 XCM3ksYuRWKdDsjrCrvEEAZHGQyqoZmZpsovi9dMiLPjDLjodRuLK0tlx2S0qMY/wAwT
 qn+IOutkdof+b3ThO0F0GjJ+fRokYcGYzVSHZ2D5vqvWNWFDzYvHrDd2wOVWmQYcFcPk
 YJsUcsycm0bMCKTYAjHlCtmpnwAklQ2BVx4MFGyhzeDHKnzbeiloCEw1Wpo94to51lAR
 SgtH3OYeJ4NiiMZnthg0re406qi53qzMB7zVHhNKtJvqV3VOZ+d6bKgULpLPr9pNfU42
 NdBg==
X-Gm-Message-State: AOJu0YzBMwWutskOS9YMkjR067SGbjGPubWwSUTkEcMTvavW9pkPTwLx
 mCtno1vbiiVXLgHgHO+IO4RgaJRSg37507M0dWiuw772I/d6VIuM1T9wo7LAMIFO+ME=
X-Gm-Gg: AY/fxX53/MGf/UI2FfN4fFnKzUr1yjaIpNkDCLaKjfRkq0EE6471HQM7I0QW8O42l2g
 UP3T46vqwgmogftaX7YMU7rlIIrcmArfy75tWeEt8S0M6FCfwXPrzQZCefatY85c4YuUhBSuYBf
 gpH0LEtbLyzrTCXYPviGxkuEhEaEHVuJZP7tsGbKk57Oh7rLPvkQ5RlJXQFZmha5VDj1cw2H6N4
 FzdsJ51gGc4W9HGDxUNBg2TJMxZtTnn/jDxVIx2E9ZBD0l+emZv6A3W7SAlVT5G2bEbAFB7d7SS
 KGuHlQJinxIRqMtGQKlOHBbRv0pNxICQQ9sRaxtq2KRrwtiLvg8HobO3pGrlzXe2sRQBZ+E+WXi
 kq5myIUT/7XsZe9r4Qv00vPROPyQM5bHY9rm+gblMptdVAvax1Rt3SW3EfjbXy7kVz8EylyUzAP
 CXvUgxmsP7KDwThZ5S0H7UYOCkOQaXQlZ7Qk/vMlZNphisqpTBSIiOVVj0SqRzDh5UH3+Ga4SHg
 sxaww878NqBSk1M0XB2pHdc/NKRV8G3/gJrQ9U=
X-Google-Smtp-Source: AGHT+IH+VSHwZVllR9Ga85g/EUkzwI+cWgdBZbAHfFnISwhl/T5Yuyxibi1UE/FfolC2MwiQj8dXBg==
X-Received: by 2002:a05:6830:83a2:b0:7c7:827f:2b6b with SMTP id
 46e09a7af769-7ce467429bdmr2314179a34.38.1767719795735; 
 Tue, 06 Jan 2026 09:16:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478d9f6dsm1788870a34.24.2026.01.06.09.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 09:16:35 -0800 (PST)
Date: Tue, 6 Jan 2026 11:16:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, macromorgan@hotmail.com,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, sjg@chromium.org,
 jmasson@baylibre.com, nbelin@baylibre.com, bisson.gary@gmail.com
Subject: Re: [PATCH] bootstd: android: Fix write outside of memory
Message-ID: <20260106171633.GI3416603@bill-the-cat>
References: <20251223234456.1983614-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zd0ISL7NCHfb6gLu"
Content-Disposition: inline
In-Reply-To: <20251223234456.1983614-1-macroalpha82@gmail.com>
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


--zd0ISL7NCHfb6gLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 05:44:56PM -0600, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> It looks like under certain circumstances when reading the vendor_boot
> partition it causes my device to write outside the range of memory
> available. Near as I can tell this occurs because
> scan_vendor_boot_part() calls android_image_get_vendor_bootimg_size()
> which calls android_vendor_boot_image_v3_v4_parse_hdr() which calls
> add_trailer() which attempts to copy information to a buffer allocated
> with malloc in the scan_vendor_boot_part() function. On my board the
> memory set aside for malloc is at the top of the system RAM, and given
> a large enough vendor boot image size this causes the write from
> add_trailer() to occur outside of the system RAM (nevermind outside
> of what was allocated with the malloc().
>=20
> While I don't know the absolute best way to handle this, I would assume
> that if we simply map the memory we want to use to where we will
> eventually load the vendor_boot image that would be the most logical.
>=20
> Fixes: abadcda24b10 ("bootstd: android: don't read whole partition sizes")
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  boot/bootmeth_android.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>=20
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 1374551dbeb..c2c25d53ef3 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -118,9 +118,10 @@ static int scan_vendor_boot_part(struct udevice *blk=
, struct android_priv *priv)
>  	struct blk_desc *desc =3D dev_get_uclass_plat(blk);
>  	struct disk_partition partition;
>  	char partname[PART_NAME_LEN];
> -	ulong num_blks, bufsz;
> +	ulong num_blks;
>  	char *buf;
>  	int ret;
> +	ulong vloadaddr =3D env_get_hex("vendor_boot_comp_addr_r", 0);
> =20
>  	if (priv->slot)
>  		sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> @@ -132,28 +133,19 @@ static int scan_vendor_boot_part(struct udevice *bl=
k, struct android_priv *priv)
>  		return log_msg_ret("part info", ret);
> =20
>  	num_blks =3D DIV_ROUND_UP(sizeof(struct andr_vnd_boot_img_hdr), desc->b=
lksz);
> -	bufsz =3D num_blks * desc->blksz;
> -	buf =3D malloc(bufsz);
> +	buf =3D map_sysmem(vloadaddr, 0);
>  	if (!buf)
>  		return log_msg_ret("buf", -ENOMEM);
> =20
>  	ret =3D blk_read(blk, partition.start, num_blks, buf);
> -	if (ret !=3D num_blks) {
> -		free(buf);
> +	if (ret !=3D num_blks)
>  		return log_msg_ret("part read", -EIO);
> -	}
> =20
> -	if (!is_android_vendor_boot_image_header(buf)) {
> -		free(buf);
> +	if (!is_android_vendor_boot_image_header(buf))
>  		return log_msg_ret("header", -ENOENT);
> -	}
> =20
> -	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_=
size)) {
> -		free(buf);
> +	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_=
size))
>  		return log_msg_ret("get vendor bootimg size", -EINVAL);
> -	}
> -
> -	free(buf);
> =20
>  	return 0;
>  }

I haven't forgotten about this, but I'm hoping there's some other way to
solve this, I'm not super keen on adding another environment variable
(that would need to be documented in a v2 if we can't fix this some
other way). Mattijs, do you have any ideas?

--=20
Tom

--zd0ISL7NCHfb6gLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV1DcAAKCRAr4qD1Cr/k
CrQRAP9yEWKhW9yhWhCX415E1lTDUaDV5zbDdOSzL9U87g0IrAD/af/4d5hr/ACc
7lvH3ZIULi+r/dLeQqmeXDZcMfUFsQY=
=MOt+
-----END PGP SIGNATURE-----

--zd0ISL7NCHfb6gLu--
