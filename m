Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42566C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C316B8789F;
	Thu, 25 Jul 2024 19:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kFV2Cc1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E7886E35; Thu, 25 Jul 2024 19:16:21 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC668789F
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 19:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-260f057aa9bso252676fac.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721927778; x=1722532578; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m47xqTSHxzpRD8ag/5lzrzViFJ3BsnpB4F422zw99QA=;
 b=kFV2Cc1a69JPDXEi/53gvacC744WFcs2+yqtQfnPiEfswZg3DfgL7pcT1JVK5tO4xi
 hzqoELTCC9ue9iyKrNvbFQfjegn2qGT914nNZnHhagX4tZcrXV60wYtO6CJ+UhjLj99p
 7Mb/W7OfJkP+DdVy4tX9Yg4u7t7ujUanQDSmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721927778; x=1722532578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m47xqTSHxzpRD8ag/5lzrzViFJ3BsnpB4F422zw99QA=;
 b=PE9tqhhXIQX9h92r9jdbgaWS0rZNFTd8FiERmbOz9lC4AS15+DrPF1CNt8QE6k4ial
 0/Wf7TdbbxDUtfdLMNPAewaDySOfzr0M0yb4ap3R4IpTXKmASHR7hPpfHgyMqVWiclYi
 ZoMgSUUjNbB7ZLFRRVoq+fllSOiZv4vp3TEhkYEzU149ViJlJdGcFwXdQKOebphvcjYG
 4fQc62UiXe5OfhCGDJh4TMnvIQRZ87zNCAXbXlIu5pFJIi9LlO+tD78qMzm70Fu+dxC6
 BK4c8vkCb8plZY0r/LIArs4Qg0nYuC36pzfIW00xxb+03+N/lJtdiYK4p3vDInE5v3wC
 Y/IA==
X-Gm-Message-State: AOJu0YyqiU1txMA4h6zmHYjOmu9ZnnHTirpE9FbABWDv4HlGaEMI9oBK
 b+4OE4xh5c7MlPVwUUZCnqLDyYkxd+XCW4w7Txm8UQ5f2t2eFAhaaep89TUkG3c=
X-Google-Smtp-Source: AGHT+IGz9qsY9ZBQj9KKsaJQ72V+a9GFc1D1vvFgFFjAfpeE0p0jR9RyanewqII1HV6SvQDbYy6VEw==
X-Received: by 2002:a05:6870:40c9:b0:261:1b0f:dc94 with SMTP id
 586e51a60fabf-264a105890fmr3957548fac.45.1721927778005; 
 Thu, 25 Jul 2024 10:16:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653cfcf982sm352234fac.5.2024.07.25.10.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 10:16:17 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:16:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-samung master
Message-ID: <20240725171612.GY989285@bill-the-cat>
References: <CGME20240725074823epcas1p322c0dce4e14b4c5379d6a703a40ad56a@epcas1p3.samsung.com>
 <005a01dade67$06c766e0$145634a0$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FiM0uzq3RRFBf1aX"
Content-Disposition: inline
In-Reply-To: <005a01dade67$06c766e0$145634a0$@samsung.com>
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


--FiM0uzq3RRFBf1aX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 04:48:23PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit b182816c1fb436916661949213c543bf4d4225=
0b:
>=20
>   turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)
>=20
> are available in the git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 2269217bbddb3d729f6129dceda8da5b1c73ba05:
>=20
>   arm: exynos: Enable TRNG on E850-96 board (2024-07-24 16:37:09 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--FiM0uzq3RRFBf1aX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaiiFIACgkQFHw5/5Y0
tywk9gv8Cj7483HUTZHRLVZqBVIbY7ZS4Hn0Q6aJCZEnIXHkyMz3qN8cyO8Xpowk
wHTAQ/S3nurvP2dn3rEP3ZZcOj6V2K/EvZpGJpn3hLI7hwwLqI5neUP2Z3msgN3Y
GDGprlDmtjYXnFRi6KO/5DxIoMzw2gLcOivt8Wu2QJj+1I54PhtDeZ3jwlYW3VYS
QYeRHUfwwEACpIlgOYHCTnyegTBhqNU5XzqVyqaUCMw2tI+oYf/pdM8Gmg4i46uQ
HLNemoo83eJPanIgw5HzaIb8Db5j8cSGaFpEpmO3RxdbMX7WAgbZSnFKTfxwlENa
2HvEosrqiivY8wv7lFABXbAzvgWKJeKEWMFkQD4+wOLo26Kd7QhJKeA42JXg2W9H
YUKRAdPs6jgdyR/737RFM3UQX4g9/9G+rM/kfmnc0p89zlnhIhwBJaCrTwJTgut8
qPGhDxBCW8k5NuK5nc80GsQ5m/Fmw8U9tSuyW9AADyiOTEqJgHezkp0Y9+JeIQEo
Qxp4+u1A
=Nclp
-----END PGP SIGNATURE-----

--FiM0uzq3RRFBf1aX--
