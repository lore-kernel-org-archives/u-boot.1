Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0D2C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 09:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A60B88044;
	Fri,  8 Mar 2024 10:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fLuuAaFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126C588087; Fri,  8 Mar 2024 10:06:18 +0100 (CET)
Received: from mail-m127229.xmail.ntesmail.com
 (mail-m127229.xmail.ntesmail.com [115.236.127.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B184787D60
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 10:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fLuuAaFS9Xc3PwcMztbSApoCCeajGMjHmrx1BD2l7ayVi4OaAt1mAUAC2K8nLNWf5Ojh+amoYT94rwzwxCcxu9EzV3pMX8BUolusjRxDtl46FWQ5UI9NUG9mlzuAkj20ZwlI1lXbz9rW3g6KCP9agS0nohAxp29DvV5IZgolxHo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=bBmnbyfXiTVpAm7MJKz+/2eip0/rXuyNPEmeSoi2eWo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C671B9002F0;
 Fri,  8 Mar 2024 17:06:02 +0800 (CST)
Message-ID: <be69d1f3-9406-44d7-9a3c-c90be48d5ae5@rock-chips.com>
Date: Fri, 8 Mar 2024 17:06:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: rockchip-inno-usb2: Limit changes made to regs
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, wulf <wulf@rock-chips.com>,
 =?UTF-8?B?546L5piO5oiQ?= <frank.wang@rock-chips.com>
References: <20240225221024.1974853-1-jonas@kwiboo.se>
 <20240225221024.1974853-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240225221024.1974853-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlMT1ZNGUoYHR1PH0tCTUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8e1d4ff52d03a9kunmc671b9002f0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6LCo*FTMPTz4DSFZOSDYt
 A0NPCkpVSlVKTEtCQ0NDTE1ITE1NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSktPSjcG
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

Hi Jonas,

On 2024/2/26 06:10, Jonas Karlman wrote:
> The USB2PHY regs already contain working default reset values for RK3328
> and RK35xx as evidenced by the fact that this driver never has changed a
> single value for these SoCs.

I would prefer to keep it as is for now, I think these configs are 
needed for the phy init,

but I'm not sure these configs are all default correct after sw/hw  
reset/reboot and for

all the SoC versions.

> Reduce to only configure utmi_suspend_n and utmi_sel bits similar to
> what is currently done on RK3399.
I don't understand, you also remove configs for rk3399 in this patch, 
isn't it?
> Also add missing clkout_ctl for RK3588.
This is necessary, would be better  send as a separate patch.
>
> When enabled utmi_suspend_n is changed to normal mode and utmi_sel to
> use otg/host controller utmi interface to phy. When disabled
> utmi_suspend_n is changed to suspend mode and utmi_sel to use GRF utmi
> interface to phy.

I don't understand this change for not much knowledge on utmi interface, 
any issue if we use the old config?

If necessary, should send as a separate patch.


Thanks,
- Kever
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 117 +++---------------
>   1 file changed, 14 insertions(+), 103 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 7317128d135e..d392aed2d4de 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -35,16 +35,6 @@ struct usb2phy_reg {
>   
>   struct rockchip_usb2phy_port_cfg {
>   	struct usb2phy_reg	phy_sus;
> -	struct usb2phy_reg	bvalid_det_en;
> -	struct usb2phy_reg	bvalid_det_st;
> -	struct usb2phy_reg	bvalid_det_clr;
> -	struct usb2phy_reg	ls_det_en;
> -	struct usb2phy_reg	ls_det_st;
> -	struct usb2phy_reg	ls_det_clr;
> -	struct usb2phy_reg	utmi_avalid;
> -	struct usb2phy_reg	utmi_bvalid;
> -	struct usb2phy_reg	utmi_ls;
> -	struct usb2phy_reg	utmi_hstdet;
>   };
>   
>   struct rockchip_usb2phy_cfg {
> @@ -131,7 +121,6 @@ static int rockchip_usb2phy_init(struct phy *phy)
>   {
>   	struct udevice *parent = dev_get_parent(phy->dev);
>   	struct rockchip_usb2phy *priv = dev_get_priv(parent);
> -	const struct rockchip_usb2phy_port_cfg *port_cfg = us2phy_get_port(phy);
>   	int ret;
>   
>   	ret = clk_enable(&priv->phyclk);
> @@ -140,14 +129,6 @@ static int rockchip_usb2phy_init(struct phy *phy)
>   		return ret;
>   	}
>   
> -	if (phy->id == USB2PHY_PORT_OTG) {
> -		property_enable(priv->reg_base, &port_cfg->bvalid_det_clr, true);
> -		property_enable(priv->reg_base, &port_cfg->bvalid_det_en, true);
> -	} else if (phy->id == USB2PHY_PORT_HOST) {
> -		property_enable(priv->reg_base, &port_cfg->bvalid_det_clr, true);
> -		property_enable(priv->reg_base, &port_cfg->bvalid_det_en, true);
> -	}
> -
>   	return 0;
>   }
>   
> @@ -351,27 +332,13 @@ bind_fail:
>   static const struct rockchip_usb2phy_cfg rk3328_usb2phy_cfgs[] = {
>   	{
>   		.reg = 0x100,
> -		.clkout_ctl	= { 0x108, 4, 4, 1, 0 },
> +		.clkout_ctl	= { 0x0108, 4, 4, 1, 0 },
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_OTG] = {
> -				.phy_sus	= { 0x0100, 15, 0, 0, 0x1d1 },
> -				.bvalid_det_en	= { 0x0110, 3, 2, 0, 3 },
> -				.bvalid_det_st	= { 0x0114, 3, 2, 0, 3 },
> -				.bvalid_det_clr = { 0x0118, 3, 2, 0, 3 },
> -				.ls_det_en	= { 0x0110, 0, 0, 0, 1 },
> -				.ls_det_st	= { 0x0114, 0, 0, 0, 1 },
> -				.ls_det_clr	= { 0x0118, 0, 0, 0, 1 },
> -				.utmi_avalid	= { 0x0120, 10, 10, 0, 1 },
> -				.utmi_bvalid	= { 0x0120, 9, 9, 0, 1 },
> -				.utmi_ls	= { 0x0120, 5, 4, 0, 1 },
> +				.phy_sus	= { 0x0100, 1, 0, 2, 1 },
>   			},
>   			[USB2PHY_PORT_HOST] = {
> -				.phy_sus	= { 0x104, 15, 0, 0, 0x1d1 },
> -				.ls_det_en	= { 0x110, 1, 1, 0, 1 },
> -				.ls_det_st	= { 0x114, 1, 1, 0, 1 },
> -				.ls_det_clr	= { 0x118, 1, 1, 0, 1 },
> -				.utmi_ls	= { 0x120, 17, 16, 0, 1 },
> -				.utmi_hstdet	= { 0x120, 19, 19, 0, 1 }
> +				.phy_sus	= { 0x0104, 1, 0, 2, 1 },
>   			}
>   		},
>   	},
> @@ -385,19 +352,9 @@ static const struct rockchip_usb2phy_cfg rk3399_usb2phy_cfgs[] = {
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_OTG] = {
>   				.phy_sus	= { 0xe454, 1, 0, 2, 1 },
> -				.bvalid_det_en	= { 0xe3c0, 3, 3, 0, 1 },
> -				.bvalid_det_st	= { 0xe3e0, 3, 3, 0, 1 },
> -				.bvalid_det_clr	= { 0xe3d0, 3, 3, 0, 1 },
> -				.utmi_avalid	= { 0xe2ac, 7, 7, 0, 1 },
> -				.utmi_bvalid	= { 0xe2ac, 12, 12, 0, 1 },
>   			},
>   			[USB2PHY_PORT_HOST] = {
> -				.phy_sus	= { 0xe458, 1, 0, 0x2, 0x1 },
> -				.ls_det_en	= { 0xe3c0, 6, 6, 0, 1 },
> -				.ls_det_st	= { 0xe3e0, 6, 6, 0, 1 },
> -				.ls_det_clr	= { 0xe3d0, 6, 6, 0, 1 },
> -				.utmi_ls	= { 0xe2ac, 22, 21, 0, 1 },
> -				.utmi_hstdet	= { 0xe2ac, 23, 23, 0, 1 }
> +				.phy_sus	= { 0xe458, 1, 0, 2, 1 },
>   			}
>   		},
>   	},
> @@ -407,19 +364,9 @@ static const struct rockchip_usb2phy_cfg rk3399_usb2phy_cfgs[] = {
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_OTG] = {
>   				.phy_sus        = { 0xe464, 1, 0, 2, 1 },
> -				.bvalid_det_en  = { 0xe3c0, 8, 8, 0, 1 },
> -				.bvalid_det_st  = { 0xe3e0, 8, 8, 0, 1 },
> -				.bvalid_det_clr = { 0xe3d0, 8, 8, 0, 1 },
> -				.utmi_avalid	= { 0xe2ac, 10, 10, 0, 1 },
> -				.utmi_bvalid    = { 0xe2ac, 16, 16, 0, 1 },
>   			},
>   			[USB2PHY_PORT_HOST] = {
> -				.phy_sus	= { 0xe468, 1, 0, 0x2, 0x1 },
> -				.ls_det_en	= { 0xe3c0, 11, 11, 0, 1 },
> -				.ls_det_st	= { 0xe3e0, 11, 11, 0, 1 },
> -				.ls_det_clr	= { 0xe3d0, 11, 11, 0, 1 },
> -				.utmi_ls	= { 0xe2ac, 26, 25, 0, 1 },
> -				.utmi_hstdet	= { 0xe2ac, 27, 27, 0, 1 }
> +				.phy_sus	= { 0xe468, 1, 0, 2, 1 },
>   			}
>   		},
>   	},
> @@ -432,24 +379,10 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
>   		.clkout_ctl	= { 0x0008, 4, 4, 1, 0 },
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_OTG] = {
> -				.phy_sus	= { 0x0000, 8, 0, 0x052, 0x1d1 },
> -				.bvalid_det_en	= { 0x0080, 2, 2, 0, 1 },
> -				.bvalid_det_st	= { 0x0084, 2, 2, 0, 1 },
> -				.bvalid_det_clr = { 0x0088, 2, 2, 0, 1 },
> -				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
> -				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
> -				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
> -				.utmi_avalid	= { 0x00c0, 10, 10, 0, 1 },
> -				.utmi_bvalid	= { 0x00c0, 9, 9, 0, 1 },
> -				.utmi_ls	= { 0x00c0, 5, 4, 0, 1 },
> +				.phy_sus	= { 0x0000, 1, 0, 2, 1 },
>   			},
>   			[USB2PHY_PORT_HOST] = {
> -				.phy_sus	= { 0x0004, 8, 0, 0x1d2, 0x1d1 },
> -				.ls_det_en	= { 0x0080, 1, 1, 0, 1 },
> -				.ls_det_st	= { 0x0084, 1, 1, 0, 1 },
> -				.ls_det_clr	= { 0x0088, 1, 1, 0, 1 },
> -				.utmi_ls	= { 0x00c0, 17, 16, 0, 1 },
> -				.utmi_hstdet	= { 0x00c0, 19, 19, 0, 1 }
> +				.phy_sus	= { 0x0004, 1, 0, 2, 1 },
>   			}
>   		},
>   	},
> @@ -458,20 +391,10 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
>   		.clkout_ctl	= { 0x0008, 4, 4, 1, 0 },
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_OTG] = {
> -				.phy_sus	= { 0x0000, 8, 0, 0x1d2, 0x1d1 },
> -				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
> -				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
> -				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
> -				.utmi_ls	= { 0x00c0, 5, 4, 0, 1 },
> -				.utmi_hstdet	= { 0x00c0, 7, 7, 0, 1 }
> +				.phy_sus	= { 0x0000, 1, 0, 2, 1 },
>   			},
>   			[USB2PHY_PORT_HOST] = {
> -				.phy_sus	= { 0x0004, 8, 0, 0x1d2, 0x1d1 },
> -				.ls_det_en	= { 0x0080, 1, 1, 0, 1 },
> -				.ls_det_st	= { 0x0084, 1, 1, 0, 1 },
> -				.ls_det_clr	= { 0x0088, 1, 1, 0, 1 },
> -				.utmi_ls	= { 0x00c0, 17, 16, 0, 1 },
> -				.utmi_hstdet	= { 0x00c0, 19, 19, 0, 1 }
> +				.phy_sus	= { 0x0004, 1, 0, 2, 1 },
>   			}
>   		},
>   	},
> @@ -481,49 +404,37 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
>   static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>   	{
>   		.reg		= 0x0000,
> +		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_OTG] = {
>   				.phy_sus	= { 0x000c, 11, 11, 0, 1 },
> -				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
> -				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
> -				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
> -				.utmi_ls	= { 0x00c0, 10, 9, 0, 1 },
>   			}
>   		},
>   	},
>   	{
>   		.reg		= 0x4000,
> +		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_OTG] = {
> -				.phy_sus	= { 0x000c, 11, 11, 0, 0 },
> -				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
> -				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
> -				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
> -				.utmi_ls	= { 0x00c0, 10, 9, 0, 1 },
> +				.phy_sus	= { 0x000c, 11, 11, 0, 1 },
>   			}
>   		},
>   	},
>   	{
>   		.reg		= 0x8000,
> +		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_HOST] = {
>   				.phy_sus	= { 0x0008, 2, 2, 0, 1 },
> -				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
> -				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
> -				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
> -				.utmi_ls	= { 0x00c0, 10, 9, 0, 1 },
>   			}
>   		},
>   	},
>   	{
>   		.reg		= 0xc000,
> +		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
>   		.port_cfgs	= {
>   			[USB2PHY_PORT_HOST] = {
>   				.phy_sus	= { 0x0008, 2, 2, 0, 1 },
> -				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
> -				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
> -				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
> -				.utmi_ls	= { 0x00c0, 10, 9, 0, 1 },
>   			}
>   		},
>   	},
