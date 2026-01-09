Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8336FD232C6
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 00:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F358415D;
	Fri,  9 Jan 2026 01:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YYhYVnPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F328415D; Fri,  9 Jan 2026 01:15:05 +0100 (CET)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1092583C91
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 01:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-3f0cbfae787so2792931fac.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 16:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767917700; x=1768522500; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fMS3vPIDys0gzo7vPCTEODd14dSaDYyzgOrEzGYkYsY=;
 b=YYhYVnPyNBTY8vPtGEpbi14/d883VlLlVDXag2OXqKXdBVcILELuLaQornoUQewqel
 dHLUDVA0hwfbGWaaR/76/pSixXEjZRbpvuUGcbNJm7zpmRnivq54Ep4Aq8K6jTLVcuFZ
 zsOxcZc5fou50R9TzXcf3yUqWidsrFYy+UcTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767917700; x=1768522500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMS3vPIDys0gzo7vPCTEODd14dSaDYyzgOrEzGYkYsY=;
 b=tqzH/S4N07paODo8Qo2CSbR2AxdvcR+UquoHDQT1CXtUG8WH51bwTHHARibA/Z0F2k
 LZ6mruNMaTeF3mmKbfyhI4g9cbxWvJ4zAPNXng22dM5uGc4e6+cUAkJKoMtxAeX0rIvu
 P89e3FXFYqwGiQR/T9dNenMiPePYWHJW7eaqzOXl/7qswNN1uPTSo/ijpS6ss+/tOb3+
 wRYsdyRSf7hq3SFs2gQTh2tb4HChyhvBfVaUBNwhE3TWFUcboZ8gpf8igVv3JPzlPL8c
 w76L5YYQvfyI6PA39U9cp9V59PFXzqk8w6wfhR6W2ASkyfozP0e/gNINsb7+Px7+QBKr
 BV7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEiftfukUnxpYXeFRkUvQzsEDYS5lhACS2joTRZVZnfeY20Xol4Kj5c35hkm68eC5LImEWoEc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh9JKlrTE0ltIySxX+xAVdFSv1zLswRak1kAkE5ne07AlLDgmz
 MTtFBDCTJC7WSE5tj6hXBE7qxSF/EEqfrb3V3N42jR9fnHyp5TOrLtfWBXPRdbS6S2M=
X-Gm-Gg: AY/fxX6DmXM31pBY6U/0JRg24PvLK/mcpz/8vUWIgNlphKe8YetKruph3zv4Dtu0Acf
 yV4ltZa0a0kE3ZIkf7SXT5IuazGnKEUX1DRJkujLkEFDAtRqCIeKMIVaGEXsjdAGF6kfzust9QS
 4+J5MMA3Qb30tQbSw8JG0Z6L+ai4gFvk6/kAylu3+XGzFng9WAOYiHRB1W/alMpbbPAhi1OR4tk
 P4J5dsSOS8oQgT/rHiP8MnZhCaGyzM8fMrZ79uMtr3pt3iLGa6ZRPrUmQy05C60Bmjssy60Msqx
 lv6FAITo5PkNLvjqkGMSVSXFmL+X95FbhBe3fCy0DrXn80aoppgYIwEN1E/RZPEkAGoS4WMMCEP
 8Ot2U8VWY7G/62C1pwOhXEg+O40JVGHyJH4Te4m3Ps5U0nhl6/bEOym3ZbRCX4JvyslVz1Ym+az
 lNSPVcl/jb95Bb8XZV+xYY0Is9Koa2NdZGOL/AMYWbUfyH75kovBQfJ6ax9zcYO/80zbrUNNpxi
 odARTLpt++YKW1o2R8vhG5qZqRVIYdUgq4jfI8=
X-Google-Smtp-Source: AGHT+IFyvPh+qZqSn+ETZc2Dzhd9t6Or48wBn8w+rthh9YHTbe11ynQ5M/0ar7RqjVIYlsM4OCnEIQ==
X-Received: by 2002:a05:6870:a54e:b0:3e8:8e56:674b with SMTP id
 586e51a60fabf-3ffc0c3ad69mr4309579fac.53.1767917699611; 
 Thu, 08 Jan 2026 16:14:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50722e9sm5852031fac.14.2026.01.08.16.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 16:14:59 -0800 (PST)
Date: Thu, 8 Jan 2026 18:14:56 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Lukasz Majewski <lukma@denx.de>,
 Maksim Kiselev <bigunclemax@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH] clk: Do not return signed value from clk_get_rate()
Message-ID: <20260109001456.GX3416603@bill-the-cat>
References: <cb4ee3c0a81dda3cbad24ca4b6f69f8a20b29f53.1765971445.git.michal.simek@amd.com>
 <24133fec-ca54-4d83-b243-6923c1999260@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aL/0ei+mYYREmalw"
Content-Disposition: inline
In-Reply-To: <24133fec-ca54-4d83-b243-6923c1999260@baylibre.com>
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


--aL/0ei+mYYREmalw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 05:58:42PM -0600, David Lechner wrote:
> On 12/17/25 5:37 AM, Michal Simek wrote:
> > As it is visible clk_get_rate() is returning ulong:
> > ulong clk_get_rate(struct clk *clk);
> >=20
> > Also struct clk_ops is defining it as
> > ulong (*get_rate)(struct clk *clk);
> >=20
> > That's why return 0 rate when ops->get_rate is not implemented which is
> > the same value as is return when clock is not valid.
> >=20
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >=20
> > Another alternative is obviously also return only long and fix all
> > get_rate calls.
>=20
> I noticed this oddness too recently while working on some clock
> drivers. I suspect most people don't realize that clk get rate
> functions can return an error because the type is unsigned and
> they don't read the documentation. The driver I was working on
> had a number of bugs due to this.
>=20
> Changing the type to signed seems sensible. But I do wonder if there
> are some GHz clock rates > INT_MAX on 32-bit platforms. Changing the
> type could be problematic in that case.
>=20
> If that is the case, the next best thing could be something
> similar to IS_ERR() and PTR_ERR() for checking the return value
> of clk rate functions, e.g RATE_IS_ERR() and RATE_ERR().
>=20
> > ---
> >  drivers/clk/clk-uclass.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > index 4420651f765c..bca818530d4c 100644
> > --- a/drivers/clk/clk-uclass.c
> > +++ b/drivers/clk/clk-uclass.c
> > @@ -490,7 +490,7 @@ ulong clk_get_rate(struct clk *clk)
> >  	ops =3D clk_dev_ops(clk->dev);
> > =20
> >  	if (!ops->get_rate)
> > -		return -ENOSYS;
>=20
> There are a number of places checking rates for this return value
> so I think changing it could unintentionally break things.

Yeah, so there's a few threads over the past few months that need to be
read here, before we decide if there's anything we can do. At least some
of it all is covered in:
https://lore.kernel.org/u-boot/aa7d67c4-5abe-4a71-89b1-866fb677d232@kwiboo.=
se/
(and the rest of the thread), and I think there's others as well if you
search around for clk and Andrew.

--=20
Tom

--aL/0ei+mYYREmalw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWBIfAAKCRAr4qD1Cr/k
CmBJAQCTzpp6oxIwgPa5jGW8gx3t/nBkViKcrJB/meoznfSBDAD7BQqgae6u19zP
kBL8RJeoywFQvz0vJIouXz0rVp6TRgo=
=2/Sf
-----END PGP SIGNATURE-----

--aL/0ei+mYYREmalw--
