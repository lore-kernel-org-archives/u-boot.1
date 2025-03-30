Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29205C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 18:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F037812BC;
	Sun, 30 Mar 2025 20:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ve83mst4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A538144A; Sun, 30 Mar 2025 20:56:40 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D58E80FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 20:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id D3A9D1FA78;
 Sun, 30 Mar 2025 20:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1743360997;
 bh=nXZmTOMCTX8HQBRqpCLH9Hgb1phqy7EXDC3rtteVeTI=; h=From:To:Subject;
 b=ve83mst4ncW3Xfq3WRYaGS69Hd/1IX1dLJnSdg+vt95P9F4ZAJle+LihZ7hC10Q5q
 qbfkaxfagbyqF2g+o+lIQ3v2r3+bb7xVwxdgyEM98oVJQu34R0AT2oIgxaCc0bMx5+
 D4Ak9W7QLx+bLtGrlMA0QFc+kgszqUqJZsqLG5QX4Eubf0H5Ofsa6YMrugoLTs/Ouz
 0gwdQB3g+EuThk2JNji36jBBIuMgG5GLWNkisqipkfvJ6CpEB+cOsKQgpvvOCQGf3I
 g1CXh1ep2BoesqSC+XV67EZCzy8NMu4McHwfL6mZkGIEwuskQqiPZhtBbLU9ydFkVJ
 jnDIiet36C4NA==
Date: Sun, 30 Mar 2025 20:56:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: rafael@beims.me, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Rafael Beims <rafael.beims@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] toradex: apalis-imx6: Fix build failure when
 CONFIG_VIDEO_IPUV3 is enabled
Message-ID: <20250330185632.GA6356@francesco-nb>
References: <20250328102051.2614040-1-rafael@beims.me>
 <20250328160557.GY93000@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328160557.GY93000@bill-the-cat>
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

On Fri, Mar 28, 2025 at 10:05:57AM -0600, Tom Rini wrote:
> On Fri, Mar 28, 2025 at 11:20:40AM +0100, rafael@beims.me wrote:
> 
> > From: Rafael Beims <rafael.beims@toradex.com>
> > 
> > If CONFIG_VIDEO_IPUV3 is enabled without also having CONFIG_IMX_HDMI
> > enabled, the build fails for the Apalis iMX6 board.
> > 
> > Fixes: 592f4aed6db7 ("arm: imx: initial support for apalis imx6")
> > Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> > ---
> >  board/toradex/apalis_imx6/apalis_imx6.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> Is there a reason why this requirement isn't enforced at the Kconfig
> level? In other words is (CONFIG_VIDEO_IPUV3=y && CONFIG_IMX_HDMI=n) an
> otherwise useful and valid configuration?

I would say no. You can have the display output over DPI or LVDS, with
HDMI non being required at all.

Francesco

