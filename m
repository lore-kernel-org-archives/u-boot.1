Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA036C4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C8EB87D09;
	Tue, 31 Oct 2023 18:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LLN1BBf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A1D687D03; Tue, 31 Oct 2023 18:46:23 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5236787D08
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-66cfc96f475so38156816d6.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774380; x=1699379180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WYLhakfJwjXzskLDz+N5y56c9aEecxHC2RoghQ/VQCA=;
 b=LLN1BBf+hbFcmpcOD5lG/J3+kKYTVb2ZtD72IkRTWEJTs5x/82njm09J542k/mzWLt
 w/HPaAcqggsBcWRZo+OClaQLoxGru1+cuUTObby28DiyujxISQ6kvT8YlDRbv/5bu0Up
 Qozgv/9LoumQeiCnhOMjXVUyQNVXT+M9VaahQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774380; x=1699379180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYLhakfJwjXzskLDz+N5y56c9aEecxHC2RoghQ/VQCA=;
 b=XVkFS/EWO1FrLlxgxc6OfqqbBmD4snyp0pHJSpCrXAUARtQrwcd5zvDldgSM4Pe/sD
 ZQOJI4TJex0rFv39eTt2epNaPTEkfYg2arRLev3k9yAwE753gZmGnsCLPPRdTTUG9LJ4
 BnMfOdrjupyptwOtrNEt3chhx6FrdDls2wKDbcilHDZCr6QwIF5QFxOFhTpJGpSdhyQr
 FOSDOg79pryw6lt7wNc4L6/bxkajjuUQwOeWNo2DHqhA154T37KAynVTg7XzUFRmHHkY
 suilvAZJ2G0ZA1voR9nppf37/bzmUUW5nn6utbYicH3tFJ39c98vdpHDU/OxnQn1b2Hl
 g8ag==
X-Gm-Message-State: AOJu0Yx45HtzVryXR94T0Vh1kw0Xef00wbkQwkv1VurmPwZ8ncEjunf1
 AEHZTstlnhzdNCk7m2S9v39JPGpvovlU+ppBJjXJoA==
X-Google-Smtp-Source: AGHT+IEZGhfmxyIzi7okK+KfbJ/sU+UxQGPz8mxlcr/Se2Z1IaIB/8z97B0c6nzZhJnplKe8VZIWgA==
X-Received: by 2002:a05:6214:29ee:b0:670:635f:6c67 with SMTP id
 jv14-20020a05621429ee00b00670635f6c67mr12382960qvb.63.1698774380149; 
 Tue, 31 Oct 2023 10:46:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 ex10-20020a05622a518a00b004198f248e8dsm682775qtb.76.2023.10.31.10.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:46:19 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:46:17 -0400
From: Tom Rini <trini@konsulko.com>
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, nd@arm.com, Jon Mason <jon.mason@arm.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH 1/3] corstone1000: add compressed kernel support
Message-ID: <20231031174617.GW496310@bill-the-cat>
References: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
 <20231026125051.321493-2-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qltk5QJigcEj6m8h"
Content-Disposition: inline
In-Reply-To: <20231026125051.321493-2-abdellatif.elkhlifi@arm.com>
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


--qltk5QJigcEj6m8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 01:50:49PM +0100, abdellatif.elkhlifi@arm.com wrote:

> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>=20
> unzip the kernel before executing it
>=20
> The Corstone-1000 kernel has become too large to fit in the available
> storage.  Switching to a compressed kernel avoids the problem, but
> requires uncompressing it.
>=20
> Changes made are generated using savedefconfig.
>=20
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Jon Mason <jon.mason@arm.com>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  configs/corstone1000_defconfig | 1551 +++++++++++++++++++++++++++++++-
>  1 file changed, 1550 insertions(+), 1 deletion(-)
>=20
> diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defcon=
fig
> index 3b5733b777..f25da79ec8 100644
> --- a/configs/corstone1000_defconfig
> +++ b/configs/corstone1000_defconfig
> @@ -1,69 +1,1618 @@

This wasn't done as savedefconfig, so I had to do a tiny bit of
reworking to re-save it and then again on 3/3 for it to apply. In the
future please make sure defconfig changes really are savedefconfig'd,
thanks and applied to u-boot/master.

--=20
Tom

--qltk5QJigcEj6m8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPWkACgkQFHw5/5Y0
tywnsQwAp1/09LcYtX51S6ys4XgmWMThS2UHDS8k7lBYliITYONdm3I6BDLnTWZi
MXzK+BpvegHoB2IxPErvBe1NVOoFhISiqDp9mvbYRJdwKVmhrzF6KIUpIJfj9jkz
oenoCHlVhTZscYEI98Nr6z6KkSfvg7SvM7hsoC8QsVjZYTI9ORVgXNBTRs7CWiwU
BibLQ1DCnFCuQqZVtqu9CYDB2ovwWJNGydnajg6w26DYHns1o9Egyo2Dzan4t9pJ
IKq2WqOL+RSRQDZFfWBM19hSoR9Hzjmb+k0z0n/pBrDYkl6Icy+y5RNP9fFsc19l
/IKYegUOWwe/n5BktmdZ4fRnJSEP6EF8yZKZuiaZiRe//YEkqmPB5GuWOAyJ+JD9
4Z+VAt7qflhoygMOgR2T8PH6pUEoPwOWICk5p+jMLlX+KkM1y+l77udB0EQU8dJe
3RUBZe/gXafrLmq9VBH2cKCJgMytcHwRVccoXdmNVxQzoRwQ+EOBfvknLE0Md7Me
WQcacQ2K
=QDcr
-----END PGP SIGNATURE-----

--qltk5QJigcEj6m8h--
