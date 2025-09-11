Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D619CAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 06:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4CB832F9;
	Thu, 11 Sep 2025 08:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="SP2vIUsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C77832FE; Thu, 11 Sep 2025 08:46:30 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB8583280
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 08:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B5FC61016F2; Thu, 11 Sep 2025 08:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1757573187;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=L7MVFt25nE0tRZtxMFygQOkRqLrT/Wfh1UBKYk3sYU0=;
 b=SP2vIUsgaWdv18ZKrdTGg2902ueIhAvLwdAzxL5XlSNiKOtn5iQ6j+nFd9dXMiKto1NcVY
 cermobbyiS6QqQSiZnuhGoM9FJwYko48Sls37LG2u0uZnR72VV3K7Ay7q2aBrXfqNzWHv0
 0T3vNNI9Vk3hxP1MQUA7+Az8+cbPs2avk8J6n2uAWrXJ29geZgNGrgWp5nQvv/Qz/agxow
 n8pb+olbp6Ccpa7/9AwTx61d6KwZ3jCTtDCHpsDIjiJdZ+yHqLRBzukLbuc1ZvWdOPOuhd
 hLeWoXDVKyk7b7Gg9pp6fjtXCvoPSVvRyIA+uvpj2hl4z/e0bQ3ycF8nLPwj4A==
Date: Thu, 11 Sep 2025 08:46:24 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, u-boot@lists.denx.de, Stephen Warren
 <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250911084624.3277af96@wsk>
In-Reply-To: <20250910140743.GA41850@francesco-nb>
References: <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
 <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
 <20250909153948.GY124814@bill-the-cat>
 <CAPVz0n1xCXPq6Qhd+EuJxkno=g8p5VXjxw0MaAz3ePumCzU4mg@mail.gmail.com>
 <20250909154710.GZ124814@bill-the-cat>
 <CAPVz0n0Yk8GzX7Y3qUET2EK=UWyGwn7FLn5HGfLP7i9ms9ht2w@mail.gmail.com>
 <20250910085148.GA9815@francesco-nb> <20250910142821.7aff2ea1@wsk>
 <20250910140743.GA41850@francesco-nb>
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

> On Wed, Sep 10, 2025 at 02:28:21PM +0200, =C5=81ukasz Majewski wrote:
> > Hi Francesco,
> >  =20
> > > Hello,
> > >=20
> > > On Tue, Sep 09, 2025 at 07:08:34PM +0300, Svyatoslav Ryhel wrote:
> > > =20
> > > > =D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:=
47 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >  =20
> > > > >   =20
> > > > ...   =20
> > > > > It's a devkit where I'm pretty sure the watchdog exists, so
> > > > > we can enable it there and be done. Just because it doesn't
> > > > > use it today doesn't mean it can't use it in the future if we
> > > > > enable it, the "use watchdog to make sure A/B system
> > > > > configures are stable" is a common use case.   =20
> > > ... =20
> > > > Not sure if changes into colibri_t30_defconfig are needed, but
> > > > if Francesco would like them, then ok.   =20
> > >=20
> > > I would prefer the defconfig not to be touched.
> > >  =20
> >=20
> > I'm still puzzled why this cannot be changed? =20
>=20
> In general I like the idea of the watchdog driver to be enabled by
> default on the defconfig. This is the sane thing to do in a lot of
> situation.
>=20
> Enabling it however complicates some use cases, attaching a debugger,
> or maybe we have a situation in which the OS is currently not keeping
> the WD alive, therefore you would be potentially in trouble if you
> would update the bootloader.
>=20
> I am not familiar with the general colibri t30 user base to be enough
> confident this change will be fine, so this is the reason I am a
> little hesitant to change for such an old product.
> =20
> With that said, I am ok to change it, no strong arguments against.
>=20

Ok, so I will prepare patch modifying colibri_t30_defconfig after the
WDT supporting patches are accepted.

> Francesco
>=20
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
