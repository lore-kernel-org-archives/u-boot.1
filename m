Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F29EE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F25186A20;
	Thu,  7 Sep 2023 03:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eTkGf2Ke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C43086A20; Thu,  7 Sep 2023 03:53:34 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32FE86A0C
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58e6c05f529so4840287b3.3
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051610; x=1694656410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+nZ+VbFkTozxZIdrcpFPu0Ce/60OvDjqd+wPgqCGcFY=;
 b=eTkGf2KexEjy4oIFjnSswmbdTPFO4VWvCTD8wtC17QwsxgCptM+QYB6ZPSoU2ThRq/
 ifprrqiviJpmVRUaIh/SvGrNiKgrXiPXBh3sfoYjP6KdAAjRTAYDTgVVXPQf2N8wjTG/
 8XdGb4YF8a8jg3yccBnLPCBlG88KyWsk8LOyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051610; x=1694656410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nZ+VbFkTozxZIdrcpFPu0Ce/60OvDjqd+wPgqCGcFY=;
 b=jRg9a5YR0IDdrMx1jQzIvFqyfipC0ZjRuMvmC9wWavK/cHL4uM7omdgLiTXLBXoV7J
 aFEPJh1u0kwlcWc11rUFiN3XI+mJyBDlyyM/AmsV0JbFCyVdUXxxWz81oBNNJrtaFmLU
 Ltms1OMKzvVOLZYtsJfHITzaJjQsw7Iq55U2idHUl3DeJJWtrX9YNxfR/3tF/BvQB8/6
 vhzhy8bo2egwrIOFKwvmIHWaSegpPpoNESQd/Y6Pemqiw71uewJ/VT2vEbQuKROAkpVJ
 xf5nh4uogs82KEOxA0iT8W2d0Lw6qx1iNfM6a7Mi6Lr0SI2Or8Gg6omWYMmGa5juLMmI
 hS4A==
X-Gm-Message-State: AOJu0YxCM/5UeGgFjOL/Zb2ljThuVlWoBGJTTqc8f05kOmcUz1q/KYc2
 yUWfuUFN2O+TjrnD9yY+GTNT3d848Puy+Kvr1qjA2Q==
X-Google-Smtp-Source: AGHT+IGC8WZ2iybF5syCzlwAGWZwiF2EJyAZFNctKfbx5Vj0Nv1GlZOyJBOPedWSSqnhQnBNsE4+UQ==
X-Received: by 2002:a81:494f:0:b0:583:9c78:9a84 with SMTP id
 w76-20020a81494f000000b005839c789a84mr19374389ywa.43.1694051610453; 
 Wed, 06 Sep 2023 18:53:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 t76-20020a0dea4f000000b005922c29c025sm4046761ywe.108.2023.09.06.18.53.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:53:29 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:53:28 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] Azure: Add sandbox64 to CI
Message-ID: <20230907015328.GU305624@bill-the-cat>
References: <20230901204143.3617876-1-trini@konsulko.com>
 <20230901204143.3617876-3-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PuJWihIdvkmgWIHn"
Content-Disposition: inline
In-Reply-To: <20230901204143.3617876-3-trini@konsulko.com>
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


--PuJWihIdvkmgWIHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 04:41:43PM -0400, Tom Rini wrote:

> Now that sandbox64 can run and pass the regular test.py suite, add it
> here as well.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--PuJWihIdvkmgWIHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LRgACgkQFHw5/5Y0
tyznLAv/cYFeP8gsiPq51tGwkLUUB404exf1b/JaVy1lz+Ubpd0g4RcbIstDtHvW
OKWFuQNQTDWu09vQTXDSwJ6ZMDcJEFNrg8Ae2cosu+V3Qk4VcCc9VXRWmQ5mMdmq
mGxNwGvw9OTQRNKggzekQl9QmF99+QDWr4xSSn9aHWDEyuMEPFFenAGCZdJuqjOD
/225RoMwfe2eDi8R5bL3eWAz5PiZi7dh0C6zUfEcw/hKH5fK8Gq63fQ7c0htaf4p
u2jJkmEQsK7cD6ci+IAqTJPwNv+Mr83LtGv2p6vTxkm5AFBhzDhV0c3qZdvXDQjW
4CDQMflAYqZPsU5+/ZvRW1w0yocbeNpQFysRVicyx1OatoGRU/+68WITIpdEQzJb
4QWxjpXZ8ubbuEJGf3mnqqktHCA8qTzdyaQS3UzJ4SOnHO+d+CMBXuyuChho/tiI
Y+fVpHa6XC51r4gUeKDGwDWvW0w97O4vJn7D4Vg0YKQ0MeF3VzCRZi1gQT8/ixTe
xx8C5o+9
=lrlk
-----END PGP SIGNATURE-----

--PuJWihIdvkmgWIHn--
