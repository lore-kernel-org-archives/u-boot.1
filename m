Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D76CCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 17:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 024EA83D18;
	Mon,  6 Oct 2025 19:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VnaS7qae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE75A83D1A; Mon,  6 Oct 2025 19:07:56 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF35483C65
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 19:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-88703c873d5so179779339f.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759770473; x=1760375273; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=15j6NMZ2+SctiS2JmR1+7PZ6n4Nc6aH5c9WNi9/KxBQ=;
 b=VnaS7qaeVXBCkWxZlKu0Rdr8V6Ae3VIXCJtchZwLkG6fhF8N43p1lj8mTY/a0WRpFN
 11gnQF11FVkoFF/UV8QRPwpvnnGTnyW/F0+vKF2lLZbvgNa9JL7D4wxsxVf7uEJF2vuH
 fKaJAGmwe78TPYdU1woddZJAky+2yazhA1Q0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759770473; x=1760375273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15j6NMZ2+SctiS2JmR1+7PZ6n4Nc6aH5c9WNi9/KxBQ=;
 b=BoseKekIzLm5KsAc/r39m8HXEZcANPUJ3EDuayLLFEjk2Os/q8GMznsSO3QCx5kl5f
 xuCZhJeWUJ0RbCprCwP8+u7sC4aH05VFSATVEnYvOpuka1LaX0x6ZppcRI8e2vkMAajt
 1lcZNQkCNPa3yPmMpilI+EOAlECjYXre2MGsMJEYaEYKMDaPZ+r8jvXgKT+fi65U1aZt
 el7p/lItHT68AFSQSpeRM85aBa7RUNDxcTJvxRgQrk5rfa2yEjEsj7EoH/CVqwbz3Tgj
 Xd74Y1ZIS3OcGQ3BQ9Dz/CITpB80XpKXtG4k0DPbGYRVYDZvqVRIdtIdIswsQ+6f6UBD
 aR9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0iOkBbaOXq+IlJ1HvSluKW6kmEA6dG6T336aqKaCP0OTYI7xTykdOlALWu9wPlq2p5ihXYMc=@lists.denx.de
X-Gm-Message-State: AOJu0YzLlrOVmkAFw9sk0txqImuC1jT69bhfJ8E7NtYiFSo+A8f9Hf+W
 0aYlmofBZWdfess3qsaSH93Gb18agGpR3wWigvMvt93qgvFhs5yT7kLqgh4zQrwpEOs=
X-Gm-Gg: ASbGnctvfKRaNCDuRb2PDYtsd49TIwMNyuaV4CdnzRleR7K+vPlj/G2PDxvp34KPvKG
 ueP3kB6wGrzutZv9rVdf2uJfNAA6e06m7073jStlFX3GlTWvH0BHgf90omOBM81r+Da6n4/kW5L
 jg1JvJdEdYQvNBNTzxklRhrH7eHb9WgNa3adbQ+Fwz7Y6fOB6fkNbDrKiIOl4jsYbi72Q2D/0Bs
 vHSQuN0U2sYhQHRaCk94hC8FKXJ9+Z1nQLLAlBmunnp1x0q33XlZ14MpeIRioozTta2G7tJIf3s
 0OGlM8HQSshjBlBdgVtY6O7+JNz+QQ2Ll+82IE7ysJIekNWbJwNl+MGaU3oSeKU7JqihAjECOKb
 ztElMj265vwOwRkY0tpncp4z0k1KRBy4BId9S3jc5To34ZPXwAmaIWw4PEHtao6XfgcFPrn8iFt
 GaKG80Olmpcw==
X-Google-Smtp-Source: AGHT+IHMtFfGo8sv2oI2wXm8GduwJR0hS7sQKKQThRSJJYjW3k5FEg8j4Yknb+qlwvmsWcL48QLTXQ==
X-Received: by 2002:a05:6e02:3e05:b0:424:80f2:2a9 with SMTP id
 e9e14a558f8ab-42e7ad049e5mr166213105ab.5.1759770473193; 
 Mon, 06 Oct 2025 10:07:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b1f3992sm52136895ab.6.2025.10.06.10.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 10:07:51 -0700 (PDT)
Date: Mon, 6 Oct 2025 11:07:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Dhruva Gole <d-gole@ti.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Garrett Giordano <ggiordano@phytec.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 open list <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 0/7] doc: make pdfdocs: Address issues with the make
 pdfdocs target
Message-ID: <20251006170748.GH6303@bill-the-cat>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3S9G5jI6T9yOjQXS"
Content-Disposition: inline
In-Reply-To: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
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


--3S9G5jI6T9yOjQXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 05, 2025 at 11:10:07PM +0100, Adriano Carvalho wrote:

> This patch series address several issues that were affecting the make
> pdfdocs target.
>=20
> In the end, the make pdfdocs could be considered fixed. It is at least
> with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025.
>=20
> The thing is fixed only after the 6th commit. Each commit solves one
> issue, in the order as they appeared. I hope it makes sense.
>=20
> Changes from v1:
> - Use already in place kfigure sphinx extension instead of
>   sphinxcontrib.inkscapeconverter.
> - I have kept the dependency on inkscape because: (1) ImageMagick's
>   convert fails to the job, and (2) it's what's done in the Linux kernel
>   on which kfigure is based.

Can you please follow-up (or in v3 if there's real comments) with adding
adding make pdfdocs to the CI targets that already do htmldocs/infodocs
? Thanks again for working on all this!

--=20
Tom

--3S9G5jI6T9yOjQXS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOP3XQAKCRAr4qD1Cr/k
CiuVAPwLxfAqNkYk0RmMvhUVBQTPDHjCK6QX5FrLtW2wEU3DDwEA6uGdOYXTZN7E
57F0O89f8tLL0EtPCbkXk4cBaKiI3AY=
=UP5s
-----END PGP SIGNATURE-----

--3S9G5jI6T9yOjQXS--
