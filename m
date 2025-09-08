Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695C8CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 21:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BE882B20;
	Mon,  8 Sep 2025 23:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l6TlRjVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FDD83045; Mon,  8 Sep 2025 23:58:31 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAEFE82A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 23:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-30cce8c3afaso3459179fac.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757368708; x=1757973508; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NKoF5M6J61GD4CBoCx0LqR96NbyDQom1WMQBdRqCSRY=;
 b=l6TlRjVrt6jIGDlnI+/b4/H+Ui7PLCCNBZ5vuyStCju9RZAWhJhcbr+I06W7g9bTn9
 oxRodURL3MOBOmxTnxd0hEVYSSOQ8qX7oUZLAHGwqUOHpcU/3bkreyoHaYxgtGzhFVij
 qBHCSoTE6xEMSKOk5LTYiyBSBVxc9XNXdr820=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757368708; x=1757973508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKoF5M6J61GD4CBoCx0LqR96NbyDQom1WMQBdRqCSRY=;
 b=LiskoJRIBQ61sp6uwe3AfUTbpKeEzE20sm2ZwVf0959AmzPJZz/5pm3UgOAJNSdnPo
 P8z3Fp58VBb6a9fxrUCICGnRpM1VFap1MvhvMd+ddydo1L9qnSntcREsmFJiBbhcuNXj
 JHg0BjJZOXHnHZGZ/JfyTXNM5We4LQUy3lu1Uar0AozVDXPawF7ZNfkJSXmUX/S6kCIM
 SCJrgvC2Mlzj7zuI0bWAjeTksYkBHnX7KEkvIyYo10DNfpcjC5iDhWHlCleRy6CT+oZj
 5dZn+kujApL53ndC7sGilBOHFvPXsU76OEdJFvU7b6OJei0Non2cyklJbXX3DEHsjmde
 M99w==
X-Gm-Message-State: AOJu0YzACnDHl+QYe0EVbYs5d/TTGLQoZ6ojFfFXusbbAA0PX+uRNmh2
 Wc4jR8qlcGDeQe+PQmYxdtsuasWEPBNhN7srLJmUJOrjl1ShWE15IdguoTxBiPId4b4=
X-Gm-Gg: ASbGncs2oX1Fy0GhRw4jhhH8ylC4Al54X9wqf4ha1naFrLZ8auSM+krWtQ8kBqgGrL+
 qbbqWa2/P3X7QDTRkIY5TfSfB7TSAW1rcTbPH8lsSXZpP6AoZSYTEgCkT1XddbO80NKFNaWhmec
 pMSKyHaoP9HUIhc1T99HafFJ/5wfY9/PpI/uej4MUE7ztsOz4UowKIZ5OBBp5IsbO5h+W9gauGt
 BDlU5xjrCfpEj13hdA8G1gOWI4qg8Caga05i5D7wduuDoGs0j3mogqJxe0DJcQLWFlFYAegQ/Kv
 0TJ2Oyb/N1wFEQj/ArscdC2AvtUOzetKfUanOuEyXing99reVmqX4a42NR/IQXyxMyahnTGbOpI
 8WhCw5pv33wFrfuitpVc20kuuhukxLxJJlo86k+1x3nTDjVkOHX57Hkr1YD/pimjxSAw=
X-Google-Smtp-Source: AGHT+IFYkgmX6X05Dp/ZbkqWTIg9VGaHzc7iBJeG7dWv5eVgfKH9S7DOXv7mn9dS+mcVnOaFLMGBYw==
X-Received: by 2002:a05:6808:5249:b0:437:d3cf:4b39 with SMTP id
 5614622812f47-43b299f6cd8mr4685024b6e.2.1757368708361; 
 Mon, 08 Sep 2025 14:58:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b2a4183b1sm1828095b6e.11.2025.09.08.14.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 14:58:27 -0700 (PDT)
Date: Mon, 8 Sep 2025 15:58:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] doc: board: ti: am335x_evm: Add documentation
Message-ID: <20250908215825.GT124814@bill-the-cat>
References: <20250903202043.285746-1-sidharthseela@gmail.com>
 <20250908055429.598536-1-sidharthseela@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="joaMLJxnFe3zRXNa"
Content-Disposition: inline
In-Reply-To: <20250908055429.598536-1-sidharthseela@gmail.com>
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


--joaMLJxnFe3zRXNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 11:24:29AM +0530, Sidharth Seela wrote:
> I am confused on where to place this information of the
> configs. As the new configurations need to be added to the default
> am335x_evm_defconfig, as well as some unused configs need to go to make
> space; to enable falcon booting.

I think just documenting it as per your patch is fine at this point.
It's not the default way to use a platform.

--=20
Tom

--joaMLJxnFe3zRXNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaL9RfgAKCRAr4qD1Cr/k
CrSsAPwMV4+MPBOGpvzNtoWYZWa57X7zegf/9LJLoce61WjvlgD+P8sDCw/B7c7p
k6P/DsDF03bPT/1ajKR8YMysUovlTQo=
=h1hJ
-----END PGP SIGNATURE-----

--joaMLJxnFe3zRXNa--
