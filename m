Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F13C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F69D87F69;
	Mon, 11 Mar 2024 11:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UB7aTUtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9755687F6E; Mon, 11 Mar 2024 11:13:39 +0100 (CET)
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com
 [220.197.32.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B2387F69
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=UB7aTUtgLBzhA49ntnjO8iUKlYRzWLyLXd7k2Ia4FCcfSJz0yPuR69JBj+/sqghCrSJL6up7AkckYItDzIMEPJMW6mD7NaqNuBDtVXXae/ptwBYVXP3t6B8Y+wgoep9T75NtlSe6eJCRnfhDpxfZ1c1e27P8kOY3iuOtzsbRIsQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=1F/7eSQySC9s0mRtOGZOCPWhM576V0B3D8eTdNr/gzQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A0B8B900359;
 Mon, 11 Mar 2024 18:13:16 +0800 (CST)
Message-ID: <d2257d2a-1aab-42c4-afa7-17df15869b2d@rock-chips.com>
Date: Mon, 11 Mar 2024 18:13:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/16] rockchip: adc: rockchip-saradc: factor out stop
 callback
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-10-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-10-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUwYTFZIH05DTkxPQx9IT0hVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2d0097fd03a9kunma0b8b900359
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6Vhw5HzMIKDADFE00Mjw8
 DzoKCRdVSlVKTEpLSk5KQkJDSE1OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ09CNwY+
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
> SARADC v2 doesn't have a stop mechanism once in single mode. In series
> conversion, the logic is different anyway. Therefore, let's abstract
> this function so that it can be provided from the udevice.data pointer.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/adc/rockchip-saradc.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> index 607d10b5b70..b5df58fe3eb 100644
> --- a/drivers/adc/rockchip-saradc.c
> +++ b/drivers/adc/rockchip-saradc.c
> @@ -39,6 +39,7 @@ struct rockchip_saradc_data {
>   	unsigned long			clk_rate;
>   	int (*channel_data)(struct udevice *dev, int channel, unsigned int *data);
>   	int (*start_channel)(struct udevice *dev, int channel);
> +	int (*stop)(struct udevice *dev);
>   };
>   
>   struct rockchip_saradc_priv {
> @@ -124,13 +125,29 @@ int rockchip_saradc_start_channel(struct udevice *dev, int channel)
>   	return 0;
>   }
>   
> -int rockchip_saradc_stop(struct udevice *dev)
> +int rockchip_saradc_stop_v1(struct udevice *dev)
>   {
>   	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
>   
>   	/* Power down adc */
>   	writel(0, &priv->regs.v1->ctrl);
>   
> +	return 0;
> +}
> +
> +int rockchip_saradc_stop(struct udevice *dev)
> +{
> +	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> +
> +	if (priv->data->stop) {
> +		int ret = priv->data->stop(dev);
> +
> +		if (ret) {
> +			pr_err("Error stopping channel, %d!", ret);
> +			return ret;
> +		}
> +	}
> +
>   	priv->active_channel = -1;
>   
>   	return 0;
> @@ -209,6 +226,7 @@ static const struct rockchip_saradc_data saradc_data = {
>   	.clk_rate = 1000000,
>   	.channel_data = rockchip_saradc_channel_data_v1,
>   	.start_channel = rockchip_saradc_start_channel_v1,
> +	.stop = rockchip_saradc_stop_v1,
>   };
>   
>   static const struct rockchip_saradc_data rk3066_tsadc_data = {
> @@ -217,6 +235,7 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
>   	.clk_rate = 50000,
>   	.channel_data = rockchip_saradc_channel_data_v1,
>   	.start_channel = rockchip_saradc_start_channel_v1,
> +	.stop = rockchip_saradc_stop_v1,
>   };
>   
>   static const struct rockchip_saradc_data rk3399_saradc_data = {
> @@ -225,6 +244,7 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>   	.clk_rate = 1000000,
>   	.channel_data = rockchip_saradc_channel_data_v1,
>   	.start_channel = rockchip_saradc_start_channel_v1,
> +	.stop = rockchip_saradc_stop_v1,
>   };
>   
>   static const struct udevice_id rockchip_saradc_ids[] = {
>
