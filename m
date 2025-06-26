Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF7C7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 14:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2492F80E9A;
	Thu, 26 Jun 2025 16:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GJ9qnRsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5540B82063; Thu, 26 Jun 2025 16:33:21 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382F7809A5
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 26 Jun 2025 16:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2e9071e3706so590587fac.0
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 26 Jun 2025 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750948398; x=1751553198; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oiHnWY5HuKsufm8s1zt4k0+GgyjtHs8NMPtOdzTorBM=;
 b=GJ9qnRsw9XlCoHfJkX+GxCHHpyKKwYRxRceybswvlhK0YCYR9yug9rgKmp2TiT5kK8
 DeifxjCHsocHxIyBmB6x8HMXbUX0cbHlMibZw1t7PzRLf81mNpy2qBzBDzeYWvu6qVvj
 ZODuU4GKVzbIZsu/v/60TNpkKKWLfJKv5u3Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750948398; x=1751553198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oiHnWY5HuKsufm8s1zt4k0+GgyjtHs8NMPtOdzTorBM=;
 b=TYvT416xbJ9JGXB0buUNsBVwW/fOUKHhorKL0E+e9x1NIqkLUmhyzyDaBaLo2xecVh
 O6RlKiYZutsviGdc/5sLspglSX783JlF1wmMZJcesYBuhUOTUuV8JvNVfv1U4VuGA5FA
 1CKNxeT6sutDM2gxFCgxZZuq+24doUV4rX8DScJqFSUxniiBc1OL7nMfeDoZzWZGYxUk
 ufouM/zFLAViFxHBRYGzqK5V5qjPUhWJoUox46uiEZrChIPgcrHTFb0JwF5Ev9KIepxX
 E/8wX35rUGbCJejpPfvASRrjODcsAXiFeYHtzbvw2GbxW0+KlpARNLpq8QwTpryHQcb5
 3aBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM5OHunKAgSPdxZgXm4y3R9zAEL/yG0eV2ls4o91kZIEr89P0qLJMCTZcXQg16X7nKK8Qpq1Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyNn4LPvMd8jY+pdQ+LwLfDW5jsCb7QZrS6YVmdKqgL/jrYFKXn
 7Lvr5YasWni7149YYOa/+zKS+d7GgnuyVGg1oAFpu0FMgWD5tlm5i29gqHyQzQHJoMA=
X-Gm-Gg: ASbGncukKP12LBFffprmzmGLs9Dwh/9C71xcdV7uY3N8Xbq9VApO7alnfNmUGShDzIe
 0u92Qur52eRyyGoGepNZVDYLksXG18N9tggRvb3Bs4O8JekISQDROUr082M8jyyRQwbjAKkWhfQ
 Az50VT7ioiy8J6a/BmzFcgdD73YvxYWTN8L5mYFr/76np+NeA0JcR/LBuRoYoUngLqsvCDu7luu
 poquEJ47/NLqomll6NN12HAWb5No6f21w565J2/d5eASQHDJmn+Rh8emmdz7Sp4XFx+EsXr3XKT
 cxXz1WcjSMF8OlRX3Mz6C7HkeyCdincUTa9MGU92LSzn729+zJp+TTWCmA9cd482jAXqe1jReZw
 9azcGimSAszVJgLE0Afi7JcM=
X-Google-Smtp-Source: AGHT+IEGcf2Ifx9hvZ3HhrZfK80VaFfdNr2kXhPcGiXF+GeFZUKo9BYzMiqMYFEw4jAaUcN4p3KRmg==
X-Received: by 2002:a05:6870:b294:b0:2b8:e6f2:ba7e with SMTP id
 586e51a60fabf-2efb21a6c74mr5243919fac.12.1750948397862; 
 Thu, 26 Jun 2025 07:33:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd512d404sm382608fac.44.2025.06.26.07.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:33:16 -0700 (PDT)
Date: Thu, 26 Jun 2025 08:33:14 -0600
From: Tom Rini <trini@konsulko.com>
To: yan wang <yan.wang@softathome.com>
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de
Subject: Re: [PATCH 0/2] Binman: fix signing an encrypted FIT with a
Message-ID: <20250626143314.GA1704048@bill-the-cat>
References: <20250602145228.79778-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5rPMR6TgSQyYp9zc"
Content-Disposition: inline
In-Reply-To: <20250602145228.79778-1-yan.wang@softathome.com>
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


--5rPMR6TgSQyYp9zc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 04:52:26PM +0200, yan wang wrote:

> When running the test case testPreLoadEncryptedFit, mkimage has been call=
ed
> multiple times. Each call to Entry_fit's GetData falls into Entry_fit's=
=20
> BuildSectionData then mkimage is called. The last mkimage is called after
> the image has been signed with the preload key. As mkimage uses a random
> IV for encryption and the timestamps may differ, There is a=20
> mismatch between the previously calculated signature and the=20
> final fit included in the image.
>=20
> During ProcessImage, how can one tell when exactly a fit is well generate=
d,
> and stop the useless mkimage afterwards?
>=20
> Paul HENRYS (1):
>   tools: binman: Test signing an encrypted FIT with a preload header

This fails CI with:
ERROR: binman.ftest.TestFunctional.testPreLoadEncryptedFit (subunit.Remoted=
TestCase)
binman.ftest.TestFunctional.testPreLoadEncryptedFit
----------------------------------------------------------------------
testtools.testresult.real._StringException: TypeError: can't multiply seque=
nce by non-int of ty
pe 'NoneType'

--=20
Tom

--5rPMR6TgSQyYp9zc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhdWiYACgkQFHw5/5Y0
tyyW9Av8DGqhCOaiEtFs7Stt2jh6TftejoYTE7xFhFVDNJEAH/nfAmCTr6e6XDRz
GmBceW8sumD7xVqSBVUDQs2029l/OmYLxVO81vmBU/if6NHWq1wDUdGonLGP8CPb
em58TIvYMwfS2UaTSWO52J1hHxI8IMtvOwC1XmRXKGdZ+pi42O4/Otc+nKxoXcJ+
+o0eknOMX/dGLObgymhvT1qqMwWYbHGeSsIk4JnFWGiDdUdi/MiomGUmAylq/JB2
cqy4T8aRSXp655Akl4UXsJqMaU0RztdMmMEg/bEzU6T9RIpcjeuEznCCBX2Bq+4/
sW4xxKjxzEAQjIFj+e974Beto0jUpqd4EksfpLRkqJemgmUoeodUuHbreiwg8hAY
OWJzagIpFwi9alOO1xNBTdxtgX/ANu68neQmb71Uzm0LO2ZP6yVOppbPfR/b4IDr
NyraAYkkup6wjmLOj1XuoggeLAVQJGzIUUNhXo1LhvjZ1cc7c0QUssbWgoXUqfCk
w2CVjrTS
=5y1Z
-----END PGP SIGNATURE-----

--5rPMR6TgSQyYp9zc--
