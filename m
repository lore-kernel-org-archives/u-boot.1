Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F5DEE49AD
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 04:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2108648C;
	Wed, 23 Aug 2023 06:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LAwQjmH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC078863DE; Wed, 23 Aug 2023 06:54:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0379886377
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37N4s8bu072641;
 Tue, 22 Aug 2023 23:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692766448;
 bh=ubvACQJhjZD9wKvdAQ2FppYXwQ7UVPeobikVDiy9b0s=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=LAwQjmH5gNAxMnWIbYaCLgmMYZJLFvMBYehneW5k7spXYkeihPbnE6+Ggzsi8CZgj
 TxV3WDd/iXXLlhRVpxLPzyS4ct3aXCAqq7fgIUgz7RSD2cPRhl+PkXT+eVbdokiLk3
 xpMG3ebKAqjCPAYnndvfkEUHZNFPJFnDShM6Eaw0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37N4s8sP058578
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 23:54:08 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 23:54:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 23:54:08 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37N4s4nw007456;
 Tue, 22 Aug 2023 23:54:05 -0500
Message-ID: <035bd59d-b70d-17fa-06a9-70fd3d422261@ti.com>
Date: Wed, 23 Aug 2023 10:24:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <joe.hershberger@ni.com>,
 <robertcnelson@gmail.com>, <jkridner@beagleboard.org>,
 <r-gunasekaran@ti.com>, <srk@ti.com>, <trini@konsulko.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH 2/2] net: phy: Change "PHY not found" message to debug()
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-3-rogerq@kernel.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230822121350.51324-3-rogerq@kernel.org>
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



On 22/08/23 17:43, Roger Quadros wrote:
> Some boards (e.g. Beagleplay) need multiple attempts to detect the PHY
> and the multiple "PHY not found" prints are not nice.

I tried grepping for calls to "phy_connect" across the drivers present in
drivers/net. Most of them simply return -ENODEV on failure. The ones
which add prints indicating failure, don't use debug(). For this reason,
I believe that the drivers which don't have any prints in case of
failure might be relying on the printf() within phy_connect() to indicate
failure. Therefore, if the printf() is being changed to debug() in
phy_connect(), maybe all the drivers which currently return -ENODEV,
should have a print added to them as a part of this patch.

> 
> Change them to debug().
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/phy/phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index ae21acb059..3a524bcd81 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -928,7 +928,7 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>  	if (phydev)
>  		phy_connect_dev(phydev, dev, interface);
>  	else
> -		printf("Could not get PHY for %s: addr %d\n", bus->name, addr);
> +		debug("Could not get PHY for %s: addr %d\n", bus->name, addr);
>  	return phydev;
>  }
>  

-- 
Regards,
Siddharth.
