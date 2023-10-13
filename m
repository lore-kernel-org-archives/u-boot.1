Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8952ECDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 07:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5922C86EA1;
	Fri, 13 Oct 2023 09:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LK+UCsLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA8386E51; Fri, 13 Oct 2023 09:44:24 +0200 (CEST)
Received: from mail-m127105.qiye.163.com (mail-m127105.qiye.163.com
 [115.236.127.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DAFB86E73
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LK+UCsLL29tEFHXjOo71l9+jU3lh37wFwr1AS2LJwgDSpM4TvK+jGJDKxbb866kkWSimtvzx7q8vUuy1CJi5gzg421ZEQttWKodJlITpmKYm9KjJStzC+8NgSyFgT97CZ+1VWdaksWCpaeOis+/E+oVmSgm+WP11SFW+r2AWndA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=V+jkp+ssDJStpdyKuk9rNR9DizWJ2uVNDjVNcq5oS0Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 7B02240039C;
 Fri, 13 Oct 2023 15:43:41 +0800 (CST)
Message-ID: <7bd72811-67be-f514-f743-255205b57e70@rock-chips.com>
Date: Fri, 13 Oct 2023 15:43:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/5] clk: rockchip: rk3588: support aclk_top_root set
 750M
Content-Language: en-US
To: Elaine Zhang <zhangqing@rock-chips.com>, lukma@denx.de,
 seanga2@gmail.com, philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
 <20231011102947.21188-4-zhangqing@rock-chips.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231011102947.21188-4-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ00aGlYeT0JJTB5NHUxPSBhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b27fdbaf32eb3kusn7b02240039c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6MDo5Tzw5OgkqTDASFRgq
 Tg8KCwxVSlVKTUJMSkNIS0lJSE5JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0lONwY+
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
> aclk_top_root choose a parent clock that does not change.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3588.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index c86176264147..7ba037ad72ba 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -306,12 +306,18 @@ static ulong rk3588_top_set_clk(struct rk3588_clk_priv *priv,
>   
>   	switch (clk_id) {
>   	case ACLK_TOP_ROOT:
> -		src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
> +		if (!(priv->cpll_hz % rate)) {
> +			src_clk = ACLK_TOP_ROOT_SRC_SEL_CPLL;
> +			src_clk_div = DIV_ROUND_UP(priv->cpll_hz, rate);
> +		} else {
> +			src_clk = ACLK_TOP_ROOT_SRC_SEL_GPLL;
> +			src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
> +		}
>   		assert(src_clk_div - 1 <= 31);
>   		rk_clrsetreg(&cru->clksel_con[8],
>   			     ACLK_TOP_ROOT_DIV_MASK |
>   			     ACLK_TOP_ROOT_SRC_SEL_MASK,
> -			     (ACLK_TOP_ROOT_SRC_SEL_GPLL <<
> +			     (src_clk <<
>   			      ACLK_TOP_ROOT_SRC_SEL_SHIFT) |
>   			     (src_clk_div - 1) << ACLK_TOP_ROOT_DIV_SHIFT);
>   		break;
