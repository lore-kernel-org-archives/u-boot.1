Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49A3C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 17:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE3188381;
	Tue, 21 May 2024 19:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d8G9ogFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8538A88385; Tue, 21 May 2024 19:52:55 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57CDE8828E
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 19:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-792c031ffdeso367629285a.2
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716313972; x=1716918772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YfDikFwfUItanGHd7uuOXK2Uw/mBAEbB645UFc42xy8=;
 b=d8G9ogFAHmHHdSDhHpZPjtt/yXCENQfI/Lh5C2TCiQiEvHKZiooCSZl2ydtbjqQ/dH
 GtvYfhp5O1v95DWJ11GaGrmNlyr90md9tkaWrXAdiAV/JyHDRpuBCL/2OZHggIHodah0
 OQKPJBAdSLKIP8LvCiJk+zt7SkvjIe462hdkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716313972; x=1716918772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfDikFwfUItanGHd7uuOXK2Uw/mBAEbB645UFc42xy8=;
 b=f9Z1R1Q4lEDIoIHlJlTo7aL0jEIMr33TNyStYRRL8Dlk6NfFZSuna2AH4KyveWs+oG
 nXx59hns+yTdpx7siY0zfWgTlyGXbH64wn8Syp0WSugONzOwvlrpI3+/ZjQ0TraewUo5
 SgrN40taS3aAldVm8LOoMAUbCY0G2i0Irh5k0Lq0d57mJM5Ic3kqPYVe4PJxdyoq0pZD
 x9qs0b5iWjg+fbMOwR48BQC2wYvBFbUmY7dv8E2ZtUbq1WZ0iRrs7dIkzcBQcXVnMkCa
 en3kndX7R7d+rcMcw24az1a6vXyQTJXRp446mtDwlld6GcSNgzIxqAkOsrO5O9aWtcqk
 setQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYVQlGuW6tbm1IVlpdL6j0UOdYRpmlM/gyhkOggwNnxLCY2Zw90E6aHGhOSh8qtWATbJ2VrQhkFKT4G0yGTslFJ+b0ew==
X-Gm-Message-State: AOJu0YxO16oaSvkNwVhjokh2jdVDK5PAH/si/PEw24G96Jck50riOZ7X
 N6g6uQTJq6GVNS1jBB3eSYZyrTQ9p3cesGDPcFHNpv0vC0XZWrH4EbV0DcSWEsY=
X-Google-Smtp-Source: AGHT+IGojkE0LoWj5eA3udGz+5wMyb0rV58lzHtKPbG3goekwaPsmvhJKJ7oQdAUx6WCqyAOLy7vjA==
X-Received: by 2002:a05:620a:2903:b0:792:9ca7:212f with SMTP id
 af79cd13be357-792c75ac0d3mr4024164885a.31.1716313972103; 
 Tue, 21 May 2024 10:52:52 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf275229sm1314706785a.18.2024.05.21.10.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 10:52:51 -0700 (PDT)
Date: Tue, 21 May 2024 11:52:47 -0600
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
Message-ID: <20240521175247.GB2568172@bill-the-cat>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
 <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
 <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
 <ZkzH2Sa4eGAxb2EB@smile.fi.intel.com>
 <20240521162145.GT2568172@bill-the-cat>
 <ZkzNa9TnTIixVnfJ@smile.fi.intel.com>
 <20240521164541.GY2568172@bill-the-cat>
 <ZkzehjK1AQ2tcPpw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ahlkTfzhtMbSYDcP"
Content-Disposition: inline
In-Reply-To: <ZkzehjK1AQ2tcPpw@smile.fi.intel.com>
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


--ahlkTfzhtMbSYDcP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 08:48:54PM +0300, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 10:45:41AM -0600, Tom Rini wrote:
> > On Tue, May 21, 2024 at 07:35:55PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 21, 2024 at 10:21:45AM -0600, Tom Rini wrote:
> > > > On Tue, May 21, 2024 at 07:12:09PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, May 21, 2024 at 08:59:17PM +0530, Kumar, Udit wrote:
> > > > > > On 5/21/2024 7:59 PM, Andy Shevchenko wrote:
> > > > > > > On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrote:
>=20
> ...
>=20
> > > > > > > Are you Cc'ing random people with this?
> > > > > > > Please don't do it.
> > > > > >=20
> > > > > > I used names names popped up while running get_maintainer.pl sc=
ript of
> > > > > > u-boot
> > > > > >=20
> > > > > > your email id was there for patch-3 of this series
> > > > >=20
> > > > > Nice, the tool is broken. Please, work with the respective people=
 to fix a tool
> > > > > or to tune it to avoid such mistakes in the future.
> > > > >=20
> > > > > (Hint: I would first disable Git fallback completely)
> > > >=20
> > > > So you were cc'd thanks to:
> > > > commit 5e541a05f70296dbad07fc1f4e8678ad207bb476
> > > > Author: Simon Glass <sjg@chromium.org>
> > > > Date:   Sun Jul 30 21:01:45 2023 -0600
> > > >=20
> > > >     env: Use include/env for text-environment includes
> > > >    =20
> > > >     The 'environment' word is too long. We mostly use 'env' in U-Bo=
ot, so use
> > > >     that as the name of the include directory too.
> > > >    =20
> > > >     Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
> # Intel Edison
> > >=20
> > > Yeah, and it even explicitly stated what I reviewed from that code...
> > >=20
> > > >     Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > >=20
> > > > And, I'm sorry because there are other contributors who get upset w=
hen git
> > > > fallback doesn't find them (because it also ages out after a year).
> > > > In this case there's not even a "tweak the threshold" option since
> > > > there's only a single commit to the file so you're in 100% of them.
> > >=20
> > > Just an example of false positive by get_maintainer.pl :-(
> > > And a confirmation of what I said =E2=80=94 tool is broken.
> >=20
> > It's an imperfect tool, yes. A quick check shows that if you never want
> > to be cc'd from a git tag, you can add yourself to
> > .get_maintainer.ignore and you will still be matched for things you have
> > an explicit MAINTAINER entry for.
>=20
> But this will kill me being a maintainer of U-Boot parts (regarding to
> a certain platform) which is not what I want.

With a quick local test, no, it still reported you for edison stuff
since that's not where the ignore list comes in.

--=20
Tom

--ahlkTfzhtMbSYDcP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZM328ACgkQFHw5/5Y0
tyykCQv9GQyinf7PV7bzP7uytVHaB9YPMRLSJnQacTeJQ8cCPjau1h9T/bR+Xfii
l3DEjqEwANilpHVknsBZgyo0ALQyF1DU9a2Lx7+ZZ3m7zobfYmOjqUae3tEDs3BL
r075GTmRKJYMGSn/I51HvtiRHPrbNQxjJLKOJZ6OccUFp2DbYUMYqOF9yT3iQ+Ua
fgQ1oj9YXJtoyKRwsU89ezGWlVDf4pRqEF/CL2rRAc/AoQs29FfsN8qJU5e+o2x0
ajC3+w2yvqNvk5k3HaX3UT0ZvnSUdnfx9joHm52+zNrHxVp1EwaB2Amk/mcBruFs
COCXT6W7w1sp5awvDBx5I5atlZ/97GW0KxbgcOoq6SfcUnaVQaNDfpC5IK2Cqy+f
YxPphG1GePx1YR6y/t4UJvVCmnHUnh07l2L6nB26qh++0Drxve0FRtyBQyMHlznH
uFujm5Y8HIE1VFPD4LpOBphgIdu1t0dCLREs8dQ2bxaLGkLXPl70h1NmxD6CCsYf
v6v47KdT
=ed6J
-----END PGP SIGNATURE-----

--ahlkTfzhtMbSYDcP--
