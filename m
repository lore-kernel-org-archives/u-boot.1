Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47AEC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7C382B70;
	Thu, 12 Jun 2025 16:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="l/8x88ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3F882BD9; Thu, 12 Jun 2025 16:16:14 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A13A2828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 5FAAB1F920;
 Thu, 12 Jun 2025 16:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1749737770;
 bh=Z66aFhuKEabAd6WKTNQE8KCMVZioTzjxqMZmJ/rYDqY=; h=From:To:Subject;
 b=l/8x88ecziybCTay76+oTL+BBBEYqi9COsKlV4r1af/x2s3epChVi+qQZZJGeeSPH
 rcLrtnZFHJUWa3ZyrXhZLIHbjmIgLYD626fcTklsEWxZKD2pmQgSExv5pe8C2eOVgH
 28iTSBcfuW+BBqTswNBZ2f755rQtH3R6/Jl/5VDdcHRJwg7gBjByMgnI18EZoa8VdB
 tKptoBvWDDMhCFmhVDAMX0mrcEsy9EsTJf/lBNNi6umhjpJ1OaNQ1Njwt9xr8fgWBa
 8wsAMf3lKnCdT8pAQyZBZFwrxWduoFkZdklOw4IzeILV5lE96iTErPFQyjaRkTgqeM
 gJb+T6msCnNXw==
Date: Thu, 12 Jun 2025 16:16:06 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] toradex-smarc-imx8mp: add SPL_STACK size and
 SPL_HAVE_INIT_STACK
Message-ID: <20250612141606.GA367904@francesco-nb>
References: <20250612140923.20497-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612140923.20497-1-hiagofranco@gmail.com>
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

On Thu, Jun 12, 2025 at 11:09:23AM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> When the toradex-smarc-imx8mp_defconfig file was first added, SPL_STACK
> was set to 0x960000, but SPL_HAVE_INIT_STACK wasn't enabled.
> 
> This led to SPL_STACK being correctly dropped in commit 25fefa05d732
> ("configs: Resync with savedefconfig"), since SPL_HAVE_INIT_STACK was
> missing, which ended up making the board not boot.
> 
> Fix this by adding SPL_STACK back and making sure SPL_HAVE_INIT_STACK is
> enabled.
> 
> Fixes: dde53eae88d6 ("board: toradex: add Toradex SMARC iMX8MP")
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

