Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B681AC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FEF80F42;
	Wed, 19 Feb 2025 16:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZuW3ioaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9BA80F56; Wed, 19 Feb 2025 16:22:09 +0100 (CET)
Received: from mail-m1973170.qiye.163.com (mail-m1973170.qiye.163.com
 [220.197.31.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F40DB800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f93c55;
 Wed, 19 Feb 2025 23:22:02 +0800 (GMT+08:00)
Message-ID: <9a17eee7-79cb-47a4-a591-91b268c46945@rock-chips.com>
Date: Wed, 19 Feb 2025 23:22:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay
 for RK3588
To: Jonas Karlman <jonas@kwiboo.se>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, wdc <wdc@rock-chips.com>
References: <20250209232801.3185681-1-jonas@kwiboo.se>
 <20250209232801.3185681-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250209232801.3185681-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUtJVk9NTBlKS00aT0oYQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951ecd3e4203afkunmb8f93c55
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6Ogw6NzIRKy4WEk9NTRcy
 DT1PCyhVSlVKTEhCQkxDTklISkxCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUpNSEI3Bg++
DKIM-Signature: a=rsa-sha256;
 b=ZuW3ioaWRVVyeqetI3jn/4xw4aYKPaqF8tFiZpt0/N3YEshOPfSHWeR8xDhckm1YP8T73RgoOWesUETRkhKOYpvPH6UY/CBxQaHZMuFRbK9WMh9MVSB7PosMJobKKj7BjJ2HiOdFyRLx5Ry8rmWlTu+jj73sN/Klq0cJMQvIRmg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Qn7yB3E8qPnTR06UEelcHovfhGjlTdxBzTiw9w2siPo=;
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
> index 3e10e07403c1..f3a0f63003ea 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -134,6 +134,10 @@ static int rk3568_set_gmac_speed(struct udevice *dev)
>   	return 0;
>   }
>   
> +#define RK3588_DELAY_ENABLE(id, tx, rx) \
> +	(((tx) ? RK3588_GMAC_TXCLK_DLY_ENABLE(id) : RK3588_GMAC_TXCLK_DLY_DISABLE(id)) | \
> +	 ((rx) ? RK3588_GMAC_RXCLK_DLY_ENABLE(id) : RK3588_GMAC_RXCLK_DLY_DISABLE(id)))
> +
>   /* sys_grf */
>   #define RK3588_GRF_GMAC_CON7			0x031c
>   #define RK3588_GRF_GMAC_CON8			0x0320
> @@ -192,8 +196,7 @@ static int rk3588_set_to_rgmii(struct udevice *dev,
>   		     RK3588_GMAC_CLK_RGMII_MODE(id));
>   
>   	regmap_write(data->grf, RK3588_GRF_GMAC_CON7,
> -		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
> -		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
> +		     RK3588_DELAY_ENABLE(id, tx_delay, rx_delay));
>   
>   	regmap_write(data->grf, offset_con,
>   		     RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |
