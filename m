Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0ECC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 14:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A4287F1F;
	Fri, 12 Apr 2024 16:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="flOZuSDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7C187E91; Fri, 12 Apr 2024 16:51:15 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD0A887F1F
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 16:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so876342b3a.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712933469; x=1713538269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FG+G1++ueybyl53lA1xj461MKHfoPEUyKx1AdU9cLhw=;
 b=flOZuSDUlC+CgFku0Aq0901RtXh3jeZE/qFw9kDl6FKFuKxol9RKk/9Es6mAqkUf3j
 sX3MIUNPlW0nGEwFeZK37PaUobSH12zf6L7qmVVNrSkk/5R914hR2wiWtMJBDSV1Q39c
 HInohesMHT5spvKRuN3sJM1UIbnCQTnfHpXOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712933469; x=1713538269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FG+G1++ueybyl53lA1xj461MKHfoPEUyKx1AdU9cLhw=;
 b=uQQTvvhmMA8IzUMqUQ8wZyVeuNVZnKdHYs3CE9Re6m5685rRATrAPzCnMi8ZXqKkrL
 Jv+VNaRc8A3mIHVGRYPmIgL8WEVQYQW15HsGXQck5eEP8Ph1n26pxezeLb94CWiTh03B
 YzpyyoKxmDxNn8KmZOvEVZ5ZV03O0B+oildpSApAMLQXpYzrpopO46f3M7kymXy6LPmN
 x1x2+P6lRUctSqTOM2Z7BSc+yEyzSb3aj+hKZxS8Fv8dVdovcWyJ2jBwLVixRC0i1QLA
 dcPBDkE5lck2uwP9uGGCGxK/7MSfinDN8hZGfZ36WXYjl8gV+cEL3NhR2Hpkt4YR3Z/N
 oEFw==
X-Gm-Message-State: AOJu0YxKAhYcfSZ3I5Qz42L5GJVSUXK2CGp7a1Tj+9qqV5fKllXCm87d
 sd3OEsXFWXd9CELjP/1FAbgFjFkREaffvWvTExe4ex34QjE9yaJOrFMu1sn0nAM=
X-Google-Smtp-Source: AGHT+IE47WseCsTS6iUs1OOakSLRJUcv/XAN+DgfPevD9tV1HV8DmihjkfjYpnX/f/r0LHQHjIIK2w==
X-Received: by 2002:a05:6a00:178f:b0:6ea:f05d:d2ec with SMTP id
 s15-20020a056a00178f00b006eaf05dd2ecmr3766942pfg.2.1712933469291; 
 Fri, 12 Apr 2024 07:51:09 -0700 (PDT)
Received: from oliver.lan ([2806:102e:18:245e:2606:71da:664:f052])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a63e641000000b005bd980cca56sm2819603pgj.29.2024.04.12.07.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 07:51:08 -0700 (PDT)
Date: Fri, 12 Apr 2024 08:50:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 bb@ti.com, nm@ti.com, sumit.garg@linaro.org, michal.simek@amd.com,
 marex@denx.de, neil.armstrong@linaro.org, afd@ti.com,
 vigneshr@ti.com, kamlesh@ti.com, m-chawdhry@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH 0/4] Cleanup K3 binman templating
Message-ID: <20240412145040.GA361586@oliver.lan>
References: <20240322131011.1029620-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sNX16T5gD+2EmtSS"
Content-Disposition: inline
In-Reply-To: <20240322131011.1029620-1-n-francis@ti.com>
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


--sNX16T5gD+2EmtSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 06:40:07PM +0530, Neha Malcom Francis wrote:

> This series does primarily three things:
> 	1. Split out the common J721E defconfig for both EVM and SK
> 	2. Cleanup k3-j721e-binman.dtsi to be SoC specific binman nodes
> 	   and -u-boot.dtsi files of the respective boards can pick and
> 	   edit according to their board. This is based on the
> 	   discussion [1] and this is the primary goal of this series
> 	3. Move J721E EVM and SK to using OF_UPSTREAM
>=20
> This series depends on series [2] and patch [3] which implement
> OF_UPSTREAM.
>=20
> Also received input from Nishanth to clean up the unnecessary artifacts
> in the final build directory (maybe populate them in another directory),
> working on that as well but didn't want to delay v1 further considering
> I'm modifying a bunch of board builds and would like some friendly build
> tests and boot tests for them.

Please rebase this on top of current master, thanks.

--=20
Tom

--sNX16T5gD+2EmtSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZSjkACgkQFHw5/5Y0
tywMbgv/cHT6r+0uqvcIgLZtrfv2YmnmitgMv2pLHav1TNPw16ao2rSrdwOpiJKg
S5lnnX3/LHkLpKO3xWeD6PSH//YpKD8DCjxpI7cFhsinKcRFtm6RA8P/EqFOwKNr
hdMIhc4OPmdRGbnnpW+GogSyNUs6e1zFxvEqq2MH1hwNlos+JvLgMEBOezi78Nb7
6cdhNB3g1eRj3KlQzuRjp4inhjfYec+PObPt4Kgnu1Mnc0DBEN0QSJkszq/VbQEE
vukyykJk7+36xAB6bGQ+8CyEl4shAeU+Mwa4n4t8Ee96B6YWe8LimtDSGBgLSnlE
erVdOIxC1nqMi/yRcLtz79tukUEi0h9YYo1EphLC21Uc+KSePiIKImQi5Dj6ssjK
IB/noDXNWO+f7Whg7AFMP/Arn7vvA8CRUgvMNyWB0MWlDf24raG9S69BtXhv5XA6
PJCN1IasSUF7FfojDGHPNuiwHaiCyGFBT0MGbrhThpb7kzT0hh6mgytKNH0/ozGS
WJ75G6YW
=2bMF
-----END PGP SIGNATURE-----

--sNX16T5gD+2EmtSS--
