Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FEEE85367
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 14:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540CF83642;
	Fri,  3 Apr 2026 16:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TlYSLhgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A896483F9D; Fri,  3 Apr 2026 16:54:01 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F955800AE
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 16:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4671cbce465so793565b6e.3
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 03 Apr 2026 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775228038; x=1775832838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VxaJi/RPnjglFt4tObsc+yqW31b2VkGyeX7x/VJeHuM=;
 b=TlYSLhgGaDGapZQp5VJhBbxRCdSIcqZKafEwIEDgFW8p7prV9XY1n/fEH1u4M7QxXZ
 RpWKk16UHAApuCkeNiNaD35nJ23DZ54SorXWeRIvlWx5OiGFKay1iGcehnpMDwHi2MfR
 b7GErn/Ey2yRxPrGAqIqH5pxGMS61Xn3OMsEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775228038; x=1775832838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxaJi/RPnjglFt4tObsc+yqW31b2VkGyeX7x/VJeHuM=;
 b=dCCNj4mXHziB6jdq75J23f760ODoeJ3wSVbRvovGGkSnWxnU2vTFo2uXo844LLubd/
 TU2YgYha2YBVazrwN6Bq55US+/DKdyh2+M1nDXgcNozvrvkrol63VKweUiYWyrfwOvUS
 WmYdU4Tqm+VAwW/I/4+zLpeRxJMm/xyeBXs/qfoSxfUQzikp1S5VUSuxKeM/RbyfFTKj
 bP66YAyrwKP0YgDm863G3kGM+jlyNr5gr6ucnb0qvVjG2SvPqR5dSM4ogN/wEztK6MAU
 JpI2zASHlwpf9zX22Jxc280Kj87a0vflruJV7gbWKKQ71b6A0jUbO3Ivtl+XmKTPTYSc
 E0ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7nD9arIwVD0Exm6rr7YxU8HeBFrr3skGbHBmDl6hr9ajPettwKc8OmvZEoDaX3WoQpmZYoxs=@lists.denx.de
X-Gm-Message-State: AOJu0YyV7IajaITFy249mLM4+mh1LemEwJPXQncdC1Kth24rNkd12qjn
 41w+XuZqoMSAzcY3kOdKxm6jeFpEL8bxYQndYGy+OZEFBR9SILu4EpwTHbgLEn2O3aE=
X-Gm-Gg: ATEYQzxQktWQbqxbGCSO3jtPUs3VE/JRnDdX8x6qwfsZPxgVipDUdGeRXNQeSJSbPly
 x9+ole3tSNYxDC6Esgy8ybiT+RZKqZQ9cAaNUfZThLAbLiIDlIsb3wRq+7JUXghWsoWFu7dXWFx
 aFUtAtNnsECvFBTmenRcr1cSmu6FB4AyyhpCUzkwGIXfGElR1KC4NF4bYzhEdq+g8HtXX5pv6fH
 vDbnPxHP2/CK7u4QYE9N8eNjlyf6CqECme9srgQqpz1b3H2b8u3IFwDpQyqFMWHCGpXFuWywzIK
 8I6Gl8Be2jaPsUS1Mv84cyspuZFGGnFZsf417NDRv0nx5Yv1bhSyLDnXa9gfS9hNhSvEwqDx4JN
 PyZ1FWMHMyXS8RvfZnmCX0Qi+4DGP7YmYmGypczC71xNRCCM8sW49kmyjXH45neLl7vvOLQTp2v
 scP3urUkv4/aTrpWgrnbZ5CwyXJX/3vmR6wVxB8v6gFdu7rhpfTYdL8uJvJlATjBD3XsF+kR1GD
 hcOyVkePTknu6K0uTvHCTHHnh4FvTiJAYRaWfE55fhitGLl
X-Received: by 2002:a05:6808:159b:b0:460:f435:2a71 with SMTP id
 5614622812f47-46ef8218f3dmr1765273b6e.46.1775228038096; 
 Fri, 03 Apr 2026 07:53:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d92f66ca2sm3522057b6e.13.2026.04.03.07.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 07:53:57 -0700 (PDT)
Date: Fri, 3 Apr 2026 08:53:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de
Subject: Re: [PATCH v3 1/3] tools: binman: Test signing an encrypted FIT with
 a preload header
Message-ID: <20260403145354.GJ41863@bill-the-cat>
References: <20260402192431.2421155-1-yan.wang@softathome.com>
 <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
 <cb03b1c9-5387-4d20-91b2-1f41b6fe6d14@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vSx3ajQrQAmQ2XYl"
Content-Disposition: inline
In-Reply-To: <cb03b1c9-5387-4d20-91b2-1f41b6fe6d14@softathome.com>
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


--vSx3ajQrQAmQ2XYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026 at 09:41:47AM +0200, Paul HENRYS wrote:
> Hi Tom,
>=20
> Just after pushing the v3 I realized that this test would better go under
> tools/binman/test/security/ instead of tools/binman/test/fit/.
> I am going to push a v4 with this change. Sorry for the inconvenience.

Thanks. It looks like there might be a v5, so please add a cover letter
too, this will be used as part of merging the series.

--=20
Tom

--vSx3ajQrQAmQ2XYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCac/UfwAKCRAr4qD1Cr/k
CsaRAP96WZoFOrpac6pideEWJIkBcMnL5RdBiFy6Zw1S0t3fGQD/bbTutiszsx5V
3JOPx045uxuQ+7EJk5S37zxiuztBCwk=
=0k6P
-----END PGP SIGNATURE-----

--vSx3ajQrQAmQ2XYl--
