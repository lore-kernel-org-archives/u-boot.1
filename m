Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BA7C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 04:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7056487F30;
	Thu, 14 Mar 2024 05:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710389760;
	bh=loEe+76j7fWSgwvF+6x0D2rFCduQV+jH+neznAWM4OE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvsuLQLXlcmBkyqhNYGFWbwI0yZSoJIf+AfHsFSziU05eOdDDQOg+t2q47oKmJgSV
	 5UY6RDr2CzzSCZ0szZTjEf/vpitgfVnLomLrsrEf4ClF0f8VL1N3Y8YN4bxzid6DBz
	 xa+VpvC0iMqeezrJbVjHIyFaSWR0S2DLKsghzM8FOePH0nJCsphApCQgQ/PFCWwQVd
	 q/YJaaTWDPxXtEuQQKKzR4KY/lLonSrNKS19kYN9wS+8vvH9HinV0oF7XonoddGRc1
	 xhqShQ6dlZdIVNWtDCOKdI2Ck9cdxJvmvdCil+VZxLEGtX+Kv7eXpacMQPAjYNOBT3
	 LSuUMimLpAbvQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1A67987E1B;
 Thu, 14 Mar 2024 05:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710389757;
 bh=loEe+76j7fWSgwvF+6x0D2rFCduQV+jH+neznAWM4OE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qxT09AN+H/owq9ZVh+I/lijxDX3SVo57GqZ52dTjiZNnCPu5lQMvoRJNy3gXTzwVu
 QnT+NU8wz2ACUAHK+EiJbXSTqVzeiAxESx8uLL80AkHmvAhGrKvdJLd73OwQ1/ZEQ9
 NfuiAcDc2KAZkX7yYCV1N3XQLoQ2Um5p2vg1iRI5NKDX7zMKfukc6Keyvz92bqOkTo
 aaqKxM4zCI54/OipSrhdbQv3SfB96oXfIe4IVj1lJsUirTA1HwNdKsIArCrXZELvcw
 4e4EBmY9JODCgSff8ZGEvGH27m2B00Ph++f4QA+Ga3bKYR5c0C5c+VVSii3hGtSm/t
 7jVi7vRN31Omw==
Message-ID: <f3e37ebd-5740-4c8f-875d-4ab2d37411fd@denx.de>
Date: Thu, 14 Mar 2024 05:13:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] pci: Add DW PCIe controller support for iMX8MP
 SoC
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-9-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240312070338.86127-9-sumit.garg@linaro.org>
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

On 3/12/24 8:03 AM, Sumit Garg wrote:
> pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> tied to quite old port of pcie_designware driver from Linux which
> suffices only iMX6 specific needs.
> 
> But currently we have the common DWC specific bits which alligns pretty
> well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> add support for other iMX8 variants to this driver.
> 
> iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> can reuse the generic PHY infrastructure to power on PCIe PHY.
> 
> Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
> Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

[...]

> +static int pcie_dw_imx_of_to_plat(struct udevice *dev)
> +{
> +	struct pcie_dw_imx *priv = dev_get_priv(dev);
> +	ofnode gpr;
> +	int ret;
> +
> +	/* Get the controller base address */
> +	priv->dw.dbi_base = (void *)dev_read_addr_name(dev, "dbi");
> +	if ((fdt_addr_t)priv->dw.dbi_base == FDT_ADDR_T_NONE) {
> +		dev_err(dev, "failed to get dbi_base address\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Get the config space base address and size */
> +	priv->dw.cfg_base = (void *)dev_read_addr_size_name(dev, "config",
> +							    &priv->dw.cfg_size);
> +	if ((fdt_addr_t)priv->dw.cfg_base == FDT_ADDR_T_NONE) {
> +		dev_err(dev, "failed to get cfg_base address\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_get_bulk(dev, &priv->clks);
> +	if (ret) {
> +		dev_err(dev, "failed to get PCIe clks\n");
> +		return ret;
> +	}
> +
> +	ret = reset_get_by_name(dev, "apps", &priv->apps_reset);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to get PCIe apps reset control\n");
> +		goto err_reset;
> +	}
> +
> +	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
> +				   (GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE));

The extra parenthesis () is not needed.

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
