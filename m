Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DFBC10F15
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C45E885B4;
	Tue, 23 Apr 2024 13:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aXCYYi9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C67885A3; Tue, 23 Apr 2024 13:03:45 +0200 (CEST)
Received: from mail-m118211.qiye.163.com (mail-m118211.qiye.163.com
 [115.236.118.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284538854A
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=aXCYYi9rmr4Ac0zJ60AhI4b+JvBB1Hnkn/qa3liTYcaS9/rIJyAsYe6aYDwOdBue6CbDrlXKLnjp2LkuUeMEURqlYnmVPPwneWD0in+Yl9t0oQoKMAJcXxOdEXEXwveA4kc9tnWFck6CTqG4WrXumAGuYBE5KxAHqsvNmlzdSuI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=30xou3ih7auvsut0tQmfXQZ3LmMU+93BR1xUjFKHOHg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 580F490024D;
 Tue, 23 Apr 2024 19:03:32 +0800 (CST)
Message-ID: <e8ad5206-af24-4962-b3dd-86613b7b8a70@rock-chips.com>
Date: Tue, 23 Apr 2024 19:03:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/31] clk: rockchip: rk3399: Add SCLK_USB3OTGx_REF support
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-15-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4ZSlZNSx0YSxgdQx4fTh1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0aa00fb203a9kunm580f490024d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBA6URw4AzNMGD0DKU80GSkx
 DC0wCT5VSlVKTEpIQ0xLSUpISE5LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT01MNwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> The SCLK_USB3OTGx_REF clocks is used as reference clock for USB3 block.
>
> Add simple support to get rate of SCLK_USB3OTGx_REF clocks to fix
> reference clock period configuration.
>
> Also replace use of 24000000 with the OSC_HZ constant.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3399.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index 29b01abeca06..6408c5d0aa6a 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -956,7 +956,9 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
>   	case SCLK_UART1:
>   	case SCLK_UART2:
>   	case SCLK_UART3:
> -		return 24000000;
> +	case SCLK_USB3OTG0_REF:
> +	case SCLK_USB3OTG1_REF:
> +		return OSC_HZ;
>   	case PCLK_HDMI_CTRL:
>   		break;
>   	case DCLK_VOP0:
