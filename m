Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A007C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B25988840;
	Wed, 12 Jun 2024 18:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="foxhQOfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30F6488840; Wed, 12 Jun 2024 18:01:00 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF778883E
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-24c9f73ccaaso3700419fac.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208056; x=1718812856; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zJpBuR/sp3dnTrH6L+zioqYMy9HGsLMm5IlHDbeU7K0=;
 b=foxhQOfV+iffeupnvCZu995DQ8K2pQKkvSRgLBlB5NQXVw8gT8tjgp6f5Ud7BPsEoU
 hjkYp3xAocbHLuF566PVqoNKbVO1IwhCkfMQz1okN12umMWVIsIU5+82mrGKJvwhv875
 MqIKLFU1FeD62Pi/ECxFKTnUnwm3FVKePkHg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208056; x=1718812856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJpBuR/sp3dnTrH6L+zioqYMy9HGsLMm5IlHDbeU7K0=;
 b=xR9P/w/4TtA0MrfOdC49MuT1DNc6P+nAjiO+8xNDqoVc9jZdeCaNRdC9ewTxsvd6N2
 xeQvG8GPlRsmQE3FfnWgl23BmmnBzVGnrrTLrQYI4WX4fbDnh+9GAAw43nU597Ug2pSS
 nfMgvqyc87pIcR++XiBbkbxwVpZymxsFcVcLiiNp02S0A7vTEm95pgovUc4JueobQwyu
 ZbECvMkY5AV0OG5ySM9tcInqGop+lXiUFEDVUtAMQjPRhHZWh1r9niOFez1v8hUlDSan
 y3RaVWBfgHgfBJinidLT6cHsx/wtIU65DxyAwv5xPg7zlql5NF3UgQvnSU4qL+AqpZbz
 pdYA==
X-Gm-Message-State: AOJu0YxPLy5jkXpdAMPzUnoppTiXRACz7Lu7RcphXDO9EHSgT6yyfDNb
 oEvFT5MopDg1CGMYobOD2EUB11KIcXJDbOHiNsNF8uMhYd7pbWDHRqvI2ErN61o=
X-Google-Smtp-Source: AGHT+IFLGDwtD//LQUF61u3/sPHUXZQBAOG10iIK54dS+oNOmr3F3qCC74gaoG2LFT8o8jGd6VTmFw==
X-Received: by 2002:a05:6870:4707:b0:250:6a57:e1d3 with SMTP id
 586e51a60fabf-25514e460c6mr2590117fac.38.1718208056393; 
 Wed, 12 Jun 2024 09:00:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254ab072356sm2040634fac.53.2024.06.12.09.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:00:55 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:00:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
Message-ID: <20240612160053.GS68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="byNIexBabwbJHyZN"
Content-Disposition: inline
In-Reply-To: <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
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


--byNIexBabwbJHyZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:04:11PM +0100, Jiaxun Yang wrote:

> The default value CYCLIC_MAX_CPU_TIME_US was 1000, which is
> a little bit too low for slower hardware and sandbox.
>=20
> On my MIPS Boston FPGA board with interaptiv CPU, wdt_cyclic
> can easily take 3200 us to run.
>=20
> On azure pipeline sandbox_clang, wdt_cyclic some times goes
> beyond 1300 us.
>=20
> Raise default value to 5000, which is the value already taken
> by octeon_nic32. This is still sufficent to maintain system
> responsiveness.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  common/Kconfig                 | 2 +-
>  configs/octeon_nic23_defconfig | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

This seems similar to:
https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298-1-r=
asmus.villemoes@prevas.dk/

at least for CI. And for outside CI, I'm OK with just having the value
be changed in the defconfig as needed. We do support using config
fragments, so keeping such changes locally isn't too hard.

--=20
Tom

--byNIexBabwbJHyZN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxjUACgkQFHw5/5Y0
tyw46Av/YvEx+RISTkQlRif4Vra2JjjYDLVkZYBf1IxP6ykBHAFKNlkN5oF8MJod
4XQ+ahpDClRNlcTR/tefdskan5bJ9UMgESIs4ynMznbEv2ougv+wqtA0OtEpFSEm
3ne6Jpxah6Pex6Kek24UQRmenvu080hDZta2GizwWQPtRnuFDzGvJunRtxgdoRBW
NT+WEJhiPrl572b1b5xlUvK4VSPA9rLcvBnaKY1pD3ePlEMot2BiM1nBZDOgAYp7
gB7ZEuZ1r6sfc4foBwF0dcrOCDQavJ2CTK10FMpdos310pTGdGR6TbUQyuStRlUi
frAMeX073cHMvEJHzQIhoUV+ihVZ0V8FUiT9tPN7zQFShmJSyMoHClp5kWr7wqmt
7TIk+phhPMt64z7o46/9Rgvz3jil8imzyf70nLlGj10BqLtIL8NjcqCgpGQ72Hhr
bE2Ks1JFHOdhq6FbOamrIfBs1H9TWO1tCY3v4pbw+rdzrKh/Y7EQVkuyI6VoKroH
Gs13izYC
=5Tzy
-----END PGP SIGNATURE-----

--byNIexBabwbJHyZN--
