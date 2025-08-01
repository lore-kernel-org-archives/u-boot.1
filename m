Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAA0C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 15:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D82A83A92;
	Fri,  1 Aug 2025 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9012183ABA; Fri,  1 Aug 2025 17:51:15 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75BA082AC4
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 17:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.147.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id DB289340B10;
 Fri, 01 Aug 2025 15:51:06 +0000 (UTC)
Date: Fri, 1 Aug 2025 23:50:53 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 linux-sunxi@lists.linux.dev, Mikhail Kalashnikov <iuncuim@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/2] sunxi: a523: enable Ethernet
Message-ID: <20250801155053-GYA919340@gentoo>
References: <20250801002726.8924-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801002726.8924-1-andre.przywara@arm.com>
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

Hi Andre,

On 01:27 Fri 01 Aug     , Andre Przywara wrote:
> The first of the two Ethernet controllers in the Allwinner A527/T527
> SoCs is compatible to the IP used in the A64 SoC, which our MAC driver
> already supports. Since the recent DT update brought us the DT
> description of the network interface, enable the driver and thus
> Ethernet functionality on the two boards that work.
> Patch 1/2 fixes the function name for the RGMII pins in the pinctrl
> driver, while patch 2/2 just enables building the sun8i-emac driver.
> 
> Please have a look and test!
> 
Thanks for pushing this

Tested-by: Yixun Lan <dlan@gentoo.org> # Radxa A5E

> Cheers,
> Andre
> 
> Andre Przywara (2):
>   pinctrl: sunxi: a523: change Ethernet pin function name
>   sunxi: a527: radxa/avaota: enable Ethernet
> 
>  configs/avaota-a1_defconfig           | 2 ++
>  configs/radxa-cubie-a5e_defconfig     | 2 ++
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> -- 
> 2.46.3
> 

-- 
Yixun Lan (dlan)
