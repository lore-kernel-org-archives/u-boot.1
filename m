Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27152D41C18
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 08:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808788953C;
	Wed, 13 Nov 2024 09:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="EYaUyzaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDA8894F3; Wed, 13 Nov 2024 09:38:32 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FBE894FC
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E7F6B1F938;
 Wed, 13 Nov 2024 09:38:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1731487110;
 bh=dqWyhL9cBgNbT62sERLLdGWX2FoRxNLZPJRu5CvmbnQ=;
 h=Received:From:To:Subject;
 b=EYaUyzaLh0Egsps+l5+Gofo1n6YmuJv9OunYniewz5ghJP3cS/pmMUYyJ9ZVq0nAO
 5fvCGsY9w8wEbwDG5Nr4cOnc1/RmucLw4SFB+oTYe9iiAbZb49Ov5iQAv800JBe61/
 uv56FFh0PpYkGNlfND6CgEGcbIz+xqiCHwVItxE1GzIPvLLRwUVe9YuHtZazaSm+mJ
 33k9+p2K/vs9I0SRsG8x01qRa+FH3zSBpHm5xHahmOHuKXWD94R22itDWOqIWRyIaE
 9lFf+Xaoliteoug+KzVJ5B+qJJ6QQuuLzcS1eY9OMsqBxFc1YbfalK8GIqDZGeJBYH
 7IAGSX1a7m8uQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 9BA0B7F949; Wed, 13 Nov 2024 09:38:29 +0100 (CET)
Date: Wed, 13 Nov 2024 09:38:29 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] imx: Fix critical thermal threshold
Message-ID: <ZzRlhaxjr96CqX8b@gaggiata.pivistrello.it>
References: <20241112175427.83979-1-francesco@dolcini.it>
 <PAXPR04MB845982FC3C40774BAB0CA92A885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845982FC3C40774BAB0CA92A885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On Wed, Nov 13, 2024 at 05:27:23AM +0000, Peng Fan wrote:
> > Subject: [PATCH v1] imx: Fix critical thermal threshold
> > 
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Fix the critical thermal threshold for i.MX processors, this was changed
> > while moving the code from imx8m/imx9 directories into a shared
> > place.
> > 
> > There is no need to keep the critical threshold 5 degrees less than the
> > SoC maximum temperature threshold, what is actually going to happen
> > in practice is that we are going to power-off the board when the SoC is
> > still within its working temperature range.
> 
> Should we leave some margin for the critical temperature?

What's the point of such a margin? For doing what?

What is happening is that the OS takes some drastic measure when the critical
threshold is reached, for example rebooting or shutting down the system. Why
would I want to deliberately remove 5 Celsius degrees of valid working
temperature range from my SoC?

Eventually, assuming such a use case would exist, it must be made configurable.
The change you implemented is just creating a regression for existing users
(this is the reason I noticed, it broke our device functionality).

Francesco

