Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAE5C47DB3
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 00:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09A7C87C3B;
	Tue, 30 Jan 2024 01:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD3687C5B; Tue, 30 Jan 2024 01:10:59 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D70C287C3B
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 01:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33E55DA7;
 Mon, 29 Jan 2024 16:11:40 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE9EC3F738;
 Mon, 29 Jan 2024 16:10:54 -0800 (PST)
Date: Tue, 30 Jan 2024 00:09:40 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Icenowy Zheng
 <icenowy@aosc.xyz>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai
 <wens@csie.org>, Adam Sampson <ats@offog.org>, Stefan Roese <sr@denx.de>,
 Maxime Ripard <mripard@kernel.org>, u-boot@lists.denx.de, Joe Hershberger
 <joe.hershberger@ni.com>
Subject: Re: [PATCH 3/5] phy: sun4i-usb: Control supplies via the regulator
 uclass
Message-ID: <20240129235520.12a7883f@minigeek.lan>
In-Reply-To: <20231031064039.50942-4-samuel@sholland.org>
References: <20231031064039.50942-1-samuel@sholland.org>
 <20231031064039.50942-4-samuel@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 31 Oct 2023 01:39:53 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> The device tree binding for the PHY provides VBUS supplies as regulator
> references. Now that all boards have the appropriate regulator uclass
> drivers enabled, the PHY driver can switch to using them. This replaces
> direct GPIO usage, which in some cases needed a special DM-incompatible
> "virtual" GPIO from the PMIC.

I like that one, avoids one more Kconfig duplicate.
Testing this revealed one problem, though:

> The following boards provided a value for CONFIG_USB0_VBUS_PIN, but are
> missing the "usb0_vbus-supply" property in their device tree. None of
> them have the MUSB controller enabled in host or OTG mode, so they
> should see no impact:
>  - Ainol_AW1_defconfig / sun7i-a20-ainol-aw1
>  - Ampe_A76_defconfig / sun5i-a13-ampe-a76
>  - CHIP_pro_defconfig / sun5i-gr8-chip-pro
>  - Cubieboard4_defconfig / sun9i-a80-cubieboard4
>  - Merrii_A80_Optimus_defconfig / sun9i-a80-optimus
>  - Sunchip_CX-A99_defconfig / sun9i-a80-cx-a99
>  - Yones_Toptech_BD1078_defconfig / sun7i-a20-yones-toptech-bd1078
>  - Yones_Toptech_BS1078_V2_defconfig /
>    sun6i-a31s-yones-toptech-bs1078-v2
>  - iNet_3F_defconfig / sun4i-a10-inet-3f
>  - iNet_3W_defconfig / sun4i-a10-inet-3w
>  - iNet_86VS_defconfig / sun5i-a13-inet-86vs
>  - iNet_D978_rev2_defconfig / sun8i-a33-inet-d978-rev2
>  - icnova-a20-swac_defconfig / sun7i-a20-icnova-swac
>  - sun8i_a23_evb_defconfig / sun8i-a23-evb
> 
> Similarly, the following boards set CONFIG_USB1_VBUS_PIN, but do not
> have "usb1_vbus-supply" in their device tree. Neither of them have USB
> enabled at all, so again there should be no impact:
>  - Cubieboard4_defconfig / sun9i-a80-cubieboard4 (also for USB3)
>  - sun8i_a23_evb_defconfig / sun8i-a23-evb
> 
> The following boards use a different pin for USB1 VBUS between their
> defconfig and their device tree. Depending on which is correct, they
> may be broken:
>  - Linksprite_pcDuino3_Nano_defconfig (PH11) /
>    sun7i-a20-pcduino3-nano (PD2)
>  - icnova-a20-swac_defconfig (PG10) / sun7i-a20-icnova-swac (PH6)
> 
> Finally, this board has conflicting pins given for its USB2 VBUS:
>  - Lamobo_R1_defconfig (PH3) / sun7i-a20-lamobo-r1 (PH12)
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/phy/allwinner/phy-sun4i-usb.c | 41 +++++++++++++--------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 6624e9134f4..dc34b828a3a 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -87,27 +87,22 @@ struct sun4i_usb_phy_cfg {
>  };
>  
>  struct sun4i_usb_phy_info {
> -	const char *gpio_vbus;
>  	const char *gpio_vbus_det;
>  	const char *gpio_id_det;
>  } phy_info[] = {
>  	{
> -		.gpio_vbus = CONFIG_USB0_VBUS_PIN,
>  		.gpio_vbus_det = CONFIG_USB0_VBUS_DET,
>  		.gpio_id_det = CONFIG_USB0_ID_DET,
>  	},
>  	{
> -		.gpio_vbus = CONFIG_USB1_VBUS_PIN,
>  		.gpio_vbus_det = NULL,
>  		.gpio_id_det = NULL,
>  	},
>  	{
> -		.gpio_vbus = CONFIG_USB2_VBUS_PIN,
>  		.gpio_vbus_det = NULL,
>  		.gpio_id_det = NULL,
>  	},
>  	{
> -		.gpio_vbus = CONFIG_USB3_VBUS_PIN,
>  		.gpio_vbus_det = NULL,
>  		.gpio_id_det = NULL,
>  	},
> @@ -115,12 +110,12 @@ struct sun4i_usb_phy_info {
>  
>  struct sun4i_usb_phy_plat {
>  	void __iomem *pmu;
> -	struct gpio_desc gpio_vbus;
>  	struct gpio_desc gpio_vbus_det;
>  	struct gpio_desc gpio_id_det;
>  	struct clk clocks;
>  	struct clk clk2;
>  	struct reset_ctl resets;
> +	struct udevice *vbus;
>  	int id;
>  };
>  
> @@ -209,6 +204,7 @@ static int sun4i_usb_phy_power_on(struct phy *phy)
>  {
>  	struct sun4i_usb_phy_data *data = dev_get_priv(phy->dev);
>  	struct sun4i_usb_phy_plat *usb_phy = &data->usb_phy[phy->id];
> +	int ret;
>  
>  	if (initial_usb_scan_delay) {
>  		mdelay(initial_usb_scan_delay);
> @@ -221,8 +217,11 @@ static int sun4i_usb_phy_power_on(struct phy *phy)
>  		return 0;
>  	}
>  
> -	if (dm_gpio_is_valid(&usb_phy->gpio_vbus))
> -		dm_gpio_set_value(&usb_phy->gpio_vbus, 1);
> +	if (usb_phy->vbus) {
> +		ret = regulator_set_enable(usb_phy->vbus, true);
> +		if (ret && ret != -ENOSYS)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -231,9 +230,13 @@ static int sun4i_usb_phy_power_off(struct phy *phy)
>  {
>  	struct sun4i_usb_phy_data *data = dev_get_priv(phy->dev);
>  	struct sun4i_usb_phy_plat *usb_phy = &data->usb_phy[phy->id];
> +	int ret;
>  
> -	if (dm_gpio_is_valid(&usb_phy->gpio_vbus))
> -		dm_gpio_set_value(&usb_phy->gpio_vbus, 0);
> +	if (usb_phy->vbus) {
> +		ret = regulator_set_enable(usb_phy->vbus, false);
> +		if (ret && ret != -ENOSYS)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -483,22 +486,16 @@ static int sun4i_usb_phy_probe(struct udevice *dev)
>  	for (i = 0; i < data->cfg->num_phys; i++) {
>  		struct sun4i_usb_phy_plat *phy = &plat[i];
>  		struct sun4i_usb_phy_info *info = &phy_info[i];
> -		char name[16];
> +		char name[32];
>  
>  		if (data->cfg->missing_phys & BIT(i))
>  			continue;
>  
> -		ret = dm_gpio_lookup_name(info->gpio_vbus, &phy->gpio_vbus);
> -		if (ret == 0) {
> -			ret = dm_gpio_request(&phy->gpio_vbus, "usb_vbus");
> -			if (ret)
> -				return ret;
> -			ret = dm_gpio_set_dir_flags(&phy->gpio_vbus,
> -						    GPIOD_IS_OUT);
> -			if (ret)
> -				return ret;
> -			ret = dm_gpio_set_value(&phy->gpio_vbus, 0);
> -			if (ret)
> +		snprintf(name, sizeof(name), "usb%d_vbus-supply", i);
> +		ret = device_get_supply_regulator(dev, name, &phy->vbus);
> +		if (phy->vbus) {
> +			ret = regulator_set_enable(phy->vbus, false);

It's quite likely that this regulator is already disabled, in this case
regulator_set_enable() returns -EALREADY, and probe() exists prematurely.
There is regulator_set_enable_if_allowed() to cover that case, and also
if we want to disable an always-on regulator. When replacing it (and
the call above, in sun4i_usb_phy_power_off()), it works for me, for
instance for the GPIO controlled Orange Pi Zero3, where is was failing
before.

I have fixed that in my tree, if nothing else pops up, there is no need
to re-send.

Cheers,
Andre



> +			if (ret && ret != -ENOSYS)
>  				return ret;
>  		}
>  

