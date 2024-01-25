Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DCBC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF2887BCE;
	Thu, 25 Jan 2024 17:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKuAF4a0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B22087A2A; Thu, 25 Jan 2024 17:14:40 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2733D87BF4
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ff84214fc7so67362757b3.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199277; x=1706804077; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CzWzhk9KILynst1pvh7NXRZPdnv1hSRuVcT05yvOK1c=;
 b=rKuAF4a0cswHsC5VPLS8eDc+cRCHU1lEKtZLB5fyNxmX8bYpAHCwBe2Li51haNKy3u
 RZAtU8K0sOJNz7AiqKRZbmljE8zGDjsIjlOoVj74/oPuSwdGsumCxEiYE9i9R1e5AQR4
 AeQyc8xtYYzcBVO/R1tITKHi0aE7NNr5BKFbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199277; x=1706804077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzWzhk9KILynst1pvh7NXRZPdnv1hSRuVcT05yvOK1c=;
 b=YREM5UJMKRAMw2LS7D0tDUFuhYCiRIgWSwLl0hUhfxEYxCaPub/WbmUGOn9+eCvbZC
 9oKkH2R3Fxl/RTzMCd9TnrkeZ6aYvJiwjVKBeY0/xb2Bn28EyYmVZ56ky6QUk0dJTPCk
 vz1tAYTZYYUo8txtjAvVJoks9ia+4V/lbmtjn0t5gJFkJ/vEdXEZ1ZlC10maxYX2WOGz
 dWgy+cAk5oiigGb6PTsNBrccx2dC0FIYAbkpvIgt1ZyrJxhif6exh6zxOjUfjTul0ibT
 qq98xVceKJ8wapT+heSlHQfICf6QHHZAPsIPcsgtdgpcrIzeBIyE6y76gfICNPMosGsI
 tRCA==
X-Gm-Message-State: AOJu0YzZde0JKfO3odVGrh446sz6AHvsEy2HNv46GX2pE27RIca1qk+V
 u/SsCnHIcsQIL2a5Vf02pQJuM8jhYUSTtvTr23nnQfiO3MxUWTN10ZzNVeYLP7U=
X-Google-Smtp-Source: AGHT+IFFvFlG3WvvGlBgumoKXl4IIXRNQSFUoz418O5xwJ/w5MLkfCmvcK8GVUcdBrYo3vVSDpFpaQ==
X-Received: by 2002:a81:4948:0:b0:5ff:abfb:8d2b with SMTP id
 w69-20020a814948000000b005ffabfb8d2bmr29168ywa.66.1706199276691; 
 Thu, 25 Jan 2024 08:14:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fq8-20020a05690c350800b005a7d46770f2sm734595ywb.83.2024.01.25.08.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:36 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Prasanth Babu Mantena <p-mantena@ti.com>
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, matwey.kornilov@gmail.com,
 jkridner@beagleboard.org, robertcnelson@gmail.com,
 u-boot@lists.denx.de, nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com,
 a-nandan@ti.com, n-francis@ti.com
Subject: Re: [PATCH v3] board: ti: common: board_detect: Fix EEPROM offset
 read for 1-byte
Message-ID: <20240125161434.GR3652023@bill-the-cat>
References: <20231030170458.21668-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5GOaf2Z5IKJ4Skik"
Content-Disposition: inline
In-Reply-To: <20231030170458.21668-1-p-mantena@ti.com>
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


--5GOaf2Z5IKJ4Skik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 10:34:58PM +0530, Prasanth Babu Mantena wrote:

> EEPROM detection logic in ti_i2c_eeprom_get() involves reading
> the total size and the 1-byte size with an offset 1. The commit
> 9f393a2d7af8 ("board: ti: common: board_detect: Fix EEPROM read
> quirk for 2-byte") that attempts to fix this uses a wrong pointer to
> compare.
>=20
> The value with one offset is read into offset_test, but the pointer
> used to match was still ep, resulting in an invalid comparison of the
> values. The intent is to identify bad 2-byte addressing eeproms that
> get stuck on the successive reads.
>=20
> Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read qui=
rk for 2-byte)
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Tested-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--5GOaf2Z5IKJ4Skik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiOoACgkQFHw5/5Y0
tyygfAv/XVSMWtsR+dXAAgwyG8RqiDdKwHRGZipdVkcwTttZICvl8DFWvP3mhNQn
BTlb+TyFQA7SiwLaARH48DUB1db4X0IRF2RWiJPd1tfrFl3FhpWg/QyEVlhZRtss
S+fVvMOASzN04pAzwmlnIxjp0iFruDhpJjGnEkde5AdFrwFSE4Ah9YWg98jge0bv
B9XtgGTSaASJafH6H/owZhyOn0lz0sSdLqtAyG3Z0sNe034GktdnMc1UvjyKHTOh
3LBc7NwtsufqQPoBMFvFYdRtmmJPLqLmLHU6UO/EommkRMQCVmndlTEz7pIv3Jhc
Wta16zHkcNN0Br+Gb9tid+6OpSwOPdi2hLeZTWFP2e8vqHkG5adWWlMjpbtIwmnP
7ZiTkMnPcShIAHpJ593iDjwKb9+1e21mxz2IA/t9747oSwnsbE8f3kUx01pCTdjk
KSGVYBsTPCdZe5ZNE4XxvakPkUIHMokmcdzmfObSFvB/uvBakNZlVCb24MTVilV3
daUffKcV
=taFa
-----END PGP SIGNATURE-----

--5GOaf2Z5IKJ4Skik--
