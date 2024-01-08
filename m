Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69956C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9DC87A4B;
	Mon,  8 Jan 2024 18:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sDQSpiv0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711F987A4B; Mon,  8 Jan 2024 18:00:19 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983CD87A34
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-67ff241c2bcso17632956d6.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 09:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704733215; x=1705338015; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4rr0Pc9YC/74Jc3oMoJ3THvFVLUjfzz8rrYpROBoErI=;
 b=sDQSpiv036xuoR0msBmCBFzYXWBi+WxItMC4fwACT3jjZsKx+Fnl1GHL6cZ5A9eDy/
 +ADRm2GtO3XI4tE/77dCs3whtYNnYz2b/oZUeQU0hcBcKej2IK8mh247pCjYC4P5TmZh
 tVUIxWXmzA6iIs5QxqH8LbRAxVUFDxP0OJyXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704733215; x=1705338015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rr0Pc9YC/74Jc3oMoJ3THvFVLUjfzz8rrYpROBoErI=;
 b=vIOTlCYBQAKW5Y71W8+jC0XVeGc6lqFO4A0OdcNA/Ztdpsm8dSj+UoiML3XPMlZ65a
 qGzXpPbqBCLd6zjxQtd/IM4Ut8zwFFUZPdBP5er+rzyFO4gBgpzQtMA8R16vCtbmaI/r
 tHclKYLJhRdB2N8+Ln+8gjT7BjucTsOBD5HLWrwn9V4RWzaVO3AcQtPbN41xNfhIsyx0
 uk+gVcb07Q1LpRjieoSbHmt6XUV84GGMcgYp7itYUZ9SMrXVdnFFClbDGEDdu+D8iK5z
 /jTrzypjeIgFyQufBUGAuDTNkTMKygdkuhDyiWRHMPC69igD8N5jt6PHwFJacoBhuR4o
 yhww==
X-Gm-Message-State: AOJu0Yx1wCVUtFWf0W8WKTt5j8i6nX+g26BzPZcCPmQBCUvf0+9ErMJ8
 jBdDuIPRK2DrHx2qa9uBUOcm1AzrY2sDYg==
X-Google-Smtp-Source: AGHT+IHlx0OhXHd+pAGwutsjKegZmdOZUUoZxxBn+d5M2YcMIVpp30gxuGiAW1i0JaO9vQIwFZ/hog==
X-Received: by 2002:a05:6214:e41:b0:67a:9b29:c70c with SMTP id
 o1-20020a0562140e4100b0067a9b29c70cmr5539940qvc.39.1704733215307; 
 Mon, 08 Jan 2024 09:00:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 n5-20020a056214008500b0067f4507b64dsm116466qvr.63.2024.01.08.09.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 09:00:14 -0800 (PST)
Date: Mon, 8 Jan 2024 12:00:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm/next
Message-ID: <20240108170012.GG1610741@bill-the-cat>
References: <CAFLszThp=VqYAR7FB0i4Ni3yd9wJvD63_QP7_pb2+2fRhXxBAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DoBNF79Movemdksi"
Content-Disposition: inline
In-Reply-To: <CAFLszThp=VqYAR7FB0i4Ni3yd9wJvD63_QP7_pb2+2fRhXxBAg@mail.gmail.com>
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


--DoBNF79Movemdksi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 05:21:57PM -0700, Simon Glass wrote:

> Hi Tom,
>=20
> This is for -next
>=20
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/19216
>=20
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D58&view=
=3Dresults
>=20
>=20
> The following changes since commit c2c598e87cfe56f5991730762c00733c5aa9a9=
94:
>=20
>   Merge branch 'staging' of
> https://source.denx.de/u-boot/custodians/u-boot-tegra into next
> (2024-01-06 09:57:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-next-7jan23
>=20
> for you to fetch changes up to 8c4b37ce97c27ad4e7f83b028d4cd1396a51a36f:
>=20
>   arm: enable support for QEMU firmware tables (2024-01-07 13:49:15 -0700)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--DoBNF79Movemdksi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcKhoACgkQFHw5/5Y0
tyxbLwv/SREF/uZvjYggeSgUw9EwrFKVrXX6iX8jc7F7kbysWamFDFQW2EABo3Yw
O9Jtuw1p5fZQ7QymvZdhTvH6UYKRTb7QgRB0e6X+iWh5fm3Q9xPScbtKgJE9w6eU
sghMcN3r6pUANDpmO2x6ChUHdkKlZGUKQYQf0YVV1x9dg9ysrLN5VZu4+Il/NW1e
ZhFrBnsJjp3Hu8p1WS/1hgTQBRJpsUUCswUBOgucByRE85rdTGbj1o6Cji9zrYAB
bLyzBAI3AfewZWPc7xxxSOa+cgOK/cdtO0w5fHuVk8tdKY2BWVdb2An1962+mmPc
RF7HT/4/Wb7b/cEi5Xq/m4aQ+5HWMD8mzxdfGzqyKt5jiTUB3k37VXoqvPf51nYt
VVwAW7Qor5W5SxR+9c2OpQOm9g7ZvIUhzI7zCG0BoJIpBuTnVkm//AXwrGjeO9fP
DRQ0EkSZHxlzbeUSD54OtE7zvbeISsoVFIuoJyjbAqU4jH0qZ6Ja85Db+R347+rl
vnGESFvw
=Rwos
-----END PGP SIGNATURE-----

--DoBNF79Movemdksi--
