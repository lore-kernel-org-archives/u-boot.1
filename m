Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F55C5474E
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 07:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7360988A75;
	Wed, 28 Aug 2024 09:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="UlSmVy6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25D8887B4; Wed, 28 Aug 2024 09:49:54 +0200 (CEST)
Received: from mxe-2-ad2.seznam.cz (mxe-2-ad2.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:ad2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C4588A8B
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-7df5484c66-k4bzx
 (smtpc-mxe-7df5484c66-k4bzx [2a02:598:64:8a00::1000:ad2])
 id 422a4275bcdef0df42a4cc6d; Wed, 28 Aug 2024 09:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1724831388;
 bh=f6xNT1JopWTeuEcmRbQZx6dp863Qerosor8wuR8bcIk=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:References:
 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
 Content-Transfer-Encoding;
 b=UlSmVy6x5U093uLRM9hf0Y+Yb7F+sVkYJmc8YG8ayfbWxet33tBcvpsdwYHaANO5m
 ndEM1sIWP3lqqWUyRtuwdweoxHlOgihdcUJa22bKYycdGTC+ch3UBFL6aoorc2RiKO
 DW4xijfstxbvF5N9ffAk5Q8tVo0B8J5st5/8iqQEwkEa5oeHBuiNXTYktslqhhRV9z
 bGlxn4x8u2l3sT6ppuS9Xbn54obRsI12AJPoYAky9moGwXRHVw/x3w+5PboEi9ZYSV
 dxH+Jzip1DO0TTBNCLTt0MLVaQFcfK9SvTfANc/krAPbWkJtN2BCeuUSixk9RFBNee
 jgxnZ3lz4q/2g==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Wed, 28 Aug 2024 09:49:44 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Peng Fan" <peng.fan@nxp.com>
Cc: =?utf-8?q?marex=40denx=2Ede?= <marex@denx.de>,
 =?utf-8?q?festevam=40gmail=2Ecom?= <festevam@gmail.com>,
 =?utf-8?q?trini=40konsulko=2Ecom?= <trini@konsulko.com>,
 =?utf-8?q?Francesco=0D=0A_Dolcini?= <francesco.dolcini@toradex.com>,
 =?utf-8?q?tharvey=40gateworks=2Ecom?= <tharvey@gateworks.com>,
 =?utf-8?q?aford173=40gmail=2Ecom?= <aford173@gmail.com>,
 "Ye Li" <ye.li@nxp.com>,
 =?utf-8?q?michael=40amarulasolutions=2Ecom?= <michael@amarulasolutions.com>,
 =?utf-8?q?u-boot=40lists=2Edenx=2Ede?= <u-boot@lists.denx.de>
Subject: =?utf-8?q?RE=3A_=5BPATCH_v3=5D_gpio=3A_mxc=5Fgpio=3A_fix_reading_?=
 =?utf-8?q?state_of_GPIO_pins_in_output_mode?=
Date: Wed, 28 Aug 2024 09:49:44 +0200 (CEST)
Message-Id: <WG.ZbwF.4nJHVDUTLil.1cpjQO@seznam.cz>
References: <Q9.ZbwV.3d4YBfwRcrs.1cphoJ@seznam.cz>
 <PAXPR04MB84594F2939AE13CFEAD7E97688952@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84594F2939AE13CFEAD7E97688952@PAXPR04MB8459.eurprd04.prod.outlook.com>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> You may give a look to this
>
> https://lore.kernel.org/u-boot/57015C5F.3080209@denx.de/
>
> Regards,
> Peng.

The Linux driver uses the DR register for about 9 years and
the NXP U-Boot driver uses the DR register for about 7 years,
so only the mainline U-Boot driver still uses the PSR register.

Please give a look to:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D442b2494b17d1a4f0a14721580271eb23ebffd42
https://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04e=
64f437b0c2

Best regards

Tomas
