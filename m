Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B1CC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F84A8811C;
	Thu, 28 Mar 2024 12:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZLiG6bx4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A799C88148; Thu, 28 Mar 2024 12:45:48 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 256828810E
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 12:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SBjfRw000380;
 Thu, 28 Mar 2024 06:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711626341;
 bh=w/0L27wQeYNmXhk2AXBoIfykU5ZCWMhrhjNcXWZCFkM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ZLiG6bx4nBcGsvCAXFnwCVtTR00T8j8LTNSEcXH8wkCEvd7evR/jw7mHD3sDCPoTp
 HPhDTrxMEvr2bwubdxV9P+5p9amEQKMu3nt78m6WN57cpvpyXwuskYRd5o5fxARHXh
 MDUq0kVEVRiS0fYfZ2amTVd288gz0crkCwGG6ZEw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SBjfwk118394
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Mar 2024 06:45:41 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 06:45:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 06:45:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SBjfbw111798;
 Thu, 28 Mar 2024 06:45:41 -0500
Date: Thu, 28 Mar 2024 06:45:41 -0500
From: Nishanth Menon <nm@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: <u-boot@lists.denx.de>, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Suman Anna <s-anna@ti.com>, Roger
 Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v2] net: ti: am65-cpsw-nuss: handle missing PHY in
 am65_cpsw_phy_init() gracefully
Message-ID: <20240328114541.pep2fszctvzc3qqt@slept>
References: <20240328062914.486999-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240328062914.486999-1-alexander.sverdlin@siemens.com>
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

On 07:29-20240328, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> am65_cpsw_ofdata_parse_phy() tries to handle the case when PHY is not
> specified in DT gracefully:
> 
> am65_cpsw_nuss_port ethernet@8000000port@1: can't parse phy-handle port 1 (-2)
> 
> am65_cpsw_mdio_init() in turn is prepared for this, checks
> if priv->has_phy == 0 and bails out (leaving cpsw_common->bus == NULL).
> 
> am65_cpsw_phy_init() however is not prepared for this and calls
> phy_connect(cpsw_common->bus, ...) unconditionally, which leads to:
> 
> "Synchronous Abort" handler, esr 0x8600000d, far 0x0
> elr: ffffffff808ab000 lr : 000000008083bde4 (reloc)
> 
> where lr points to the instruction right after bus->read() in get_phy_id().
> 
> Fixes: 9d0dca1199d1 ("net: ethernet: ti: Introduce am654 gigabit eth switch subsystem driver")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> v2: rewritten subject; "is turn" -> "in turn" further down in message body
> 
>  drivers/net/ti/am65-cpsw-nuss.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
> index 6da018c0f9d5..d1e452b6b43c 100644
> --- a/drivers/net/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> @@ -722,6 +722,9 @@ static int am65_cpsw_phy_init(struct udevice *dev)
>  	u32 supported = PHY_GBIT_FEATURES;
>  	int ret;
>  
> +	if (!priv->has_phy || !cpsw_common->bus)
> +		return 0;
> +
>  	phydev = phy_connect(cpsw_common->bus,
>  			     priv->phy_addr,
>  			     priv->dev,
> -- 
> 2.44.0
> 

Reviewed-by: Nishanth Menon <nm@ti.com>


Thanks for fixing this.

Btw, this no longer applies on next. only applies on master. Depending
on where Tom would like to apply this change, might need a rebase.

CC Roger.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
