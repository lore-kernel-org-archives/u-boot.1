Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA504C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F23E87ED8;
	Mon, 26 Feb 2024 09:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708937683;
	bh=bcbTgrR+/mF733RBUc7oFNBveB6syDDYO2ZIkwRvIv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F/PDrloH9bwfBT+fxxtGE3oWSAlSdShjW/2QHgpp7soADY3SIY5fZyJehtYKn4kK7
	 9Dx2wJdivxWHiBycb+4HSlNarmDgjtAdxzf5ul0cE7rVBmTCZ2YyqWefBbCiilzXpd
	 FBR0gC6+dv/PQJR7z9f2rZx8TXWtv7Mz2/hNqZHnC8oXIfGaP9606wJ7fqj8oIeEX9
	 0GqJTM+v8H3fphB6Hcjx42xyU/gAq9jUn1GHbGPGkb+wuPPTyVCBT+N/WGmVciVvGx
	 3ww6TphhU1LCpJ6DyOjQMP+d/tEC+yFG7OCQ3CYPtWVtLgTq0btJFHRpQMTq6BwtM6
	 H4xiBSgMk+8YA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DC61487E9C;
 Mon, 26 Feb 2024 09:54:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708937680;
 bh=bcbTgrR+/mF733RBUc7oFNBveB6syDDYO2ZIkwRvIv0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UrPRXX8nnX0ylGqukANkVIme6Sf8tGIDhTUUbrYRFFSHnMP6VbnHjwfY9cw2TvBnZ
 BqBZnV6iktDRg/M9cpyqCOtqwVMA3sQhuDj0Yx6m3Giz6CEyHeD4BMfFykYFB3PqwJ
 5M3u/0yxNWXDaJ3AIhxx5kmbNa966JrKC2Bw2/LZBTNPbntDjumhaCeBdj0al1PREE
 WnLZuZHbZbfkxEzdrarudlSjSc8KiA+wwsKiLO2zte+e24KHn/7WxrUawdLSuWi3ci
 WI1q+0iVywm78sw2v9EWkB/Sqhi2GIFGXrIUdCiQHVeB4Ky5FogMsKWPT5wKcQIhsb
 eo+Gt1WVuKmPQ==
Message-ID: <73e06c3c-ac55-4fa1-923d-add85eb96505@denx.de>
Date: Mon, 26 Feb 2024 09:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] imx8mp: power-domain: Add PCIe support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-4-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240226080433.3307154-4-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2/26/24 9:04 AM, Sumit Garg wrote:
> Add support for GPCv2 power domains and clock handling for PCIe and
> PCIe PHY.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/power/domain/imx8mp-hsiomix.c | 101 ++++++++++++++++++++------
>   1 file changed, 78 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> index e2d772c5ec78..58cc3f63bb56 100644
> --- a/drivers/power/domain/imx8mp-hsiomix.c
> +++ b/drivers/power/domain/imx8mp-hsiomix.c
> @@ -16,48 +16,73 @@
>   #define GPR_REG0		0x0
>   #define  PCIE_CLOCK_MODULE_EN	BIT(0)
>   #define  USB_CLOCK_MODULE_EN	BIT(1)
> +#define  PCIE_PHY_APB_RST	BIT(4)
> +#define  PCIE_PHY_INIT_RST	BIT(5)
>   
>   struct imx8mp_hsiomix_priv {
>   	void __iomem *base;
>   	struct clk clk_usb;
> +	struct clk clk_pcie;
>   	struct power_domain pd_bus;
>   	struct power_domain pd_usb;
> +	struct power_domain pd_pcie;
>   	struct power_domain pd_usb_phy1;
>   	struct power_domain pd_usb_phy2;
> +	struct power_domain pd_pcie_phy;
>   };
>   
>   static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>   {
>   	struct udevice *dev = power_domain->dev;
>   	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
> -	struct power_domain *domain;
> +	struct power_domain *domain = NULL;
> +	struct clk *clk = NULL;
> +	u32 gpr_reg0_bits = 0;
>   	int ret;
>   
> -	ret = power_domain_on(&priv->pd_bus);
> -	if (ret)
> -		return ret;
> -
> -	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB) {
> +	switch (power_domain->id) {
> +	case IMX8MP_HSIOBLK_PD_USB:
>   		domain = &priv->pd_usb;
> -	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY1) {
> +		clk = &priv->clk_usb;
> +		gpr_reg0_bits |= USB_CLOCK_MODULE_EN;
> +		break;
> +	case IMX8MP_HSIOBLK_PD_USB_PHY1:
>   		domain = &priv->pd_usb_phy1;
> -	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2) {
> +		break;
> +	case IMX8MP_HSIOBLK_PD_USB_PHY2:
>   		domain = &priv->pd_usb_phy2;
> -	} else {
> -		ret = -EINVAL;
> -		goto err_pd;
> +		break;
> +	case IMX8MP_HSIOBLK_PD_PCIE:
> +		domain = &priv->pd_pcie;
> +		clk = &priv->clk_pcie;
> +		gpr_reg0_bits |= PCIE_CLOCK_MODULE_EN;
> +		break;
> +	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
> +		domain = &priv->pd_pcie_phy;
> +		/* Bits to deassert PCIe PHY reset */
> +		gpr_reg0_bits |= PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST;
> +		break;
> +	default:
> +		dev_err(dev, "unknown power domain id: %ld\n",
> +			power_domain->id);
> +		return -EINVAL;
>   	}
>   
> +	ret = power_domain_on(&priv->pd_bus);
> +	if (ret)
> +		return ret;
> +
>   	ret = power_domain_on(domain);
>   	if (ret)
>   		goto err_pd;
>   
> -	ret = clk_enable(&priv->clk_usb);
> -	if (ret)
> -		goto err_clk;
> +	if (clk) {
> +		ret = clk_enable(clk);
> +		if (ret)
> +			goto err_clk;
> +	}
>   
> -	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> -		setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
> +	setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);

Are you sure it is OK to do this unconditionally ?

Why not this:

if (gpr_reg0_bits)
   setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);

>   	return 0;
>   
> @@ -73,17 +98,31 @@ static int imx8mp_hsiomix_off(struct power_domain *power_domain)
>   	struct udevice *dev = power_domain->dev;
>   	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
>   
> -	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> +	switch (power_domain->id) {
> +	case IMX8MP_HSIOBLK_PD_USB:
>   		clrbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
> -
> -	clk_disable(&priv->clk_usb);
> -
> -	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> +		clk_disable(&priv->clk_usb);
>   		power_domain_off(&priv->pd_usb);
> -	else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY1)
> +		break;
> +	case IMX8MP_HSIOBLK_PD_USB_PHY1:
>   		power_domain_off(&priv->pd_usb_phy1);
> -	else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2)
> +		break;
> +	case IMX8MP_HSIOBLK_PD_USB_PHY2:
>   		power_domain_off(&priv->pd_usb_phy2);
> +		break;
> +	case IMX8MP_HSIOBLK_PD_PCIE:

Maybe we need some function ... imx8mp_hsiomix_id_to_pd() to avoid this 
duplicate switch statement:

pd = imx8mp_hsiomix_id_to_pd(...)
...
power_domain_off(fd);

> +		clrbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
> +		clk_disable(&priv->clk_pcie);
> +		power_domain_off(&priv->pd_pcie);
> +		break;
> +	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
> +		clrbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
> +						    PCIE_PHY_INIT_RST);
> +		power_domain_off(&priv->pd_pcie_phy);

Is it OK to turn off the bus PD after this ?
Please double-check if power_domain_on/off() is refcounted .

> +		break;
> +	default:
> +		break;
> +	}
>   
>   	power_domain_off(&priv->pd_bus);
>   
> @@ -109,6 +148,10 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
>   	if (ret < 0)
>   		return ret;
>   
> +	ret = clk_get_by_name(dev, "pcie", &priv->clk_pcie);
> +	if (ret < 0)
> +		return ret;
> +
>   	ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
>   	if (ret < 0)
>   		return ret;

Some clk_put() seems to be missing for clk_pcie .
