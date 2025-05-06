Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2902C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F8B582163;
	Tue,  6 May 2025 09:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="O2BR88h4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3789D82161; Tue,  6 May 2025 09:55:37 +0200 (CEST)
Received: from mail-m12838.netease.com (mail-m12838.netease.com
 [103.209.128.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 081548288D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14172bff8;
 Tue, 6 May 2025 15:55:28 +0800 (GMT+08:00)
Message-ID: <e270f80d-dfb4-4e5b-8b10-a707ddc2b8a5@rock-chips.com>
Date: Tue, 6 May 2025 15:55:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] pinctrl: rockchip: constify rockchip_pin_ctrl
 for RK3066
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
 <20250131-rockchip-pinctrl-const-v2-4-59bf93968ce7@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250131-rockchip-pinctrl-const-v2-4-59bf93968ce7@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0JJVh9OSR1DHkJLTUsZSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96a497b72c03afkunm14172bff8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kwg6OSo4AzJIQhdWAxQqATkp
 KyowFBNVSlVKTE9NTkpDSkhKSkNCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlLTk03Bg++
DKIM-Signature: a=rsa-sha256;
 b=O2BR88h4hEdRB/ExoAGJ1sza+jiwMdx4ekOwnYDSAlHroly1W2BIGV/yazGE5ewI3QuvShkfGRERw3YUKDzTsuD8mhlHIibYY0//G6HMs2ZH/9WVMJ/eS/rqIMnR5H9qr2t/ocqYs0Tyxm4a0boF2vR+VVfi6wqJbtd5Y3TNmzo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=PovGCKserReK4WHPVTvXb4ocTitsp0VK6krWo16UTSw=;
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


On 2025/1/31 18:31, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> There's no need to modify private data from the controller, so let's
> make that struct const.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/pinctrl-rk3066.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3066.c b/drivers/pinctrl/rockchip/pinctrl-rk3066.c
> index 60e088a9a6f0d9133cd0822a9f4816cea18a524d..f773f2a3dab86dc866965cdcfd9b56da9e777acc 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3066.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3066.c
> @@ -82,7 +82,7 @@ static struct rockchip_pin_bank rk3066_pin_banks[] = {
>   	PIN_BANK(6, 16, "gpio6"),
>   };
>   
> -static struct rockchip_pin_ctrl rk3066_pin_ctrl = {
> +static const struct rockchip_pin_ctrl rk3066_pin_ctrl = {
>   	.pin_banks		= rk3066_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3066_pin_banks),
>   	.grf_mux_offset		= 0xa8,
>
