Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF88DC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0C482AA7;
	Tue,  3 Jun 2025 18:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LFn/+Sf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACDD582AAA; Tue,  3 Jun 2025 18:01:50 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC0182A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4067ac8f6cdso3482438b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748966507; x=1749571307; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5e/kJctgdXUddJxdujCaW69110h6Mkb4klyzLq/rQT4=;
 b=LFn/+Sf6HrEC2bLcGFsnqvPye8JUGfxe/vbg9O8ItNehS643lHa4a/omRGpmVPWQll
 inkG2eCdI0jYDXTcKnJfmB99x1UP1hzrtUO4DtfWSNLAgxzAS+9Yu8kitsAW0vKg7kv5
 6gUgj0yMvswAuV553RG90oCQtQmoJGXYuLhdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748966507; x=1749571307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5e/kJctgdXUddJxdujCaW69110h6Mkb4klyzLq/rQT4=;
 b=uD8wxrgaTs/tO0EwWlCiOhjWxHBPU+9zg7ZGN1p3dwAJpIJ69U/xt+7bF86aGkHJXb
 kYRNZ0m8NC1uf6bEKHSn7kVP/DrQzHrQ78hMWwgqb8flffzVskEGv2mT4ADDdL4pRH++
 ACem/LPihvpm8WR+FvP5cQXI0q7PdJlAH7jVeP5E0Lj+9S8hF1hzA2d9Rh1vO3fD9pBd
 BZqhKLjNhR5w3pNsWs9OtSvhZyJIKw0U8J0xQ1/s/V77X5cPGQeLl4jI9PUc6XH7YMY1
 d3P48YvUfFnnVZf+oloyArfVCgFfjVU4cmu0Kvur8ckz5Yf1q95Xc6v8qaOyBnQA8lYh
 88fw==
X-Gm-Message-State: AOJu0YwYpIOLG/0rZ7ad9I/03ZYNSy2i7zrHxNj+/kQd0uQWmVEDmaCk
 FJ6FstUwQMRq3/ZB81kkTYF6KAV1AAs7nffxbQ0a+szGbHYWF5sd/la0RDD6ObZ9sa8=
X-Gm-Gg: ASbGncsWyXZ0HnoLPYvx9VvW6I1f6MQBs0MJjdaX1n9Q6K5o2z+6zEo/KKmkwyCFKhi
 7nQx1I2VVdTn3zVFIwf4uKXYMHP3HXOEgzTsAZZ+PaVvZTF6kgf6TRfuUkq4bNJd4zcXx4C3SMX
 aifVNFdNI7z16FFIXm37oGI/A6fVqtJ3spfwbNTMJyt0hLu+Q9HeAs9gnTldrgWIbMMQ1h42wW7
 qRTDJg4KFqtr47fGHc2FxvxiQHWaRQVa0xN0oXDW5vLJuq8oH5CMoa/smI52VVuyrKH7NYiP8iM
 oppIVLIdO5xELZWZww8w7hIHweSo1/A1WIobr/SjqRO2r+2Rd0Z0yug6xtRsLSTvf78pvdJCYFu
 VKPQii1MGoW+8
X-Google-Smtp-Source: AGHT+IEhrzDMz/TMXUh5zT9DhfLwGi2bIhN5JOmzXdUXUssv3QTHcUuzFtnLnLte6FUY4PKspxsF+g==
X-Received: by 2002:a05:6808:2f0e:b0:403:3c95:3683 with SMTP id
 5614622812f47-407a65d85edmr9392372b6e.19.1748966507145; 
 Tue, 03 Jun 2025 09:01:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c40ad2sm1833734b6e.25.2025.06.03.09.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 09:01:46 -0700 (PDT)
Date: Tue, 3 Jun 2025 10:01:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] dtc: Add Kconfig option to pad device tree blob
Message-ID: <20250603160144.GH1382132@bill-the-cat>
References: <20250520182305.3819776-1-eric.schikschneit@novatechautomation.com>
 <20250602223101.GA1230232@bill-the-cat>
 <SJ2PR07MB9711838697E12AB9B1A53015816DA@SJ2PR07MB9711.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GVlGOPxvGZOySh8C"
Content-Disposition: inline
In-Reply-To: <SJ2PR07MB9711838697E12AB9B1A53015816DA@SJ2PR07MB9711.namprd07.prod.outlook.com>
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


--GVlGOPxvGZOySh8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 01:57:14PM +0000, Eric Schikschneit wrote:

> Tom,
>=20
> I think I understand the problems you stated. Obviously, we do not want t=
o cause any regressions,
> and I am happy to modify my patch as you suggest. I am unsure what to do =
about your dts/upstream
> Issue though being that portion gets synced from the linux kernel source =
tree, correct? As far as the
> ARM / ARM64 issue I could change the default lines to something similar t=
o:
>=20
> default  4096 if ARC || ARM64 || M68K.....
> default 32768 if X86 && EFI_APP
> default 0
>=20
> That should allow 64-bit ARM platforms to be 4096, but 32-bit ARM platfor=
ms to still default to 0.

The Kconfig fragment looks fine, yes. What I mean about
dts/upstream/.../Makefile is that you should modify those too as they're
the small part of the infrastructure there that's what we modified.

--=20
Tom

--GVlGOPxvGZOySh8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/HF0ACgkQFHw5/5Y0
tyxxiQv9E3IJuAquKCmwdbKuOy0+jBjsusQ0+PDP47Tto6Fa0Cy4VkEXuxZnhrii
AH6/l0MTfD4UV5dATDYHrHMQBM7EVOAjPsGDwk2cjh0qZ018OCSrop0skfBhoAua
atrWSmVS6LXF4GOmp3ys+2Rk6xPgA37HAMACvncKIHzKmO75KgynRpMrsrgTw7OR
cm7FTJKRuPr/BsVX7ujpoQoBN7uho1QJ6+s47SU8LfGJMo8vLe+AOlXXK0Kv1+Np
jVKdmKsK3JtMj82xrfLp+bORHypQQw6ORVxt2X0KsHXh54uNtmODqnrYjiSnTzCo
dIaIvbW9mv74xYEqrHSMLiia+2v3A44az+oSOR/meFUbDIU87do1ycRWiqsYtEEd
r7BSxj+qhANU7A8wZlrN8bFNMS3+JGL0c5wKas5RK/wvx7BrRG8l6Ij1my9tGBR3
e+/AGfscrJBKvht1SwI3ayAMS7aMRjRJ7nlAyEv4SttbjrR6O3bG6YsRvdqZsPEO
O7W49XGO
=Ye/B
-----END PGP SIGNATURE-----

--GVlGOPxvGZOySh8C--
