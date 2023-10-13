Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE8DCDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 07:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D8C86E77;
	Fri, 13 Oct 2023 09:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gpreQQGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5527286B35; Fri, 13 Oct 2023 09:43:53 +0200 (CEST)
Received: from mail-m155105.qiye.163.com (mail-m155105.qiye.163.com
 [101.71.155.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3445B86E7C
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gpreQQGk+Ycb7d8wznw6dSpcUySTsGTwr+4Z4H/2aJa3kXYh2vj3vBU88Xn2TbiFHCImrCrjl+AKnbx96lDx2XGNTQOK/pL+mmqYvRy/BffiUHUFjTaTz8de3Trw5e79mGmBD8i714TMxbbMX9+XmFXs2dmhJ1opRZm5TwSVYiY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=/epUjV2LlnO6aevdaxaRID6eq/mnVjQ5iQN+simVlKM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 47FFA400316;
 Fri, 13 Oct 2023 15:43:09 +0800 (CST)
Message-ID: <cc94f286-4d6a-e4a6-4064-8d0d61fb4eca@rock-chips.com>
Date: Fri, 13 Oct 2023 15:43:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/5] clk: rockchip: rk3568: support dclk_vop select
 more parent clks
Content-Language: en-US
To: Elaine Zhang <zhangqing@rock-chips.com>, lukma@denx.de,
 seanga2@gmail.com, philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
 <20231011102947.21188-2-zhangqing@rock-chips.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231011102947.21188-2-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5DQ1ZOT0MeSh1OGEhNTktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b27fd3c9a2eb3kusn47ffa400316
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pjo6Cyo4PTwzUQk2NThNTygz
 Qk1PCk1VSlVKTUJMSkNJQkNCQkhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISkNKNwY+
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


On 2023/10/11 18:29, Elaine Zhang wrote:
> For dclk_vop to support more frequencies.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3568.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 599b7b130eb9..68f5bbbb9e57 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -1838,7 +1838,7 @@ static ulong rk3568_dclk_vop_set_clk(struct rk3568_clk_priv *priv,
>   		rockchip_pll_set_rate(&rk3568_pll_clks[VPLL],
>   				      priv->cru, VPLL, div * rate);
>   	} else {
> -		for (i = 0; i <= DCLK_VOP_SEL_CPLL; i++) {
> +		for (i = sel; i <= DCLK_VOP_SEL_CPLL; i++) {
>   			switch (i) {
>   			case DCLK_VOP_SEL_GPLL:
>   				pll_rate = priv->gpll_hz;
> @@ -2785,9 +2785,15 @@ static int rk3568_dclk_vop_set_parent(struct clk *clk, struct clk *parent)
>   	if (parent->id == PLL_VPLL) {
>   		rk_clrsetreg(&cru->clksel_con[con_id], DCLK0_VOP_SEL_MASK,
>   			     DCLK_VOP_SEL_VPLL << DCLK0_VOP_SEL_SHIFT);
> -	} else {
> +	} else if (parent->id == PLL_HPLL) {
>   		rk_clrsetreg(&cru->clksel_con[con_id], DCLK0_VOP_SEL_MASK,
>   			     DCLK_VOP_SEL_HPLL << DCLK0_VOP_SEL_SHIFT);
> +	} else if (parent->id == PLL_CPLL) {
> +		rk_clrsetreg(&cru->clksel_con[con_id], DCLK0_VOP_SEL_MASK,
> +			     DCLK_VOP_SEL_CPLL << DCLK0_VOP_SEL_SHIFT);
> +	} else {
> +		rk_clrsetreg(&cru->clksel_con[con_id], DCLK0_VOP_SEL_MASK,
> +			     DCLK_VOP_SEL_GPLL << DCLK0_VOP_SEL_SHIFT);
>   	}
>   
>   	return 0;
