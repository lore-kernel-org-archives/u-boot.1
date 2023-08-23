Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787F9EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 04:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E40F864AD;
	Wed, 23 Aug 2023 06:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KhXFZpn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B4FA864AE; Wed, 23 Aug 2023 06:36:13 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3647864AB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37N4a1PP011601;
 Tue, 22 Aug 2023 23:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692765361;
 bh=GE0cnsE57B6km6S934SG8mSZYTAE9hZS9iwEevAai3c=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=KhXFZpn9c/qtpzmH41br339A3F2ISl529OWt3U38lLjO9epvOLSrgTNTk/5+twpte
 arALw4q6ParHpJXsgoJqsk1qSV6ol5eSDlzv5MTQCi4swGyLiIHn15mSQ3l6mMbSpR
 vMAydNLsi+SwNmQKAP6EzJgyqdb6xCtMG0f+sAS0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37N4a1Pp012625
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 23:36:01 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 23:36:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 23:36:01 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37N4ZvHI116147;
 Tue, 22 Aug 2023 23:35:58 -0500
Message-ID: <0348ec9c-a50e-1e03-2f7d-c7b82fefc1ed@ti.com>
Date: Wed, 23 Aug 2023 10:05:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <joe.hershberger@ni.com>,
 <robertcnelson@gmail.com>, <jkridner@beagleboard.org>,
 <r-gunasekaran@ti.com>, <srk@ti.com>, <trini@konsulko.com>,
 <s-vadapalli@ti.com>
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

Roger,

On 22/08/23 17:43, Roger Quadros wrote:
> Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
> PHY in the sense that it is non responsive over MDIO immediately
> after power-up/reset.
> 
> We need to either try multiple times or wait sufficiently long enough
> (couple of 10s of ms?) before the PHY begins to respond correctly.

Based on the datasheet at:
https://datasheet.lcsc.com/lcsc/1912111437_Realtek-Semicon-RTL8211F-CG_C187932.pdf
in the section 7.17. PHY Reset (Hardware Reset), it is stated that
software has to wait for at least 50 ms before accessing the PHY
registers. Is this why the for-loop in the code below tries for at most
5 times with a delay of 10 ms before the next try? If yes, then isn't it
better to move the delay into the realtek PHY driver at
drivers/net/phy/realtek.c
Shouldn't it be the PHY driver which ensures that any reads/writes to the PHY
registers are valid? It can ensure this by having a one time 50ms delay for the
very first access to the PHY registers.

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
>  
>  	if (!phydev) {
>  		dev_err(dev, "phy_connect() failed\n");

-- 
Regards,
Siddharth.
