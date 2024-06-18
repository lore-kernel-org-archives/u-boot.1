Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7203C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CA4488476;
	Tue, 18 Jun 2024 09:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SpliSF09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B72882E5; Tue, 18 Jun 2024 09:27:59 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4CF38842C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ebd95f136bso58316931fa.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718695676; x=1719300476;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2FA91q3w3IwDN1gxCzAXrzAia0/uLLLBxT/yEapIY8A=;
 b=SpliSF099ZqfLti0vleMPG6Iv1Q7er1HdtcMziH7dO7fSbStaUfI+1VurNltD5junf
 mrSMD3aKzwspFTM19e9jiRw14HZers+jXgUV6ACrWv2ioYqN+1n45X6NVKGUEP0r04Pu
 8f+KKBz38+9cqgMgIVoacbWUxa0PM96J7YnL2/NkDt8lNUsQaxXSfOyeo82/EOu/vZND
 7ec99hnD0wukK+aPvVwSy5El8VaikXr15lmFEzgi7lpBltzKHjWLHjKly1+4Z+tDOKtQ
 TWWnLtLZHgLDWjPyzIZAmYtzLgeaZlqJ9T83wwONEpyLoHxa3pZWA1hTKy2RU1kwnb02
 47jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718695676; x=1719300476;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2FA91q3w3IwDN1gxCzAXrzAia0/uLLLBxT/yEapIY8A=;
 b=gqKMGrCwXbU8uIbYOqV5D5Ga26R4RLbVXBdyp+km/u7pUaRFCSYFl0C9FPj0JILjRk
 sQ69KiqaPNvNeJDfAsYxQopvGy4HIkmLx8VT69Mbthg3ybQvJCjXn0DrWbg6QZUELMK+
 rFtEhBi5iiVkoYUltPJJuau77pXa0rgUz0N2BCvXFo34btBgLCr4tB520JBzTItPlMlr
 liRK7dk1KBDHpATF6PusVVMCEPvnsQiS669yarwxfgbVwER8+5GdcR6ZwLgCnmbokNGp
 tpUcNP13aMfLVnBAwVJMUEMIR52jiqN56IxQlyskS3N228LhJCDYyG5ENLd49VN1CpLU
 i/wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgDYG9C/An1zjt4ls9WgrjM9DHFxHDEktDcSDwXPKlDe8mkJA48hFBJmhHrXctFH1HMW70AJh1W5L3tzWcxhH8M5jwSg==
X-Gm-Message-State: AOJu0Yze2wd/mJfFWnhZrp2kLPJGKOLws9g/qNNOCtTdhwuwHcm1SIAz
 +mtDpOM704UZi/VoP/oOV5z2o1vfWMd69AXFoh1EmQXf3tLIMLuNU8HiVotPdJE=
X-Google-Smtp-Source: AGHT+IFfOBZV4F8s3FDY7zagcVZtlaeBAMaLMf2sP+rboLoWcoC+8VfL0zcSpLIQWz15Q4/vnFHI9Q==
X-Received: by 2002:a2e:350e:0:b0:2ec:2b25:3c8e with SMTP id
 38308e7fff4ca-2ec2b253d64mr34407391fa.39.1718695676024; 
 Tue, 18 Jun 2024 00:27:56 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eefa07sm220393705e9.8.2024.06.18.00.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:27:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 04/11] usb: gadget: dwc3: Convert interrupt handling to
 usb_gadget_generic_ops
In-Reply-To: <20240614005309.34433-5-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-5-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:27:53 +0200
Message-ID: <87y172iubq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

Thank you for the patch.

On ven., juin 14, 2024 at 02:51, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Implement .handle_interrupts callback as a replacement for deprecated
> dm_usb_gadget_handle_interrupts() function. The new callback allows
> for each DM capable USB gadget controller driver to define its own
> IRQ handling implementation without colliding with other controller
> drivers.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/usb/dwc3/dwc3-generic.c    | 23 ++++++++++++++---------
>  drivers/usb/dwc3/dwc3-layerscape.c | 21 +++++++++++++--------
>  2 files changed, 27 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 8db678eb85d..731ede2fead 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -194,34 +194,39 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>  }
>  
>  #if CONFIG_IS_ENABLED(DM_USB_GADGET)
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +static int dwc3_generic_peripheral_probe(struct udevice *dev)
>  {
>  	struct dwc3_generic_priv *priv = dev_get_priv(dev);
> -	struct dwc3 *dwc3 = &priv->dwc3;
>  
> -	dwc3_gadget_uboot_handle_interrupt(dwc3);
> -
> -	return 0;
> +	return dwc3_generic_probe(dev, priv);
>  }
>  
> -static int dwc3_generic_peripheral_probe(struct udevice *dev)
> +static int dwc3_generic_peripheral_remove(struct udevice *dev)
>  {
>  	struct dwc3_generic_priv *priv = dev_get_priv(dev);
>  
> -	return dwc3_generic_probe(dev, priv);
> +	return dwc3_generic_remove(dev, priv);
>  }
>  
> -static int dwc3_generic_peripheral_remove(struct udevice *dev)
> +static int dwc3_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	struct dwc3_generic_priv *priv = dev_get_priv(dev);
> +	struct dwc3 *dwc3 = &priv->dwc3;
>  
> -	return dwc3_generic_remove(dev, priv);
> +	dwc3_gadget_uboot_handle_interrupt(dwc3);
> +
> +	return 0;
>  }
>  
> +static const struct usb_gadget_generic_ops dwc3_gadget_ops = {
> +	.handle_interrupts	= dwc3_gadget_handle_interrupts,
> +};
> +
>  U_BOOT_DRIVER(dwc3_generic_peripheral) = {
>  	.name	= "dwc3-generic-peripheral",
>  	.id	= UCLASS_USB_GADGET_GENERIC,
>  	.of_to_plat = dwc3_generic_of_to_plat,
> +	.ops	= &dwc3_gadget_ops,
>  	.probe = dwc3_generic_peripheral_probe,
>  	.remove = dwc3_generic_peripheral_remove,
>  	.priv_auto	= sizeof(struct dwc3_generic_priv),
> diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
> index ff83bf71e89..108b44c67eb 100644
> --- a/drivers/usb/dwc3/dwc3-layerscape.c
> +++ b/drivers/usb/dwc3/dwc3-layerscape.c
> @@ -99,33 +99,38 @@ static int dwc3_layerscape_of_to_plat(struct udevice *dev)
>  }
>  
>  #if CONFIG_IS_ENABLED(DM_USB_GADGET)
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +static int dwc3_layerscape_peripheral_probe(struct udevice *dev)
>  {
>  	struct dwc3_layerscape_priv *priv = dev_get_priv(dev);
>  
> -	dwc3_gadget_uboot_handle_interrupt(&priv->dwc3);
> -
> -	return 0;
> +	return dwc3_layerscape_probe(dev, priv);
>  }
>  
> -static int dwc3_layerscape_peripheral_probe(struct udevice *dev)
> +static int dwc3_layerscape_peripheral_remove(struct udevice *dev)
>  {
>  	struct dwc3_layerscape_priv *priv = dev_get_priv(dev);
>  
> -	return dwc3_layerscape_probe(dev, priv);
> +	return dwc3_layerscape_remove(dev, priv);
>  }
>  
> -static int dwc3_layerscape_peripheral_remove(struct udevice *dev)
> +static int dwc3_layerscape_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	struct dwc3_layerscape_priv *priv = dev_get_priv(dev);
>  
> -	return dwc3_layerscape_remove(dev, priv);
> +	dwc3_gadget_uboot_handle_interrupt(&priv->dwc3);
> +
> +	return 0;
>  }
>  
> +static const struct usb_gadget_generic_ops dwc3_layerscape_gadget_ops = {
> +	.handle_interrupts	= dwc3_layerscape_gadget_handle_interrupts,
> +};
> +
>  U_BOOT_DRIVER(dwc3_layerscape_peripheral) = {
>  	.name	= "dwc3-layerscape-peripheral",
>  	.id	= UCLASS_USB_GADGET_GENERIC,
>  	.of_to_plat = dwc3_layerscape_of_to_plat,
> +	.ops	= &dwc3_layerscape_gadget_ops,
>  	.probe = dwc3_layerscape_peripheral_probe,
>  	.remove = dwc3_layerscape_peripheral_remove,
>  	.priv_auto	= sizeof(struct dwc3_layerscape_priv),
> -- 
> 2.43.0
