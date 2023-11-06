Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D3EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582C18701D;
	Mon,  6 Nov 2023 17:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ENyv1KM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA98786FF9; Mon,  6 Nov 2023 17:32:36 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9714186F88
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-778711ee748so332295185a.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288353; x=1699893153; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=miIXev5ZP7/fDh0R5pDsD4fqt6i/fvVujc+3AIsVUM8=;
 b=ENyv1KM0mzq4dHnr09UWZENw1k2WoHdB+VKtPI1MLfRaQtP8BB2NEkdnCvs+rEjPDU
 ukqL+0KE1pQRfcbhL4Zi5RtPNut/162BfnxeZtFeZlOs1U3QnkY3XnmPez8/6MDbqEsy
 fz0kisGHLrdS4PALB+nw1CuQrFhHDUy2Q9/PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288353; x=1699893153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miIXev5ZP7/fDh0R5pDsD4fqt6i/fvVujc+3AIsVUM8=;
 b=d7Iksh3ZV7ks43n3Kx3u4At+xAXYEakNywQH8IAfhpKM/o1saT04/IIILae2DNqRWG
 hRghExWUYNR/wAJmjK2pxskQfs1KjNRktAwyzKvihcWjIndTY61uaUOy6JW7dKlCNW3a
 LQ9FgstbWPAtRXxifjoY0a7I3MBDU7MlN93gnZK+AAE9bcyRmnZ+AN7G2wrdVB7LoTB0
 ObGS04stOzwJq2Ux0NPfKvFNbDSEAUVOK5budjukJI84rRoIDayIMJWR9TJbY7Jgb4Qa
 U3Q3w1L7MVV/3TivjA5y0leLLMIlQDNiY/lX3pEgb7bhgIvfVtnPApqQjfwRjJ7s1V6C
 M+QA==
X-Gm-Message-State: AOJu0YypQ+q+TdYWDgRAb73LlpW8lwFyCvOV8OEwdI1kgxU9dtYVwHYl
 vOTNwQmbb3EnKrHqiGrZcjHDvg==
X-Google-Smtp-Source: AGHT+IHduy2nDpePd0VuPU9HE9GqhdE9cddFfYifSlqNv5eFjp+p1icosvgzCX9i29lgr1ABE91Ueg==
X-Received: by 2002:a05:620a:4555:b0:778:92de:c50 with SMTP id
 u21-20020a05620a455500b0077892de0c50mr36035568qkp.34.1699288353247; 
 Mon, 06 Nov 2023 08:32:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 z9-20020ae9f449000000b0076d74da4481sm3422939qkl.23.2023.11.06.08.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:32:32 -0800 (PST)
Date: Mon, 6 Nov 2023 11:32:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 01/20] m68k: Remove CONFIG_FSLDMAFEC
Message-ID: <20231106163230.GK496310@bill-the-cat>
References: <20231101162824.3755579-1-trini@konsulko.com>
 <63a7cd49-9491-6939-48af-62b2fc586cae@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1bov2CCkLJWaW9tf"
Content-Disposition: inline
In-Reply-To: <63a7cd49-9491-6939-48af-62b2fc586cae@kernel-space.org>
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


--1bov2CCkLJWaW9tf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 09:58:07PM +0100, Angelo Dureghello wrote:
> Hi Tom,
>=20
> Reviewed by: Angelo Dureghello <angelo@kernel-space.org>
>=20
>=20
> Thanks for the cleanup, m68k boards build fine.
>=20
> fsl_mcdmafec driver is still referenced in arch/m68k/dts/mcf54xx.dtsi,
> (from compatible field) but no board is including it.
> You can remove the dtsi too if you want.

Thanks for the review.  I'd appreciate it if you went and did the rest
of the cleaning of unused code around here as I'm not familiar with it,
I just found this one as part of looking for common.h usage.

--=20
Tom

--1bov2CCkLJWaW9tf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFRcACgkQFHw5/5Y0
tyy+zwv/Xi0xJQbooQ+28bgSPpDFUB3DpfWmxGdQJOxl6wmR1JN6NbjqyKSwPTG+
13UhPLKwMpxngHv1RT1NkCQGI1AHWx4RT0+xUQeAmg6B9bKWUEB7X5w+UQ95bGej
cDCNNxJLxMvHjvR0UzvrkFqV/31hUe0aVSRQ+kiuQKImCo2gReLN7z1xID7TDibD
ZpK3bSbzCGw836LIrRegoAShBed8dD0QtNSx+DFZd4X2lEqibr22VZXxLsQovMDH
sCc+8bCLdEMewO4Yp76TvvnXqeXwZtZ+0hQIE4gt9rLNa81Hiwy9Tge50OY4g8YF
1y8gYChOKGHEE5G0ywzU3HtvATlU1J7YikKMhhJAIXlbeeBlkUMugbyqTOUa1Hjs
0NKN/jPAEQy9LVSPDioA+t3CcW8AriXDgi7snMaHelKw1kQT7i7D9jEkkivZlIOw
0pS5J8Lkej86w6MTksdwlD3bqDDsRNRV1ke6TyFKhS/yiy/eh/513eDJDFPIVluM
JF9lwByP
=vE+G
-----END PGP SIGNATURE-----

--1bov2CCkLJWaW9tf--
