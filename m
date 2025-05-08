Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212EDC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 03:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C09828A2;
	Thu,  8 May 2025 05:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HtOQOHxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7024E828A2; Thu,  8 May 2025 05:12:45 +0200 (CEST)
Received: from mail-m49245.qiye.163.com (mail-m49245.qiye.163.com
 [45.254.49.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F1381FAB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 05:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14523fb41;
 Thu, 8 May 2025 11:12:36 +0800 (GMT+08:00)
Message-ID: <21ea7c58-f396-460b-9cb8-b4cf2d158589@rock-chips.com>
Date: Thu, 8 May 2025 11:12:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3288: grf: Unify speed/flowctrl fields
 for clarity
To: chf.fritz@googlemail.com, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Fabio Estevam <festevam@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 RamonFried <rfried.dev@gmail.com>, u-boot <u-boot@lists.denx.de>
References: <13931598d2714780f91ce96d054664f304de7c1f.camel@googlemail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <13931598d2714780f91ce96d054664f304de7c1f.camel@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0gYVkNJS0xJTRpPT0kaSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96ade1787103afkunm14523fb41
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6NTo5PDIBPwgyTxo0K005
 NjUKCzdVSlVKTE9NTUxIQk5DSU1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlMQkw3Bg++
DKIM-Signature: a=rsa-sha256;
 b=HtOQOHxUuRVyvQfy/lM0znHLH3mjmei01pPsgp5TpMLnoU7Ar9+M5GmV7L4mBABNQmjqAYGvMdjhHWvGwjdC9mo8HCLkLWP5ra8UetklpBtjHZtW973tre31/fNaZ29ltYwlqI9uSuXsOZub7QsRViSIyiv9KsOBqUJKr68+vk4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=JHPojbWlaPgW8zH6BMr4/aLNd2neUia9fcbNLlP8Oow=;
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


On 2025/4/16 19:44, Christoph Fritz wrote:
> Update GMAC speed and flow control fields in GRF_SOC_CON1 to use
> RK3288_GMAC_* prefix, ensuring a consistent naming convention. It also
> shifts each mask/bit definition to match the actual hardware bits, which
> makes future usage easier.
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/include/asm/arch-rockchip/grf_rk3288.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3288.h b/arch/arm/include/asm/arch-rockchip/grf_rk3288.h
> index 894d3a40b09..0111b3a0ded 100644
> --- a/arch/arm/include/asm/arch-rockchip/grf_rk3288.h
> +++ b/arch/arm/include/asm/arch-rockchip/grf_rk3288.h
> @@ -934,21 +934,21 @@ enum {
>   	RK3288_RMII_CLK_SEL_2_5M  = (0 << RK3288_RMII_CLK_SEL_SHIFT),
>   	RK3288_RMII_CLK_SEL_25M   = (1 << RK3288_RMII_CLK_SEL_SHIFT),
>   
> -	GMAC_SPEED_SHIFT	= 0xa,
> -	GMAC_SPEED_MASK		= 1,
> -	GMAC_SPEED_10M		= 0,
> -	GMAC_SPEED_100M,
> +	RK3288_GMAC_SPEED_SHIFT	= 0xa,
> +	RK3288_GMAC_SPEED_MASK	= (1 << RK3288_GMAC_SPEED_SHIFT),
> +	RK3288_GMAC_SPEED_10M	= (0 << RK3288_GMAC_SPEED_SHIFT),
> +	RK3288_GMAC_SPEED_100M	= (1 << RK3288_GMAC_SPEED_SHIFT),
>   
> -	GMAC_FLOWCTRL_SHIFT	= 0x9,
> -	GMAC_FLOWCTRL_MASK	= 1,
> +	RK3288_GMAC_FLOWCTRL_SHIFT = 0x9,
> +	RK3288_GMAC_FLOWCTRL_MASK = (1 << RK3288_GMAC_FLOWCTRL_SHIFT),
>   
>   	RK3288_GMAC_PHY_INTF_SEL_SHIFT = 6,
>   	RK3288_GMAC_PHY_INTF_SEL_MASK  = (7 << RK3288_GMAC_PHY_INTF_SEL_SHIFT),
>   	RK3288_GMAC_PHY_INTF_SEL_RGMII = (1 << RK3288_GMAC_PHY_INTF_SEL_SHIFT),
>   	RK3288_GMAC_PHY_INTF_SEL_RMII  = (4 << RK3288_GMAC_PHY_INTF_SEL_SHIFT),
>   
> -	HOST_REMAP_SHIFT	= 0x5,
> -	HOST_REMAP_MASK		= 1
> +	RK3288_HOST_REMAP_SHIFT	= 0x5,
> +	RK3288_HOST_REMAP_MASK	= (1 << RK3288_HOST_REMAP_SHIFT),
>   };
>   
>   /* GRF_SOC_CON2 */
