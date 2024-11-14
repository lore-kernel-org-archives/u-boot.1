Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D13D68B31
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 15:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E048890CE;
	Thu, 14 Nov 2024 16:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Fj5Nd1vR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43DD1890B9; Thu, 14 Nov 2024 16:26:56 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DAA890CE
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 16:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E1F591F843;
 Thu, 14 Nov 2024 16:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1731598012;
 bh=QFERuU3z+vzOFYfzQKz4dBXyrvfVkdl2Tr/dFurI6zU=;
 h=Received:From:To:Subject;
 b=Fj5Nd1vR6oDr38kMFrGrXrfAVdRYI4t3t6IjI31DqFUkod1+yOOhHjBW2vowsojKO
 gJV9z0JZWi8FXzOEcPtFvvYmc1bLnw5JN9L/KrDhEy4t3bwT2e3IDSyP/OgadULyzu
 bc70LJt+xHUgKsAdyMqtVLXN1X5dj7kVTSvsZbuGA++K0jpFsp1Mw3yYIOWaIfYQwB
 SMqbCvs8jZoVMN2Nr09uv77edkXL1/mpBSt17Au4NXUqZhLbPpEtDVlUqO5bvf1PWh
 //zUeVPR2H6n5iSBENf2Vk1aWxB+F/5BEMtgYhBFVTEJraIys0B6nXCZHDoQKvPOed
 YXI/+fqcsyatw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 8C7C47FA28; Thu, 14 Nov 2024 16:26:51 +0100 (CET)
Date: Thu, 14 Nov 2024 16:26:51 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] imx: Fix critical thermal threshold
Message-ID: <ZzYWu5bPiWG2uxEC@gaggiata.pivistrello.it>
References: <20241112175427.83979-1-francesco@dolcini.it>
 <PAXPR04MB845982FC3C40774BAB0CA92A885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ZzRlhaxjr96CqX8b@gaggiata.pivistrello.it>
 <PAXPR04MB84592EF185F8F80089BB6796885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84592EF185F8F80089BB6796885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

Hello Peng,

On Wed, Nov 13, 2024 at 09:10:46AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v1] imx: Fix critical thermal threshold
> > On Wed, Nov 13, 2024 at 05:27:23AM +0000, Peng Fan wrote:
> > > > Subject: [PATCH v1] imx: Fix critical thermal threshold
> > > >
> > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > >
> > > > Fix the critical thermal threshold for i.MX processors, this was
> > > > changed while moving the code from imx8m/imx9 directories into
> > a
> > > > shared place.
> > > >
> > > > There is no need to keep the critical threshold 5 degrees less than
> > > > the SoC maximum temperature threshold, what is actually going to
> > > > happen in practice is that we are going to power-off the board
> > when
> > > > the SoC is still within its working temperature range.
> > >
> > > Should we leave some margin for the critical temperature?
> > 
> > What's the point of such a margin? For doing what?
> > 
> > What is happening is that the OS takes some drastic measure when the
> > critical threshold is reached, for example rebooting or shutting down
> > the system. Why would I want to deliberately remove 5 Celsius degrees
> > of valid working temperature range from my SoC?
> 
> The maxc means the maximum temperature that the soc might run at.
> If the current temperature >= maxc, the chip might be broken.
> And temperature sensor may have some deviation.
> So leave margin for SW to shutdown the system. 

Let's brake this problem in two.

1. the change you did created a regression. this must be solved, and this patch
   is solving it. after that we can discuss if this needs to be refined in any way,
   for example making this threshold configurable in some way

2. the device tree is supposed to describe the HW. This is the threshold
   without any *arbitrary* margin. I need to be able to run my system at the
   maximum allowed working temperature. If you want a policy to preserve some
   margin this is not something that should be enforced this way. How can you
   decide that 5 degrees are enough to be able to shutdown the system? It really
   depends if the temperature is raising or not, how fast it is raising, and even
   more external factors.

Francesco

