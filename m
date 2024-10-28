Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A317D5B847
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 23:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8995B89159;
	Tue, 29 Oct 2024 00:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NWO24jhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9304E89152; Tue, 29 Oct 2024 00:22:55 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 306728907E
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 00:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-460ad98b043so41428171cf.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730157772; x=1730762572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tIJiF7QzDqqITMWwuBXIt2qoi8EsGdFeFS6nLtHXgeE=;
 b=NWO24jhLqwNfxOTAgFSJ5QsJd3FPdiz8XOIh3ZS33LV+VJLcNpRXPap/1PR1PpLotc
 M9ccmWeo6d6ugvzg3hZrPpkwFtOorynLLZq4HtMi+tmw+vJP85vbe3bC9Sm7DLwjp4U8
 j28wO6pj6Wy+5aKcKrO2KjSNM28XSjzyFSXPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730157772; x=1730762572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIJiF7QzDqqITMWwuBXIt2qoi8EsGdFeFS6nLtHXgeE=;
 b=H1i7CVACnRDrkJcaofPmWeuq8EDQr+FJd5bHRmf3So8CmgYoAaL5kifdKNT91ZqZWg
 SGfGmTXVguhxYXPlyBwVKxDjdKVVTzMmjmlwPAcSByR3e5aNn9oKXh1Ww9BOyyXK2yGX
 VPYGAZ5Z3M8KMxIhNxk6QGsifSDMvLPgiLVHixhAg9xXLNDz3HtwF4ub7L1MlqVTcbvR
 Sgn5g0jfTWrVAW+wAAOfgcmEGSPik8h8EXDyT7pOlbEo/eRCA0ES9TBh9O8l2xaqOP/Z
 6HBcgH2jzX5GSahBsq159FgJ2EKlkJHD8y+Fc8I9BNCyxbfpR3RkOhn9t8iQE0lgLmAX
 fzlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdwDHivljIr/EdEecydt5tcaWK9KcGu4bRdj2/Ib+tREaQM6UVljJqGR1+TSFYOlUxt75A/lA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywztm9yvIypvE6oP87UQHY8C72nNoatKSRVPeJb15Es1zxQzb7e
 Rh2eIv59+Oqfh3YiCH3Qtvn+P/g4IyvE9xKnplq/XpXnsqRNNdK0JTElvtGpPOs=
X-Google-Smtp-Source: AGHT+IFG3Wi2785FOAHpDDbDx2jQ/LKEC88x8XoRa2gVBvCau4ZCk/IN7/c1G0H9xFAetyLoU70WgA==
X-Received: by 2002:a05:622a:549:b0:461:43d4:fcb3 with SMTP id
 d75a77b69052e-4616842ff9emr2977261cf.13.1730157771972; 
 Mon, 28 Oct 2024 16:22:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613211c703sm39039211cf.11.2024.10.28.16.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 16:22:50 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:22:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 3/3] test/lib/uuid: Make lib_test_dynamic_uuid depend on
 SANDBOX
Message-ID: <20241028232247.GW4959@bill-the-cat>
References: <20241028164844.2308549-1-trini@konsulko.com>
 <20241028164844.2308549-3-trini@konsulko.com>
 <7eb00a6a-bba3-4aa5-ba63-1da2c63b3e5f@canonical.com>
 <20241028213441.GU4959@bill-the-cat>
 <e229e1d4-c2c9-4697-aa39-925a9ae5c75a@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xfbp+ZLNKWneNi2j"
Content-Disposition: inline
In-Reply-To: <e229e1d4-c2c9-4697-aa39-925a9ae5c75a@canonical.com>
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


--xfbp+ZLNKWneNi2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:01:05PM +0100, Heinrich Schuchardt wrote:
> On 10/28/24 22:34, Tom Rini wrote:
> > On Mon, Oct 28, 2024 at 10:24:58PM +0100, Heinrich Schuchardt wrote:
> > > On 10/28/24 17:48, Tom Rini wrote:
> > > > The dynamic UUID test checks for the sandbox specific capsule UUID =
to be
> > > > used, so we can only perform this test on sandbox currently.
> > >=20
> > > The tested function is gen_v5_guid(). This function is used to genera=
ted
> > > capsule UUIDs. It receives the test data provided in dynamic_uuid_tes=
t_data
> > > test_data[]:
> > >=20
> > > * compatible string
> > > * image name
> > >=20
> > > The generated UUID is compared to a UUID provided in the test data.
> > >=20
> > > By chance the chosen test data contains the string 'sandbox'.
> > >=20
> > > It is not obvious why this test should depend on running on the sandb=
ox.
> > >=20
> > > Where did it fail for you?
> >=20
> > On Pi 3, I forget if it was rpi_3 or rpi_arm64_defconfig (with tweaks
> > like enabling CONFIG_UNIT_TEST).
> >=20
>=20
> On qemu_arm64_defconfig the tests runs fine:
>=20
> =3D> ut lib lib_test_dynamic_uuid
> Test: lib_test_dynamic_uuid: uuid.c
> Failures: 0
>=20
> Missing CONFIG_SANDBOX cannot be the cause of the issue that you observed.

Hunh, OK. Lets for now go with it being related to the 32bit UUID
problem:
https://lore.kernel.org/u-boot/4b60130d-030f-405c-a753-eeb52a5e7b1d@foss.st=
=2Ecom
and that it was on 32bit Pi only where I saw that failure, as indeed I
don't on 64bit Pi now. Thanks!

--=20
Tom

--xfbp+ZLNKWneNi2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcgHMQACgkQFHw5/5Y0
tywFEQv+JexYbia4zVhloFqK204sl8d0pOSQzZBf08WuBTL21THY3ZIBjj5h+2dC
A1vnR23eqT+AP59wSpcyUwKmnay9LKCbNm6KS1JatSF66G33lZS1/fuf3lL1II1V
tCcAh7U2BGpkVO8YbpjGjLVlPoPuMv7xYEQksz2y/gypQ+9JG7s9B1NVB+SONEZt
Fq3WoB5TdMSYEYSLZRtSMVx1tsWjFj5DvVZnIIgcoyPoObEwpbTURGmKuG/l4lyp
Fy3KXq10Uk9ZkwewivMFkgnSNLcZJTQ/2X3k4dlFA//NpBoaP2aP5ogVe4GspM0t
frwJGJu8wzF4GmgMxJSDvOtwDKekosS9STnNz80afMf9VjoOEJcCSrHn/ZKp5ktn
/bDchzKiyL/Co11QZukUOXNzpmCXRiS5X7uMzqkgQR10VhsytMIcPjgSWumZ3TIb
C0XjJG+WmUPcyLMPNnrYv7Go6N4uu+ZW4FaA9nkALpYtkun77M/8TshsiYnP262F
pR43/RPq
=PhcZ
-----END PGP SIGNATURE-----

--xfbp+ZLNKWneNi2j--
