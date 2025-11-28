Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C9ECFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A1B84547;
	Fri, 28 Nov 2025 12:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="JDLJLNcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528F384548; Fri, 28 Nov 2025 12:42:18 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5086F8452B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9EF851F928;
 Fri, 28 Nov 2025 12:42:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1764330135;
 bh=1bzOqtdKdx8SH4w5cmtpOcB6d0qnm1fkaYpLYZK5yYY=; h=From:To:Subject;
 b=JDLJLNcQyWkaIS16MpwGbClR921vFpIrAx4WGy3gNnOV2HnyA1IMC8fHG1JB7dWJX
 FL2hmXRt+PVaqLUmM4Dnpc7R03RT/x9B5NLhvKPMzkYPIt8u+9UHE9rNrI0x11jBfy
 1n2fr4QbjqbOQAWB9XPCCXcjDWlnXgUR+lviqdeDJFxlB8Fw/e+nAw1yzASK9DfKTw
 wtVVrgzB2Kp/ZSi5jn8Km9ONIs4lAZx6rop0t7cvonT79jydqgBLY+H3kk0xMPJsxB
 nutpHTxplBn8YVtvZ6X8Ab1JP+5D7PlOYIo2bg8IA5Jy62l/USpTJOt5O7d7b/nPJO
 /QVhkzg0ItaLw==
Date: Fri, 28 Nov 2025 12:42:12 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1] imx95_evk: Initialize the ELE RNG context
Message-ID: <20251128114212.GC32259@francesco-nb>
References: <20251113082145.898431-1-alice.guo@oss.nxp.com>
 <DU0PR04MB96367EBECA5951D3B9B7925BE2DCA@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <CAOMZO5BH+=tDCCE4sJtHwQyyu5_+tOJTQi+=+o1A1QT7ML3pkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BH+=tDCCE4sJtHwQyyu5_+tOJTQi+=+o1A1QT7ML3pkw@mail.gmail.com>
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

On Fri, Nov 28, 2025 at 08:00:16AM -0300, Fabio Estevam wrote:
> Hi Alice,
> 
> On Fri, Nov 28, 2025 at 6:08 AM Alice Guo (OSS) <alice.guo@oss.nxp.com> wrote:
> 
> > Gentle ping: Any comments on this patch?
> 
> It looks good to me.
> 
> I plan to queue it for u-boot-imx/next soon.

Fabio, Alice,

Is this something that should be more generic? I assume every i.MX95
board should have the same.

I was looking at this and thinking that we should do the same on our
SMARC i.MX95 board, but at the same time having this code duplicated in
all the different board files does not seem that a good idea.

Francesco


