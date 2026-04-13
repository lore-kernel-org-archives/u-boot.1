Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB04BF34C40
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 11:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47283839DF;
	Mon, 13 Apr 2026 13:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BQ/Oi9EZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EA783F75; Mon, 13 Apr 2026 13:57:54 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29DA839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C3A326091C;
 Mon, 13 Apr 2026 11:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09783C19421;
 Mon, 13 Apr 2026 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776081471;
 bh=P+tgrOGL4d7TqY0KMVyxOlhdrMleRYqb3K+VCwx9+yc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BQ/Oi9EZR4zidCTjZV0Pk9aj4pfnKoPCDJu9HHQPU0IAVKI1GJcdBEfs2WK9cpsj3
 XlhFDV+Dv0fY+bAcEkZXAUrJ7/QVJzaWi340EFh9oYKENCSdXds5lCC4LcWa0mu/gd
 7f+cWO2xgN7JHCpRU01rU3UNlNaL8/rEh3/0BYGTJr017YEkXrX/3U4+jOOYzA1LiF
 5SGxt7j+PdxbYwnpqqn+hB0MVxdgKa6/Juli/AgQBLsHbIIw+zSqpDUxT4F23rs4/n
 lNX7/sxBerC6hqHYSD8LvwRKOD7b/3tIOrr3hRkzBWAvG4p8K0yH/LelhaQrw68daw
 xrOHnZ9qoMz0Q==
Date: Mon, 13 Apr 2026 17:27:44 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com,
 loic.poulain@oss.qualcomm.com, patrice.chotard@foss.st.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: msm_sdhci: Use max-frequency to get clock rate
Message-ID: <adzaOC0mgP5vfZUr@sumit-xelite>
References: <20260409070620.3655875-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409070620.3655875-1-varadarajan.narayanan@oss.qualcomm.com>
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

On Thu, Apr 09, 2026 at 12:36:20PM +0530, Varadarajan Narayanan wrote:
> msm_sdc_clk_init() uses clock-frequency to get the clock rate for SDC
> clocks. However, the DT files seem to use max-frequency for the same.
> Since msm_sdc_clk_init() doesn't find clock-frequency in the DT, it sets
> 201500000 as the clock rate and this results in timeout errors on IPQ
> platforms. Hence, try to get max-frequency if clock-frequency is not
> present.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/mmc/msm_sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 66f3cf2de4f..2e6120f18ff 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -71,8 +71,8 @@ static int msm_sdc_clk_init(struct udevice *dev)
>  
>  	var_info = (void *)dev_get_driver_data(dev);
>  
> -	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
> -	if (ret)
> +	if (ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate)) &&
> +	    ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
>  		clk_rate = 201500000;

Looks like clock-frequency is just a leftover from legacy DT nodes. Now
on Qcom platforms, upstream DT is used. So let's just add max-frequency
check compliant with DT bindings and drop check for clock-frequency.

-Sumit

>  
>  	ret = clk_get_bulk(dev, &prv->clks);
> -- 
> 2.34.1
> 
