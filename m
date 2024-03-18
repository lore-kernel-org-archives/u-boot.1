Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70092C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 12:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A10C887D66;
	Mon, 18 Mar 2024 13:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e/6PPX0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A2487D83; Mon, 18 Mar 2024 13:47:23 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4879879AF
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 13:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3416df43cabso666835f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710766040; x=1711370840; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vn6vfOb4VHfhuuF3mAsvF8lR2Ro+15TJo0Q+CM1vmtk=;
 b=e/6PPX0G0P73PT2fdAoT1B5G9Qpzt67mi52oa/fyZrgi8k92Jv3KZNfTHVAeJG97MD
 fdXRhQTsKV+wEBpcppUFI3VkBQSAGePfFNzcPbrtdgj6P/wJCN4w67WTTg2puKPtxj8/
 oFnP3tNJU8tVi9EBrni8/OouEactP45mx5iMXRfm9/uuuPZeB3MGSQFfTG9HMQRfuwUb
 cT+5P2Uc6I/EDW3grDdraez+Ntfkf+tyEs/eWePszd4ixh07CuGs++FYcvcFSlS4399y
 umLw13ddmYu4PT5/YjUGHEudQkphuDalJJzU0jTtZWC2tQ15Xls8WULwvlxu1qekvHXh
 XAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710766040; x=1711370840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vn6vfOb4VHfhuuF3mAsvF8lR2Ro+15TJo0Q+CM1vmtk=;
 b=X/sANeeiD3Nty/CezVHDgzoYzLDm48Os4kuxGspa8tmUcaoJaUoOZumbBxlGD99xlC
 dTiLyKkd0Nhdqd6KxsDRNKkA8MEZQ/X6JXNPlGfvKkvtASjV6yEdJqDpIIUjOCEqj9uX
 DlL5Um3SOCDIbN1Z1OzlDqG3mXaAglHQ+gxXPQIRieMTdaaMyzBWkCh0Y4fwDpz6zUBL
 5qEKM6pvXsHMuP558snSlZEXSZLuwlb/WdySMTHC5YgNw4iQZXzU3DFQbUL22h1awf1G
 PLlU4FiADrnO8Q+55KBG9q/D5urQeED63TBkO6D9ZVtwf24f3nBW1AqOFBfm7RiKXbek
 pv3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNvwtZ1o3EUEBB0Tnr1J4EZFXfvGyH5YNfVBi5mfEweHlLeGHZfDBcfFqotqUXTvzIBS2sNAcgu5fij6+y5rcqEZ1kgw==
X-Gm-Message-State: AOJu0YxRxZwFW1oMvj8/lMWBE7MjErSfEl4FxwpHKyvtXa5jA1RQbiTt
 OGUpEf1xwmQnXxjoDJYkKGUc5V1Qn/z2OUuqW5ucoMQYo4bHpoDreTLXEjXvrfQ=
X-Google-Smtp-Source: AGHT+IFrBZ82ixqNlNJz2ucJNJ77asrPTSRWmdDtOo7agnFvrZXKrgtvebWxYQf39GkoB9uMf57eEQ==
X-Received: by 2002:a5d:6b4b:0:b0:33e:b1e7:742a with SMTP id
 x11-20020a5d6b4b000000b0033eb1e7742amr7572949wrw.10.1710766040231; 
 Mon, 18 Mar 2024 05:47:20 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 s15-20020adfeccf000000b0033e9e26a2d0sm9747395wro.37.2024.03.18.05.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 05:47:19 -0700 (PDT)
Message-ID: <b20f5e01-d45c-402c-90e2-9593558bbeaa@linaro.org>
Date: Mon, 18 Mar 2024 12:47:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: udc: dwc3: Fold board
 dm_usb_gadget_handle_interrupts() into DWC3 gadget
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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



On 17/03/2024 04:42, Marek Vasut wrote:
> The dm_usb_gadget_handle_interrupts() has no place in board code. Move
> this into DWC3 driver. The OMAP implementation is special, add new weak
> dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
> handling should be called, and override it in OMAP DWC3 code, to repair
> the special OMAP interrupt handling code until OMAP gets switched over
> to DM UDC proper.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Igor Prusov <ivprusov@salutedevices.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: kernel@puri.sm
> ---
>  board/purism/librem5/spl.c        |  6 ------
>  board/samsung/common/exynos5-dt.c |  6 ------
>  board/st/stih410-b2260/board.c    |  6 ------
>  board/ti/am43xx/board.c           | 11 -----------
>  drivers/usb/dwc3/core.c           | 25 +++++++++++++++++++++----
>  drivers/usb/dwc3/dwc3-omap.c      |  4 ++--
>  include/dwc3-omap-uboot.h         |  1 -
>  include/dwc3-uboot.h              |  1 +
>  8 files changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/board/purism/librem5/spl.c b/board/purism/librem5/spl.c
> index 581f0929662..9aadc553302 100644
> --- a/board/purism/librem5/spl.c
> +++ b/board/purism/librem5/spl.c
> @@ -418,12 +418,6 @@ out:
>  	return rv;
>  }
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	dwc3_uboot_handle_interrupt(dev);
> -	return 0;
> -}
> -
>  static void dwc3_nxp_usb_phy_init(struct dwc3_device *dwc3)
>  {
>  	u32 RegData;
> diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exynos5-dt.c
> index 95cf6d2acc2..b3e87c93751 100644
> --- a/board/samsung/common/exynos5-dt.c
> +++ b/board/samsung/common/exynos5-dt.c
> @@ -122,12 +122,6 @@ static struct dwc3_device dwc3_device_data = {
>  	.index = 0,
>  };
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	dwc3_uboot_handle_interrupt(dev);
> -	return 0;
> -}
> -
>  int board_usb_init(int index, enum usb_init_type init)
>  {
>  	struct exynos_usb3_phy *phy = (struct exynos_usb3_phy *)
> diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
> index e21cbc270e9..82817571ae3 100644
> --- a/board/st/stih410-b2260/board.c
> +++ b/board/st/stih410-b2260/board.c
> @@ -50,12 +50,6 @@ static struct dwc3_device dwc3_device_data = {
>  	.index = 0,
>  };
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	dwc3_uboot_handle_interrupt(dev);
> -	return 0;
> -}
> -
>  int board_usb_init(int index, enum usb_init_type init)
>  {
>  	int node;
> diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
> index ea0d0b92088..a4679a2e294 100644
> --- a/board/ti/am43xx/board.c
> +++ b/board/ti/am43xx/board.c
> @@ -759,17 +759,6 @@ static struct ti_usb_phy_device usb_phy2_device = {
>  	.usb2_phy_power = (void *)USB2_PHY2_POWER,
>  	.index = 1,
>  };
> -
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	u32 status;
> -
> -	status = dwc3_omap_uboot_interrupt_status(dev);
> -	if (status)
> -		dwc3_uboot_handle_interrupt(dev);
> -
> -	return 0;
> -}
>  #endif /* CONFIG_USB_DWC3 */
>  
>  #if defined(CONFIG_USB_DWC3) || defined(CONFIG_USB_XHCI_OMAP)
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 4b4fcd8a22e..09737be9a9c 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -983,6 +983,11 @@ void dwc3_uboot_exit(int index)
>  	}
>  }
>  
> +MODULE_ALIAS("platform:dwc3");
> +MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
> +
>  /**
>   * dwc3_uboot_handle_interrupt - handle dwc3 core interrupt
>   * @dev: device of this controller
> @@ -1004,10 +1009,22 @@ void dwc3_uboot_handle_interrupt(struct udevice *dev)
>  	}
>  }
>  
> -MODULE_ALIAS("platform:dwc3");
> -MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
> +__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
> +{
> +	return 1;
> +}
> +
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	if (!dwc3_uboot_interrupt_status(dev))
> +		return 0;
> +
> +	dwc3_uboot_handle_interrupt(dev);
> +
> +	return 0;
> +}
> +#endif
>  
>  #if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
>  int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 4fadb4a3e20..53c4d4826b4 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -428,7 +428,7 @@ void dwc3_omap_uboot_exit(int index)
>  }
>  
>  /**
> - * dwc3_omap_uboot_interrupt_status - check the status of interrupt
> + * dwc3_uboot_interrupt_status - check the status of interrupt
>   * @dev: device of this controller
>   *
>   * Checks the status of interrupts and returns true if an interrupt
> @@ -436,7 +436,7 @@ void dwc3_omap_uboot_exit(int index)
>   *
>   * Generally called from board file.
>   */
> -int dwc3_omap_uboot_interrupt_status(struct udevice *dev)
> +int dwc3_uboot_interrupt_status(struct udevice *dev)
>  {
>  	struct dwc3_omap *omap = NULL;
>  
> diff --git a/include/dwc3-omap-uboot.h b/include/dwc3-omap-uboot.h
> index ed92bfc5a97..f220705ef7b 100644
> --- a/include/dwc3-omap-uboot.h
> +++ b/include/dwc3-omap-uboot.h
> @@ -27,5 +27,4 @@ struct dwc3_omap_device {
>  
>  int dwc3_omap_uboot_init(struct dwc3_omap_device *dev);
>  void dwc3_omap_uboot_exit(int index);
> -int dwc3_omap_uboot_interrupt_status(struct udevice *dev);
>  #endif /* __DWC3_OMAP_UBOOT_H_ */
> diff --git a/include/dwc3-uboot.h b/include/dwc3-uboot.h
> index 35cfbb93b29..5f13f5bcf40 100644
> --- a/include/dwc3-uboot.h
> +++ b/include/dwc3-uboot.h
> @@ -44,6 +44,7 @@ struct dwc3_device {
>  
>  int dwc3_uboot_init(struct dwc3_device *dev);
>  void dwc3_uboot_exit(int index);
> +int dwc3_uboot_interrupt_status(struct udevice *dev);
>  void dwc3_uboot_handle_interrupt(struct udevice *dev);
>  
>  struct phy;

-- 
// Caleb (they/them)
