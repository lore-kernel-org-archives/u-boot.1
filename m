Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97664C282C6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 14:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02854801CF;
	Tue,  4 Mar 2025 15:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MxEIqp+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 654ED80786; Tue,  4 Mar 2025 15:26:35 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2836F8006D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 15:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e60c4412127so2386580276.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741098392; x=1741703192; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3mSSXkncz73j7oE06FO7AxaVchchlP9AW57k5fkaW4s=;
 b=MxEIqp+CJ1IYdaitX4gsOgiWEwVTCn+TQxgFnEaRi28fq+cozECD0yhFXdAaL/qfqa
 9MajC5hr+DAzR0vPyR+HMwDV0qYS6uUC+9VQzaLJ9FMLBlDMIQTsu84vn4oS3Nfr2uBz
 i31snrq8OWQ1p60H9dxV6cBc3UhIu4ILrKAhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741098392; x=1741703192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mSSXkncz73j7oE06FO7AxaVchchlP9AW57k5fkaW4s=;
 b=e4a8UArnbDAGjDoxAmrykhIP7JuxSVk289/DwTUxMUBC7qhnZd1EnbPTFqc5b4Ikgd
 0fisXyupD3ieyOWr2szSQh8Nv+T2qWt79WGrbEOHnytWynXYHxtJ1McPQ+jpv+ZezuH5
 4IcMr9UFqf5XKvChym376wF5koa5Ro7dHYDxpDwOFIuwQu1qfgiFVgE39XBce6zoqg7K
 XYnb4EvQQp3g4qwqrMDemhkijDiLuj0UBJk85I8AV5gAtuPJnsZ4tNSWK8VrpQN40ulD
 cQDGwrqLtW3emw51H6CbihACHX56j4vPdAtv2BWrA+yILXolPez1UBTClZ+Z2y0lzfh1
 FRfw==
X-Gm-Message-State: AOJu0YxgWuw48/HeZFPv357tuQHZp+jhma89/oTo+uc8rYJ2NUVrvZ48
 rUa+1DAeqjzCajEv2Qf6BvnG1S1kCIXKEp8sM42B9bAI3aFWY/ZNewDgUIWhPS4=
X-Gm-Gg: ASbGncvRz7Ej5Vhwx2wShKf83c2Jdrj3hlU+LJQG2gcKb4Ng9HCpb4KoQHjTqNds5iq
 +T4rhtZMhcDFzHLypw7CHmwdfSOD5S5JVSufpDVJtV+uRtZK/u7CMEEBsLP/19dD6KYKnxokTrX
 groEvvQYeUWaY9N86AZ5VwynqyEFVMu3WmQYcIR8dSmwBiZfk+Us5/0tscvFHfpSkA2ZlVr0uvf
 v/8qOVD84ex2H/XdvisM1Jif9gsxe4SKgGNL0QiIvGNbzOkF+axx4qJJXsRJEvrmQz7CVy+ON6X
 F8pg7h3xTJlckPsB04nyYV4qQZQaXdEFXLJ8vRDmdUc=
X-Google-Smtp-Source: AGHT+IGJy1/+SiT8Xq3GHuycAZNXVmX1k2tRlfxhAlPZd8SLcueIjNbp+azz2TiQTpZwzFQK9zTSVQ==
X-Received: by 2002:a05:6902:128a:b0:e5b:12a3:1ed2 with SMTP id
 3f1490d57ef6-e60b2f043acmr21875359276.33.1741098391952; 
 Tue, 04 Mar 2025 06:26:31 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e61123e19dfsm393255276.51.2025.03.04.06.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 06:26:31 -0800 (PST)
Date: Tue, 4 Mar 2025 08:26:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH 7/7] CI: Run code-coverage test for Binman
Message-ID: <20250304142628.GW2640854@bill-the-cat>
References: <20250304130947.109799-1-sjg@chromium.org>
 <20250304130947.109799-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y52Kawa6vWpjf2Sd"
Content-Disposition: inline
In-Reply-To: <20250304130947.109799-8-sjg@chromium.org>
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


--Y52Kawa6vWpjf2Sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 06:09:44AM -0700, Simon Glass wrote:

> Binman includes a good set of tests covering all of its functionality.
> This includes a code-coverage test.
>=20
> However to date the code-coverage test has not been checked
> automatically by CI, relying on people to run 'binman test -T'
> themselves.
>=20
> Plug the gap to avoid bugs creeping in future.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Y52Kawa6vWpjf2Sd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHDZQACgkQFHw5/5Y0
tyxelwv/Q10lhdZJ4h0MWokwrH2Fcc3mIUKb/tClTEo148i9vOCLSaDJeDPQYKNh
85ED1V7NnMaySZel2XaOt1OvykdG8NSpUtC6VBflgyV3P85QhVlfQxDzzV4hY+9D
ja/sxFw74TlmEpzD2S38knfJEisTB6nIwE6dNzBZKsKnynN19+Kqg7HY+/+yMAjP
8sqtS7zHZobMTZc3RmlZES/hVdDLg6gRIqwJ+vG1khezGeVRihGljEDI82VG5Ocj
Zh2eB9fI1JYqiMVCE0vywAgTWMap2Jm8Lm6ikHskgby7Ian8DG3US70vfLYT6hCD
ZiZNPKQZMzKC3yHsyl/yoJIwG1Fasy0VbP22xScZbedOvgC3veCKz6G6zyC+a4e0
NeMXZHKZJ+RKFhTEmRyy31f5RCjiofrKw2x3iws7/xzuQBwu3ielrM1ik0d/TAsE
hMjb9qq/v/VdLIwVu+VKTr1nKsfYHxg2sck8dZNbptyifq9MX1geI0ggaQX7f1UW
+1pa6RZ9
=1TK0
-----END PGP SIGNATURE-----

--Y52Kawa6vWpjf2Sd--
