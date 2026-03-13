Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42479106FD9B
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 08:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA0B83FA4;
	Fri, 13 Mar 2026 09:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CVjbEnrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22D188420D; Fri, 13 Mar 2026 09:12:42 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F44883F86
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 09:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bzFCcaQeVRH/JLP5q7SDI1tdKQkk+kVDOvKGPONFXgE=; b=CVjbEnrkpJQcBcRFSb7d9XvB0p
 9C/Yeh7aa6Xz95SfUkRINXspeaCN2WLCcJuZ0sADmoG0c4AgBcPGfw8SnRUd9EBfvOCvWjtKMdxSv
 lcFV9Evasrpq80H6ppHUvAwKkHhuEPmEiipHLjQ8jusI5Sc1CtKpJpppNTuitFMEcqxyzB0s5VdpT
 P/tqBQspDzqGoxsO/blu99mJSmyaR6ejhXfvTKMCQxXaHFt0BoeBeVSe5zzxlFquU7EyS+D03PpK/
 idp2JwiNE5R62Nvu50ZghuiUKpemI9kYdNaXaQq9OkKz7uCh19OB4S7v2jd8dgIX1s2YoNlSzwG8j
 e6ay+YBg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1w0xdP-000Pl9-0v; Fri, 13 Mar 2026 09:12:39 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1w0xdP-00016K-08; Fri, 13 Mar 2026 09:12:39 +0100
Message-ID: <9e8aa4e7-72ab-4b1a-b324-4c78b13b9741@ew.tq-group.com>
Date: Fri, 13 Mar 2026 09:12:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT] pci: imx: Properly support upstream Linux reset-gpios
 property
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org
References: <20260312192605.131132-1-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20260312192605.131132-1-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 3/12/26 20:26, Krzysztof Kozlowski wrote:
> The driver requests explicitly "reset-gpio" property, not the one with
> "gpios" suffix but upstream Linux kernel deprecated it in 2021.
> Existing upstream Linux kernel DTS is being changed to "reset-gpios"
> property, thus update the driver to read that one too.
>
> Note that driver is probably broken already, because it parsed GPIO in
> standard way respecting the flags and on top of that applied the
> "reset-gpio-active-high" flag, thus "reset-gpio ACTIVE_LOW" with the
> "reset-gpio-active-high" property would be double inverted.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> ---
>
> 1. https://lore.kernel.org/linux-devicetree/20260312-dts-snps-reset-gpios-v2-12-0d5040eb4a1e@oss.qualcomm.com/
> 2. See Linux kernel commit 42694f9f6407 ("dt-bindings: PCI: add snps,dw-pcie.yaml")
> ---
>   drivers/pci/pcie_imx.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pcie_imx.c b/drivers/pci/pcie_imx.c
> index 11c4ccbfc555..8d853ecf2c22 100644
> --- a/drivers/pci/pcie_imx.c
> +++ b/drivers/pci/pcie_imx.c
> @@ -728,15 +728,31 @@ static int imx_pcie_dm_write_config(struct udevice *dev, pci_dev_t bdf,
>   static int imx_pcie_dm_probe(struct udevice *dev)
>   {
>   	struct imx_pcie_priv *priv = dev_get_priv(dev);
> +	int ret;
>   
>   #if CONFIG_IS_ENABLED(DM_REGULATOR)
>   	device_get_supply_regulator(dev, "vpcie-supply", &priv->vpcie);
>   #endif
>   
>   	/* if PERST# valid from dt then assert it */
> -	gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
> -			     GPIOD_IS_OUT);
> -	priv->reset_active_high = dev_read_bool(dev, "reset-gpio-active-high");
> +	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
> +				   GPIOD_IS_OUT);
> +	if (!ret) {
> +		/*
> +		 * Legacy property, invert assert logic based on
> +		 * reset-gpio-active-high. This won't work if flags are not
> +		 * matching the reset-gpio-active-high.
> +		 */
> +		priv->reset_active_high = dev_read_bool(dev, "reset-gpio-active-high");

A warning should also be issued when using the deprecated "reset-gpio" 
property.

             dev_warn(dev, "reset-gpio property deprecated, use 
reset-gpios\n");

> +	} else {
> +		/*
> +		 * Linux kernel upstream property, assert active level based on
> +		 * GPIO flags, thus leave priv->reset_active_high=0.
> +		 */
> +		gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset_gpio,
> +				     GPIOD_IS_OUT);
> +	}
> +
>   	if (dm_gpio_is_valid(&priv->reset_gpio)) {
>   		dm_gpio_set_value(&priv->reset_gpio,
>   				  priv->reset_active_high ? 0 : 1);

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

