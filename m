Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABC9C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6589387F5A;
	Mon, 11 Mar 2024 11:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gBtfChLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E2486BDB; Mon, 11 Mar 2024 11:13:00 +0100 (CET)
Received: from mail-m121157.qiye.163.com (mail-m121157.qiye.163.com
 [115.236.121.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B6E87F74
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gBtfChLLgvf2DKnu1D9bZ57MocVB8clLKj26FKxRkRL0cAa370sNdp27/NtSJpGyA4uXHu2dsAsf124/9Hoy+CU93zyV7RTt+abtF0SgL1mXLuj1NodSIbTkxDenm4+0ckgeYADWT2GU7il8VFvnczsXYibY8beyxaoU8gXOTwk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=9do8wKSO2OQrVGIEW8guRhVqn95P8JFIikqTnN1pf2s=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 340609003E8;
 Mon, 11 Mar 2024 18:12:47 +0800 (CST)
Message-ID: <a0be8302-552b-4ec3-9131-3bbad14ae9b4@rock-chips.com>
Date: Mon, 11 Mar 2024 18:12:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/16] rockchip: adc: rockchip-saradc: factor out
 channel_data callback
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-8-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-8-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkpPGFZNS0pMS09CSUtOHR5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2d00240703a9kunm340609003e8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NE06Hjo6FzMTMDAaMkssNEsw
 M0hPFDZVSlVKTEpLSk5KQk1DSkhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSkxPNwY+
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
> SARADC v1 and v2 have a different way of reading data, therefore let's
> abstract this function so that it can be provided from the udevice.data
> pointer.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/adc/rockchip-saradc.c | 37 +++++++++++++++++++++++++++++--------
>   1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> index 4a842556a60..1cc57beecc2 100644
> --- a/drivers/adc/rockchip-saradc.c
> +++ b/drivers/adc/rockchip-saradc.c
> @@ -37,6 +37,7 @@ struct rockchip_saradc_data {
>   	int				num_bits;
>   	int				num_channels;
>   	unsigned long			clk_rate;
> +	int (*channel_data)(struct udevice *dev, int channel, unsigned int *data);
>   };
>   
>   struct rockchip_saradc_priv {
> @@ -45,28 +46,45 @@ struct rockchip_saradc_priv {
>   	const struct rockchip_saradc_data	*data;
>   };
>   
> +int rockchip_saradc_channel_data_v1(struct udevice *dev, int channel,
> +				    unsigned int *data)
> +{
> +	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> +
> +	if ((readl(&priv->regs.v1->ctrl) & SARADC_CTRL_IRQ_STATUS) !=
> +	    SARADC_CTRL_IRQ_STATUS)
> +		return -EBUSY;
> +
> +	/* Read value */
> +	*data = readl(&priv->regs.v1->data);
> +
> +	/* Power down adc */
> +	writel(0, &priv->regs.v1->ctrl);
> +
> +	return 0;
> +}
> +
>   int rockchip_saradc_channel_data(struct udevice *dev, int channel,
>   				 unsigned int *data)
>   {
>   	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
>   	struct adc_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
> +	int ret;
>   
>   	if (channel != priv->active_channel) {
>   		pr_err("Requested channel is not active!");
>   		return -EINVAL;
>   	}
>   
> -	if ((readl(&priv->regs.v1->ctrl) & SARADC_CTRL_IRQ_STATUS) !=
> -	    SARADC_CTRL_IRQ_STATUS)
> -		return -EBUSY;
> +	ret = priv->data->channel_data(dev, channel, data);
> +	if (ret) {
> +		if (ret != -EBUSY)
> +			pr_err("Error reading channel data, %d!", ret);
> +		return ret;
> +	}
>   
> -	/* Read value */
> -	*data = readl(&priv->regs.v1->data);
>   	*data &= uc_pdata->data_mask;
>   
> -	/* Power down adc */
> -	writel(0, &priv->regs.v1->ctrl);
> -
>   	return 0;
>   }
>   
> @@ -174,18 +192,21 @@ static const struct rockchip_saradc_data saradc_data = {
>   	.num_bits = 10,
>   	.num_channels = 3,
>   	.clk_rate = 1000000,
> +	.channel_data = rockchip_saradc_channel_data_v1,
>   };
>   
>   static const struct rockchip_saradc_data rk3066_tsadc_data = {
>   	.num_bits = 12,
>   	.num_channels = 2,
>   	.clk_rate = 50000,
> +	.channel_data = rockchip_saradc_channel_data_v1,
>   };
>   
>   static const struct rockchip_saradc_data rk3399_saradc_data = {
>   	.num_bits = 10,
>   	.num_channels = 6,
>   	.clk_rate = 1000000,
> +	.channel_data = rockchip_saradc_channel_data_v1,
>   };
>   
>   static const struct udevice_id rockchip_saradc_ids[] = {
>
