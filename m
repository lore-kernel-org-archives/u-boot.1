Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53100C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D431780F32;
	Wed, 19 Feb 2025 16:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aFsix7Jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4021880F5F; Wed, 19 Feb 2025 16:24:31 +0100 (CET)
Received: from mail-m32103.qiye.163.com (mail-m32103.qiye.163.com
 [220.197.32.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84FF801BE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f93d95;
 Wed, 19 Feb 2025 23:24:23 +0800 (GMT+08:00)
Message-ID: <c8de17ff-c25e-46b0-b8ef-bfab1426d00d@rock-chips.com>
Date: Wed, 19 Feb 2025 23:24:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: rockchip: rk3328: Fix pinmux for GPIO2-B and
 GPIO3-B pins
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250106213944.3796172-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250106213944.3796172-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0IZVhhJGkxLQh9CHR0YT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951ecf654403afkunmb8f93d95
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxA6KTo5KDIcGS4OESsuHhAJ
 FiowCR9VSlVKTEhCQkxDTU1IQ01IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUlCSkg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=aFsix7JqEpkFB+Zfgg23bKRhGx03mVySatJKqGeYXpBZQWnZvTGOrw2nMjiRoOm+TNiU36/b462bbT7NTiXdWK++iWqRGMDVV8K0iuQ4d0+BquEMu8uNmvDrravKbMm4t2CCz9z72yJEv6qghY10yidc4jD/9pXblFn6oYies0Q=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=2EhH2o/q34ggdJSpc1ANzCbt6Xcyz+EPcT0iT5y0yq4=;
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


On 2025/1/7 05:39, Jonas Karlman wrote:
> The pinmux bits for GPIO2-B0 to GPIO2-B6 actually have 2 bits width,
> correct the bank flag for GPIO2-B. The pinmux bits for GPIO2-B7 is
> recalculated so it remain unchanged. Add missing GPIO3-B1 to GPIO3-B7
> pinmux data to rk3328_mux_recalced_data as mux register offset for these
> pins does not follow rockchip convention.
>
> This matches changes in following Linux commits:
> - e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins")
> - 5ef6914e0bf5 ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins")
> - 128f71fe014f ("pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins")
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/pinctrl-rk3328.c | 59 ++++++++++++++++++++---
>   1 file changed, 52 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3328.c b/drivers/pinctrl/rockchip/pinctrl-rk3328.c
> index 47c2e923a1bb..dd0dc2eff270 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3328.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3328.c
> @@ -14,23 +14,68 @@
>   
>   static struct rockchip_mux_recalced_data rk3328_mux_recalced_data[] = {
>   	{
> -		.num = 2,
> -		.pin = 12,
> -		.reg = 0x24,
> -		.bit = 8,
> -		.mask = 0x3
> -	}, {
> +		/* gpio2_b7_sel */
>   		.num = 2,
>   		.pin = 15,
>   		.reg = 0x28,
>   		.bit = 0,
>   		.mask = 0x7
>   	}, {
> +		/* gpio2_c7_sel */
>   		.num = 2,
>   		.pin = 23,
>   		.reg = 0x30,
>   		.bit = 14,
>   		.mask = 0x3
> +	}, {
> +		/* gpio3_b1_sel */
> +		.num = 3,
> +		.pin = 9,
> +		.reg = 0x44,
> +		.bit = 2,
> +		.mask = 0x3
> +	}, {
> +		/* gpio3_b2_sel */
> +		.num = 3,
> +		.pin = 10,
> +		.reg = 0x44,
> +		.bit = 4,
> +		.mask = 0x3
> +	}, {
> +		/* gpio3_b3_sel */
> +		.num = 3,
> +		.pin = 11,
> +		.reg = 0x44,
> +		.bit = 6,
> +		.mask = 0x3
> +	}, {
> +		/* gpio3_b4_sel */
> +		.num = 3,
> +		.pin = 12,
> +		.reg = 0x44,
> +		.bit = 8,
> +		.mask = 0x3
> +	}, {
> +		/* gpio3_b5_sel */
> +		.num = 3,
> +		.pin = 13,
> +		.reg = 0x44,
> +		.bit = 10,
> +		.mask = 0x3
> +	}, {
> +		/* gpio3_b6_sel */
> +		.num = 3,
> +		.pin = 14,
> +		.reg = 0x44,
> +		.bit = 12,
> +		.mask = 0x3
> +	}, {
> +		/* gpio3_b7_sel */
> +		.num = 3,
> +		.pin = 15,
> +		.reg = 0x44,
> +		.bit = 14,
> +		.mask = 0x3
>   	},
>   };
>   
> @@ -275,7 +320,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
>   	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
>   	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
>   	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
> -			     IOMUX_WIDTH_3BIT,
> +			     IOMUX_8WIDTH_2BIT,
>   			     IOMUX_WIDTH_3BIT,
>   			     0),
>   	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",
