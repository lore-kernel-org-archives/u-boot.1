Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5CACA1017
	for <u-boot@archiver.kernel.org>; Sun,  7 Sep 2025 07:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8DF8311B;
	Sun,  7 Sep 2025 09:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DEGvapWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511F481E13; Sun,  7 Sep 2025 09:18:24 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB18A81E13
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 09:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5877I9Zw4065066;
 Sun, 7 Sep 2025 02:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757229489;
 bh=5hVMVckUGLDEw5atycW2t4fG+M2f2nl9DvgZ+T5Lmag=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=DEGvapWFJFTIGisDHvPgCNeF89/9yGMY8PohTun1hl1+7X2m9G8m+eKv1mtwogSwr
 ize5zbk3A3JWECP9WnfWHtKWqSkXRvKr5+VtB5SreitC6U4xvsYLafSfVPnoCz0Ks6
 0xB0kvxnxEkKyKaj6Ib6VeFX5x/x0ppsT/JZbd0g=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5877I9GE2099288
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Sun, 7 Sep 2025 02:18:09 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 02:18:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 02:18:09 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5877I7Zj3226085;
 Sun, 7 Sep 2025 02:18:08 -0500
Date: Sun, 7 Sep 2025 12:48:07 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Roger Quadros <rogerq@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] phy: Reset init count on phy exit failure
Message-ID: <0924d46e-9275-461b-bdad-7341f844aea4@ti.com>
References: <20250906230052.582621-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250906230052.582621-1-marek.vasut@mailbox.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Sun, Sep 07, 2025 at 01:00:44AM +0200, Marek Vasut wrote:

Hello Marek,

> In case the PHY exit callback reports failure, reset init_count to 0 anyway,
> so the next attempt at PHY initialization might try to reinitialize the PHY
> and restore it to normal operation.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/phy/phy-uclass.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
> index 714be123856..f8d4fb3b41b 100644
> --- a/drivers/phy/phy-uclass.c
> +++ b/drivers/phy/phy-uclass.c
> @@ -274,7 +274,7 @@ int generic_phy_exit(struct phy *phy)
>  {
>  	struct phy_counts *counts;
>  	struct phy_ops const *ops;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!generic_phy_valid(phy))
>  		return 0;
> @@ -292,12 +292,11 @@ int generic_phy_exit(struct phy *phy)
>  		if (ret) {
>  			dev_err(phy->dev, "PHY: Failed to exit %s: %d.\n",
>  				phy->dev->name, ret);
> -			return ret;

I assume that a generic_phy_reset() may be required for generic_phy_init()
to succeed after generic_phy_exit() has failed. While I understand that
the current patch allows retrying, this may not be complete in allowing
users to make use of the change being brought about by this patch.
Nevertheless, the change being proposed in this patch looks good to me.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

>  		}
>  	}
>  	counts->init_count = 0;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  int generic_phy_power_on(struct phy *phy)

Regards,
Siddharth.
