Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F08C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 19:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2613987469;
	Wed, 20 Dec 2023 20:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jFn2I5hB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1441C87469; Wed, 20 Dec 2023 20:12:11 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A7498781A
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 20:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5cd81e76164so437647b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703099527; x=1703704327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5/y+CtXgur4F1KM4txBk8JPziB7vRQnEC9KR3DnLE5I=;
 b=jFn2I5hBX1R96TkusNmerBQ8Ij9YrD/ahPkqGK7HhHpNGXrlYe7i+tuTPm4AU4hcZS
 +eZ9a3m8ThuarsjSL2eqhTzf5nLtSKgZRYw/ZTekUhqQiqDewCqNy6LXDoDWYQndtcJm
 G++pi9DsQaoX9uCjwOH7UHLCqOWP2Tt1etgyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703099527; x=1703704327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/y+CtXgur4F1KM4txBk8JPziB7vRQnEC9KR3DnLE5I=;
 b=e1cjj88VE0QulWy0swTAB2t7YOdBTqq9YtU3TSJCGbYksfsO16wCiGEWs+fTBqvK2r
 D+kCNKIGeELsxfIUgJCzppk/n/OMa1S7mysLCm3v7saXduqvPr6DvreWCpSCdvLF99Rg
 tVyDG0M6krCJD5dHzGZ2ahZaMQfY05pzZBpGFx+cKO/P0my29CyijbvGPEfwkdMVbKcY
 TSzJxoNKyb8IdwDAU+6VyTOuS/kGelc53mziblKm2nv5MZsKEbAwcuaI5XMDU8cmiZA9
 mMxOBABwrSKfJ0tBkH7tlqVcu7D8+m2gC7ZEEBkFZ84Vu9u66Thor5ZRXXdLpMFxoEVZ
 LroA==
X-Gm-Message-State: AOJu0Ywu4eFTbQZlchDxNUQ2nSXjp7Kd/SDQdrXlJMW6UHbmaEDEzjb9
 Ll8FU1HM5wAc9ZWUXq2ZnS1x+A==
X-Google-Smtp-Source: AGHT+IGZbj4i/ZI08V198U8MqKPXLntn93NUjke2e86QJhNgIXq9yzSQwj/46qU7trnzpEaj0hIgRQ==
X-Received: by 2002:a0d:cc8d:0:b0:5de:7455:1a06 with SMTP id
 o135-20020a0dcc8d000000b005de74551a06mr219024ywd.21.1703099527230; 
 Wed, 20 Dec 2023 11:12:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 z125-20020a816583000000b005e8fc1e90e8sm145504ywb.111.2023.12.20.11.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 11:12:06 -0800 (PST)
Date: Wed, 20 Dec 2023 14:12:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH v2] test/py: i2c: Add tests for i2c command
Message-ID: <20231220191204.GN2513409@bill-the-cat>
References: <0d8e994ea619d3942ee215a8f5635627e89c3512.1700567875.git.love.kumar@amd.com>
 <20231220154637.GA4032343@bill-the-cat>
 <aaa35987-ba52-4db6-aaf6-8fd6f46e4310@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+Vr7AZMhw/tfuG5H"
Content-Disposition: inline
In-Reply-To: <aaa35987-ba52-4db6-aaf6-8fd6f46e4310@amd.com>
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


--+Vr7AZMhw/tfuG5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 05:45:24PM +0100, Michal Simek wrote:
>=20
>=20
> On 12/20/23 16:46, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 05:28:43PM +0530, Love Kumar wrote:
> >=20
> > > Add below test cases for i2c commands:
> > > i2c_bus - To show i2c bus info,
> > > i2c_dev - To set or show the current bus,
> > > i2c_probe - To probe the i2c device,
> > > i2c_eeprom - To test i2c eeprom device,
> > > i2c_probe_all_buses - To list down all the buses and probes it
> > >=20
> > > Signed-off-by: Love Kumar <love.kumar@amd.com>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Changes in v2:
> > > - Take the configured eeprom value from env to read back and compare
> > > ---
> > >   test/py/tests/test_i2c.py | 108 +++++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 108 insertions(+)
> > >   create mode 100644 test/py/tests/test_i2c.py
> >=20
> > So this leads to failures in CI on other platforms.  Please put this and
> > the other tests through CI:
> > https://docs.u-boot.org/en/latest/develop/ci_testing.html
>=20
> Can you give me link to that gitlab build to see it?
> I can push it via my tree but it will be just resource wasting to see err=
ors
> which you have seen already.

The first failure is
https://source.denx.de/u-boot/u-boot/-/jobs/758375#L268 but I suspect
that like the mii or mdio (I forget which now) test, they end up needing
to be opt-in, but should also have their comments expanded to make sure
it's clear what expected values to configure the test are.

--=20
Tom

--+Vr7AZMhw/tfuG5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDPIEACgkQFHw5/5Y0
tyzTvQv/YmrCUuo5hEFsACooQgUk5/I3eKY+roxcNmFLpq8sPqCEc953sbFWvRMp
cCQOYVLun0zC3UAVkAx/r3vMYGfXhdyNOoBZ192chFNJbJDHDhjFCV8e/Jxh3kZj
XYZQbEsa9WTRirvXeSKG9xhrvRKQn+dZ4nvrLj0tpjixsJeXCdnLFR96RwYpAmdk
sepGvL6CrsD17eFuw83ysceCM/QeQ/IxlhJNwqXw3UUxrbf0B6UC0xYsWy/UVRRr
3L8OqggG181FzoLJu9krADD6xIDcmlbmKRRi7Qv8IwfsFfMQjfT3npF1SQ2BJ+KE
5zUFjpesPM0lTMjwCyjHzoausJqSq6XBiVQsFANZtkD7zdZ8tFgfIbUYK3TXo+Bb
MxgdionHkf4/UPe4py99a8o8DbSkKxxNuTNSDT4Rvetw45S8o4hJDc/+gwCcVUPW
sr5RXtYV4P9178oYpsONOxHiARWq7Tr4NI8UCsRj6v9aYybTCUTxg23KJ0CZzvxx
h9o6WU1C
=Ev3B
-----END PGP SIGNATURE-----

--+Vr7AZMhw/tfuG5H--
