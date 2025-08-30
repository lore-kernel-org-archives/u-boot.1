Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEA9CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB90C83837;
	Sat, 30 Aug 2025 17:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PgS61Qhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D8E8383A; Sat, 30 Aug 2025 17:12:11 +0200 (CEST)
Received: from mail-m49234.qiye.163.com (mail-m49234.qiye.163.com
 [45.254.49.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3155C8380E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4ece;
 Sat, 30 Aug 2025 23:12:02 +0800 (GMT+08:00)
Message-ID: <cd38d27b-6dd4-4a7a-8fb7-9091fde75b62@rock-chips.com>
Date: Sat, 30 Aug 2025 23:12:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] clk: px30: Allow use of GPU and WIFI_PMU in
 assigned-clocks
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250713233429.1376172-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb8917b703afkunm338f69eb411baf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE1JVh5OGEhITB5JH0gdT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=PgS61QhrYoIjk/dOK9ej4nDSrmjBHdDo6yUub6VkejCeAo63MtZcG95hNrKvn0g8DqR1tuPFJqefdhZP4Qfo8uZcJSa81cXPuIS64LnEeQq36tcWOCyN8jW1LQN28tR6FxCtnPSDDOT43T5OYE9FvJ0AL3cXFSVV8VHumb3a29Y=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Hrj+xdzu2BYgUSmjTLVbTS1fDLu5uJwx17d7ehaIqEU=;
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


On 2025/7/14 07:33, Jonas Karlman wrote:
> Add dummy implementation of set_rate for SCLK_GPU and SCLK_WIFI_PMU to
> allow use of dts/upstream assigned-clocks in cru and pmucru nodes.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_px30.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
> index ad7e1c0f2460..b5054e84c326 100644
> --- a/drivers/clk/rockchip/clk_px30.c
> +++ b/drivers/clk/rockchip/clk_px30.c
> @@ -1360,6 +1360,9 @@ static ulong px30_clk_set_rate(struct clk *clk, ulong rate)
>   	case SCLK_GMAC_RMII:
>   		ret = px30_mac_set_speed_clk(priv, rate);
>   		break;
> +	/* Might occur in cru assigned-clocks, can be ignored here */
> +	case SCLK_GPU:
> +		break;
>   #endif
>   	default:
>   		return -ENOENT;
> @@ -1726,6 +1729,9 @@ static ulong px30_pmuclk_set_rate(struct clk *clk, ulong rate)
>   	case SCLK_UART0_PMU:
>   		ret = px30_pmu_uart0_set_clk(priv, rate);
>   		break;
> +	/* Might occur in pmucru assigned-clocks, can be ignored here */
> +	case SCLK_WIFI_PMU:
> +		break;
>   	default:
>   		return -ENOENT;
>   	}
