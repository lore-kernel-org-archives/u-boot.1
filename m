Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B04AF588C2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 685D184312;
	Mon, 20 Apr 2026 14:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tdayIP3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDAE8431E; Mon, 20 Apr 2026 14:31:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53A384366
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3149843E8C;
 Mon, 20 Apr 2026 12:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8464C2BCB6;
 Mon, 20 Apr 2026 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776688308;
 bh=dg4spvgBzBYTcw9BQXGS9eqVUzmbVXv+nkpyyWt23fY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tdayIP3m2grCJvTx6v2NM6XdwXzitT7OxPAdfbaM+kStuCMDP9pEab6uuhsa3X7et
 eCcJQp6UcgQrclijXUaYDXhBvngqXnmc8Fb0yV8JD/0VmiuPQ/RIEa3bVpbgZnEcCm
 T+i9HU+LvKj4oVZTHBfXEOM8zxLxzG1mirj+cl5CYmzuz19DzMJtA/rhBuZQpHOnsJ
 LfiyJXf6o8Ua5nLd+3KvYsrz5AWtC0z0qMbFEbWZBvyIvAP2sZt419NJvSS5P2H/bJ
 xXviJA8Xv6UUeq+wAdg1fZuP/RwuquN4y+b4hy+ErPVXj7rR/KRySV+W8WnpRj35yZ
 XZLIaNan8nSag==
Date: Mon, 20 Apr 2026 18:01:41 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com,
 loic.poulain@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2] mmc: msm_sdhci: Use max-frequency to get clock rate
Message-ID: <aeYcrW_rJ_ehVYb7@sumit-xelite>
References: <20260416051151.2825532-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416051151.2825532-1-varadarajan.narayanan@oss.qualcomm.com>
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

On Thu, Apr 16, 2026 at 10:41:51AM +0530, Varadarajan Narayanan wrote:
> msm_sdc_clk_init() uses clock-frequency to get the clock rate for SDC
> clocks. However, the DT files seem to use max-frequency for the same.
> Since msm_sdc_clk_init() doesn't find clock-frequency in the DT, it sets
> 201500000 as the clock rate and this results in timeout errors on IPQ
> platforms.
> 
> Additionally, clock-frequency is not DT bindings compliant. Hence, get
> clock rate using DT bindings compliant max-frequency.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/mmc/msm_sdhci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 66f3cf2de4f..aaa87923604 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -71,8 +71,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>  
>  	var_info = (void *)dev_get_driver_data(dev);
>  
> -	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
> -	if (ret)
> +	if (ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
>  		clk_rate = 201500000;
>  
>  	ret = clk_get_bulk(dev, &prv->clks);
> -- 
> 2.34.1
> 
