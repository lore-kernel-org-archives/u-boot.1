Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986CDC3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E1883346;
	Tue,  8 Apr 2025 05:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H8o3MdSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F9082CE7; Tue,  8 Apr 2025 05:24:37 +0200 (CEST)
Received: from mail-m32113.qiye.163.com (mail-m32113.qiye.163.com
 [220.197.32.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 106C8833E1
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208ce1;
 Tue, 8 Apr 2025 11:24:31 +0800 (GMT+08:00)
Message-ID: <73603e2d-966e-4535-9c82-f637e6cf843f@rock-chips.com>
Date: Tue, 8 Apr 2025 11:24:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/30] phy: rockchip-inno-usb2: Add support for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-28-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-28-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhhPT1ZPQhkdSR0eTEgYHUlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136d964103afkunm110208ce1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCI6Ogw*LzJWLUIfL04YPzYV
 PAhPFBNVSlVKTE9PS0NJTUxJT0hPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0pDNwY+
DKIM-Signature: a=rsa-sha256;
 b=H8o3MdSBWm8oS7TgMYq14/z2h02YVSUlqFQJ33orGLH8ZEorEY1uPAQY084OSy6+3T62ZJ2x1+rvrf+v1HO8HQlt4m5OBLpSMGXNMqZrG3w5opDdkTVe8r/3iJOpczkwwiN4+zxJZlkD+NBZJl6yL2BSuYZncj9/nCiGwfoh5FY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=IG/aVEtL0NBYTdS758khjM0sapDkHAcfqv7mvNTBWV0=;
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


On 2025/4/8 06:47, Jonas Karlman wrote:
> Add support for the two USB2.0 PHYs use in the RK3528 SoC.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index f40a86bc9dae..88b33de1b2a0 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -412,6 +412,22 @@ static const struct rockchip_usb2phy_cfg rk3399_usb2phy_cfgs[] = {
>   	{ /* sentinel */ }
>   };
>   
> +static const struct rockchip_usb2phy_cfg rk3528_phy_cfgs[] = {
> +	{
> +		.reg		= 0xffdf0000,
> +		.clkout_ctl_phy	= { 0x041c, 7, 2, 0, 0x27 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x004c, 1, 0, 2, 1 },
> +			},
> +			[USB2PHY_PORT_HOST] = {
> +				.phy_sus	= { 0x005c, 1, 0, 2, 1 },
> +			}
> +		},
> +	},
> +	{ /* sentinel */ }
> +};
> +
>   static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
>   	{
>   		.reg		= 0xfe8a0000,
> @@ -493,6 +509,10 @@ static const struct udevice_id rockchip_usb2phy_ids[] = {
>   		.compatible = "rockchip,rk3399-usb2phy",
>   		.data = (ulong)&rk3399_usb2phy_cfgs,
>   	},
> +	{
> +		.compatible = "rockchip,rk3528-usb2phy",
> +		.data = (ulong)&rk3528_phy_cfgs,
> +	},
>   	{
>   		.compatible = "rockchip,rk3568-usb2phy",
>   		.data = (ulong)&rk3568_phy_cfgs,
