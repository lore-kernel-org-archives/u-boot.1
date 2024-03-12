Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487C0C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 03:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE7587F24;
	Tue, 12 Mar 2024 04:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Z8ssiupU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D848B87F2F; Tue, 12 Mar 2024 04:50:16 +0100 (CET)
Received: from mail-m605.netease.com (mail-m605.netease.com [210.79.60.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358AC87F16
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 04:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Z8ssiupU8plnPZ8D1ok8dgoYl7bLfMf7+cwHxEmpaTQqGs6CYUYCNWPCurm7jc7XMjK+oegY0tb5EMIJR6RT/7/ah8AAoTrpCUZiwMMeeCb2tNYsbynf7q3SFQA1uMk/6EMbMAeTakA1OTD5C9dmbocV3mFuWxzYIMmII+WQMsM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=VdoiYLcT4ZfgAsYA5FILMkYcb68suB5nkd3LNEraPh4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 415AF9002D5;
 Tue, 12 Mar 2024 11:50:01 +0800 (CST)
Message-ID: <05d91801-7e94-40fe-ad38-e5f7d945a069@rock-chips.com>
Date: Tue, 12 Mar 2024 11:50:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/16] rockchip: adc: rockchip-saradc: add support for
 RK3588
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-11-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-11-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRkdHVZMHUNPTxpKQkpCQktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e30c8126203a9kunm415af9002d5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PiI6Lyo*FTMXMDY3FDY3Dw4i
 Lh9PC0hVSlVKTEpLSUpOT0tJTkNPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDT0NONwY+
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
> This adds support for the SARADCv2 found on RK3588.
>
> There is no stop callback as it is currently configured in single
> conversion mode, where the ADC is powered down after a single conversion
> has been made.
>
> Due to what seems to be a silicon bug, a controller reset needs to be
> issued before starting a channel conversion otherwise Rockchip says that
> channel 1 will error whatever that means. This is aligned with upstream
> and downstream Linux kernel as well as downstream U-Boot.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/adc/rockchip-saradc.c | 102 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 101 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> index b5df58fe3eb..10ded1b088f 100644
> --- a/drivers/adc/rockchip-saradc.c
> +++ b/drivers/adc/rockchip-saradc.c
> @@ -10,12 +10,17 @@
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> -#include <asm/io.h>
> +#include <reset.h>
> +#include <asm/arch-rockchip/hardware.h>
> +#include <linux/bitfield.h>
>   #include <linux/bitops.h>
> +#include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/printk.h>
>   #include <power/regulator.h>
>   
> +#define usleep_range(a, b) udelay((b))
> +
>   #define SARADC_CTRL_CHN_MASK		GENMASK(2, 0)
>   #define SARADC_CTRL_POWER_CTRL		BIT(3)
>   #define SARADC_CTRL_IRQ_ENABLE		BIT(5)
> @@ -30,8 +35,37 @@ struct rockchip_saradc_regs_v1 {
>   	unsigned int dly_pu_soc;
>   };
>   
> +struct rockchip_saradc_regs_v2 {
> +	unsigned int conv_con;
> +#define SARADC2_SINGLE_MODE	BIT(5)
> +#define SARADC2_START		BIT(4)
> +#define SARADC2_CONV_CHANNELS	GENMASK(3, 0)
> +	unsigned int t_pd_soc;
> +	unsigned int t_as_soc;
> +	unsigned int t_das_soc;
> +	unsigned int t_sel_soc;
> +	unsigned int high_comp[16];
> +	unsigned int low_comp[16];
> +	unsigned int debounce;
> +	unsigned int ht_int_en;
> +	unsigned int lt_int_en;
> +	unsigned int reserved[24];
> +	unsigned int mt_int_en;
> +	unsigned int end_int_en;
> +#define SARADC2_EN_END_INT	BIT(0)
> +	unsigned int st_con;
> +	unsigned int status;
> +	unsigned int end_int_st;
> +	unsigned int ht_int_st;
> +	unsigned int lt_int_st;
> +	unsigned int mt_int_st;
> +	unsigned int data[16];
> +	unsigned int auto_ch_en;
> +};
> +
>   union rockchip_saradc_regs {
>   	struct rockchip_saradc_regs_v1	*v1;
> +	struct rockchip_saradc_regs_v2	*v2;
>   };
>   struct rockchip_saradc_data {
>   	int				num_bits;
> @@ -46,6 +80,7 @@ struct rockchip_saradc_priv {
>   	union rockchip_saradc_regs		regs;
>   	int					active_channel;
>   	const struct rockchip_saradc_data	*data;
> +	struct reset_ctl			*reset;
>   };
>   
>   int rockchip_saradc_channel_data_v1(struct udevice *dev, int channel,
> @@ -66,6 +101,22 @@ int rockchip_saradc_channel_data_v1(struct udevice *dev, int channel,
>   	return 0;
>   }
>   
> +int rockchip_saradc_channel_data_v2(struct udevice *dev, int channel,
> +				    unsigned int *data)
> +{
> +	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> +
> +	if (!(readl(&priv->regs.v2->end_int_st) & SARADC2_EN_END_INT))
> +		return -EBUSY;
> +
> +	/* Read value */
> +	*data = readl(&priv->regs.v2->data[channel]);
> +
> +	/* Acknowledge the interrupt */
> +	writel(SARADC2_EN_END_INT, &priv->regs.v2->end_int_st);
> +
> +	return 0;
> +}
>   int rockchip_saradc_channel_data(struct udevice *dev, int channel,
>   				 unsigned int *data)
>   {
> @@ -104,6 +155,40 @@ int rockchip_saradc_start_channel_v1(struct udevice *dev, int channel)
>   	return 0;
>   }
>   
> +static void rockchip_saradc_reset_controller(struct reset_ctl *reset)
> +{
> +	reset_assert(reset);
> +	usleep_range(10, 20);
> +	reset_deassert(reset);
> +}
> +
> +int rockchip_saradc_start_channel_v2(struct udevice *dev, int channel)
> +{
> +	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> +
> +	/*
> +	 * Downstream says
> +	 * """If read other chn at anytime, then chn1 will error, assert
> +	 * controller as a workaround."""
> +	 */
> +	if (priv->reset)
> +		rockchip_saradc_reset_controller(priv->reset);
> +
> +	writel(0xc, &priv->regs.v2->t_das_soc);
> +	writel(0x20, &priv->regs.v2->t_pd_soc);
> +
> +	/* Acknowledge any previous interrupt */
> +	writel(SARADC2_EN_END_INT, &priv->regs.v2->end_int_st);
> +
> +	rk_clrsetreg(&priv->regs.v2->conv_con,
> +		     SARADC2_CONV_CHANNELS | SARADC2_START | SARADC2_SINGLE_MODE,
> +		     FIELD_PREP(SARADC2_CONV_CHANNELS, channel) |
> +		     FIELD_PREP(SARADC2_START, 1) |
> +		     FIELD_PREP(SARADC2_SINGLE_MODE, 1));
> +
> +	return 0;
> +}
> +
>   int rockchip_saradc_start_channel(struct udevice *dev, int channel)
>   {
>   	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> @@ -162,6 +247,8 @@ int rockchip_saradc_probe(struct udevice *dev)
>   	int vref_uv;
>   	int ret;
>   
> +	priv->reset = devm_reset_control_get_optional(dev, "saradc-apb");
> +
>   	ret = clk_get_by_index(dev, 0, &clk);
>   	if (ret)
>   		return ret;
> @@ -178,6 +265,9 @@ int rockchip_saradc_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> +	if (priv->reset)
> +		rockchip_saradc_reset_controller(priv->reset);
> +
>   	vref_uv = regulator_get_value(vref);
>   	if (vref_uv < 0) {
>   		printf("can't get vref-supply value: %d\n", vref_uv);
> @@ -247,6 +337,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>   	.stop = rockchip_saradc_stop_v1,
>   };
>   
> +static const struct rockchip_saradc_data rk3588_saradc_data = {
> +	.num_bits = 12,
> +	.num_channels = 8,
> +	.clk_rate = 1000000,
> +	.channel_data = rockchip_saradc_channel_data_v2,
> +	.start_channel = rockchip_saradc_start_channel_v2,
> +};
> +
>   static const struct udevice_id rockchip_saradc_ids[] = {
>   	{ .compatible = "rockchip,saradc",
>   	  .data = (ulong)&saradc_data },
> @@ -254,6 +352,8 @@ static const struct udevice_id rockchip_saradc_ids[] = {
>   	  .data = (ulong)&rk3066_tsadc_data },
>   	{ .compatible = "rockchip,rk3399-saradc",
>   	  .data = (ulong)&rk3399_saradc_data },
> +	{ .compatible = "rockchip,rk3588-saradc",
> +	  .data = (ulong)&rk3588_saradc_data },
>   	{ }
>   };
>   
>
