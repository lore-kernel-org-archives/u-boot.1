Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE12C282DE
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 19:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34AEB8122F;
	Wed,  5 Mar 2025 20:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UvHb/1Q2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="APMtTjq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62955812BC; Wed,  5 Mar 2025 20:56:25 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6096D8121A
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 20:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z7NbW0srgz9sjn;
 Wed,  5 Mar 2025 20:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxjvFU5rXudpV/CB5HhPo/KWhoiu3G3n9hxwxx/+1+M=;
 b=UvHb/1Q2Jgz4+U/DXzcXTJ5fGi2w1cphpb4LxNoUIot7qspeIQrwT4GdKHYMytfB7KLGnh
 T+Wg53CdqGxz06zSzuBnry8pdL/scwz4XMm6raJXDJsWyL88uauuwRjhaXwfxFOEPMhNDr
 q2DX6eIFMvJ+qBg3GHW0hK2GGsnGrC0O3nY32mL45sRoIi1MGQmnOD4ox3/b3qzW/onzwW
 owKxDXbv8Lg4kOSgvX89KlJ+SDuxgfzhAjXnkg/6Vg6j3IHw7leryHjlCfM7ElvGGJvxok
 Yt/J/3H4IKAWI/pt8SfjDTuLr9yEJrAOWFFeOMa0hvd0fRaLUH0GYv3fnnpn1w==
Message-ID: <6e0ede59-6923-463e-bfbc-23cba4c73ced@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxjvFU5rXudpV/CB5HhPo/KWhoiu3G3n9hxwxx/+1+M=;
 b=APMtTjq6liNo37aCDqMEvczevIvhRimRkr0ffUM8Zamk1DMbkQE/fkplAB9bB4vn1YDzGZ
 TryPi/UtOn9TnCtfvAC4GnkqOIpMefJQkoQWg2xwkPhJmyUj+UWjacTUrKh5C4layiFVzu
 uRsZ7lDsZOyHso3AWg/oCApGw8eOVaGFgHJB1Vc6NkjrYNp6Qu89bNhRklpBPQqI+NC18q
 OOrCTBMpMgB3XzPPCaQKVuHNDBn1ZVd6/lVYQn2O+1a5e7oEtBUdR/sZ+inuBX0JYvrLEo
 p8oDFgedrpHj8M/6rq/oGEiKDfzDmgvaN8IzT3uCPL4TMD1ekUnYh9KcFMc1GQ==
Date: Wed, 5 Mar 2025 20:55:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] net: ravb: Fix error handling in ravb_probe
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
 <20250304200712.92514-4-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250304200712.92514-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 61855349d29d56f8aa7
X-MBO-RS-META: 677wamncxc1f8cug7a7dnudob7ccjmgb
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

On 3/4/25 9:07 PM, Paul Barker wrote:
> In ravb_probe(), we were missing a couple of things in the error
> handling path:
> 
>    * We must unregister the MDIO bus before freeing the corresponding
>      struct mii_dev instance to avoid the potential for use-after-free
>      bugs.
> 
>    * We must free the resources acquired by clk_get_bulk() even if the
>      clocks have not yet been enabled.
> 
> Fixes: 8ae51b6f324e ("net: ravb: Add Renesas Ethernet RAVB driver")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   drivers/net/ravb.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index 6bd94cf6bb1b..83cf6e0d19f4 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c
> @@ -591,7 +591,7 @@ static int ravb_probe(struct udevice *dev)
>   
>   	ret = clk_get_bulk(dev, &eth->clks);
>   	if (ret < 0)
> -		goto err_mdio_alloc;
> +		goto err_clk_get;
>   
>   	mdiodev = mdio_alloc();
>   	if (!mdiodev) {
> @@ -613,23 +613,25 @@ static int ravb_probe(struct udevice *dev)
>   	/* Bring up PHY */
>   	ret = clk_enable_bulk(&eth->clks);
>   	if (ret)
> -		goto err_mdio_register;
> +		goto err_clk_enable;
>   
>   	ret = ravb_reset(dev);
>   	if (ret)
> -		goto err_mdio_reset;
> +		goto err_clk_enable;

Shouldn't this also assure clk_disable_bulk() is called ?

>   	ret = ravb_phy_config(dev);
>   	if (ret)
> -		goto err_mdio_reset;
> +		goto err_clk_enable;

DTTO here ?

>   
>   	return 0;
>   
> -err_mdio_reset:
> -	clk_release_bulk(&eth->clks);
> +err_clk_enable:
> +	mdio_unregister(mdiodev);
>   err_mdio_register:
>   	mdio_free(mdiodev);
>   err_mdio_alloc:
> +	clk_release_bulk(&eth->clks);
> +err_clk_get:
>   	unmap_physmem(eth->iobase, MAP_NOCACHE);
>   	return ret;
>   }


-- 
Best regards,
Marek Vasut
