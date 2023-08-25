Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E961C7EE2C
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 21:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F7C86AED;
	Fri, 25 Aug 2023 23:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UlmugxDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF3186A77; Fri, 25 Aug 2023 23:52:05 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 691B686ACF
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 23:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d7484cfdc11so1476346276.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693000316; x=1693605116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2LKMVEMnZAdDFRkldypzGRNK4032lxnNrCewlRXfzIU=;
 b=UlmugxDsNhrXWKARhHRgrJvY399Hj4GwTOJMyQ+OK9i56mC8uFkzI4J8ECN2aflr69
 VRwEMMcO1BmsMe0NGO3eutZay1o4d1Of06jJcs728qnPcAc4X4uxjhphP0M/hwpcTFcD
 tsW8T7bdvqlw7OlK+IIAkYgQNep8RhR0P/WtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693000316; x=1693605116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LKMVEMnZAdDFRkldypzGRNK4032lxnNrCewlRXfzIU=;
 b=Z2O8Ol5gg3P4ULFNU+sloDMBjOCFP59gIoKxTkukLXvtWTwKtFthXQEgkcIHqugkC/
 cB3uE8ZBGZqP5VkrTxalmHhkOBmCjnVUbiwm16m1KJi+zGPmSYzQq4CUVGIMdBHtdqGe
 LA7bTfPAH2oFI2yNCF8MAeKi5Ve3yAMJJLXCSPfEo2fAJpae1/A4go8k/F/5W6Ze5eWl
 59HC1N53g9BWrWKTis4ZsBNEEG6e0mo4vrduIXG13kUPyI/o0DS5UrtlKrPaqllbp1t4
 YkzMubc89i8aZMDW7XHDWlbvUpjqEodrKX7hWOTYwTSVGN2DXPzGF1gBhSyF+23QtZx9
 tkkQ==
X-Gm-Message-State: AOJu0YxP3QmwD30wNV79cMDDevSTk4EkrsbXWVEk3bNBV5qIWgd8j9TQ
 n/LaChfLE9gUkA9giyP+AHZoHA==
X-Google-Smtp-Source: AGHT+IE8c4B5M/eGvhibfIEHBzC0sAd7olpVECQYP4Z/r63S6PoXWufHeNlFabX8gg8XvYsQCctcpA==
X-Received: by 2002:a25:dcd2:0:b0:d7a:c0b8:f171 with SMTP id
 y201-20020a25dcd2000000b00d7ac0b8f171mr527788ybe.37.1693000316185; 
 Fri, 25 Aug 2023 14:51:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a25ce05000000b00d7817223b11sm578757ybe.46.2023.08.25.14.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 14:51:55 -0700 (PDT)
Date: Fri, 25 Aug 2023 17:51:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V6 02/20] include: env: ti: mmc: envboot: Only attempt
 boot.scr if BOOTSTD is not enabled
Message-ID: <20230825215153.GQ3953269@bill-the-cat>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/C9tAP7Y+HXu8B7+"
Content-Disposition: inline
In-Reply-To: <20230825180305.69515-3-nm@ti.com>
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


--/C9tAP7Y+HXu8B7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 01:02:47PM -0500, Nishanth Menon wrote:

> 'script' bootmethod that should be used with CONFIG_BOOTSTD.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--/C9tAP7Y+HXu8B7+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTpInkACgkQFHw5/5Y0
tywi4wv+LcHVEcBUwcWazCuuan9ZveA2Q138+2dXbR0f4pC0gIjksNIpX9iL3sSL
iDN/dW75v+k3TI1RnmgKd1KaOgXtnfuAd34n+845UROkHV7cem+3wLjPe5+EYCdJ
YrfTD63KvbCuMAUHMSlctKkhQMPjfxSYcb+5VsLkWy8GWXfow7HzXFuZ4MX0lTNg
LJ2k9Ij5Qj9pt3TJclqCYrfqB2o/JKKkbm65fTM6ulYoP4xJrx2wwb0jVsrss3X9
3qfgFHTWHjKlAhgedvuofz/oYmiVcJ5FuzxsTIv8VzNcjdwV3uY39PFYM3j076Er
57kAqOQ6KMyuta8m+VIjtNhs7zh3knk9+5l4++SB53QXNxrr7kL6rCQ5UYy//HlO
Eb2QkEI6aLGvlvPVpZLw1sLk+pVygYqWcdfBa1Cz16y12vLIYP4GxCFejibUPGCJ
zvmszmdxU6INqhSIFHdHJ9cDZ6uAKdfA7LpFFeLcwLAgKP7Owyk1+RMQsYaKhIjl
K8USTZCu
=Fxtn
-----END PGP SIGNATURE-----

--/C9tAP7Y+HXu8B7+--
