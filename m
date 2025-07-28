Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE3AC83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A64482E52;
	Mon, 28 Jul 2025 18:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="OjH7mMaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15CB982E52; Mon, 28 Jul 2025 18:45:00 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06DF82E26
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4C0421FA0D;
 Mon, 28 Jul 2025 18:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1753721096;
 bh=qP/+wf8+AjYPP6bC1dec6aLjcZQDtS+1GHYApyTMnWU=; h=From:To:Subject;
 b=OjH7mMaYmBF60PHeMofRUbLUe9d6Jb71hQhYM1cNxm1oYb7APtmiaR4KYc8jCybg1
 ID600M6MAxBNmd6nQduFWFzaUbtz12F0Rk84JGE4CMeInYx3PU+eKyY4hT5UI0Go8q
 VOrukJ0PpFtCyAwZi91regB85PBUtXby9IWjXtg/DPsjjMI/ZapAOfxx3ITgjF+0on
 nFlIJo8o/70FCAqAM1/v3IR2UKoRgYUYNEBZkjxcuFAUOQvhef6Ur4UtQDL6FLb9Jj
 2SFPNfOgGPQrVRt24NyeYuq670lBkCk4qNy2kZADJ2jGtT9iBLVxs6AP6tPUz6MacR
 YJD3uCyZ5fRJw==
Date: Mon, 28 Jul 2025 18:44:41 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Tim Harvey <tharvey@gateworks.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
 Peng Fan <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
Message-ID: <20250728164441.GA15074@francesco-nb>
References: <20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com>
 <20250724033822.GE18395@nxa18884-linux.ap.freescale.net>
 <kn34dabjpqywranhgrtpy77bmuviluhzgf2pgtdguqvgwk7e3d@3zud5czxsewc>
 <20250728102923.GA32387@francesco-nb>
 <CAOMZO5DT=ua+vCX5OQq6sx1nfcFjFY0S1hJ8OmNE1RWCQAmxJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5DT=ua+vCX5OQq6sx1nfcFjFY0S1hJ8OmNE1RWCQAmxJg@mail.gmail.com>
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

On Mon, Jul 28, 2025 at 11:25:04AM -0300, Fabio Estevam wrote:
> On Mon, Jul 28, 2025 at 7:29 AM Francesco Dolcini <francesco@dolcini.it> wrote:
> 
> > You worked on a similar topic, for imx8m, some time ago, commit
> > d175982c207b ("imx8mn/8mp: Allow booting via USB"). What's your opinion
> > here? How should we fix this?
> 
> The solution on the commit you mentioned is related to the
> i.MX8MN/i.MX8MP boot ROM implementation, and it works there.
> 
> What confuses me about João's patch is that it was not tested against
> the mainline U-Boot.
> 
> Can U-Boot mainline boot over serial download on i.MX95?
> 
> Adding Tim, as he has been trying to get USB boot to work with i.MX95.
> 
> I don't have access to any i.MX95 board to try it myself, so I
> appreciate some help here.

The issue here is not specific about USB, this is about code assuming
that the relevant env config options are enabled without checking
anything AND assuming that ENVL_NOWHERE is working as a default in any
case.

See also env_locations in env/env.c and arch_env_get_location()

Francesco

