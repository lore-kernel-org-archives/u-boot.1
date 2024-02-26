Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A515FC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F0D87EC6;
	Mon, 26 Feb 2024 09:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708937686;
	bh=IBC0kLw/QLSJXTTOvHMaDJ17HTBzmSx+RCjwmJHNES8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dMnvipyEHBsEc95X9GRL4ILPYdNemO03M8tITureQWp9va1jROHnEAemqMvZ4UBqr
	 RidEAJTDBHOLEvNLjezCfg6cy+bneoyI902NXkJdtDpNphjZwF2PAoATkv9BwH59QO
	 uP5ohm0Tr7RoJBS1Cb473x/XhzWUfAhWltGaXkv9URfW1DwY1A/KA+jEJbnOUu62aR
	 z5rwDE3dCu5sNcuZtQ47TDsT88PFE7CNxP+JEQTVySNXc2N7Kt60uzqOeobp0vkmGH
	 m1JAQ+1oQZiCtQzVaMXiFella9tO/jOc8yvdklyFslimL1Ol4ocB5P03knPWOoAFj8
	 DTcGu8fsF6dwg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A112987EC4;
 Mon, 26 Feb 2024 09:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708937682;
 bh=IBC0kLw/QLSJXTTOvHMaDJ17HTBzmSx+RCjwmJHNES8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BT4+rPwYhQuvR59bj1YxUDmndTIVjyAIV16XETeuF3Sxdi7KMh3kJ+JtqoZna4ejO
 17pQFSLjQjdMUe76+wuRr9E9xFxM6F1vSE+p0vsrCfgncihNI5KZcFbekoc+UxVRmp
 Y1Lswja114AOJ5r0VC/W/ZUCA/ilEXA3xuk/a3wt2HePfB+MAQMG/qABDb1CQsZKN6
 MWul7/X5zJ1ikltNJCmxHWV6uar++Ts1q4+Hpo3IgRWjjliyi9aWqya2pFnhxTor2K
 fr+tRRmThoIs6ma4p9Hu80Xh7UYelnOZ83duuf8GGsvrd/wK8OWYWrnfJqBQIEzP3h
 lAST2kk0CPhKw==
Message-ID: <609581c7-d221-4eff-862b-6f172ba9d4e8@denx.de>
Date: Mon, 26 Feb 2024 09:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240226080433.3307154-6-sumit.garg@linaro.org>
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
> Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
> PHY initialization moved to this standalone PHY driver.
> 
> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c.

Commit ID , see previous comments.

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
> +	if (dev_read_u32(dev, "fsl,tx-deemph-gen1", &imx8_phy->tx_deemph_gen1))
> +		imx8_phy->tx_deemph_gen1 = 0;

Use dev_read_u32_default() and you won't need the if (...)

> +	if (dev_read_u32(dev, "fsl,tx-deemph-gen2", &imx8_phy->tx_deemph_gen2))
> +		imx8_phy->tx_deemph_gen2 = 0;
> +
> +	if (dev_read_bool(dev, "fsl,clkreq-unsupported"))
> +		imx8_phy->clkreq_unused = true;
> +	else
> +		imx8_phy->clkreq_unused = false;
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
> +
> +	ret = clk_get_by_name(dev, "ref", &imx8_phy->hsio_clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to get PCIEPHY ref clock\n");
> +		return ret;
> +	}
> +
> +	ret = reset_get_by_name(dev, "pciephy", &imx8_phy->reset);
> +	if (ret) {
> +		dev_err(dev, "Failed to get PCIEPHY reset control\n");
> +		return ret;
> +	}

Some clk_put() and co. fail path is missing here. Also .remove is missing .
