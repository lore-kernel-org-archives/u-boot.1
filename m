Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300D8C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 15:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6104287FC2;
	Tue, 20 Feb 2024 16:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708443163;
	bh=gTZ2n0Leke/hO+FYihByw5ARY6WX8uSye5mU87v0+i4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S6nhP8d9nC1Xg4mYxQUYly5tjO2WcLu5X0xm501L69PmlafY6TKwlSts2VqufWNN1
	 VHO8pn5DodklNRXDaoUG7mKfxg/viVOWUq70rHvga5PYOLeOHyMPuhlGY86MEBlzeY
	 SzxRhdAvB1QwfVVTknRNHde848AvWA6qgqDfwus4NL8gdaYDLi/dxXM4wtTin7B4SV
	 rgsWan7fi4sRMlBOnSJKdWK0q7Reag+xgTsn1eEIUmoA8ScsptaF8RLdH/xJkc24Mq
	 Oz3yffjfjVENS46VZ7zFPs7dLoJbu1lYpPinrCY34HVAv2T1663EU8viBLatyN4pgS
	 JPhYdbOJN96sw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E2CE287ED6;
 Tue, 20 Feb 2024 16:32:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708443158;
 bh=gTZ2n0Leke/hO+FYihByw5ARY6WX8uSye5mU87v0+i4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m3jsa6fPzqESY1siXSbbys+5bXyILKku8vVL09SdG3ahEMhu5xDvMrcN8CQyLR2lf
 D9m1uDab05N3MdAU9TnQi0UpcVp52IWKID7L+rgtiG6TnF1KWRlw2WSC6pXYt8zZI8
 rEp6Y4po7R8rKiSlOzF+DdyzG+pmFO9kh9xwxiKOzPW8sBayaGiU7T0JAueJN5wLXa
 XMbe/yxyMiGaRKozzmGF6vgZGj2dgw5LAaLarNjR5sDyuaIfzQmFvRQ0YBvhECgLqb
 YiGUKU24e0Zl7nPzoLGqr1pmkA3Igxa5Qiz24WMMmV4GyrgBCJYzw9I0Vfy4CX6mhU
 z+KI2jZgXqIVg==
Message-ID: <d3bd5acf-ad1e-4a99-b7fc-84fbddf33880@denx.de>
Date: Tue, 20 Feb 2024 16:14:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] imx8mp: power-domain: Add PCIe support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-4-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240220131056.2962331-4-sumit.garg@linaro.org>
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

On 2/20/24 14:10, Sumit Garg wrote:
> Pre-requisite to enable PCIe support on iMX8MP SoC.

This commit message is useless, write a proper one.

> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/power/domain/imx8mp-hsiomix.c | 50 +++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> index e2d772c5ec7..62145e0261b 100644
> --- a/drivers/power/domain/imx8mp-hsiomix.c
> +++ b/drivers/power/domain/imx8mp-hsiomix.c
> @@ -16,14 +16,19 @@
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
> @@ -43,6 +48,10 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>   		domain = &priv->pd_usb_phy1;
>   	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2) {
>   		domain = &priv->pd_usb_phy2;
> +	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
> +		domain = &priv->pd_pcie;
> +	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
> +		domain = &priv->pd_pcie_phy;
>   	} else {
>   		ret = -EINVAL;
>   		goto err_pd;
> @@ -54,14 +63,25 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>   
>   	ret = clk_enable(&priv->clk_usb);
>   	if (ret)
> -		goto err_clk;
> +		goto err_clk_usb;
> +
> +	ret = clk_enable(&priv->clk_pcie);
> +	if (ret)
> +		goto err_clk_pcie;

Does this mean that when USB power domains get enabled, PCIe clock are 
also enabled ? Why ?

What if the PCIe clock enable fails, do USB clock remain enabled ?

>   	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
>   		setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
> +	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
> +		setbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
> +	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
> +		setbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
> +						    PCIE_PHY_INIT_RST);

Shouldn't the reset bits be cleared here ?

[...]
