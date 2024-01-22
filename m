Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D6CC47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 17:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1749879BD;
	Mon, 22 Jan 2024 18:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ad7ZqIkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4CD48798B; Mon, 22 Jan 2024 18:54:32 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB1687960
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 18:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5ff847429d4so30409247b3.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705946069; x=1706550869; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=toizd7JF8gQ5DYC2FU1ES8rV3qWfWm59DVNDZ8+LjHk=;
 b=Ad7ZqIkBtdNhzoDIZx2SgHoKyd7mSlt7Sy1M2ejMgqQVGD1Lt3zJqliLv+gDFJkTkS
 iL+IIluyqr53b44iWCRpgALbR6+cWKTihOOTsYLMtIWwh58TeWVbzoJKjXhlaib4YWnX
 64XVhAYipiPAgIqlYP8ajVpiR3sB+BQJxXS7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705946069; x=1706550869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toizd7JF8gQ5DYC2FU1ES8rV3qWfWm59DVNDZ8+LjHk=;
 b=o4U1alARihrWpcsY+uV9jxwalqYmm4sCr/ncflk764WaeHw+Std+RpWT6WPJQ5sjLK
 gpmVq6hkrs3u2m7+gUAFSV6jfdXh+x2QuLuMtClg/AXaSXO1mRilOSDyR4ArTI4nz0oo
 y0pfu75DBLb5nQKfhiz1UfITAt+iwkAFOB0QfDqfhgkt9bgu8xXQpz+qv9rcI7YzF3yY
 eMfOyIJvGYOkImxZ+vR46SJmv1bbmDmRhcqx8ys0P0N3zR6nbPTMisLlqiBBxmvj7x0i
 fsB+v6Hj/Edm1zDZzvIQy/wP7Je916IRv02G1POPWJvHecRoLdDQk1b/dEdgoYcSPQcd
 GE+g==
X-Gm-Message-State: AOJu0YzIVtcq9CJAabixy39YeoXfZ1sdASLRd+7cDCSOyvGqndOGm+ee
 VACvuvxXUQnt0F7t/WCg2gqVIzJCi3TyQp8qy5aiorUpgmYz+5Hie84gz1A1GGA=
X-Google-Smtp-Source: AGHT+IGG/qhxjKd1hWtbaln8D4PY+1e3sNZKJfuqJBCGhVZPuGJIcypQeX1shueXSKts+Wfvg5h9iA==
X-Received: by 2002:a81:a0c9:0:b0:5ff:f6eb:8908 with SMTP id
 x192-20020a81a0c9000000b005fff6eb8908mr1583614ywg.98.1705946068859; 
 Mon, 22 Jan 2024 09:54:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n133-20020a81728b000000b005ffa141d9f4sm2400747ywc.18.2024.01.22.09.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 09:54:28 -0800 (PST)
Date: Mon, 22 Jan 2024 12:54:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, heiko@sntech.de,
 Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de,
 jonas@kwiboo.se
Subject: Re: [PATCH v3 4/6] rockchip: find U-boot proper boot device by
 inverting the logic that sets it
Message-ID: <20240122175426.GO3652023@bill-the-cat>
References: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
 <20240117-rk3588-spl-boot-dev-v3-4-72cb989e6da8@theobroma-systems.com>
 <afc5d7e1-030b-48f4-b414-ab4a918debb9@rock-chips.com>
 <ff2cd476-e230-41e9-b9b9-bbf15f8fcfcd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y9CytMBHNkThZd0y"
Content-Disposition: inline
In-Reply-To: <ff2cd476-e230-41e9-b9b9-bbf15f8fcfcd@theobroma-systems.com>
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


--Y9CytMBHNkThZd0y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:49:23AM +0100, Quentin Schulz wrote:
> Hi Kever,
>=20
> On 1/18/24 11:12, Kever Yang wrote:
> > Hi Quentin,
> >=20
> > On 2024/1/18 01:22, Quentin Schulz wrote:
> > > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > >=20
> > > BOOT_DEVICE_* is set by spl_node_to_boot_device() depending on the bl=
ock
> > > device number associated with the MMC device the SPL used to load U-B=
oot
> > > proper from. It is NOT related to the mmc alias in the Device Tree.
> > >=20
> > > For SPI flashes, all SPI flashes will return BOOT_DEVICE_SPI so there=
's
> > > currently no way to know from which one the SPL loaded U-Boot proper
> > > from. Therefore, let's just find the first valid candidate in
> > > /chosen/u-boot,spl-boot-order that is a SPI flash and return that pat=
h.
> > > This is a best effort.
> > >=20
> > > While the original implementation may have worked, using the exact sa=
me
> > > mechanism but in inverted fashion makes it less likely to have
> > > surprising corner-cases or side-effects.
> > >=20
> > > A nice side-effect is that all existing and future Rockchip SoCs now
> > > automatically have their /chosen/u-boot,spl-boot-device set.
> >=20
> > Error happen in some 32bit SoC:
> >=20
> > +arch/arm/mach-rockchip/spl-boot-order.c: In function 'spl_perform_fixu=
ps':
> > +arch/arm/mach-rockchip/spl-boot-order.c:242:31: error: 'struct
> > spl_image_info' has no member named 'fdt_addr'
> > +=A0 242 |=A0=A0=A0=A0=A0=A0=A0=A0 void *blob =3D spl_image->fdt_addr;
> > +=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^~
> > +make[3]: *** [scripts/Makefile.build:257:
> > spl/arch/arm/mach-rockchip/spl-boot-order.o] Error 1
> >=20
> >=20
>=20
> It'd be nice to say **which** boards aren't working so that I can reprodu=
ce
> locally :)
>=20
> I eventually figured we have GitLab CI/CD for your maintainer branch/repo
> here: https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipeline=
s.
> This also helped me figure out this wasn't the only build failure and I
> could send another patch before you had the opportunity to tell me I had
> broken something else :)
>=20
> Giving the link of the failed pipeline would really help, please think ab=
out
> it for next time :) Thanks!
>=20
> For people interested in build-testing all Rockchip platforms locally, I
> used the following script:

Please note that you can also build all of the rockchip platforms
locally with:
tools/buildman/buildman --allow-missing rk rv

It won't be bootable as it will fake all require blobs, but all
platforms will be built. And buildman can be told a number of things to
be built, but "rockchip" only catches the cases where the board vendor
is "rockhip" rather than ARCH_ROCKCHIP, but "rk" and "rv" catch all of
the rkXXXX and rvXXXX SoCs.

--=20
Tom

--Y9CytMBHNkThZd0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWuq88ACgkQFHw5/5Y0
tyzSCAwAs+2ASrR32WmMv2KV+OC7DCB+FePZKBtyWZDs2uurSJhOj012y3U7uAbX
vdCcpFtuZn2EPTb7DpXDJhBsdjVv2gDKAIz5TcXJDlGqsgb3tVf9Ivdho/PdD5wP
6uIIilfpejynV80TnViyW5PZ8pcEV/s2TcnsJJ24nCeSXlEEoP8EdAeLSzr6dJQi
a76qnVwa51zKtVsHId4sDyIpLD8jpQYTAvz7ZRuTkZv/PHx98VN+W0YOdBio2OLv
dlERtxHPzgwuqyRqZ5oqg0b6jPIt3Y7qJgvuSR5FgKNiW08F7SWYsumiNq+GIsea
IeDv0XKFnRJQGbq0Rtd+OFKyaR6tdFEOBb78iMgj1jb4h94Aj5i+68RQgE2y71Hf
q6wU46YNXZ4odMYvmG+cdDTkgB6NzLH8i1XkPYBTFDmrnsphk8plg1zCCLqdlBlk
RtWOT42fjurcbTDZ4pKNL1gyY6qzzCYzurVJByCqk0YtDQruXSU75YAom6I2gP0U
c1jkzXqa
=jCcM
-----END PGP SIGNATURE-----

--Y9CytMBHNkThZd0y--
