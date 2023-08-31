Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1ECC83F36
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2259386561;
	Thu, 31 Aug 2023 16:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uTnPmCWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3DD865A3; Thu, 31 Aug 2023 16:16:46 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B0D855CE
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-58d40c2debeso10510347b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693491402; x=1694096202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2l1VaQTc05cDDjKgpJnKDBILyUM8gOytGWIKme/6GQ=;
 b=uTnPmCWCbhPX2e9cGHfHg4XGDlViwVxOJ6EJ3/H4mK1DiNBRr7fBnZo5h6RmxVpiJ1
 nlobnkttQra313d25JhokPnRrrMJTlWagzCchTLWTHTHXqYw9d7JaxR0x9vdfoaMEy3o
 azn2ucpmIhcYu8jgU1hh7REDIsQY7veZ7Bcgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693491402; x=1694096202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2l1VaQTc05cDDjKgpJnKDBILyUM8gOytGWIKme/6GQ=;
 b=VnNE7HsLfmuVFXiXeuifK61x0QCqA6c0UJ6rTmtUwgslGfwCfpPfzkH7yWO0IwXgKe
 PfMW8jny5cVyvKLUhrt/CkhtNNyZaarrRiS0iQVSrG2Na4eLLJvFwOhOdqPfCFkVoPSk
 GosdxNmmCciv5Vn78p3joUql6Q359oHkldt3/WPZbl+8nE9LQZmCl4oItLQmb/O4QO/3
 NWWkqd+5xKIp+S7jDh6r5FFAQ/rN3+QKHzBpzoEEdUAGZKRRTgUL2NPAG4Y+qGxzYQ3g
 kG7qXVUID9GMKgc1D1mr8zOj/FGbEvlagFOcwVqU5FztWZnX384YoPCrEZraeaD93q5d
 xgzA==
X-Gm-Message-State: AOJu0Yz9vhnxoQKxmBN9rPVVKrA+fshfbX4y9pqrlcFDSpg7XC5sfxTT
 OEk0DIfkCgu/l22nN8bcegfj8Q==
X-Google-Smtp-Source: AGHT+IG+I7sgvtZ8B/M4pS7xKIABy9OpMXwdGXsnlvjWirVH4CPNX4Y1x4Yg9Cg08eSY1cElqblpBQ==
X-Received: by 2002:a81:6502:0:b0:583:d363:8d1b with SMTP id
 z2-20020a816502000000b00583d3638d1bmr5635848ywb.47.1693491402421; 
 Thu, 31 Aug 2023 07:16:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 t188-20020a0dd1c5000000b0057a6e41aad1sm430212ywd.67.2023.08.31.07.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:16:41 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:16:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 14/19] spl: Tidy up load address in spl_ram
Message-ID: <20230831141640.GW3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-15-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VSfUgqqAVAWHbCE3"
Content-Disposition: inline
In-Reply-To: <20230831035319.2316665-15-sjg@chromium.org>
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


--VSfUgqqAVAWHbCE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 09:53:08PM -0600, Simon Glass wrote:

> This CONFIG is used but is not given a value by some boards. Use
> a default value of 0 explicitly, rather than relying on the 0 value
> provided by CONFIG_SPL_LOAD_FIT_ADDRESS
>=20
> This will allow us to make SPL_LOAD_FIT_ADDRESS depend on SPL_LOAD_FIT
> as it should.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  common/spl/spl_ram.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> index 93cf420d810a..4158ed1c32d7 100644
> --- a/common/spl/spl_ram.c
> +++ b/common/spl/spl_ram.c
> @@ -20,12 +20,16 @@
>  static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
>  			       ulong count, void *buf)
>  {
> -	ulong addr;
> +	ulong addr =3D 0;
> =20
>  	debug("%s: sector %lx, count %lx, buf %lx\n",
>  	      __func__, sector, count, (ulong)buf);
> =20
> -	addr =3D (ulong)CONFIG_SPL_LOAD_FIT_ADDRESS + sector;
> +	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
> +		addr =3D IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
> +				      CONFIG_SPL_LOAD_FIT_ADDRESS);
> +	}
> +	addr +=3D sector;
>  	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
>  		addr +=3D image_load_offset;
> =20
> @@ -38,20 +42,23 @@ static int spl_ram_load_image(struct spl_image_info *=
spl_image,
>  			      struct spl_boot_device *bootdev)
>  {
>  	struct legacy_img_hdr *header;
> +	ulong addr =3D 0;
>  	int ret;
> =20
> -	header =3D (struct legacy_img_hdr *)CONFIG_SPL_LOAD_FIT_ADDRESS;
> +	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
> +		addr =3D IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
> +				      CONFIG_SPL_LOAD_FIT_ADDRESS);
> +	}
> =20
>  	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)) {
> -		unsigned long addr =3D (unsigned long)header;
>  		ret =3D image_pre_load(addr);
> =20
>  		if (ret)
>  			return ret;
> =20
>  		addr +=3D image_load_offset;
> -		header =3D (struct legacy_img_hdr *)addr;
>  	}
> +	header =3D map_sysmem(addr, 0);
> =20
>  #if CONFIG_IS_ENABLED(DFU)
>  	if (bootdev->boot_device =3D=3D BOOT_DEVICE_DFU)
> @@ -84,7 +91,7 @@ static int spl_ram_load_image(struct spl_image_info *sp=
l_image,
>  			u_boot_pos =3D (ulong)spl_get_load_buffer(-sizeof(*header),
>  								sizeof(*header));
>  		}
> -		header =3D (struct legacy_img_hdr *)map_sysmem(u_boot_pos, 0);
> +		header =3D map_sysmem(u_boot_pos, 0);
> =20
>  		ret =3D spl_parse_image_header(spl_image, bootdev, header);
>  	}

This makes the code less readable.  Perhaps it needs to be refactored in
to other files instead.

--=20
Tom

--VSfUgqqAVAWHbCE3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwoMcACgkQFHw5/5Y0
tyyInQwAmnrQLSsIzQgz0D6N/BatIkqaRU2VmfyZcjWnaa8AYV5NAiwurBgbqHdH
DJuUm7Z9VTXNTb2AVOe0uHidlTcA63xtxnr7z/Pg/mKFiBwHatOmxFrZVIgvt95k
/OtLkLBOMSY6EDCU2Mp/LOgfVZiVM20X9EtPLxLd8jatw6NdlYUjrDJbTWild2jM
vebOi46m92GnNCIUzcAAeq/NStM8Vc7Nlgf7xqm8m8lR5Np6zbbqC2WhzvkjJKgd
ds1PJHQbtKDyXwv7Tduh5/NDpJT9sSaEvDoJLiBSpXHfUaPPw55iiscYldxgV8WD
JVHUNB62WqExXf839WaD9fjPDHWJcHSxbOq9UI3oVigQaiuVa5KZ6gakl37+1686
3zVJrLyJzvvl6a0rXuvolpJtiJ+f+i2DwTkM00BKonyk/QQKnjo3jzZb8fswlRQw
mwDrscNXssw3DtnQi5NmBA96ZWtOnLaMPCEOquh3iH8dMl6Gsv/idJG4+lA5/rZN
SVOtlUsx
=+NGN
-----END PGP SIGNATURE-----

--VSfUgqqAVAWHbCE3--
