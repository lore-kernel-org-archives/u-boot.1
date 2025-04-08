Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1DBC3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7750D82F29;
	Tue,  8 Apr 2025 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y7xMDtuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663DB82F29; Tue,  8 Apr 2025 05:17:19 +0200 (CEST)
Received: from mail-m3283.qiye.163.com (mail-m3283.qiye.163.com
 [220.197.32.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC327830EE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101c67f9;
 Tue, 8 Apr 2025 11:17:10 +0800 (GMT+08:00)
Message-ID: <8be6033b-8496-4900-89c1-679e483ac951@rock-chips.com>
Date: Tue, 8 Apr 2025 11:17:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] pinctrl: rockchip: constify rockchip_pin_ctrl for
 RK3368
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <20250129-rockchip-pinctrl-const-v1-12-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-12-450ccdadfa7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MZT1ZPGR4ZHh9DSEwZQh9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961366ddd203afkunm1101c67f9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oio6Nzo4NTJCA0IwATw#FzdK
 SEgwFA1VSlVKTE9PS0NJSUhJSEhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS05INwY+
DKIM-Signature: a=rsa-sha256;
 b=Y7xMDtuzvS2O99q0tOGX0a/flNIfx0ulrP+yBKCe+ZGvIi0Bp8HaTcrQaum7C19ZuiTwcGwPH/VZesApEAI9351ztWyyGH9t89t+H7pA/nV3eZUBS2FMXdjyAwx9pbB2uwLeNjaS5xXX7wTubGddrvQwvhru68QOla0omO3zMOM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=tRbKRTkucPs4WE4+QOyRAXB/6TDisQEpZt+mrIUeLK4=;
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
>   drivers/pinctrl/rockchip/pinctrl-rk3368.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3368.c b/drivers/pinctrl/rockchip/pinctrl-rk3368.c
> index 9ae06ed19e9cda76f6d466fce2e01f48520a668a..aaf24719a16e191478ea407846bd50fc4cd29210 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3368.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3368.c
> @@ -152,7 +152,7 @@ static struct rockchip_pin_bank rk3368_pin_banks[] = {
>   	PIN_BANK(3, 32, "gpio3"),
>   };
>   
> -static struct rockchip_pin_ctrl rk3368_pin_ctrl = {
> +static const struct rockchip_pin_ctrl rk3368_pin_ctrl = {
>   	.pin_banks		= rk3368_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3368_pin_banks),
>   	.grf_mux_offset		= 0x0,
>
