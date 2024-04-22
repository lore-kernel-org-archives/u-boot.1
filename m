Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E662CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 07:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741858833F;
	Mon, 22 Apr 2024 09:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Vb75DDiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6399188347; Mon, 22 Apr 2024 09:57:33 +0200 (CEST)
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com
 [115.236.118.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DBA88350
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Vb75DDiQ2g20rNNh5WX1Ulfuq0WSZPIfO/JKuKYu3a3uJ8vXw6wabOEzTpuDOoSVKa/ddA6wim7q7DQj0CbirEYpnFjPzn6dd+3qXYIne8F+mvgL7UE5fCd69/S93gxAHcaiK4ycx3GR7/ojr7SRbXY2nsZDAFu+8c0HXnDAlI0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=NKyPpfXNM852KtVSzHQMrq37Gwz6eABjDOu+m4lTWT8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 456E49002E5;
 Mon, 22 Apr 2024 15:57:22 +0800 (CST)
Message-ID: <38b3e3ac-a5ed-494c-9938-96db733fce3e@rock-chips.com>
Date: Mon, 22 Apr 2024 15:57:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/28] clk: rockchip: rk356x: Fix set rate of SCLK_SFC
 clock
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9KQlZCSUxCTk8YHUpPSBpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04cf41ae03a9kunm456e49002e5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDI6FRw5LzNKEDpNNxkNAhEz
 LEMaCitVSlVKTEpITExJTU9IS0NOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITU5NNwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> The SCLK_SFC can be set to a rate of 24, 50, 75, 100, 125 or 150 MHz.
>
> However, clk_set_rate() will fail unless one of those exact rates are
> used, and with newer and updated device tree files that contain
> spi-max-frequency values that does not exactly match these rates use of
> SPI flash may fail.
>
> Fix this by using the highest possible rate that exceeds or is equal to
> the requested rate.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: New patch
> ---
>   drivers/clk/rockchip/clk_rk3568.c | 32 ++++++++++++-------------------
>   1 file changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 999f48ea4b4e..24eeca8bf265 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -1527,28 +1527,20 @@ static ulong rk3568_sfc_set_clk(struct rk3568_clk_priv *priv, ulong rate)
>   	struct rk3568_cru *cru = priv->cru;
>   	int src_clk;
>   
> -	switch (rate) {
> -	case OSC_HZ:
> -		src_clk = SCLK_SFC_SEL_24M;
> -		break;
> -	case 50 * MHz:
> -		src_clk = SCLK_SFC_SEL_50M;
> -		break;
> -	case 75 * MHz:
> -		src_clk = SCLK_SFC_SEL_75M;
> -		break;
> -	case 100 * MHz:
> -		src_clk = SCLK_SFC_SEL_100M;
> -		break;
> -	case 125 * MHz:
> -		src_clk = SCLK_SFC_SEL_125M;
> -		break;
> -	case 150 * MHz:
> +	if (rate >= 150 * MHz)
>   		src_clk = SCLK_SFC_SEL_150M;
> -		break;
> -	default:
> +	else if (rate >= 125 * MHz)
> +		src_clk = SCLK_SFC_SEL_125M;
> +	else if (rate >= 100 * MHz)
> +		src_clk = SCLK_SFC_SEL_100M;
> +	else if (rate >= 75 * MHz)
> +		src_clk = SCLK_SFC_SEL_75M;
> +	else if (rate >= 50 * MHz)
> +		src_clk = SCLK_SFC_SEL_50M;
> +	else if (rate >= OSC_HZ)
> +		src_clk = SCLK_SFC_SEL_24M;
> +	else
>   		return -ENOENT;
> -	}
>   
>   	rk_clrsetreg(&cru->clksel_con[28],
>   		     SCLK_SFC_SEL_MASK,
