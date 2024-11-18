Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C05D591AE
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 19:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6575489246;
	Mon, 18 Nov 2024 20:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gV5Ha4PG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6997988E5C; Mon, 18 Nov 2024 20:30:21 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5202D88F48
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 20:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b147a2ff04so186863185a.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731958218; x=1732563018; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9B74PxUw3/F8okXqs1Ta1WXUBS5RKCeYX3awMxjPgek=;
 b=gV5Ha4PGVuVqQLL5z6Wjmx8QFtd4jN3963yPgaTPHtWdFa/QE8oHOtxy5pghpZ5eQZ
 wNC/5rsKLvilhMtTjhkieh9cc8feVFUs6O9kYdxsoDp2YYhF7MW/ekSM9pFC4l7t/Jbd
 I2iHWa0kThNuDKwn4/gPxH/YGTpSbTQCV8t3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731958218; x=1732563018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9B74PxUw3/F8okXqs1Ta1WXUBS5RKCeYX3awMxjPgek=;
 b=PyJ49DKlUk6RMgd76eriQnfZVbrfR+7gloUOQ4YjuvqsR5EkVc7z9ljia9cIAhlPvP
 dyacTDx32QDVQs6LP07JEbBXgHblYFgSYECGtfDDWhXBTDnAMr0TzqjRypuBy3hULYlZ
 J1C3+7MmkqX2uyhU5QG1ZeHssekkkhSo90UZ5RSxZO9s0aX3uJAYqk+qpp9zqAFVF3qV
 mqPiWc2gqBxtzUCQO/mBcPVmsa4FFGyWdmlnthUvfphNQiWe5ik9SEMXONV9eVLk5T6F
 rjtudjS51yOYVZCDnVX8HHAzOBFP8BA8mDeqEu5sH5y/3AI+Wwa+fVobihriozjBbKpW
 BcZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUihuK7vMN6H358v6wlaqHyvhFhEMYrP5FmQ8Oo1fFJ+6NJRyXUBn2GF6ne1oJ4NgNQeDTf24c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7jGl7/Q9/FezhmxqHxu3a1fslnR4FegMlFUOe9LKAwcPdLUwa
 pCuWVn+aFaQ+WrkhIOaYtEpCcahRT97ppWOlOoVMlgweN4IO/RJPqgyDAz54s8E=
X-Google-Smtp-Source: AGHT+IHsYtnA0McJpkp9kk15ivyUO5rIRrG/0DylfRWzbPkbn1Yz8Pvxu1VHlQIoDWKZonkPganaBA==
X-Received: by 2002:a05:620a:4111:b0:7ac:d663:f664 with SMTP id
 af79cd13be357-7b3622bada2mr1848153085a.1.1731958218178; 
 Mon, 18 Nov 2024 11:30:18 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b37a897f2csm18464785a.93.2024.11.18.11.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 11:30:17 -0800 (PST)
Date: Mon, 18 Nov 2024 13:30:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] fs: Use ARCH_DMA_MINALIGN as default alignment
 for fs_read_alloc()
Message-ID: <20241118193014.GT3600562@bill-the-cat>
References: <cover.1730988601.git.namcao@linutronix.de>
 <e05bde602304f32dd813a8383a2249fabc464940.1730988601.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mM2XnLIkz4oeCPKW"
Content-Disposition: inline
In-Reply-To: <e05bde602304f32dd813a8383a2249fabc464940.1730988601.git.namcao@linutronix.de>
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


--mM2XnLIkz4oeCPKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 04:01:06PM +0100, Nam Cao wrote:

> The comment above fs_read_alloc() explains:
>=20
>     @align: Alignment to use for memory allocation (0 for default)
>=20
> However, in the actual implementation, there is no alignment when @align =
is
> zero.
>=20
> This current default is probably fine for most cases. But for some block
> devices which transfer data via DMA, ARCH_DMA_MINALIGN is needed.
>=20
> Change the default alignment to ARCH_DMA_MINALIGN.
>=20
> Fixes: de7b5a8a1ac0 ("fs: Create functions to load and allocate a file")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>

Applied to u-boot/master, thanks!

--=20
Tom

--mM2XnLIkz4oeCPKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc7lcYACgkQFHw5/5Y0
tyx2xAv/Wx6cZ2a7UCg7hOGxIQxKmcMpDD5pirDtLS8Mq9rDTdpFL86Zpa3wbNUp
BAoZpWJsUh9+UuZRe6oVupdKoVaTsXqrW0z0OCr+YMZWuYfouaJu2iK9O13fJ0iB
wLkoOEA1AvHGsyIXbAcSk9hcJpXKok6+nWY9QdlSH0pbFO9DdGxztBvzbWB/OM3C
afeVyHWG2A1dO9TIx6RPiQqJzdsJPfEuMXar2iwIa8fU1SvrepwzjmLUnfKqQY+Q
fzZgrpmvSZRaICsUIhBxIcljDfPGPcLtFdQqCSjdEuUC/jrrhwM2qL2gUJdJpKiB
nejlAKCyV5Cie9BeL3874lSjrHc+ZNXP8x88fmE1c2fm24JXR4v0RY5OOjtrvWdD
QnRFxZP53DJLUJOo7amC2Ec6kTKeGjn0GH3JC9VuMoRqDyUOaaZ1qtmHVe+JRVnq
4Xb+RNbYg6AzZS9p3HnLDs62BNRg4lUKhW/Is5hvH05PuMAZe5SXJNg7tkqJzHFL
BxFrgNp7
=v6VC
-----END PGP SIGNATURE-----

--mM2XnLIkz4oeCPKW--
