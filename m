Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C5DD1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 14:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53EE83C0C;
	Tue,  9 Dec 2025 15:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ik0kQ2V+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F9C83C0C; Tue,  9 Dec 2025 15:17:19 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32619838A0
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 15:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6597b072cffso1821235eaf.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 06:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765289830; x=1765894630; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vjuoRZF2g/KWCYPP3LLohZu3kMaG0dEB2N7YiPFIZFU=;
 b=Ik0kQ2V+LBFcDi5pAM8pX5345wSxsLRopcZwrUUWUuamLt7/YCgXCvFIl5rBJSqr2Z
 sASdQ0oEx8fYYzwEKMZVnwpke0yIPCT4uoY3YxmIVQohRKtXitQMzTb4/x5kB7d5O98r
 pwCGxLz6kkEgiV++JOZ28OwRf/jfi6+BBVkxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765289830; x=1765894630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjuoRZF2g/KWCYPP3LLohZu3kMaG0dEB2N7YiPFIZFU=;
 b=fQGz13xHG0VuK8yEFvaWnL8XQ8Cjd6jpQv67dnvwiF/rltNaeCHSMcN+ulotIxtrX2
 pu2vW0Oz8nnfYylw2i2tLgTBlVobMHXkJp5w59tBHERkRZ+CWK9HHsQ/OszUecv3+dS8
 YcXGxW0Ojbk7jRnK2B6SE2PNCEClmbkH02qODKy4I8JiQBXQ8OHBtK2b5x+UQ4FdrvWH
 rmbtTVZAepFUWFs0HvYYHdDajwonJsQiSj2k7A7yE8fzmE9FEp/kI7BZQvQmeHKHM3IU
 AevI65RDPd1GfZ1IfwBUIQGGu6GRHopKg2aAy0RnLH21a7lVvuyjl88+O3XNvtliOeYe
 Fp4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkQgnA7FvdaG3N4lZnyoaHLx08m/hoAZVSgBqEMdVEOOfxeFhGfbRCZhOgc+z9mVNJNH896k8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxb24gYhQAc2rrlchsDWggGeQ9duV1v+0VcPnzwTleMsOBLtEft
 f4hZU+tUV12sLMc1j2G9WtsIBAX3bsxNlyjs02LEa6SvNttAe/UwRhhvKY0yJzjUYM4=
X-Gm-Gg: ASbGncsekKbyJ7yekBoZVBIMOP91NVh5bug1QxoI2UMDwthh3IYOm+iDKAXGDLPYZog
 05sXPAUk8559wX0IhAZDw/NPIc7N4NHSOvH3PDZDowwm2JWNnuFuBkdan20yJIvGgwbNUg8r6zN
 YylxXkQszD/Im7skpGqf/t3VKRu384GuLTE863cgUjnJaPihKMHwgnkupfFxoQHddGWtFD3csID
 O0Nw+TReWfUa7ExkvncBroqEJLUCxmn28XhkWky6t+qFHoRyPSqpQJ2CEaLFa9n1kFVxY5C1Pyl
 ILoh83pB1yiz7PmGgwXGdW1YB1p3Yk+VLng81G0kaP35ogMNjBeAmnNkm/ats4Xb3P49TyxJ+ya
 ANFcZBQPRQ6nhWHEuohjpkDgzBZqFmepuuy4tQTcxvsevfGZgbgMiEuGk+WFh4nzgqn/8Fgne42
 irO8P34TLnSnhbhCxJ9lNRunFwo+5fd8sYmwc5aI9jXLzIZ25XqA==
X-Google-Smtp-Source: AGHT+IGctGJxa000xHKObKp/pDSJ/SYpUuzIcGpvQUiXSram1ZOF0L+FMHw3y2SPcTUsS7ZN/ZpQVQ==
X-Received: by 2002:a05:6820:2008:b0:659:9a49:8dee with SMTP id
 006d021491bc7-6599a95bbd3mr4007043eaf.48.1765289829690; 
 Tue, 09 Dec 2025 06:17:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ec4bdc1sm7740951eaf.6.2025.12.09.06.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 06:17:08 -0800 (PST)
Date: Tue, 9 Dec 2025 08:17:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
Message-ID: <20251209141706.GV303283@bill-the-cat>
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4cZGGI+wAhKhRnmF"
Content-Disposition: inline
In-Reply-To: <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
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


--4cZGGI+wAhKhRnmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 12:16:33PM +0200, Tudor Ambarus wrote:
>=20
>=20
> On 12/9/25 11:56 AM, Francois Berder wrote:
> > Free buf if spi_flash_read_dm fails.
> >=20
> > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > ---
> >  drivers/mtd/spi/sf_bootdev.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
> > index 017a74a3016..720faf51a1f 100644
> > --- a/drivers/mtd/spi/sf_bootdev.c
> > +++ b/drivers/mtd/spi/sf_bootdev.c
> > @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice *dev, stru=
ct bootflow_iter *iter,
> > =20
> >  	ret =3D spi_flash_read_dm(sf, env_get_hex("script_offset_f", 0),
> >  				size, buf);
> > -	if (ret)
> > +	if (ret) {
> > +		free(buf);
> >  		return log_msg_ret("cmd", -EINVAL);
> > +	}
>=20
>=20
> can we use a devm alloc method to get rid of the extra free handling?

No, because this isn't the kernel and devm alloc doesn't always free
here. Making that no longer be the case (always freeing) is on my list
to look at doing (drivers that use devm alloc always implys/select'ing
DEVRES).

--=20
Tom

--4cZGGI+wAhKhRnmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTgvXwAKCRAr4qD1Cr/k
CmmKAQDxV2ElK6YScBYWr/YYPt2FonHDAxyIASfzdUIiVFStegEAr2gTq0K5WCB8
mkTYnna+cm6LDgsczLsTqCRNE/WWRQs=
=NqQB
-----END PGP SIGNATURE-----

--4cZGGI+wAhKhRnmF--
