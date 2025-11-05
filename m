Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0863CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 23:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E74F83AC5;
	Thu,  6 Nov 2025 00:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jAAyzwOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DBC8839FA; Thu,  6 Nov 2025 00:09:14 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF23783AC5
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 00:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3d3116a5a26so299462fac.3
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 15:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762384144; x=1762988944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4YaZwQHywWqILXYeqWK6OUqEAU6UKhe4+9BI0nW1QSA=;
 b=jAAyzwOjOeAs+74mdNeZjtmuC9Kf9544LUOtkOnWuuN6v6kdPGWVR9rfR0Zb5zyJga
 lWGfxA1az3W/NsI+JGP8XKpBf3MF2SKdGfVu9WFc7O1Agnyh3a+KhzpdnP3OYKsvFcbX
 oUHu6hLHEVFCZ4w1Ov2NAWuYo8VURJa9SrEHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762384144; x=1762988944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YaZwQHywWqILXYeqWK6OUqEAU6UKhe4+9BI0nW1QSA=;
 b=t1euPf5xcG0U1NjIo8//ZcsjOk1AJMwqQc4X5bPdk0YYKPgOMj++tczDy1N7WabtFX
 R50fLREarpOKH64WF5T/bnDjB/rQKnf9r7onIseHTO8agST2VA0XURAcPf6oRJQBpxz8
 Ir3RWWFvVpCG+s/DVipZ9RUsH3rb5xl3eXp3AIZicRl2q0yV+UkZD2qXQ4JhlvC4O35p
 rMB+O0eA81z6mknjbq/P2WtJy5naOV1PKaQ0A0pg1Js5oWVeQmuHmiZURf/oj8LBrHrm
 /7OAIvbtcV5+Uz4CaOkfdEfrD4UkyZugx5/FmxLGrZxtW22V7QIlwbze4PYUOqUVnXX1
 XBsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0+xyL/y7v5MP87KANj5Gz6WvBr2ObPFCUbyW0ciyu8mP4Z6kKr4SbmhaaKQrAcF+HpTI1h4s=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1PfbZxslTDkmMzkH7ujUSmIeMu44GFeYVjUuTOlH318qJAq5Y
 dwBtPwaxsKOhDhs7rGzxWIfe3kkeXmGnWTWSzqqKKhMAoqVRLrPdlQRVKkpq3kPRJOY=
X-Gm-Gg: ASbGncux9QaASDzL0fvlskkrn2M4i1bcsX4gwsgfow5uyAcsFDrvenZY8SeD0J+E5Vd
 wr1iXO34Vmzh4xPRcY3bPGOawSaQQCKbglLj9zLO3A+tGvM350zkKkF7PX5nlnrqdXBdr+OVPvt
 F405OuPfh68E/C/D2DguxGOY67/fYeUCxN2UJPqPlhhw6Os/JR5cI2vxHc1ZXOD8yPJtm99xFqx
 i6BYFzkoGLlgHs7Ul5s+lpGD2ZfslwAqGVkgX1wVxMbtheW8H5WYyMv4jWyK25L5qClJYTUqtSA
 ZIRFmpoGK3g2Ma1H0Ek3gtzK7pZeoezY2iHmMvfFxAXu4rPdncjqupSjVjXA6mhOWk02AB2pset
 9cGi63KB6mdMB6xe9dTC5B9hYyPEoC0zEK2hVi1mXYi6nIExrIs/cY33Q9HKySM1RkXZO9t3NzQ
 kX9UofFXzr5PTQ/FlG1VOhgyC1j7rYlBGQpqGHDpU=
X-Google-Smtp-Source: AGHT+IH05mLTGR3QPN17+wg27gzI8We9e3sQnTsYmhS9uhmYFTArsCcsQKPUh1zz461x8mKPlONJmg==
X-Received: by 2002:a05:687c:2057:b0:3e0:df48:d5df with SMTP id
 586e51a60fabf-3e19c15b067mr2633274fac.34.1762384144505; 
 Wed, 05 Nov 2025 15:09:04 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e30823e536sm285691fac.1.2025.11.05.15.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 15:09:03 -0800 (PST)
Date: Wed, 5 Nov 2025 17:09:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] test: do not write to 0x0 except on sandbox
Message-ID: <20251105230901.GV6688@bill-the-cat>
References: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
 <20251105192601.GT6688@bill-the-cat>
 <20251105193307.GU6688@bill-the-cat>
 <0a146dc8-f1bd-4a92-ab42-29909da4e7c0@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+a4OZ54aXfjE07me"
Content-Disposition: inline
In-Reply-To: <0a146dc8-f1bd-4a92-ab42-29909da4e7c0@canonical.com>
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


--+a4OZ54aXfjE07me
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 11:57:25PM +0100, Heinrich Schuchardt wrote:
> On 11/5/25 20:33, Tom Rini wrote:
> > On Wed, Nov 05, 2025 at 01:26:01PM -0600, Tom Rini wrote:
> > > On Wed, Nov 05, 2025 at 07:07:47PM +0100, Heinrich Schuchardt wrote:
> > > > ARM and RISC-V do not have memory at 0x0.
> > > > On X86 interrupt vectors are stored at 0x0.
> > > >=20
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.c=
om>
> > > > ---
> > > >   test/cmd/fdt.c      | 4 ++++
> > > >   test/common/print.c | 8 ++++++--
> > > >   2 files changed, 10 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > > > index 96a8488e172..6b07999c88f 100644
> > > > --- a/test/cmd/fdt.c
> > > > +++ b/test/cmd/fdt.c
> > > > @@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_test_stat=
e *uts)
> > > >   	uint32_t ts;
> > > >   	void *buf;
> > > > +	/* This test requires low writable memory */
> > > > +	if (!IS_ENABLED(CONFIG_SANDBOX))
> > > > +		return -EAGAIN;
> > > > +
> > > >   	/* Original source DT */
> > > >   	ut_assertok(make_test_fdt(uts, fdt, size, &addr));
> > > >   	ts =3D fdt_totalsize(fdt);
> > >=20
> > > In one of those "what is even going on?" moments, just out of context=
 we
> > > set newaddr to 0x10000 and then "fdt move addr newaddr ts". Loooking =
at
> > > my logs for am62x_beagleplay_a53 where memory is not at 0x0, this test
> > > is currently running and passing. I'm going to fire the platform up a=
nd
> > > poke now.
> > >=20
> > > > diff --git a/test/common/print.c b/test/common/print.c
> > > > index 76ee851fe6a..389d6bf4069 100644
> > > > --- a/test/common/print.c
> > > > +++ b/test/common/print.c
> > >=20
> > > These tests are also running and passing on am62x_beagleplay_a53 I see
> > > in that same log.
> >=20
> > I'm poking TI folks about this in that it seems like memory is really at
> > 0x0 here.
> >=20
> > But with respect to this patch, NAK, we need to figure out how to change
> > these tests to run elsewhere rather than disable them on all of the
> > platforms they currently run on.
> >=20
>=20
> These tests that are not passing on qemu-riscv64_smode_acpi because of
> illegal memory accesses.
>=20
> Unfortunately Simon has written a lot of tests with the sandbox in mind. I
> agree that it is preferable to make tests more generic.
>=20
> test/cmd/fdt.c also has issues.

Perhaps lmb could be used to ask for a new address to use and then free
it?

--=20
Tom

--+a4OZ54aXfjE07me
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQvZCQAKCRAr4qD1Cr/k
Cjl3AQD3jVrPG2J0zTkcxYWEHo/X4/ugl7Ro3R2O35ihpMtVRgD/QFe8UZC1fkAs
iAQInNaxi71a+etykDxIRJZhaciurwU=
=jsHT
-----END PGP SIGNATURE-----

--+a4OZ54aXfjE07me--
