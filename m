Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEC4EF8FE4
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A516283F93;
	Thu,  5 Mar 2026 18:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NG+YOJDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C561A83F2D; Thu,  5 Mar 2026 16:06:41 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F8D81E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 16:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4648448e387so5438362b6e.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772723198; x=1773327998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WtqYFWJepXd1RuG7xJODikd0Qqri7bB0LyHvsU1C8go=;
 b=NG+YOJDQemLWv7gYANE1Qlv0SoZ+Z7h4RemeqEU18XPBw9tMN5ibDTiAP5p4wNYGPS
 KbxF91OwukAj/50l9+/y0g1sPaizjXPJz5va8wX2ToAMDa0+MdvtAKy5kw71KKA9vM2r
 0KVo7OcLjhn0Ra7UwoFlR701+OUa7DQJsVEus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772723198; x=1773327998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtqYFWJepXd1RuG7xJODikd0Qqri7bB0LyHvsU1C8go=;
 b=QEkg11/8XPGoDIhIE8UWNtTU9778KuCobClQgc8cgIo+OWhITqMXGjhugw6gSbgDvP
 oWCgBc7JCbK9ktgV39EPF8rsoijL0LtzgK6p+8K+cx7GLcR2JO3Nx92H4vn2HDAib1WX
 jzhiABntM7Ay5vmdvzGAB0CH9og7jZ9l7TfgZud7/VHkMLZ9sWevrFCUsu8lLr/aEO+5
 E6rfEfPQE3XyRAuupZZUsUqvVsWGvrMaGWUapPYc5nGuJtIktnpCIF7nNT53K9bHLmn/
 lGKXieWOkyxRoor3hStKOcOSL/fqMaDVIX+rZa3d/37rxKecRXpZdvXOaKwb8gUoSXks
 HBKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVILzRsMs6XNo/zpZe3CwYGxjC5pvNPQuDTU2cwEKnjym7z9xXeWXzLV/wuIexy+HdNFClCryo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3Igqc18PyLyYkpeLuTwjFQ8P2SqIjpOUjZ+ClXN1jwSZgzRDQ
 hQ0reu8+xOGqncarvqKhnSK8O5EBqfDhySAyz2LiwZWFw3lHvvDN83mKbB63jzdzEMc=
X-Gm-Gg: ATEYQzwFO0QHAQal/SYQb1hkhcjmPyemednGWvpKZgb9XawpWm9NuKhlhoyBOjfy48y
 K3liW9LcM7Oc9WJicW36hArVge0Ir1oRysquKKVUJKP/kJpYY6lX+y0W/T4KXxS4iAvhX9t9JOH
 Ulqw7YVVLJxzZvz3cs2wWHG4wUv2WQVpbd/3ySDC/XPbaBI4R1Ee865pNen07QGaVMGuiMfaBn6
 i5sYwitgkeYs5f7NQnp0iCjGDbdgL1ZcEER4WEeJSam9OoBHps2kie6bezknxkyHK8CN5nz2xV0
 RthG8e0WGl1JvDoOnSi/RfzFxRdUYUTyCE5Rn15B+tnAbJ8PMWCqOkMW1Sq3TuZGftDa2O+qECW
 LX6Kz5IaShN0pXrVrjVhLj3/M7cETbiF486i12r/Zae/DT43AXrA5dVEWLrS5yWGviGGZON5xtC
 1bP/kRJ2azG02URt/lNOQSGcZu8P9Q+Cpo4w9BPbS8uhOd99SfYyyCcOLPeAZNekIfmlOmlE70L
 8T88S9JZYYbnj8Z8z+hLO70Pgt5C8NIjUbKbNyg2bnI2lABIAqkVUXJxL1aEQ==
X-Received: by 2002:a05:6808:c2f4:b0:45e:a555:4f1e with SMTP id
 5614622812f47-4651acd0ae7mr2920705b6e.38.1772723198339; 
 Thu, 05 Mar 2026 07:06:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb0991f5sm13560528b6e.0.2026.03.05.07.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 07:06:37 -0800 (PST)
Date: Thu, 5 Mar 2026 09:06:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ji Luo <ji.luo@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, Niko Mauno <niko.mauno@vaisala.com>,
 Adam Ford <aford173@gmail.com>, Joseph Guo <qijian.guo@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 11/13] arm64: dts: freescale: Add i.MX952 EVK basic
 device tree
Message-ID: <20260305150634.GF1388590@bill-the-cat>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
 <20260302-imx952-v1-11-069d6167c0cb@nxp.com>
 <CAOMZO5Dz9PNPWqqBOvwquvQYmh+Oy24KQ79d5qcxKn8EbyH1ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vRNU/iFXzYgbmj4N"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dz9PNPWqqBOvwquvQYmh+Oy24KQ79d5qcxKn8EbyH1ew@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 05 Mar 2026 18:26:47 +0100
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


--vRNU/iFXzYgbmj4N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 11:00:11AM -0300, Fabio Estevam wrote:
> Hi Alice,
>=20
> On Mon, Mar 2, 2026 at 3:41=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX952 EVK basic device tree, with UART1, SDHC[1,2] supported.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> >
> > [ upstream commit: a5aa8551d0046ec701e8962f83361165ccf640a4 ]
> >
> > (cherry picked from commit bf18a0f083bdf73f806a3afb9b606b2cb0fcafb3)
> > ---
> >  dts/upstream/src/arm64/freescale/imx952-evk.dts | 217 ++++++++++++++++=
++++++++
> >  1 file changed, 217 insertions(+)
>=20
> Shouldn't we add this temporarily to arch/arm/dts instead?
>=20
> Then, when it reaches dts/upstream, we can move to OF_UPSTREAM.
>=20
> Tom, what is your preference?

This was a correctly done cherry-pick with our script
(bf18a0f083bdf73f806a3afb9b606b2cb0fcafb3 is the commit in
devicetree-rebasing) and may go in dts/upstream.

--=20
Tom

--vRNU/iFXzYgbmj4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaamb+gAKCRAr4qD1Cr/k
CrOyAP0ey8upbWkD8bH1O5UUihAXJNf9brUUf00hhSI16huwNwD/XccmfJ7FWmEw
U/qZJd/hh+6zuh4uRwrSDZhnazsMVgM=
=mhVT
-----END PGP SIGNATURE-----

--vRNU/iFXzYgbmj4N--
