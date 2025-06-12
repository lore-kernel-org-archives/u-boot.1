Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D662EC71135
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 00:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E578828A2;
	Thu, 12 Jun 2025 02:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DzIMwNNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DFB82977; Thu, 12 Jun 2025 02:29:01 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419F481FEE
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 02:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-404e580bf09so108487b6e.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749688138; x=1750292938; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tnpZ/o/vJWj7icOXWxd509ItXmp1nqBMNqcvZY/FhOM=;
 b=DzIMwNNiAJ0E7h61MtAdVZ8A0Dq9kD9wIcwo8a3GYEEqYMR/7K26bIfqP+h8Q37Ts8
 FhOomVaGx0gDOW86QRL3OMVGAMH2YIhb94K9OY29iTZQVhQaPd9CGjDzD969ELjNLN0y
 aB83pAjFEGZpntzek/JXn9uSNkQ7O1L31X3+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749688138; x=1750292938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnpZ/o/vJWj7icOXWxd509ItXmp1nqBMNqcvZY/FhOM=;
 b=VU+9o6Ld7U0mfHxsrBnES24AkAz8+icaVX5QgwUhK7ck/cYf3EKlVm7p7LyWfnv7tR
 6G1QHFjvmyHW0yYrGK7XFg3ZJyrjVg8RpJWMZSssz7jNcGyiGEG/bgjmcF06uofoosqK
 Djb4QHUpA7lD72izFlVHnSXlQvOB9A7tUUttH4r4H6OqkY9SgAEmtB4IzEywPiXJ7kZz
 pCD3G3NLzK1Ys/yEBWPY+0ebPsG8c8seqbQIHjSWctQkE3L8gZZpG9Ln1ZkmjGPHeC6B
 PokBAlL/Abx9s+L1dG6Nl3MQJuFJoJfF6DCe7//J1iRF1tUv3vfV4URoiD+kySYH5Qp5
 HM6Q==
X-Gm-Message-State: AOJu0YzLZlg8jKMBVlXk85JAMyncFrNfa6HozkoBePIReN1rYVvjlyld
 Zm8koYf7EQzUNvvB9im87L9Rr4W/qpsl5UZJho5DfPTQwKxOXFmlr70S2sHShbQkOsU=
X-Gm-Gg: ASbGnctFPxRNKasPl9es/FBcgTJ85nGZnDeP8oTBdZArkhXu7qGenJZxNgBI1nqX3ae
 mIlUcOXqeRO8lbfy6CKHpVrAM2bZaRoumst4phzLG6yuWh5esBxF2FnnrifpKspYaMRvCdgQUSl
 q73LXtgdThXV2Oq0oRzY9+/DrlP/kXFcRDKb0kyBgyRDcUBlYTLtzAf2oM97hV95grd3W9SPHln
 /dvuhDbOI8wX5sE2js1Q4Mjk1ArMxXcHuX9/G47SxWIIOH+TGevJzopWFji/HI5k/DdUKYgTWaN
 cM9Bb4/hQy2YKV/iDSnoJeHiA6Ej4VF3BLkWA3CIRQNF414ntd67br9iSB8f0iLQ8Ep6mPeROQg
 MK17wOoIbATDEGLWcs+WtW+qCrsPVdhCmQA==
X-Google-Smtp-Source: AGHT+IHbPOrfS4s0wUMZGCE1xvu1+7rxADDQWOeXpWM3bTn/29ZH6V07rG0qO3RSqI4ENo78LXcRSQ==
X-Received: by 2002:a54:461a:0:b0:408:e6e0:910a with SMTP id
 5614622812f47-40a6607eb37mr874450b6e.22.1749688138004; 
 Wed, 11 Jun 2025 17:28:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a682fbf05sm63707b6e.32.2025.06.11.17.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 17:28:57 -0700 (PDT)
Date: Wed, 11 Jun 2025 18:28:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: Re: [PATCH 2/2] imx: imx91_evk: Remove for now
Message-ID: <20250612002855.GK1382132@bill-the-cat>
References: <20250611183006.4044614-1-trini@konsulko.com>
 <20250611183006.4044614-2-trini@konsulko.com>
 <PAXPR04MB84595F1BCB3A665DB97B50148875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CP4s0d5O9gatLDQq"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84595F1BCB3A665DB97B50148875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--CP4s0d5O9gatLDQq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:41:02PM +0000, Peng Fan wrote:
> Hi Tom,
>=20
> > Subject: [PATCH 2/2] imx: imx91_evk: Remove for now
>=20
> When I did this patchset, the i.MX91 DTS is under reviewing in linux
> community without major concern, so I thought it would be
> merged soon. But things went the other way.
>=20
> Since i.MX91 dts still not landed in linux kernel, should I
> move the dts to arch/arm/dts, not leaving it in dts/upstream?
>=20
> Then after linux upstream done, we could move back
> to OF_UPSTREAM. Does this sound good to you?

Hi Peng,

Yes, disabling OF_UPSTREAM and moving the files out of dts/upstream
would be acceptable. Please get this done ASAP as I want it fixed for
the v2025.07 release, thanks.

--=20
Tom

--CP4s0d5O9gatLDQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhKHz8ACgkQFHw5/5Y0
tyzJmwv9GUvx3/53TKoionxfVHYF16e0fbsrGO9Ac4s0oQr5sThGzKiVpYOJ89Pa
HEkUpGQiF6D4lS+vgJeWH+HyYRcEzHCPZoIDOrELHJoLtYGc40s5Zl7oAiAmO0xU
yNyR04hkJSsGMfwQEtvVJbOUV8Tdsl7eFdVteLwYmurp5yxV2HAIt6MvWOlgNryW
uDLn+orzWNIQ0lxCQQGFQrs6tSC73eRtmt7EfOGNM/TyTxz3a/1Nl26xq0wpPd1a
MZW8uXYNdZPkdTdflce1kIqyIG7R1IIK5tKqkrOMKAGH8InzjaL2HEDMMhKbVeYg
IRpGZLKZu9FxBngLnqsbhzIoIHlGK5bibmVHtnE+Aj55EEraveZU/2q4oau9v5L8
BsUAisEiPpbpDsXqXuSBiN5yJHxucpVDpajUAHMc9vYaP1cBKVvIrZy63uFAQVDD
1fY8x3dH8AYfrhSQs32o+btMmhVDMs2GpOwWYbgonwRidadRJso6iIIFXHRFUv2o
kphmIXXK
=tUtN
-----END PGP SIGNATURE-----

--CP4s0d5O9gatLDQq--
