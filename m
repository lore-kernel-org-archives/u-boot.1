Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E07C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 07:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BDB88345;
	Mon, 22 Apr 2024 09:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BhbxXefz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 451CA88348; Mon, 22 Apr 2024 09:55:54 +0200 (CEST)
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com
 [45.254.49.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC28F8831D
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BhbxXefz2lCQpSD2zo9gXpHS/B5lfz51Fc70DoBdsmojsROeLGZtgcT0ATvzgOXVZnTYmprNizZZ1fgsl14mlB3dSIDjBUt5bo/zlsvTNAyW8WGy8PT/TyaWZmdLEaJ3NYIewNjxaQ0/R/XZNJO39RlmZr7uHXML9jnc/ZjTzn8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=8gR1SeauD5D00W3EbvheAXXC2Sk0UItVofW15VYwdIE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4F4B29002A5;
 Mon, 22 Apr 2024 15:55:45 +0800 (CST)
Message-ID: <d32a9bf1-aa60-409f-ab27-9daf3a8db6b2@rock-chips.com>
Date: Mon, 22 Apr 2024 15:55:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/28] clk: rockchip: rk3588: Add REF_CLK_USB3OTGx
 support
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pCHVZLGk1DTRpPHR0dGR9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04cdc76503a9kunm4f4b29002a5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6SCo4TTNWMjoJGTYcAgFI
 Sk4KFC5VSlVKTEpITExJTk9NT0xNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0xMNwY+
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
> The REF_CLK_USB3OTGx clocks is used as reference clock for USB3 block.
>
> Add simple support to get rate of REF_CLK_USB3OTGx clocks to fix
> reference clock period configuration.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Acked-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Collect a-b tag
> v2: Collect r-b tag
> ---
>   drivers/clk/rockchip/clk_rk3588.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index 8f33843179b0..4c611a390499 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -1569,6 +1569,9 @@ static ulong rk3588_clk_get_rate(struct clk *clk)
>   	case DCLK_DECOM:
>   		rate = rk3588_mmc_get_clk(priv, clk->id);
>   		break;
> +	case REF_CLK_USB3OTG0:
> +	case REF_CLK_USB3OTG1:
> +	case REF_CLK_USB3OTG2:
>   	case TMCLK_EMMC:
>   	case TCLK_WDT0:
>   		rate = OSC_HZ;
> @@ -1734,6 +1737,9 @@ static ulong rk3588_clk_set_rate(struct clk *clk, ulong rate)
>   	case DCLK_DECOM:
>   		ret = rk3588_mmc_set_clk(priv, clk->id, rate);
>   		break;
> +	case REF_CLK_USB3OTG0:
> +	case REF_CLK_USB3OTG1:
> +	case REF_CLK_USB3OTG2:
>   	case TMCLK_EMMC:
>   	case TCLK_WDT0:
>   		ret = OSC_HZ;
