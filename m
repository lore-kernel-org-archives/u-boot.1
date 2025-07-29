Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFCFC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6898482BA7;
	Tue, 29 Jul 2025 17:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="SNGmP+3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2F682C65; Tue, 29 Jul 2025 17:04:43 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011C682BA1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id C0C6E1F983;
 Tue, 29 Jul 2025 17:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1753801480;
 bh=i+BC0HfyRvQJHl5j7m5LQWeLQH7MeAts/xoqegm2dOo=; h=From:To:Subject;
 b=SNGmP+3QnLOUmQzc3Lsfyy2qDKNmYfmEwesRaV+kWx+Dap4tRyjAm/aKKLclWbkBU
 RW9BjHSuLs/ChLgv55U/0y+1DtR6D13kbOeTwD3tyH+eSOh7DubrRfkFQFi2j6BRE/
 g+bbY7eveuoK+Aj4gPF8gNA2zVZ2xk9buR325gHU3dgYlekr64qk3fq/oSKrctazBv
 xQN5UNk6qPUKFpVkbWc4n42ePeA1oTgIQfTeh3SE9SeWYHNpndfCiYN7Ee2k4Ycsi9
 Gxm/kvmeeSYdUTIr/RZGVwbpf3Idhpl+SF5PHiTqBwig1ttxu1eqkTH89TLaMzy3ag
 y9mT47b7s5sqg==
Date: Tue, 29 Jul 2025 17:04:38 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Ye Li <ye.li@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: ??????: [PATCH v2 0/4] imx: add i.MX95 b0 support
Message-ID: <20250729150438.GB48479@francesco-nb>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <20250729113902.GA27993@francesco-nb>
 <20250729160805.GA31189@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729160805.GA31189@nxa18884-linux.ap.freescale.net>
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

On Wed, Jul 30, 2025 at 12:08:05AM +0800, Peng Fan wrote:
> On Tue, Jul 29, 2025 at 01:39:02PM +0200, Francesco Dolcini wrote:
> >On Tue, Jul 29, 2025 at 02:21:19AM +0000, Alice Guo (OSS) wrote:
> >> A0 has been dropped.
> >
> >Dropping support for A0 i.MX95 SoC variant in mainline U-Boot is not a
> >decision from NXP.
> >
> >There are multiple boards around with such SoC variant, just dropping
> >support for it with no explanation does not seem ok to me.
> 
> A0 may not goes into mass production, so I think it will phase out.
> It would be better to update your boards to use B0.
> 
> Since B0 is here, continuing A0 does not make much sense.

This was clear and known to me.

But that does mean that we have to just drop support from U-Boot? Is
there a significant increased maintenance effort to keep A0 silicon
alive that justify dropping support for it now? We have new products
shipping with A0/A1 silicon as of now.

Francesco

