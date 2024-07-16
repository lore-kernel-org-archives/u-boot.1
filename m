Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6423DC3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D91148813A;
	Tue, 16 Jul 2024 04:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BxBZZZlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B658893B; Tue, 16 Jul 2024 04:20:32 +0200 (CEST)
Received: from mail-m15566.qiye.163.com (mail-m15566.qiye.163.com
 [101.71.155.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7A587FC8
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BxBZZZlEEoA/PK8LhPZ72aJwNbhKPyxLCZgxuJYyCHa9O92gd9tzBKFd4itS0u6Z6hOO4+uIU7YJ9srtdOc20O9R5dknSm1bxW6S+s3yOpht7McQKH8dlMRlZ4+9SYflGASLWK+0DCZlFs7UBkgbXbwI94lrQ96TR+rWVk97hXE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=l+r1cmZTZiNJabGs117Ndg4CCqnQykCXmjTVMaeMSQw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id F18E79003CF;
 Tue, 16 Jul 2024 10:20:17 +0800 (CST)
Message-ID: <96409f23-ce4d-4e8c-b766-af8942ac7689@rock-chips.com>
Date: Tue, 16 Jul 2024 10:20:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: rockchip: inno-hdmi: Fix missing readl base addr
To: Jagan Teki <jagan@edgeble.ai>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Da Xue <da@libretech.co>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20240622182149.28416-1-jagan@edgeble.ai>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240622182149.28416-1-jagan@edgeble.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kaQlZLQ0NNSBlCTEhIHk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b95733c303a9kunmf18e79003cf
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6UQw*CDI4CBgKGDBKDTNI
 Vk4aCyNVSlVKTElKS0JNT0pDTUhMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUpCNwY+
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


On 2024/6/23 02:21, Jagan Teki wrote:
> inno_poll passes the reg offset that is used by readl_poll_sleep_timeout
> without any base addr.
>
> Fix it.
>
> Bug:
> inno_hdmi_phy phy@ff430000: Pre-PLL locking failed
> inno_hdmi_phy phy@ff430000: PHY: Failed to power on phy@ff430000: -110.
> failed to power on phy (ret=-110)
> inno_hdmi_phy phy@ff430000: Pre-PLL locking failed
> inno_hdmi_phy phy@ff430000: PHY: Failed to power on phy@ff430000: -110.
> failed to power on phy (ret=-110)
>
> Fixes: aa2271184603 ("phy: rockchip: Add Rockchip INNO HDMI PHY driver")
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> index 3bb1a254ff..7459779dff 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> @@ -432,8 +432,8 @@ static inline void inno_update_bits(struct inno_hdmi_phy *inno, u8 reg,
>   	inno_write(inno, reg, tmp);
>   }
>   
> -#define inno_poll(reg, val, cond, sleep_us, timeout_us) \
> -	readl_poll_sleep_timeout((reg) * 4, val, cond, sleep_us, timeout_us)
> +#define inno_poll(inno, reg, val, cond, sleep_us, timeout_us) \
> +	readl_poll_sleep_timeout((inno)->regs + ((reg) * 4), val, cond, sleep_us, timeout_us)
>   
>   static unsigned long inno_hdmi_phy_get_tmdsclk(struct inno_hdmi_phy *inno,
>   					       unsigned long rate)
> @@ -575,7 +575,7 @@ inno_hdmi_phy_rk3328_clk_set_rate(struct phy *phy,
>   	inno_update_bits(inno, 0xa0, RK3328_PRE_PLL_POWER_DOWN, 0);
>   
>   	/* Wait for Pre-PLL lock */
> -	ret = inno_poll(0xa9, val, val & RK3328_PRE_PLL_LOCK_STATUS,
> +	ret = inno_poll(inno, 0xa9, val, val & RK3328_PRE_PLL_LOCK_STATUS,
>   			1000, 10000);
>   	if (ret) {
>   		dev_err(phy->dev, "Pre-PLL locking failed\n");
> @@ -674,7 +674,7 @@ inno_hdmi_phy_rk3328_power_on(struct phy *phy,
>   			 RK3328_TMDS_DRIVER_ENABLE);
>   
>   	/* Wait for post PLL lock */
> -	ret = inno_poll(0xaf, v, v & RK3328_POST_PLL_LOCK_STATUS,
> +	ret = inno_poll(inno, 0xaf, v, v & RK3328_POST_PLL_LOCK_STATUS,
>   			1000, 10000);
>   	if (ret) {
>   		dev_err(phy->dev, "Post-PLL locking failed\n");
