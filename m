Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A696DD10BF9
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 13:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D722788E67;
	Sat, 26 Oct 2024 15:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pN1KZ2tZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9AC88E5C; Sat, 26 Oct 2024 15:36:25 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3F188E67
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 15:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b15467f383so208383085a.3
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729949767; x=1730554567; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b5TdhLsHtr8Y38SMjDu5KlU02S1VV2NxhCAo0sVAdj4=;
 b=pN1KZ2tZdIcrzxbsYEliYWc6mchL52ESS10z6Wjtxlryqvo12Q81MkTrbpH0Qf59Pj
 PBM+9hiAGc5SezrBndBJeBjZ9pakSLsGiqA1/NGNsch0TgYEZP9u7zbK6WRUAcltWidl
 Wvq2JTDAGST1Ap8fCRVIxelzDZ9LboAwMfCs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729949767; x=1730554567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5TdhLsHtr8Y38SMjDu5KlU02S1VV2NxhCAo0sVAdj4=;
 b=T6QQ5VTysqxUVrBpXEGMEwdotBQcOP2VZSOW40UOu7/t7uEN79HAHDs6bq9RIXcP7b
 yc8UbTPCrTTpUbGNFRKguSOfcKYZF9khjLmbnXKADS3UtJR+rPQd7RdOBfJ3GlGu2e05
 6x7cI7uoaIQCnYCgqjusHm/YbqwesQaG6F4dBgTdwJGBgDKXbJWlqaEkrlJv2hSyrojP
 AacUhdfiMaKodODelBNQE3svv0FBSlUuuo3OelGXiPlxjFld+KulaxXa2nZuWKjmgwHo
 CneedYCIN+0qjkfvGGNZ2E9Z6xBejstVRiv8BigARlRmRndgYMTN9FxGQ86N9cV/4OQi
 UNsg==
X-Gm-Message-State: AOJu0YwfOfTlr+a76mHb3CV7zQ6/7R/cGtS7C+p2O3ILtxPkUiGmcChJ
 H6nNcVcQbTOh6LbfwCWwEJ5GA0q6CKF7KYA4BJwV8mO9440ImsxijWdaGM869CkrNF50ePY8n7+
 1/o4=
X-Google-Smtp-Source: AGHT+IFFgY4/iHULruqUqACSSoJSqDNQw3EYNJXOevdPOGieC+L2PmCCcTjZMCxsOCU4FgwQJ9ClgA==
X-Received: by 2002:a05:620a:45a4:b0:7a7:dd3a:a699 with SMTP id
 af79cd13be357-7b193ed72d8mr364356885a.11.1729949766942; 
 Sat, 26 Oct 2024 06:36:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d2aadc2sm152447285a.60.2024.10.26.06.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 06:36:05 -0700 (PDT)
Date: Sat, 26 Oct 2024 07:36:02 -0600
From: Tom Rini <trini@konsulko.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Kconfig: Remove TARGET_TRICORDER references
Message-ID: <20241026133602.GG4959@bill-the-cat>
References: <20241026040747.1657322-1-trini@konsulko.com>
 <alpine.DEB.2.21.2410261009270.40463@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a345sbYJzFnxCrIp"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2410261009270.40463@angie.orcam.me.uk>
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


--a345sbYJzFnxCrIp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 10:10:05AM +0100, Maciej W. Rozycki wrote:

> On Fri, 25 Oct 2024, Tom Rini wrote:
>=20
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index b9287c606856..ba77130449a3 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -234,7 +234,7 @@ config SPL_LOAD_FIT_ADDRESS
> >  	hex "load address of fit image"
> >  	depends on SPL_LOAD_FIT
> >  	default 0x44000000 if ARCH_IMX8M
> > -	default 0x0
> > +	default SYS_LOAD_ADDR
>=20
>  This seems unrelated, are you sure?

Oh hah, whoops, thanks.

--=20
Tom

--a345sbYJzFnxCrIp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcc8D4ACgkQFHw5/5Y0
tyybRwwApzeI+KcKLS2/fc45fiUywWxD681L/LE76chuZGHSFCG8j1BmjM/84cJB
IeYA29oUJneKLx3MHRGeYTfWAp028pqW26WUEzC9dcKtraTxEB0EuyTiAqyLOVgM
VnRwzTUutRmCMu03ySaACJyQshQKg20AonCLaCZf3f/26HwZSgJoCWR7yWWAfKc1
jvmsKvQDbyqU0q0KvfsnFTYdZl1EsapejFqVzDKJJC6tC8HeUYK6ZOZPr/YtVKPQ
vtveJ8tcL6t118agMXudAG+Zw7BOCcRVLHNC71zlfDNEXXcrFdVKA5SYNLiPthgu
fgYkLvqJQuamNxXKxSYnEnFuOC5nzZdVsgGfa3XVRXAkdXChCA5K7NxhyuvWzfNp
9vPpKhRAZhFDpKl+T9lojHPvLfnu2yoeOSe/tDY9i/lwZZd8sKG5DqTS/tzBc0Cv
dpvLsu/81PwrvUaRAvQWfwcTr9ZWDR3g3BGIjMUIpKtO4A/nW1mVhxIZYec5oDqv
oP9Obd1H
=FQCL
-----END PGP SIGNATURE-----

--a345sbYJzFnxCrIp--
