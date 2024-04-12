Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B68AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB02488216;
	Fri, 12 Apr 2024 20:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YBXFra31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8FF388020; Fri, 12 Apr 2024 20:52:25 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C25088221
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-22f01274622so756554fac.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947942; x=1713552742; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jDnMVfzbnp9AVFhFhNH4yoEdijWBTdiK9jqWRxsXXh8=;
 b=YBXFra31gv4YiXMMGFX/D4IK/Rx0jx9JWaAn6ko/3mem9A2SCszkMp5omO1ZHLo8gQ
 JWA/m0Fn2ZDRcClcTNhTN90j5+Ba7Bg2RJTmrmcloTRjkDfl2/+nVj0y8UsZwQ34JUdg
 P5umeRjuNmm8vWeqn8QtpYH7QrNnx9depQ/Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947942; x=1713552742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDnMVfzbnp9AVFhFhNH4yoEdijWBTdiK9jqWRxsXXh8=;
 b=k4kLxTzHDhlk0GFPpfFn4m/TOEGMwHPPIn4QhU2CYYEd8+1dGAadgZ4QuX64WYip/6
 lgOQ3wsuXYFS5vFsxuQNXqswNnjt7LNuzaOMOiSjkvcpZfjD3G7afQU+Ru3UKTaRBcdk
 WjsZTZTvKVcZ12ROAkYcJmCY9VShHa3Fza6hjyoammRBkobl99M90JG/cFS7h8uISZFT
 ccjjCCgG10jFh4LxTeFmMDmNkp6VFXKQ2Hbkr2hO81ZgLs8gDD6ruLvuxMVKQCBwlN1h
 f6ihtzQmTwIcxjjHG360TivokNk8WebiLNoAg3kTtqKCIPok5idFldBFe2GdYhhOlXY8
 +Q5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS0c/fdZaBAxKLYT1PjklK/6/zDPWoNiXXy96bm1J0CqbdX3ZOlNl85ZExlU/Ml+I9uupWN331UD5Kqm6qA8dXPBZf9A==
X-Gm-Message-State: AOJu0YzJ5k5mp4zsj+DE+DUsCrgqQ2zfcqm0d8gIMDiPydSzB3MSj0jn
 i3DOPZwPSmkQK1bmGSCI9+5acNe9wHePyLb+zjMIbptGwKZfnEDtCHA/mW/KQYtJl4uqpVXB8sE
 8Twg=
X-Google-Smtp-Source: AGHT+IEi7FtBqtMygq3cgcDhLGVownHlqJbZtxygt3+t3Qe03aQ8CxDC8Y/anhbPnHbd2GRT2i70Bw==
X-Received: by 2002:a05:6870:b619:b0:22b:5bc1:66f5 with SMTP id
 cm25-20020a056870b61900b0022b5bc166f5mr3868997oab.16.1712947940809; 
 Fri, 12 Apr 2024 11:52:20 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a05620a108d00b0078ec439a9a7sm2296215qkk.62.2024.04.12.11.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:20 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:52:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cli: always show cursor
Message-ID: <20240412185217.GT2493117@bill-the-cat>
References: <20240329160922.127095-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G5wSswT8hh5BSCbx"
Content-Disposition: inline
In-Reply-To: <20240329160922.127095-1-heinrich.schuchardt@canonical.com>
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


--G5wSswT8hh5BSCbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 05:09:22PM +0100, Heinrich Schuchardt wrote:

> We may enter the command line interface in a state where on the remote
> console the cursor is not shown. Send an escape sequence to enable it.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--G5wSswT8hh5BSCbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZguEACgkQFHw5/5Y0
tyxoMQv7B3Z7gs/877bqCaGmkn5J9eH5zAQrQs4+CLSvZx47khgZRSAM9oCUnZl3
MelLDcPUwdM1N0wYSC+JPK/JN2NPIBGn2G+KEkLNajVjJfkzCYfztI4nsP8SF92f
ubcsiGlauBBjGvUu7RF23fnbVZAeMtB1b5QjKk9VrbRUDdDnfmVbu14kKKeYZ2NS
4i+ChNgO5WinrEbSt8a3aEpO2LG8mDN3kwjWzkWkHcHi9D2mCGrYf82NXMx4OVwD
rbJ5UHHXUGC3pjMoAXgahGVFfzj6oftqDBJofHj0q3Ju5Bysfs3l+OelXVUtp1Um
44BanYBTy8okUXQn3j/SXWd47uiUbkxEyxrpiIAnOIr1lIWveKuwj+bInzmhgz+k
FTXTlwouAQve9xzSKsm3EpNpFJb1J7vD1c0wSLZPcUeZjX0FHLAidIvX1DIephmV
EXk/cxoxe+ZafN8OGIaub5uCIiFlfhs1qaULWGsIq3axZJGVpk/U+UZUr7JtFtXK
+BO1UFPs
=S5SX
-----END PGP SIGNATURE-----

--G5wSswT8hh5BSCbx--
