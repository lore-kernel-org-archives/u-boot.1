Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7D8CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3164831EA;
	Tue,  9 Sep 2025 14:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="jRxfHLuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E0F8312A; Tue,  9 Sep 2025 12:15:47 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932E2830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 12:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DC19D1001AC; Tue,  9 Sep 2025 12:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1757412944;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vojCgNnMdDSt0nNaYgnSkt8rS/9Txkst+Zku1GgxHFI=;
 b=jRxfHLukyadfj0lsfmwdKMG8efNGjzi6qvseiKa6U+CnHDy9EOy/p2664NKAonQ9ru0bnK
 5lFvg8QvJgs+Ugsk51h1dKxgDUIpz8R6w/tgdpl1TWbHx3xfs2sRwaDkXTRWa9U+sqQVyz
 wBGdCK3QhGf+HjOLFA9uKoQSgdrE0n9NrqjylMRz235PUxlAfWsv4gmRblodjEkoAvs4tY
 jv2nUSa/kHuPjtIvSLVBJGScMEcc7J8s1vMQVdRvwZ7K9vUJW38h4LS4Xe3Z3LVf+jPiw8
 zNx33XgVmIlh3C/XuSrL5qzLn9PJC2j/BwkAM10sZwNzzmZrI096aF5CnMcw0A==
Date: Tue, 9 Sep 2025 12:15:42 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de, Tom Warren
 <twarren@nvidia.com>, Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250909121537.1c2a95b1@wsk>
In-Reply-To: <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 09 Sep 2025 14:59:55 +0200
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

Hi Svyatoslav,

> =D0=BF=D0=BD, 8 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:41 =C5=
=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> > =20
> > > =D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=
=BE 12:39 Lukasz Majewski <lukma@nabladev.com>
> > > =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > >
> > > > The Tegra30 SoC is a bit special, as it doesn't have the
> > > > separate IP block to provide watchdog functionality.
> > > >
> > > > Instead, timer IP block allows such functionality when properly
> > > > configured.
> > > >
> > > > As in the tegra30.dtsi there is a timer node, which "covers" all
> > > > timers, with 'nvidia,tegra30-timer' compatibility it was
> > > > necessary to manually bind U-Boot's WDT driver (based on
> > > > WDT_UCLASS).
> > > >
> > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > ---
> > > >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> > > >  1 file changed, 18 insertions(+)
> > > > =20
> > >
> > > What is the practical application for this diver in therms of
> > > Tegra and U-Boot overall? =20
> >
> > You have the WDT functionality working. It uses the same DTS
> > bindings as ones used in Linux. =20
>=20
> Why do we need WDT for Tegra in U-Boot at all?=20

Can you correct me if I draw wrong conclusion - you ask why Tegra needs
to support watchdog in u-boot bootloader ?

> It is not used and has
> no practical application.
>=20

Yes, it has ...

Customer has number of Tegra30 colibri modules in the field. They want
to switch to u-boot + linux kernel BSP.

For their application - it would be welcome if the device could reboot
and start emergency procedure in the case of not being able to start
Linux.

The procedure is that we start Watchdog at very early boot - then we do
have for example 30 seconds to "feed" the Watchdog in Linux

When we fail, after watchdog reboot, we can switch to another rootfs
partition (the A/B scheme of booting) or start emergency system.


> > > Where is can be used so that existing means of
> > > U-Boot cannot handle such case? =20
> >
> > Currently u-boot for Tegra 30 doesn't support Watchdog at all... =20
>=20
> Yes, and it does not affect or break anything.

Could you be more specific?

>=20
> > You have for example collibri T30 modules without WDT functionality
> > support. =20
>=20
> Correct and? ALL Tegra devices work perfectly fine WITHOUT WDT

They will not fulfil requirements of my customer's use case...

>=20
> > After adding those patches you can use WDT class (and wdt command)
> > to control WDT.
> > =20
>=20
> And what is the benefit? To have a driver for the sake of having a
> driver?

The benefit is simple - WDT support in u-boot allows my customer to
switch to open source BSP.

Many other SoCs (like NXP) do support Watchdog.

>=20
> > Do you have more specific questions?
> >
> >
> > It is strange, but I've just noticed your reply (caused probably by
> > my "work" mail switch), so I would like to apologize for a late
> > reply.
> >
> >
> > --
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> > Nabla Software Engineering GmbH
> > HRB 40522 Augsburg
> > Phone: +49 821 45592596
> > E-Mail: office@nabladev.com
> > Geschftsfhrer : Stefano Babic =20



--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
