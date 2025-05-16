Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F9AC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B57E80107;
	Fri, 16 May 2025 17:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iF7IVvl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB0C8059D; Fri, 16 May 2025 17:57:02 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18EA78006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4033c89f2aaso1782670b6e.0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747411019; x=1748015819; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bWapyd0/pfSD/FrKLF5q6Ob9LTMiAjmrRePwQ5w0PUw=;
 b=iF7IVvl7mr46XDPSMkyLgDIXWKFzEHlzKJEhkoN75TrUVUDk64L2+TOuXdfoxkSifD
 pUK1noHfKlf1OvnTAmmYt2F/dcqfeVnUOxEnK54zTEk0Hji27g7mu7lfoDEZ7GSblprs
 Bv0eFQr6NDSjxVZpLvAqlQfqcZJZmrJS1dqQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747411019; x=1748015819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWapyd0/pfSD/FrKLF5q6Ob9LTMiAjmrRePwQ5w0PUw=;
 b=hheVJkhFSA98rVqy1IRi1w4eLhgyTOx4oe6p6Uo7Zhy49d48QeCUEMpv9af2e6VHQX
 2t8tIVMbjzhmcYHHuAv2mB3kSi+vLU2yAd1o8OFB8P5WgdUDOVMWW/fFF31Xl+YFETkM
 H1rhfFsNUIeItq6WHv1Db4VJqj+YTDZ2p1/eZH1Mp+m3Lg5fGBOxjI4c5uKnvH+ax1T4
 LqZNTNvxSqpngv0vQDQGHRBMCu1Eh/W9ia7CeBMwCHoCO5fTn2rvzDIqUxv93vm8YFHx
 ftyP+WFLnNdaOdwVB+ZDVKK5j2Uw6B1f31ixR8EbRhystuNqwWWC82yN25GDLe7f6YdF
 Jcsw==
X-Gm-Message-State: AOJu0YzmIdrk/puB27qjxI7kehnjnyXCxRqIYe0bzeNYkTofBvgln0CO
 v3b42RIvAJXfQ7fuO7XpN08XvJ9S7mV71tyBANISwi8k1rjW9eIEqTbgV5uPYfJqu6A=
X-Gm-Gg: ASbGncvHWeIaCRMjRkmAGj9LG48OB8D1LeZL5rAIOTojtZcrEAUElfFF+92EU7SL/MK
 8RUEv+448BZoN1Cgmu7LxPxLqJaNYdA78Wcn+MVuMNXTxQYK8xOqSZXmGh3AjreQojxVRdZxu0j
 b0pHy+5gR8wbac/9EBUZqZb8GzdPyWpYYqIujrlgUGyeZy+qi8j1iTlMPC61zjvQoXKFqNOKdeY
 8/ImgHAcNElSvCkVDP+MltEqPofYP1pDes0CnUZHmcNqkWnMaT0NWsCOgrLyU6C1hp5MSTjxI8W
 7LouYVNG47kGViSnHTwzO+qUFockmm+//Dza+DNh3Su3Ee5MRqfkie1gCSWMwi0EHuv5VnIejN6
 jFQki2/eTkQxN
X-Google-Smtp-Source: AGHT+IHq4tJd2nyNtNem+P2ArCMhTXlygWppIdMh2a1STp4a71MQui2uOrKPRxZnveQcqfIglzEESA==
X-Received: by 2002:a05:6870:70aa:b0:2d4:d9d6:c8bf with SMTP id
 586e51a60fabf-2e3c1f4dbe2mr2163516fac.32.1747411018642; 
 Fri, 16 May 2025 08:56:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a82109sm391560a34.28.2025.05.16.08.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 08:56:57 -0700 (PDT)
Date: Fri, 16 May 2025 09:56:55 -0600
From: Tom Rini <trini@konsulko.com>
To: ant.v.moryakov@gmail.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] drivers: spi: fix deref ater null.might in spi-uclass.c
Message-ID: <20250516155655.GJ100073@bill-the-cat>
References: <20250516125053.25457-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="udfVoEQDCFHKzSeA"
Content-Disposition: inline
In-Reply-To: <20250516125053.25457-1-ant.v.moryakov@gmail.com>
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


--udfVoEQDCFHKzSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 03:50:53PM +0300, ant.v.moryakov@gmail.com wrote:
> From: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> The static analyzer (Svace) reported=20
> After having been compared to a NULL value at spi-uclass.c:465,
> pointer 'dev' is passed as 1st parameter in call to function 'dev_get_fla=
gs'=20
> at spi-uclass.c:469, where it is dereferenced at device.h:240.
>=20
> Correct explained:
> 1. Added dev && !device_active(dev) check before calling device_active()
> 2. Added explicit if (!dev) check with ret =3D -ENODEV setting
> 3. Protected logging in error block with if(dev) check
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  drivers/spi/spi-uclass.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> index d6049753740..52b79223f96 100644
> --- a/drivers/spi/spi-uclass.c
> +++ b/drivers/spi/spi-uclass.c
> @@ -345,7 +345,7 @@ int spi_get_bus_and_cs(int busnum, int cs, struct ude=
vice **busp,
>  		return ret;
>  	}
> =20
> -	if (!device_active(dev)) {
> +	if (dev && !device_active(dev)) {
>  		struct spi_slave *slave;
> =20
>  		ret =3D device_probe(dev);

Given that it looks like from a quick glance most places do not check
for dev before dereferencing perhaps this should be done in
dev_get_flags or so, and a follow-up for the places which had already
been checking.

--=20
Tom

--udfVoEQDCFHKzSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgnYD8ACgkQFHw5/5Y0
tyzPIwv/Q0ri5L+ms7wmfm5Q3HiL2qYITzjiTZnI1FEIKXIt4nEcelUqpFF6Jn7P
4E/kDXAxkjUcuiLGlrJ11lzMExXi+O3IPVjIAsS1aLtDe5Z1fM661yVy4YklZMvs
fjtV4XekSkVBlYZzvwJQQRu5/OXmNZCucLO3PFQFSz3dpyE2uy4kP2nQt7Qh5Yn5
9rihuswW5puBjKHerpvlYCs96jHS2lbXNOrXsakfW4gDKsPqyASBZvBK50LVuhuX
g0p7gHAwl+jqyjjVlwiG7r/XVbp+JsdoWFdTF1om8wlS+Yl0HZVh6zHa15T/2mbx
N9HSJIh5+xehaZ4Yc0s/e82s7fyIPBcbostOIycgSD8+pNYANLRmLtVkBNJNvqQj
Og2WcRFClsigQ7K8mZP9dwn3JSC2Ldrm29Lsgo30Ty4U0J5IlhqyYnoE1HsMMrS4
NvlIroZ5ESsr1al/Ndvm8uUfCwo0nDYCm/whrk9DlHNmVx183uVtP2PEbH9A/rKm
0Zz89ANj
=Smcb
-----END PGP SIGNATURE-----

--udfVoEQDCFHKzSeA--
