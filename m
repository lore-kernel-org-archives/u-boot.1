Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27444C282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C4A80FF7;
	Thu, 13 Mar 2025 17:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mfcs3vRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6496A80FF7; Thu, 13 Mar 2025 17:20:42 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA06080F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6e8f916e75fso25981206d6.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741882838; x=1742487638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZyX9kiv0tX73vOC1d9ZTG0basI9+lxGZj2DXYZEIK0=;
 b=mfcs3vRuczBn1QnH2pyhbfwnTg3AfS5IeFzuJpFVJ87MVP7wRv2hD+nx4QetNjQEp+
 x9ZP5qa7Qiyutt/9BW15q77eKF5lfAvTFqw+DPIkoxwVGvFXoAU7vex4Ka1+mTB3vMRJ
 kTcXqkkbCC3G6wySu4BzSJ1XjnyNWVkCB0qoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741882838; x=1742487638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZyX9kiv0tX73vOC1d9ZTG0basI9+lxGZj2DXYZEIK0=;
 b=wQbPRg5rROK52n4qjXXN6IvBiRj5y4i0SRiPuOdSTyHqHRuRjPYY7mLUKGZBfE8l+/
 s1bBOP2Bq2cMobMocoZrRalUa/o1AnWLTDINcoJHqp4FpuSMcA/nzc4SiLcGZrKm/AW1
 I1JvuBeN/wXr+OhU1ny3liH5TQkLQNIGyC6CeQOi4HFZlbTH8lVJiG8KEgD5Bi95/EGd
 GLqoJuEoLlQG+vxxUib0BHM0qetQXpXssiM+Pc02MLDWF4+M+kKKkh4XbnsrA6103eZz
 unXD0jusCEFeoMb1kpGX3h4vbSnm/4JOJS7QZ+WvRE+oFThWFInZfMxrzhoFfG6hAeKN
 CEUQ==
X-Gm-Message-State: AOJu0Yw/3zcW4AAtSMyK1CYFl6gGN57B38ECfTNuqxc2CvEDDsOB0hrM
 BFuyHp0r+ko/mS3hCfqWOApriFZJL0izlEvalesK6Y/MvwL2e4c4EnJNUPfI5qGTdIvYiKPjW2J
 E
X-Gm-Gg: ASbGncvkqRg/m70j17cCGt/HP+2SnEUlr2P7rOArwiigT5a9YxipvR2Nxp17dByWfzF
 hSEQsxz8pb7I0edjx39JqjOBG3UJSE8YaPDs2YezbWIv4qPcoVDcihYYp7hf4Rf7o2l+eMjW8Ts
 uQMeFahodDSV+YktbjpounFE7Ep/ZdJ9bO1VoHUBwpGoqX8d1roHb1zpK/NWCeYUskjyc3i68SL
 OTUWxOUVxKpjF85/4vNPO+TqXt2Bdi1cNw9AhznVCugatlnCqEQsgEJojKibwUmOtjLzhJ55B0+
 9MO58FVREMxHgiwgz2/zlGbIiN2tnHbszH0xgeHEOOGtFQ==
X-Google-Smtp-Source: AGHT+IF2jw+/D3zkRiKnUYCWaJYOADdwdzu69LJ/I+HDXIYaEIA40eE/bOxkVjnI3T7uwdbBrbxijw==
X-Received: by 2002:a05:6214:3c9b:b0:6e8:903c:6e5b with SMTP id
 6a1803df08f44-6eaddf21d4cmr50648296d6.9.1741882838383; 
 Thu, 13 Mar 2025 09:20:38 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade231bb5sm11257526d6.34.2025.03.13.09.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:20:37 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:20:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH 4/4] docs: fuse: Add fuse writebuff cmd docs
Message-ID: <20250313162035.GH2640854@bill-the-cat>
References: <20250313115517.1181829-1-h-vm@ti.com>
 <20250313115517.1181829-5-h-vm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ke2edVjZ7X6DDvlt"
Content-Disposition: inline
In-Reply-To: <20250313115517.1181829-5-h-vm@ti.com>
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


--Ke2edVjZ7X6DDvlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 05:25:17PM +0530, Harsha Vardhan V M wrote:

> Add fuse writebuff sub-system command documentation
>=20
> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
> ---
>  doc/README.fuse | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Please convert this to doc/cmd/usage/fuse.rst first (as say patch #2)
and then update with the new command in the final patch. Thanks!

--=20
Tom

--Ke2edVjZ7X6DDvlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTBdMACgkQFHw5/5Y0
tyxMOgv7Bp/dek+dC8jyRHNC8o6tziR+JRUKg12dyeaAq1MMkkEhH2BBJNVw695y
xPRTbibakTBi0kq9XvdoOFzbJVnKi0N4AXm0ABhh4/p6Pa8GEDyaFyJ3MtjTkPcC
qoJPjHRLe6ViweYZeDYOnD+SuLR+tgi87FcCTftte2lkraDGwwRrA5Ygn7CUgZoi
90/sF2ZWTjYz/VNnxxZPWhopEAIWCA24LeFjsLCa6g5HvxogJ5vsZTtclLDV6O0k
NVSWoekjMMChI3BOKW70e+LlewxUybFlqm+ShEx+io7JFOeDFgksEVTL2kr2YlZx
Fb5uSqtuOey92AB2CXfL8o3taueO++oKuQye98zO5byt3Upg2wczHhhzLvgCVQxq
LXcXoBg7YHFQJRndYq+PAlQky/TtavUeLTpg+czCLPnn8uYnfGOBlQMWHy6grTQ8
4k+xhkbnBdZCIsYwgUJ1dWZjflTzREovMBUUksk9oH5iEeRKAE/9LZaj/v3RzVuf
z2OwCtHL
=2dcX
-----END PGP SIGNATURE-----

--Ke2edVjZ7X6DDvlt--
