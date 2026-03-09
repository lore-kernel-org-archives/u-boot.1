Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE18F417E7
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5A883FC8;
	Mon,  9 Mar 2026 15:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MYs2q1IJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8940583F6D; Mon,  9 Mar 2026 15:39:39 +0100 (CET)
Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com
 [101.71.155.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C60A83FD9
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e8280;
 Mon, 9 Mar 2026 22:39:33 +0800 (GMT+08:00)
Message-ID: <d307cd81-50f4-4ec0-a60f-6b30078a25b4@rock-chips.com>
Date: Mon, 9 Mar 2026 22:39:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] phy: rockchip-inno-usb2: Add support for RK3506
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260131233843.3419737-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd309ff2803afkunm90fa28bf16bc628
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0sYVhofSEpIGUhIGEhLSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=MYs2q1IJqKubcDZV9ZG/kYvw09N9YZQrYiCqcGJRpkZjgW512Zk+KTAg4dplUHgfkJaEhI5WUHlkjNh+YMq/iI5eukRVvttMMTYTh5sC8Jk50LPvhrDayTTN8f4PsCdv4CDX5baG40MJcR6C3M3Pks2QfDndxNr8RMI790GUT0E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=q2KKfXDLgzIhG8gmXchM3VtrdgvhpGFxFAB52uVl1MU=;
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


On 2026/2/1 07:38, Jonas Karlman wrote:
> Add support for the two USB2.0 PHYs use in the RK3506 SoC.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Aaron Griffith <aargri@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Collect t-b tag
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 4ea6600ce7f5..f80b2789333d 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -421,6 +421,22 @@ static const struct rockchip_usb2phy_cfg rk3399_usb2phy_cfgs[] = {
>   	{ /* sentinel */ }
>   };
>   
> +static const struct rockchip_usb2phy_cfg rk3506_phy_cfgs[] = {
> +	{
> +		.reg		= 0xff2b0000,
> +		.clkout_ctl_phy = { 0x041c, 7, 2, 0, 0x27 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x0060, 1, 0, 2, 1 },
> +			},
> +			[USB2PHY_PORT_HOST] = {
> +				.phy_sus	= { 0x0070, 1, 0, 2, 1 },
> +			}
> +		},
> +	},
> +	{ /* sentinel */ }
> +};
> +
>   static const struct rockchip_usb2phy_cfg rk3528_phy_cfgs[] = {
>   	{
>   		.reg		= 0xffdf0000,
> @@ -540,6 +556,10 @@ static const struct udevice_id rockchip_usb2phy_ids[] = {
>   		.compatible = "rockchip,rk3399-usb2phy",
>   		.data = (ulong)&rk3399_usb2phy_cfgs,
>   	},
> +	{
> +		.compatible = "rockchip,rk3506-usb2phy",
> +		.data = (ulong)&rk3506_phy_cfgs,
> +	},
>   	{
>   		.compatible = "rockchip,rk3528-usb2phy",
>   		.data = (ulong)&rk3528_phy_cfgs,
