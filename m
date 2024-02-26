Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11A1C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A7C87EE4;
	Mon, 26 Feb 2024 09:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708937686;
	bh=As5R0IcDeBLX8erDruc8JHYOkCzHy61LRZi7tEWHfqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kVpL2rZiJ9SZR8NF5QlO3t/bczvc0+fYtrBgUnqE+vx3Z6muBJIsQuBvPbEl+HyT/
	 qnAhQy0kb4AnLCJon+Z+uPJUnXo5pkEGPci07syv4VjlaIjsCauLzBrkUe35CbxAtU
	 Ni2GoFQ9L47Q45pEjjeLKsaNFWk2oo58z6tp+naPjGl2qEHDyotWfqRrlZbPTT5axs
	 5PNjGJRRV7AswFOCo2DT8/1nQirJUOddVo8Wce+LGpVq7jfXARgXG0qCKVDzRsv36k
	 xVsRB9QNo9RUCFhtszQAGo85NHvkBSGapkWBPIOxBjdfi6YVb32Byewm+XsBq+xOLd
	 Db755WlQqYeOg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5C99287EDA;
 Mon, 26 Feb 2024 09:54:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708937684;
 bh=As5R0IcDeBLX8erDruc8JHYOkCzHy61LRZi7tEWHfqA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V63OhuLE83qbnihg1lXhi08/b8fFUjG7Hcau5+UvTG3QMwd6p10P9tRk1DgQ8GmxU
 /tO8FO0ohSKvGlbw80IgqtWg+n9CcAzkMfUVyRM1+CKBWBGA+YVerw6W+2603yq9IT
 UHA1rSH/nMOOBK0fwfP3NavAChj4ase5DW5qu3udXBckFBbqyqsRFT9xgEVhfwXaBq
 Kj22rPO773+U/sqnt6f6p1ijcCjbv0yvYSBdVVHN2h8M7xNMVDRgqeP+XrGV1N6bwv
 Vi37jRDM7OrjBkE2DzgIEjcuuS3MZdJXu0N9RcKRjRhvZl5gGCjoeQwcZk5YniE6Ua
 IEIRMsfeGH8Rg==
Message-ID: <3f5cf71b-ef9a-4e8b-99c2-cb51d342db7f@denx.de>
Date: Mon, 26 Feb 2024 09:44:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] pci: Add DW PCIe controller support for iMX8MP SoC
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-7-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240226080433.3307154-7-sumit.garg@linaro.org>
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
> pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> tied to quite old port of pcie_designware driver from Linux which
> suffices only iMX6 specific needs.

It is probably hand-rolled, but it does suck, that's true.

> But currently we have the common DWC specific bits which alligns pretty
> well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> add support for other iMX8 variants to this driver.
> 
> iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> can reuse the generic PHY infrastructure to power on PCIe PHY.

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
> +		return ret;
> +	}
> +
> +	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
> +				   (GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE));
> +	if (ret) {
> +		dev_err(dev, "unable to get reset-gpio\n");
> +		return ret;
> +	}
> +
> +	ret = generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
> +	if (ret) {
> +		dev_err(dev, "failed to get pcie phy\n");
> +		return ret;
> +	}
> +
> +	gpr = ofnode_by_compatible(ofnode_null(), "fsl,imx8mp-iomuxc-gpr");
> +	if (ofnode_equal(gpr, ofnode_null())) {
> +		dev_err(dev, "unable to find GPR node\n");
> +		return -ENODEV;
> +	}

You likely need a fail path here too, to undo allocation and co.
