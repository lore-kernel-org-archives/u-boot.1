Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A61C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C55F8815E;
	Thu, 28 Mar 2024 12:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gk41d9fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4559880B9; Thu, 28 Mar 2024 06:55:04 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D968C87B89
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 06:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S5swuw025736;
 Thu, 28 Mar 2024 00:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711605298;
 bh=Lm8unvzDiZnCkkbN/D6CQOExyN9S3jcR3KTqQFoIoxs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gk41d9fr1411Jqm6OffBRQx4/6G8yvl8qdtP8xtoH9w3yc3eHzGvIATKXvmuBNaL+
 hL/RIJaL/BfK60HfdlvoB/W2rsE7HItZYqkyU3vwCWVb8Uk93Lx1XTjKgBnWHzE5ZK
 uq1VsqVNNEq1YMS05Fd2Wel/OasBDQShAR4NXea8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S5swqp013677
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Mar 2024 00:54:58 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 00:54:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 00:54:58 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S5svsR094476;
 Thu, 28 Mar 2024 00:54:57 -0500
Date: Thu, 28 Mar 2024 11:24:56 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: <u-boot@lists.denx.de>, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: Don't crash in
 am65_cpsw_phy_init()
Message-ID: <f59444a4-05ff-42b4-b2a6-1c287546a4bf@ti.com>
References: <20240327170941.436610-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240327170941.436610-1-alexander.sverdlin@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 28 Mar 2024 12:43:31 +0100
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

On Wed, Mar 27, 2024 at 06:09:40PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

In the $subject, "Don't crash.." seems to indicate the consequence of
not handling the absence of PHYs gracefully within am65_cpsw_phy_init().
So the subject should probably be reworded to emphasize this instead.
Something like:

net: ti: am65-cpsw-nuss: Update am65_cpsw_phy_init() to handle PHY absence

The rest of the patch looks good to me. With the subject reworded,

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

> 
> am65_cpsw_ofdata_parse_phy() tries to handle the case when PHY is not
> specified in DT gracefully:
> 
> am65_cpsw_nuss_port ethernet@8000000port@1: can't parse phy-handle port 1 (-2)
> 
> am65_cpsw_mdio_init() is turn is prepared for this, checks
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
