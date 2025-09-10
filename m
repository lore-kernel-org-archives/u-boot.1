Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E69DCA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 06:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 585E3830A0;
	Wed, 10 Sep 2025 08:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Ldxz1CuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A828318E; Wed, 10 Sep 2025 08:52:39 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D7482B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 08:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DDBB2106305; Wed, 10 Sep 2025 08:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1757487155;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JMSCylHCoM6c7KxFMkNNlLAAPHKbgXePl745e9yVq+I=;
 b=Ldxz1CuGY2zW3Fa9FWUugKjPJ7wPrvZ1dxeaNIq+pkAJPPD3YpT2Ytpko3TnFpg11bLsT2
 9AxQXNCFnKL9NRW65KSHvQb1rB0rVm3SGmj89FoLNP/LLi+oBi3jEcFlHwmGbhXzCdmWUq
 rD3THUi99nbHMWmJZvRdHIL6xE6Z/MEb0h8k3aTGbpIZrP84iFbigT8ljdQDG5FYaTFhvC
 Vt5LNx6dml3iF91ugZzy0c0MrEpoqQG3b2g2NFURoF12wlEaGRr0sCxZCUH7tF+vA7CBv0
 sAI+tbfzYBbv7fCBVYJZ9QwoZD3DHINApCpt5Z0ac46uwbqdR1ugfnY1J9RK2A==
Date: Wed, 10 Sep 2025 08:52:33 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Thierry Reding <treding@nvidia.com>,
 u-boot@lists.denx.de, Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250910085233.368e801b@wsk>
In-Reply-To: <20250909154710.GZ124814@bill-the-cat>
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
 <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
 <20250909153948.GY124814@bill-the-cat>
 <CAPVz0n1xCXPq6Qhd+EuJxkno=g8p5VXjxw0MaAz3ePumCzU4mg@mail.gmail.com>
 <20250909154710.GZ124814@bill-the-cat>
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

Hi Tom,

> On Tue, Sep 09, 2025 at 06:44:45PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:39 T=
om Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > >
> > > On Tue, Sep 09, 2025 at 02:26:19PM +0300, Svyatoslav Ryhel wrote:
> > > =20
> > > > =D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:=
15 =C5=81ukasz Majewski <lukma@nabladev.com>
> > > > =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > > >
> > > > > Hi Svyatoslav,
> > > > > =20
> > > > > > =D0=BF=D0=BD, 8 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE=
 15:41 =C5=81ukasz Majewski
> > > > > > <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > > > > >
> > > > > > > Hi Svyatoslav,
> > > > > > > =20
> > > > > > > > =D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=
=80. =D0=BE 12:39 Lukasz Majewski
> > > > > > > > <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > > > > > > >
> > > > > > > > > The Tegra30 SoC is a bit special, as it doesn't have
> > > > > > > > > the separate IP block to provide watchdog
> > > > > > > > > functionality.
> > > > > > > > >
> > > > > > > > > Instead, timer IP block allows such functionality
> > > > > > > > > when properly configured.
> > > > > > > > >
> > > > > > > > > As in the tegra30.dtsi there is a timer node, which
> > > > > > > > > "covers" all timers, with 'nvidia,tegra30-timer'
> > > > > > > > > compatibility it was necessary to manually bind
> > > > > > > > > U-Boot's WDT driver (based on WDT_UCLASS).
> > > > > > > > >
> > > > > > > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> > > > > > > > >  1 file changed, 18 insertions(+)
> > > > > > > > > =20
> > > > > > > >
> > > > > > > > What is the practical application for this diver in
> > > > > > > > therms of Tegra and U-Boot overall? =20
> > > > > > >
> > > > > > > You have the WDT functionality working. It uses the same
> > > > > > > DTS bindings as ones used in Linux. =20
> > > > > >
> > > > > > Why do we need WDT for Tegra in U-Boot at all? =20
> > > > >
> > > > > Can you correct me if I draw wrong conclusion - you ask why
> > > > > Tegra needs to support watchdog in u-boot bootloader ?
> > > > > =20
> > > > > > It is not used and has
> > > > > > no practical application.
> > > > > > =20
> > > > >
> > > > > Yes, it has ...
> > > > >
> > > > > Customer has number of Tegra30 colibri modules in the field.
> > > > > They want to switch to u-boot + linux kernel BSP.
> > > > >
> > > > > For their application - it would be welcome if the device
> > > > > could reboot and start emergency procedure in the case of not
> > > > > being able to start Linux.
> > > > >
> > > > > The procedure is that we start Watchdog at very early boot -
> > > > > then we do have for example 30 seconds to "feed" the Watchdog
> > > > > in Linux
> > > > >
> > > > > When we fail, after watchdog reboot, we can switch to another
> > > > > rootfs partition (the A/B scheme of booting) or start
> > > > > emergency system.=20
> > > >
> > > > So when are you going to submit this board variant? If driver
> > > > has no users, it is removed. =20
> > >
> > > I assume it would be enabled on colibri_t30_defconfig.
> > > =20
> >=20
> > T30 colibri does not need it and does not use it with current
> > configuration, hence I am asking about board submission. =20
>=20
> It's a devkit where I'm pretty sure the watchdog exists, so we can
> enable it there and be done. Just because it doesn't use it today
> doesn't mean it can't use it in the future if we enable it, the "use
> watchdog to make sure A/B system configures are stable" is a common
> use case.

+1

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
