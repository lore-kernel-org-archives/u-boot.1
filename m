Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FD3CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 15:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13E38407D;
	Thu, 11 Jun 2026 17:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ffg2AtcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D97E83FEC; Thu, 11 Jun 2026 17:42:03 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC19283FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 17:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id F15141F947;
 Thu, 11 Jun 2026 17:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1781192519;
 bh=e3GWl3sA2yLIWT0sluLy3tpx+Wi724TA612PAfTu2yM=; h=From:To:Subject;
 b=ffg2AtcHUjpYranFUV8bjLsaWTNVTYHInOJgMT8SdQPANauAbj+XZVTylHmwGnzQr
 0g0fjZm+i7K8wy7YKmrVhNwffe30NV1rShfRNeds+tKNJw2uT0B85Mb2Aq9OrvctpW
 DeZ+b8qnSleY5t7MyCtPdii8eVLDWwz+5NWe2D/XkMh4HW42tQbgg5Wx8pgxWt12LJ
 qm1f5z/UHkZz63lB9id7HGnRukru0Jowi8YTvkvvGBfD6Gnwn8SAGqJigyaRfy/vSa
 9WueN4ywKLZKatXkOedkH+7vrte4fC36PmbV8iRrHLtY11Xcb5qElCNuInEnmc239L
 L4kr2WMzYgKJw==
Date: Thu, 11 Jun 2026 17:41:55 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH] board: toradex: add initial support for aquila imx95
Message-ID: <20260611154155.GA4301@francesco-nb>
References: <20260611-aquila-imx95-v1-1-6a13d7190e83@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-aquila-imx95-v1-1-6a13d7190e83@toradex.com>
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

On Thu, Jun 11, 2026 at 03:47:48PM +0200, Franz Schnyder wrote:
> From: Franz Schnyder <franz.schnyder@toradex.com>
> 
> Add initial U-Boot support for Aquila iMX95 SoM.
> 
> Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/nxp-imx95
> Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

