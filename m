Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA06C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 23:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A427E87BBB;
	Sun, 17 Dec 2023 00:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=yandex.com header.i=@yandex.com header.b="g+d6y/Nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B736487752; Sat, 16 Dec 2023 23:45:09 +0100 (CET)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [178.154.239.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA0187788
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 23:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@yandex.com
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:3d80:0:640:1395:0])
 by forward501a.mail.yandex.net (Yandex) with ESMTP id 960E86141B;
 Sun, 17 Dec 2023 01:45:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id 1jvPLN1d1W20-IJQDhObR; 
 Sun, 17 Dec 2023 01:45:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1702766704; bh=WvKemtKAYPSr9PArWwtGHEDSnODYX5BD7dvTyuajg38=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=g+d6y/NmDLJxf5b33MM+Hz6GJd3NHlTNA/IomynI+/iC6gQtj6Vp4FyYo7RJVDQzL
 0ePda3endPKdMt/EMIbraop2qqMObHv6NKVntdLp6b5IcpOXAv4EYerBK08W7AV0i1
 2A89ezNUX8Y8TO0J/7eyw6RjlEO5VTz/20N8YFnw=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.com
Message-ID: <f59bcbea-fd04-864f-b95c-5b4c4872c28d@yandex.com>
Date: Sat, 16 Dec 2023 23:45:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 13/17] video: rockchip: Add rk3328 vop support
To: Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
 <20231211085939.5478-14-jagan@amarulasolutions.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <20231211085939.5478-14-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 17 Dec 2023 00:23:35 +0100
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

Hi Jagan,

In  your patch U-boot users must add a new file for each new Rockchip SoC.

With the VOP2 introduction the VOP1 structures and functions are frozen/stabilized.

My proposal would be to use a file simular to Linux rockchip_vop_reg.c and port it to U-boot as is done in the manufacturer tree.

Together with a simple basic rockchip_vop.c to start with.

Not sure if we need a kind of DRM frame work.

Question: What do the U-boot maintainers think of this DRM implementation in use by Rockchip. Is that a route that useful for mainline?

Let me know your ideas.

Johan


On 12/11/23 09:59, Jagan Teki wrote:
> From: Jagan Teki <jagan@edgeble.ai>
>
> Add support for Rockchip RK3328 VOP.
>
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
>  drivers/video/rockchip/Makefile     |  1 +
>  drivers/video/rockchip/rk3328_vop.c | 66 +++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 drivers/video/rockchip/rk3328_vop.c
>
> diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
> index 4991303c73..f55beceebf 100644
> --- a/drivers/video/rockchip/Makefile
> +++ b/drivers/video/rockchip/Makefile
> @@ -6,6 +6,7 @@
>  ifdef CONFIG_VIDEO_ROCKCHIP
>  obj-y += rk_vop.o
>  obj-$(CONFIG_ROCKCHIP_RK3288) += rk3288_vop.o
> +obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328_vop.o
>  obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399_vop.o
>  obj-$(CONFIG_DISPLAY_ROCKCHIP_EDP) += rk_edp.o
>  obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) += rk_lvds.o
> diff --git a/drivers/video/rockchip/rk3328_vop.c b/drivers/video/rockchip/rk3328_vop.c
> new file mode 100644
> index 0000000000..2512314e64
> --- /dev/null
> +++ b/drivers/video/rockchip/rk3328_vop.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <video.h>
> +#include <asm/io.h>
> +#include "rk_vop.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static void rk3328_set_pin_polarity(struct udevice *dev,
> +				    enum vop_modes mode, u32 polarity)
> +{
> +	struct rk_vop_priv *priv = dev_get_priv(dev);
> +	struct rk3288_vop *regs = priv->regs;
> +
> +	switch (mode) {
> +	case VOP_MODE_HDMI:
> +		clrsetbits_le32(&regs->dsp_ctrl1,
> +				M_RK3399_DSP_HDMI_POL,
> +				V_RK3399_DSP_HDMI_POL(polarity));
> +		break;
> +	default:
> +		debug("%s: unsupported output mode %x\n", __func__, mode);
> +	}
> +}
> +
> +static int rk3328_vop_probe(struct udevice *dev)
> +{
> +	/* Before relocation we don't need to do anything */
> +	if (!(gd->flags & GD_FLG_RELOC))
> +		return 0;
> +
> +	return rk_vop_probe(dev);
> +}
> +
> +struct rkvop_driverdata rk3328_driverdata = {
> +	.dsp_offset = 0x490,
> +	.win_offset = 0xd0,
> +	.features = VOP_FEATURE_OUTPUT_10BIT,
> +	.set_pin_polarity = rk3328_set_pin_polarity,
> +};
> +
> +static const struct udevice_id rk3328_vop_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3328-vop",
> +		.data = (ulong)&rk3328_driverdata
> +	},
> +	{ /* sentile */ }
> +};
> +
> +static const struct video_ops rk3328_vop_ops = {
> +};
> +
> +U_BOOT_DRIVER(rk3328_vop) = {
> +	.name	= "rk3328_vop",
> +	.id	= UCLASS_VIDEO,
> +	.of_match = rk3328_vop_ids,
> +	.ops	= &rk3328_vop_ops,
> +	.bind	= rk_vop_bind,
> +	.probe	= rk3328_vop_probe,
> +	.priv_auto	= sizeof(struct rk_vop_priv),
> +};
