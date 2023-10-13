Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADAEC41513
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 07:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABCB86E75;
	Fri, 13 Oct 2023 09:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y8E/QTS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B057F86E77; Fri, 13 Oct 2023 09:44:36 +0200 (CEST)
Received: from mail-m12745.qiye.163.com (mail-m12745.qiye.163.com
 [115.236.127.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74A486E51
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Y8E/QTS7PSEt0So82Dcxqph8zDqvlmlWTdVZjivgv+XzQREduZDBRbL3Kd6UIGjDEHpJ3ENqeekRK0QnsB0Q6wMmZfbKVu/FbJVWzfTwgsa3VOM/jmbYdUghFYWRlOEGyTiZsbrj8JRsFtg8TQOHBNQzAJQYQAv1R1b3C0YNAxI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=+4mXPS7sRgnWTFWUmpKq1RrXf7tgGyzF3tYIdrMH77U=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 870F1400398;
 Fri, 13 Oct 2023 15:43:53 +0800 (CST)
Message-ID: <4d83225b-df10-28e1-2697-0cef3564f08b@rock-chips.com>
Date: Fri, 13 Oct 2023 15:43:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] clk: rockchip: rk3588: Avoid re-setting the pll
 rate of dclk_vop's parent
Content-Language: en-US
To: Elaine Zhang <zhangqing@rock-chips.com>, lukma@denx.de,
 seanga2@gmail.com, philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
 <20231012101812.27142-1-zhangqing@rock-chips.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231012101812.27142-1-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgdGVZPGE1PHxlKH0wZTR1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b27fdea192eb3kusn870f1400398
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6CCo4DjwrPgkDTDEXFQ8Y
 ORlPFFFVSlVKTUJMSkNIS0hPSEJCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUJCNwY+
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


On 2023/10/12 18:18, Elaine Zhang wrote:
> Optimize setting process.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3588.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index 7ba037ad72ba..a995dd5591d3 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -1130,13 +1130,23 @@ static ulong rk3588_dclk_vop_set_clk(struct rk3588_clk_priv *priv,
>   	}
>   
>   	if (sel == DCLK_VOP_SRC_SEL_V0PLL) {
> -		div = DIV_ROUND_UP(RK3588_VOP_PLL_LIMIT_FREQ, rate);
> -		rk_clrsetreg(&cru->clksel_con[conid],
> -			     mask,
> -			     DCLK_VOP_SRC_SEL_V0PLL << sel_shift |
> -			     ((div - 1) << div_shift));
> -		rockchip_pll_set_rate(&rk3588_pll_clks[V0PLL],
> -				      priv->cru, V0PLL, div * rate);
> +		pll_rate = rockchip_pll_get_rate(&rk3588_pll_clks[V0PLL],
> +						 priv->cru, V0PLL);
> +		if (pll_rate >= RK3588_VOP_PLL_LIMIT_FREQ && pll_rate % rate == 0) {
> +			div = DIV_ROUND_UP(pll_rate, rate);
> +			rk_clrsetreg(&cru->clksel_con[conid],
> +				     mask,
> +				     DCLK_VOP_SRC_SEL_V0PLL << sel_shift |
> +				     ((div - 1) << div_shift));
> +		} else {
> +			div = DIV_ROUND_UP(RK3588_VOP_PLL_LIMIT_FREQ, rate);
> +			rk_clrsetreg(&cru->clksel_con[conid],
> +				     mask,
> +				     DCLK_VOP_SRC_SEL_V0PLL << sel_shift |
> +				     ((div - 1) << div_shift));
> +			rockchip_pll_set_rate(&rk3588_pll_clks[V0PLL],
> +					      priv->cru, V0PLL, div * rate);
> +		}
>   	} else {
>   		for (i = 0; i <= DCLK_VOP_SRC_SEL_AUPLL; i++) {
>   			switch (i) {
