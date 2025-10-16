Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EF5CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 15:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68598836C1;
	Thu, 16 Oct 2025 17:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="olvZpyEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542E0836EE; Thu, 16 Oct 2025 17:29:42 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD2E836AC
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 17:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-651c521980cso230726eaf.2
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760628578; x=1761233378; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=359o+Gbf1rZXXRXDHx1yLoi5L4Kh8wVbiX/bsj5zXuY=;
 b=olvZpyEfZS7ejhXAoU/uXSERPWvRLHms0Uu4jdv5z4efr0N44lASTXx+9l3ysiKPRJ
 /SXRCYemUSQNY8FrvQBgswn8Rt43ShnmQcsVvREl/wNRCVc0EmrdsMWUX6spm0KiGtv6
 yb/EitbTC8Z3U/EW1h3G7CHnv25+lIXUrM1PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760628578; x=1761233378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=359o+Gbf1rZXXRXDHx1yLoi5L4Kh8wVbiX/bsj5zXuY=;
 b=CCBfoedOR9J675mzDVvmiOHmwb5rb8ShwjgX5PN5tQ7QcRqO/5jwL+7Ryv4oJvpZKI
 km2w9B+zvxc8ZUn5cWn2ztIu0UNyiX0qGu5/l0gRvXVMt1jU6ROedv0EiDMnoDXUcK6e
 In+g8H9qYfDVhwJa+7WlL/HOIDPkWrBsZP4m90DcALlLlwBgfG1HxastK7RImDLM628I
 tTk/DA//bUjN0XvIIA+DGSsYSp5xHcCtUOIJG8NW8pIxLnoD78fEmfOGSSmtqqZa1WJe
 v02cGeKw1wH3lBxiIKdiBv7eSYYeV4c96MJPqrN88JnxPxBa2eQs1XIjlDXRaRhgxbzi
 dcjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv59jLk+oXi8Bmx7z6GvZF+v/Mh2yjV6ArPInUVLW79J/9k50pLYWSclKA87xITsuALf91Q0k=@lists.denx.de
X-Gm-Message-State: AOJu0YwnYfPtOsefuYEOcPe8A+n5JlgmObqhTV+oLvFRehUsGZSeysrd
 NhCRAxo5ub3/NHpdet4+BfmCRoWbQn4McOjbBuU+1cyPujeaX0rt0SPLxjpz+PD3sAc=
X-Gm-Gg: ASbGncvB1O+AizuakchCGUmhgsBrKphlhGXQn88NHhvbomGXhAWnKaMA74yzyUhDrG6
 RpHmuPJ0hKVxsZFi011SJF5gKVyr5kchCA3WsiL9orKm012xlmZ0m1g7ylVWeh/Qoyxlw+9050/
 auoNCD14EfkBuyEpeS9lqyS0rQ8/jMfci4PlYP6oTPT2qtpsBtGoqypvdJBpKXz5hTGeI0TYi6i
 QAGEaXjpl783YrdFAwfCoeCmb0goNMToeUP3cUE61ZqeBxzUUXnZyu2DXyvZr36HlhsA8EUsJWo
 3FDtN4Cn6TjvVK8in1TybtCSywBJv11e5hvOYMcKo0verATICyTYXaRHkdTuaSDBywl3kj3gJ0O
 WXDynIqbSQFJAVQofQumeKdMGlMzay4T6Jz2vteHD8jlM5HGgDuuVE/N2Wda7cHR1J5B2PXnSaJ
 RY3MTPklcpP92H/HX5tXIGySnVZWQwkz004VzpWbs=
X-Google-Smtp-Source: AGHT+IGUq7Z6N9OjwTDZZ3V0n+Ui5t4DN4j7VfloSeghE6vSppHaj3MjN77xNM+HnZ8jUBEF9nlE9w==
X-Received: by 2002:a05:6820:1e85:b0:61e:2be3:97b8 with SMTP id
 006d021491bc7-651c7d59c45mr106743eaf.1.1760628578513; 
 Thu, 16 Oct 2025 08:29:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-650181321bdsm4862407eaf.5.2025.10.16.08.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:29:37 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:29:35 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [PATCH v1 1/2] spi: cadence: Add driver for xSPI
Message-ID: <20251016152935.GA6688@bill-the-cat>
References: <20251014101354.11182-1-boon.khai.ng@altera.com>
 <20251014101354.11182-2-boon.khai.ng@altera.com>
 <20251015221706.GU6113@bill-the-cat>
 <BY1PR03MB719006799BE98987B8856DFBB4E9A@BY1PR03MB7190.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jAaFefIaDayYGbyz"
Content-Disposition: inline
In-Reply-To: <BY1PR03MB719006799BE98987B8856DFBB4E9A@BY1PR03MB7190.namprd03.prod.outlook.com>
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


--jAaFefIaDayYGbyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 03:34:55AM +0000, Ng, Boon Khai wrote:
>=20
> > What's the status of the related binding in the linux kernel?
> >
> Yup, it's already there,
>=20
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/spi/cdns%2Cxspi.yaml

OK, good, thanks.

--=20
Tom

--jAaFefIaDayYGbyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPEPXAAKCRAr4qD1Cr/k
CmPhAQDrYnH60XFoLY5Q1apyDbSOUiB1tk0ARvD9U0w6vJaJJgD/RLOZJuVl/8Xk
8k8VWhL+oKwT0WBDuFEL5oewtVURZwQ=
=Rx3N
-----END PGP SIGNATURE-----

--jAaFefIaDayYGbyz--
