Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D044C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 13:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6215486D33;
	Thu, 23 Nov 2023 14:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XpV06ARB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DB186DC3; Thu, 23 Nov 2023 14:54:04 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0083986CF7
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 14:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A3BAFF813;
 Thu, 23 Nov 2023 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1700747642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HM6Tr7qle+79EQZ9VBRcGVXCcXouOcYmy5v/eEIxtLg=;
 b=XpV06ARBOoofgkrfb5r/EfteOcgtzXEYwTSlD74Q74uZ5zn1sIjgxQzJUSe3gJGsAShtsg
 QfMlF4EFPp386aqk/VSBq1BY9O52Um5eNoqxU7R8uEoZK1sM9F6WfzgA4Sgqcb0dftnHGU
 a/dANvPBdLW7wbS3dvV7fZbpKTp40rWG6gCK+515ULvL497O3VCIu42cZZ/KXRTMbm49z8
 URUNe2gXFUH5UZe7fPT784Pqq1DBSP8DWTb6SFe5YySlVNEGdvZ3ggv1QhRrgWBolKy5Cf
 KPG89Wlr+UhaUuY3rIMWUCNl5QJ0C/I2cJtYDFEW5M5I7xF6N+5iBJ7VmiBgaQ==
Date: Thu, 23 Nov 2023 14:54:00 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, thomas.petazzoni@bootlin.com,
 u-boot@ew.tq-group.com
Subject: Re: [PATCH] tqma6: Fix DDR configuration
Message-ID: <20231123145400.029cb46d@xps-13>
In-Reply-To: <12328531.O9o76ZdvQC@steina-w>
References: <mailman.3902.1700255720.703.u-boot@lists.denx.de>
 <b7f6a997414bd7b37e75dc29c14c6708fad8164c.camel@ew.tq-group.com>
 <20231123141233.3f37c1b7@xps-13> <12328531.O9o76ZdvQC@steina-w>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Alexander,

> > > > --- a/board/tq/tqma6/tqma6q.cfg
> > > > +++ b/board/tq/tqma6/tqma6q.cfg
> > > > @@ -36,7 +36,7 @@ DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
> > > >=20
> > > >  DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
> > > >  DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
> > > >  DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
> > > >=20
> > > > -DATA 4, MX6_IOM_DRAM_RESET, 0x000C3030
> > > > +DATA 4, MX6_IOM_DRAM_RESET, 0x00003030 =20
> > >=20
> > > Thank you for pointing this out. Originally this error came from an
> > > older/ancient reference manual. Sorry that we missed to bring this
> > > upstream. We will send the changes for DCD data in the next days. =20
> >=20
> > No problem, I'm glad this can now be solved. By any chance, could you
> > point to the relevant location of the manual (ddr or imx6 ?) explaining
> > what this is actually about? Because I failed to bring any real
> > explanation to my observations so far. =20
>=20
> It's a bit hidden but the comment above that list indicates these setting=
s are=20
> iomuxc configurations. In this case the register=20
> IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET. See i.MX6Q RM Rev.6 05/2020 section=20
> 36.4.347.
> Your patch configures the field "DDR Select Field" from reserved3 to=20
> DDR3_LPDDR2. It seems this field has to be set to 0 in every case.

Yes, that's also what I get from reading the iMX6Q manual. But I'm
sorry I don't understand why a runtime change of a reset pin
configuration can be so impacting. It's not like it only affects the
power-on sequence because I can reproduce the strange QoS/NIC issues
with a devmem once the kernel has started. I  believe there is a bit
more than just a pad configuration behind this field.

Thanks,
Miqu=C3=A8l
