Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E34CE8D5F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6592C842A1;
	Fri, 14 Nov 2025 18:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KrI5Uh6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23833842CE; Fri, 14 Nov 2025 18:35:41 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE3B8429E
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-30cce892b7dso1089806fac.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763141738; x=1763746538; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kE7/5OKejgq6wglgvvKCzN0JDsihW1wcU0ysLXTpIII=;
 b=KrI5Uh6kStUtPbp/BIGC8ohazSiWvL44QHRMLzEaHcWxvoArxqMBnKw44bK8wIIXBa
 6uqmfM3DxeW4IMITee2RPo4ommfW3pNXs/opFKg/EQzHGKPkH/ztCecl1OXVsTksYb/T
 7E0kUQhhYXNubH2Tof9bhY/9ljT1PxivJ9neM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763141738; x=1763746538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kE7/5OKejgq6wglgvvKCzN0JDsihW1wcU0ysLXTpIII=;
 b=kCD39wkcYx6vljizZPBMNvSH8jz4kq3OL0ps9srVhZCj+ojJzz4xf2UA9LkaNx3iM9
 vcGnLizDORkPyEShjj16c29gvhn1MaBFemuK2rVW0Uk3quHISDaiJdbXq5NEUo0PIsQl
 KNBveUjRaR8w9XRIRbXrnJJFdyP8jBjybbimsqFaN8Wx7J93dFXurb4PbI1ZeKFpYJ/i
 2Zlg7jEmla62WK2h+jMeBScx8X9G6I754nr/UChQhmRUpfJY0+ljGn6jh3D8uyLNVFYI
 eNLjLQ+F8AiqE6v0Xsvgth5isj6+7118UVMihTkMAZwD3Q3CdhDLrUNuSwE0WV1wTOqf
 dN/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU12km222DFlmUeahGYes2d58VQcFxmqW8gi/4U8np66s+52zVv6MkUOV3jHnrv11xm7/ZzSk0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzj/nBVBklg09jU9FYAYK6afaNCemxpxVpuSQv3IGGwBMzPRt96
 G8/NOWxy/gmLNmQ4KoREAXyo3c98Gn6aY1R6R/xe0CCZDkmY3P7Yeq209XB3DeIlGmo=
X-Gm-Gg: ASbGncvhbwAEA6k8/4Vxo3tuIQThq8MOTLVX6+gZXZql8ZF4ma7A3yIqgbzezDMr6lT
 2inhwz7Dy/0r8N2mNVcE3r676bt6yBc47J40pYvet5OHntZct6Z2h7Olc9s/T09XjihuO6fEq/H
 FmebfjwGnxdnA8iIr89Y18/j3uSmxU0FqwOO0ESiSjqv3Kx1/qq9m+PcE2rMZDVUI1igEnKyBxK
 R20cVUxaTOGPctLi+GQZIszxyEaN8qhn6zOm0Dj0zROJr6FycxcTd9ET5niNtvXaUPPimYbNifL
 NCAc/inIH+o5RbKabG+UljsTXrNpQHBGsWuSQa6luRcYCROVP3nWnsVMZGmv3cQdLdxRh1CUV7v
 q9pw1s8WrT0HfQZ6iyXM+GPj55mlncvbUZnyVDUxyBtgjq6VYdj+4qQm9zVTKAQfpwSCZ9VCVHR
 8ZRUR9d8O/dTuihEuxdZuRNt+OYiruaK1dM1zqSfM=
X-Google-Smtp-Source: AGHT+IEiHphE6bG5+9kCvNp6CBa2jQ+TIJsy1kqhpMtgDzKnUdjrranxXRgZXnV7nlequ6dpL+3cxQ==
X-Received: by 2002:a05:6870:a693:b0:331:cbf1:e04b with SMTP id
 586e51a60fabf-3e86918450fmr2079286fac.46.1763141737716; 
 Fri, 14 Nov 2025 09:35:37 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ffc62dsm3050460fac.5.2025.11.14.09.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 09:35:37 -0800 (PST)
Date: Fri, 14 Nov 2025 11:35:35 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Sune Brian <briansune@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
Message-ID: <20251114173535.GD6688@bill-the-cat>
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
 <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
 <CAN7C2SBU1xozPwfRG_tdcqos4jDZRm-qzXR5MEVTG7jXebp_7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SWTJUfNaMQWbqzXC"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBU1xozPwfRG_tdcqos4jDZRm-qzXR5MEVTG7jXebp_7Q@mail.gmail.com>
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


--SWTJUfNaMQWbqzXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:35:21PM +0800, Sune Brian wrote:
> > like Cyclone V, and Arria 10. Our initial assumption was that users
> > would primarily use the Altera official release repo, where we have been
> > gradually migrating platform devices to the driver model stage by stage,
> > including clk driver used in MMC driver.
>=20
> Tom, with all respect. I don't see those previous patches really improved
> nor introduced a proper build environment for supported SoCFPGA series.
>=20
> Assumption is not considered as a proper way nor correct way to patch thi=
ngs.
> Simply removing critical code and breaking other SoCFPGA families is comp=
letely
> unacceptable.
>=20
> We are not talking about code improvement nor cleanup.
> What the previous patch actually did is simply remove old generation SoCF=
PGA
> codes and w/o coherently coexist old and new generations.

Something like this recently happened on the i.MX side of things, and it
was fixed because once the rest of the community found out, it was made
clear breaking / removing older used devices is not allowed.

So, Tien, Altera in general, please do whatever is needed to restore
functionality to older devices that are still quite clearly being used
by both the community and your own customers. If more CI of older
targets is needed, get that going. Breaking older devices to support
newer devices is not appropriate.

>=20
> Brian

--=20
Tom

--SWTJUfNaMQWbqzXC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRdoZAAKCRAr4qD1Cr/k
CuaLAP92fiogn0U6J0RXx4IcwI2LBYdAVUulSEwXJMJL82lQeAEAj3M5PyntQTsJ
PnkgduAekqiA+8X821PCe4bhotLInQs=
=BA+L
-----END PGP SIGNATURE-----

--SWTJUfNaMQWbqzXC--
