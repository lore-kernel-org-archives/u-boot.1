Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC4EC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB72587EF5;
	Mon, 11 Mar 2024 11:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gLiBz4Ug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF2B87F60; Mon, 11 Mar 2024 11:12:50 +0100 (CET)
Received: from mail-m25489.xmail.ntesmail.com (mail-m25489.xmail.ntesmail.com
 [103.129.254.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339CA86BDB
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gLiBz4UgGYep/WEMO4l040ZMyDHHGudl1c67fhjhRMdyH+36QLe7CepSkKbVb45Kkq+sTRxVdJCuV9aPPNEHQcfQHsQbLcCDRDSFN76AgvYQLgjk9IxHX6PfH3AD0hWNqw24NZCidA1vciDMRMgSsQLGM01cCft14Euc3/LiBBk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=GnG1rV1sdbvsTxKvQc0M4e7+8AdoS1AhxJdam1WUYh8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 64E4C900428;
 Mon, 11 Mar 2024 18:12:33 +0800 (CST)
Message-ID: <5d454077-eee0-43d2-9d95-e9abe681ecd9@rock-chips.com>
Date: Mon, 11 Mar 2024 18:12:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] rockchip: adc: rockchip-saradc: use union for
 preparing for v2
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-7-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-7-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1DQ1YdSx4fQk1DTB9CGk1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cffef7903a9kunm64e4c900428
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mzo6OTo5KDMRSzAwFFZNNEMQ
 ETwwCx5VSlVKTEpLSk5KQk5PTU9JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSUNCNwY+
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
> The registers are entirely different between SARADC v1 and SARADC v2, so
> let's prepare to add another struct for accessing v2 registers by adding
> a union.
>
> Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/adc/rockchip-saradc.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> index 03caca78b5f..4a842556a60 100644
> --- a/drivers/adc/rockchip-saradc.c
> +++ b/drivers/adc/rockchip-saradc.c
> @@ -23,13 +23,16 @@
>   
>   #define SARADC_TIMEOUT			(100 * 1000)
>   
> -struct rockchip_saradc_regs {
> +struct rockchip_saradc_regs_v1 {
>   	unsigned int data;
>   	unsigned int stas;
>   	unsigned int ctrl;
>   	unsigned int dly_pu_soc;
>   };
>   
> +union rockchip_saradc_regs {
> +	struct rockchip_saradc_regs_v1	*v1;
> +};
>   struct rockchip_saradc_data {
>   	int				num_bits;
>   	int				num_channels;
> @@ -37,7 +40,7 @@ struct rockchip_saradc_data {
>   };
>   
>   struct rockchip_saradc_priv {
> -	struct rockchip_saradc_regs		*regs;
> +	union rockchip_saradc_regs		regs;
>   	int					active_channel;
>   	const struct rockchip_saradc_data	*data;
>   };
> @@ -53,16 +56,16 @@ int rockchip_saradc_channel_data(struct udevice *dev, int channel,
>   		return -EINVAL;
>   	}
>   
> -	if ((readl(&priv->regs->ctrl) & SARADC_CTRL_IRQ_STATUS) !=
> +	if ((readl(&priv->regs.v1->ctrl) & SARADC_CTRL_IRQ_STATUS) !=
>   	    SARADC_CTRL_IRQ_STATUS)
>   		return -EBUSY;
>   
>   	/* Read value */
> -	*data = readl(&priv->regs->data);
> +	*data = readl(&priv->regs.v1->data);
>   	*data &= uc_pdata->data_mask;
>   
>   	/* Power down adc */
> -	writel(0, &priv->regs->ctrl);
> +	writel(0, &priv->regs.v1->ctrl);
>   
>   	return 0;
>   }
> @@ -77,11 +80,11 @@ int rockchip_saradc_start_channel(struct udevice *dev, int channel)
>   	}
>   
>   	/* 8 clock periods as delay between power up and start cmd */
> -	writel(8, &priv->regs->dly_pu_soc);
> +	writel(8, &priv->regs.v1->dly_pu_soc);
>   
>   	/* Select the channel to be used and trigger conversion */
>   	writel(SARADC_CTRL_POWER_CTRL | (channel & SARADC_CTRL_CHN_MASK) |
> -	       SARADC_CTRL_IRQ_ENABLE, &priv->regs->ctrl);
> +	       SARADC_CTRL_IRQ_ENABLE, &priv->regs.v1->ctrl);
>   
>   	priv->active_channel = channel;
>   
> @@ -93,7 +96,7 @@ int rockchip_saradc_stop(struct udevice *dev)
>   	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
>   
>   	/* Power down adc */
> -	writel(0, &priv->regs->ctrl);
> +	writel(0, &priv->regs.v1->ctrl);
>   
>   	priv->active_channel = -1;
>   
> @@ -146,8 +149,8 @@ int rockchip_saradc_of_to_plat(struct udevice *dev)
>   	struct rockchip_saradc_data *data;
>   
>   	data = (struct rockchip_saradc_data *)dev_get_driver_data(dev);
> -	priv->regs = dev_read_addr_ptr(dev);
> -	if (!priv->regs) {
> +	priv->regs.v1 = dev_read_addr_ptr(dev);
> +	if (!priv->regs.v1) {
>   		pr_err("Dev: %s - can't get address!", dev->name);
>   		return -EINVAL;
>   	}
>
