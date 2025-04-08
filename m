Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2B8C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C28E782CFA;
	Tue,  8 Apr 2025 05:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jGAes5gi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCE682CEB; Tue,  8 Apr 2025 05:17:27 +0200 (CEST)
Received: from mail-m32107.qiye.163.com (mail-m32107.qiye.163.com
 [220.197.32.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15C28318F
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101c6829;
 Tue, 8 Apr 2025 11:17:17 +0800 (GMT+08:00)
Message-ID: <c79a3771-bfb7-4a7a-8ac5-0c674c1eb6d5@rock-chips.com>
Date: Tue, 8 Apr 2025 11:17:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] pinctrl: rockchip: constify rockchip_pin_ctrl for
 RK3399
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <20250129-rockchip-pinctrl-const-v1-13-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-13-450ccdadfa7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJMHVZLT09PSkhMTkxPQkJWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961366f8ec03afkunm1101c6829
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nkk6Gio6KDJITEIjPz03FyMT
 HSgKCT9VSlVKTE9PS0NJSUhCT0xPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0hDNwY+
DKIM-Signature: a=rsa-sha256;
 b=jGAes5giuiKQ+aEKq0iE7DWhD7QBKzlGXJAGr8o9ksN/AXI9CGPSMWGA0xJ+pW3cgvSLGfOuXNYBX7Uu/YDyZCGdiscy8IO2xgWpc815Os8Tju+qLK7wbAOV7jgU1RHLpQS8EiRZDSfsORjoeEXLDKP5g23OI/qzh1hcO/lgn3s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=wMIj+EUBk3b6Fvi1YFkCLChkFKHJJ0IN+gDWwSMtS0Q=;
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


On 2025/1/29 20:42, Quentin Schulz wrote:
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
>   drivers/pinctrl/rockchip/pinctrl-rk3399.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3399.c b/drivers/pinctrl/rockchip/pinctrl-rk3399.c
> index b7a5092c032ba3bac0889921d9421bf0d3cd7277..928ed59aec6903fafa97ef6c3f95ad22422475fc 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3399.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3399.c
> @@ -279,7 +279,7 @@ static struct rockchip_pin_bank rk3399_pin_banks[] = {
>   			   ),
>   };
>   
> -static struct rockchip_pin_ctrl rk3399_pin_ctrl = {
> +static const struct rockchip_pin_ctrl rk3399_pin_ctrl = {
>   	.pin_banks		= rk3399_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3399_pin_banks),
>   	.grf_mux_offset		= 0xe000,
>
