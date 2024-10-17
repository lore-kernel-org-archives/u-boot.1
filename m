Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B64D2127D
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF69E88EDA;
	Thu, 17 Oct 2024 13:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D999488F57; Thu, 17 Oct 2024 13:25:20 +0200 (CEST)
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de
 [80.67.31.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A298988DC6
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay05.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98)
 (envelope-from <LW@KARO-electronics.de>) id 1t1Od1-000000007ND-2HWf;
 Thu, 17 Oct 2024 13:25:15 +0200
Date: Thu, 17 Oct 2024 13:25:14 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "sbabic@denx.de" <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: Re: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
Message-ID: <20241017132514.26807534@karo-electronics.de>
In-Reply-To: <PAXPR04MB84597D20308880039DE8817088472@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241017081236.26742-1-peng.fan@oss.nxp.com>
 <20241017111936.6688fce9@karo-electronics.de>
 <PAXPR04MB84597D20308880039DE8817088472@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On Thu, 17 Oct 2024 09:21:54 +0000 Peng Fan wrote:
> > Subject: Re: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt
> > device tree
> >=20
> > Hi,
> >=20
> > On Thu, 17 Oct 2024 16:12:36 +0800 Peng Fan (OSS) wrote: =20
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > U-Boot device tree is padded just after U-Boot proper.
> > > After the whole stuff loaded to DRAM space, the device tree area is
> > > conflict with BSS region before U-Boot relocation.
> > >
> > > So any write to BSS area before reloc_fdt will corrupt the device
> > > tree. Without the fix, there is issue that "binman_init failed:-2" on
> > > i.MX8MP-EVK board.
> > > =20
> > Placing the 'revision' variable into the 'data' section would achieve t=
he
> > same goal without any further code change:
> > static char revision[4] __section(".data"); =20
>=20
> This was not welcomed,
> https://lore.kernel.org/all/20241017034507.GJ4959@bill-the-cat/
>=20
Thanks, good to know.



Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
