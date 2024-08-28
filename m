Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1C0C5474A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 07:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC88D88A75;
	Wed, 28 Aug 2024 09:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2373588A75; Wed, 28 Aug 2024 09:58:36 +0200 (CEST)
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de
 [134.119.228.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F14D0888C1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay08.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98)
 (envelope-from <LW@KARO-electronics.de>) id 1sjDZZ-000000003MD-1IUK;
 Wed, 28 Aug 2024 09:58:33 +0200
Date: Wed, 28 Aug 2024 09:58:32 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "Tomas Paukrt" <tomaspaukrt@email.cz>
Cc: "Peng Fan" <peng.fan@nxp.com>, "marex@denx.de" <marex@denx.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, Francesco   Dolcini <francesco.dolcini@toradex.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "aford173@gmail.com"
 <aford173@gmail.com>, "Ye Li" <ye.li@nxp.com>,
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode
Message-ID: <20240828095832.4b750b9f@karo-electronics.de>
In-Reply-To: <WG.ZbwF.4nJHVDUTLil.1cpjQO@seznam.cz>
References: <Q9.ZbwV.3d4YBfwRcrs.1cphoJ@seznam.cz>
 <PAXPR04MB84594F2939AE13CFEAD7E97688952@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <WG.ZbwF.4nJHVDUTLil.1cpjQO@seznam.cz>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
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

Hi,

On Wed, 28 Aug 2024 09:49:44 +0200 (CEST) Tomas Paukrt wrote:
> > You may give a look to this
> >
> > https://lore.kernel.org/u-boot/57015C5F.3080209@denx.de/
> >
> > Regards,
> > Peng. =20
>=20
> The Linux driver uses the DR register for about 9 years and
> the NXP U-Boot driver uses the DR register for about 7 years,
> so only the mainline U-Boot driver still uses the PSR register.
>=20
> Please give a look to:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D442b2494b17d1a4f0a14721580271eb23ebffd42
> https://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04=
e64f437b0c2
>
Reading the PSR (with SION set) has the advantage that it provides the
_actual_ pin state rather than the programmed output value even in case
external hardware drives against the output driver.
This is especially useful for Opendrain outputs or in case the output
driver is disabled via the pad_ctl register.


Lothar Wa=C3=9Fmann
