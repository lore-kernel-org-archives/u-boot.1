Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ADDCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B573B86EB1;
	Thu, 12 Oct 2023 23:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cfyM1qfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0CC586E02; Thu, 12 Oct 2023 23:22:26 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AA88037B
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66afd39c8edso8299996d6.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697145558; x=1697750358; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ye3uAVrfVpdg6hAfdHV0i1/uvPa77GXVVE/mfSFpbgA=;
 b=cfyM1qfax6hqUVR5EMwb4d82Tdr0xfRPdpONEDmxYrF9X4Xnj4sknRYA/RKDi0zUsC
 DDtrCmVQEOYzz1wn1z/dUKmlootQSC0ajrSr+fez3VJ7/kuN1fTEe/yIUlmKdLUA7881
 sGkRqoLqHwsZgw9uvUxZnXtuFR5wKKyPuMrKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697145558; x=1697750358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ye3uAVrfVpdg6hAfdHV0i1/uvPa77GXVVE/mfSFpbgA=;
 b=JixTW1097Z2bs2WEN66wg/LvI4t4zyYR2aDvVL4cWSfuM9PguhgoLkAHMYlf1vXNhr
 zZo5TZJfEk99RBRRVUhKMkvC2C9SHOT3e/PqeamGNWJwgEr+086lENngNpAPn2GSOv6U
 XxGwjPAYF+V1eOTI9jgBJIwJdXjlnkBpxO0iHvEdDtJUy4HJIKTgADQ6HU4vkdqOSdQR
 dA6N1Plh0RBcH41e/USsFEYRcgxQzSrjc0HhKzqtvK+BmyXYJXlJczV2b/wKGsQ9hpt3
 /rhOC1Yehw3zykeoOiReR1EUzoJ3WEaV/DKHjvI/zuMBqwBHAm48X2jLcKMJLty0cFs4
 R2+g==
X-Gm-Message-State: AOJu0YxbWff6LMQT1+oJs+uPzFoLZdVErqVFKtYrUf1YG7SVeh1HJKvq
 Mw5KbcHp+l5Dq0wf04SFO5RJkdiPscfkHCBgbspNLw==
X-Google-Smtp-Source: AGHT+IHvDJUa4UP9XN87hHCzLwNV5xHd1fbArn6K/4kz0KmnlqjdFQg/tLfMofRRmOtXeFSNQTKcXg==
X-Received: by 2002:a0d:ead5:0:b0:5a7:e5de:79a4 with SMTP id
 t204-20020a0dead5000000b005a7e5de79a4mr5613144ywe.17.1697144679367; 
 Thu, 12 Oct 2023 14:04:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 j141-20020a819293000000b005a7b785f66bsm223462ywg.39.2023.10.12.14.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:04:39 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:04:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v7 7/7] board: ti: j721s2: MAINTAINERS: Update the
 MAINTAINERS File.
Message-ID: <20231012210437.GG3119521@bill-the-cat>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-7-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EhLC6bsc8kogfPXg"
Content-Disposition: inline
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-7-5d31f765dd2c@ti.com>
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


--EhLC6bsc8kogfPXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 10:16:01AM +0530, Manorit Chawdhry wrote:

> Update the MAINTAINERS file and propose a new MAINTAINER for j721s2 due
> to the previous MAINTAINER not being associated with TI.
>=20
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--EhLC6bsc8kogfPXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoX2UACgkQFHw5/5Y0
tyxPbwwAjbNMkZ0x3nYQkHB4kP2pAegRYMxN/N0ybjuzn6H8dSa5S/Wq0M+1w+5g
JKKNzoFvL56lE+qV16gxnuLgplJKjbNOn2gnrQUu/B+ahUblApjthIlin9Ygh83+
E7mStpZfC3es/MKoCBlHBEFniZPItAvzuVEL5YRvD7U7+pXgQNd1ohF1tCl3RpRw
f7yHW2or4DA5tpzKWvX12skoHy+HHrPC3BvnGncS1H61uyOWrVCeDn2+Pe/8eIJL
6m84XVdRc8ZByXD/KTePcZeu12GS0ZUAEsWx3AbVu3S49hhHYMxHY78bee4KNO4+
iSiipnkgXcrMaZTJhcy6B7EIEVGJzLXtL7Q8uYx9Qr1B8/76qUK8z463IZe42wEM
k71J9JOpAp3AdtJVTQIwS6wsEycCcF22ODHBGeZ8Onj1uYh2sjol6k23lbazzLsQ
xXR2qDwLUvo44Dh1Fl3ikDuvwxA0Mo1SAMcRZYTY3zYVHpddMAjcg5HlG8o1/988
9/9yTHd5
=DCHf
-----END PGP SIGNATURE-----

--EhLC6bsc8kogfPXg--
