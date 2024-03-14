Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1FEC54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 04:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7EFC87F7F;
	Thu, 14 Mar 2024 05:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710389760;
	bh=JXUsRimkoV9UHIYpMfBa0zwaRhnQhxtYaadSZQ8fRDU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7PyUUYBDjw6k4GP889VwY/4QZG3jAsoiRxwCePIWAHZXPirtlY091IBugKiBkO8R
	 hky6YiWJg840GVFG5nFM31sbUSBDsYmIVgpVqrlgGDSWAqa+7cJ+Fuoy3IGMVs7JFd
	 haX7SFc+hmySzbdC5m+NlfM/A5Xsi6exkM23xiT0fZJlJjppc4BlL+AlPXztwuPVHt
	 dremYFzBHotfaIGk8g9JzYCSpmfqw/d1fSMSrK5NtgByDDT9YPx/tTDEKxM3HDUY97
	 tRg5fP4DGoC/g1F8RO/64pqCdbKn5neW5OOvYkuxyw6FGGMr8cr+TxlxpKP8YQ0bo2
	 TbTA8VDnQWM/w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9AF7587E0C;
 Thu, 14 Mar 2024 05:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710389759;
 bh=JXUsRimkoV9UHIYpMfBa0zwaRhnQhxtYaadSZQ8fRDU=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=VrULeed6y8B7X69XIDdhBwkoZORae+bmrcuenXjecYr6Yfrb5JEeQSs4I+KTf6w+z
 2YXmCEHjOz2Rl1zBTMw54+81Q58R71+TWV/nK+dnl5F7v4KUuQb4Ex6eHsospg9nqV
 vAi9gN/4wIGCXES8ygKQWS1PtvEBpT7zsxrs487x0noZjVgDPD51fQ7buhslvhh75N
 EYct3OuqKNxkG61jIzITUWwEp8CEHzNclC7ZCVbdYPExKss8YyXMMUV605w4XwCzpD
 gMzQT8sCV+ZvDYfXisCyhUyFsvAJEOOi2DiOABtlMLwgwxnY8dW1HpqZJ+T7/y9fN3
 t7vHy0GiKiokw==
Message-ID: <48de4f52-aa8a-414a-9094-ccfee70d55f8@denx.de>
Date: Thu, 14 Mar 2024 05:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 07/11] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-8-sumit.garg@linaro.org>
Content-Language: en-US
In-Reply-To: <20240312070338.86127-8-sumit.garg@linaro.org>
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
> Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
> PHY initialization moved to this standalone PHY driver.
> 
> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c. Use last Linux kernel driver
> reference commit 7559e7572c03 ("phy: Explicitly include correct DT
> includes").

[...]

> +static int imx8_pcie_phy_probe(struct udevice *dev)
> +{
> +	struct imx8_pcie_phy *imx8_phy = dev_get_priv(dev);
> +	ofnode gpr;
> +	int ret = 0;
> +
> +	imx8_phy->drvdata = (void *)dev_get_driver_data(dev);
> +	imx8_phy->base = dev_read_addr(dev);
> +	if (!imx8_phy->base)
> +		return -EINVAL;
> +
> +	/* get PHY refclk pad mode */
> +	dev_read_u32(dev, "fsl,refclk-pad-mode", &imx8_phy->refclk_pad_mode);
> +
> +	imx8_phy->tx_deemph_gen1 = dev_read_u32_default(dev,
> +							"fsl,tx-deemph-gen1",
> +							0);
> +	imx8_phy->tx_deemph_gen2 = dev_read_u32_default(dev,
> +							"fsl,tx-deemph-gen2",
> +							0);
> +	imx8_phy->clkreq_unused = dev_read_bool(dev, "fsl,clkreq-unsupported");
> +
> +	/* Grab GPR config register range */
> +	gpr = ofnode_by_compatible(ofnode_null(), imx8_phy->drvdata->gpr);
> +	if (ofnode_equal(gpr, ofnode_null())) {
> +		dev_err(dev, "unable to find GPR node\n");
> +		return -ENODEV;
> +	}
> +
> +	imx8_phy->iomuxc_gpr = syscon_node_to_regmap(gpr);
> +	if (IS_ERR(imx8_phy->iomuxc_gpr)) {
> +		dev_err(dev, "unable to find iomuxc registers\n");
> +		return PTR_ERR(imx8_phy->iomuxc_gpr);
> +	}

syscon_regmap_lookup_by_compatible() should simplify these two steps ^ .

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

[...]
