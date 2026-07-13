Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CA3C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 06:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F99F848EB;
	Mon, 13 Jul 2026 08:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ETrjZACs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE6684A0F; Mon, 13 Jul 2026 08:05:35 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52FB8467B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id A40DA1FA47;
 Mon, 13 Jul 2026 08:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1783922731;
 bh=QD0oMnvSnW52WV57z5qvwkaGpqUK/h6bkuSIF/W9glA=; h=From:To:Subject;
 b=ETrjZACsYUOLBGvp6ONQbQoI/gfOH2zmBdNbD6hBljsSyFfZKDEfqYxIO/knYroQ2
 PvzV0I7dk7ZJIIgRhevCTN4lvkiHJM0LM8NmZH+lKdMlbsFV8VKjwuSREi9KqTuE/u
 AHOxsoqHJ5H7/1yUK8ifVx+Qyggle0GIxIDJDaTZa5vHM/1LOxqtaRibR0ftD2D51c
 sAstDeWnYp2xgOBUC9TKA7MlYMsy5G2hgMoxOZc1ZksaG0oXrIZ8bjs2uMKOzWbIrt
 edn52wihycrkSRqw6UvATcbjtaMYu0+3I5/1ABPNgaN9yWlSY9xeE2ZvNjCS/NmnNR
 hhPtumOws7+Mg==
Date: Mon, 13 Jul 2026 08:05:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] board: toradex: smarc-imx95/aquila-imx95: detect RAM
 sizes
Message-ID: <20260713060526.GA13102@francesco-nb>
References: <20260710133913.388770-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710133913.388770-1-ghidoliemanuele@gmail.com>
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

On Fri, Jul 10, 2026 at 03:39:07PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Use alias-based RAM probing to detect different memory configurations
> on Toradex iMX95 modules using LPDDR5. The address wrap-around is not
> linear on LPDDR5 modules: address bits above the module capacity
> alias back with some low address bits XORed (bit 32 -> XOR 0xc000),
> as measured on 4GB and 8GB modules.
> 

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

