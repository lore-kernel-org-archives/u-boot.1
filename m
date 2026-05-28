Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9632ACD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 16:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4CF83FF5;
	Thu, 28 May 2026 18:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="bp0Xspms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59E9846A5; Thu, 28 May 2026 18:25:06 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB5F839A8
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 18:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 6018C22799;
 Thu, 28 May 2026 18:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1779985500;
 bh=lPYqouECsxBDWl9N2HaSkUfpLP0hEJDf4r/j4JZe0cs=; h=From:To:Subject;
 b=bp0XspmsAYaMQ4pR2NTn5MVo+dxab5ai3+mCSIos4eDf8GT2xEf/DOpmYCckF2xHf
 5QLSid8Xfi0GDcEvufKsmxspP6HadOPXDedNN1d1YUaaiwJRDE2RibWyVD8KqDf+g9
 NnY5XNZoRkWKtrtIW/2/LDrDUoFCCoI5MSmwehmTofzL4yyHkNJRl0Dfuapy2qo+cY
 4Vdk3IJG2OMVpgY1XrRa4CHgC5f9hdn0M/BW5fBgIIeqpmphrTy27O2bXvc1umaA8V
 +p8FxBaM1aZLcXet4Wqdn9CHPPp6JhGYv/oHZ/J9yX+mm4RU1XhzbthQFlhrDiPmi+
 MqXg7PnDxI1Hw==
Date: Thu, 28 May 2026 18:24:56 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@oss.nxp.com>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Subject: Re: [PATCH v1] serial: lpuart: Fix RX FIFO Enable bitmask
Message-ID: <20260528162441.GA6074@francesco-nb>
References: <20260528134919.10031-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528134919.10031-1-ghidoliemanuele@gmail.com>
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

On Thu, May 28, 2026 at 03:49:06PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> The Receive FIFO Enable (RXFE) field in the LPUART FIFO register is
> bit 3 on all supported architectures. The define has been wrong since
> it was introduced: for non-i.MX8/i.MXRT it set bit 6, which on LS102xA
> is read-only-as-zero, so the bug went unnoticed.
> 
> NXP confirmed bit 3 is correct everywhere, so drop the ARCH-based
> selection.
> 
> Link: https://github.com/nxp-imx/uboot-imx/commit/9498bcc514737269bb0ca436f775460741ab8199
> Link: https://lore.kernel.org/u-boot/dc163ea7-9063-4dfb-a39a-e643c0bcccf1@oss.nxp.com/
> Fixes: 6209e14cb026 ("serial: lpuart: add 32-bit registers lpuart support")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

