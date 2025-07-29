Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C107C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FB48277D;
	Tue, 29 Jul 2025 13:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="xdMghkq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 694A582B07; Tue, 29 Jul 2025 13:39:11 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E475182103
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 63AD61FA59;
 Tue, 29 Jul 2025 13:39:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1753789147;
 bh=TCmadwQVL+Om/ItEqLrpqxfMPh4Oqjq//qLnF99lCKQ=; h=From:To:Subject;
 b=xdMghkq18HIRWsj9tC2LHSCB1iYUBc2o6ILJpQrEZBK062Vj0eJZ8FaacdPzvPzjK
 YbYOB/FF7R/Ftnm2emi+ESSbBn12MPnBcVOV6iabK/UtfRrY1U+pC3eodH4QiBy9AH
 WA6hEhTg55kYptzWBJKLLl+EF5vSKHPFlTbyZILuAOn7DXDjc5yirWNQASqPYaIXfA
 TcRTVUJOSnTglqCl80+sFyjz25le9pM9ZWErH42qno5qQPnJwCNLvLi4SIA+8HTm93
 y2LXbPwd9orvJyXbo6KhUMl8p3Xqr8IRilbGU7qpa9IRJS2AW9A+2Hb6f4kPP3NgnG
 cot94q26lMrQA==
Date: Tue, 29 Jul 2025 13:39:02 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: "tharvey@gateworks.com" <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH v2 0/4] imx: add
 i.MX95 b0 support
Message-ID: <20250729113902.GA27993@francesco-nb>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On Tue, Jul 29, 2025 at 02:21:19AM +0000, Alice Guo (OSS) wrote:
> A0 has been dropped.

Dropping support for A0 i.MX95 SoC variant in mainline U-Boot is not a
decision from NXP.

There are multiple boards around with such SoC variant, just dropping
support for it with no explanation does not seem ok to me.

Francesco



