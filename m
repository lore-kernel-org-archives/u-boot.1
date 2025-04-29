Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22740C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910BF8215E;
	Tue, 29 Apr 2025 15:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CijIZ04W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 443098272A; Tue, 29 Apr 2025 15:52:47 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185538004F
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2da3b3bb560so683094fac.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745934764; x=1746539564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9/UMHEaKwvsncXgGuzoWkqXBALIUUGNnyUFZft49hPs=;
 b=CijIZ04WRtoOYk3UkqbbCSMiU5Dvumvvij53gBy7IE/Qoz9FXcv08t7Li5IX4fGlCC
 XEpZ7CvqLjPv7zs4+xilidvZFpDvMwYOIXDUiOQeM7rsrSfKMOK2tLic9zMHhhhUOMWB
 77sdzc5yrZNfVoY0dX7/Z0CTgi+KzssUa3gb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745934764; x=1746539564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/UMHEaKwvsncXgGuzoWkqXBALIUUGNnyUFZft49hPs=;
 b=e4sJ41Pc16+muIf+GBBGNa3X4Kpwkre68FyRwcfzKxwv6CSJ8ihQEK3BuuDENCw5/a
 3L8oJSsVyShrufmJTQD6VaMgqNAkB9nim2lKLAkQ0iWAhUss2L/ogLMxiTt+wn5Ak+3C
 rf5riSpUg/K6XBwUEYOILxRuLr8bZxsAAI+BK7ibn5rg/F08eWHHQsrKXza9NTo485ta
 IE5QWLLC+L+ryGYsGIZGfRbRnWB8QZptLQooNUcUF4fys7siu0j4t6/Z7RulkIjbPKH+
 Qj5scSPJerbxjIPEeae+PCcMv7tqBXs1EjutSPW6x4N8Z5fQkQipNVPMysaR5li4uZ7D
 hBUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0QHcfp2uwNlQ5E4jmRLYPzJx/WgLdu9gPM0pfK8KsXfExSfhGoM160iaF7FlFT9GL6kP+CD8=@lists.denx.de
X-Gm-Message-State: AOJu0YytRCeDq98szzNaEICvGOAU06d17kEJH04bfzer5BazTYMNbe12
 KjbwyWAN9VN8bzY2L4JneZgScL/9DGgiOxyx3ghHAS2GuY1zjXt472SUXdXcvsxZKt/b1fb2RSr
 G
X-Gm-Gg: ASbGnct0yy8WcPM3e+DlctQyB2krgQYO3kaBO3eBTu7zvq0UDUK3yjmetzOM1VZyPYQ
 DoyLvKRsRgyaAgocMG6fuxoK4JgQzXnK5bS147pDNXFBqOZ3FjjlamBQszED8BHSL5GM5dlVhuN
 wurmBI+VN9d+/D1OYoIyuCbSyV6s3WqSutuPoTE/JHjjGXx8ZKuzLhn1OsxFYnlrU7Gp2amICXd
 2Kkng7veMu0WASy2NVytvoQKLJ1w+VCiryIKhXhzlIw+oY3NrBhJJJ9BMwa5H4M2LPYlZMGRbhU
 ofPTzy1Ffad14kEAXolZLtheQNW2/34YooxVZgHuMNaWCmPyJaQpJiKLZOS45hJpFp/ATASH4Dy
 bUA==
X-Google-Smtp-Source: AGHT+IFhMD91KfppV8YzUBP5fPXg1f5GKuTAcpUeOOan0qgUtVVKI+bSgvMZbl3CemIVliyGhQF6GQ==
X-Received: by 2002:a05:6871:5829:b0:2d5:b914:fe2d with SMTP id
 586e51a60fabf-2da402872b5mr2071409fac.33.1745934763863; 
 Tue, 29 Apr 2025 06:52:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973650836sm2754078fac.9.2025.04.29.06.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:52:43 -0700 (PDT)
Date: Tue, 29 Apr 2025 07:52:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: Re: [PATCH 2/2] tools: Update the license specifiers
Message-ID: <20250429135241.GC1261075@bill-the-cat>
References: <20250429131515.244061-1-sjg@chromium.org>
 <20250429131515.244061-2-sjg@chromium.org>
 <016f585f-fd30-4604-8676-c7cabd9e40a1@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zp3nyEMIuvQwxzg4"
Content-Disposition: inline
In-Reply-To: <016f585f-fd30-4604-8676-c7cabd9e40a1@cherry.de>
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


--zp3nyEMIuvQwxzg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 03:28:35PM +0200, Quentin Schulz wrote:
> Hi Simon,
>=20
> On 4/29/25 3:15 PM, Simon Glass wrote:
> > Recent versions of Python complain about the license being in the
>=20
> I believe this isn't related to Python but rather setuptools.
>=20
> setuptools 77.0.3 and later support PEP-639 which recommends to ditch the
> License :: classifier for a license property.
>=20
> The issue is that this license property also changed in PEP-639, with
> something that isn't compatible with pre-PEP-639.
>=20
> Therefore we need to bump the minimum requirement for the setuptools
> dependency in the various pyproject.toml to 77.0.3 or later.
>=20
> I'm also wondering if we don't need to add a license-files property (also
> PEP-639) to comply with the GPL-2.0-or-later which requires to provide a
> copy of the license.

Thanks for digging in to this more. Is there not some way to both meet
the PEP and utilize SPDX?

--=20
Tom

--zp3nyEMIuvQwxzg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQ2akACgkQFHw5/5Y0
tywydwv8DtflZxduBiQPH4qcLlcvM6b9gC3ppTmhbf5ISIFH1M0alD3vxN8nHPIB
YJTXVOAyhSePjOP1Tq7S385sbCDSLUmElVv53HQ62t3J1D+Vs1EOFBbRrmFS1Lm2
AVA456q7bj4Vd97mD42GCqojoaY0+hz/nRmRGwj64c320fIv21abWlbqkO18no/1
JndwHauZ4fVdNEMlR8Db5hXrGvPr9Qu/8K1lHiP5YaWB9TBvBQP+/82sFrq0+1Nh
DgIWNXQj6uOVYYKVjg6cmlby8X555cNlrYFwM3+gVVeZHTkMFwtH4HibVXUBlF+f
KKiOG9JzUEa8822HSFSuxRp6zrba/SKPqUfvv49W2dmsJhbpUOEwElDNceNVUIv3
4mCkcYLCfj9wAGxRMNUX2P/qMHMJ0rC41Uzl47j4Ldoo6+8fz2G1jcv6wzpC/aRl
+GI1Jt8cvxz/lESTZ3Lh/WzB5Ku+PUlAFNENP4SpiQtzl6Xh2o98K3KahLEW1ysn
yDvbCT0o
=Gxyk
-----END PGP SIGNATURE-----

--zp3nyEMIuvQwxzg4--
