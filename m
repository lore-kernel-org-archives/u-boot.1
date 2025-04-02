Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C13CC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83FB481703;
	Wed,  2 Apr 2025 17:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I5KRxnms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2914681F0B; Wed,  2 Apr 2025 17:05:49 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1D080194
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c769da02b0so4177994fac.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743606345; x=1744211145; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a4JoKg8d5tL9PEPEiH+ANmJeh4jmA6zuXqt7p8iPA+Q=;
 b=I5KRxnms33EeuQY6tQWpTvqLMHzmvYO9rdkDmFcENFGS7bEUSfIv7UEzBl4fdwQjzD
 rSpyoitixuAv0vyrXUY3EQ7sYCzpOxxeHeqzcOzzJvqtlOviKVqTyx24yvKI1YFltT0z
 qJi+3ZwfqgBy1lHB9x1Mq8r16t76oBape66ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743606345; x=1744211145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4JoKg8d5tL9PEPEiH+ANmJeh4jmA6zuXqt7p8iPA+Q=;
 b=h73wwyaURl4tF/Ry2yUpxo1TYxczO6JddfDECWyJpTVyc8TGwlWMf7H3GeiQofja6w
 /6IiD6f6FV9HYLWpVNqOlQu954QD4eHRk1DKBU5Z/1SkjWnBvrEPjCcY+p7SmthC2MCA
 BfcYo1zQUXobyw/nkSrqmtUjhhyOj1se9MdKEtV8kduIbaeubO5fIza75rzf73J8Jy8l
 QOUya+NPXJTkZwozzGsrNPmBo4co+N0l0006Uc7kFPILNEJjCkEwEUNTrp4sV3fuzBtl
 mSPiQauo4MlO4+GhfiQW0z90RAB56N4hCn05/27nPDTx9T3lFGcxKx81ib0KY2wtRWNl
 MSYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU90ts9C2Nsz5MmraPBK7bva74PwMY82OJxUZkho2/P0+GjWKVHLK+zlySPUyhuz68T9hC0/Lo=@lists.denx.de
X-Gm-Message-State: AOJu0YwmRmWF+nTpudVYAP/ED+YBplQDVSex124GMvF5v+xgwwPF2USu
 QMCBBjnWH0hk8J9hzHjd1vnvsqUH4JHamtLSl33tavTDeO80euftKjSbgkJndVbMPF2bSipLpzH
 R
X-Gm-Gg: ASbGncs5nPmHyPjLoEqdlG9+Xk8pzxAKMReJbymrv1Uf6XSWpOJNfzCvVWK6lVEyZ0z
 3vyb4AjW0MfnqPlB1jtRkgk9O4+PC8bqp9OxOewyDtIcpue7MAWHC1zE9AGkmhZoPec+wsgVe6y
 NZcZtVDDHgU4zbPfvYHXjU1mnxEtg6lcbsI/mxOlI98CBctTGfyXKnUIdNLHY/Nau3nltXVKI7i
 yEAQ92iiaFEfLVeebHxB9NMqj/4BCClsQrSYrIgQAK0kLsBBE1C90dIHVkyWOWd5XahJanOZj5E
 2JeGwFLfas+GD2k9S7Ptues9GjveIFlOaEuQyKw7OkyLN3raEgBP69UOqneWgfOuSGfD2gGFmTW
 JuHMI2g==
X-Google-Smtp-Source: AGHT+IFuKFI/tFE3emyM71nF79vmVQ6Dftm9lZ8JqjCtiDbwek672m7fA5RbtDytg+Z5tGla8QnabA==
X-Received: by 2002:a05:6871:4081:b0:29e:354e:5fdb with SMTP id
 586e51a60fabf-2cbcf74ed19mr9967982fac.37.1743606345193; 
 Wed, 02 Apr 2025 08:05:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a91396dsm2860984fac.47.2025.04.02.08.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 08:05:44 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:05:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] env: Introduce support for SPI NAND flash
Message-ID: <20250402150542.GV5495@bill-the-cat>
References: <20250401225803.27519-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sj3wzq0UILf914UR"
Content-Disposition: inline
In-Reply-To: <20250401225803.27519-1-ansuelsmth@gmail.com>
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


--sj3wzq0UILf914UR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 12:57:57AM +0200, Christian Marangi wrote:

> Introduce support for SPI NAND flash. Currently we only support SPI
> flash based on the lagacy sf cmd that assume SPI flash are always NOR.
> This is not the case as to SPI controller also NAND can be attached. Add
> support for it by adding an env driver that base entirely on the MTD
> api.
>=20
> Introduce a new kconfig ENV_IS_IN_SPI_NAND_FLASH and
> CONFIG_SYS_SNAND_ENV_DEV to define the name of the SPI nand as exposed
> by mtd list.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  env/Kconfig            |  41 ++++-
>  env/Makefile           |   1 +
>  env/env.c              |   3 +
>  env/snand.c            | 338 +++++++++++++++++++++++++++++++++++++++++
>  include/env_internal.h |   1 +
>  5 files changed, 380 insertions(+), 4 deletions(-)
>  create mode 100644 env/snand.c

Since this uses the generic mtd API, it can also support SPI NOR, and
"regular" NAND too yes? If so, I'd like to see this named more
generically (and my feedback about naming things from the UFS one
applies here too), and then perhaps a follow-up converting some other
platforms to use this? Thanks.

--=20
Tom

--sj3wzq0UILf914UR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftUkYACgkQFHw5/5Y0
tyy0OAwApIBngI2rsptMfftwOtBb/sqxg/O11a1H1IPGY1eXsNufLYLme2W8zS+5
Fy4vNGwTxmFO4uhg4MpUmOqgLaozX/wN1p8HTh3sCyP2RM9ZxxVBF4vmA3NBQ3Ua
zuk9LKWsBawEKwKGJv50ayFJqY+SrAVQxaOfIr3wU7i4r721Me+66SuKucB3MAcm
XioJkThGkotVn1Ha27lKSTDTDfBzHxBTcH/EO1pbLSepjuXvGfWiEamWqMaj90vx
YlDbHncQXGG0pYQ76XX0Lghup+paYj52ROwOlW6wyVFYuIBhxYxUWscLXnFcJN4t
ZxKcxzqogSO66ntOoRIb+mlB7dRISftJkXiV+rX0oE9fPa9eD7MDycs5jB6QF9I8
fYzOcjBd4i97kUKsRNl2qGssaFDgGgCiJvffviWxfGZLrJ6KOL35IXRsSIby60xm
ZHr5AX/OpTW5mju7nEd7jxsF0Deo4YhpdkIClHkfiyQBJbYA0tQSBMVSeaJAYDrZ
2q9ZMOaD
=vf4p
-----END PGP SIGNATURE-----

--sj3wzq0UILf914UR--
