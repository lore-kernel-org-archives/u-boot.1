Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D123C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 22:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775A987517;
	Sat,  9 Dec 2023 23:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V0CtJIsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FF68754B; Sat,  9 Dec 2023 23:13:27 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C838874CA
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 23:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b9de2332e3so2050415b6e.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702160003; x=1702764803; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oNbu87EqaVnV78/e22aQl/ZDPAhbIypgXs0Y4CUGbbo=;
 b=V0CtJIsmQ8+Phu6GusWPj3mfbcuQi94+1SfNorgx3VU4Y6fiG6jPqKMUFtnhImhZLJ
 3d86CjWNifF8TBHwEl+Ef9tXf3bISccgdkhYkD7iF7pMdjaPRa04ToaLf2Eg0uoAehEB
 3P1SPpaRpJs8F6kP8c7XnacHfGbTocysG8x9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702160003; x=1702764803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNbu87EqaVnV78/e22aQl/ZDPAhbIypgXs0Y4CUGbbo=;
 b=dZvz6ezfqz4+RdwJWUM+b6MrfpenN6HfOwmR+XeNUFOTYkzsGKpsREx9/hbs8/TpSR
 BvpoZC2Z5vJeVczcoLstpCL6ZP0rr27EhEsKhhS0NdcZJuvenxb8UqHQPBIlbPaz80jg
 MQp5CjmUoHe1ThNuMIylh0VsG2wky1m5s5JW9XwBLl9n9KZRcYlYFCik3C/8QwfdICtf
 p5MN31awUKE7qAXS9k5EMP46cgTfw1GOlH9n8uoq2yPLCBp/9LfiNhrxMklqKp8egkzs
 TjhoEmjrHYeGnBUG+9G0MChYit1O41TYNVMWakxX5JA4yv4ODbObNbOLP6tpKc9tf9ct
 YuoA==
X-Gm-Message-State: AOJu0YxcL9FFKq9an/51WEEkrrOyYf6d3cUbiLfGHwiZacLNy1Sts4Hk
 mA+t0QMQfIKkedE/Uu9/IR3wSw==
X-Google-Smtp-Source: AGHT+IHPrV+LQrUZMh7uT0mg6jllTwNRunyG4R0+KcKnzDg1bvWRqPsMqN/2wprszJ7FNdihH80HdQ==
X-Received: by 2002:a05:6808:2394:b0:3b9:e580:c21b with SMTP id
 bp20-20020a056808239400b003b9e580c21bmr2252485oib.20.1702160003495; 
 Sat, 09 Dec 2023 14:13:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8dee-9b11-e8b3-3204.res6.spectrum.com.
 [2603:6081:7b00:6400:8dee:9b11:e8b3:3204])
 by smtp.gmail.com with ESMTPSA id
 y190-20020a81a1c7000000b005c9cbfc868bsm1759699ywg.33.2023.12.09.14.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 14:13:22 -0800 (PST)
Date: Sat, 9 Dec 2023 17:13:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Bob McChesney <bob@electricworry.net>,
 Stephen Graf <stephen.graf@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: Add support for zBIT ZB25VQ128
Message-ID: <20231209221320.GN2513409@bill-the-cat>
References: <20231204005954.13201-1-andre.przywara@arm.com>
 <20231204005954.13201-2-andre.przywara@arm.com>
 <20231206162443.7f0692d7@donnerap.manchester.arm.com>
 <20231209203423.GF2513409@bill-the-cat>
 <3c6b3fe41f54a2d2a391d433684e80d9@manjaro.org>
 <20231209204336.GG2513409@bill-the-cat>
 <5f898df3e85bb46df5e3dbaa81525047@manjaro.org>
 <20231209212109.GL2513409@bill-the-cat>
 <0dc545aa9d32038dbe7bc481595198b0@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N1mjptx0EPtMX5jH"
Content-Disposition: inline
In-Reply-To: <0dc545aa9d32038dbe7bc481595198b0@manjaro.org>
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


--N1mjptx0EPtMX5jH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 10:43:35PM +0100, Dragan Simic wrote:
> On 2023-12-09 22:21, Tom Rini wrote:
> > On Sat, Dec 09, 2023 at 10:02:09PM +0100, Dragan Simic wrote:
> > > On 2023-12-09 21:43, Tom Rini wrote:
> > > > On Sat, Dec 09, 2023 at 09:37:28PM +0100, Dragan Simic wrote:
> > > > > On 2023-12-09 21:34, Tom Rini wrote:
> > > > > > On Wed, Dec 06, 2023 at 04:24:43PM +0000, Andre Przywara wrote:
> > > > > > > On Mon,  4 Dec 2023 00:59:52 +0000
> > > > > > > Andre Przywara <andre.przywara@arm.com> wrote:
> > > > > > > > Add support for the zBIT ZB25VQ128 (128M-bit) SPI NOR flash=
 memory chip,
> > > > > > > > as used on the Xunlong Orange Pi Zero 3 board.
> > > > > > >
> > > > > > > does anyone have any objections against this patch? I wanted =
to take
> > > > > > > this
> > > > > > > via the sunxi tree, as this blocks some board support patches.
> > > > > > >
> > > > > > > IIUC Linux gave up on adding rather generic entries up for ea=
ch and
> > > > > > > every
> > > > > > > SPI NOR chip, if there is nothing special about them:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D773bbe1044
> > > > > > > Should we follow suit here?
> > > > > >
> > > > > > And we could then start trimming the table we do have as well, =
to
> > > > > > reclaim space?
> > > > >
> > > > > In general, yes, but we'd also need to consume a bit more space w=
ith
> > > > > the
> > > > > additional auto-detection logic.
> > > >
> > > > Maybe part one of the series is backport that logic, part two is re=
move
> > > > all the easy to remove tables? Or at least a number of them so the
> > > > series is a wash and then a targeted series of drop-an-entry and cc=
 the
> > > > person that added it so they can run-time verify it's still fine?
> > >=20
> > > Sounds like a plan to me and I'm willing to work on that.  Though, I
> > > think
> > > we'll inevitably end up with increasing the resulting image sizes a
> > > bit, but
> > > that might be an acceptable trade-off for making supporting more SPI
> > > chips
> > > and more new boards much easier in the future.
> >=20
> > Yeah, this is where we need to go overall long term if nothing else.
>=20
> I agree, it would make the things a bit easier.  I'll see to start working
> on it next week.

Thanks!

--=20
Tom

--N1mjptx0EPtMX5jH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV05oAACgkQFHw5/5Y0
tywkWwv/Zy5aKU00kYp9bu5Sv5U2LkS19uSU3uhkTKHTwdxRuoJZ5V0s8ZajnfA8
vZvEGFF40V+JzFUQxFPPQ4cLOU5JhMEVbt8GynzqOXnRK0o+AAEtre6Nnh2265zW
KZc2Z+SW7QhBECSebFVilSm75SJDoUGiiRMG3OFlsYYmJ7FMqRKAiKhnITcclOQg
8aSzZGapmP5eCm2USIIsL039PULg4Ra3oxvF36aLkcpFRtbikMPOuoESlYQW8jod
owQEcdiY9U9SduFyxpFVkaQF97Wy56sIfHUX+orzPmz195d2B+KgBKTbtaunZfua
TypRhGSUQRIp4IiaHm6AmJDSRgJJ3PYO+98369sCncEpAseIcWsG6mljKexHlTtl
bmNFBIyEHIUlr3lP+1IYW5qH+t30SKb18p9gGmz15OXROexwnvM95FgLVREyrSl2
439kEsdQK5Pb0I5oqqWq8jmEf//VeaL8/PAKxdCs361JZF/fFe+2gZ+ZTMN0UzXQ
AFWO7r6p
=8XU5
-----END PGP SIGNATURE-----

--N1mjptx0EPtMX5jH--
