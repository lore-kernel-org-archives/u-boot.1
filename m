Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E6C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 10:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BB587EE6;
	Thu, 21 Mar 2024 11:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FG58ZwR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 954A280245; Thu, 21 Mar 2024 11:01:45 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A1E87EE6
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33fd12a06fdso465304f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711015301; x=1711620101;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zGQMa277IbyRfWS3sVG6ZdKCDYfXJF32jVlhiMpedOU=;
 b=FG58ZwR9wg/zyTEzrmxPtayznsRVXeRS96KLNz+ROOjyMnpAzuIFBQq+zvsg9b4EcX
 4aUvm7xS2kDNEugQWy8fsubf8FqWg2wvJKQ7hqn5PU6mwx2RjlM+/jZmfBVUOOBQm5/1
 T12DgM1VB2NCMJwLRwrnoUJuLP+Qc7twIzexE72G10pF/VNyENMDDGwVmiKc72FREJFM
 ytSHb7xscK1vYFJlS50ISyud5IW9Ip4AOJy73k0FKICLi2d+rySdb15ic7z4E2uChHKp
 sSqdNdlBQrcLl6s7Um0Z2zIUH/d7vLHVaCw1sOKVoj3pmeisMUWrMaWdw/sH27+Rs3e9
 kmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015301; x=1711620101;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zGQMa277IbyRfWS3sVG6ZdKCDYfXJF32jVlhiMpedOU=;
 b=jP7iXUgSN6Cf8sp/8B/8xEa4RiOlxv3Vjor9HTvvbWrYJEIhEG+3vlI/waudwLoWhJ
 GyXy7KJkFaJNiegvAAZZdnmoFwH6XhMWRnZ3N4ZhAnXSCsS4D/VniijkwOVDGdJP0qv5
 Tq6T8u2l1Hd7Dfk1DKwfMoIFwbeTzlQokCVvXzvkPSozqP7BsQRh0fje0dZNLZNqRuTz
 X3GdGtY7CyfoQs0lSYesncxbAYnapjpZGBrkrTDYjmvBtaDBNEP+abN9SgJW3Gxlr8wq
 XxZrZMCB2R5VxTqZp+ejMY1YD5ymwefITL/4upv1V4thDG8qX8Ec3Vm+mOJp1rPydSm+
 kbbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYim9/byuWU+HWh82Z+R/V3kjURF8NXTz9WFglJ12ZTbKot8nBshaK0Yoe3qWBbidjlAMP1KAjTpcnuCiDOjsYjI7WXg==
X-Gm-Message-State: AOJu0Yy9wdB1Nb8NHKiFh2Nq7870mJdvM9jmsRlFkN4u6fOz7TqKhoJI
 e21Hlf9ElL+Bt+NfXGAGiE0QmPj6ToQEX2Gs0airj91kxLg/0ZTwXKPDM4LUjec=
X-Google-Smtp-Source: AGHT+IGOkgHBZEN1LT3bY2OVd4p0wRwdWZTEXm7y5mENHXMXzS3uHw5C6G4dfshuqTRV4db8tmlxjA==
X-Received: by 2002:adf:ea88:0:b0:341:7395:3097 with SMTP id
 s8-20020adfea88000000b0034173953097mr2925406wrm.1.1711015301349; 
 Thu, 21 Mar 2024 03:01:41 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 w16-20020adff9d0000000b0033ec7e71178sm16863995wrr.77.2024.03.21.03.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 03:01:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Angus Ainslie
 <angus@akkea.ca>, Caleb Connolly <caleb.connolly@linaro.org>, Eugen
 Hristev <eugen.hristev@collabora.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Stefan
 Bosch <stefan_b@posteo.net>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>, kernel@puri.sm
Subject: Re: [PATCH 1/2] usb: udc: dwc3: Fold board
 dm_usb_gadget_handle_interrupts() into DWC3 gadget
In-Reply-To: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
Date: Thu, 21 Mar 2024 11:01:39 +0100
Message-ID: <878r2boqd8.fsf@baylibre.com>
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

On dim., mars 17, 2024 at 05:42, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The dm_usb_gadget_handle_interrupts() has no place in board code. Move
> this into DWC3 driver. The OMAP implementation is special, add new weak
> dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
> handling should be called, and override it in OMAP DWC3 code, to repair
> the special OMAP interrupt handling code until OMAP gets switched over
> to DM UDC proper.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Tested that I could scan for usb mass storage and that I can use
fastboot:

=> fastboot usb 0
crq->brequest:0x0
=> usb start
starting USB...
Bus usb@ff500000: Register 3000140 NbrPorts 3
Starting the controller
USB XHCI 1.10
scanning bus usb@ff500000 for devices... 3 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found

=> usb storage
  Device 0: Vendor: SanDisk Rev: 1.00 Prod: Ultra
            Type: Removable Hard Disk
            Capacity: 29328.0 MB = 28.6 GB (60063744 x 512)

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3

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
> -- 
> 2.43.0
