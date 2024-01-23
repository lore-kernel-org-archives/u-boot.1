Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266BDC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 18:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 816E787D73;
	Tue, 23 Jan 2024 19:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UM1i9lxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D284687A17; Tue, 23 Jan 2024 19:03:08 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADC587D73
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 19:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbed179f0faso4245713276.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 10:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706032983; x=1706637783; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=INFn+A3se0KcsTlYBBRzoGqX/LAPR+prAZTjOjLpM0E=;
 b=UM1i9lxqvFSlcN2RS6UHgRK0WXCywA7HfZUI7+/5cg/3bndjg1X3oXJfKVIEtVkOf3
 zwtlrTX3dM30elN5UJOWozKN/6zveZmM0LIflKMbmoQqOGKA7FKMwNWaA79bq7lNo8G7
 7VMqEFeHl3qZepwPWYd8rVpmszOONm9d8UI78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706032983; x=1706637783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INFn+A3se0KcsTlYBBRzoGqX/LAPR+prAZTjOjLpM0E=;
 b=pG2mUMGO4l0favfcILR0mDp1kYwFgIVaghxMbF0wZnfyLQLIjkxjTHQIcL6qUQNgOq
 kTnH3DbxviHE09QqXlRU+yOTQNZl2+y5L3rYE5VqTi4V/IT56TpujxZahNyyPND2O3Ir
 yCz4knihoOnoqEaUciU1QlkBrLN34raUGLf0O2Fhk7gkeL0Qm/JmpOX77TRTRmtNuWs+
 BLk07ZJ9pg8vus3eZXPRCq9Os++8GHX5qz737f23Xv61jwP9vppw3j/aOeoIVD1BDUmj
 4dXChTvwfXW4AvSbSRN8lVcSJJxTX7kMGFS5Wl6FS7/WNc/gvzqtWoXhGauNrFU1u8Qn
 /PUg==
X-Gm-Message-State: AOJu0YzelTDmtY7IshQJZNGkxR2sMyneGIXQIPq2J/d5UjVvrCcrVMFq
 KyZ75yn9pN4Q1W6NhJukn3eYFQXF9IFvNRMTrlW6wN54iq+B8D922Q5OvLL7IBArCR43t+vFhqr
 q
X-Google-Smtp-Source: AGHT+IEmYztKsOleGeaCS5Mq8pZWRJ5zCBPIRc9waq8LHKCzSMPp9QWsB/V6YVVwENUZNjKHqn9/tw==
X-Received: by 2002:a81:4785:0:b0:5ff:9dea:3777 with SMTP id
 u127-20020a814785000000b005ff9dea3777mr4820400ywa.13.1706032982749; 
 Tue, 23 Jan 2024 10:03:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n4-20020a817204000000b005ff6419ec70sm5208008ywc.109.2024.01.23.10.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 10:03:02 -0800 (PST)
Date: Tue, 23 Jan 2024 13:03:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20240123180300.GW3652023@bill-the-cat>
References: <20240104014919.413568-1-sjg@chromium.org>
 <20240116-snowbound-symptom-aa07c4dcf736@wendy>
 <20240122-pranker-shininess-8953eb6182b4@spud>
 <20240122184717.GQ3652023@bill-the-cat>
 <20240122-finicky-ancient-797ba048f927@spud>
 <20240123-aviation-caretaker-3c49d8da42dd@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VEdfzAiLimgR7c6d"
Content-Disposition: inline
In-Reply-To: <20240123-aviation-caretaker-3c49d8da42dd@spud>
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


--VEdfzAiLimgR7c6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 11:27:57AM +0000, Conor Dooley wrote:
> On Mon, Jan 22, 2024 at 06:55:01PM +0000, Conor Dooley wrote:
> > On Mon, Jan 22, 2024 at 01:47:17PM -0500, Tom Rini wrote:
> > > On Mon, Jan 22, 2024 at 06:36:31PM +0000, Conor Dooley wrote:
> > > > Hey,
> > > >=20
> > > > On Tue, Jan 16, 2024 at 01:48:06PM +0000, Conor Dooley wrote:
> > > > > Yo,
> > > > >=20
> > > > > On Wed, Jan 03, 2024 at 06:49:19PM -0700, Simon Glass wrote:
> > > > > > Standard passage provides for a bloblist to be passed from one =
firmware
> > > > > > phase to the next. That can be used to pass the devicetree alon=
g as well.
> > > > > > Add an option to support this.
> > > > > >=20
> > > > > > Tests for this will be added as part of the Universal Payload w=
ork.
> > > > > >=20
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >=20
> > > > > Since this was merged into master, U-Boot is no longer booting on=
 my
> > > > > icicle kit (At least that's what my bisection tells me). This is a
> > > > > RISC-V board and U-Boot for it is built from
> > > > > microchip_mpfs_icicle_defconfig.
> > > > >=20
> > > > > There's zero output on the console from U-Boot at all, the last t=
hing
> > > > > that I see is OpenSBI before things grind to a halt.
> > > >=20
> > > > Just wondering if there's anything I can do to help this one along?
> > > > Got a red CI complaining at me every morning about it :|
> > >=20
> > > Well, can you please look in to what part of this is causing the
> > > failure? I don't really see what would have changed on
> > > microchip_mpfs_icicle_defconfig from this as BLOBLIST isn't set before
> > > nor after this change.
> >=20
> > Sure. I'll try to look into it more tomorrow.
>=20
> I gave it a try, it seems to be the FDTSRC_BLOBLIST additions that kill
> it, not the actual code in fdtdec_setup().

Well that's very unexpected. Can you see what boundary we're crossing or
whatever has overflowed now or something on your platform?

--=20
Tom

--VEdfzAiLimgR7c6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWv/1QACgkQFHw5/5Y0
tywDhgv9ErIcGBfI8eGRbVJ4uq/4ZvFou1Oe8nXmYoxQHB61r8FP40bJ/aLmWWtm
iAeTyt0Rz1RqLj4LUUu3pw+UyWLkcZhYUAtGDUWoZZL+yUArjooWvAB6zn0w2bU8
svD377DWL0x6rMvqYhWT9V3E21IusPB+/xQSUi6ktKCuUAP49a5Qph2KO7iBoXqD
E+kfCqwzvGhkEmr7rJjYi2mf2qRS5ujX4P5DmpF2ib4VYojKx5XM1NhYPRsCKNQT
XVP9szMKSl70jMv0hpuMHIO0zbnltXVVe7SZNvcxq7gAywS9i7uXYM+6R9Qtbo9v
Z/MEMBnuwlHJVUlxi5pERb4Re4aBfZ55cIblJHrKwPFNEeu3HdCxhUpRCGTX2a2R
BHj4Z5FaEFrcV6js3pcfH1X4wNj420lb+LLdSG8wMi725peDFwsftYYazetY54fI
lJG3gitHhhKnzhNW2OvFKBJmQxOtKiZByOF8vrbqC0Gx4zNG3BSvAR8+dlX6i5hC
3MPOojaC
=piVn
-----END PGP SIGNATURE-----

--VEdfzAiLimgR7c6d--
