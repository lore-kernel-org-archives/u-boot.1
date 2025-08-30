Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C160CA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9F54838B7;
	Sat, 30 Aug 2025 16:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UgyzWXo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5A38380E; Sat, 30 Aug 2025 16:57:09 +0200 (CEST)
Received: from mail-m49210.qiye.163.com (mail-m49210.qiye.163.com
 [45.254.49.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5594D838BB
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4c6a;
 Sat, 30 Aug 2025 22:57:01 +0800 (GMT+08:00)
Message-ID: <414c2843-d26c-446d-aad9-622c2edff264@rock-chips.com>
Date: Sat, 30 Aug 2025 22:57:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] phy: rockchip-inno-usb2: Add support for RK3576
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Frank Wang <frank.wang@rock-chips.com>
References: <20250801203255.2590535-1-jonas@kwiboo.se>
 <20250801203255.2590535-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250801203255.2590535-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb7b57fb03afkunm78bbb62a40d616
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTkweVk4YH0hIGBhIGEJMT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=UgyzWXo8q0yyRvr2ICoT3g4WBwHXggrbnUJM+MBxDqmGpQhuE5f9FS6vtRPXZ7dU3wa6ekvR3P0yiSwaBjcLD7xHHPCtARB4wmJZcQG/bIByicxNhMA6BUd+Lo/yGN7NqHhLzgJcXNSqpHmYqCvna3l22JJ8R+IKutNx3HeaSRw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=L19IcjvaYqKDq03Jh5WHGa70r2xs6z75GhVULW+re4I=;
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


On 2025/8/2 04:32, Jonas Karlman wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
>
> Add support for the USB2.0 PHYs used in the RK3576 SoC.
>
> Config values are taken from vendor U-Boot linux-6.1-stan-rkr5 tag.
>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: New patch
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index a3222138b9d0..4ea6600ce7f5 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -465,6 +465,28 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
>   	{ /* sentinel */ }
>   };
>   
> +static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
> +	{
> +		.reg		= 0x0000,
> +		.clkout_ctl	= { 0x0008, 0, 0, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x0000, 1, 0, 2, 1 },
> +			}
> +		},
> +	},
> +	{
> +		.reg		= 0x2000,
> +		.clkout_ctl	= { 0x2008, 0, 0, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x2000, 1, 0, 2, 1 },
> +			}
> +		},
> +	},
> +	{ /* sentinel */ }
> +};
> +
>   static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>   	{
>   		.reg		= 0x0000,
> @@ -526,6 +548,10 @@ static const struct udevice_id rockchip_usb2phy_ids[] = {
>   		.compatible = "rockchip,rk3568-usb2phy",
>   		.data = (ulong)&rk3568_phy_cfgs,
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-usb2phy",
> +		.data = (ulong)&rk3576_phy_cfgs,
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-usb2phy",
>   		.data = (ulong)&rk3588_phy_cfgs,
