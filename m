Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D26D79742
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 07:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DB584564;
	Sat, 31 Jan 2026 08:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dZRvi9lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BDD84568; Sat, 31 Jan 2026 08:27:03 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E62B18455B
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 08:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from ehlo.thunderbird.net (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id E8C961F990;
 Sat, 31 Jan 2026 08:26:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1769844420;
 bh=eSXEULXUQjqKGoB+0xRj0FyxX2kNxnsnsn3nN2nkyWU=; h=From:To:Subject;
 b=dZRvi9lOonHu29Cv2FIC2j6KehY6MBL46HiJoEg0Dy5K+jfMzu2aicicqB9aZx9+Y
 HI55KZ21N0EFtPCLd0J3JRXyglC1i8OpecExQ6M+mvBZCUb4UgifVuv+QwBCJimVvy
 5YciDAVACL7q763gQTIW6hYHKJ6feMe/ATkzQ8X8jBS/5cE6/2h3y/p/8DAEuLzXOQ
 cEzK3e3kOKuS3goxUv+PB12S8UP+YW/9dIkHpAEY6O6yLOyRdoWDzocW7R8OuethbC
 FSZFf9jw/n/iPSRV81i05SsYZY9hTQ/+HTHcIawcAPrOrMeu9zG13Ut8pi/bekCM4z
 Ou09h1xt3ezCQ==
Date: Sat, 31 Jan 2026 08:26:59 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH 4/4] imx9: Kconfig: Enable remoteproc for i.MX95 EVK
User-Agent: K-9 Mail for Android
In-Reply-To: <PAXPR04MB84591087BC940470B1AC0227889FA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
 <20260129-imx95-rproc-v1-4-035b2dbf3e57@nxp.com>
 <20260129100133.GA30853@francesco-nb>
 <PAXPR04MB84591087BC940470B1AC0227889FA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Message-ID: <88173A72-552A-4768-88AB-BF29D2511254@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Peng

On January 30, 2026 3:06:04 AM GMT+01:00, Peng Fan <peng=2Efan@nxp=2Ecom> =
wrote:
>Hi Francesco,
>
>> Subject: Re: [PATCH 4/4] imx9: Kconfig: Enable remoteproc for i=2EMX95
>=2E=2E=2E
>> >
>> > diff --git a/arch/arm/mach-imx/imx9/Kconfig
>> > b/arch/arm/mach-imx/imx9/Kconfig index
>> d9f97e4328c=2E=2E7051e086072 100644
>> > --- a/arch/arm/mach-imx/imx9/Kconfig
>> > +++ b/arch/arm/mach-imx/imx9/Kconfig
>> > @@ -134,6 +134,12 @@ config TARGET_IMX95_19X19_EVK
>> >  	imply BOOTSTD_BOOTCOMMAND
>> >  	imply BOOTSTD_FULL
>> >  	imply OF_UPSTREAM
>> > +	select CMD_REMOTEPROC
>> > +	select REMOTEPROC_IMX
>> > +	select REGMAP
>> > +	select SYSCON
>> > +	select IMX_SM_LMM
>> > +	select IMX_SM_CPU
>>=20
>> Why doing this with a select in the Kconfig?
>>=20
>> I would expect either
>>  - you enable what you need in the defconfig
>>  - you add the select to the imx95 soc
>
>There are many defconfigs in NXP downstream for
>a single board:
>$ls -l configs/imx95_19x19_* | wc -l
>21
>I would not changes so many defconfigs=2E

Why don't you have the common part shared in a single defconfig fragment a=
nd reuse it without duplicating the content?


Francesco=20
