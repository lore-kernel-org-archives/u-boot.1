Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D7ACA0ECC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D6188D60;
	Fri, 30 Aug 2024 03:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724981206;
	bh=+SbkYwwm9OJZN5wuvbO6t0N3q+/n+mT4sFjt2xL8gF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tpUPOm/BlgeUbOZCthVbvCi3168QuTPRSrJbV2kjROAbGAiNHz3Y3AXgYjkeNI/Cp
	 HvQIeAlzMb0Q22W18lDykuP2StVe8ZzRTulpLlqbvUG3cMqM87Fih64xYswA0DUDxm
	 FFbKuUpn03/gIfcgjGhWrypA5mrwPkzfdAEqQsCXW/gZYexhpVamJqloRIkyv7E7s3
	 UNs2wcbm9AaB/3yO/IqLWqc4EyUGmXgEicapAEbj3kB/165AJ/7FxvnlIfQ3TUrZ5z
	 CUUS4RDkEq5eX5OSkZ2X2pdHfl793EN5ys5ubC3OPako2iqGlg8yHetgWunX6EWTna
	 doBU338Utb5EA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4CCFA886CC;
 Fri, 30 Aug 2024 03:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724981204;
 bh=+SbkYwwm9OJZN5wuvbO6t0N3q+/n+mT4sFjt2xL8gF4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VSncRD71+v+Ck5f+ftlh0qp7nGJKLiuk8ZXzOXzeo57FkNTEjYW61oxsjbF5uwbdU
 rdWA1BaswAsy6aKa5f3TRzdFRTlhUoKclmoG6+f1XMyqzJ/iCK1jz+fyKFkkIwwhEZ
 LpOkKGdlFhffBBP2bxrhwXRTeeNMoMkNa869o82hD7/AimuNDiF22NMeo6ZzploEJH
 V+B3Gj5omRu1axtsQpV4scci1qYjQojvXjrGO9bBSx0OdXx7BkKjmJNiDVc4vWNWuP
 VMDZACFbhwWlab8TyFLUMTe5oJ25siSr3MgIohP1j1wg4z3DwxZux3voxahbPH6QmO
 gw+vPP/v7OC8g==
Message-ID: <377687e7-4487-406f-93ca-91000bb4e85b@denx.de>
Date: Fri, 30 Aug 2024 03:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] usb: cdns: starfive: Add cdns USB driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-5-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240829013058.6178-5-minda.chen@starfivetech.com>
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

On 8/29/24 3:30 AM, Minda Chen wrote:
> Add cdns USB3 wrapper driver.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>   drivers/usb/cdns3/Kconfig          |   7 ++
>   drivers/usb/cdns3/Makefile         |   2 +
>   drivers/usb/cdns3/cdns3-starfive.c | 191 +++++++++++++++++++++++++++++
>   3 files changed, 200 insertions(+)
>   create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
> 
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index 35b61497d9..f8f363982b 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -55,4 +55,11 @@ config USB_CDNS3_TI
>   	help
>   	  Say 'Y' here if you are building for Texas Instruments
>   	  platforms that contain Cadence USB3 controller core. E.g.: J721e.
> +
> +config USB_CDNS3_STARFIVE
> +	tristate "Cadence USB3 support on Starfive platforms"
> +	default USB_CDNS3

Should this be 'default y if SOMEPLATFORM' ?

[...]

> +static void cdns_mode_init(struct cdns_starfive *data, enum usb_dr_mode mode)
> +{
> +	unsigned int strap, suspendm;
> +
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_MISC_CFG_MASK,
> +			   USB_SUSPENDM_BYPS | USB_PLL_EN | USB_REFCLK_MODE);
> +
> +	switch (mode) {
> +	case USB_DR_MODE_HOST:
> +		strap = USB_STRAP_HOST;
> +		suspendm = USB_SUSPENDM_HOST;
> +		break;
> +
> +	case USB_DR_MODE_PERIPHERAL:
> +		strap = USB_STRAP_DEVICE;
> +		suspendm = 0;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_STRAP_MASK, strap);
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_SUSPENDM_MASK, suspendm);

Are two consecutive writes to the same register mandatory here ?

> +}

[...]

> +static int cdns_starfive_probe(struct udevice *dev)
> +{
> +	struct cdns_starfive *data = dev_get_plat(dev);
> +	enum usb_dr_mode dr_mode;
> +	ofnode node;
> +	int ret;
> +
> +	data->dev = dev;
> +
> +	ret = cdns_starfive_get_syscon(data);
> +	if (ret)
> +		return ret;
> +
> +	node = ofnode_by_compatible(dev_ofnode(dev), "cdns,usb3");
> +	if (!ofnode_valid(node)) {
> +		dev_err(dev, "failed to get usb node\n");

USB in capitals.

> +		return -ENODEV;
> +	}
> +
> +	dr_mode = usb_get_dr_mode(node);
> +
> +	data->mode = dr_mode;
> +	ret = cdns_clk_rst_init(data);
> +	if (ret) {
> +		dev_err(data->dev, "clk reset failed: %d\n", ret);
> +		return ret;
> +	}
> +	cdns_mode_init(data, dr_mode);
> +
> +	return 0;
> +}

Looks pretty good, thanks .
