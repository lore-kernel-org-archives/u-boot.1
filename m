Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81770CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 13:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D9182AE9;
	Mon,  8 Sep 2025 15:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="HAGOomDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766CD82C84; Mon,  8 Sep 2025 14:41:13 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB83800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 14:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6729D1044D0; Mon,  8 Sep 2025 14:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1757335270;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Znz/tdBNuQMj4Ym74q8WILyy7GEmUxKTDqnz1W66DAc=;
 b=HAGOomDUmaeHTFFDl7DIYo8Uc3vYVufQY5tN0xi8a47W2YMjO+1jfYvCFDncFFMksSJVdO
 D7bImnTtCcg1kLcj+j8On7u0OfxBFAjNTN2xIEopQ52Ar2RGLNckaqEjg6CyXDD0gGYG7m
 wRREpU4RCMXiFTG4+UCYbLDP3GFy8lUbm+1xzQJYhgF+w2ZomiBHoaDqHTd9tTrbQl7v1X
 pXOp//qGrVvQqzMshph5tb/bo7M4PS1V112jxI79iDns7jSDg7s7PLMVd69/MIxjU1gbqT
 E4J3lfHJS9Q6GAsUmvqmV2coPiA+2YwEylPsJs2PSvqBUt2H4uJo3rPP0UeZvQ==
Date: Mon, 8 Sep 2025 14:41:07 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250908144107.10bcb8a1@wsk>
In-Reply-To: <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 08 Sep 2025 15:06:10 +0200
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

> =D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 12=
:39 Lukasz Majewski <lukma@nabladev.com>
> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > The Tegra30 SoC is a bit special, as it doesn't have the separate
> > IP block to provide watchdog functionality.
> >
> > Instead, timer IP block allows such functionality when properly
> > configured.
> >
> > As in the tegra30.dtsi there is a timer node, which "covers" all
> > timers, with 'nvidia,tegra30-timer' compatibility it was necessary
> > to manually bind U-Boot's WDT driver (based on WDT_UCLASS).
> >
> > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > ---
> >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > =20
>=20
> What is the practical application for this diver in therms of Tegra
> and U-Boot overall?

You have the WDT functionality working. It uses the same DTS bindings
as ones used in Linux.

> Where is can be used so that existing means of
> U-Boot cannot handle such case?

Currently u-boot for Tegra 30 doesn't support Watchdog at all...

You have for example collibri T30 modules without WDT functionality
support.

After adding those patches you can use WDT class (and wdt command) to
control WDT.

Do you have more specific questions?


It is strange, but I've just noticed your reply (caused probably by my
"work" mail switch), so I would like to apologize for a late reply.


--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
