Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19F0CA0FFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 14:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1823788C09;
	Fri, 30 Aug 2024 16:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AIDPEdDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F24688C19; Fri, 30 Aug 2024 16:26:28 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E32F888FD
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 16:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6bf9ac165d3so10770496d6.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725027985; x=1725632785; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rjktAWL8KxDeat/IhCxeKMjxmcu+Io8VbnBdLemA8/c=;
 b=AIDPEdDmtMyVXzLjUfoOSqy5lgoeneolzWouUSrcqJV9ChsADwVJW7s9IfZ+TIYCqD
 yYt2SSkAN1iUK6vo9mXHLm8u80ExSCflYf+rVzKlwDsn0eZ8YemmHaXWN8IcboxeXzyo
 xFUyq1ymmCwMFZDeldkCuHsPDPgotBT9MsvxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725027985; x=1725632785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjktAWL8KxDeat/IhCxeKMjxmcu+Io8VbnBdLemA8/c=;
 b=i94r/GNSGq5+jE3g4lmh1FH8TB3DP/GHBzyulJHT03ydzJS0OTzt/0oo+xo4w3AN64
 81s3JUL65LZqPBzwKqJdmAAkAeccH3ztgBfUy8WXFPyCVCszQBVRax8qfYZVGrqAAlKG
 qRummxTN22SYoGZFYn4ScJRTkgIn7MdJVKmdXYXipZlENlVROh2f7aq0K/9U63sCN6O1
 e2Pj+3VGJ5E6X09wNp9+U6wLH7yOSe1gcKcRHygp3BY0xf8mG+5W3JIzt9xfUgjN6fJA
 csEdHzf5FT+HrHz1NoZF1slSrsb6NAFu8rc6DnwTWQfktXvQrrGurnc19ynHF4YJc7my
 660Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtsuU0jNeuxfBroMtWkorr3Rh6B0TM5FDOwh8+/JFP6mjdZwrybK6p0xi4W0niWsp27c+2+ek=@lists.denx.de
X-Gm-Message-State: AOJu0YwSxwtRswXwp7h1AwJdpCr1jphtjyHr3PvWSflDgpBwWd6FeZX5
 B1f13p6cX4HmkMe2vrn/0a2GY2OoDHjJdsvVzu6tc5Tmj4WxuHnCrskMbtCTTxM=
X-Google-Smtp-Source: AGHT+IHi2smst7Py6z0bxcHlUQpe60u4ZfMd8x2dksJaOiomgEHg8C7fqe04j6xzUb9rx0Dj5+1x5A==
X-Received: by 2002:a05:6214:5c07:b0:6c3:2a81:44de with SMTP id
 6a1803df08f44-6c33e626fdemr68895436d6.32.1725027984680; 
 Fri, 30 Aug 2024 07:26:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c34995321dsm6371656d6.111.2024.08.30.07.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:26:23 -0700 (PDT)
Date: Fri, 30 Aug 2024 08:26:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
Message-ID: <20240830142620.GS2479150@bill-the-cat>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
 <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
 <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
 <20240829165906.GG2479150@bill-the-cat>
 <CAFLszTh4A2NH8d6hocom3pAzYB4ExgVbDRa+6phux7K5P9X4Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e+J803lVMra+L6wG"
Content-Disposition: inline
In-Reply-To: <CAFLszTh4A2NH8d6hocom3pAzYB4ExgVbDRa+6phux7K5P9X4Pg@mail.gmail.com>
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


--e+J803lVMra+L6wG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 07:04:36PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 29 Aug 2024 at 10:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 09:01:17AM -0600, Simon Glass wrote:
> > > Hi Neil,
> > >
> > > On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wrote:
> > > >
> > > > On 29/08/2024 00:08, Simon Glass wrote:
> > > > > Send the Labgrid quit characters to ask it to exit gracefully. Th=
is
> > > > > typically allows it to power off the board being used.
> > > >
> > > > Sending those characters every time could collide with other CI sys=
tems,
> > > > I don't think it's a good idea.
> > >
> > > What systems are you thinking about and what sort of collision would =
occur?
> > >
> > > What do you suggest instead?
> >
> > Why do we need this at all? Did I miss where we send picocom the
> > disconnect nicely key-combination?
>=20
> When labgrid gets a signal, it exits. It doesn't continue its
> co-routines and execute the end strategy to power things off, etc. I
> suspect it could be made to do that, but I already have 62 Labgrid
> patches, so I thought this would be expedient...
>=20
> I can make this conditional on the new USE_LABGRID variable.

It sounds to me like we need to make generic improvements to our hooks
then, if there's not a "now call poweroff" hook.

--=20
Tom

--e+J803lVMra+L6wG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbR1okACgkQFHw5/5Y0
tywmagv/fcZYERvtgowPNWadV7PCMVVYFIjffGADYMjmQ+dFOUTtmdOf2amgMHul
lQ+8oeMzr7macFn/PEl6rGevp22gbkt0lsPYAMN9olxHIZRgc2pPAxO9veYjKmkw
xOa4nOJ2c04n19Qg70yTR/TV+cg8xCwo+NR278ICJsbowKUQ7wmd8l5iADHtoUbM
xuFbIXbb3IZPH3Ormpt/skZa1zaBKPNwP5Lf+lGQPkrvvT2OBMK8/hlvAy4vg0rb
pgPu/sOA4/dSVCxImv8P9BcnZblUGw5dpUdd3yYTkbPvTSjBHHh7i1AqHHlLOX8x
zD4EfLZmBxqYg8MZYXbvxXWcyG7A3i7vXLR2lFRWjcaGC421XGWBHcQdb2985NcR
2i6O30gloF78nt5atZHZRrEX+bydRxzQ7eRwjj7ctU/5oZh/cXE//nM2zVJE+R61
xqvePtKO9UlZe2NE+s7dmdKuHVeOUWR8LEGoPWUgU7jJiSyiwtYxXp4KH/05fZBj
8djXYup4
=frCD
-----END PGP SIGNATURE-----

--e+J803lVMra+L6wG--
