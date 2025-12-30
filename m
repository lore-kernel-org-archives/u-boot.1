Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A2DEE4982
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAD083F66;
	Tue, 30 Dec 2025 17:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JpidYByD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D2583F6D; Tue, 30 Dec 2025 17:15:51 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABCA83B23
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3f5aaa0c8d7so7209923fac.3
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767111348; x=1767716148; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xFZWY4s9kCQ4djD5jZVwoNkQFCOnWiG+SpGzdrBkHA0=;
 b=JpidYByDF33Z52WhFTT/OGkuOGqDocO/OiBKcAfnuZBVcvsVRFYvHf3Dzm7+SQR/yn
 FgTDoehjOtXrCSrLAUV3nw3dKC9h0Ap6DJQB/lwNkQ8mROm3L2INompLtpFE3JnEXQ8W
 1wlPbcGF/CToOSdsdYI9YDPygmJibNf0Ld8sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767111348; x=1767716148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFZWY4s9kCQ4djD5jZVwoNkQFCOnWiG+SpGzdrBkHA0=;
 b=qUghQwFTcNP90e/Z0W4ri/Acnj2xrsOzHYAJRHkY527BDYFNvzuCcWtLVvXh8tdSxr
 1N2Gfy0/MDl84PyIv7Z5iIN1QnxtD9EikIMWM86gp41xE7ONTmqonabUCdm96esSZOFY
 /8Qdhph8OgqX3z/sklXmlV9QyS6+G3ViLoXdQN8H7SwAoCSy6yUIzjGtoRJhEG0rsoz7
 f03oQY342K5QHt5cc7qG2DjuzT7z/yaMY2jEkrYvLS9v8UT1Ts3DsKQd4F8xcxZQ+ApW
 jQVp8nhObc0ZGKVzxYHPtP/VzNmOmb7IPWp6M6rPWNyLeTpy0aZp0c/XiUwsBOQju/od
 7ztQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8vwCa8IrjoPQ+62zVKsaMRbk94kXToidxgDHwCLGU8qZud17Z2uzcyL7vn3hxIrYvoaZSHZg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1UhsM1sepgiqQEcssz0pl/bdYQr1GWb630RpCMDq9GCVR8HJb
 2YBPn4nsyTQ3hLiZxojHql5oQ+9xqFURUA4HQCbsB+kPkdj5Ts9teqkoiM7/nKnjsWk=
X-Gm-Gg: AY/fxX4OJooUej4CcmyDkUCGRlqPUuSAMfNEy8YCSRvOugGX3YvPjAnCTWgcYeapxzw
 dAty6ZQancR40+EsEdz2mQBO6UJomgoDcvgNPofAQky/XcgrtktxI6Wt0ftoNBKS6e1E4vSkhsx
 GX0gkXK804CarR30ScIbW8GXpRhvVsq/qoXaSWw63YqlOt/Z0ajXNuvdYIPnUQNTMWd9LE3jmgk
 MUYJok0ZwSlQYSuv9T47uRZoyFKAAYZQhPiRSw0bd7XdCXD+84V61LHpOBAwecDP6nxzLsVzHjT
 gDfYjaLLPH0KYhF/UV3agtv3DgzybHWZxg2HDweHZZv8EqklHqhycM/eiamW4XqhaPov5K79yPI
 nYiU4JPpP35RYdLoJ3Ak98L9UcRnaauJN5QaIZzfZucERVEduayROk2Ud4Kx9ONTN0MBC3v0SQF
 mH/MUeVAWESnVe1bBDSue31HPvYwy4beO7XGF8aOY8vY1DJbMfKVNTJSBhVqyfWwlpXmjqH6kQI
 TbH/7A70UZJ2RDJjs30eCUbi+/N93ibNJ968UQ=
X-Google-Smtp-Source: AGHT+IHcEF21G8CA75wBuIOsx0IjXYMvKUOB/D/B+zPTF+Bc64+wvDYw3MDjhDuFGKSSLe2dgLZnrA==
X-Received: by 2002:a05:6870:2382:b0:3f5:4172:128 with SMTP id
 586e51a60fabf-3fda594490emr15623609fac.57.1767111348174; 
 Tue, 30 Dec 2025 08:15:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d3585sm21044039fac.2.2025.12.30.08.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:15:47 -0800 (PST)
Date: Tue, 30 Dec 2025 10:15:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks][PATCH v2] travis-ci: Add config for QEMU
 m68k virt machine
Message-ID: <20251230161545.GU710860@bill-the-cat>
References: <20251230160651.3049301-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5ofsVpcEOdVlZGH+"
Content-Disposition: inline
In-Reply-To: <20251230160651.3049301-1-visitorckw@gmail.com>
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


--5ofsVpcEOdVlZGH+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 04:06:51PM +0000, Kuan-Wei Chiu wrote:

> Add the configuration file required to run tests for the QEMU m68k
> 'virt' board. This setup uses 'qemu-system-m68k' with the '-M virt'
> machine type and '-cpu m68040'.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v2:
> - Rename to conf.qemu-m68k_na
>=20
>  bin/travis-ci/conf.qemu-m68k_na | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 bin/travis-ci/conf.qemu-m68k_na

It would be good, but not a big deal either way, to also leverage
py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py here. And I say "would be
good" because really, we need because I'm not sure it will add any
coverage over what we have today.

--=20
Tom

--5ofsVpcEOdVlZGH+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVP6sQAKCRAr4qD1Cr/k
CjtmAQDpwOFOxvZ/IIj0dg+uTK6LRofZzcFxZli/uN5gDogqyQEAgmnjurv7OJ1Z
eJCuo22Q5rdbTtq+5GGovQ9ayg/zygI=
=7xvc
-----END PGP SIGNATURE-----

--5ofsVpcEOdVlZGH+--
