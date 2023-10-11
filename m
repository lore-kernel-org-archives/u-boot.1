Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C511BCDB480
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D68286E84;
	Wed, 11 Oct 2023 20:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IYoAWA5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F3E586DD6; Wed, 11 Oct 2023 20:39:26 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B5186D80
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7a77e736dso2066787b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049431; x=1697654231; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JvJaGM6fa30M3tU93E06QZkMjnZJsbClNJ4ulw1sXPg=;
 b=IYoAWA5PNJ3fcU35g6odGE49itklRr/o0OqBU22Sj1mfFz2oxwvA0OefgoOep74CNj
 LRZcTaTGNpSHtutxzJCLOnj2TagjfjIAEs+m4NRxpVJqsEK6V/bRfIcTeEMmKdh4xD5B
 dLFyKcJ42Cs2lYGo0etTXtCsEAfDHtvfO1OHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049431; x=1697654231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvJaGM6fa30M3tU93E06QZkMjnZJsbClNJ4ulw1sXPg=;
 b=vBp+QcGRwdOWbi8Ic/vlU5j+iDj7DrSQ2K1hkx/T56+o7D0uY0bx8V+m54Tg+49Oya
 xcPHG2U8w+qzKdArJZ4Fk9mNQeU6x9h2f10F2yF0fpZMdVpsu8YgyVLxdzmdcSCnGkrq
 vNGQ4CZCXGFgLlFHRpilWpk15WIwoBht5cgaR8WBsodcG4FqXcT37QiKKLsWq/m1tdoV
 w0UvvWadPHufuvWCcJfYg9A+NCQlOEWYwe5V4pYW/TftnapVWZ9k+IHV7hgx4kmvKWpO
 xpr3AlYDnmBgYhVpA2qSw/UpgmHQ/Z9L1au0mr+t+VyR8Jyqer4ZJUWC5s/0Xt52itQb
 eC+A==
X-Gm-Message-State: AOJu0YzT4JbkrUcj2PO37Xk/LZvGOetjy0d5B2HPTqi7tInxwlia9AmG
 OQecMQanpWs/kabti5LNZs71BQ==
X-Google-Smtp-Source: AGHT+IE4B/JrXyIY9Ex/1kNYa+vaaAZKkp44r+eAbkIMpbysS3sM2x2laTwKacUCjIT9vBcquwcZnA==
X-Received: by 2002:a81:ab42:0:b0:5a1:e4bf:ee5a with SMTP id
 d2-20020a81ab42000000b005a1e4bfee5amr22074030ywk.41.1697049431556; 
 Wed, 11 Oct 2023 11:37:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a81ae4b000000b005a7b785f66bsm1658575ywk.39.2023.10.11.11.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:11 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 5/5] doc: use .dtso as extension for device tree overlay
 sources
Message-ID: <20231011183709.GQ3119521@bill-the-cat>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
 <20230925080909.365098-6-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+CuFIucTLJNI5Z0y"
Content-Disposition: inline
In-Reply-To: <20230925080909.365098-6-rasmus.villemoes@prevas.dk>
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


--+CuFIucTLJNI5Z0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 10:09:09AM +0200, Rasmus Villemoes wrote:

> Moving towards using .dtso for overlay sources, update the
> documentation examples to follow that pattern.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--+CuFIucTLJNI5Z0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm61UACgkQFHw5/5Y0
tyyBVAv+IdCGVC1Wmvl7zMezNNLtgOB71q9Q/cx0m6LJmTclwCV2ZaLgzstFAYZ/
Ew6zuowXa36bEspZxdr2gQiql2NNaNtReFdwersmNJh1pD7j8bdO+MerRs/cYIRq
OCUKqoYO3QxWOPPycFBwzSmZRsq8qnJIGiv9YrFlNJ7Os2JQD6iurZoyMIbJxf/+
5G5Eb4xRPatynFgfwEPnK3E+qgkXH+LIBBfQHNgQA6KqpmBHJ+5Afr1ixnsnabci
74vTxuAQDn4COvsdVCmcDK90WZM6skCegRuvjQDYLmmfK9jV99/wMCP6S4kPCKdl
hEO9Bk7x/J23f220NHnizo6u8HFNJ+CrsXuLRwtYlao1a14c8S39VXS5v5UmPcuQ
IPGBj4cQf/gwm3hCY/ze2qupop3lrSEKRcWP0qDJFkqJ3s8aZHdvmDDu9cjHvHbF
NTtoNXIQPZQT8DguuO8IdR6RLCLz1gwByrVPFZTBWI64isijVfaNhl6SApuzh7O2
aj8RdcdD
=t0go
-----END PGP SIGNATURE-----

--+CuFIucTLJNI5Z0y--
