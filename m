Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0FC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B5E8783C;
	Fri, 10 Nov 2023 17:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qPcUbNvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5C787793; Fri, 10 Nov 2023 17:21:26 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33EC687828
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-495d687b138so916285e0c.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633282; x=1700238082; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3mafvvqvBLEpv2GAkmSkTztTRuyHmj1TMWhVp6ccgZA=;
 b=qPcUbNvEfFxwMgY1VTzZyK5wB0Wci3R+BffzDAR8s87bJ6rvIB2bcOhkao0QAuLSDq
 7/Yxhv3o5YJKigrr1auHhKJuqfO6Txmo/JFsP4y6ZjtazA7r1pdIgd/ICSJ7O1Knv8iV
 1mVzeLpAWkAV+lESHYht6cm//RlmcWi9zQt40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633282; x=1700238082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mafvvqvBLEpv2GAkmSkTztTRuyHmj1TMWhVp6ccgZA=;
 b=qAR0gMT4lICpxdISDQqeP6YY/LBIFo7L4VA+D1gNM/OxRZIsvjkpanNNAZIeqOu/U/
 XHkSqdJ3TqtvaKQbacMUa7L7Lwhhvq5BHDPygjHNB5g6jlD++GXgBF0mGcueJVthpSF5
 YNwJrIfTGQm42FSL38s51c70J13jndW504FG4p0O2YXMijIvYpWJ3bceLiMZk1jxU1zr
 TCQD+gndJkpoXc4cA5pcA5xLAfW1GvtrHRtyvUpKTBlLMTtB4MIrKlo6PcxSoRWlqAQl
 u//3/1VTnmm+rM4KIiJDFVkgaGq8cPAvm2+iZmeTkr9QrU1YOXppWvpGt/8wwVrxiEh9
 7NUg==
X-Gm-Message-State: AOJu0YynbTy7I03LYLvOYL++3E+6RnBSOT4t/vrDSByA11zE2u1fNls6
 5BBMZC/+6MUw3LbVixDx11faLA==
X-Google-Smtp-Source: AGHT+IFf0WMTIEL5b0y7s95OSAGVaFOlngxOTrtZizrKTbB5xPffUJhIMUWVU4V0+sm5pZbEU3pQNQ==
X-Received: by 2002:a05:6122:2215:b0:4ac:bf09:4c1 with SMTP id
 bb21-20020a056122221500b004acbf0904c1mr4694222vkb.10.1699633281722; 
 Fri, 10 Nov 2023 08:21:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a0cedae000000b0065af24495easm3021513qvr.51.2023.11.10.08.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:21 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Alexander Gendin <agendin@matrox.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] test: cmd: mbr: Remove unreachable code
Message-ID: <20231110162119.GU6601@bill-the-cat>
References: <ZUr67-KKyaSDv_vk@alg-gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/ZV+D8jbGCYzEB61"
Content-Disposition: inline
In-Reply-To: <ZUr67-KKyaSDv_vk@alg-gentoo>
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


--/ZV+D8jbGCYzEB61
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:05:19AM +0000, Alexander Gendin wrote:

> Fix Coverity (CID 467404): Control flow issues (DEADCODE).
> Fix code indentation.
>=20
> Reported-by: Coverity (CID 467404)
> Signed-off-by: Alexander Gendin <agendin@matrox.com>

Applied to u-boot/master, thanks!

--=20
Tom

--/ZV+D8jbGCYzEB61
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWH8ACgkQFHw5/5Y0
tyzbvAwAtwgEN7/HWRVAbv048eXm0UQGyIrhUI7mDYReM4s7B9uy/fNjhMn/nITm
eHOjnSx0AHTFOpTOCWMfCzkPljl98c6qGYlBPf1zZ74Va+CMEUOaF2usr7ylzR0j
YZ7IDXvMjX1MY4KVnP/bAiA0JyPvuOJxaLcdt/e+7ugkDAUzy6PgAft7se1IV9Y9
YNI7yfOe2k+PsN2oEGKMdhyHYmehBFRWvwNcjV6sRZXknbeQ+AatMPhJiFwmXi26
x5QSld1vay63qJW1fsB0pocGIAWYuuobzYZFSnWYE8H2vAMS6hpTX3bf8ITTxe3g
0KRAnrKGnGLPfCm7vlggrLDLfSdscmbc2ZeYkYnem5B1dQzW0rTPRHyTEILpjWET
YhNEkLLaMxgbeZ+pHwYKxmME8iEcKEAODGwn+rfDit3HZBJb+fKIGkGshN5B/fFa
KQB7XcdrwlPZJcobWBielA1NdQteTpX8W5V+voMnFUkQeSLs5N1W3FEHBhiuVL5W
Vleg+z7a
=QhNt
-----END PGP SIGNATURE-----

--/ZV+D8jbGCYzEB61--
