Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA73CD6E55
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96021838D7;
	Sun, 31 May 2026 23:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="clL/k1dZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B346F840ED; Sun, 31 May 2026 23:28:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477548039B
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cd95=D5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1780262913;
 bh=8U5/PaNkuAysAOTTD1U7EHv51z2WL63te+3yxpZLgGw=;
 b=clL/k1dZMKN6AQgw1dk2F+CQoCVvygZ4rcaJ/RUfH+mQ4C6SzjCNb/Ra6M/FW5T2cBMjgd0yj
 0BAI2WoKrXzuj9PMfIJTOmJ9ZlgPwUPeO38U98Wc2fK3j3A3YtWXuoEPPP0cSLz6j2SLWnllK+k
 xIM7XCMGITGb4OjCRzokTUDzI6pyGGWKq6AlZn/pXdJfEJ7qZXJAAiyQEIIE1VQc+fX9tRrFWyW
 goDhabDPKgphx7VR4AjUkz9WOofBxQ9Vf3W6/ppubkDnAa5J1nlcHibW+aHEefEmezrhEUmnwFJ
 h0Q6lZJMozh5UEucmWIP1HGZeZ/YJ3ZJRGYciarLNq9w==
X-Forward-Email-ID: 6a1ca7f8ebb34a99f106780b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ecc58c70-084b-4c45-8b04-d2bcc586e034@kwiboo.se>
Date: Sun, 31 May 2026 23:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] usb: phy: remove rockchip_usb2_phy.c
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 trini@konsulko.com, hl@rock-chips.com, jernej.skrabec@gmail.com,
 w.egorov@phytec.de, jagan@amarulasolutions.com, heiko@sntech.de,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
 <2e44e865-42c0-4187-8d05-5c854624a179@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2e44e865-42c0-4187-8d05-5c854624a179@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Johan,

On 5/31/2026 11:03 PM, Johan Jonker wrote:
> Remove rockchip_usb2_phy.c and replace it by phy-rockchip-usb2.c
> Adjust defconfigs. Enable CONFIG_DM_RESET where needed to compile
> the phy driver. Add grf bind function for usbphy node.
> Remove a variable no longer needed from an include file.

This patch is trying to do too much at once, please split this into
something like:
- Add .bind = dm_scan_fdt_dev to syscon_rk drivers
- Adjust defconfigs to use the new phy driver
- Remove old code

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V3:
> rebase
> use CONFIG_IS_ENABLED
> 
> Changed V2 RESEND:
> Add include
> Add grf bind function
> Restyle
> ---
>  arch/arm/mach-rockchip/board.c                |  28 -----
>  arch/arm/mach-rockchip/rk3066/syscon_rk3066.c |  26 ++++
>  arch/arm/mach-rockchip/rk3188/syscon_rk3188.c |  27 +++++
>  arch/arm/mach-rockchip/rk3288/syscon_rk3288.c |  27 +++++
>  configs/chromebit_mickey_defconfig            |   2 +-
>  configs/chromebook_jerry_defconfig            |   2 +-
>  configs/chromebook_minnie_defconfig           |   2 +-
>  configs/chromebook_speedy_defconfig           |   2 +-
>  configs/evb-rk3288-rk808_defconfig            |   2 +-
>  configs/firefly-rk3288_defconfig              |   4 +-
>  configs/miqi-rk3288_defconfig                 |   4 +-
>  configs/mk808_defconfig                       |   2 +-
>  configs/phycore-rk3288_defconfig              |   3 +-
>  configs/popmetal-rk3288_defconfig             |   3 +-
>  configs/rock-pi-n8-rk3288_defconfig           |   2 +-
>  configs/rock2_defconfig                       |   3 +-
>  configs/rock_defconfig                        |   3 +-
>  configs/tinker-rk3288_defconfig               |   4 +-
>  configs/tinker-s-rk3288_defconfig             |   4 +-
>  configs/vyasa-rk3288_defconfig                |   2 +-
>  drivers/usb/phy/Kconfig                       |   3 -
>  drivers/usb/phy/Makefile                      |   1 -
>  drivers/usb/phy/rockchip_usb2_phy.c           | 113 ------------------
>  include/usb/dwc2_udc.h                        |   1 -
>  24 files changed, 104 insertions(+), 166 deletions(-)
>  delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

[snip]

> diff --git a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
> index ff269b53b542..27628b6749fe 100644
> --- a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
> +++ b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
> @@ -5,10 +5,33 @@
>   */
> 
>  #include <dm.h>
> +#include <dm/lists.h>
>  #include <log.h>
>  #include <syscon.h>
>  #include <asm/arch-rockchip/clock.h>
> 
> +#if CONFIG_IS_ENABLED(OF_REAL) && CONFIG_IS_ENABLED(PHY_ROCKCHIP_USB2)
> +static int rk3066_syscon_bind(struct udevice *dev)
> +{
> +	if (dev->driver_data == ROCKCHIP_SYSCON_GRF) {
> +		ofnode subnode = ofnode_find_subnode(dev_ofnode(dev), "usbphy");
> +
> +		if (ofnode_valid(subnode)) {
> +			struct udevice *usbphy_dev;
> +			int ret;
> +
> +			ret = device_bind_driver_to_node(dev, "rockchip_usbphy", "usbphy",
> +							 subnode, &usbphy_dev);
> +			if (ret)
> +				return ret;
> +
> +			usbphy_dev->driver_data = usbphy_dev->driver->of_match->data;
> +		}
> +	}
> +
> +	return 0;
> +}
> +#endif
>  static const struct udevice_id rk3066_syscon_ids[] = {
>  	{ .compatible = "rockchip,rk3066-noc", .data = ROCKCHIP_SYSCON_NOC },
>  	{ .compatible = "rockchip,rk3066-grf", .data = ROCKCHIP_SYSCON_GRF },
> @@ -20,6 +43,9 @@ U_BOOT_DRIVER(syscon_rk3066) = {
>  	.name = "rk3066_syscon",
>  	.id = UCLASS_SYSCON,
>  	.of_match = rk3066_syscon_ids,
> +#if CONFIG_IS_ENABLED(OF_REAL) && CONFIG_IS_ENABLED(PHY_ROCKCHIP_USB2)
> +	.bind = rk3066_syscon_bind,
> +#endif

Please use what the other rk syscon drivers are using:

#if CONFIG_IS_ENABLED(OF_REAL)
	.bind = dm_scan_fdt_dev,
#endif

Or are there any reason why you try to restrict this to just usbphy?

Regards,
Jonas

>  };
> 
>  #if CONFIG_IS_ENABLED(OF_PLATDATA)

[snip]
