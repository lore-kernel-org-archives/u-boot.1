Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E95C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 11:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111C986A0A;
	Wed, 15 Nov 2023 12:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RBlfxieV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 050BD86BDF; Wed, 15 Nov 2023 12:15:17 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1BE8652B
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 12:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id B7F62B818BC;
 Wed, 15 Nov 2023 11:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8448C433C7;
 Wed, 15 Nov 2023 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700046914;
 bh=c0clK69P3jrYv6aqgLZ9sKvrogCoAfZE4fhzERJxUW8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RBlfxieVJcHgLwFCSunaJiy4Nyev7EJd0WtAiqRu4OV3oVnR2+Y/Unkj1na7zKGGT
 2Mg44BFtjz46I2KWnAS7tN5UeXHOG5ZHvwt1hutN5aWB3BKp2Sy+vPB/xt687fjW5O
 S+vMShn7eNo9cVaBJW2JPrQjcNu9Mvl8ocAUoVdfBUW7/lo8pmxjaUgzM20D+k4Jvp
 mmWxB6ND3m/wBIDvMmX9zr63qbznEVoOJjP35JvWwSmfB8s3a6+kUyBH4arYL2aPyN
 jXHVUMx+6bDxgFZSbPJDeFx0SDbwhTwXDbFrJIkW44fe4NV9ZBWHdX6Mj9LOq401ip
 9qKN9y6uRvoEA==
Message-ID: <2df85ff2-ada8-44ba-91b9-3ba3d299eeef@kernel.org>
Date: Wed, 15 Nov 2023 13:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] configs: am62ax_evm_a53_defconfig: Enable networking
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>,
 u-boot@lists.denx.de
References: <20231113145149.1926732-1-nm@ti.com>
 <20231113145149.1926732-5-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231113145149.1926732-5-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 13/11/2023 16:51, Nishanth Menon wrote:
> Enable networking
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  configs/am62ax_evm_a53_defconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
> index d0a34c75505d..c94708a7bf85 100644
> --- a/configs/am62ax_evm_a53_defconfig
> +++ b/configs/am62ax_evm_a53_defconfig
> @@ -42,7 +42,6 @@ CONFIG_SPL_OF_CONTROL=y
>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_SPL_MULTI_DTB_FIT=y
>  CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> -# CONFIG_NET is not set
>  CONFIG_SPL_DM=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_REGMAP=y
> @@ -51,6 +50,8 @@ CONFIG_SPL_OF_TRANSLATE=y
>  CONFIG_CLK=y
>  CONFIG_SPL_CLK=y
>  CONFIG_CLK_TI_SCI=y
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_TI_SCI_PROTOCOL=y
>  # CONFIG_GPIO is not set
>  # CONFIG_I2C is not set
> @@ -60,6 +61,10 @@ CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_ADMA=y
>  CONFIG_SPL_MMC_SDHCI_ADMA=y
>  CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_PHY_TI_DP83867=y
> +CONFIG_PHY_FIXED=y

Why do we need PHY_FIXED?

"
config PHY_FIXED
        bool "Fixed-Link PHY"
        help
          Fixed PHY is used for having a 'fixed-link' to another MAC with a direct
          connection (MII, RGMII, ...).
          There is nothing like autoneogation and so
          on, the link is always up with fixed speed and fixed duplex-setting.
          More information: doc/device-tree-bindings/net/fixed-link.txt
"


> +CONFIG_TI_AM65_CPSW_NUSS=y
> +CONFIG_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_SINGLE=y

-- 
cheers,
-roger
