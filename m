Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76BAC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F6F87F74;
	Mon, 11 Mar 2024 11:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="F0/HLyjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AC087F7B; Mon, 11 Mar 2024 11:13:16 +0100 (CET)
Received: from mail-m1287.netease.com (mail-m1287.netease.com [103.209.128.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7B287F80
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=F0/HLyjJXhho6OfIypL1XWMw+Sq2XYeyHfI5dyM4w2BzQZlqKqPSnMkVFf95Apsm/W07uKKRgRR2/gu1rW/vpKAJLsMBsRMhMfJikxuvvuLy1RBF5DewPysTR8/o92JeetP79azi2SOOuEacZECowerE8uxPsFcO/S3DKNGYlYk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=WHQKiQI4w3yk/PQCT0/VpS0eGCcT5hvRHOIXIIuybjI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 07D409003DA;
 Mon, 11 Mar 2024 18:13:00 +0800 (CST)
Message-ID: <54f05f46-2e20-43b8-8828-cd0a2f252879@rock-chips.com>
Date: Mon, 11 Mar 2024 18:13:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/16] rockchip: adc: rockchip-saradc: factor out
 start_channel callback
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-9-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-9-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGklNGVZDTUtNGRhOHk9KHRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2d005a4803a9kunm07d409003da
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTY6KRw5EjMKHjABMlYYNAxO
 KSNPChVVSlVKTEpLSk5KQkNKQkxNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSExCNwY+
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


On 2024/3/4 19:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> SARADC v1 and v2 have a different way of starting a channel, therefore
> let's abstract this function so that it can be provided from the
> udevice.data pointer.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/adc/rockchip-saradc.c | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> index 1cc57beecc2..607d10b5b70 100644
> --- a/drivers/adc/rockchip-saradc.c
> +++ b/drivers/adc/rockchip-saradc.c
> @@ -38,6 +38,7 @@ struct rockchip_saradc_data {
>   	int				num_channels;
>   	unsigned long			clk_rate;
>   	int (*channel_data)(struct udevice *dev, int channel, unsigned int *data);
> +	int (*start_channel)(struct udevice *dev, int channel);
>   };
>   
>   struct rockchip_saradc_priv {
> @@ -88,15 +89,10 @@ int rockchip_saradc_channel_data(struct udevice *dev, int channel,
>   	return 0;
>   }
>   
> -int rockchip_saradc_start_channel(struct udevice *dev, int channel)
> +int rockchip_saradc_start_channel_v1(struct udevice *dev, int channel)
>   {
>   	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
>   
> -	if (channel < 0 || channel >= priv->data->num_channels) {
> -		pr_err("Requested channel is invalid!");
> -		return -EINVAL;
> -	}
> -
>   	/* 8 clock periods as delay between power up and start cmd */
>   	writel(8, &priv->regs.v1->dly_pu_soc);
>   
> @@ -104,6 +100,25 @@ int rockchip_saradc_start_channel(struct udevice *dev, int channel)
>   	writel(SARADC_CTRL_POWER_CTRL | (channel & SARADC_CTRL_CHN_MASK) |
>   	       SARADC_CTRL_IRQ_ENABLE, &priv->regs.v1->ctrl);
>   
> +	return 0;
> +}
> +
> +int rockchip_saradc_start_channel(struct udevice *dev, int channel)
> +{
> +	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	if (channel < 0 || channel >= priv->data->num_channels) {
> +		pr_err("Requested channel is invalid!");
> +		return -EINVAL;
> +	}
> +
> +	ret = priv->data->start_channel(dev, channel);
> +	if (ret) {
> +		pr_err("Error starting channel, %d!", ret);
> +		return ret;
> +	}
> +
>   	priv->active_channel = channel;
>   
>   	return 0;
> @@ -193,6 +208,7 @@ static const struct rockchip_saradc_data saradc_data = {
>   	.num_channels = 3,
>   	.clk_rate = 1000000,
>   	.channel_data = rockchip_saradc_channel_data_v1,
> +	.start_channel = rockchip_saradc_start_channel_v1,
>   };
>   
>   static const struct rockchip_saradc_data rk3066_tsadc_data = {
> @@ -200,6 +216,7 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
>   	.num_channels = 2,
>   	.clk_rate = 50000,
>   	.channel_data = rockchip_saradc_channel_data_v1,
> +	.start_channel = rockchip_saradc_start_channel_v1,
>   };
>   
>   static const struct rockchip_saradc_data rk3399_saradc_data = {
> @@ -207,6 +224,7 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>   	.num_channels = 6,
>   	.clk_rate = 1000000,
>   	.channel_data = rockchip_saradc_channel_data_v1,
> +	.start_channel = rockchip_saradc_start_channel_v1,
>   };
>   
>   static const struct udevice_id rockchip_saradc_ids[] = {
>
