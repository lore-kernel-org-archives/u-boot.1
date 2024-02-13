Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A071DC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 22:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DDB087DCA;
	Tue, 13 Feb 2024 23:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K8PfNOT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFD687DAD; Tue, 13 Feb 2024 23:33:15 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1AE87DB0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 23:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dc7472aa206so4171748276.2
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707863587; x=1708468387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m2rMY+C448sEbdR6LPobMRujSlF5tcS8HaSQ9L9mWbA=;
 b=K8PfNOT9gsFroa9LzdqkubRdoYsXH5qt+t+QQ+0Pzdma06SSEkBQjnK2Itj4NerNaI
 FyH2RVYMBiKgAHJ6flcZEkMFS/XEkN5wzUeDvcUrUHa8FK3Iq8lZZQMhKPGNfqY52JY4
 reLd8GH04gHmJHfqyFLfwHYMdA2snER2ANCf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707863587; x=1708468387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2rMY+C448sEbdR6LPobMRujSlF5tcS8HaSQ9L9mWbA=;
 b=P2Ddb3er7im2NnELpSk4lEKJsqhQ4N/2CdLDVITyZMoHZrV9hl0beuhqqL1lox19rB
 4fUZo9egUdoQqlD6BEpIrNtq0plM8rMclZusz0Ya5gBSxcWQYwniOq9hL/dj+3VgPdxg
 634IdBWgKfcHnLEQMOqgQmluuBWJC6q9RybpATQ2J9uy4/Y+75WaBdyYBJydr6tLMhnR
 FG5c0RcNIBuVABOFFnDidfm09mx907oQTUdbyfCesdZS7gCS2TSUcbbgVdRc2XCDjBN4
 UtNzj34+npsHVtGrqmstJs6VMbK+G5/mWeR6KZI1mxmgq3G86hUnJmHfvtWBeJRKF0xn
 6hYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj3lGDOz00wqtMj4AOc1/jh6D08DE6iFR5rd2Ufg+uObhBx7WoM7P4i6kDe1pjd998jyI1LIdPvtBvj/tWQVvgAt86xA==
X-Gm-Message-State: AOJu0YzEP9PEBWg+fBi281Ybu77sYxu3b8AB/Mm4JGeHDr9uO2Ztxxsn
 uwRkQCiMDbOU+CaWHN4pzzd4poJmHn0iqxHJ+EbBfaibVrdSWCNtzE7aL16KD5CgEGLGFNjuVya
 f
X-Google-Smtp-Source: AGHT+IEHOxylfT7m9Jvc6MscyiU0AK3D+3YY2wECijfUQctR5WAsy1egX/dxKB2bgPtDRT/41LTEGA==
X-Received: by 2002:a25:ae8e:0:b0:dc6:8534:bb06 with SMTP id
 b14-20020a25ae8e000000b00dc68534bb06mr750272ybj.17.1707863586872; 
 Tue, 13 Feb 2024 14:33:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVUAwxvZkWZkKbbXnwdkG+5hxhICGrbC/1j8Z9vYNg1eXFE+3aK1oqKAmEgYYtKlT9+9VrfzEPV9a8h/3wbmUZg6+UcuhNTQEbdLPG+uli7DhdlPWAnerZwhXO0S50/bdAuiBjascy+X1EdSj8Oc8tm0Q==
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 v12-20020a25848c000000b00dbdb2966f67sm1833582ybk.24.2024.02.13.14.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 14:33:06 -0800 (PST)
Date: Tue, 13 Feb 2024 17:33:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: dario.binacchi@amarulasolutions.com, nm@ti.com, praneeth@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] memory: ti-gpmc: Fix lock up at A53 SPL during NAND boot
 on AM64-EVM
Message-ID: <20240213223304.GV3040305@bill-the-cat>
References: <20240206140251.44155-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cOHIeA2b1QPzAkx/"
Content-Disposition: inline
In-Reply-To: <20240206140251.44155-1-rogerq@kernel.org>
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


--cOHIeA2b1QPzAkx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 04:02:51PM +0200, Roger Quadros wrote:

> AM64 ES2.0 bootrom seems to enable WAIT0EDGEDETECTION interrupt.
> This causes a lockup at A53 SPL when accessing NAND controller
> or ELM registers.
>=20
> A good option would be to softrest GPMC block at probe
> but this cannot be done for AM64 as SOFTRESET bit is marked
> as reserved in SYSCONFIG register.
>=20
> Fix the issue by disabling all IRQs at probe.
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to u-boot/master, thanks!

--=20
Tom

--cOHIeA2b1QPzAkx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXL7iAACgkQFHw5/5Y0
tyxZbAwAi9M+kSSL2mJVI205jO7RlHYXA1Tes8vHCZqTIKmLODfpKJOqDXqCJIh3
ycDKqGQjyqBilILjCiYtjmW5WFSVzXt+rh305/qB6sJe55+oFBdiUfD6bftYlUeg
OmkC2qqwSJW78vKYvhR3Wg/VpD2yGV1uUD3/ikAP8r4kFsRuimL6NyU1WEUqLaGw
2595JgnY0wVft4RyzKa15S0R5KLhh9o9fpCosEX6spDsWVn+2gA3xRCajU0J2s3i
92AOZG9giAyNdFgXGTqW/LfP6Yd2Gt8YpxvP1J3LGiDg1uV2sKSkVtYhD+zMyHnV
r4S9jj82kQ0ABMYMQZRM95R93s3rbsPrydSbbodkDdwkxjSYYOse3+DK7LDDQTFF
jg0g2gDobRYR6Gh55l8S7ptpgq369+y1CfsbgQIsaMLVi7HX+TEceE6WSYl1T74p
oe8V7gQV1M7/k5D3qgBNGpf1JEwFOVMKkX0bc27wikEh20pU8aBNuBs7XBzBZV0c
jao7/l+x
=2i38
-----END PGP SIGNATURE-----

--cOHIeA2b1QPzAkx/--
