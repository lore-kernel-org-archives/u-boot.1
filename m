Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD719C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 23:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C5E80C96;
	Fri, 31 Jan 2025 00:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Jtb8fgvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4528F80E90; Fri, 31 Jan 2025 00:23:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C79E80C85
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 00:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738279419;
 bh=Ypii88soiE87kJjTowTewq7O5/FXUFnEOZ4t/YNjXoA=;
 b=Jtb8fgvAGiUAgnCeadsr1FtmN83AZyAWvi2qB7jeHHlXhWIvEwOL8skfGKfbgEGpNMzd4jFrh
 Xmzprkkv6qk7oihN6Ua10sYWrZWYqedzyiItHFB2yciWIrza8i/RQNIK3gzBFt0An2B7tj1fs0d
 sHwX+n2fQcvxtR5BXkuyvhMKVdyFrbEeJn1eFabDMJSFiifwh6YmTK4zqi8JT+gxCXmpEAUu5GD
 iJ4mGMZUXL6T57r+oCXo5mVd12oO6+k1rPn0yPje0qWoWmeJpmnS+ZyZHHdyA12gGoamexFu/ji
 GXLOKYAiamRyy/CnD6Eb0BnOVmncohW44Le9oPWcuATw==
X-Forward-Email-ID: 679c09ee2d70e7e058840682
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c8877e78-8930-402c-a3b8-727441d8e8c1@kwiboo.se>
Date: Fri, 31 Jan 2025 00:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] pinctrl: rockchip: support rk3576 pinctrl
To: Heiko Stuebner <heiko@sntech.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "detlev.casanova@collabora.com" <detlev.casanova@collabora.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
 Steven Liu <steven.liu@rock-chips.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-13-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241121142731.1202209-13-heiko@sntech.de>
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

Hi Heiko,

On 2024-11-21 15:27, Heiko Stuebner wrote:
> From: Steven Liu <steven.liu@rock-chips.com>
> 
> Add support for the rk3576 variant of pinctrl.
> 
> Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> [adapted to mainline u-boot]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/pinctrl/rockchip/Makefile           |   1 +
>  drivers/pinctrl/rockchip/pinctrl-rk3576.c   | 287 ++++++++++++++++++++
>  drivers/pinctrl/rockchip/pinctrl-rockchip.h |   3 +
>  3 files changed, 291 insertions(+)
>  create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3576.c
> 
> diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
> index c91f650b043..468840913dd 100644
> --- a/drivers/pinctrl/rockchip/Makefile
> +++ b/drivers/pinctrl/rockchip/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ROCKCHIP_RK3328) += pinctrl-rk3328.o
>  obj-$(CONFIG_ROCKCHIP_RK3368) += pinctrl-rk3368.o
>  obj-$(CONFIG_ROCKCHIP_RK3399) += pinctrl-rk3399.o
>  obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
> +obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
>  obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
>  obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
>  obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3576.c b/drivers/pinctrl/rockchip/pinctrl-rk3576.c
> new file mode 100644
> index 00000000000..9399540ed4a
> --- /dev/null
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3576.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <dm.h>
> +#include <dm/pinctrl.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +
> +#include "pinctrl-rockchip.h"
> +#include <dt-bindings/pinctrl/rockchip.h>
> +
> +static int rk3576_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int iomux_num = (pin / 8);
> +	struct regmap *regmap;
> +	int reg, ret, mask;
> +	u8 bit;
> +	u32 data;
> +
> +	debug("setting mux of GPIO%d-%d to %d\n", bank->bank_num, pin, mux);

This and the debug() below is not really needed, pinctrl-rockchip-core.c
already has similar debug() calls.

> +
> +	regmap = priv->regmap_base;
> +	reg = bank->iomux[iomux_num].offset;
> +	if ((pin % 8) >= 4)
> +		reg += 0x4;
> +	bit = (pin % 4) * 4;
> +	mask = 0xf;
> +
> +	data = (mask << (bit + 16));
> +	data |= (mux & mask) << bit;
> +
> +	if (bank->bank_num == 0 && pin >= RK_PB4 && pin <= RK_PB7)
> +		reg += 0x1FF4; /* GPIO0_IOC_GPIO0B_IOMUX_SEL_H */
> +
> +	debug("iomux write reg = %x data = %x\n", reg, data);
> +
> +	ret = regmap_write(regmap, reg, data);

We should use regmap_update_bits() similar to Linux kernel.

Please feel free to squash "fixup: pinctrl: rockchip: support rk3576
pinctrl" at [1] if you agree.

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3576-2025.04-wip/

Regards,
Jonas

> +
> +	return ret;
> +}

[snip]
