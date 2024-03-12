Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C92FC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 13:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476F987F27;
	Tue, 12 Mar 2024 14:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cYMFOtk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347ED87F36; Tue, 12 Mar 2024 14:20:34 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CCD87E2E
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 14:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 41DAB610D5;
 Tue, 12 Mar 2024 13:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68A7C433C7;
 Tue, 12 Mar 2024 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710249629;
 bh=kG1W7uEQ/qftHXQcAMELyKZpvVSpKP3w6+Gu+6ow4Mo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cYMFOtk7hpKcJjAZrVNY94237Yk85pacMFvCOPFqV5p16u73ujFwh9PH5JLb0cm83
 /3aFLNDbB+nFVNsn115eUbAbPnDCbNHUribQqP8KFCjRTftwFdzx79ylp2vusfTNQu
 rxOGpPFWvK5bAbxKk0Ne/an+KZZSBYDzxus3zQpme5e8zP93+yL3EBt3wl5riXY8Fj
 syPh0Hw/xqb5IBQigFHl7bgBc4/2bVunbimurpY26WvJYos/SK5aOJicDsRTn8bneH
 lsgMnjkNILSqW3DKOSvZSD+BvzNiqPlyfHhgrlEOdLUBxXOwoS81Ows/g2B7KJJgQ2
 m1eKibbmvuicw==
Date: Tue, 12 Mar 2024 13:20:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Leo Liang <ycliang@andestech.com>
Cc: Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: Add ethernet node
Message-ID: <20240312-unnatural-deviant-24bab57103ba@spud>
References: <20240310055816.11575-1-seashell11234455@gmail.com>
 <20240310055816.11575-3-seashell11234455@gmail.com>
 <ZfAnkOLt4mdCZLOP@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="usU7dECXSGppG9Mm"
Content-Disposition: inline
In-Reply-To: <ZfAnkOLt4mdCZLOP@swlinux02>
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


--usU7dECXSGppG9Mm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 05:59:44PM +0800, Leo Liang wrote:
> On Sun, Mar 10, 2024 at 01:56:45PM +0800, Kongyang Liu wrote:
> > Add ethernet node for cv1800b SoC
> >=20
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > ---
> >=20
> >  arch/riscv/dts/cv18xx.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
>=20
> Hi KongYang,
>=20
> Will there be a patch adding this ethernet node for kernel as well ?

It's highly like that the compatible of "cv1800b-ethernet" will be
requested to be changed to "cv1800b-dwmac" to match the designware IP
used in other SoCs.

The added node also looks suspiciously missing any clocks or interrupts.

--usU7dECXSGppG9Mm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfBWmgAKCRB4tDGHoIJi
0ud0AP0bSXsW12m6BoNI6eoagwzeDyuUp9KYXsmCbYjxKqgbagD+MuL9Rudvgb9c
Ir33jUYeFXdTE/dUbwSc/NZVaf9syQA=
=raWS
-----END PGP SIGNATURE-----

--usU7dECXSGppG9Mm--
