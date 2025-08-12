Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464F4CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 16:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70ECD80C59;
	Tue, 12 Aug 2025 18:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UFFquRYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23A681D5D; Tue, 12 Aug 2025 18:20:40 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876B1801DD
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 18:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30c8206a3efso1220176fac.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755015637; x=1755620437; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bTAdnr/LMzH2rnUta/WArz37NsuyPNw20E50NHUnZxs=;
 b=UFFquRYvoEj++XmOyCZMkkc8384oXjIKcyyVZsA5qeVlYFCaZ8bMgkyaEGB1sDVe1d
 X0ghaQtx8leqwYydQKuwVQ7mkbToKSbL8s+RBukbZ7OoAdWVNj8MyWgKa58C3dxwQZ9v
 xkqJ4YgSwbb0enVqrtrU2aDNMYp14CASlyX84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755015637; x=1755620437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTAdnr/LMzH2rnUta/WArz37NsuyPNw20E50NHUnZxs=;
 b=wy++uZW5Bz/vB6ntOmhGjZQ3Q7rP1/jMmTf4YeJNruPo8+SNybsSpp5apI76v2AfQV
 qGyIFCbmWOzG5CBwAYzRFCr7Ci1TlLwZsgwDazvJthesfzfgJM9CW4bqAHyTuEOp0Uqj
 Zad4nCv7mk1zoFK7inYGl9wAda6WZHNtDqrIK0zaEYOM0sCtyJfBt2+rOwpidyC1tkr4
 I9Mc3/CIGmctaLZpoa9L52i4hqsAK8R1A5yS+2MJkepVpZBiAEP7hIHWjJzOlbEashTr
 n15DGQ7sVCOIk5TJHHy0rHlQUtPNRARdA0jl9/LS1/zHfCr8Bi/jgzjAX3oNwUYINbb+
 NPAQ==
X-Gm-Message-State: AOJu0YxTn2tkhWCXVCgwBfGsDNQ5J1suE0g4rDvwax3nQFKUolNZye4L
 9GxNTdDw3eCc/1gTsctshsMt+HsnVxRAonN24jfDodknV7NJJdOwbQB1IEFm52ATADc=
X-Gm-Gg: ASbGncvMhmi0rZHSsRMuoZWSC+mgebN1gyQ393foboEqzxKzJgnL//XvyL4BJBDo5AH
 HjgbvvnmJ+xS6zNwWltCv7DWnR2wL27Oh4FJDihRNczmfRwnwa0lcT2a0jZXsbIn/2mH5dbFIdc
 eDbp2Cd4tQkektyf2Cv1X5/tltmgu4lmUJxx5cS2szCTRdjEEU03tGF/4gBBs/dFYG++SgIiRGV
 KIJgspllDMS/YOF4vm4q4viiaemM4L/68f8HRH0OG4Sx2SsvEhtyPlsL8Ti/iT2jl/c5t5Qpvxo
 fljCxIIb1BGBr+ww8DAbEWFqiVns5pU4iLvS8FUVWHPSy/lbgE0IwSu0J/eOE28jwEGTiUUIqHh
 HzZAmDc+bywTE1PrJN0vQKEJd3OXwSJ7QXsBmcMsTxMC35LmSNX5ArsNX
X-Google-Smtp-Source: AGHT+IGwqbZgjvqFxmG/cyzHvu1wmTjI8wnjiM0PyvBkBs/8K0dzKLBY6xp0R02dqlPoB5ES1vxWeQ==
X-Received: by 2002:a05:6871:4312:b0:30c:4f83:79a5 with SMTP id
 586e51a60fabf-30cb4550c9bmr25072fac.31.1755015637183; 
 Tue, 12 Aug 2025 09:20:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7436f9821ccsm303357a34.38.2025.08.12.09.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 09:20:36 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:20:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Andri Yngvason <andri@yngvason.is>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: led: Add WS28XX compatible LED driver
Message-ID: <20250812162034.GX124814@bill-the-cat>
References: <20250812153048.2775200-1-andri@yngvason.is>
 <20250812155951.GW124814@bill-the-cat>
 <CAFNQBQzpOej99AE3ZXdTdV7r0o7p6AE8cVeuADHWLkMeTvZRBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XxpgiDM2jfb2feUq"
Content-Disposition: inline
In-Reply-To: <CAFNQBQzpOej99AE3ZXdTdV7r0o7p6AE8cVeuADHWLkMeTvZRBg@mail.gmail.com>
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


--XxpgiDM2jfb2feUq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 04:10:12PM +0000, Andri Yngvason wrote:
> Hi Tom,
>=20
> =FEri., 12. =E1g=FA. 2025 kl. 15:59 skrifa=F0i Tom Rini <trini@konsulko.c=
om>:
> >
> > On Tue, Aug 12, 2025 at 03:30:18PM +0000, Andri Yngvason wrote:
> > > This is a new LED driver for the WS28XX family of LED controllers from
> > > Worldsemi and compatible devices from other manufacturers.
> > >
> > > The LED chain must be connected to an SPI output. This driver uses SPI
> > > to emulate the required digital signal.
> > >
> > > Each LED gets a fixed colour assigned to it in the device tree.
> > >
> > > Signed-off-by: Andri Yngvason <andri@yngvason.is>
> > > ---
> > >  doc/device-tree-bindings/leds/leds-ws28xx.txt |  48 ++++
> >
> > We have dts/upstream/Bindings/leds/ now, so this needs to be upstream
> > and the driver compatible with that. If the driver is already
> > compatible, we can just omit adding this file. Thanks.
> >
>=20
> There does not exist a compatible driver in the Linux kernel. Are you
> saying that I also need to implement this for the Linux kernel for
> this to be accepted into u-boot?
>=20
> I have also written a driver for Linux, but I have no intention of
> upstreaming it as it is much too complex to fit into the LED
> subsystem.

You need to get the binding upstreamed, yes. That's not the same as
having a linux kernel driver upstreamed too.

--=20
Tom

--XxpgiDM2jfb2feUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJtpzgAKCRAr4qD1Cr/k
Cpw9AQDDWcn1D5q9dFopSdRMtQxpPA1uLbYvaDqZ3TRZBy/NzwD/XubnemWa7Ss0
odvAGL1Xty1sVTLixZpjiPOHEajERQw=
=85+g
-----END PGP SIGNATURE-----

--XxpgiDM2jfb2feUq--
