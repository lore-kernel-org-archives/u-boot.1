Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22409C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 07:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3830788334;
	Mon, 22 Apr 2024 09:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YYrwR4Dh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A05488334; Mon, 22 Apr 2024 09:55:42 +0200 (CEST)
Received: from mail-m17230.xmail.ntesmail.com (mail-m17230.xmail.ntesmail.com
 [45.195.17.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A008831D
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YYrwR4DhqH8vZvJgbEOGfvGi6HAvgbf9jO3JOIxdBUwcK7Z150PHZ6I0ipa8ZuCPsoY1QLuWPwdC0mXWYCmZm+/zDLb9RFe4Xz8Lx1ctVN0m4LLW0dPM7sD5g6c2IIUI0gpKcJyrBM40fpEu+X4bLUrFpZUsstMl46iXXpLUK14=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=S3IRNtILoN9/7oRepIedGUFxyFUavrGtaY1dG7fiX3M=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BE1ED9002AD;
 Mon, 22 Apr 2024 15:55:25 +0800 (CST)
Message-ID: <b26717f2-e644-4fc9-b86b-e99d92588a7d@rock-chips.com>
Date: Mon, 22 Apr 2024 15:55:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/28] clk: rockchip: rk356x: Add CLK_USB3OTGx_REF
 support
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkfS1YaSU1IHU1PHRkYGU5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04cd7bbe03a9kunmbe1ed9002ad
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6OQw4QzNOCDpLCSs1Ahwf
 CDYwCQxVSlVKTEpITExJTklMSUNMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQktCNwY+
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
> The CLK_USB3OTGx_REF clocks is used as reference clock for USB3 block.
>
> Add simple support to get rate of CLK_USB3OTGx_REF clocks to fix
> reference clock period configuration.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Acked-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Collect a-b tag
> v2: No change
> ---
>   drivers/clk/rockchip/clk_rk3568.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 57ef27dda893..999f48ea4b4e 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -2417,6 +2417,8 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
>   	case BCLK_EMMC:
>   		rate = rk3568_emmc_get_bclk(priv);
>   		break;
> +	case CLK_USB3OTG0_REF:
> +	case CLK_USB3OTG1_REF:
>   	case TCLK_EMMC:
>   		rate = OSC_HZ;
>   		break;
> @@ -2596,6 +2598,8 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
>   	case BCLK_EMMC:
>   		ret = rk3568_emmc_set_bclk(priv, rate);
>   		break;
> +	case CLK_USB3OTG0_REF:
> +	case CLK_USB3OTG1_REF:
>   	case TCLK_EMMC:
>   		ret = OSC_HZ;
>   		break;
