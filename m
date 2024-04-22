Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCC0C07E8F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE5D88363;
	Mon, 22 Apr 2024 10:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZgDi/CYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C2D88366; Mon, 22 Apr 2024 10:46:20 +0200 (CEST)
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com
 [45.254.49.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5708717A
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ZgDi/CYN5EhvTI38YahQ/x5421wk2ixdpGXFi6jhFv8gtRjevib8as0GEBpvJzhfAAdsZL4mnte/m+B/ZK5f6a8g0ZAVALyW6derteMBejYlno+LXjUVIU7FXqDvvuBE7cc7YGFpjtqKXQrysvwhtdyjA242XHS6eBdPtcbykK8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=pPxdH+7gtLAop6ozPnhXdZaMjEc6HjLNUW57r73ycVw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DEA4E9002E2;
 Mon, 22 Apr 2024 16:46:05 +0800 (CST)
Message-ID: <814bcb73-ae23-4f9a-8021-f976e11eb6b9@rock-chips.com>
Date: Mon, 22 Apr 2024 16:46:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] phy: rockchip-inno-usb2: Add support for RK3308
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5ITVYaGh9CQ0NOTB8eS01VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04fbde8c03a9kunmdea4e9002e2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6Lgw4TTMCCDoKQhE2Niw*
 CixPCi9VSlVKTEpITExOTk1MSk5DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0JDNwY+
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


On 2024/4/9 02:14, Jonas Karlman wrote:
> Add clkout_ctl and phy_sus regs to support USB2PHY for RK3308.
>
> Based on linux commit 31f840e7ff3e ("phy: phy-rockchip-inno-usb2: add
> support for RK3308 USB phy").
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index d392aed2d4de..43f6e020a6a0 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -329,6 +329,22 @@ bind_fail:
>   	return ret;
>   }
>   
> +static const struct rockchip_usb2phy_cfg rk3308_phy_cfgs[] = {
> +	{
> +		.reg = 0x100,
> +		.clkout_ctl	= { 0x0108, 4, 4, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x0100, 1, 0, 2, 1 },
> +			},
> +			[USB2PHY_PORT_HOST] = {
> +				.phy_sus	= { 0x0104, 1, 0, 2, 1 },
> +			}
> +		},
> +	},
> +	{ /* sentinel */ }
> +};
> +
>   static const struct rockchip_usb2phy_cfg rk3328_usb2phy_cfgs[] = {
>   	{
>   		.reg = 0x100,
> @@ -442,6 +458,10 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>   };
>   
>   static const struct udevice_id rockchip_usb2phy_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3308-usb2phy",
> +		.data = (ulong)&rk3308_phy_cfgs,
> +	},
>   	{
>   		.compatible = "rockchip,rk3328-usb2phy",
>   		.data = (ulong)&rk3328_usb2phy_cfgs,
