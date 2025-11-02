Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D05CCCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 00:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 608748389A;
	Sun,  2 Nov 2025 01:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iDPKvqMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C199838A5; Sun,  2 Nov 2025 01:51:05 +0100 (CET)
Received: from mail-m828.xmail.ntesmail.com (mail-m828.xmail.ntesmail.com
 [156.224.82.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524AD82A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 01:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 28088886d;
 Sun, 2 Nov 2025 08:50:57 +0800 (GMT+08:00)
Message-ID: <74dde404-9969-490d-8fd2-fd307a01d6e5@rock-chips.com>
Date: Sun, 2 Nov 2025 08:50:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: rockchip: rk3368: add SCLK for mmc clock get/set
To: WeiHao Li <cn.liweihao@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 lukma@denx.de, seanga2@gmail.com, ag.dev.uboot@gmail.com,
 muratdemirtaseu@outlook.com
References: <20250814131237.8135-1-cn.liweihao@gmail.com>
 <20250814131237.8135-3-cn.liweihao@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250814131237.8135-3-cn.liweihao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a420bbfb203afkunmbf5a454fa1dd6c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQk8aVkIdS0sdQ05IGhoaSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=iDPKvqMn74EtI3y9lV5Ma05akQ12UQNXzz6IyfhFNXJTK3A+WcVjhHoYqIkfl9J6sXQPu6F3CFHt48mRxHpfHQPhszII8LRUJTUmkh5ru8tTvxdvvJ1met883Ny5Q/4pcP3qtkGHaCKdWanDVaB6ISsCpAJv4YLF4owko3CBB3g=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Oj+dexGcjAZtzljiM+0IPVpILkYypeeiN7EGQj9J04w=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/8/14 21:12, WeiHao Li wrote:
> Because of dwmmc driver get clk form a fixed index 1, so must add
> SCLK_SDMMC and SCLK_EMMC support to make emmc work.
>
> Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3368.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
> index 994330162..f9936fb40 100644
> --- a/drivers/clk/rockchip/clk_rk3368.c
> +++ b/drivers/clk/rockchip/clk_rk3368.c
> @@ -165,9 +165,11 @@ static ulong rk3368_mmc_get_clk(struct rk3368_cru *cru, uint clk_id)
>   
>   	switch (clk_id) {
>   	case HCLK_SDMMC:
> +	case SCLK_SDMMC:
>   		con_id = 50;
>   		break;
>   	case HCLK_EMMC:
> +	case SCLK_EMMC:
>   		con_id = 51;
>   		break;
>   	case SCLK_SDIO0:
> @@ -262,9 +264,11 @@ static ulong rk3368_mmc_set_clk(struct clk *clk, ulong rate)
>   
>   	switch (clk_id) {
>   	case HCLK_SDMMC:
> +	case SCLK_SDMMC:
>   		con_id = 50;
>   		break;
>   	case HCLK_EMMC:
> +	case SCLK_EMMC:
>   		con_id = 51;
>   		break;
>   	case SCLK_SDIO0:
> @@ -559,6 +563,8 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
>   #if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
>   	case HCLK_SDMMC:
>   	case HCLK_EMMC:
> +	case SCLK_SDMMC:
> +	case SCLK_EMMC:
>   		rate = rk3368_mmc_get_clk(priv->cru, clk->id);
>   		break;
>   #endif
> @@ -597,6 +603,8 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
>   #if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
>   	case HCLK_SDMMC:
>   	case HCLK_EMMC:
> +	case SCLK_SDMMC:
> +	case SCLK_EMMC:
>   		ret = rk3368_mmc_set_clk(clk, rate);
>   		break;
>   #endif
