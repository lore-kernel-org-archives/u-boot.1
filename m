Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8980AC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 18:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0AB6806FC;
	Thu, 20 Mar 2025 19:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fYnvqy0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1078070C; Thu, 20 Mar 2025 19:28:37 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26037803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 19:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223594b3c6dso26931415ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742495313; x=1743100113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6A64ZgXRxi6RFHgm4Q8CFWABzQHDar9p4YYer90wgPc=;
 b=fYnvqy0goktD+C2bN3EXMpe4Ecc2cqUEJnYQJIsJIgmO77xML+YUFENkl5seyQWWwK
 AGyg52RX3lKheUj1V+WDkxTZn3L8C4N/X+Ep9z6Ushm+f8M39NL++fwz28NXxFq3D31C
 8DASlaXhTYmydoC8nMcah+sOgVI4+N3BRLulg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742495313; x=1743100113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6A64ZgXRxi6RFHgm4Q8CFWABzQHDar9p4YYer90wgPc=;
 b=qZfg18qxd9HAdKhZ0d8cdcbx0Mh753htX2Y7UzQ+VkyKOOT/jCkkqOQaJcEzwycb4t
 3rmTYkQ8twHW0maiQibeYjtUFwwTU0IEfUfEytYcsW7bzq9a5bOiSNImoWb0b6V+2Zlq
 wmBfhNhO6jYDtpPcw0rL8MKhLdvxTsStLp+LElU7D54UYO6rOZjRJB4j0hlkuhnGEB4U
 qsNexX5Zrsl2OO1uj+VwqAhUWAQDfS/NB0Q4Bo3InfjP2Q9FO/2Q+JVdWTSXv3d07YJo
 Bf+1sgTJ4zNBlPN1kOua0oUn+qbBnRpGW1UzUzVqV7kpPGveD3vFhakyQzN/Cky1HH9H
 5+vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQhhP5TT7N7YeGw8LlPSIAdReNgCFYZyA+msQCJ7qedBbNobRX9vpYJIz5NunU4sxyzJa7cFA=@lists.denx.de
X-Gm-Message-State: AOJu0YxDS5JV1HMg5gUlSjrpfe1u6e4CIwVFyPcK91a4jNJsHf+OVxd4
 tbhmL9xuY3nlQDfeeuwe4GZLotmH172ZemrUY8lcFuKIjX9soh01hsx0GUDkH2c=
X-Gm-Gg: ASbGncsM7Gi1nSgm7v8Ie5zLqD89CjAfy4vLax+9d3ywrZMlgXopRR6JdIUkLcgh5z/
 kxud3Q3acD6WY0sxD9sS2hss4Jnof72nYgVea+pGJtwIXMmrXP1+lKObTpLqfUHdCCMmm8tfMs5
 faZh/tkal29RSOJ44lSwopNUIZN16o2GhHIFR9XhVxNl83cugs5LF2erdpahV1TM56bSRUrKCsb
 4kw/E28t8V3lSQA+Pq/HVEX7xedWGuO3IJ0Wgo+hyxQ8DLc0SWC1Bqy3MXhVaJhtY34nbDdi5lY
 TZ38Dult7bUVohbp/dAG7JcWzFJklleu+WJKCuP0FYPybQ==
X-Google-Smtp-Source: AGHT+IH4vW09UQ0vJOtAdimjGTKZpDDD/kazLG6PCnsI4DpIVFDkJOmCWOo2yg/7adPb4XqB1+Q+Bw==
X-Received: by 2002:a17:903:41c6:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-22780c7ab87mr5157505ad.13.1742495313475; 
 Thu, 20 Mar 2025 11:28:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f651asm1019365ad.209.2025.03.20.11.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 11:28:32 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:28:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Benedikt Spranger <b.spranger@linutronix.de>,
 Simon Glass <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
Message-ID: <20250320182829.GS2640854@bill-the-cat>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <513b3e03-72d6-4997-8fb7-ca5d8a530097@denx.de>
 <20250320141837.GP2640854@bill-the-cat>
 <b43b5a7016ed4fa08e934c294457b424@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BXsfml5jjkpzZj/T"
Content-Disposition: inline
In-Reply-To: <b43b5a7016ed4fa08e934c294457b424@dh-electronics.com>
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


--BXsfml5jjkpzZj/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 05:58:56PM +0000, Christoph Niedermaier wrote:
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, March 20, 2025 3:19 PM
> > On Thu, Mar 20, 2025 at 03:14:03PM +0100, Marek Vasut wrote:
> > > On 3/20/25 3:00 PM, Quentin Schulz wrote:
> > > > Hi Marek,
> > > >
> > > > On 3/20/25 12:49 PM, Marek Vasut wrote:
> > > > > On 3/20/25 11:23 AM, Christoph Niedermaier wrote:
> > > > > > If tiny printf is used with 0x%08X (upper case X) the output is
> > > > > > always 0x00000000. It could be confusing if upper case instead
> > > > > > of lower case is used intentionally or accidentally because the
> > > > > > actual value is not output. To avoid this confusion, tiny printf
> > > > > > is extended to support also the formatting with %X.
> > > > > >
> > > > > > Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electroni=
cs.com>
> > > > > TINY_PRINTF is meant to be tiny, i.e. not consume a lot of space,=
 at
> > > > > the expense of functionality. This is meant to be used in size
> > > > > constrained environments, like the SPL. If you need full vsprintf=
()
> > > > > formatting support, disable TINY_PRINTF in your config and use the
> > > > > regular vsprintf() implementation.
> > > >
> > > > The issue is that disabling TINY_PRINTF may not be possible (size
> > > > constraints) and some code is compiled for different stages and peo=
ple
> > > > typically don't check whether the format used in printf is valid wi=
th
> > > > tiny_printf. I've had this issue already in the past, I vaguely rec=
all
> > > > "complaining" about it on IRC.
> > > >
> > > > Maybe there's something we can do to verify that the code is workin=
g how
> > > > we expect it to work, regardless of tiny_printf/full printf selecti=
on?
> > > > checkpatch or a compile-time check for the formats maybe?
> > > >
> > > > But yeah, essentially the whole thing is... if we continue like thi=
s,
> > > > we'll just end up getting closer and closer to the full printf whic=
h is
> > > > not something we want :)
> > > Shall we maybe patch tiny printf to print '?' on unsupported formatti=
ng
> > > characters, or outright complain that users should fix their code ?
> >=20
> > This sounds good to me, adding ? in the output.
> >=20
> > > For the %x/%X thing, we could technically fall back from %X to %x , w=
hich
> > > would do the printing with minimum footprint increase, albeit slightly
> > > malformed:
> >=20
> > There's 109 hits on "%X" and another 489 on "%0.X", so I think it's
> > reasonable to do either of:
> > - Misprint A-F as a-f (in other words, treat it like 'x'
> > - Audit the callers and change them to 'x' from 'X'. We normally don't
> >   capitalize the output and there's all sorts of patches over the years
> >   changing them to lowercase in other places.
> >=20
> > We have done both for other format specifiers and tiny-printf before in
> > the past.
>=20
> If we taking about adding feature, I think that the patch don't really
> add a new feature, it's just a variant of %x. I reuse part of the %x code.
> So if size matters here the size of the object file (not stripped):
>=20
> Before:
> -rw-r--r-- 1 developer developer 19340 Mar 20 15:32 tiny-printf.o
>=20
> After with current patch:
> -rw-r--r-- 1 developer developer 21212 Mar 20 15:38 tiny-printf.o
> =3D> Diff: 1872 Bytes (+9,67%)
>=20
> I have another patch, where I don't introduce two new function and
> don't use an enum. Then it looks like this:
> -rw-r--r-- 1 developer developer 19888 Mar 20 16:53 tiny-printf.o
> =3D> Diff: 548 Bytes (+2,83%)
>=20
> Would this increase in size be OK for %X?
> So there will be no misprint.
>=20
> Otherwise, a misprint for %X would be fine with me, because I still
> get the correct value.

Tiny really does mean tiny in this case so yes, I would prefer the
single digit byte increase of adding 'X' to the 'x' case. Thanks!

--=20
Tom

--BXsfml5jjkpzZj/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfcXkkACgkQFHw5/5Y0
tyzfmwv/WW/DJNDdtGRi3mIBryj/xaVjSHj7qfga7ZzpSHi9xey1QK2OQdqm+TuJ
ZEMJ7OQs4ulwLyRPtD/yb0UVxxzcEeeenM4UzN0HE8hyRMEEcXFgAIW37/4EylRX
MCw7Rbdg2BaByn+PVuWJCkOEHeBbkVowUb7kNVyTnwvCfJRYTbvJZCS6+0I2yrV6
g6jIrKrXlnbVdZ/QW3GLoAtppOmyrliU+d7+W120aoDcZciQpVGn+G6F6qtmersW
HBfrAKp2f13TzJBX81JBjUYpn6ZcIeJPasU0jgSbIhCusDA8ajqHHAih0OwVlLL2
ZqORN3/gTg/MYUlInJe7Y0ZPIVfPf5hrafNWZsiPhBazHUXpkRgFVrIpPiikmAFF
5XPp9ZYmt/CdIDYPR/yWiOeGI9cktVreeYsxWZne9Sj84fepWLoBhaNQzxGKC84c
bGZmx70cFF2rMWBvGkVG1R68cTtVLR6hUsxAWgY/wjJxDJVqdVH6uWC0tXF30mUK
P5Dk/V96
=ztgL
-----END PGP SIGNATURE-----

--BXsfml5jjkpzZj/T--
