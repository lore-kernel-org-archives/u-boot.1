Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4B8C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D9D881C1;
	Tue, 21 May 2024 18:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qlpfoBYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3442888335; Tue, 21 May 2024 18:45:49 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F365A87FA7
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-792b94301eeso34650685a.3
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716309946; x=1716914746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hnn7tZxP3HKBmPBo9F18RfFyisZQt/9/LWH82SDzrMQ=;
 b=qlpfoBYGu0vehYNpIHmbB8DGIjz4EUf6UoJmIusQETRbLxgh1+ouTng1ar/HfW8XYP
 AlUrIx1LYGyjZMvQz0DxavTvX4ZPPDJZaJ4oGBCuRoOvyv3TLolb9PVSshuEdKQvpo2b
 RF4z8nTa0rCU02xAbTc9Kxkr6YQm1kxSYi8jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716309946; x=1716914746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hnn7tZxP3HKBmPBo9F18RfFyisZQt/9/LWH82SDzrMQ=;
 b=dAJULpjhucyIIq6WeflI6i19QLDBDZGyXF7V62ifD5WfrvS2nMhrjV2K2iYer7Rcil
 TqsrLWYiC35emYReYirKqGIEGfDrgcv6Iw60hZaCUn24gOapu/GCCCVktAlX7tzvVWIP
 hN2X64coL75sBFVCOKu1Sl+VyG5ZK2cm0n0TLo9XDzwcc5FieAvsW3/Gn3LTw+KpQzGj
 t8Hy6MvPHtABxKkqgwP6xwAzsVrWwd4u+b2/C3lv4B8POS5HwB+LySfSut6zK7WBhlHM
 MyCgr67Es6ajrSSCz1H6NMbK/HPgstSi0Jmo1JTdM3SMwiXfcdpgTDl135RG9M5cQPw4
 PVXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjZ4Xt+7P7TMiRQWIpVt9Bgfd+E7TsqnlfC4zGEA6gwwBD98j049B71Vc55gdDFMjD/WBtkvB1QyqtMiKjw19dV3HOQw==
X-Gm-Message-State: AOJu0Yw8hjUzwd8nQr93YV8aIr5nV7JUDxRIwgFGDU/YCOiIO5HHy4PE
 GocmCHtow3+s9sxpwMyfSif8qRosouygM7FQyI2dWkJzyvzznjNNaZ+0Pxc4doU=
X-Google-Smtp-Source: AGHT+IFlZmiNeYrE4H6kb0CiI0e+1eAPrbaiDedAqboTerrmWxpLhevlcLHhlOKKNvfBapWQwbkfXw==
X-Received: by 2002:a05:620a:45a3:b0:790:ef5d:25ae with SMTP id
 af79cd13be357-792c75f4541mr4765454685a.56.1716309945663; 
 Tue, 21 May 2024 09:45:45 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fc609sm1301342585a.94.2024.05.21.09.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:45:45 -0700 (PDT)
Date: Tue, 21 May 2024 10:45:41 -0600
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
Message-ID: <20240521164541.GY2568172@bill-the-cat>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
 <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
 <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
 <ZkzH2Sa4eGAxb2EB@smile.fi.intel.com>
 <20240521162145.GT2568172@bill-the-cat>
 <ZkzNa9TnTIixVnfJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BoQ0OvCEalUS0k9l"
Content-Disposition: inline
In-Reply-To: <ZkzNa9TnTIixVnfJ@smile.fi.intel.com>
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


--BoQ0OvCEalUS0k9l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 07:35:55PM +0300, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 10:21:45AM -0600, Tom Rini wrote:
> > On Tue, May 21, 2024 at 07:12:09PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 21, 2024 at 08:59:17PM +0530, Kumar, Udit wrote:
> > > > On 5/21/2024 7:59 PM, Andy Shevchenko wrote:
> > > > > On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrote:
>=20
> ...
>=20
> > > > > Are you Cc'ing random people with this?
> > > > > Please don't do it.
> > > >=20
> > > > I used names names popped up while running get_maintainer.pl script=
 of
> > > > u-boot
> > > >=20
> > > > your email id was there for patch-3 of this series
> > >=20
> > > Nice, the tool is broken. Please, work with the respective people to =
fix a tool
> > > or to tune it to avoid such mistakes in the future.
> > >=20
> > > (Hint: I would first disable Git fallback completely)
> >=20
> > So you were cc'd thanks to:
> > commit 5e541a05f70296dbad07fc1f4e8678ad207bb476
> > Author: Simon Glass <sjg@chromium.org>
> > Date:   Sun Jul 30 21:01:45 2023 -0600
> >=20
> >     env: Use include/env for text-environment includes
> >    =20
> >     The 'environment' word is too long. We mostly use 'env' in U-Boot, =
so use
> >     that as the name of the include directory too.
> >    =20
> >     Signed-off-by: Simon Glass <sjg@chromium.org>
> >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # =
Intel Edison
>=20
> Yeah, and it even explicitly stated what I reviewed from that code...
>=20
> >     Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> >=20
> > And, I'm sorry because there are other contributors who get upset when =
git
> > fallback doesn't find them (because it also ages out after a year).
> > In this case there's not even a "tweak the threshold" option since
> > there's only a single commit to the file so you're in 100% of them.
>=20
> Just an example of false positive by get_maintainer.pl :-(
> And a confirmation of what I said =E2=80=94 tool is broken.

It's an imperfect tool, yes. A quick check shows that if you never want
to be cc'd from a git tag, you can add yourself to
=2Eget_maintainer.ignore and you will still be matched for things you have
an explicit MAINTAINER entry for.

--=20
Tom

--BoQ0OvCEalUS0k9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZMz7UACgkQFHw5/5Y0
tyy4qAv/WV2pF89HAdXirzuCjw9i8McepQEinj9muyqZCMcL38IdrPAD/2NUlNDu
BDdXChYBI7oB48Vkg2BthK9hJQe2VwH5zV741kMbIrr0paXcJCXsKLZhWfQZ6Ta2
eGlkOLnFATfqKDdLXEfDAqA740Ogj5/mf9EFi0v8XSSJZS5cAAlmj7I7jDkOeoq8
wE4ceH/4vradtAuKL/6QJs/qtBsP8ToereqUDG6Ciq419fsGOXuXjfBm+SLVteRC
SkpZJtTXD+3YXnxly6R+k7DzQn412b7QoGCSst6XJTvrXES22lqpYZrSooPxugPS
1PqbApR9PTYgXYRrIrChM1GxJT97Pr14jLyHhUUhgp37XktrHYRcQZgrDm3coxNX
cSOz+SgYl9gUjsaKUnP2WQ/6NpMgWnpVhJO4cbF6y95r4E7O86VDA+I2cTbmbfXW
aUlSy1xacYEUmxUWIZMDGhQSqIzC0V17yR4trzp6WPsLw9hJ4IGeKBRZqhqgqDyS
4GVPE6gX
=hreI
-----END PGP SIGNATURE-----

--BoQ0OvCEalUS0k9l--
