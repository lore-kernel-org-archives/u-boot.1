Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7051DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F259D88352;
	Mon, 22 Apr 2024 10:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NMDmp4Hj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37C9A88379; Mon, 22 Apr 2024 10:39:58 +0200 (CEST)
Received: from mail-m25475.xmail.ntesmail.com (mail-m25475.xmail.ntesmail.com
 [103.129.254.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7759388346
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NMDmp4HjtIDaw2Au3XMa6Z+CtFhhh/mNfdw44yHPrmI9nxFiRXLODFkBAzsAq8dyVHqB/VcJvVgL0U83dpiFFeewuFGeSIt7ConhPbRJwIB2dX4j11EV9GC6zQ8ENbfIFszpn5wdfFs/DB6OTgRjrYHjmf8jVFs64xnh+23GE8M=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=NSPdBYXAK0Wjvp4HTZ/H7AoC0pyvoyB7Kfa/vOP3m0M=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 0439C9002FD;
 Mon, 22 Apr 2024 16:39:47 +0800 (CST)
Message-ID: <314785e2-82ad-4f07-91cd-12a38eb519b0@rock-chips.com>
Date: Mon, 22 Apr 2024 16:39:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: rockchip_sdhci: Fix 4 blocks PIO mode read limit
 for RK35xx
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240410143052.227908-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240410143052.227908-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9PHlYYHUtJHUwZTU5KGk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04f619ed03a9kunm0439c9002fd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Hzo*FzNMGDoCDkg*Szc9
 EhAaCU1VSlVKTEpITExOSkNDQk1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ0pONwY+
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


On 2024/4/10 22:30, Jonas Karlman wrote:
> The commit 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks
> read in a single command") introduced a limit of number of blocks to
> read to fix a Data End Bit Error on RK3568 and RK3588. This had a side
> affect of significant slowing down reading FIT from eMMC.
>
> After the commit 6de9d7b2f13c ("rockchip: rk35xx: Enable eMMC HS200 mode
> by default") the limit of number of blocks to read workaround is no
> longer necessary and at HS200+ a Data End Bit Error is no longer
> happening using PIO mode.
>
> Change this limitation to allow reading more than 4 blocks with a single
> CMD18 command in PIO mode at HS200+ speed, keep using the 4 blocks
> limitation when loadig FIT from eMMC at lower speed than HS200.
>
> Fixes: 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks read in a single command")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Move cfg->b_max configuration to set_ios_post() ops
>
> This significantly speed up FIT loading from eMMC on RK3588 boards with
> a mmc-hs200 prop in the sdhci node, and boards without a mmc-hs200 prop
> continue to work.
> ---
>   drivers/mmc/rockchip_sdhci.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index 706fb1235796..c889c7bc9855 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -391,6 +391,8 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   static int rk3568_sdhci_set_ios_post(struct sdhci_host *host)
>   {
>   	struct mmc *mmc = host->mmc;
> +	struct rockchip_sdhc_plat *plat = dev_get_plat(mmc->dev);
> +	struct mmc_config *cfg = &plat->cfg;
>   	u32 reg;
>   
>   	reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> @@ -437,6 +439,20 @@ static int rk3568_sdhci_set_ios_post(struct sdhci_host *host)
>   
>   	sdhci_writew(host, reg, DWCMSHC_EMMC_EMMC_CTRL);
>   
> +	/*
> +	 * Reading more than 4 blocks with a single CMD18 command in PIO mode
> +	 * triggers Data End Bit Error using a slower mode than HS200. Limit to
> +	 * reading max 4 blocks in one command when using PIO mode.
> +	 */
> +	if (!(host->flags & USE_DMA)) {
> +		if (mmc->selected_mode == MMC_HS_200 ||
> +		    mmc->selected_mode == MMC_HS_400 ||
> +		    mmc->selected_mode == MMC_HS_400_ES)
> +			cfg->b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT;
> +		else
> +			cfg->b_max = 4;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -598,16 +614,6 @@ static int rockchip_sdhci_probe(struct udevice *dev)
>   	    dev_read_bool(dev, "u-boot,spl-fifo-mode"))
>   		host->flags &= ~USE_DMA;
>   
> -	/*
> -	 * Reading more than 4 blocks with a single CMD18 command in PIO mode
> -	 * triggers Data End Bit Error on RK3568 and RK3588. Limit to reading
> -	 * max 4 blocks in one command when using PIO mode.
> -	 */
> -	if (!(host->flags & USE_DMA) &&
> -	    (device_is_compatible(dev, "rockchip,rk3568-dwcmshc") ||
> -	     device_is_compatible(dev, "rockchip,rk3588-dwcmshc")))
> -		cfg->b_max = 4;
> -
>   	return sdhci_probe(dev);
>   }
>   
