Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662A7C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E881B801BE;
	Wed, 19 Feb 2025 16:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="U+o5RQhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D2580EC0; Wed, 19 Feb 2025 16:21:40 +0100 (CET)
Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com
 [117.135.214.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B52800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f93c0e;
 Wed, 19 Feb 2025 23:21:34 +0800 (GMT+08:00)
Message-ID: <df22445b-cdbd-4feb-9620-e31d6beac320@rock-chips.com>
Date: Wed, 19 Feb 2025 23:21:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay
 for RK356x
To: Jonas Karlman <jonas@kwiboo.se>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, wdc <wdc@rock-chips.com>
References: <20250209232801.3185681-1-jonas@kwiboo.se>
 <20250209232801.3185681-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250209232801.3185681-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGR8dVkMZSBpOHh0ZTkxOGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951eccd19e03afkunmb8f93c0e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pww6Fgw6SzIJPy4UEk8RTQg2
 PAtPCUJVSlVKTEhCQkxDT0JOSktDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUpOQks3Bg++
DKIM-Signature: a=rsa-sha256;
 b=U+o5RQhbkWCBVmNKBIiONQd2s0uiRSm+GYvaLyIak29l5Rl8W85rQqTDqxwTwJfPguroCgIDS050VU6sLfiCTSwLbSBQghBHq9UfalYuyNIU9avQNzEiC/N89mOMF59o52LV0nb6JVfeMRDC95hPtmlG7GVEz+I65Qm4ZF92U0Y=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=v2D0helmCdukkmcRG/JS/f+RcwauCCRJJzQOCDCpa0E=;
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


On 2025/2/10 07:27, Jonas Karlman wrote:
> When rgmii-rxid/txid/id phy-mode is used the MAC should not add RX
> and/or TX delay. Currently RX/TX delay is configured as enabled using
> zero as delay value for the rgmii-rxid/txid/id modes.
>
> Change to disable RX and/or TX delay and using zero as delay value.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/net/dwc_eth_qos_rockchip.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
> index 9fc8c686b889..3e10e07403c1 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -46,6 +46,10 @@ struct rockchip_platform_data {
>   #define GRF_BIT(nr)	(BIT(nr) | BIT((nr) + 16))
>   #define GRF_CLR_BIT(nr)	(BIT((nr) + 16))
>   
> +#define DELAY_ENABLE(soc, tx, rx) \
> +	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
> +	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
> +
>   #define RK3568_GRF_GMAC0_CON0		0x0380
>   #define RK3568_GRF_GMAC0_CON1		0x0384
>   #define RK3568_GRF_GMAC1_CON0		0x0388
> @@ -85,8 +89,7 @@ static int rk3568_set_to_rgmii(struct udevice *dev,
>   
>   	regmap_write(data->grf, con1,
>   		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
> -		     RK3568_GMAC_RXCLK_DLY_ENABLE |
> -		     RK3568_GMAC_TXCLK_DLY_ENABLE);
> +		     DELAY_ENABLE(RK3568, tx_delay, rx_delay));
>   
>   	return 0;
>   }
