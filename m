Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408F0C54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 802DC87F63;
	Thu, 14 Mar 2024 01:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yid6Wa5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C99C887E3A; Thu, 14 Mar 2024 01:39:17 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAD0887F25
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-68f571be9ddso3172096d6.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376751; x=1710981551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rk9nh9mWwiO80qEszSeaB9euRDtWRhP8+eOTBx2CM7Q=;
 b=Yid6Wa5uMgoGyGYc2zjf2ERZUP2N8wnzp3sqsxAX+yKy6qjbdNAwz4VoEdr4pbvczy
 IJNFCMV7z3ThLWw1dAaRyQyDJr0iNzlKZpiiVp0fAKz+N1siCFp9TedcUUzi7uVgCbmr
 W1HSlOZtRBOSO4c9sPmtZv3TX1McYpAN7Tfss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376751; x=1710981551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rk9nh9mWwiO80qEszSeaB9euRDtWRhP8+eOTBx2CM7Q=;
 b=a/2VQTAwwk7YMl/IykkwW9MjpRNHJ4YfcZO14jxP3tA8VxOQheNQMHZ75WBDfcKXDW
 tpMn8BPU9pW/xOZPc1jaQtc5n0gYrVN85ulkVCPkFNeyes65p92QbGB92XIim+EnAuDQ
 9zhdD5yDAvRAvGCj4stRwFaCzVLHCo1O4yLyo4GyDC7Th1RbwnEpweCeOev7OLE/1Oah
 c2DKuWVzUairb7hXpGsWqsPcDSzp1zTv+Lv0AQpxH8uVojnclNlo96iFjR5ElWBb3OUw
 MEM5NKftKP0koScSVhvGiEC/19ZxDkDTSWLlYu5nqyQTL5Fd6FpY61MmCXax2YmlzKbk
 AQSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx/Kbm3TZBZUhk5ZVx06RjAoscJyMaGgcozy4Bty0bIaEioutazoXAaaybOudxB6zpHxB+0wyteeLiDgOa0LnHoo4W0A==
X-Gm-Message-State: AOJu0Yx5TgWiabJUmq5KiqqbU6p4DeE008ARmKkrW2fKYM936qQ8/RM0
 4P35ceXEGU4fwLe7opgBkkDuvWsNoye/qXyqfK3k0dfD0ddl6lX3haetb/CEuG4=
X-Google-Smtp-Source: AGHT+IF5vKxsyJkSoOohE2VRUmBdAAetGE8K4sNn73G8SCiqEt8s0QN24lUD/s0NzsspyIcVFqlNtw==
X-Received: by 2002:a0c:f6d0:0:b0:690:ed71:d982 with SMTP id
 d16-20020a0cf6d0000000b00690ed71d982mr322147qvo.2.1710376750693; 
 Wed, 13 Mar 2024 17:39:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 jn7-20020ad45de7000000b00690befbe5a5sm223411qvb.74.2024.03.13.17.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:39:10 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:39:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 2/3] driver: rng: Fix SMCCC TRNG crash
Message-ID: <20240314003908.GF3442575@bill-the-cat>
References: <20240304144242.11666-1-o451686892@gmail.com>
 <20240304144242.11666-3-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nTLZs1AsXOOZ6c9t"
Content-Disposition: inline
In-Reply-To: <20240304144242.11666-3-o451686892@gmail.com>
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


--nTLZs1AsXOOZ6c9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 02:42:41PM +0000, Weizhao Ouyang wrote:

> Fix a SMCCC TRNG null pointer crash due to a failed smccc feature
> binding.
>=20
> Fixes: 53355bb86c25 ("drivers: rng: add smccc trng driver")
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--nTLZs1AsXOOZ6c9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRywACgkQFHw5/5Y0
tywJHgv/XWwKR4CsWtAaVG32sXbhhABgFHa+SwvFkw/f+XbvQlhU1CLVjQ6Mlxz9
tEc9n8uJ/UKwGcRU7YliRC4Hzveogk90kPUzyySHnBRpqt2BgWKJYKOZiDB3KPTE
CE6v/SNbklzA6+OE4dJZhMtdM7uzynQ6FnJki/NlrDA3ISqrhgZ4zbnEaF5K1d3I
PY083BtH1LCFrtRo/qEogdHHvSUaQpauNuT+AfZ+fvsLDX/9G9QOAW38OHTCLXtK
q1vIRvqKypKQALtxoymYguw+GTKuAjDwbN3VdUtW5Vb9p1SgcQ6D/pMDV3/qv1ww
Ywe1QeNEAPIfKuRaoTQIrXaqnUMbyGA/0AyPxyCYYehjPA1/pbaOppSXr1CBx5Vh
OpeKleoaOBoF5uJun8R+e6nTc14fcVNrLv5AB+6RYuP/yihaKZk7gkAxVNlV7r72
ooy+hHOscuthfJcKcjpsEtEhNms8zDbkRxdPv95CQets+xzv57E2km83CK4D/ETe
ej+w22GT
=gTPO
-----END PGP SIGNATURE-----

--nTLZs1AsXOOZ6c9t--
