Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A634BC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364F888755;
	Fri,  9 Aug 2024 11:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QgsqSLkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFBE88755; Fri,  9 Aug 2024 11:37:34 +0200 (CEST)
Received: from mail-m12767.qiye.163.com (mail-m12767.qiye.163.com
 [115.236.127.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC3F88581
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QgsqSLkCdY6HbcMHBVZGUooYgBMd0vLsy+5j0dC0sVbOAOkyKda0Ki0+YAMo6IkJFOk+CjIDtOI8dkDwvuus9bEv0avIbI/1Z/XcmxSnRVPMhzR1Vcr442Nfk4q+/Eumwb6ro1tsYqpXYIPtxgfnIfIqmAYKu3iUhkpGUG1vrDo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=4aBD5fv1YjWQrDngiz5eOK8DlUoQJeCQntGwzz8jV6s=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7496090018E;
 Fri,  9 Aug 2024 17:37:22 +0800 (CST)
Message-ID: <cefdebf7-a250-4638-8623-4b173b537e26@rock-chips.com>
Date: Fri, 9 Aug 2024 17:37:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] pinctrl: rockchip: Add gpio_request_enable() ops
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802225705.2640999-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDShoYVh9OHUhKHR5DHUxJQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91367ffc2303a9kunm7496090018e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PU06Dzo6MDI3Dw5IPT89OkIx
 ATEaFBxVSlVKTElISkJNSU9ITklOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhLTUs3Bg++
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


On 2024/8/3 06:56, Jonas Karlman wrote:
> Implement gpio_request_enable() ops so that the gpio request() ops can
> be implemented and a gpio requested pin automatically is pinmuxed for
> gpio use, similar to Linux kernel.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch from "rockchip: Add gpio request() ops" series
> ---
>   drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index 345e0abdf5d1..e164af0d8f61 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -358,6 +358,18 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
>   	return 0;
>   }
>   
> +static int rockchip_pinctrl_gpio_request_enable(struct udevice *dev,
> +						unsigned int selector)
> +{
> +	struct rockchip_pin_bank *bank;
> +
> +	bank = rockchip_pin_to_bank(dev, selector);
> +	if (!bank)
> +		return -EINVAL;
> +
> +	return rockchip_set_mux(bank, selector - bank->pin_base, RK_FUNC_GPIO);
> +}
> +
>   static int rockchip_perpin_drv_list[DRV_TYPE_MAX][8] = {
>   	{ 2, 4, 8, 12, -1, -1, -1, -1 },
>   	{ 3, 6, 9, 12, -1, -1, -1, -1 },
> @@ -608,6 +620,7 @@ const struct pinctrl_ops rockchip_pinctrl_ops = {
>   	.set_state			= rockchip_pinctrl_set_state,
>   	.get_gpio_mux			= rockchip_pinctrl_get_gpio_mux,
>   	.get_pin_muxing			= rockchip_pinctrl_get_pin_muxing,
> +	.gpio_request_enable		= rockchip_pinctrl_gpio_request_enable,
>   };
>   
>   /* retrieve the soc specific data */
