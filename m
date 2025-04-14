Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CB2C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 940F38215D;
	Tue, 15 Apr 2025 00:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JyT/rzTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC26A82845; Tue, 15 Apr 2025 00:50:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C08A68214F
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=02b5=XB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744671054;
 bh=5yTDGhOz8Zpg8T04iwa67G1G2+Wri1npRBnJRTM9fMU=;
 b=JyT/rzTbwZDmRPsAXV6cFKqawVeM5QYthpA1ISRaH19ZOlNVxjxg/7yJT95reb21r+Ym2W0Re
 aSllMZEjvEsUrF5JbeqSEbSbRNyGdWS97OKkjpGZQbC2NfHnLBrQZbtUc8rN5OW6O8vtQFf7+62
 z9Pnm4oozoTyUSslNNsP0Cexzf+tY1L4xb+XBH7gHaKRDQisQXm7WdX/V7WeNFs7Rylld3GOMEM
 oF3De3/I/3t1uOrNJ/lAP988QCK2W//gEBpQ0pEoclmLI2O/XqtoI+CbUXeSmOJv/yEBHx6fI4F
 NO4YZ+VDjsBVlFzca051KB+X/Pu3dgqFaUsGCT95UXMA==
X-Forward-Email-ID: 67fd914440cbaa005ededc77
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <630dc067-1c44-4977-b119-072326b5216b@kwiboo.se>
Date: Tue, 15 Apr 2025 00:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] pinctrl: rockchip: support rk3576 pinctrl
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com, Steven Liu <steven.liu@rock-chips.com>
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-6-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-6-heiko@sntech.de>
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

On 2025-04-14 22:01, Heiko Stuebner wrote:
> From: Steven Liu <steven.liu@rock-chips.com>
> 
> Add support for the rk3576 variant of pinctrl.
> 
> Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> [adapted to mainline u-boot]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/pinctrl/rockchip/Makefile           |   1 +
>  drivers/pinctrl/rockchip/pinctrl-rk3576.c   | 279 ++++++++++++++++++++
>  drivers/pinctrl/rockchip/pinctrl-rockchip.h |   3 +
>  3 files changed, 283 insertions(+)
>  create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3576.c
> 
> diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
> index df6c97d6234..e17415e1ca6 100644
> --- a/drivers/pinctrl/rockchip/Makefile
> +++ b/drivers/pinctrl/rockchip/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_ROCKCHIP_RK3368) += pinctrl-rk3368.o
>  obj-$(CONFIG_ROCKCHIP_RK3399) += pinctrl-rk3399.o
>  obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
>  obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
> +obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
>  obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
>  obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
>  obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3576.c b/drivers/pinctrl/rockchip/pinctrl-rk3576.c
> new file mode 100644
> index 00000000000..589a9b8491c
> --- /dev/null
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3576.c

[snip]

> +static const struct rockchip_pin_ctrl rk3576_pin_ctrl = {
> +	.pin_banks		= rk3576_pin_banks,
> +	.nr_banks		= ARRAY_SIZE(rk3576_pin_banks),
> +	.nr_pins		= 160,

This property is removed in Quentin Schulz "pinctrl: rockchip: fix
editing const struct + constify rockchip_pin_ctrl" series [1].

Suggest you drop this property to ease merging of both these series.

With that fixes this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

[1] https://patchwork.ozlabs.org/cover/2040824/

Regards,
Jonas

> +	.grf_mux_offset		= 0x0,
> +	.set_mux		= rk3576_set_mux,
> +	.set_pull		= rk3576_set_pull,
> +	.set_drive		= rk3576_set_drive,
> +	.set_schmitt		= rk3576_set_schmitt,
> +};

[snip]
