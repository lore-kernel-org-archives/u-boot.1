Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0357AC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40692862EB;
	Thu, 24 Aug 2023 20:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TE9Dzzbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D3486401; Thu, 24 Aug 2023 20:04:43 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD6D852DB
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OI4ZNS125883;
 Thu, 24 Aug 2023 13:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692900275;
 bh=FFq372DUTj3yJx5fjnsJCov130okrtlXSf++s3nJEFI=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=TE9DzzbcZzlxqWDzrgbPEICjKUPltZN+b06BvzfdE0L1WrMjiy2tvAx3IYR5fDwuR
 99pWhfDcFDfAwTOLV4D39eMZfRJqGYQUzsPZQ0dAwPH9fQvXne+jXEfGcFlV4ZgVTw
 rlZuU2MyJbdWdt2MPGsnuQ0ux+8ZAaXEWqwlPmuQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OI4Z8F018477
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 13:04:35 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 13:04:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 13:04:34 -0500
Received: from [10.249.131.186] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OI4UYM048198;
 Thu, 24 Aug 2023 13:04:31 -0500
Message-ID: <12738ca9-ac8c-b587-c0bf-c8abc8fd3f48@ti.com>
Date: Thu, 24 Aug 2023 23:34:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
CC: <nm@ti.com>, <joe.hershberger@ni.com>, <robertcnelson@gmail.com>,
 <jkridner@beagleboard.org>, <r-gunasekaran@ti.com>, <srk@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
To: Roger Quadros <rogerq@kernel.org>
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230822121350.51324-2-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hello Roger,

On 22-08-2023 17:43, Roger Quadros wrote:
> Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
> PHY in the sense that it is non responsive over MDIO immediately
> after power-up/reset.
> 
> We need to either try multiple times or wait sufficiently long enough
> (couple of 10s of ms?) before the PHY begins to respond correctly.
> 
> One theory is that the PHY is configured to operate on MDIO address 0
> which it treats as a special broadcast address.
> 
> Datasheet states:
> "PHYAD (config pins) sets the PHY address for the device.
> The RTL8211F(I)/RTL8211FD(I) supports PHY addresses from 0x01 to 0x07.
> Note 1: An MDIO command with PHY address=0 is a broadcast from the MAC;
> each PHY device should respond."
> 
> This issue is not seen with the other PHY (different make) on the board
> which is configured for address 0x1.
> 
> As a woraround we try to probe the PHY multiple times instead of giving
> up on the first attempt.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ti/am65-cpsw-nuss.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
> index 51a8167d14..4f8a2f9b93 100644
> --- a/drivers/net/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> @@ -27,6 +27,7 @@
>  #include <syscon.h>
>  #include <linux/bitops.h>
>  #include <linux/soc/ti/ti-udma.h>
> +#include <linux/delay.h>
>  
>  #include "cpsw_mdio.h"
>  
> @@ -678,14 +679,22 @@ static int am65_cpsw_phy_init(struct udevice *dev)
>  	struct am65_cpsw_priv *priv = dev_get_priv(dev);
>  	struct am65_cpsw_common *cpsw_common = priv->cpsw_common;
>  	struct eth_pdata *pdata = dev_get_plat(dev);
> -	struct phy_device *phydev;
>  	u32 supported = PHY_GBIT_FEATURES;
> +	struct phy_device *phydev;
> +	int tries;
>  	int ret;
>  
> -	phydev = phy_connect(cpsw_common->bus,
> -			     priv->phy_addr,
> -			     priv->dev,
> -			     pdata->phy_interface);
> +	/* Some boards (e.g. beagleplay) don't work on first go */
> +	for (tries = 1; tries <= 5; tries++) {
> +		phydev = phy_connect(cpsw_common->bus,
> +				     priv->phy_addr,
> +				     priv->dev,
> +				     pdata->phy_interface);
> +		if (phydev)
> +			break;
> +
> +		mdelay(10);
> +	}

After rethinking about the above implementation and the second patch of
this series, the second patch could be dropped altogether if the
following implementation is acceptable:

phydev = phy_connect(cpsw_common->bus,
		     priv->phy_addr,
		     priv->dev,
		     pdata->phy_interface);

if (!phydev) {
	/* Some boards (e.g. beagleplay) don't work on first go */
	mdelay(50);
	phydev = phy_connect(cpsw_common->bus,
			     priv->phy_addr,
			     priv->dev,
			     pdata->phy_interface);
}

if (!phydev) {
	dev_err(dev, "phy_connect() failed\n");
...

With this, there would be at most one "PHY not found" print, which
should be fine. The mdelay value of 50 could be replaced with a
sufficiently large value which guarantees success for Beagleplay.

-- 
Regards,
Siddharth.
