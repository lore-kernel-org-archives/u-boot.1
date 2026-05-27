Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C8DCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E5A8341A;
	Wed, 27 May 2026 14:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YWbRJ3Br";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1D484671; Wed, 27 May 2026 14:17:27 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF82F8056B
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gQTC76y4nz9v9c;
 Wed, 27 May 2026 14:17:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779884244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYx+YzwphHQmlaFHd3reMiOkBqKHYoMpOzdwYR5Sb5Y=;
 b=YWbRJ3Br4IU0oO6nobv2zYOUk2nuGJehhfXaoA12m+CJxvMcMrlEr99a+CVRMoHTUz5nWu
 9uvGm1JPu1ypmr0uE6frupKmBCu9Kq8Ak3M9K0qfks+EaGiCA72cTD2ul48JZl2cUKOstM
 DMegFGOqUu1ih5veZhiwaBp5hNzQ/esFiMdEz1IxrRXW+jkKKKJlWtWyfoqqV2cjtLto2+
 1mxD8GWG4K2/m/8nvGOTBLILy8kl/gOIhEEerAhX25bBxN/NGhnvBSfAUUIb9sX5c9bi/R
 u2iw++lvgle3i/d7sjVK/Oyt6mY8mjzoSzLBwk0i7lHAGTJ3gWN315/fQpnJpg==
Message-ID: <3d60d412-1dfa-4479-bc79-122f320abf4d@mailbox.org>
Date: Wed, 27 May 2026 14:17:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] phy: cadence: Use device API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
 <20260526-devfdt-phy-v1-3-908ff621dea4@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260526-devfdt-phy-v1-3-908ff621dea4@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d01187b15cca0d11020
X-MBO-RS-META: 3wmeaw16sgb6fdtjh8itb4m6wuer5s47
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

On 5/26/26 08:39, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_remap_addr_index() and dev_read_addr_size_index() which support
> both live device tree and flat DT backends, avoiding direct dependency on
> devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/phy/cadence/phy-cadence-sierra.c  | 4 ++--
>   drivers/phy/cadence/phy-cadence-torrent.c | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index bd7ab9d1b77..9f8a6d8d43d 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -1068,12 +1068,12 @@ static int cdns_sierra_phy_probe(struct udevice *dev)
>   
>   	sp->dev = dev;
>   
> -	sp->base =  devfdt_remap_addr_index(dev, 0);
> +	sp->base = dev_remap_addr_index(dev, 0);
>   	if (!sp->base) {
>   		dev_err(dev, "unable to map regs\n");
>   		return -ENOMEM;
>   	}
> -	devfdt_get_addr_size_index(dev, 0, (fdt_size_t *)&sp->size);
> +	dev_read_addr_size_index(dev, 0, (fdt_size_t *)&sp->size);
>   
>   	/* Get init data for this PHY */
>   	data = (struct cdns_sierra_data *)dev_get_driver_data(dev);
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 933533b2b0b..814aff15070 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -791,10 +791,10 @@ static int cdns_torrent_phy_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> -	cdns_phy->sd_base = devfdt_remap_addr_index(dev, 0);
> -	if (IS_ERR(cdns_phy->sd_base))
> -		return PTR_ERR(cdns_phy->sd_base);
> -	devfdt_get_addr_size_index(dev, 0, (fdt_size_t *)&cdns_phy->size);
> +	cdns_phy->sd_base = dev_remap_addr_index(dev, 0);
> +	if (!cdns_phy->sd_base)
> +		return -EINVAL;
> +	dev_read_addr_size_index(dev, 0, (fdt_size_t *)&cdns_phy->size);
>   
>   	dev_for_each_subnode(child, dev)
>   		subnodes++;
> 

