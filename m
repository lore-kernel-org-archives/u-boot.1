Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A4C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 15:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960ED829E4;
	Sun, 13 Apr 2025 17:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="W8gaZknl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C7B82A60; Sun, 13 Apr 2025 17:11:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3388828A2
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 17:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744557070;
 bh=+UPmMxkUBRebrhW8uzkcexozD6kvHOKiNO4cJZM5MjI=;
 b=W8gaZknlR3xNBB63v82bKO/rIRF6E76rI/Fe+UjhZ4kpAYmqFjxBDD9BW9UF3C4RrBfde5/rR
 jqFrPH1VF0ROoo8w3PBew8pKBeoATjueJoxbHKKveodRUvbmdCn0VWAcJY2FMienwao6hguk4Wa
 y4GngaDDVC0x63tjzp1DSSYAwTqmb6OuL+YRr6n2pA3R+r9QCr+1KM993hT6Kw0wUjP+eEDgRpU
 rmmo4xm9TGwBXSt8XLgPCL4WTcHigIVm33CwDRb+BuMq3QWxWHS9VhYr2OOeu7iuKm76F8uNHei
 yJlImVm9eiF2HSmRgBXCtSowPoTIhEcwRcfFZ7OhUZcA==
X-Forward-Email-ID: 67fbd4037cfcd77aa7dc3970
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d43483ec-092b-499f-8a1f-0a3e869644eb@kwiboo.se>
Date: Sun, 13 Apr 2025 17:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] video: rockchip: Add HDMI support for RK3568
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Ondrej Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Piotr Zalewski <pZ010001011111@proton.me>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
 <20250412-vop2-pt2-v3-10-7c796db335e9@riseup.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250412-vop2-pt2-v3-10-7c796db335e9@riseup.net>
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

Hi,

On 2025-04-12 16:27, Dang Huynh wrote:
> HDMI on RK3568 is mostly simplified, all this does is enabling
> DDC for display timings and HPD.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  drivers/video/rockchip/Makefile      |  1 +
>  drivers/video/rockchip/rk3568_hdmi.c | 71 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
> index 2f89a979a2848733be5a6d05817ad76ce3ad3a34..b751c969b46f1933e91a6c0434f31227a709d8e5 100644
> --- a/drivers/video/rockchip/Makefile
> +++ b/drivers/video/rockchip/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) += rk_lvds.o
>  obj-hdmi-$(CONFIG_ROCKCHIP_RK3288) += rk3288_hdmi.o
>  obj-hdmi-$(CONFIG_ROCKCHIP_RK3328) += rk3328_hdmi.o
>  obj-hdmi-$(CONFIG_ROCKCHIP_RK3399) += rk3399_hdmi.o
> +obj-hdmi-$(CONFIG_ROCKCHIP_RK3568) += rk3568_hdmi.o
>  obj-$(CONFIG_DISPLAY_ROCKCHIP_HDMI) += rk_hdmi.o $(obj-hdmi-y)
>  obj-mipi-$(CONFIG_ROCKCHIP_RK3288) += rk3288_mipi.o
>  obj-mipi-$(CONFIG_ROCKCHIP_RK3399) += rk3399_mipi.o
> diff --git a/drivers/video/rockchip/rk3568_hdmi.c b/drivers/video/rockchip/rk3568_hdmi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..5578ea37243a5735713d92572639cdc8ba9865cf
> --- /dev/null
> +++ b/drivers/video/rockchip/rk3568_hdmi.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Dang Huynh <danct12@riseup.net>
> + */
> +
> +#include <display.h>
> +#include <dm.h>
> +#include <dw_hdmi.h>
> +#include <edid.h>
> +#include <asm/arch-rockchip/hardware.h>
> +#include <asm/arch-rockchip/grf_rk3568.h>
> +#include "rk_hdmi.h"
> +
> +#define RK3568_IO_DDC_IN_MSK             ((3 << 14) | (3 << (14 + 16)))
> +
> +static int rk3568_hdmi_enable(struct udevice *dev, int panel_bpp,
> +			      const struct display_timing *edid)
> +{
> +	struct rk_hdmi_priv *priv = dev_get_priv(dev);
> +
> +	return dw_hdmi_enable(&priv->hdmi, edid);
> +}
> +
> +static int rk3568_hdmi_of_to_plat(struct udevice *dev)
> +{
> +	struct rk_hdmi_priv *priv = dev_get_priv(dev);
> +	struct dw_hdmi *hdmi = &priv->hdmi;
> +
> +	hdmi->i2c_clk_high = 0x71;
> +	hdmi->i2c_clk_low = 0x76;

It is interesting that U-Boot will do I2C clock configuration, something
that Linux will not do.

Where did you get these values? According to the dw-hdmi databook these
should be configured similar to following:

 Minimum High and Minimum Low @100 kbps:
 MIN_SCL_*time Variable		Specification Value	Compliance Value
 MIN_SCL_HIGHtime		4000 ns			4500 ns
 MIN_SCL_LOWtime		4500 ns			5200 ns

 SFR Clock Frequency (Hz) = SFRFREQ
 SFRFREQ = 27 MHz
 I2Cmode = standard, 100 kbit/s
 MIN_SCL_HIGHtime = 4000 ns.
 MIN_SCL_LOWtime = 4700 ns.

 IC_xCNT = (ROUNDUP(MIN_SCL_HIGH_LOWtime*SFRFREQ,0))
 IC_HCNT = (ROUNDUP(4000 ns * 27 MHz,0))
 IC_HCNTSCL PERIOD = 108 (0x6c)

 IC_LCNT = (ROUNDUP(4700 ns * 27 MHz,0))
 IC_LCNTSCL PERIOD = 127 (0x7f)

Above are the defaults for a 27 MHz source clock, however Rockchip use a
24 MHz source clock.

With current values the difference between high and low seem rather low:

 i2c_clk_high = 0x71 (4708 ns)
 i2c_clk_low = 0x76 (4916 ns)

I would expect these to possible be better options:

 i2c_clk_high = 0x6c (4500 ns)
 i2c_clk_low = 0x7d (5208 ns)

As that more closer matches the recommended values for compliance test.

> +
> +	return rk_hdmi_of_to_plat(dev);
> +}
> +
> +static const char * const rk3568_hdmi_reg_names[] = {
> +	"avdd-0v9",
> +	"avdd-1v8"
> +};
> +
> +static int rk3568_hdmi_probe(struct udevice *dev)
> +{
> +	struct rk_hdmi_priv *priv = dev_get_priv(dev);
> +	struct rk3568_grf *grf = priv->grf;
> +
> +	rk_hdmi_probe_regulators(dev, rk3568_hdmi_reg_names,
> +				 ARRAY_SIZE(rk3568_hdmi_reg_names));
> +
> +	writel(RK3568_IO_DDC_IN_MSK, &grf->vo_con1);
> +
> +	return rk_hdmi_probe(dev);
> +}
> +
> +static const struct dm_display_ops rk3568_hdmi_ops = {
> +	.read_edid = rk_hdmi_read_edid,
> +	.enable = rk3568_hdmi_enable,
> +};
> +
> +static const struct udevice_id rk3568_hdmi_ids[] = {
> +	{ .compatible = "rockchip,rk3568-dw-hdmi" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rk3568_hdmi_rockchip) = {
> +	.name = "rk3568_hdmi_rockchip",
> +	.id = UCLASS_DISPLAY,
> +	.of_match = rk3568_hdmi_ids,
> +	.ops = &rk3568_hdmi_ops,
> +	.of_to_plat = rk3568_hdmi_of_to_plat,
> +	.probe = rk3568_hdmi_probe,
> +	.priv_auto	= sizeof(struct rk_hdmi_priv),

No need to add a tab here since none of the values are aligned, please
replace the tab with a space.

Regards,
Jonas

> +};
> 

