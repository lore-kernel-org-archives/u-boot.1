Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB290C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 18:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B75683487;
	Thu, 17 Jul 2025 20:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EG6zCQ16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFDB83496; Thu, 17 Jul 2025 20:05:09 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CA783457
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 20:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2edec6c5511so629614fac.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752775506; x=1753380306; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aaf47/vJgACrMXh6KLVBR9eamFzRMoRZMxV8cdBzyYA=;
 b=EG6zCQ16zJ5H0YwlOobMlHKmko7bunlglyBXF5EWkV16qfqfTp4NKLP69uW2kN/9Hj
 2+V8ZLPDw1gSt+J4X+WfNqKNuh0J1pKhDHxVlDvj8XmO4ilslTE8Vl5qGzUThj99OuMN
 RARTQhAjKwK9Zq4lHn+s7s4Fzuhj3MoOwntco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752775506; x=1753380306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaf47/vJgACrMXh6KLVBR9eamFzRMoRZMxV8cdBzyYA=;
 b=nMPOX14UnW2wC9aWLbnKipODVpbrypCAh0Wnx6d+vePpJjnYI5EipYnQUCw7qEUmFg
 O7BegKQhCxDSZoSTVDT1k0lHaTm9cSBSAJ3XCYv+fCJqhJn0jerqcQRY+gG3rOs+2OWo
 4eTFdVf3aEr7qC54s7IUtOCAX2GHl4unrEJJ3z6/bDizq+bn8/j+ei5G7QhJXsbcZvMv
 SHNcUepaWfBZxuklartbb29RFONSrQZWWTYF6AZNbZSwpSuH44rjtR28yhAiAxsQUqWo
 C1066kcSs6aIyKXTLSSadZhYBliCDe6MhWr5SajB+/wjuAlkCf6EkIU+7AA5Iibbyqe+
 IiIg==
X-Gm-Message-State: AOJu0YyepSCgZodUksi24PH6/esVKGjidzaHNORmiDZSuqtQZKWf4kzP
 fJw00RKTRZNqkFyhEyta5uA9fx47xcgEA0VVAAbr81G+cC0NgWaV8QpIlzcl7meafKU=
X-Gm-Gg: ASbGncteXn0FwmsAAIWupeci6t2S8pH3sHtqQvL/g9PEJ/NoapLwvI2gyJX7TKveik+
 x42NuytO5TgBvQjxJeuXVYkQ1JGoXnYDKQcHOMNolbDLrLJdQQOc/XG5Ik4SHN9P8Gje3OhSStr
 85kWmzBeYYnWbyPBxr9uIt4VbG5mb5FCApGelIFQe8Fm4CLV8+PgVvWjqMm6rVGRaLJY9n0EvBf
 Zn6PWzNB0nUS0Yg6Z9L+daY7rNFxWdckXhZwLmPuXwfYKzjpiZhL+uDHevSpi+0/rziVDqH1oK2
 zR/Dv5mt6bO0ePv6Cg87UabXH3PEwdtNJN/eO3btg44xj+dTvBwByyEtGS3sfAu8mFYbkuVuAXb
 CmgetB1m+aFmL6BBOQQUrZbz2BrhxD6Om0d0zohN4Cjm6yV1L86mkFi8O
X-Google-Smtp-Source: AGHT+IE7SfXuUHisoMAeQAT7+2GHaxDyDEcC4mrLydgeYzSDkAcv0/JELxs9oLGo8lVMlfWZBUkQlQ==
X-Received: by 2002:a05:6870:1098:b0:2ff:b276:97f5 with SMTP id
 586e51a60fabf-2ffb276ada5mr4485582fac.5.1752775505754; 
 Thu, 17 Jul 2025 11:05:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e71344680sm1068881a34.9.2025.07.17.11.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 11:05:04 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:05:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 2/3] clk: clk-cdce9xx.c: Change from u32 to ulong for
 addresses
Message-ID: <20250717180502.GP193579@bill-the-cat>
References: <20250702010535.19250-1-trini@konsulko.com>
 <20250702010535.19250-2-trini@konsulko.com>
 <f3ff27e4-106b-411d-89f0-82e7e78fff77@cherry.de>
 <20250717150827.GN193579@bill-the-cat>
 <3eb8df7f-632f-464b-bf44-b05678bd22e2@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AiUz4Eb8taQxaQys"
Content-Disposition: inline
In-Reply-To: <3eb8df7f-632f-464b-bf44-b05678bd22e2@cherry.de>
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


--AiUz4Eb8taQxaQys
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 05:19:39PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 7/17/25 5:08 PM, Tom Rini wrote:
> > On Mon, Jul 14, 2025 at 12:35:14PM +0200, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 7/2/25 3:05 AM, Tom Rini wrote:
> > > > For 32/64bit correctness, we need to use ulong and not u32 for cast=
ing
> > > > for addresses.
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Lukasz Majewski <lukma@denx.de>
> > > > Cc: Sean Anderson <seanga2@gmail.com>
> > > > ---
> > > >    drivers/clk/clk-cdce9xx.c | 10 +++++-----
> > > >    1 file changed, 5 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
> > > > index e5f74e714d54..afb997c06be5 100644
> > > > --- a/drivers/clk/clk-cdce9xx.c
> > > > +++ b/drivers/clk/clk-cdce9xx.c
> > > > @@ -103,7 +103,7 @@ static int cdce9xx_clk_probe(struct udevice *de=
v)
> > > >    	u32 val;
> > > >    	struct clk clk;
> > > > -	val =3D (u32)dev_read_addr_ptr(dev);
> > > > +	val =3D (ulong)dev_read_addr_ptr(dev);
> > >=20
> > > The output would be stored in a u32 anyway so not sure this actually =
helps
> > > (see type of val in the git context above).
> >=20
> > Yeah. It's funny. The other example of a driver doing these games is
> > drivers/clk/clk_versaclock.c which uses u64 since it's a 64bit system I
> > believe.
> >=20
> > > >    	ret =3D i2c_get_chip(dev->parent, val, 1, &data->i2c);
> > > >    	if (ret) {
> > > > @@ -226,10 +226,10 @@ static ulong cdce9xx_clk_set_rate(struct clk =
*clk, ulong rate)
> > > >    }
> > > >    static const struct udevice_id cdce9xx_clk_of_match[] =3D {
> > > > -	{ .compatible =3D "ti,cdce913", .data =3D (u32)&cdce913_chip_info=
 },
> > > > -	{ .compatible =3D "ti,cdce925", .data =3D (u32)&cdce925_chip_info=
 },
> > > > -	{ .compatible =3D "ti,cdce937", .data =3D (u32)&cdce937_chip_info=
 },
> > > > -	{ .compatible =3D "ti,cdce949", .data =3D (u32)&cdce949_chip_info=
 },
> > > > +	{ .compatible =3D "ti,cdce913", .data =3D (ulong)&cdce913_chip_in=
fo },
> > > > +	{ .compatible =3D "ti,cdce925", .data =3D (ulong)&cdce925_chip_in=
fo },
> > > > +	{ .compatible =3D "ti,cdce937", .data =3D (ulong)&cdce937_chip_in=
fo },
> > > > +	{ .compatible =3D "ti,cdce949", .data =3D (ulong)&cdce949_chip_in=
fo },
> > >=20
> > > Just get rid of the cast I guess? udevice_id.data being a ulong alrea=
dy the
> > > compiler should perform the cast in any case and this improves readab=
ility?
> >=20
> > Without some cast we get:
> > error: initialization of =E2=80=98long unsigned int=E2=80=99 from =E2=
=80=98const struct
> > cdce9xx_chip_info *=E2=80=99 makes integer from pointer without a cast
> > [-Werror=3Dint-conversion]
> >=20
>=20
> My apologies for the mislead.
>=20
> It seems like places where it's not needed are where the member is of type
> void*. The kernel uses this type for of_device_id struct which I'm the mo=
st
> familiar with, but U-Boot's udevice_id actually uses a ulong instead, whi=
ch
> thus requires the cast I guess.
>=20
> > That said, I'm just going to drop this patch and make the driver depend
> > on ARCH_OMAP2PLUS. My gut feeling is this is another one of the cases
> > where we run in to problems because we don't use phys_addr_t for
> > physical addresses consistently.
> >=20
>=20
> Considering it could be anything, should the type be void* like in the
> kernel for udevice_id.data maybe? Up to the driver to perform the proper
> cast when accessing/dereferencing it?

Off-hand, I don't know. That's the kind of thing that perhaps someone
will take an interest in looking at and thinking on now that as a
community we're spending some more time cleaning up code.

--=20
Tom

--AiUz4Eb8taQxaQys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5O0oACgkQFHw5/5Y0
tyzjDAv/Zlyr59+kO9dDliLPkq6MieJZHbLLstOb/dNZQ6PiANQLMFt6axCdvP6j
eyynPNufkjUQhDo32oFVIBmHvUHrw6WI/n7ddA0zRYmRZvWps2jbdHNfX2YXygHz
Q+tWWGJN7Gk9QBCrdknbbg84zWtfT7QBltdW/6uOt9PYCnZxniwMIX76qkOf1Yu9
j1bh+2IjDTiMZVD3gFKs4Lszvtca/ff9KM68udpbLGBMj4uHHS6cEF0mryBKuHfs
LSDCuCoNd4r94hsHp3yef4shJNAIOsojRgTf+1rwGXPDrj0k5aOASpW48I9h5LII
my0F6wqlrMJj2iePHO385Ar8AFTUYxHuE91ckLeJbBqJZRKCFcMqZKRw14FrWdUK
57ddMA+Ebb11Co3WZPWWPszTmvyBNQWLMp95olvpxJbiPfQVH9rO64XhayZj208n
T9SI2QIfPErgtFUKrJT+Y2HS71Z0c8Oxukzmza93+T32xuCDS0VpO8ScQXAgNBpd
rTY9Fgvk
=Yfcg
-----END PGP SIGNATURE-----

--AiUz4Eb8taQxaQys--
