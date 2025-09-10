Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C24CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 12:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03BAA83236;
	Wed, 10 Sep 2025 14:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="dtNNvm4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C7E88323A; Wed, 10 Sep 2025 14:28:30 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2771383214
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 14:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F818101961; Wed, 10 Sep 2025 14:28:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1757507307;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2ObwmVQM5vIKYRNpVVa2tnZv4m+/Xm6W8scsOr3ICjo=;
 b=dtNNvm4Ta7ZZNql47i+2gPI0bCnBSSXH9T6FOGuAb8asNkivNrC+b4I0JJtvDXtk0hodDC
 rp3reC302N+yIGAop+z45GzW0WRJmJxlx3kpuaE0R5aE2wWfupxdHU5k/H6O501SfljrwE
 bpL3px/yDOEblYrX237dIwPdSxzqF63iBDWy5AS82iRdJ2CnwnknBhOGeLICWGRVRp8XD3
 bF5YIGV0TRdG55HxcnqaPSj+lIkrixFkPcHaU87lV1hYDHY5tc5O0b9GGpq0A1wc1/gEbH
 F32qrGu8+hxw8Pf10jSAIBW1jC3qDKNDvom3LZGafAUmFiBWQniS3xx/gDURGw==
Date: Wed, 10 Sep 2025 14:28:21 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de,
 Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250910142821.7aff2ea1@wsk>
In-Reply-To: <20250910085148.GA9815@francesco-nb>
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
 <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
 <20250909153948.GY124814@bill-the-cat>
 <CAPVz0n1xCXPq6Qhd+EuJxkno=g8p5VXjxw0MaAz3ePumCzU4mg@mail.gmail.com>
 <20250909154710.GZ124814@bill-the-cat>
 <CAPVz0n0Yk8GzX7Y3qUET2EK=UWyGwn7FLn5HGfLP7i9ms9ht2w@mail.gmail.com>
 <20250910085148.GA9815@francesco-nb>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Francesco,

> Hello,
>=20
> On Tue, Sep 09, 2025 at 07:08:34PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:47 T=
om Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > =20
> > ... =20
> > > It's a devkit where I'm pretty sure the watchdog exists, so we can
> > > enable it there and be done. Just because it doesn't use it today
> > > doesn't mean it can't use it in the future if we enable it, the
> > > "use watchdog to make sure A/B system configures are stable" is a
> > > common use case. =20
> ...
> > Not sure if changes into colibri_t30_defconfig are needed, but if
> > Francesco would like them, then ok. =20
>=20
> I would prefer the defconfig not to be touched.
>=20

I'm still puzzled why this cannot be changed?

My customer is using the Colibri T30 module for their production
solution (u-boot 2016.11 from latest Toradex Linux BSP doesn't help :-)
)

To sum up:
----------

1. I think that the WDT driver is required for the Tegra 30 to be
usable in any professional use case based on u-boot.

2. It would be best to modify the colibri_t30_defconfig to add support
for WDT.

3. If point 2 is not possible (please share the rationale for it) -
then I can ask my customer if I can share defconfig for their product.

> Francesco
>=20


--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
