Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4123FD4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43E488486;
	Sun,  1 Dec 2024 17:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t2Op4U1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E189F8860B; Sun,  1 Dec 2024 17:50:18 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A39C8826E
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d87f00f786so31211346d6.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733071812; x=1733676612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dY7wgAXg/W+sXV68xBX5T/1oKTX/JArC+mKGprWncYQ=;
 b=t2Op4U1qM1YLXCC+CAnDqP3PuRDkKG2LvnjKw6URv1bthjU4pFHx3VLS8zulYpzonL
 iCvedVRSAZEn2Z9QOAKR7VIERvxTg5zfzaxLdvbugB3i+9czEFHZDGKQAd5nkMptdLy2
 I5cUiouwKD31Hf8y+eFZXVr81Bcm4yiO+DZ60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733071812; x=1733676612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dY7wgAXg/W+sXV68xBX5T/1oKTX/JArC+mKGprWncYQ=;
 b=N9xhZorzfVELALOcxSicdNjL+Q6Tcx2vrJ6DNueoAC0YSL/6Sii7A6t2wcytbtukxG
 nIHMQXeIkusOJa2dNPJR+4p4VggDM1uxH5itAVSVaSkvahALoq82siWK+J0HG1nTcAn/
 9oWMzmGMcRZ8qctiTAfozeO/vL26DxOiIBbKadEmB0mNMW/znTTv1heEo4z77jhG5kPl
 6r6DqG6FaK/9TE8+eRdtbu4nwtq4q3qDeXKk9yyPhZ54j6TSoYzPer05tjoeuz390YfP
 La51REvndXQ6OhIwKDCVKeAcCxOrsVAPNHqEFhuKw6e1dHvYvTuymXfSADHFgangg20B
 +f6Q==
X-Gm-Message-State: AOJu0Yz+Ni2t8xYwTm9BHOlKAo66pFehFlRM/njjSvUcJh53Iq8YHsb5
 IK5ZVgohBtiUsZL1XLF+2FNXGnODeqA/u1EcBloeqK9PxYdbJQCSDRzLFtjLXdg=
X-Gm-Gg: ASbGncvA6/g2dNAefWHuiEqCq/W7fwQFMeTmn9iYjNnQiSrHoN0pOebm7PisZdJX/sK
 QdP/MGUOzPEfnlGkYPaAwcCn4zrZjEmyfdelYfxemIWdSe8aw1giSC3I8w5K1QCpL0nkwQI+axP
 pNUBMjQAUWadLg8F5PGnmATcwbRtyGJdbDDruH59U9y6uwiWIFHCRGYAxZMYVS/bQguTjnafman
 czgshDQGE2CLjaUDEd0nM34KQQLyXvhUGdskSSePTbgTbui9A==
X-Google-Smtp-Source: AGHT+IHGyAAhpgymxYNnMBQ1++be+IVRZB/DFDuPRljdinFrxgdqIz3SupqDRLOF45ufD+0adwkLxw==
X-Received: by 2002:a05:6214:5283:b0:6d3:f1ff:f8d6 with SMTP id
 6a1803df08f44-6d864de521bmr286391526d6.40.1733071812284; 
 Sun, 01 Dec 2024 08:50:12 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8751f55e8sm38916716d6.75.2024.12.01.08.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:50:11 -0800 (PST)
Date: Sun, 1 Dec 2024 10:50:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 6/8] binman: Avoid skipping binman_init()
Message-ID: <20241201165007.GU3600562@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OLirFhrRXauuVZGz"
Content-Disposition: inline
In-Reply-To: <20241201144240.1664398-7-sjg@chromium.org>
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


--OLirFhrRXauuVZGz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 07:42:34AM -0700, Simon Glass wrote:
> A recent lwip change stopped binman's init from working, so it is not
> possible to read nodes from the image description anymore.
>=20
> Correct this by dropping the offending line.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 4d4d7838127 net: lwip: add TFTP support and tftpboot command
> ---
>=20
>  lib/binman.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/lib/binman.c b/lib/binman.c
> index 93d85548116..9047f5275f3 100644
> --- a/lib/binman.c
> +++ b/lib/binman.c
> @@ -137,7 +137,6 @@ int binman_init(void)
>  {
>  	int ret;
> =20
> -	return 0;
>  	binman =3D malloc(sizeof(struct binman_info));
>  	if (!binman)
>  		return log_msg_ret("space for binman", -ENOMEM);

Erm, Jerome, do you recall why you were doing that at all to start with?
Or some sort of mis-merge locally that was (sadly) missed on review.

--=20
Tom

--OLirFhrRXauuVZGz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdMk78ACgkQFHw5/5Y0
tyze2AwAm82FF55dy3zgls+ehEozkWVHRTVKh128y+r8Z5s4rzWt5CdKJ8uxq9VT
L0WQF5UrLTI54TywAchuf880A49TNyK/iuI8tp4NLSHeMdVqgaZWU+Fc1JgRA9ks
6fiYWXw/rDZlp0H+O6suiLhGRFXccR2SKdtIkDRjsHyPIoFwWeJSsVxED4qtuagW
ZT3fUM1ZZBuaDxJPsjG4trfwgs3Zix3JOYNgdzR72pmkUhfTPjGA1mAQQKyy9WHm
HWdDDwF7FRc470+3oatxdp+h6Jv6oJWlzdIzKRH5hJT2IJ0/QlFKU95UHgwh1om2
nbJdp3wIprsby10cR8mHnzImPiiPOeV7woAk9Eyz5bdY3pLoyzt0JE+5kA/HG0U0
dCOvONXr2q31T7DludwE30LjuCbixIcvbSOkBWPf9Et025a+uq/5YQI9gh8BcXnT
QOwnlcVLAlr0DI8VMPvBqq7BcbvcnEia+8D8GB5k66V+ok3oQRJGmAw9pMfBjkxH
QxeIg/cD
=HcfZ
-----END PGP SIGNATURE-----

--OLirFhrRXauuVZGz--
