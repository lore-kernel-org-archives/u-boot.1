Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6BCC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A08A876A2;
	Thu,  9 Nov 2023 22:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k5AUWfZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70CFE875B6; Thu,  9 Nov 2023 22:28:19 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7559E874FB
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ce344fa7e4so820574a34.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 13:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699565292; x=1700170092; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cd6eFkcO8rYwWSAFEBcir2BDz2CeaTy7FTVFxS4/S7g=;
 b=k5AUWfZ8YeU2xEGGdKwG6CISkmufHA882QyTjZXWhhMezp4l+isCjkEGbfB01YzRmO
 294yZYAFa9R2EY4eXcN9ys0uHnnyiVxxoCJvf4v6TeNovMAleuKhhxLjTe9JaiaJ3x9u
 71t3QnZ2UF/6mW1D4IaDCU4c0JCY4Aaj5+g9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699565292; x=1700170092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cd6eFkcO8rYwWSAFEBcir2BDz2CeaTy7FTVFxS4/S7g=;
 b=oChhiY0qGoMoBZ+z5fKZIzUCyoMLqetzF+jF3MHBRZMzNCRBRtPqqwAJ9QPZIm6b5B
 FURACDTFsrnc5Baay3UHaaKMUJxfguV7inlJ92UQ9e9wXiU2H/gpDB1eaFEoBVoq769v
 xNu4uHijFeHz1cCcFXejpJyI7whOjTGuT0vRM7CBNuF+gN2bdWybODbiqZlZtXWVZfge
 SiM884+MrBUb2Ft24lbMWtJv5KLn2raNpIQN4+ot9NKlsMsqvWxF287QN5craxs7tHxr
 tEYDDWsq82p4uyCvEzXMH3A4JNr6cmKRH5rH2wEyciKQb3a9M40JNWGbS0KCP+AkNLh/
 nT9A==
X-Gm-Message-State: AOJu0Yx07XXiIy+1diztYT4GAb9XqQ8RAkX6aP6pYXUeGZdmoPKIY1bR
 EU8Tn5uoeTjHnjEVG/yEHSD0wQ==
X-Google-Smtp-Source: AGHT+IGF4vQXx1zW7M07PxaYPlj8dGR13hwJdlUdoThYitqIn1IFpmC9OCWxGjA0a4wM6Tp1s/YV1Q==
X-Received: by 2002:a05:6358:6f95:b0:16b:7751:3093 with SMTP id
 s21-20020a0563586f9500b0016b77513093mr6616245rwn.32.1699565292010; 
 Thu, 09 Nov 2023 13:28:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 o28-20020a05620a131c00b007743382121esm203623qkj.84.2023.11.09.13.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:28:11 -0800 (PST)
Date: Thu, 9 Nov 2023 16:28:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 6/6] rockchip: ringneck-px30: fix modified boot_targets
 detection
Message-ID: <20231109212809.GO6601@bill-the-cat>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-6-cb493bfdeffd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JhRE1/UrhNrPVPNr"
Content-Disposition: inline
In-Reply-To: <20231108-env_default_theobroma-v1-6-cb493bfdeffd@theobroma-systems.com>
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


--JhRE1/UrhNrPVPNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:20:35PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
> U-Boot proper automatically modifies boot_targets to swap the order in
> which MMC storage media are used for standard boot based on which MMC
> storage medium was used to load U-Boot proper. This is however only done
> if the user has not changed it manually, therefore a check between the
> default and current value is done.
>=20
> This used to work fine until the migration to standard boot where
> boot_targets value size in the default environment went above the 32
> characters that env_get_default function can return, thus resulting in a
> truncated variable.
>=20
> Therefore the check between default and current value would always fail.
>=20
> By using the newly added env_get_default_into function, a buffer of
> the appropriate size can be allocated on the stack to get the whole
> value of boot_targets in the default environment and thus fixing the
> check.
>=20
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  board/theobroma-systems/ringneck_px30/ringneck-px30.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

This looks like what the puma-rk3399 is doing in 5/6. Can we have this
in a more common location? Or would there be a downside to that?

--=20
Tom

--JhRE1/UrhNrPVPNr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNTukACgkQFHw5/5Y0
tyxmcAv+L/8l6O3ztSLDyO3knLx5dywSE6/vIjoDCKFzPbcKpL+oPMDRbtvHiQSB
BN4fGPnXl3KKw6vkwDPSKrp56a2MkdKCUl1n2F7u9/SOfmI00k+AAvOg6PvDGo2Y
6WLmBbLpl19ikc+EEWD7bHbZ7n53zgoQ0dB2mB+MuhlWVMmMA3f2z9CuUkREur1l
SM484/2tFU3jLQnzFsNXUOenMvpYw08GHq3WJjxPjpH/eI5MlSMTr/VmZADUhm75
ofxBOR9tQMWqjPn0m2O3sn1H/ACjGg/7KR8lzdg+pEjwfi4ew8O9aAD5fZ3O+MFa
vR7hEr/gxVfZvQIb9NsfRX3CjAplH8asMB7mprnOy4oWnxlC74PMc0MbZcd5OGNU
sR6R6Lu+Vydqz7bUVQZKaF0feqERQufxE/LHi1Z/tA1/jQF/RrM2chg23LAXU0Et
TT4zVV7FFFdDQ0GiafKQoeKsIyxPpMvS12C+PNGjAZCPrEHYZu66Xy0xTKifqaoL
hGo92Nz6
=/M1I
-----END PGP SIGNATURE-----

--JhRE1/UrhNrPVPNr--
