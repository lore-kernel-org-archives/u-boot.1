Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB0DC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 15:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5CF487FE8;
	Tue, 20 Feb 2024 16:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708443163;
	bh=4EoL6QdQVlaaQUZxH0mhsbrOF88N7d+L6lfKsovkFdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iUz47+d1gMsiVig6TmzS+9F9PihvDHoL/RrNYH/v6xYf+S0DwmwfkVkcf/iLWA0pK
	 r1tupSloRl7ep2pBP29NO6ec+dCX9mHhgj1emH2piUZ4eyqDIBTIexSBexWXAqt3JP
	 NR/g+BpHod7TRi6liia5BhVSSEi+FbVk8YsIC+Jx+juIMbmuupjiJzkfRCc7SANUEX
	 ET5UP8HY5aroKmBzySt/QMQo/S8Rc0Vxcpr2VRg0tiIQgo2fqQ9EqIUcomchuSXUIh
	 uyhyDxJhOmyLHt620+24B/S5WrveDD8A80mOWAKs6+YC1bp0tmhM5rXjWOYQep8rae
	 2CHAcfarvbFhQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9852987FE0;
 Tue, 20 Feb 2024 16:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708443159;
 bh=4EoL6QdQVlaaQUZxH0mhsbrOF88N7d+L6lfKsovkFdY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Wcl/weB/l9PjOaK/g98txzg6zBR2VwqhlQQ3WRkpCov/xtAHlzWk6J6KW+Y9Juc7+
 SHJdmOZOxpVuIAQTL8sLSe+vdV+ZvYvm6oyHWTZIyCbLjQVNJ996Qsj9+vLCeW/m4W
 2SxZ6ZFma2aW6vTlDgBs7ZpGcejn/QN9/rUGzPEZ0r/sJUnXjjmORNORcYAYKA5mp3
 qzpBnqFmOes0QoehOJh/tNYMQovuPv/dlB1tmhTCdQhwK/A7B4Wd9b9AA/G98d7Xgu
 G3i3Mv5t8+HI00Jw47IF5OaKMA+Ix5neJHprVGHa1qGvhG/+OifpGi7idl02gHW7HD
 8WrR2BebmLRjw==
Message-ID: <947bbd39-451b-4ce0-86dc-47d95db2885d@denx.de>
Date: Tue, 20 Feb 2024 16:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] imx8mp: power-domain: Expose high performance PLL
 clock
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-5-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240220131056.2962331-5-sumit.garg@linaro.org>
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
> PCIe PHY can use it when there is no external refclock provided.

Commit message needs to be fixed.

> +static int hsio_pll_enable(struct udevice *dev)
> +{
> +	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
> +	unsigned long start;
> +	u32 val;
> +
> +	/* Setup HSIO PLL */
> +	val = readl(priv->base + GPR_REG2);
> +	val &= ~(P_PLL_MASK | M_PLL_MASK | S_PLL_MASK);
> +	val |= (FIELD_PREP(P_PLL_MASK, 12) | FIELD_PREP(M_PLL_MASK, 800) |
> +		FIELD_PREP(S_PLL_MASK, 4));
> +	writel(val, priv->base + GPR_REG2);

clrsetbits_le32()

> +	/* de-assert PLL reset */
> +	setbits_le32(priv->base + GPR_REG3, PLL_RST);
> +
> +	/* enable PLL */
> +	setbits_le32(priv->base + GPR_REG3, PLL_CKE);
> +
> +	/* Check if PLL is locked */
> +	start = get_timer(0);

wait_for_bit() or readl_poll_timeout()

> +	for (;;) {
> +		if (readl(priv->base + GPR_REG1) & PLL_LOCK)
> +			break;
> +
> +		if (get_timer(start) > 100) {
> +			dev_err(dev, "failed to lock HSIO PLL\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		udelay(10);
> +	}
> +
> +	return 0;
> +}
> +
> +static void hsio_pll_disable(struct udevice *dev)
> +{
> +	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
> +
> +	/* de-assert PLL reset */
> +	clrbits_le32(priv->base + GPR_REG3, PLL_RST);
> +
> +	/* enable PLL */
> +	clrbits_le32(priv->base + GPR_REG3, PLL_CKE);
> +}
> +
>   static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>   {
>   	struct udevice *dev = power_domain->dev;
> @@ -69,16 +127,23 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>   	if (ret)
>   		goto err_clk_pcie;
>   
> -	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> +	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB) {
>   		setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
> -	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
> +	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
>   		setbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
> -	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
> +	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
>   		setbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
>   						    PCIE_PHY_INIT_RST);
>   
> +		ret = hsio_pll_enable(dev);

Is this how Linux handles this PLL ?

Seems like this should be either syscon or clock driver .

[...]
