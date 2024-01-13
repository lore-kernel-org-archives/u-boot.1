Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3EAC4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 20:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2929E87967;
	Sat, 13 Jan 2024 21:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="WCDmsl37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6C087134; Sat, 13 Jan 2024 21:52:10 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7805687968
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 21:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8C9DC206F2;
 Sat, 13 Jan 2024 21:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1705179127;
 bh=tLiKewzyxcnJSBU3l83LIRZJRpACx5Eiud5KwZ1vq38=; h=From:To:Subject;
 b=WCDmsl37JxxQcj7ezhEFIHpIjWNiaBMUQkROZ/MhywkisuBJnMS6mdEcVCNFtxAup
 /Ezp6cb9PvERH7dwnPFCp7Bfe6acBXwoI9ENkNldNrfQtGsaYMwkz6j8rpf7xJG/1z
 d8onk/JXWNIYFMliLYVDp+v9ohM6nSFudcgRMDO4NIzshEeCCCuEnFh+7hrSO1vGQr
 zH+Tdt5wB8J+qUkTkrDzfoH2/xdA21KFp4anCvYQgOZlY53DbguMLhCSvsPNxYqKaY
 yrsckT915ifjE0sbyUALiCpi1kh2GwJTbcJ83utF7jaEMdXTLglNdeCVGsSKlM48ra
 fHWvnlOlwFvGw==
Date: Sat, 13 Jan 2024 21:52:03 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Message-ID: <20240113205203.GA3650@francesco-nb>
References: <CAOMZO5APcHhdkvd40Pm+WzSAoxtHS0kcdVpkRTs8yqwXdUSaRQ@mail.gmail.com>
 <e07c0ace3d9db05e80795a949a449506d7a3247e.camel@toradex.com>
 <20240113204542.GA3000@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113204542.GA3000@francesco-nb>
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

On Sat, Jan 13, 2024 at 09:45:42PM +0100, Francesco Dolcini wrote:
> On Sat, Jan 13, 2024 at 06:40:19PM +0000, Marcel Ziswiler wrote:
> > Hi Marek
> > 
> > Thanks, seems like a decent idea. I guess we just did not do it as those previous revisions were just samples
> > but with this change can still be used much easier (e.g. without requiring manual intervention).
> > 
> > On Sat, 2024-01-13 at 19:33 +0100, Marek Vasut wrote:
> > > The older i.MX8M Mini Verdin SoMs before rev. 1.1C came with 20 MHz SPI CAN
> > > controller oscillator, the newer SoMs use 40 MHz oscillator. Handle both by
> > > overriding the oscillator frequency just before booting the kernel.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > Cc: Philippe Schenker <philippe.schenker@toradex.com>
> > > Cc: Stefano Babic <sbabic@denx.de>
> > 
> > Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Marcel, that patch is buggy.
> 
> The assembly version makes sense only for a specific major/minor
> hardware version.
> 
> So what you need to check if revision < 1.1C, while the code from Marek
> check just for the assembly version C.

And in the general case even my suggested test is not enough.  We
started having assembly version that are not linearly increasing since
some time.

I am fine on finding a solution to dynamically handle the different
oscillator frequency, but let's do it right.

I will reply Monday with some more details so we can have a working
solution.

Francesco

