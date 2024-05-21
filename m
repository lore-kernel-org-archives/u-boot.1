Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149C7C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567C388342;
	Tue, 21 May 2024 18:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QmgL86Wh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2188834D; Tue, 21 May 2024 18:21:53 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117D28826E
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-43de92e236fso33846251cf.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716308510; x=1716913310; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c/s/8PnFBvL2jzNyyL5s6scauDimCU8tc2KSJNf1mJk=;
 b=QmgL86Wh7VNjL8WFUROysPdftDH/N4U+5Z+gF1Ziea1ShQqKyhw5J1hRS/uT9MlNb8
 eHSZ/L23xg6ulfZsDV8yEmT/97iKn0Yp0f0rluShyoe1mbCXNUzEk/v5CN69KBK2cegx
 CaRFgbn9MXaWrBbRwZwySnEtgooUbtIzZJavk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716308510; x=1716913310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/s/8PnFBvL2jzNyyL5s6scauDimCU8tc2KSJNf1mJk=;
 b=ktV30vR6+n2xOfCqOaepSoiK2k/osJrvvyh/+MznvG7id95msXd5McOiBYffOey+9u
 WThpad2nFLo5O84PA9pMSFFrMPnUsf8lEdf1rFNzxz33zsFjksPecLiK1pLPQweuhhY1
 ile98vge+D1hhOw7Y4KMPl32mB3+1ZENmQyya5DzVOLh9VfV4xxvmU7ZzIjQl8JllEPS
 5Th0VqNqY+t6Bv3otwFZAf6ZDeKjzN1KK1tePRKIQmJTbtD140ShaozImeVSdrZe5qkP
 SDMEqYOl34okEEMI+3LRWaMjGDMCQoXLcX1asfVoHYFc/FyroWxw6SnqSBcyOIzlEurS
 nW4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4XCVDenmaOQSq9BpS8LYSOD767dYem3+Wylb9p4NQGA/vxl5CICWhOWpgkAgEHUVhpqRLJ4P65nP6LOFjPuvK6xXdkw==
X-Gm-Message-State: AOJu0Ywdmm9pjiGkg0IzupfBzDHX00Io63hpsg+UL9gG9/jZ0zI5HBgk
 miJCNdlGEhwT5XzGA84Cv8eFASXcmFC568AWQhUHFYzmGHWjpckiZBSodWGUCW0=
X-Google-Smtp-Source: AGHT+IFpbY0f1TzjZhcvgRmaVVu/VHEitajm3gVV0ESdAO8d0p72B+3gSwe+s8fiS5d6ORBilRxXwQ==
X-Received: by 2002:a05:622a:1a0b:b0:436:4d7c:8a9b with SMTP id
 d75a77b69052e-43dfdcd6a97mr425470091cf.46.1716308509887; 
 Tue, 21 May 2024 09:21:49 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df68acf20sm161784851cf.50.2024.05.21.09.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:21:49 -0700 (PDT)
Date: Tue, 21 May 2024 10:21:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, vigneshr@ti.com, nm@ti.com,
 joe.hershberger@ni.com, m-chawdhry@ti.com, afd@ti.com,
 devarsht@ti.com, sjg@chromium.org, emanuele.ghidoli@toradex.com,
 matthias.schiffer@ew.tq-group.com, a-bhatia1@ti.com,
 vitor.soares@toradex.com, danishanwar@ti.com, bmeng.cn@gmail.com,
 mkorpershoek@baylibre.com, s-vadapalli@ti.com, u-boot@lists.denx.de,
 joao.goncalves@toradex.com, hnagalla@ti.com
Subject: Re: [PATCH 0/4] Adding support to load secure firmware for HS devices
Message-ID: <20240521162145.GT2568172@bill-the-cat>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
 <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
 <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
 <ZkzH2Sa4eGAxb2EB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="poBOEAEII+eh4INz"
Content-Disposition: inline
In-Reply-To: <ZkzH2Sa4eGAxb2EB@smile.fi.intel.com>
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


--poBOEAEII+eh4INz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 07:12:09PM +0300, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 08:59:17PM +0530, Kumar, Udit wrote:
> > On 5/21/2024 7:59 PM, Andy Shevchenko wrote:
> > > On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrote:
>=20
> ...
>=20
> > > Are you Cc'ing random people with this?
> > > Please don't do it.
> >=20
> > I used names names popped up while running get_maintainer.pl script of
> > u-boot
> >=20
> > your email id was there for patch-3 of this series
>=20
> Nice, the tool is broken. Please, work with the respective people to fix =
a tool
> or to tune it to avoid such mistakes in the future.
>=20
> (Hint: I would first disable Git fallback completely)

So you were cc'd thanks to:
commit 5e541a05f70296dbad07fc1f4e8678ad207bb476
Author: Simon Glass <sjg@chromium.org>
Date:   Sun Jul 30 21:01:45 2023 -0600

    env: Use include/env for text-environment includes
   =20
    The 'environment' word is too long. We mostly use 'env' in U-Boot, so u=
se
    that as the name of the include directory too.
   =20
    Signed-off-by: Simon Glass <sjg@chromium.org>
    Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Inte=
l Edison
    Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

And, I'm sorry because there are other contributors who get upset when git
fallback doesn't find them (because it also ages out after a year).
In this case there's not even a "tweak the threshold" option since
there's only a single commit to the file so you're in 100% of them.

--=20
Tom

--poBOEAEII+eh4INz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZMyhUACgkQFHw5/5Y0
tyz6aQwAlCM4Ba7qtEdj+JTzGpJRepdmUt9OzdJSalSbQIQgh4fFZe/ghD3kUDO4
BKa8kTaLrN7xF3ORgPcsLngAsp8AN0ibheZVJgaA0MoaQ6kGlcGhJty4GvL5/zVm
b9VmrrqEO/rY6NfiqzWPUxvY1qkuoH667g940+BdLV/gpAUyX+9GKbFZK90iaoMK
5Vc1O/1F0iNvw29KTc1QUFcuOsQFrvVw/7GJkx48AiLFHw7uHbWedwP4AFBB7zhT
5pjFawLT1dETTKKtcWOux0a6FT9bpE/mZ+yjOvAqevH+7MwV0jm1tgtY8lUfqpV+
452PtMddWUOGylhDlwH6BkEx6IV9H77xr6gDE2B5iCAhpgDfv9cMh+JZlFYqvVsy
alv8Yf4bewOlf+PZXYG1l5MTvBtLHMYIYwpRUqGzKobGrw7O+dzmRY53QvCMsooO
81s5Ce/PSWHbKMaMbUSYvCcN/ekcLIs2mcPj5UIEc8PlEEZxOfFh7bMQaRyyJgrA
NPnoUGFX
=PrO1
-----END PGP SIGNATURE-----

--poBOEAEII+eh4INz--
