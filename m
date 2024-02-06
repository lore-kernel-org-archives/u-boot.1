Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531C3C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 13:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB9E86D4C;
	Tue,  6 Feb 2024 14:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YTr7bm2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6445687C7E; Tue,  6 Feb 2024 14:45:55 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1023B86308
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 14:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-783eb452e01so45357885a.1
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 05:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707227152; x=1707831952; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bmJhbpFqIfuNcVvXMl9aRVpTMQeQZNWJksOVM/tYOWc=;
 b=YTr7bm2VhwaAaXgYVujdSGOya9Iiu0nXSRlfA3bcDmPbNcWDkpyl3bkX+dRRoJUB64
 jMzDMfZxh8UZLUoMWVoOkiUeTlZ8kiVU743n83M4eYJ3mdsSlTvwhMzAsP60GbkpO5MZ
 uxPOd+lMd9k18Ga0Y6Gr4GGNxIdbdK7gEe2Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707227152; x=1707831952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmJhbpFqIfuNcVvXMl9aRVpTMQeQZNWJksOVM/tYOWc=;
 b=YJ0zy3ri1Pb8ZEgqxShZIReGkscr4bADo238yscrs4vJaCMTd91OvKd7m0xfagLIWE
 enW9Ee1aLt0EsSCMcGwZ6AHTtMHUFrHow00cb7o3iGYBiI2hiBOkRZvwgam9XFWoSbSz
 1aH8NMyESRqiZci+QHjxVj0it9i7Kiyhm7XPXZAROPbFUUvBVgTX7T/yrLpqH3ZRqNu5
 u1Gd1g2eYssGP3aA9dMo8vIava2V4uvznlnPkZ5kDoRVgcBLk0u7jQdkLM87VfWl2n+i
 nFEskseZw/1JZKUiNhJGUMWrGLpAh+u5ui2EE7u9Y0NK391XYn6XbfSRnR/miLdSUlif
 0GBQ==
X-Gm-Message-State: AOJu0YwU6OoUWuPSXgA6u1qPwYXeOqY39YKGq7rl+gd7f62oAGvr4Mn2
 E+2L4NRFK+GvIXXXNxxsSjLmt/uo/uRcgKeEUNQYE3Ve7umhTAE/yJcV7FmAKJ0=
X-Google-Smtp-Source: AGHT+IHkeuswkn+GijezYB80wtXD+HKWhW0ilmzBhJSvxpdzH+3OurbD0ssD3i7Y3g0QNE8BR4UcWw==
X-Received: by 2002:a05:620a:564:b0:785:6054:5f87 with SMTP id
 p4-20020a05620a056400b0078560545f87mr13671082qkp.21.1707227151787; 
 Tue, 06 Feb 2024 05:45:51 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUOpmRTR2VdTx4D4Yr0+F3sPVZUNC4MCKVcf2TApuWWvgHcF6MB0LwifqBrlwtP/vUSYb7ESJhGmeDX6zUxpNGpQqZmjo4R8KWNUadG+ptUjTCXrSqJ6pzBFEOujlYa6eq4p/iasE0U7kMmGfDOyfaTA3CRbKUYiSgI6ovpAsVQKDvE4GM7NIyEi3CsXx5xfwiNOXoMkdREtyeaTcyEL8kkjpEqL+vd9cjMcoWUJGtWg7Rg
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 lz10-20020a0562145c4a00b0068c968c3b33sm1014814qvb.20.2024.02.06.05.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:45:51 -0800 (PST)
Date: Tue, 6 Feb 2024 08:45:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Neha Malcom Francis <n-francis@ti.com>,
 Keerthy J <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/10] Add AVS support for J721S2
Message-ID: <20240206134549.GP1152441@bill-the-cat>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JTkVQX2PR9WXzrh+"
Content-Disposition: inline
In-Reply-To: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
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


--JTkVQX2PR9WXzrh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 05:51:07PM +0530, Manorit Chawdhry wrote:

> This series does the DT sync with Linux 6.8-rc1 as that has the pmic
> nodes required for AVS support and then adds AVS Support for J721S2.
>=20
> AVS Test for J721S2: https://gist.github.com/manorit2001/d7690ded6ef685aa=
8ffa5b16746cc529
> Boot Test results: https://gist.github.com/manorit2001/6775d721b3df5a6904=
97d94d012b93c4
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Manorit Chawdhry (10):
>       arm: dts: k3-j721s2*: Sync with 6.8-rc1
>       arm: dts: k3-am68*: Sync with 6.8-rc1

The starting point for this series should be to build on top of Sumit's
OF_UPSTREAM series.

>       DONOTMERGE: arm: dts: j721s2: Fix Power domain for VTM node.

And please make sure to mark the series as RFC if there's DONOTMERGE
parts in it, thanks.

--=20
Tom

--JTkVQX2PR9WXzrh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXCOAkACgkQFHw5/5Y0
tyxZ+Qv8DrpbMJE95T4uroH4J+zDEYH8SeMRM0MCe+E34fksrNVV9tFOQHfL7UQw
q0vm797WQvze5ITmMDos4RJdYT/Z7cpwEbS3u/hb4S7YQeH2D5HpVmP4cSQRqU7r
pRTBANOWZnjJDfOR3KeAF9JUiTH8uH9GKC5vSde3HtL8roLDy1eCjnovsRX07w0S
9NIb/+jZESyzPWRqx/LUlZjMbWfK7KFqXuEIcJgMRP0YSb53X+kBvPLNScONCfjH
UfYwI69RGNAdDMJkEA1ytrQ0IPdhjcARoLH0NMz58/MV2OLtzTTl3bAWFcIptaSf
GBAwbTDY8DsXr8UsGhSiXXYLcHyd2WGGtjPVIN6l1vZ6Bxjx1BMpNsLckUbsNZ/O
uhM80RFWs2HVMEWRT7r3WANkbYeOFyjpGOoviSsypWhdVtDNRgUo3Pt8F8y0hkMr
ndXcOaBbnltGIAYd82wtDeOg69XwDkofU/WN1m/n+3Q7AnjB/Bqb3bmVKYBnkojt
+bH0OCqu
=kXuI
-----END PGP SIGNATURE-----

--JTkVQX2PR9WXzrh+--
