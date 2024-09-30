Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD7ACF64B1
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC70C88E3A;
	Mon, 30 Sep 2024 15:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rtQgGUdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A64C88936; Mon, 30 Sep 2024 09:33:54 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0564A886A7
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 09:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fac63abf63so8754581fa.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727681627; x=1728286427;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F3myJfj1kvRxLniJaq8Y1VH2bVSWfqeWWrmczMGhU+U=;
 b=rtQgGUdX5K4ixHI5F0aIWlpNjS3FlkY0LzIQHc15mBHEvLQhlzCuMeZpI0uiGtiBUS
 0jwnxivmyBR0G0RDQKHM06u6ThDFNPcmMoo6JgN55/DvXhXL8lqtfAWm+1b7sVyTsLmq
 pJoJ0Y6EIY0M583IMH+4SZTRX73svJgx4/M8EgUy1o8KV/EZMcttLeh18MvJvL109kz2
 FGDLh3u3qTMJjiwZrBW9WAW63K74hsgWOAaRr4V7bgPzhDg2UTqygGtTG4/hUaBuz8Og
 /BTnc05TooUX0GMAaad0xJw4/RiwH66db9a1B7HVopXcYw/lNSU3Xk59o2DtcWWV3+94
 O5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727681627; x=1728286427;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F3myJfj1kvRxLniJaq8Y1VH2bVSWfqeWWrmczMGhU+U=;
 b=MZ1Dul6bRhAS0uv96NFRt0PiUBCKwOHPcQy0SnCRSZGabCgSzKGHcqJvDCLjDb13rB
 K6hggU0gqTINMZf3HjcH4A/APM3hX83MenW88sTpBxpm2o1kukWORBrJl3ur6Tt+dPVO
 wGloxGQJmsvd9CveVD+mwfhq0o5ciyn1s3PCRUZZPz+lQEcJYb3eXhNrEcj0XTaAfcE7
 kIhclRSgQHpkhvATmCFAJoqBNUMYlQOZ69lymNlYw056S7Yv9aks3+FexisiTjgj+Vkw
 fGI0UBjeHuE/zIMshduJisGYkEOqsjte8IwLwmF7DS9h4Ko9JnKRu4TBuzh2PwFwkLfz
 1RYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFEAfJaERmFbbsFtiIFTfaq7t5z4fV5hr06wIlT2drSLhK9WRiflhdAK7eq0Vm98K97KZeAwo=@lists.denx.de
X-Gm-Message-State: AOJu0YxGob1r/1ceB5JhuxOh8L6hLySayDQVXC2N2t9koKGqoO9Udy2T
 g+nkaUeam9zF3JP4vlG1bnttRS8nJ9C9zDb7Xe42L1mtjp1Y/U1HSTSCO+PkfH0=
X-Google-Smtp-Source: AGHT+IHP9KtiogV1Gfdm4uo3jIY9HZMn6b06PW3c6eVh1mKwv7z0Nmln6w4pMoSuQ33qmGKPbI97sQ==
X-Received: by 2002:a2e:750:0:b0:2f5:a29:5a42 with SMTP id
 38308e7fff4ca-2f9d3e5d375mr43328961fa.14.1727681626602; 
 Mon, 30 Sep 2024 00:33:46 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a3622bsm142523705e9.35.2024.09.30.00.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 00:33:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, Lukasz
 Majewski <lukma@denx.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] usb: gadget: usbhs: Add Renesas USBHS device driver
In-Reply-To: <20240908230654.286062-1-marek.vasut+renesas@mailbox.org>
References: <20240908230654.286062-1-marek.vasut+renesas@mailbox.org>
Date: Mon, 30 Sep 2024 09:33:44 +0200
Message-ID: <87plolmw87.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 30 Sep 2024 15:00:33 +0200
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

On lun., sept. 09, 2024 at 01:06, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> From: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
>
> Add UDC driver for Renesas USBHS controller found in R-Car Gen3 SoCs.
> This is mostly ported from the Linux kernel, with additional porting
> glue. The code has been synchronized with 1b4861e32e46 ("Linux 6.9.3")
> and cleaned up and ported to DM since the original implementation by
> Vitaliy.
>
> Signed-off-by: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I already did the comparison with the linux driver in v1:
https://lore.kernel.org/r/all/87jzhcpi9z.fsf@baylibre.com/

The diff between v1 and v2 looks good to me as well, so

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Note that the driver does have a few checkpatch warnings in it, those
> also partly come from Linux.
> ---
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
> ---
> V2: Drop CONFIG_USB_RENESAS_USBHS_UDC check
> ---
>  drivers/usb/gadget/Kconfig            |    9 +
>  drivers/usb/gadget/Makefile           |    1 +
>  drivers/usb/gadget/rcar/Makefile      |    8 +
>  drivers/usb/gadget/rcar/common.c      |  478 +++++++++++
>  drivers/usb/gadget/rcar/common.h      |  328 +++++++
>  drivers/usb/gadget/rcar/fifo.c        | 1067 +++++++++++++++++++++++
>  drivers/usb/gadget/rcar/fifo.h        |  114 +++
>  drivers/usb/gadget/rcar/mod.c         |  345 ++++++++
>  drivers/usb/gadget/rcar/mod.h         |  161 ++++
>  drivers/usb/gadget/rcar/mod_gadget.c  | 1136 +++++++++++++++++++++++++
>  drivers/usb/gadget/rcar/pipe.c        |  849 ++++++++++++++++++
>  drivers/usb/gadget/rcar/pipe.h        |  114 +++
>  drivers/usb/gadget/rcar/renesas_usb.h |  125 +++
>  13 files changed, 4735 insertions(+)
>  create mode 100644 drivers/usb/gadget/rcar/Makefile
>  create mode 100644 drivers/usb/gadget/rcar/common.c
>  create mode 100644 drivers/usb/gadget/rcar/common.h
>  create mode 100644 drivers/usb/gadget/rcar/fifo.c
>  create mode 100644 drivers/usb/gadget/rcar/fifo.h
>  create mode 100644 drivers/usb/gadget/rcar/mod.c
>  create mode 100644 drivers/usb/gadget/rcar/mod.h
>  create mode 100644 drivers/usb/gadget/rcar/mod_gadget.c
>  create mode 100644 drivers/usb/gadget/rcar/pipe.c
>  create mode 100644 drivers/usb/gadget/rcar/pipe.h
>  create mode 100644 drivers/usb/gadget/rcar/renesas_usb.h
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 4621a6fd5e6..5fb73890c78 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -114,6 +114,15 @@ config USB_GADGET_DWC2_OTG
>  	  driver to operate in Peripheral mode. This option requires
>  	  USB_GADGET to be enabled.
>  
> +config USB_RENESAS_USBHS
> +	bool "Renesas RCar USB2.0 HS controller (gadget mode)"
> +	select USB_GADGET_DUALSPEED
> +	help
> +	  The Renesas Rcar USB 2.0 high-speed gadget controller
> +	  integrated into Salvator and Kingfisher boards. Select this
> +	  option if you want the driver to operate in Peripheral mode.
> +	  This option requires USB_GADGET to be enabled.
> +
>  if USB_GADGET_DWC2_OTG
>  
>  config USB_GADGET_DWC2_OTG_PHY
> diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
> index 6abcce0d9c7..da76b6524de 100644
> --- a/drivers/usb/gadget/Makefile
> +++ b/drivers/usb/gadget/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_USB_GADGET_BCM_UDC_OTG_PHY) += bcm_udc_otg_phy.o
>  obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_udc_otg.o
>  obj-$(CONFIG_USB_GADGET_DWC2_OTG_PHY) += dwc2_udc_otg_phy.o
>  obj-$(CONFIG_USB_GADGET_MAX3420) += max3420_udc.o
> +obj-$(CONFIG_USB_RENESAS_USBHS) += rcar/
>  ifndef CONFIG_SPL_BUILD
>  obj-$(CONFIG_USB_GADGET_DOWNLOAD) += g_dnl.o
>  obj-$(CONFIG_USB_FUNCTION_THOR) += f_thor.o
> diff --git a/drivers/usb/gadget/rcar/Makefile b/drivers/usb/gadget/rcar/Makefile
> new file mode 100644
> index 00000000000..676f39c8e24
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_USB_RENESAS_USBHS) += \
> +	common.o \
> +	fifo.o \
> +	mod.o \
> +	mod_gadget.o \
> +	pipe.o
> diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
> new file mode 100644
> index 00000000000..2ba022a3f2c
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/common.c
> @@ -0,0 +1,478 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Copyright (C) 2019 Renesas Electronics Corporation
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <generic-phy.h>
> +#include <linux/err.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <usb.h>
> +
> +#include "common.h"
> +
> +/*
> + *		image of renesas_usbhs
> + *
> + * ex) gadget case
> +
> + * mod.c
> + * mod_gadget.c
> + * mod_host.c		pipe.c		fifo.c
> + *
> + *			+-------+	+-----------+
> + *			| pipe0 |------>| fifo pio  |
> + * +------------+	+-------+	+-----------+
> + * | mod_gadget |=====> | pipe1 |--+
> + * +------------+	+-------+  |	+-----------+
> + *			| pipe2 |  |  +-| fifo dma0 |
> + * +------------+	+-------+  |  |	+-----------+
> + * | mod_host   |	| pipe3 |<-|--+
> + * +------------+	+-------+  |	+-----------+
> + *			| ....  |  +--->| fifo dma1 |
> + *			| ....  |	+-----------+
> + */
> +
> +/*
> + *		common functions
> + */
> +u16 usbhs_read(struct usbhs_priv *priv, u32 reg)
> +{
> +	return ioread16(priv->base + reg);
> +}
> +
> +void usbhs_write(struct usbhs_priv *priv, u32 reg, u16 data)
> +{
> +	iowrite16(data, priv->base + reg);
> +}
> +
> +void usbhs_bset(struct usbhs_priv *priv, u32 reg, u16 mask, u16 data)
> +{
> +	u16 val = usbhs_read(priv, reg);
> +
> +	val &= ~mask;
> +	val |= data & mask;
> +
> +	usbhs_write(priv, reg, val);
> +}
> +
> +/*
> + *		syscfg functions
> + */
> +static void usbhs_sys_clock_ctrl(struct usbhs_priv *priv, int enable)
> +{
> +	usbhs_bset(priv, SYSCFG, SCKE, enable ? SCKE : 0);
> +}
> +
> +void usbhs_sys_host_ctrl(struct usbhs_priv *priv, int enable)
> +{
> +	u16 mask = DCFM | DRPD | DPRPU | HSE | USBE;
> +	u16 val  = DCFM | DRPD | HSE | USBE;
> +
> +	/*
> +	 * if enable
> +	 *
> +	 * - select Host mode
> +	 * - D+ Line/D- Line Pull-down
> +	 */
> +	usbhs_bset(priv, SYSCFG, mask, enable ? val : 0);
> +}
> +
> +void usbhs_sys_function_ctrl(struct usbhs_priv *priv, int enable)
> +{
> +	u16 mask = DCFM | DRPD | DPRPU | HSE | USBE;
> +	u16 val  = HSE | USBE;
> +
> +	/*
> +	 * if enable
> +	 *
> +	 * - select Function mode
> +	 * - D+ Line Pull-up is disabled
> +	 *      When D+ Line Pull-up is enabled,
> +	 *      calling usbhs_sys_function_pullup(,1)
> +	 */
> +	usbhs_bset(priv, SYSCFG, mask, enable ? val : 0);
> +}
> +
> +void usbhs_sys_function_pullup(struct usbhs_priv *priv, int enable)
> +{
> +	usbhs_bset(priv, SYSCFG, DPRPU, enable ? DPRPU : 0);
> +}
> +
> +void usbhs_sys_set_test_mode(struct usbhs_priv *priv, u16 mode)
> +{
> +	usbhs_write(priv, TESTMODE, mode);
> +}
> +
> +/*
> + *		frame functions
> + */
> +int usbhs_frame_get_num(struct usbhs_priv *priv)
> +{
> +	return usbhs_read(priv, FRMNUM) & FRNM_MASK;
> +}
> +
> +/*
> + *		usb request functions
> + */
> +void usbhs_usbreq_get_val(struct usbhs_priv *priv, struct usb_ctrlrequest *req)
> +{
> +	u16 val;
> +
> +	val = usbhs_read(priv, USBREQ);
> +	req->bRequest		= (val >> 8) & 0xFF;
> +	req->bRequestType	= (val >> 0) & 0xFF;
> +
> +	req->wValue	= cpu_to_le16(usbhs_read(priv, USBVAL));
> +	req->wIndex	= cpu_to_le16(usbhs_read(priv, USBINDX));
> +	req->wLength	= cpu_to_le16(usbhs_read(priv, USBLENG));
> +}
> +
> +void usbhs_usbreq_set_val(struct usbhs_priv *priv, struct usb_ctrlrequest *req)
> +{
> +	usbhs_write(priv, USBREQ,  (req->bRequest << 8) | req->bRequestType);
> +	usbhs_write(priv, USBVAL,  le16_to_cpu(req->wValue));
> +	usbhs_write(priv, USBINDX, le16_to_cpu(req->wIndex));
> +	usbhs_write(priv, USBLENG, le16_to_cpu(req->wLength));
> +
> +	usbhs_bset(priv, DCPCTR, SUREQ, SUREQ);
> +}
> +
> +/*
> + *		bus/vbus functions
> + */
> +void usbhs_bus_send_sof_enable(struct usbhs_priv *priv)
> +{
> +	u16 status = usbhs_read(priv, DVSTCTR) & (USBRST | UACT);
> +
> +	if (status != USBRST) {
> +		struct device *dev = usbhs_priv_to_dev(priv);
> +		dev_err(dev, "usbhs should be reset\n");
> +	}
> +
> +	usbhs_bset(priv, DVSTCTR, (USBRST | UACT), UACT);
> +}
> +
> +void usbhs_bus_send_reset(struct usbhs_priv *priv)
> +{
> +	usbhs_bset(priv, DVSTCTR, (USBRST | UACT), USBRST);
> +}
> +
> +int usbhs_bus_get_speed(struct usbhs_priv *priv)
> +{
> +	u16 dvstctr = usbhs_read(priv, DVSTCTR);
> +
> +	switch (RHST & dvstctr) {
> +	case RHST_LOW_SPEED:
> +		return USB_SPEED_LOW;
> +	case RHST_FULL_SPEED:
> +		return USB_SPEED_FULL;
> +	case RHST_HIGH_SPEED:
> +		return USB_SPEED_HIGH;
> +	}
> +
> +	return USB_SPEED_UNKNOWN;
> +}
> +
> +static void usbhsc_bus_init(struct usbhs_priv *priv)
> +{
> +	usbhs_write(priv, DVSTCTR, 0);
> +}
> +
> +/*
> + *		device configuration
> + */
> +int usbhs_set_device_config(struct usbhs_priv *priv, int devnum,
> +			   u16 upphub, u16 hubport, u16 speed)
> +{
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	u16 usbspd = 0;
> +	u32 reg = DEVADD0 + (2 * devnum);
> +
> +	if (devnum > 10) {
> +		dev_err(dev, "cannot set speed to unknown device %d\n", devnum);
> +		return -EIO;
> +	}
> +
> +	if (upphub > 0xA) {
> +		dev_err(dev, "unsupported hub number %d\n", upphub);
> +		return -EIO;
> +	}
> +
> +	switch (speed) {
> +	case USB_SPEED_LOW:
> +		usbspd = USBSPD_SPEED_LOW;
> +		break;
> +	case USB_SPEED_FULL:
> +		usbspd = USBSPD_SPEED_FULL;
> +		break;
> +	case USB_SPEED_HIGH:
> +		usbspd = USBSPD_SPEED_HIGH;
> +		break;
> +	default:
> +		dev_err(dev, "unsupported speed %d\n", speed);
> +		return -EIO;
> +	}
> +
> +	usbhs_write(priv, reg,	UPPHUB(upphub)	|
> +				HUBPORT(hubport)|
> +				USBSPD(usbspd));
> +
> +	return 0;
> +}
> +
> +/*
> + *		interrupt functions
> + */
> +void usbhs_xxxsts_clear(struct usbhs_priv *priv, u16 sts_reg, u16 bit)
> +{
> +	u16 pipe_mask = (u16)GENMASK(usbhs_get_dparam(priv, pipe_size), 0);
> +
> +	usbhs_write(priv, sts_reg, ~(1 << bit) & pipe_mask);
> +}
> +
> +/*
> + *		local functions
> + */
> +static void usbhsc_set_buswait(struct usbhs_priv *priv)
> +{
> +	int wait = usbhs_get_dparam(priv, buswait_bwait);
> +
> +	/* set bus wait if platform have */
> +	if (wait)
> +		usbhs_bset(priv, BUSWAIT, 0x000F, wait);
> +}
> +
> +/*
> + *		platform default param
> + */
> +
> +/* commonly used on newer SH-Mobile and R-Car SoCs */
> +static struct renesas_usbhs_driver_pipe_config usbhsc_new_pipe[] = {
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_CONTROL, 64, 0x00, false),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_ISOC, 1024, 0x08, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_ISOC, 1024, 0x28, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x48, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x58, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x68, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_INT, 64, 0x04, false),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_INT, 64, 0x05, false),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_INT, 64, 0x06, false),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x78, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x88, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x98, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0xa8, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0xb8, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0xc8, true),
> +	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0xd8, true),
> +};
> +
> +#define LPSTS			0x102
> +#define LPSTS_SUSPM		BIT(14)
> +
> +#define UGCTRL2			0x184
> +#define UGCTRL2_RESERVED_3	BIT(0)
> +#define UGCTRL2_USB0SEL_EHCI	0x10
> +#define UGCTRL2_USB0SEL_HSUSB	0x20
> +#define UGCTRL2_USB0SEL_OTG	0x30
> +#define UGCTRL2_USB0SEL_MASK	0x30
> +#define UGCTRL2_VBUSSEL		BIT(10)
> +
> +struct usbhs_priv_otg_data {
> +	void __iomem		*base;
> +	void __iomem		*phybase;
> +
> +	struct platform_device	usbhs_dev;
> +	struct usbhs_priv	usbhs_priv;
> +
> +	struct phy		phy;
> +};
> +
> +static int usbhs_rcar3_power_ctrl(struct usbhs_priv *priv, bool enable)
> +{
> +	if (enable) {
> +		writel(UGCTRL2_USB0SEL_OTG | UGCTRL2_VBUSSEL | UGCTRL2_RESERVED_3,
> +		       priv->base + UGCTRL2);
> +
> +		usbhs_bset(priv, LPSTS, LPSTS_SUSPM, LPSTS_SUSPM);
> +		/* The controller on R-Car Gen3 needs to wait up to 90 usec */
> +		udelay(90);
> +
> +		usbhs_sys_clock_ctrl(priv, enable);
> +	} else {
> +		usbhs_sys_clock_ctrl(priv, enable);
> +
> +		usbhs_bset(priv, LPSTS, LPSTS_SUSPM, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +void usbhsc_hotplug(struct usbhs_priv *priv)
> +{
> +	int ret;
> +
> +	ret = usbhs_mod_change(priv, USBHS_GADGET);
> +	if (ret < 0)
> +		return;
> +
> +	usbhs_rcar3_power_ctrl(priv, true);
> +
> +	/* bus init */
> +	usbhsc_set_buswait(priv);
> +	usbhsc_bus_init(priv);
> +
> +	/* module start */
> +	usbhs_mod_call(priv, start, priv);
> +}
> +
> +#define USB2_OBINTSTA		0x604
> +#define USB2_OBINT_SESSVLDCHG		BIT(12)
> +#define USB2_OBINT_IDDIGCHG		BIT(11)
> +
> +static int usbhs_udc_otg_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
> +	const u32 status = readl(priv->phybase + USB2_OBINTSTA);
> +
> +	/* We don't have a good way to forward IRQ to PHY yet */
> +	if (status & (USB2_OBINT_SESSVLDCHG | USB2_OBINT_IDDIGCHG)) {
> +		writel(USB2_OBINT_SESSVLDCHG | USB2_OBINT_IDDIGCHG,
> +		       priv->phybase + USB2_OBINTSTA);
> +		generic_phy_set_mode(&priv->phy, PHY_MODE_USB_OTG, 0);
> +	}
> +
> +	usbhs_interrupt(0, &priv->usbhs_priv);
> +
> +	return 0;
> +}
> +
> +static int usbhs_probe(struct usbhs_priv *priv)
> +{
> +	int ret;
> +
> +	priv->dparam.type = USBHS_TYPE_RCAR_GEN3;
> +	priv->dparam.pio_dma_border = 64;
> +	priv->dparam.pipe_configs = usbhsc_new_pipe;
> +	priv->dparam.pipe_size = ARRAY_SIZE(usbhsc_new_pipe);
> +
> +	/* call pipe and module init */
> +	ret = usbhs_pipe_probe(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = usbhs_fifo_probe(priv);
> +	if (ret < 0)
> +		goto probe_end_pipe_exit;
> +
> +	ret = usbhs_mod_probe(priv);
> +	if (ret < 0)
> +		goto probe_end_fifo_exit;
> +
> +	usbhs_sys_clock_ctrl(priv, 0);
> +
> +	usbhs_rcar3_power_ctrl(priv, true);
> +	usbhs_mod_autonomy_mode(priv);
> +	usbhsc_hotplug(priv);
> +
> +	return ret;
> +
> +probe_end_fifo_exit:
> +	usbhs_fifo_remove(priv);
> +probe_end_pipe_exit:
> +	usbhs_pipe_remove(priv);
> +	return ret;
> +}
> +
> +static int usbhs_udc_otg_probe(struct udevice *dev)
> +{
> +	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
> +	struct usb_gadget *gadget;
> +	struct clk_bulk clk_bulk;
> +	int ret = -EINVAL;
> +
> +	priv->base = dev_read_addr_ptr(dev);
> +	if (!priv->base)
> +		return -EINVAL;
> +
> +	ret = clk_get_bulk(dev, &clk_bulk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable_bulk(&clk_bulk);
> +	if (ret)
> +		return ret;
> +
> +	clrsetbits_le32(priv->base + UGCTRL2, UGCTRL2_USB0SEL_MASK, UGCTRL2_USB0SEL_EHCI);
> +	clrsetbits_le16(priv->base + LPSTS, LPSTS_SUSPM, LPSTS_SUSPM);
> +
> +	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_OTG, 1);
> +	if (ret)
> +		goto err_clk;
> +
> +	priv->phybase = dev_read_addr_ptr(priv->phy.dev);
> +
> +	priv->usbhs_priv.pdev = &priv->usbhs_dev;
> +	priv->usbhs_priv.base = priv->base;
> +	priv->usbhs_dev.dev.driver_data = &priv->usbhs_priv;
> +	ret = usbhs_probe(&priv->usbhs_priv);
> +	if (ret < 0)
> +		goto err_phy;
> +
> +	gadget = usbhsg_get_gadget(&priv->usbhs_priv);
> +	gadget->is_dualspeed = 1;
> +	gadget->is_otg = 0;
> +	gadget->is_a_peripheral = 0;
> +	gadget->b_hnp_enable = 0;
> +	gadget->a_hnp_support = 0;
> +	gadget->a_alt_hnp_support = 0;
> +
> +	return usb_add_gadget_udc((struct device *)dev, gadget);
> +
> +err_phy:
> +	generic_shutdown_phy(&priv->phy);
> +err_clk:
> +	clk_disable_bulk(&clk_bulk);
> +	return ret;
> +}
> +
> +static int usbhs_udc_otg_remove(struct udevice *dev)
> +{
> +	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
> +
> +	usbhs_rcar3_power_ctrl(&priv->usbhs_priv, false);
> +	usbhs_mod_remove(&priv->usbhs_priv);
> +	usbhs_fifo_remove(&priv->usbhs_priv);
> +	usbhs_pipe_remove(&priv->usbhs_priv);
> +
> +	generic_shutdown_phy(&priv->phy);
> +
> +	return dm_scan_fdt_dev(dev);
> +}
> +
> +static const struct udevice_id usbhs_udc_otg_ids[] = {
> +	{ .compatible = "renesas,rcar-gen3-usbhs" },
> +	{},
> +};
> +
> +static const struct usb_gadget_generic_ops usbhs_udc_otg_ops = {
> +	.handle_interrupts = usbhs_udc_otg_gadget_handle_interrupts,
> +};
> +
> +U_BOOT_DRIVER(usbhs_udc_otg) = {
> +	.name		= "usbhs-udc-otg",
> +	.id		= UCLASS_USB_GADGET_GENERIC,
> +	.ops		= &usbhs_udc_otg_ops,
> +	.of_match	= usbhs_udc_otg_ids,
> +	.probe		= usbhs_udc_otg_probe,
> +	.remove		= usbhs_udc_otg_remove,
> +	.priv_auto	= sizeof(struct usbhs_priv_otg_data),
> +};
> diff --git a/drivers/usb/gadget/rcar/common.h b/drivers/usb/gadget/rcar/common.h
> new file mode 100644
> index 00000000000..544cfd77cdf
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/common.h
> @@ -0,0 +1,328 @@
> +/* SPDX-License-Identifier: GPL-1.0+ */
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Copyright (C) 2019 Renesas Electronics Corporation
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#ifndef RENESAS_USB_DRIVER_H
> +#define RENESAS_USB_DRIVER_H
> +
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <linux/bug.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include "renesas_usb.h"
> +
> +struct usbhs_priv;
> +
> +#include "mod.h"
> +#include "pipe.h"
> +
> +/*
> + *
> + *		register define
> + *
> + */
> +#define SYSCFG		0x0000
> +#define BUSWAIT		0x0002
> +#define DVSTCTR		0x0008
> +#define TESTMODE	0x000C
> +#define CFIFO		0x0014
> +#define CFIFOSEL	0x0020
> +#define CFIFOCTR	0x0022
> +#define D0FIFO		0x0100
> +#define D0FIFOSEL	0x0028
> +#define D0FIFOCTR	0x002A
> +#define D1FIFO		0x0120
> +#define D1FIFOSEL	0x002C
> +#define D1FIFOCTR	0x002E
> +#define INTENB0		0x0030
> +#define INTENB1		0x0032
> +#define BRDYENB		0x0036
> +#define NRDYENB		0x0038
> +#define BEMPENB		0x003A
> +#define INTSTS0		0x0040
> +#define INTSTS1		0x0042
> +#define BRDYSTS		0x0046
> +#define NRDYSTS		0x0048
> +#define BEMPSTS		0x004A
> +#define FRMNUM		0x004C
> +#define USBREQ		0x0054	/* USB request type register */
> +#define USBVAL		0x0056	/* USB request value register */
> +#define USBINDX		0x0058	/* USB request index register */
> +#define USBLENG		0x005A	/* USB request length register */
> +#define DCPCFG		0x005C
> +#define DCPMAXP		0x005E
> +#define DCPCTR		0x0060
> +#define PIPESEL		0x0064
> +#define PIPECFG		0x0068
> +#define PIPEBUF		0x006A
> +#define PIPEMAXP	0x006C
> +#define PIPEPERI	0x006E
> +#define PIPEnCTR	0x0070
> +#define PIPE1TRE	0x0090
> +#define PIPE1TRN	0x0092
> +#define PIPE2TRE	0x0094
> +#define PIPE2TRN	0x0096
> +#define PIPE3TRE	0x0098
> +#define PIPE3TRN	0x009A
> +#define PIPE4TRE	0x009C
> +#define PIPE4TRN	0x009E
> +#define PIPE5TRE	0x00A0
> +#define PIPE5TRN	0x00A2
> +#define PIPEBTRE	0x00A4
> +#define PIPEBTRN	0x00A6
> +#define PIPECTRE	0x00A8
> +#define PIPECTRN	0x00AA
> +#define PIPEDTRE	0x00AC
> +#define PIPEDTRN	0x00AE
> +#define PIPEETRE	0x00B0
> +#define PIPEETRN	0x00B2
> +#define PIPEFTRE	0x00B4
> +#define PIPEFTRN	0x00B6
> +#define PIPE9TRE	0x00B8
> +#define PIPE9TRN	0x00BA
> +#define PIPEATRE	0x00BC
> +#define PIPEATRN	0x00BE
> +#define DEVADD0		0x00D0 /* Device address n configuration */
> +#define DEVADD1		0x00D2
> +#define DEVADD2		0x00D4
> +#define DEVADD3		0x00D6
> +#define DEVADD4		0x00D8
> +#define DEVADD5		0x00DA
> +#define DEVADD6		0x00DC
> +#define DEVADD7		0x00DE
> +#define DEVADD8		0x00E0
> +#define DEVADD9		0x00E2
> +#define DEVADDA		0x00E4
> +#define D2FIFOSEL	0x00F0	/* for R-Car Gen2 */
> +#define D2FIFOCTR	0x00F2	/* for R-Car Gen2 */
> +#define D3FIFOSEL	0x00F4	/* for R-Car Gen2 */
> +#define D3FIFOCTR	0x00F6	/* for R-Car Gen2 */
> +#define SUSPMODE	0x0102	/* for RZ/A */
> +
> +/* SYSCFG */
> +#define SCKE	(1 << 10)	/* USB Module Clock Enable */
> +#define CNEN	(1 << 8)	/* Single-ended receiver operation Enable */
> +#define HSE	(1 << 7)	/* High-Speed Operation Enable */
> +#define DCFM	(1 << 6)	/* Controller Function Select */
> +#define DRPD	(1 << 5)	/* D+ Line/D- Line Resistance Control */
> +#define DPRPU	(1 << 4)	/* D+ Line Resistance Control */
> +#define USBE	(1 << 0)	/* USB Module Operation Enable */
> +#define UCKSEL	(1 << 2)	/* Clock Select for RZ/A1 */
> +#define UPLLE	(1 << 1)	/* USB PLL Enable for RZ/A1 */
> +
> +/* DVSTCTR */
> +#define EXTLP	(1 << 10)	/* Controls the EXTLP pin output state */
> +#define PWEN	(1 << 9)	/* Controls the PWEN pin output state */
> +#define USBRST	(1 << 6)	/* Bus Reset Output */
> +#define UACT	(1 << 4)	/* USB Bus Enable */
> +#define RHST	(0x7)		/* Reset Handshake */
> +#define  RHST_LOW_SPEED  1	/* Low-speed connection */
> +#define  RHST_FULL_SPEED 2	/* Full-speed connection */
> +#define  RHST_HIGH_SPEED 3	/* High-speed connection */
> +
> +/* CFIFOSEL */
> +#define DREQE	(1 << 12)	/* DMA Transfer Request Enable */
> +#define MBW_32	(0x2 << 10)	/* CFIFO Port Access Bit Width */
> +
> +/* CFIFOCTR */
> +#define BVAL	(1 << 15)	/* Buffer Memory Enable Flag */
> +#define BCLR	(1 << 14)	/* CPU buffer clear */
> +#define FRDY	(1 << 13)	/* FIFO Port Ready */
> +#define DTLN_MASK (0x0FFF)	/* Receive Data Length */
> +
> +/* INTENB0 */
> +#define VBSE	(1 << 15)	/* Enable IRQ VBUS_0 and VBUSIN_0 */
> +#define RSME	(1 << 14)	/* Enable IRQ Resume */
> +#define SOFE	(1 << 13)	/* Enable IRQ Frame Number Update */
> +#define DVSE	(1 << 12)	/* Enable IRQ Device State Transition */
> +#define CTRE	(1 << 11)	/* Enable IRQ Control Stage Transition */
> +#define BEMPE	(1 << 10)	/* Enable IRQ Buffer Empty */
> +#define NRDYE	(1 << 9)	/* Enable IRQ Buffer Not Ready Response */
> +#define BRDYE	(1 << 8)	/* Enable IRQ Buffer Ready */
> +
> +/* INTENB1 */
> +#define BCHGE	(1 << 14)	/* USB Bus Change Interrupt Enable */
> +#define DTCHE	(1 << 12)	/* Disconnection Detect Interrupt Enable */
> +#define ATTCHE	(1 << 11)	/* Connection Detect Interrupt Enable */
> +#define EOFERRE	(1 << 6)	/* EOF Error Detect Interrupt Enable */
> +#define SIGNE	(1 << 5)	/* Setup Transaction Error Interrupt Enable */
> +#define SACKE	(1 << 4)	/* Setup Transaction ACK Interrupt Enable */
> +
> +/* INTSTS0 */
> +#define VBINT	(1 << 15)	/* VBUS0_0 and VBUS1_0 Interrupt Status */
> +#define DVST	(1 << 12)	/* Device State Transition Interrupt Status */
> +#define CTRT	(1 << 11)	/* Control Stage Interrupt Status */
> +#define BEMP	(1 << 10)	/* Buffer Empty Interrupt Status */
> +#define BRDY	(1 << 8)	/* Buffer Ready Interrupt Status */
> +#define VBSTS	(1 << 7)	/* VBUS_0 and VBUSIN_0 Input Status */
> +#define VALID	(1 << 3)	/* USB Request Receive */
> +
> +#define DVSQ_MASK		(0x7 << 4)	/* Device State */
> +#define  POWER_STATE		(0 << 4)
> +#define  DEFAULT_STATE		(1 << 4)
> +#define  ADDRESS_STATE		(2 << 4)
> +#define  CONFIGURATION_STATE	(3 << 4)
> +#define  SUSPENDED_STATE	(4 << 4)
> +
> +#define CTSQ_MASK		(0x7)	/* Control Transfer Stage */
> +#define  IDLE_SETUP_STAGE	0	/* Idle stage or setup stage */
> +#define  READ_DATA_STAGE	1	/* Control read data stage */
> +#define  READ_STATUS_STAGE	2	/* Control read status stage */
> +#define  WRITE_DATA_STAGE	3	/* Control write data stage */
> +#define  WRITE_STATUS_STAGE	4	/* Control write status stage */
> +#define  NODATA_STATUS_STAGE	5	/* Control write NoData status stage */
> +#define  SEQUENCE_ERROR		6	/* Control transfer sequence error */
> +
> +/* INTSTS1 */
> +#define OVRCR	(1 << 15) /* OVRCR Interrupt Status */
> +#define BCHG	(1 << 14) /* USB Bus Change Interrupt Status */
> +#define DTCH	(1 << 12) /* USB Disconnection Detect Interrupt Status */
> +#define ATTCH	(1 << 11) /* ATTCH Interrupt Status */
> +#define EOFERR	(1 << 6)  /* EOF Error Detect Interrupt Status */
> +#define SIGN	(1 << 5)  /* Setup Transaction Error Interrupt Status */
> +#define SACK	(1 << 4)  /* Setup Transaction ACK Response Interrupt Status */
> +
> +/* PIPECFG */
> +/* DCPCFG */
> +#define TYPE_NONE	(0 << 14)	/* Transfer Type */
> +#define TYPE_BULK	(1 << 14)
> +#define TYPE_INT	(2 << 14)
> +#define TYPE_ISO	(3 << 14)
> +#define BFRE		(1 << 10)	/* BRDY Interrupt Operation Spec. */
> +#define DBLB		(1 << 9)	/* Double Buffer Mode */
> +#define SHTNAK		(1 << 7)	/* Pipe Disable in Transfer End */
> +#define DIR_OUT		(1 << 4)	/* Transfer Direction */
> +
> +/* PIPEMAXP */
> +/* DCPMAXP */
> +#define DEVSEL_MASK	(0xF << 12)	/* Device Select */
> +#define DCP_MAXP_MASK	(0x7F)
> +#define PIPE_MAXP_MASK	(0x7FF)
> +
> +/* PIPEBUF */
> +#define BUFSIZE_SHIFT	10
> +#define BUFSIZE_MASK	(0x1F << BUFSIZE_SHIFT)
> +#define BUFNMB_MASK	(0xFF)
> +
> +/* PIPEnCTR */
> +/* DCPCTR */
> +#define BSTS		(1 << 15)	/* Buffer Status */
> +#define SUREQ		(1 << 14)	/* Sending SETUP Token */
> +#define INBUFM		(1 << 14)	/* (PIPEnCTR) Transfer Buffer Monitor */
> +#define CSSTS		(1 << 12)	/* CSSTS Status */
> +#define	ACLRM		(1 << 9)	/* Buffer Auto-Clear Mode */
> +#define SQCLR		(1 << 8)	/* Toggle Bit Clear */
> +#define SQSET		(1 << 7)	/* Toggle Bit Set */
> +#define SQMON		(1 << 6)	/* Toggle Bit Check */
> +#define PBUSY		(1 << 5)	/* Pipe Busy */
> +#define PID_MASK	(0x3)		/* Response PID */
> +#define  PID_NAK	0
> +#define  PID_BUF	1
> +#define  PID_STALL10	2
> +#define  PID_STALL11	3
> +
> +#define CCPL		(1 << 2)	/* Control Transfer End Enable */
> +
> +/* PIPEnTRE */
> +#define TRENB		(1 << 9)	/* Transaction Counter Enable */
> +#define TRCLR		(1 << 8)	/* Transaction Counter Clear */
> +
> +/* FRMNUM */
> +#define FRNM_MASK	(0x7FF)
> +
> +/* DEVADDn */
> +#define UPPHUB(x)	(((x) & 0xF) << 11)	/* HUB Register */
> +#define HUBPORT(x)	(((x) & 0x7) << 8)	/* HUB Port for Target Device */
> +#define USBSPD(x)	(((x) & 0x3) << 6)	/* Device Transfer Rate */
> +#define USBSPD_SPEED_LOW	0x1
> +#define USBSPD_SPEED_FULL	0x2
> +#define USBSPD_SPEED_HIGH	0x3
> +
> +/* SUSPMODE */
> +#define SUSPM		(1 << 14)	/* SuspendM Control */
> +
> +/*
> + *		struct
> + */
> +struct usbhs_priv {
> +	void __iomem *base;
> +	struct renesas_usbhs_driver_param	dparam;
> +	struct platform_device			*pdev;
> +
> +	/*
> +	 * module control
> +	 */
> +	struct usbhs_mod_info mod_info;
> +
> +	/*
> +	 * pipe control
> +	 */
> +	struct usbhs_pipe_info pipe_info;
> +
> +	/*
> +	 * fifo control
> +	 */
> +	struct usbhs_fifo_info fifo_info;
> +};
> +
> +/*
> + * common
> + */
> +u16 usbhs_read(struct usbhs_priv *priv, u32 reg);
> +void usbhs_write(struct usbhs_priv *priv, u32 reg, u16 data);
> +void usbhs_bset(struct usbhs_priv *priv, u32 reg, u16 mask, u16 data);
> +
> +#define usbhs_lock(p, f) spin_lock_irqsave(usbhs_priv_to_lock(p), f)
> +#define usbhs_unlock(p, f) spin_unlock_irqrestore(usbhs_priv_to_lock(p), f)
> +
> +/*
> + * sysconfig
> + */
> +void usbhs_sys_host_ctrl(struct usbhs_priv *priv, int enable);
> +void usbhs_sys_function_ctrl(struct usbhs_priv *priv, int enable);
> +void usbhs_sys_function_pullup(struct usbhs_priv *priv, int enable);
> +void usbhs_sys_set_test_mode(struct usbhs_priv *priv, u16 mode);
> +
> +/*
> + * usb request
> + */
> +void usbhs_usbreq_get_val(struct usbhs_priv *priv, struct usb_ctrlrequest *req);
> +void usbhs_usbreq_set_val(struct usbhs_priv *priv, struct usb_ctrlrequest *req);
> +
> +/*
> + * bus
> + */
> +void usbhs_bus_send_sof_enable(struct usbhs_priv *priv);
> +void usbhs_bus_send_reset(struct usbhs_priv *priv);
> +int usbhs_bus_get_speed(struct usbhs_priv *priv);
> +int usbhs_vbus_ctrl(struct usbhs_priv *priv, int enable);
> +void usbhsc_hotplug(struct usbhs_priv *priv);
> +
> +/*
> + * frame
> + */
> +int usbhs_frame_get_num(struct usbhs_priv *priv);
> +
> +/*
> + * device config
> + */
> +int usbhs_set_device_config(struct usbhs_priv *priv, int devnum, u16 upphub,
> +			   u16 hubport, u16 speed);
> +
> +/*
> + * interrupt functions
> + */
> +void usbhs_xxxsts_clear(struct usbhs_priv *priv, u16 sts_reg, u16 bit);
> +
> +/*
> + * data
> + */
> +#define usbhs_get_dparam(priv, param)	(priv->dparam.param)
> +#define usbhs_priv_to_dev(priv)		(&priv->pdev->dev)
> +
> +#endif /* RENESAS_USB_DRIVER_H */
> diff --git a/drivers/usb/gadget/rcar/fifo.c b/drivers/usb/gadget/rcar/fifo.c
> new file mode 100644
> index 00000000000..6016b2987d5
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/fifo.c
> @@ -0,0 +1,1067 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Copyright (C) 2019 Renesas Electronics Corporation
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include "common.h"
> +#include "pipe.h"
> +
> +#define usbhsf_get_cfifo(p)	(&((p)->fifo_info.cfifo))
> +
> +#define usbhsf_fifo_is_busy(f)	((f)->pipe) /* see usbhs_pipe_select_fifo */
> +
> +/*
> + *		packet initialize
> + */
> +void usbhs_pkt_init(struct usbhs_pkt *pkt)
> +{
> +	INIT_LIST_HEAD(&pkt->node);
> +}
> +
> +/*
> + *		packet control function
> + */
> +static int usbhsf_null_handle(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pkt->pipe);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +
> +	dev_err(dev, "null handler\n");
> +
> +	return -EINVAL;
> +}
> +
> +static const struct usbhs_pkt_handle usbhsf_null_handler = {
> +	.prepare = usbhsf_null_handle,
> +	.try_run = usbhsf_null_handle,
> +};
> +
> +void usbhs_pkt_push(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt,
> +		    void (*done)(struct usbhs_priv *priv,
> +				 struct usbhs_pkt *pkt),
> +		    void *buf, int len, int zero, int sequence)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	unsigned long flags;
> +
> +	if (!done) {
> +		dev_err(dev, "no done function\n");
> +		return;
> +	}
> +
> +	/********************  spin lock ********************/
> +	usbhs_lock(priv, flags);
> +
> +	if (!pipe->handler) {
> +		dev_err(dev, "no handler function\n");
> +		pipe->handler = &usbhsf_null_handler;
> +	}
> +
> +	list_move_tail(&pkt->node, &pipe->list);
> +
> +	/*
> +	 * each pkt must hold own handler.
> +	 * because handler might be changed by its situation.
> +	 * dma handler -> pio handler.
> +	 */
> +	pkt->pipe	= pipe;
> +	pkt->buf	= buf;
> +	pkt->handler	= pipe->handler;
> +	pkt->length	= len;
> +	pkt->zero	= zero;
> +	pkt->actual	= 0;
> +	pkt->done	= done;
> +	pkt->sequence	= sequence;
> +
> +	usbhs_unlock(priv, flags);
> +	/********************  spin unlock ******************/
> +}
> +
> +static void __usbhsf_pkt_del(struct usbhs_pkt *pkt)
> +{
> +	list_del_init(&pkt->node);
> +}
> +
> +struct usbhs_pkt *__usbhsf_pkt_get(struct usbhs_pipe *pipe)
> +{
> +	return list_first_entry_or_null(&pipe->list, struct usbhs_pkt, node);
> +}
> +
> +static void usbhsf_fifo_unselect(struct usbhs_pipe *pipe,
> +				 struct usbhs_fifo *fifo);
> +static struct dma_chan *usbhsf_dma_chan_get(struct usbhs_fifo *fifo,
> +					    struct usbhs_pkt *pkt);
> +#define usbhsf_dma_map(p)	__usbhsf_dma_map_ctrl(p, 1)
> +#define usbhsf_dma_unmap(p)	__usbhsf_dma_map_ctrl(p, 0)
> +static int __usbhsf_dma_map_ctrl(struct usbhs_pkt *pkt, int map);
> +static void usbhsf_tx_irq_ctrl(struct usbhs_pipe *pipe, int enable);
> +static void usbhsf_rx_irq_ctrl(struct usbhs_pipe *pipe, int enable);
> +struct usbhs_pkt *usbhs_pkt_pop(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt)
> +{
> +	struct usbhs_fifo *fifo = usbhs_pipe_to_fifo(pipe);
> +	unsigned long flags;
> +
> +	/********************  spin lock ********************/
> +	usbhs_lock(priv, flags);
> +
> +	usbhs_pipe_disable(pipe);
> +
> +	if (!pkt)
> +		pkt = __usbhsf_pkt_get(pipe);
> +
> +	if (pkt) {
> +		struct dma_chan *chan = NULL;
> +
> +		if (fifo)
> +			chan = usbhsf_dma_chan_get(fifo, pkt);
> +		if (chan)
> +			usbhsf_dma_unmap(pkt);
> +
> +		usbhs_pipe_clear_without_sequence(pipe, 0, 0);
> +		usbhs_pipe_running(pipe, 0);
> +
> +		__usbhsf_pkt_del(pkt);
> +	}
> +
> +	if (fifo)
> +		usbhsf_fifo_unselect(pipe, fifo);
> +
> +	usbhs_unlock(priv, flags);
> +	/********************  spin unlock ******************/
> +
> +	return pkt;
> +}
> +
> +enum {
> +	USBHSF_PKT_PREPARE,
> +	USBHSF_PKT_TRY_RUN,
> +	USBHSF_PKT_DMA_DONE,
> +};
> +
> +static int usbhsf_pkt_handler(struct usbhs_pipe *pipe, int type)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct usbhs_pkt *pkt;
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int (*func)(struct usbhs_pkt *pkt, int *is_done);
> +	unsigned long flags;
> +	int ret = 0;
> +	int is_done = 0;
> +
> +	/********************  spin lock ********************/
> +	usbhs_lock(priv, flags);
> +
> +	pkt = __usbhsf_pkt_get(pipe);
> +	if (!pkt) {
> +		ret = -EINVAL;
> +		goto __usbhs_pkt_handler_end;
> +	}
> +
> +	switch (type) {
> +	case USBHSF_PKT_PREPARE:
> +		func = pkt->handler->prepare;
> +		break;
> +	case USBHSF_PKT_TRY_RUN:
> +		func = pkt->handler->try_run;
> +		break;
> +	case USBHSF_PKT_DMA_DONE:
> +		func = pkt->handler->dma_done;
> +		break;
> +	default:
> +		dev_err(dev, "unknown pkt handler\n");
> +		goto __usbhs_pkt_handler_end;
> +	}
> +
> +	if (likely(func))
> +		ret = func(pkt, &is_done);
> +
> +	if (is_done)
> +		__usbhsf_pkt_del(pkt);
> +
> +__usbhs_pkt_handler_end:
> +	usbhs_unlock(priv, flags);
> +	/********************  spin unlock ******************/
> +
> +	if (is_done) {
> +		pkt->done(priv, pkt);
> +		usbhs_pkt_start(pipe);
> +	}
> +
> +	return ret;
> +}
> +
> +void usbhs_pkt_start(struct usbhs_pipe *pipe)
> +{
> +	usbhsf_pkt_handler(pipe, USBHSF_PKT_PREPARE);
> +}
> +
> +/*
> + *		irq enable/disable function
> + */
> +#define usbhsf_irq_empty_ctrl(p, e) usbhsf_irq_callback_ctrl(p, irq_bempsts, e)
> +#define usbhsf_irq_ready_ctrl(p, e) usbhsf_irq_callback_ctrl(p, irq_brdysts, e)
> +#define usbhsf_irq_callback_ctrl(pipe, status, enable)			\
> +	({								\
> +		struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);	\
> +		struct usbhs_mod *mod = usbhs_mod_get_current(priv);	\
> +		u16 status = (1 << usbhs_pipe_number(pipe));		\
> +		if (!mod)						\
> +			return;						\
> +		if (enable)						\
> +			mod->status |= status;				\
> +		else							\
> +			mod->status &= ~status;				\
> +		usbhs_irq_callback_update(priv, mod);			\
> +	})
> +
> +static void usbhsf_tx_irq_ctrl(struct usbhs_pipe *pipe, int enable)
> +{
> +	/*
> +	 * And DCP pipe can NOT use "ready interrupt" for "send"
> +	 * it should use "empty" interrupt.
> +	 * see
> +	 *   "Operation" - "Interrupt Function" - "BRDY Interrupt"
> +	 *
> +	 * on the other hand, normal pipe can use "ready interrupt" for "send"
> +	 * even though it is single/double buffer
> +	 */
> +	if (usbhs_pipe_is_dcp(pipe))
> +		usbhsf_irq_empty_ctrl(pipe, enable);
> +	else
> +		usbhsf_irq_ready_ctrl(pipe, enable);
> +}
> +
> +static void usbhsf_rx_irq_ctrl(struct usbhs_pipe *pipe, int enable)
> +{
> +	usbhsf_irq_ready_ctrl(pipe, enable);
> +}
> +
> +/*
> + *		FIFO ctrl
> + */
> +static void usbhsf_send_terminator(struct usbhs_pipe *pipe,
> +				   struct usbhs_fifo *fifo)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +
> +	usbhs_bset(priv, fifo->ctr, BVAL, BVAL);
> +}
> +
> +static int usbhsf_fifo_barrier(struct usbhs_priv *priv,
> +			       struct usbhs_fifo *fifo)
> +{
> +	/* The FIFO port is accessible */
> +	if (usbhs_read(priv, fifo->ctr) & FRDY)
> +		return 0;
> +
> +	return -EBUSY;
> +}
> +
> +static void usbhsf_fifo_clear(struct usbhs_pipe *pipe,
> +			      struct usbhs_fifo *fifo)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	int ret = 0;
> +
> +	if (!usbhs_pipe_is_dcp(pipe)) {
> +		/*
> +		 * This driver checks the pipe condition first to avoid -EBUSY
> +		 * from usbhsf_fifo_barrier() if the pipe is RX direction and
> +		 * empty.
> +		 */
> +		if (usbhs_pipe_is_dir_in(pipe))
> +			ret = usbhs_pipe_is_accessible(pipe);
> +		if (!ret)
> +			ret = usbhsf_fifo_barrier(priv, fifo);
> +	}
> +
> +	/*
> +	 * if non-DCP pipe, this driver should set BCLR when
> +	 * usbhsf_fifo_barrier() returns 0.
> +	 */
> +	if (!ret)
> +		usbhs_write(priv, fifo->ctr, BCLR);
> +}
> +
> +static int usbhsf_fifo_rcv_len(struct usbhs_priv *priv,
> +			       struct usbhs_fifo *fifo)
> +{
> +	return usbhs_read(priv, fifo->ctr) & DTLN_MASK;
> +}
> +
> +static void usbhsf_fifo_unselect(struct usbhs_pipe *pipe,
> +				 struct usbhs_fifo *fifo)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +
> +	usbhs_pipe_select_fifo(pipe, NULL);
> +	usbhs_write(priv, fifo->sel, 0);
> +}
> +
> +static int usbhsf_fifo_select(struct usbhs_pipe *pipe,
> +			      struct usbhs_fifo *fifo,
> +			      int write)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int timeout = 1024;
> +	u16 mask = ((1 << 5) | 0xF);		/* mask of ISEL | CURPIPE */
> +	u16 base = usbhs_pipe_number(pipe);	/* CURPIPE */
> +
> +	if (usbhs_pipe_is_busy(pipe) ||
> +	    usbhsf_fifo_is_busy(fifo))
> +		return -EBUSY;
> +
> +	if (usbhs_pipe_is_dcp(pipe)) {
> +		base |= (1 == write) << 5;	/* ISEL */
> +
> +		if (usbhs_mod_is_host(priv))
> +			usbhs_dcp_dir_for_host(pipe, write);
> +	}
> +
> +	/* "base" will be used below  */
> +	usbhs_write(priv, fifo->sel, base | MBW_32);
> +
> +	/* check ISEL and CURPIPE value */
> +	while (timeout--) {
> +		if (base == (mask & usbhs_read(priv, fifo->sel))) {
> +			usbhs_pipe_select_fifo(pipe, fifo);
> +			return 0;
> +		}
> +		udelay(10);
> +	}
> +
> +	dev_err(dev, "fifo select error\n");
> +
> +	return -EIO;
> +}
> +
> +/*
> + *		DCP status stage
> + */
> +static int usbhs_dcp_dir_switch_to_write(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv); /* CFIFO */
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int ret;
> +
> +	usbhs_pipe_disable(pipe);
> +
> +	ret = usbhsf_fifo_select(pipe, fifo, 1);
> +	if (ret < 0) {
> +		dev_err(dev, "%s() failed\n", __func__);
> +		return ret;
> +	}
> +
> +	usbhs_pipe_sequence_data1(pipe); /* DATA1 */
> +
> +	usbhsf_fifo_clear(pipe, fifo);
> +	usbhsf_send_terminator(pipe, fifo);
> +
> +	usbhsf_fifo_unselect(pipe, fifo);
> +
> +	usbhsf_tx_irq_ctrl(pipe, 1);
> +	usbhs_pipe_enable(pipe);
> +
> +	return ret;
> +}
> +
> +static int usbhs_dcp_dir_switch_to_read(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv); /* CFIFO */
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int ret;
> +
> +	usbhs_pipe_disable(pipe);
> +
> +	ret = usbhsf_fifo_select(pipe, fifo, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "%s() fail\n", __func__);
> +		return ret;
> +	}
> +
> +	usbhs_pipe_sequence_data1(pipe); /* DATA1 */
> +	usbhsf_fifo_clear(pipe, fifo);
> +
> +	usbhsf_fifo_unselect(pipe, fifo);
> +
> +	usbhsf_rx_irq_ctrl(pipe, 1);
> +	usbhs_pipe_enable(pipe);
> +
> +	return ret;
> +
> +}
> +
> +static int usbhs_dcp_dir_switch_done(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +
> +	if (pkt->handler == &usbhs_dcp_status_stage_in_handler)
> +		usbhsf_tx_irq_ctrl(pipe, 0);
> +	else
> +		usbhsf_rx_irq_ctrl(pipe, 0);
> +
> +	pkt->actual = pkt->length;
> +	*is_done = 1;
> +
> +	return 0;
> +}
> +
> +const struct usbhs_pkt_handle usbhs_dcp_status_stage_in_handler = {
> +	.prepare = usbhs_dcp_dir_switch_to_write,
> +	.try_run = usbhs_dcp_dir_switch_done,
> +};
> +
> +const struct usbhs_pkt_handle usbhs_dcp_status_stage_out_handler = {
> +	.prepare = usbhs_dcp_dir_switch_to_read,
> +	.try_run = usbhs_dcp_dir_switch_done,
> +};
> +
> +/*
> + *		DCP data stage (push)
> + */
> +static int usbhsf_dcp_data_stage_try_push(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +
> +	usbhs_pipe_sequence_data1(pipe); /* DATA1 */
> +
> +	/*
> +	 * change handler to PIO push
> +	 */
> +	pkt->handler = &usbhs_fifo_pio_push_handler;
> +
> +	return pkt->handler->prepare(pkt, is_done);
> +}
> +
> +const struct usbhs_pkt_handle usbhs_dcp_data_stage_out_handler = {
> +	.prepare = usbhsf_dcp_data_stage_try_push,
> +};
> +
> +/*
> + *		DCP data stage (pop)
> + */
> +static int usbhsf_dcp_data_stage_prepare_pop(struct usbhs_pkt *pkt,
> +					     int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv);
> +
> +	if (usbhs_pipe_is_busy(pipe))
> +		return 0;
> +
> +	/*
> +	 * prepare pop for DCP should
> +	 *  - change DCP direction,
> +	 *  - clear fifo
> +	 *  - DATA1
> +	 */
> +	usbhs_pipe_disable(pipe);
> +
> +	usbhs_pipe_sequence_data1(pipe); /* DATA1 */
> +
> +	usbhsf_fifo_select(pipe, fifo, 0);
> +	usbhsf_fifo_clear(pipe, fifo);
> +	usbhsf_fifo_unselect(pipe, fifo);
> +
> +	/*
> +	 * change handler to PIO pop
> +	 */
> +	pkt->handler = &usbhs_fifo_pio_pop_handler;
> +
> +	return pkt->handler->prepare(pkt, is_done);
> +}
> +
> +const struct usbhs_pkt_handle usbhs_dcp_data_stage_in_handler = {
> +	.prepare = usbhsf_dcp_data_stage_prepare_pop,
> +};
> +
> +/*
> + *		PIO push handler
> + */
> +static int usbhsf_pio_try_push(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv); /* CFIFO */
> +	void __iomem *addr = priv->base + fifo->port;
> +	u8 *buf;
> +	int maxp = usbhs_pipe_get_maxpacket(pipe);
> +	int total_len;
> +	int i, ret, len;
> +	int is_short;
> +
> +	usbhs_pipe_data_sequence(pipe, pkt->sequence);
> +	pkt->sequence = -1; /* -1 sequence will be ignored */
> +
> +	usbhs_pipe_set_trans_count_if_bulk(pipe, pkt->length);
> +
> +	ret = usbhsf_fifo_select(pipe, fifo, 1);
> +	if (ret < 0)
> +		return 0;
> +
> +	ret = usbhs_pipe_is_accessible(pipe);
> +	if (ret < 0) {
> +		/* inaccessible pipe is not an error */
> +		ret = 0;
> +		goto usbhs_fifo_write_busy;
> +	}
> +
> +	ret = usbhsf_fifo_barrier(priv, fifo);
> +	if (ret < 0)
> +		goto usbhs_fifo_write_busy;
> +
> +	buf		= pkt->buf    + pkt->actual;
> +	len		= pkt->length - pkt->actual;
> +	len		= min(len, maxp);
> +	total_len	= len;
> +	is_short	= total_len < maxp;
> +
> +	/*
> +	 * FIXME
> +	 *
> +	 * 32-bit access only
> +	 */
> +	if (len >= 4 && !((unsigned long)buf & 0x03)) {
> +		iowrite32_rep(addr, buf, len / 4);
> +		len %= 4;
> +		buf += total_len - len;
> +	}
> +
> +	/* the rest operation */
> +	if (usbhs_get_dparam(priv, cfifo_byte_addr)) {
> +		for (i = 0; i < len; i++)
> +			iowrite8(buf[i], addr + (i & 0x03));
> +	} else {
> +		for (i = 0; i < len; i++)
> +			iowrite8(buf[i], addr + (0x03 - (i & 0x03)));
> +	}
> +
> +	/*
> +	 * variable update
> +	 */
> +	pkt->actual += total_len;
> +
> +	if (pkt->actual < pkt->length)
> +		*is_done = 0;		/* there are remainder data */
> +	else if (is_short)
> +		*is_done = 1;		/* short packet */
> +	else
> +		*is_done = !pkt->zero;	/* send zero packet ? */
> +
> +	/*
> +	 * pipe/irq handling
> +	 */
> +	if (is_short)
> +		usbhsf_send_terminator(pipe, fifo);
> +
> +	usbhsf_tx_irq_ctrl(pipe, !*is_done);
> +	usbhs_pipe_running(pipe, !*is_done);
> +	usbhs_pipe_enable(pipe);
> +
> +	dev_dbg(dev, "  send %d (%d/ %d/ %d/ %d)\n",
> +		usbhs_pipe_number(pipe),
> +		pkt->length, pkt->actual, *is_done, pkt->zero);
> +
> +	usbhsf_fifo_unselect(pipe, fifo);
> +
> +	return 0;
> +
> +usbhs_fifo_write_busy:
> +	usbhsf_fifo_unselect(pipe, fifo);
> +
> +	/*
> +	 * pipe is busy.
> +	 * retry in interrupt
> +	 */
> +	usbhsf_tx_irq_ctrl(pipe, 1);
> +	usbhs_pipe_running(pipe, 1);
> +
> +	return ret;
> +}
> +
> +static int usbhsf_pio_prepare_push(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	if (usbhs_pipe_is_running(pkt->pipe))
> +		return 0;
> +
> +	return usbhsf_pio_try_push(pkt, is_done);
> +}
> +
> +const struct usbhs_pkt_handle usbhs_fifo_pio_push_handler = {
> +	.prepare = usbhsf_pio_prepare_push,
> +	.try_run = usbhsf_pio_try_push,
> +};
> +
> +/*
> + *		PIO pop handler
> + */
> +static int usbhsf_prepare_pop(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv);
> +
> +	if (usbhs_pipe_is_busy(pipe))
> +		return 0;
> +
> +	if (usbhs_pipe_is_running(pipe))
> +		return 0;
> +
> +	/*
> +	 * pipe enable to prepare packet receive
> +	 */
> +	usbhs_pipe_data_sequence(pipe, pkt->sequence);
> +	pkt->sequence = -1; /* -1 sequence will be ignored */
> +
> +	if (usbhs_pipe_is_dcp(pipe))
> +		usbhsf_fifo_clear(pipe, fifo);
> +
> +	usbhs_pipe_set_trans_count_if_bulk(pipe, pkt->length);
> +	usbhs_pipe_enable(pipe);
> +	usbhs_pipe_running(pipe, 1);
> +	usbhsf_rx_irq_ctrl(pipe, 1);
> +
> +	return 0;
> +}
> +
> +static int usbhsf_pio_try_pop(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv); /* CFIFO */
> +	void __iomem *addr = priv->base + fifo->port;
> +	u8 *buf;
> +	u32 data = 0;
> +	int maxp = usbhs_pipe_get_maxpacket(pipe);
> +	int rcv_len, len;
> +	int i, ret;
> +	int total_len = 0;
> +
> +	ret = usbhsf_fifo_select(pipe, fifo, 0);
> +	if (ret < 0)
> +		return 0;
> +
> +	ret = usbhsf_fifo_barrier(priv, fifo);
> +	if (ret < 0)
> +		goto usbhs_fifo_read_busy;
> +
> +	rcv_len = usbhsf_fifo_rcv_len(priv, fifo);
> +
> +	buf		= pkt->buf    + pkt->actual;
> +	len		= pkt->length - pkt->actual;
> +	len		= min(len, rcv_len);
> +	total_len	= len;
> +
> +	/*
> +	 * update actual length first here to decide disable pipe.
> +	 * if this pipe keeps BUF status and all data were popped,
> +	 * then, next interrupt/token will be issued again
> +	 */
> +	pkt->actual += total_len;
> +
> +	if ((pkt->actual == pkt->length) ||	/* receive all data */
> +	    (total_len < maxp)) {		/* short packet */
> +		*is_done = 1;
> +		usbhsf_rx_irq_ctrl(pipe, 0);
> +		usbhs_pipe_running(pipe, 0);
> +		/*
> +		 * If function mode, since this controller is possible to enter
> +		 * Control Write status stage at this timing, this driver
> +		 * should not disable the pipe. If such a case happens, this
> +		 * controller is not able to complete the status stage.
> +		 */
> +		if (!usbhs_mod_is_host(priv) && !usbhs_pipe_is_dcp(pipe))
> +			usbhs_pipe_disable(pipe);	/* disable pipe first */
> +	}
> +
> +	/*
> +	 * Buffer clear if Zero-Length packet
> +	 *
> +	 * see
> +	 * "Operation" - "FIFO Buffer Memory" - "FIFO Port Function"
> +	 */
> +	if (0 == rcv_len) {
> +		pkt->zero = 1;
> +		usbhsf_fifo_clear(pipe, fifo);
> +		goto usbhs_fifo_read_end;
> +	}
> +
> +	/*
> +	 * FIXME
> +	 *
> +	 * 32-bit access only
> +	 */
> +	if (len >= 4 && !((unsigned long)buf & 0x03)) {
> +		ioread32_rep(addr, buf, len / 4);
> +		len %= 4;
> +		buf += total_len - len;
> +	}
> +
> +	/* the rest operation */
> +	for (i = 0; i < len; i++) {
> +		if (!(i & 0x03))
> +			data = ioread32(addr);
> +
> +		buf[i] = (data >> ((i & 0x03) * 8)) & 0xff;
> +	}
> +
> +usbhs_fifo_read_end:
> +	dev_dbg(dev, "  recv %d (%d/ %d/ %d/ %d)\n",
> +		usbhs_pipe_number(pipe),
> +		pkt->length, pkt->actual, *is_done, pkt->zero);
> +
> +usbhs_fifo_read_busy:
> +	usbhsf_fifo_unselect(pipe, fifo);
> +
> +	return ret;
> +}
> +
> +const struct usbhs_pkt_handle usbhs_fifo_pio_pop_handler = {
> +	.prepare = usbhsf_prepare_pop,
> +	.try_run = usbhsf_pio_try_pop,
> +};
> +
> +/*
> + *		DCP ctrol statge handler
> + */
> +static int usbhsf_ctrl_stage_end(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	usbhs_dcp_control_transfer_done(pkt->pipe);
> +
> +	*is_done = 1;
> +
> +	return 0;
> +}
> +
> +const struct usbhs_pkt_handle usbhs_ctrl_stage_end_handler = {
> +	.prepare = usbhsf_ctrl_stage_end,
> +	.try_run = usbhsf_ctrl_stage_end,
> +};
> +
> +/*
> + *		DMA fifo functions
> + */
> +static struct dma_chan *usbhsf_dma_chan_get(struct usbhs_fifo *fifo,
> +					    struct usbhs_pkt *pkt)
> +{
> +	if (&usbhs_fifo_dma_push_handler == pkt->handler)
> +		return fifo->tx_chan;
> +
> +	if (&usbhs_fifo_dma_pop_handler == pkt->handler)
> +		return fifo->rx_chan;
> +
> +	return NULL;
> +}
> +
> +#define usbhsf_dma_start(p, f)	__usbhsf_dma_ctrl(p, f, DREQE)
> +#define usbhsf_dma_stop(p, f)	__usbhsf_dma_ctrl(p, f, 0)
> +static void __usbhsf_dma_ctrl(struct usbhs_pipe *pipe,
> +			      struct usbhs_fifo *fifo,
> +			      u16 dreqe)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +
> +	usbhs_bset(priv, fifo->sel, DREQE, dreqe);
> +}
> +
> +static int __usbhsf_dma_map_ctrl(struct usbhs_pkt *pkt, int map)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct usbhs_pipe_info *info = usbhs_priv_to_pipeinfo(priv);
> +
> +	return info->dma_map_ctrl(pkt, map);
> +}
> +
> +/*
> + *		DMA push handler
> + */
> +static int usbhsf_dma_prepare_push(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +
> +	if (usbhs_pipe_is_busy(pipe))
> +		return 0;
> +
> +	/*
> +	 * change handler to PIO
> +	 */
> +	pkt->handler = &usbhs_fifo_pio_push_handler;
> +
> +	return pkt->handler->prepare(pkt, is_done);
> +}
> +
> +static int usbhsf_dma_push_done(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	int is_short = pkt->trans % usbhs_pipe_get_maxpacket(pipe);
> +
> +	pkt->actual += pkt->trans;
> +
> +	if (pkt->actual < pkt->length)
> +		*is_done = 0;		/* there are remainder data */
> +	else if (is_short)
> +		*is_done = 1;		/* short packet */
> +	else
> +		*is_done = !pkt->zero;	/* send zero packet? */
> +
> +	usbhs_pipe_running(pipe, !*is_done);
> +
> +	usbhsf_dma_stop(pipe, pipe->fifo);
> +	usbhsf_dma_unmap(pkt);
> +	usbhsf_fifo_unselect(pipe, pipe->fifo);
> +
> +	if (!*is_done) {
> +		/* change handler to PIO */
> +		pkt->handler = &usbhs_fifo_pio_push_handler;
> +		return pkt->handler->try_run(pkt, is_done);
> +	}
> +
> +	return 0;
> +}
> +
> +const struct usbhs_pkt_handle usbhs_fifo_dma_push_handler = {
> +	.prepare	= usbhsf_dma_prepare_push,
> +	.dma_done	= usbhsf_dma_push_done,
> +};
> +
> +/*
> + *		DMA pop handler
> + */
> +
> +static int usbhsf_dma_prepare_pop_with_rx_irq(struct usbhs_pkt *pkt,
> +					      int *is_done)
> +{
> +	return usbhsf_prepare_pop(pkt, is_done);
> +}
> +
> +static int usbhsf_dma_prepare_pop(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	return usbhsf_dma_prepare_pop_with_rx_irq(pkt, is_done);
> +}
> +
> +static int usbhsf_dma_try_pop_with_rx_irq(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +
> +	if (usbhs_pipe_is_busy(pipe))
> +		return 0;
> +
> +	/*
> +	 * change handler to PIO
> +	 */
> +	pkt->handler = &usbhs_fifo_pio_pop_handler;
> +
> +	return pkt->handler->try_run(pkt, is_done);
> +}
> +
> +static int usbhsf_dma_try_pop(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pkt->pipe);
> +
> +	BUG_ON(usbhs_get_dparam(priv, has_usb_dmac));
> +
> +	return usbhsf_dma_try_pop_with_rx_irq(pkt, is_done);
> +}
> +
> +static int usbhsf_dma_pop_done_with_rx_irq(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	int maxp = usbhs_pipe_get_maxpacket(pipe);
> +
> +	usbhsf_dma_stop(pipe, pipe->fifo);
> +	usbhsf_dma_unmap(pkt);
> +	usbhsf_fifo_unselect(pipe, pipe->fifo);
> +
> +	pkt->actual += pkt->trans;
> +
> +	if ((pkt->actual == pkt->length) ||	/* receive all data */
> +	    (pkt->trans < maxp)) {		/* short packet */
> +		*is_done = 1;
> +		usbhs_pipe_running(pipe, 0);
> +	} else {
> +		/* re-enable */
> +		usbhs_pipe_running(pipe, 0);
> +		usbhsf_prepare_pop(pkt, is_done);
> +	}
> +
> +	return 0;
> +}
> +
> +static int usbhsf_dma_pop_done(struct usbhs_pkt *pkt, int *is_done)
> +{
> +	return usbhsf_dma_pop_done_with_rx_irq(pkt, is_done);
> +}
> +
> +const struct usbhs_pkt_handle usbhs_fifo_dma_pop_handler = {
> +	.prepare	= usbhsf_dma_prepare_pop,
> +	.try_run	= usbhsf_dma_try_pop,
> +	.dma_done	= usbhsf_dma_pop_done
> +};
> +
> +/*
> + *		irq functions
> + */
> +static int usbhsf_irq_empty(struct usbhs_priv *priv,
> +			    struct usbhs_irq_state *irq_state)
> +{
> +	struct usbhs_pipe *pipe;
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int i, ret;
> +
> +	if (!irq_state->bempsts) {
> +		dev_err(dev, "debug %s !!\n", __func__);
> +		return -EIO;
> +	}
> +
> +	dev_dbg(dev, "irq empty [0x%04x]\n", irq_state->bempsts);
> +
> +	/*
> +	 * search interrupted "pipe"
> +	 * not "uep".
> +	 */
> +	usbhs_for_each_pipe_with_dcp(pipe, priv, i) {
> +		if (!(irq_state->bempsts & (1 << i)))
> +			continue;
> +
> +		ret = usbhsf_pkt_handler(pipe, USBHSF_PKT_TRY_RUN);
> +		if (ret < 0)
> +			dev_err(dev, "irq_empty run_error %d : %d\n", i, ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static int usbhsf_irq_ready(struct usbhs_priv *priv,
> +			    struct usbhs_irq_state *irq_state)
> +{
> +	struct usbhs_pipe *pipe;
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int i, ret;
> +
> +	if (!irq_state->brdysts) {
> +		dev_err(dev, "debug %s !!\n", __func__);
> +		return -EIO;
> +	}
> +
> +	dev_dbg(dev, "irq ready [0x%04x]\n", irq_state->brdysts);
> +
> +	/*
> +	 * search interrupted "pipe"
> +	 * not "uep".
> +	 */
> +	usbhs_for_each_pipe_with_dcp(pipe, priv, i) {
> +		if (!(irq_state->brdysts & (1 << i)))
> +			continue;
> +
> +		ret = usbhsf_pkt_handler(pipe, USBHSF_PKT_TRY_RUN);
> +		if (ret < 0)
> +			dev_err(dev, "irq_ready run_error %d : %d\n", i, ret);
> +	}
> +
> +	return 0;
> +}
> +
> +void usbhs_fifo_clear_dcp(struct usbhs_pipe *pipe)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv); /* CFIFO */
> +
> +	/* clear DCP FIFO of transmission */
> +	if (usbhsf_fifo_select(pipe, fifo, 1) < 0)
> +		return;
> +	usbhsf_fifo_clear(pipe, fifo);
> +	usbhsf_fifo_unselect(pipe, fifo);
> +
> +	/* clear DCP FIFO of reception */
> +	if (usbhsf_fifo_select(pipe, fifo, 0) < 0)
> +		return;
> +	usbhsf_fifo_clear(pipe, fifo);
> +	usbhsf_fifo_unselect(pipe, fifo);
> +}
> +
> +/*
> + *		fifo init
> + */
> +void usbhs_fifo_init(struct usbhs_priv *priv)
> +{
> +	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> +	struct usbhs_fifo *cfifo = usbhsf_get_cfifo(priv);
> +	struct usbhs_fifo *dfifo;
> +	int i;
> +
> +	mod->irq_empty		= usbhsf_irq_empty;
> +	mod->irq_ready		= usbhsf_irq_ready;
> +	mod->irq_bempsts	= 0;
> +	mod->irq_brdysts	= 0;
> +
> +	cfifo->pipe	= NULL;
> +	usbhs_for_each_dfifo(priv, dfifo, i)
> +		dfifo->pipe	= NULL;
> +}
> +
> +void usbhs_fifo_quit(struct usbhs_priv *priv)
> +{
> +	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> +
> +	mod->irq_empty		= NULL;
> +	mod->irq_ready		= NULL;
> +	mod->irq_bempsts	= 0;
> +	mod->irq_brdysts	= 0;
> +}
> +
> +#define __USBHS_DFIFO_INIT(priv, fifo, channel, fifo_port)		\
> +do {									\
> +	fifo = usbhsf_get_dnfifo(priv, channel);			\
> +	fifo->name	= "D"#channel"FIFO";				\
> +	fifo->port	= fifo_port;					\
> +	fifo->sel	= D##channel##FIFOSEL;				\
> +	fifo->ctr	= D##channel##FIFOCTR;				\
> +	fifo->tx_slave.shdma_slave.slave_id =				\
> +			usbhs_get_dparam(priv, d##channel##_tx_id);	\
> +	fifo->rx_slave.shdma_slave.slave_id =				\
> +			usbhs_get_dparam(priv, d##channel##_rx_id);	\
> +} while (0)
> +
> +#define USBHS_DFIFO_INIT(priv, fifo, channel)				\
> +		__USBHS_DFIFO_INIT(priv, fifo, channel, D##channel##FIFO)
> +#define USBHS_DFIFO_INIT_NO_PORT(priv, fifo, channel)			\
> +		__USBHS_DFIFO_INIT(priv, fifo, channel, 0)
> +
> +int usbhs_fifo_probe(struct usbhs_priv *priv)
> +{
> +	struct usbhs_fifo *fifo;
> +
> +	/* CFIFO */
> +	fifo = usbhsf_get_cfifo(priv);
> +	fifo->name	= "CFIFO";
> +	fifo->port	= CFIFO;
> +	fifo->sel	= CFIFOSEL;
> +	fifo->ctr	= CFIFOCTR;
> +
> +	/* DFIFO */
> +	USBHS_DFIFO_INIT(priv, fifo, 0);
> +	USBHS_DFIFO_INIT(priv, fifo, 1);
> +	USBHS_DFIFO_INIT_NO_PORT(priv, fifo, 2);
> +	USBHS_DFIFO_INIT_NO_PORT(priv, fifo, 3);
> +
> +	return 0;
> +}
> +
> +void usbhs_fifo_remove(struct usbhs_priv *priv)
> +{
> +}
> diff --git a/drivers/usb/gadget/rcar/fifo.h b/drivers/usb/gadget/rcar/fifo.h
> new file mode 100644
> index 00000000000..86746ca9bdd
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/fifo.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: GPL-1.0+ */
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#ifndef RENESAS_USB_FIFO_H
> +#define RENESAS_USB_FIFO_H
> +
> +#include <dma.h>
> +#include "pipe.h"
> +
> +/*
> + * Drivers, using this library are expected to embed struct shdma_dev,
> + * struct shdma_chan, struct shdma_desc, and struct shdma_slave
> + * in their respective device, channel, descriptor and slave objects.
> + */
> +
> +struct shdma_slave {
> +	int slave_id;
> +};
> +
> +/* Used by slave DMA clients to request DMA to/from a specific peripheral */
> +struct sh_dmae_slave {
> +	struct shdma_slave		shdma_slave;	/* Set by the platform */
> +};
> +
> +struct usbhs_fifo {
> +	char *name;
> +	u32 port;	/* xFIFO */
> +	u32 sel;	/* xFIFOSEL */
> +	u32 ctr;	/* xFIFOCTR */
> +
> +	struct usbhs_pipe	*pipe;
> +
> +	struct dma_chan		*tx_chan;
> +	struct dma_chan		*rx_chan;
> +
> +	struct sh_dmae_slave	tx_slave;
> +	struct sh_dmae_slave	rx_slave;
> +};
> +
> +#define USBHS_MAX_NUM_DFIFO	4
> +struct usbhs_fifo_info {
> +	struct usbhs_fifo cfifo;
> +	struct usbhs_fifo dfifo[USBHS_MAX_NUM_DFIFO];
> +};
> +#define usbhsf_get_dnfifo(p, n)	(&((p)->fifo_info.dfifo[n]))
> +#define usbhs_for_each_dfifo(priv, dfifo, i)			\
> +	for ((i) = 0;						\
> +	     ((i) < USBHS_MAX_NUM_DFIFO) &&			\
> +		     ((dfifo) = usbhsf_get_dnfifo(priv, (i)));	\
> +	     (i)++)
> +
> +struct usbhs_pkt_handle;
> +struct usbhs_pkt {
> +	struct list_head node;
> +	struct usbhs_pipe *pipe;
> +	const struct usbhs_pkt_handle *handler;
> +	void (*done)(struct usbhs_priv *priv,
> +		     struct usbhs_pkt *pkt);
> +	struct work_struct work;
> +	dma_addr_t dma;
> +	const struct dmaengine_result *dma_result;
> +	void *buf;
> +	int length;
> +	int trans;
> +	int actual;
> +	int zero;
> +	int sequence;
> +};
> +
> +struct usbhs_pkt_handle {
> +	int (*prepare)(struct usbhs_pkt *pkt, int *is_done);
> +	int (*try_run)(struct usbhs_pkt *pkt, int *is_done);
> +	int (*dma_done)(struct usbhs_pkt *pkt, int *is_done);
> +};
> +
> +/*
> + * fifo
> + */
> +int usbhs_fifo_probe(struct usbhs_priv *priv);
> +void usbhs_fifo_remove(struct usbhs_priv *priv);
> +void usbhs_fifo_init(struct usbhs_priv *priv);
> +void usbhs_fifo_quit(struct usbhs_priv *priv);
> +void usbhs_fifo_clear_dcp(struct usbhs_pipe *pipe);
> +
> +/*
> + * packet info
> + */
> +extern const struct usbhs_pkt_handle usbhs_fifo_pio_push_handler;
> +extern const struct usbhs_pkt_handle usbhs_fifo_pio_pop_handler;
> +extern const struct usbhs_pkt_handle usbhs_ctrl_stage_end_handler;
> +
> +extern const struct usbhs_pkt_handle usbhs_fifo_dma_push_handler;
> +extern const struct usbhs_pkt_handle usbhs_fifo_dma_pop_handler;
> +
> +extern const struct usbhs_pkt_handle usbhs_dcp_status_stage_in_handler;
> +extern const struct usbhs_pkt_handle usbhs_dcp_status_stage_out_handler;
> +
> +extern const struct usbhs_pkt_handle usbhs_dcp_data_stage_in_handler;
> +extern const struct usbhs_pkt_handle usbhs_dcp_data_stage_out_handler;
> +
> +void usbhs_pkt_init(struct usbhs_pkt *pkt);
> +void usbhs_pkt_push(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt,
> +		    void (*done)(struct usbhs_priv *priv,
> +				 struct usbhs_pkt *pkt),
> +		    void *buf, int len, int zero, int sequence);
> +struct usbhs_pkt *usbhs_pkt_pop(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt);
> +void usbhs_pkt_start(struct usbhs_pipe *pipe);
> +struct usbhs_pkt *__usbhsf_pkt_get(struct usbhs_pipe *pipe);
> +
> +#endif /* RENESAS_USB_FIFO_H */
> diff --git a/drivers/usb/gadget/rcar/mod.c b/drivers/usb/gadget/rcar/mod.c
> new file mode 100644
> index 00000000000..f5f8d169e17
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/mod.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Copyright (C) 2019 Renesas Electronics Corporation
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#include "common.h"
> +#include "mod.h"
> +
> +/*
> + *		autonomy
> + *
> + * these functions are used if platform doesn't have external phy.
> + *  -> there is no "notify_hotplug" callback from platform
> + *  -> call "notify_hotplug" by itself
> + *  -> use own interrupt to connect/disconnect
> + *  -> it mean module clock is always ON
> + *             ~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +static int usbhsm_autonomy_irq_vbus(struct usbhs_priv *priv,
> +				    struct usbhs_irq_state *irq_state)
> +{
> +	usbhsc_hotplug(priv);
> +
> +	return 0;
> +}
> +
> +void usbhs_mod_autonomy_mode(struct usbhs_priv *priv)
> +{
> +	struct usbhs_mod_info *info = usbhs_priv_to_modinfo(priv);
> +
> +	info->irq_vbus = usbhsm_autonomy_irq_vbus;
> +
> +	usbhs_irq_callback_update(priv, NULL);
> +}
> +
> +/*
> + *		host / gadget functions
> + *
> + * renesas_usbhs host/gadget can register itself by below functions.
> + * these functions are called when probe
> + *
> + */
> +void usbhs_mod_register(struct usbhs_priv *priv, struct usbhs_mod *mod, int id)
> +{
> +	struct usbhs_mod_info *info = usbhs_priv_to_modinfo(priv);
> +
> +	info->mod[id]	= mod;
> +	mod->priv	= priv;
> +}
> +
> +struct usbhs_mod *usbhs_mod_get(struct usbhs_priv *priv, int id)
> +{
> +	struct usbhs_mod_info *info = usbhs_priv_to_modinfo(priv);
> +	struct usbhs_mod *ret = NULL;
> +
> +	switch (id) {
> +	case USBHS_HOST:
> +	case USBHS_GADGET:
> +		ret = info->mod[id];
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int usbhs_mod_is_host(struct usbhs_priv *priv)
> +{
> +	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> +	struct usbhs_mod_info *info = usbhs_priv_to_modinfo(priv);
> +
> +	if (!mod)
> +		return -EINVAL;
> +
> +	return info->mod[USBHS_HOST] == mod;
> +}
> +
> +struct usbhs_mod *usbhs_mod_get_current(struct usbhs_priv *priv)
> +{
> +	struct usbhs_mod_info *info = usbhs_priv_to_modinfo(priv);
> +
> +	return info->curt;
> +}
> +
> +int usbhs_mod_change(struct usbhs_priv *priv, int id)
> +{
> +	struct usbhs_mod_info *info = usbhs_priv_to_modinfo(priv);
> +	struct usbhs_mod *mod = NULL;
> +	int ret = 0;
> +
> +	/* id < 0 mean no current */
> +	switch (id) {
> +	case USBHS_HOST:
> +	case USBHS_GADGET:
> +		mod = info->mod[id];
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	info->curt = mod;
> +
> +	return ret;
> +}
> +
> +irqreturn_t usbhs_interrupt(int irq, void *data);
> +int usbhs_mod_probe(struct usbhs_priv *priv)
> +{
> +	int ret;
> +
> +	/*
> +	 * install host/gadget driver
> +	 */
> +	ret = usbhs_mod_host_probe(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = usbhs_mod_gadget_probe(priv);
> +	if (ret < 0)
> +		goto mod_init_host_err;
> +
> +	return ret;
> +
> +mod_init_host_err:
> +	usbhs_mod_host_remove(priv);
> +
> +	return ret;
> +}
> +
> +void usbhs_mod_remove(struct usbhs_priv *priv)
> +{
> +	usbhs_mod_host_remove(priv);
> +	usbhs_mod_gadget_remove(priv);
> +}
> +
> +/*
> + *		status functions
> + */
> +int usbhs_status_get_device_state(struct usbhs_irq_state *irq_state)
> +{
> +	return (int)irq_state->intsts0 & DVSQ_MASK;
> +}
> +
> +int usbhs_status_get_ctrl_stage(struct usbhs_irq_state *irq_state)
> +{
> +	/*
> +	 * return value
> +	 *
> +	 * IDLE_SETUP_STAGE
> +	 * READ_DATA_STAGE
> +	 * READ_STATUS_STAGE
> +	 * WRITE_DATA_STAGE
> +	 * WRITE_STATUS_STAGE
> +	 * NODATA_STATUS_STAGE
> +	 * SEQUENCE_ERROR
> +	 */
> +	return (int)irq_state->intsts0 & CTSQ_MASK;
> +}
> +
> +static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
> +				     struct usbhs_irq_state *state)
> +{
> +	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> +	u16 intenb0, intenb1;
> +	unsigned long flags;
> +
> +	/********************  spin lock ********************/
> +	usbhs_lock(priv, flags);
> +	state->intsts0 = usbhs_read(priv, INTSTS0);
> +	intenb0 = usbhs_read(priv, INTENB0);
> +
> +	if (usbhs_mod_is_host(priv)) {
> +		state->intsts1 = usbhs_read(priv, INTSTS1);
> +		intenb1 = usbhs_read(priv, INTENB1);
> +	} else {
> +		state->intsts1 = intenb1 = 0;
> +	}
> +
> +	/* mask */
> +	if (mod) {
> +		state->brdysts = usbhs_read(priv, BRDYSTS);
> +		state->nrdysts = usbhs_read(priv, NRDYSTS);
> +		state->bempsts = usbhs_read(priv, BEMPSTS);
> +
> +		state->bempsts &= mod->irq_bempsts;
> +		state->brdysts &= mod->irq_brdysts;
> +	}
> +	usbhs_unlock(priv, flags);
> +	/********************  spin unlock ******************/
> +
> +	return 0;
> +}
> +
> +/*
> + *		interrupt
> + */
> +#define INTSTS0_MAGIC 0xF800 /* acknowledge magical interrupt sources */
> +#define INTSTS1_MAGIC 0xA870 /* acknowledge magical interrupt sources */
> +irqreturn_t usbhs_interrupt(int irq, void *data)
> +{
> +	struct usbhs_priv *priv = data;
> +	struct usbhs_irq_state irq_state;
> +
> +	if (usbhs_status_get_each_irq(priv, &irq_state) < 0)
> +		return IRQ_NONE;
> +
> +	/*
> +	 * clear interrupt
> +	 *
> +	 * The hardware is _very_ picky to clear interrupt bit.
> +	 * Especially INTSTS0_MAGIC, INTSTS1_MAGIC value.
> +	 *
> +	 * see
> +	 *	"Operation"
> +	 *	 - "Control Transfer (DCP)"
> +	 *	   - Function :: VALID bit should 0
> +	 */
> +	usbhs_write(priv, INTSTS0, ~irq_state.intsts0 & INTSTS0_MAGIC);
> +	if (usbhs_mod_is_host(priv))
> +		usbhs_write(priv, INTSTS1, ~irq_state.intsts1 & INTSTS1_MAGIC);
> +
> +	/*
> +	 * The driver should not clear the xxxSTS after the line of
> +	 * "call irq callback functions" because each "if" statement is
> +	 * possible to call the callback function for avoiding any side effects.
> +	 */
> +	if (irq_state.intsts0 & BRDY)
> +		usbhs_write(priv, BRDYSTS, ~irq_state.brdysts);
> +	usbhs_write(priv, NRDYSTS, ~irq_state.nrdysts);
> +	if (irq_state.intsts0 & BEMP)
> +		usbhs_write(priv, BEMPSTS, ~irq_state.bempsts);
> +
> +	/*
> +	 * call irq callback functions
> +	 * see also
> +	 *	usbhs_irq_setting_update
> +	 */
> +
> +	/* INTSTS0 */
> +	if (irq_state.intsts0 & VBINT)
> +		usbhs_mod_info_call(priv, irq_vbus, priv, &irq_state);
> +
> +	if (irq_state.intsts0 & DVST)
> +		usbhs_mod_call(priv, irq_dev_state, priv, &irq_state);
> +
> +	if (irq_state.intsts0 & CTRT)
> +		usbhs_mod_call(priv, irq_ctrl_stage, priv, &irq_state);
> +
> +	if (irq_state.intsts0 & BEMP)
> +		usbhs_mod_call(priv, irq_empty, priv, &irq_state);
> +
> +	if (irq_state.intsts0 & BRDY)
> +		usbhs_mod_call(priv, irq_ready, priv, &irq_state);
> +
> +	if (usbhs_mod_is_host(priv)) {
> +		/* INTSTS1 */
> +		if (irq_state.intsts1 & ATTCH)
> +			usbhs_mod_call(priv, irq_attch, priv, &irq_state);
> +
> +		if (irq_state.intsts1 & DTCH)
> +			usbhs_mod_call(priv, irq_dtch, priv, &irq_state);
> +
> +		if (irq_state.intsts1 & SIGN)
> +			usbhs_mod_call(priv, irq_sign, priv, &irq_state);
> +
> +		if (irq_state.intsts1 & SACK)
> +			usbhs_mod_call(priv, irq_sack, priv, &irq_state);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +void usbhs_irq_callback_update(struct usbhs_priv *priv, struct usbhs_mod *mod)
> +{
> +	u16 intenb0 = 0;
> +	u16 intenb1 = 0;
> +	struct usbhs_mod_info *info = usbhs_priv_to_modinfo(priv);
> +
> +	/*
> +	 * BEMPENB/BRDYENB are picky.
> +	 * below method is required
> +	 *
> +	 *  - clear  INTSTS0
> +	 *  - update BEMPENB/BRDYENB
> +	 *  - update INTSTS0
> +	 */
> +	usbhs_write(priv, INTENB0, 0);
> +	if (usbhs_mod_is_host(priv))
> +		usbhs_write(priv, INTENB1, 0);
> +
> +	usbhs_write(priv, BEMPENB, 0);
> +	usbhs_write(priv, BRDYENB, 0);
> +
> +	/*
> +	 * see also
> +	 *	usbhs_interrupt
> +	 */
> +
> +	if (info->irq_vbus)
> +		intenb0 |= VBSE;
> +
> +	if (mod) {
> +		/*
> +		 * INTSTS0
> +		 */
> +		if (mod->irq_ctrl_stage)
> +			intenb0 |= CTRE;
> +
> +		if (mod->irq_dev_state)
> +			intenb0 |= DVSE;
> +
> +		if (mod->irq_empty && mod->irq_bempsts) {
> +			usbhs_write(priv, BEMPENB, mod->irq_bempsts);
> +			intenb0 |= BEMPE;
> +		}
> +
> +		if (mod->irq_ready && mod->irq_brdysts) {
> +			usbhs_write(priv, BRDYENB, mod->irq_brdysts);
> +			intenb0 |= BRDYE;
> +		}
> +
> +		if (usbhs_mod_is_host(priv)) {
> +			/*
> +			 * INTSTS1
> +			 */
> +			if (mod->irq_attch)
> +				intenb1 |= ATTCHE;
> +
> +			if (mod->irq_dtch)
> +				intenb1 |= DTCHE;
> +
> +			if (mod->irq_sign)
> +				intenb1 |= SIGNE;
> +
> +			if (mod->irq_sack)
> +				intenb1 |= SACKE;
> +		}
> +	}
> +
> +	if (intenb0)
> +		usbhs_write(priv, INTENB0, intenb0);
> +
> +	if (usbhs_mod_is_host(priv) && intenb1)
> +		usbhs_write(priv, INTENB1, intenb1);
> +}
> diff --git a/drivers/usb/gadget/rcar/mod.h b/drivers/usb/gadget/rcar/mod.h
> new file mode 100644
> index 00000000000..b670e950a28
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/mod.h
> @@ -0,0 +1,161 @@
> +/* SPDX-License-Identifier: GPL-1.0+ */
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Copyright (C) 2019 Renesas Electronics Corporation
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#ifndef RENESAS_USB_MOD_H
> +#define RENESAS_USB_MOD_H
> +
> +#include "common.h"
> +
> +/*
> + *	struct
> + */
> +struct usbhs_irq_state {
> +	u16 intsts0;
> +	u16 intsts1;
> +	u16 brdysts;
> +	u16 nrdysts;
> +	u16 bempsts;
> +};
> +
> +struct usbhs_mod {
> +	char *name;
> +
> +	/*
> +	 * entry point from common.c
> +	 */
> +	int (*start)(struct usbhs_priv *priv);
> +	int (*stop)(struct usbhs_priv *priv);
> +
> +	/*
> +	 * INTSTS0
> +	 */
> +
> +	/* DVST (DVSQ) */
> +	int (*irq_dev_state)(struct usbhs_priv *priv,
> +			     struct usbhs_irq_state *irq_state);
> +
> +	/* CTRT (CTSQ) */
> +	int (*irq_ctrl_stage)(struct usbhs_priv *priv,
> +			      struct usbhs_irq_state *irq_state);
> +
> +	/* BEMP / BEMPSTS */
> +	int (*irq_empty)(struct usbhs_priv *priv,
> +			 struct usbhs_irq_state *irq_state);
> +	u16 irq_bempsts;
> +
> +	/* BRDY / BRDYSTS */
> +	int (*irq_ready)(struct usbhs_priv *priv,
> +			 struct usbhs_irq_state *irq_state);
> +	u16 irq_brdysts;
> +
> +	/*
> +	 * INTSTS1
> +	 */
> +
> +	/* ATTCHE */
> +	int (*irq_attch)(struct usbhs_priv *priv,
> +			 struct usbhs_irq_state *irq_state);
> +
> +	/* DTCHE */
> +	int (*irq_dtch)(struct usbhs_priv *priv,
> +			struct usbhs_irq_state *irq_state);
> +
> +	/* SIGN */
> +	int (*irq_sign)(struct usbhs_priv *priv,
> +			struct usbhs_irq_state *irq_state);
> +
> +	/* SACK */
> +	int (*irq_sack)(struct usbhs_priv *priv,
> +			struct usbhs_irq_state *irq_state);
> +
> +	struct usbhs_priv *priv;
> +};
> +
> +struct usbhs_mod_info {
> +	struct usbhs_mod *mod[USBHS_MAX];
> +	struct usbhs_mod *curt; /* current mod */
> +
> +	/*
> +	 * INTSTS0 :: VBINT
> +	 *
> +	 * This function will be used as autonomy mode (runtime_pwctrl == 0)
> +	 * when the platform doesn't have own get_vbus function.
> +	 *
> +	 * This callback cannot be member of "struct usbhs_mod" because it
> +	 * will be used even though host/gadget has not been selected.
> +	 */
> +	int (*irq_vbus)(struct usbhs_priv *priv,
> +			struct usbhs_irq_state *irq_state);
> +};
> +
> +/*
> + *		for host/gadget module
> + */
> +struct usbhs_mod *usbhs_mod_get(struct usbhs_priv *priv, int id);
> +struct usbhs_mod *usbhs_mod_get_current(struct usbhs_priv *priv);
> +void usbhs_mod_register(struct usbhs_priv *priv, struct usbhs_mod *usb, int id);
> +int usbhs_mod_is_host(struct usbhs_priv *priv);
> +int usbhs_mod_change(struct usbhs_priv *priv, int id);
> +int usbhs_mod_probe(struct usbhs_priv *priv);
> +void usbhs_mod_remove(struct usbhs_priv *priv);
> +
> +void usbhs_mod_autonomy_mode(struct usbhs_priv *priv);
> +void usbhs_mod_non_autonomy_mode(struct usbhs_priv *priv);
> +
> +/*
> + *		status functions
> + */
> +int usbhs_status_get_device_state(struct usbhs_irq_state *irq_state);
> +int usbhs_status_get_ctrl_stage(struct usbhs_irq_state *irq_state);
> +
> +/*
> + *		callback functions
> + */
> +void usbhs_irq_callback_update(struct usbhs_priv *priv, struct usbhs_mod *mod);
> +
> +irqreturn_t usbhs_interrupt(int irq, void *data);
> +
> +#define usbhs_mod_call(priv, func, param...)		\
> +	({						\
> +		struct usbhs_mod *mod;			\
> +		mod = usbhs_mod_get_current(priv);	\
> +		!mod		? -ENODEV :		\
> +		!mod->func	? 0 :			\
> +		 mod->func(param);			\
> +	})
> +
> +#define usbhs_priv_to_modinfo(priv) (&priv->mod_info)
> +#define usbhs_mod_info_call(priv, func, param...)	\
> +({							\
> +	struct usbhs_mod_info *info;			\
> +	info = usbhs_priv_to_modinfo(priv);		\
> +	!info->func ? 0 :				\
> +	 info->func(param);				\
> +})
> +
> +/*
> + * host / gadget control
> + */
> +#if	defined(CONFIG_USB_RENESAS_USBHS_HCD) || \
> +	defined(CONFIG_USB_RENESAS_USBHS_HCD_MODULE)
> +extern int usbhs_mod_host_probe(struct usbhs_priv *priv);
> +extern int usbhs_mod_host_remove(struct usbhs_priv *priv);
> +#else
> +static inline int usbhs_mod_host_probe(struct usbhs_priv *priv)
> +{
> +	return 0;
> +}
> +static inline void usbhs_mod_host_remove(struct usbhs_priv *priv)
> +{
> +}
> +#endif
> +
> +extern int usbhs_mod_gadget_probe(struct usbhs_priv *priv);
> +extern void usbhs_mod_gadget_remove(struct usbhs_priv *priv);
> +
> +#endif /* RENESAS_USB_MOD_H */
> diff --git a/drivers/usb/gadget/rcar/mod_gadget.c b/drivers/usb/gadget/rcar/mod_gadget.c
> new file mode 100644
> index 00000000000..bd9855eb4fa
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/mod_gadget.c
> @@ -0,0 +1,1136 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Copyright (C) 2019 Renesas Electronics Corporation
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/otg.h>
> +#include "common.h"
> +
> +/*
> + *		struct
> + */
> +struct usbhsg_request {
> +	struct usb_request	req;
> +	struct usbhs_pkt	pkt;
> +};
> +
> +#define EP_NAME_SIZE 8
> +struct usbhsg_gpriv;
> +struct usbhsg_uep {
> +	struct usb_ep		 ep;
> +	struct usbhs_pipe	*pipe;
> +	spinlock_t		lock;	/* protect the pipe */
> +
> +	char ep_name[EP_NAME_SIZE];
> +
> +	struct usbhsg_gpriv *gpriv;
> +};
> +
> +struct usbhsg_gpriv {
> +	struct usb_gadget	 gadget;
> +	struct usbhs_mod	 mod;
> +
> +	struct usbhsg_uep	*uep;
> +	int			 uep_size;
> +
> +	struct usb_gadget_driver	*driver;
> +	bool			 vbus_active;
> +
> +	u32	status;
> +#define USBHSG_STATUS_STARTED		(1 << 0)
> +#define USBHSG_STATUS_REGISTERD		(1 << 1)
> +#define USBHSG_STATUS_WEDGE		(1 << 2)
> +#define USBHSG_STATUS_SELF_POWERED	(1 << 3)
> +#define USBHSG_STATUS_SOFT_CONNECT	(1 << 4)
> +};
> +
> +struct usbhsg_recip_handle {
> +	char *name;
> +	int (*device)(struct usbhs_priv *priv, struct usbhsg_uep *uep,
> +		      struct usb_ctrlrequest *ctrl);
> +	int (*interface)(struct usbhs_priv *priv, struct usbhsg_uep *uep,
> +			 struct usb_ctrlrequest *ctrl);
> +	int (*endpoint)(struct usbhs_priv *priv, struct usbhsg_uep *uep,
> +			struct usb_ctrlrequest *ctrl);
> +};
> +
> +/*
> + *		macro
> + */
> +#define usbhsg_priv_to_gpriv(priv)			\
> +	container_of(					\
> +		usbhs_mod_get(priv, USBHS_GADGET),	\
> +		struct usbhsg_gpriv, mod)
> +
> +#define __usbhsg_for_each_uep(start, pos, g, i)	\
> +	for ((i) = start;					\
> +	     ((i) < (g)->uep_size) && ((pos) = (g)->uep + (i));	\
> +	     (i)++)
> +
> +#define usbhsg_for_each_uep(pos, gpriv, i)	\
> +	__usbhsg_for_each_uep(1, pos, gpriv, i)
> +
> +#define usbhsg_for_each_uep_with_dcp(pos, gpriv, i)	\
> +	__usbhsg_for_each_uep(0, pos, gpriv, i)
> +
> +#define usbhsg_gadget_to_gpriv(g)\
> +	container_of(g, struct usbhsg_gpriv, gadget)
> +
> +#define usbhsg_req_to_ureq(r)\
> +	container_of(r, struct usbhsg_request, req)
> +
> +#define usbhsg_ep_to_uep(e)		container_of(e, struct usbhsg_uep, ep)
> +#define usbhsg_gpriv_to_dev(gp)		usbhs_priv_to_dev((gp)->mod.priv)
> +#define usbhsg_gpriv_to_priv(gp)	((gp)->mod.priv)
> +#define usbhsg_gpriv_to_dcp(gp)		((gp)->uep)
> +#define usbhsg_gpriv_to_nth_uep(gp, i)	((gp)->uep + i)
> +#define usbhsg_uep_to_gpriv(u)		((u)->gpriv)
> +#define usbhsg_uep_to_pipe(u)		((u)->pipe)
> +#define usbhsg_pipe_to_uep(p)		((p)->mod_private)
> +#define usbhsg_is_dcp(u)		((u) == usbhsg_gpriv_to_dcp((u)->gpriv))
> +
> +#define usbhsg_ureq_to_pkt(u)		(&(u)->pkt)
> +#define usbhsg_pkt_to_ureq(i)	\
> +	container_of(i, struct usbhsg_request, pkt)
> +
> +#define usbhsg_is_not_connected(gp) ((gp)->gadget.speed == USB_SPEED_UNKNOWN)
> +
> +/* status */
> +#define usbhsg_status_init(gp)   do {(gp)->status = 0; } while (0)
> +#define usbhsg_status_set(gp, b) (gp->status |=  b)
> +#define usbhsg_status_clr(gp, b) (gp->status &= ~b)
> +#define usbhsg_status_has(gp, b) (gp->status &   b)
> +
> +/*
> + *		queue push/pop
> + */
> +static void __usbhsg_queue_pop(struct usbhsg_uep *uep,
> +			       struct usbhsg_request *ureq,
> +			       int status)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> +	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
> +
> +	if (pipe)
> +		dev_dbg(dev, "pipe %d : queue pop\n", usbhs_pipe_number(pipe));
> +
> +	ureq->req.status = status;
> +	spin_unlock(usbhs_priv_to_lock(priv));
> +	usb_gadget_giveback_request(&uep->ep, &ureq->req);
> +	spin_lock(usbhs_priv_to_lock(priv));
> +}
> +
> +static void usbhsg_queue_pop(struct usbhsg_uep *uep,
> +			     struct usbhsg_request *ureq,
> +			     int status)
> +{
> +	unsigned long flags;
> +
> +	usbhs_lock(priv, flags);
> +	__usbhsg_queue_pop(uep, ureq, status);
> +	usbhs_unlock(priv, flags);
> +}
> +
> +static void usbhsg_queue_done(struct usbhs_priv *priv, struct usbhs_pkt *pkt)
> +{
> +	struct usbhs_pipe *pipe = pkt->pipe;
> +	struct usbhsg_uep *uep = usbhsg_pipe_to_uep(pipe);
> +	struct usbhsg_request *ureq = usbhsg_pkt_to_ureq(pkt);
> +	unsigned long flags;
> +
> +	ureq->req.actual = pkt->actual;
> +
> +	usbhs_lock(priv, flags);
> +	if (uep)
> +		__usbhsg_queue_pop(uep, ureq, 0);
> +	usbhs_unlock(priv, flags);
> +}
> +
> +static void usbhsg_queue_push(struct usbhsg_uep *uep,
> +			      struct usbhsg_request *ureq)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> +	struct usbhs_pkt *pkt = usbhsg_ureq_to_pkt(ureq);
> +	struct usb_request *req = &ureq->req;
> +
> +	req->actual = 0;
> +	req->status = -EINPROGRESS;
> +	usbhs_pkt_push(pipe, pkt, usbhsg_queue_done,
> +		       req->buf, req->length, req->zero, -1);
> +	usbhs_pkt_start(pipe);
> +
> +	dev_dbg(dev, "pipe %d : queue push (%d)\n",
> +		usbhs_pipe_number(pipe),
> +		req->length);
> +}
> +
> +/*
> + *		dma map/unmap
> + */
> +static int usbhsg_dma_map_ctrl(struct usbhs_pkt *pkt, int map)
> +{
> +	return -1;
> +}
> +
> +/*
> + *		USB_TYPE_STANDARD / clear feature functions
> + */
> +static int usbhsg_recip_handler_std_control_done(struct usbhs_priv *priv,
> +						 struct usbhsg_uep *uep,
> +						 struct usb_ctrlrequest *ctrl)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +	struct usbhsg_uep *dcp = usbhsg_gpriv_to_dcp(gpriv);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(dcp);
> +
> +	usbhs_dcp_control_transfer_done(pipe);
> +
> +	return 0;
> +}
> +
> +static int usbhsg_recip_handler_std_clear_endpoint(struct usbhs_priv *priv,
> +						   struct usbhsg_uep *uep,
> +						   struct usb_ctrlrequest *ctrl)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> +
> +	if (!usbhsg_status_has(gpriv, USBHSG_STATUS_WEDGE)) {
> +		usbhs_pipe_disable(pipe);
> +		usbhs_pipe_sequence_data0(pipe);
> +		usbhs_pipe_enable(pipe);
> +	}
> +
> +	usbhsg_recip_handler_std_control_done(priv, uep, ctrl);
> +
> +	usbhs_pkt_start(pipe);
> +
> +	return 0;
> +}
> +
> +static struct usbhsg_recip_handle req_clear_feature = {
> +	.name		= "clear feature",
> +	.device		= usbhsg_recip_handler_std_control_done,
> +	.interface	= usbhsg_recip_handler_std_control_done,
> +	.endpoint	= usbhsg_recip_handler_std_clear_endpoint,
> +};
> +
> +/*
> + *		USB_TYPE_STANDARD / set feature functions
> + */
> +static int usbhsg_recip_handler_std_set_device(struct usbhs_priv *priv,
> +						 struct usbhsg_uep *uep,
> +						 struct usb_ctrlrequest *ctrl)
> +{
> +	switch (le16_to_cpu(ctrl->wValue)) {
> +	case USB_DEVICE_TEST_MODE:
> +		usbhsg_recip_handler_std_control_done(priv, uep, ctrl);
> +		udelay(100);
> +		usbhs_sys_set_test_mode(priv, le16_to_cpu(ctrl->wIndex) >> 8);
> +		break;
> +	default:
> +		usbhsg_recip_handler_std_control_done(priv, uep, ctrl);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int usbhsg_recip_handler_std_set_endpoint(struct usbhs_priv *priv,
> +						 struct usbhsg_uep *uep,
> +						 struct usb_ctrlrequest *ctrl)
> +{
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> +
> +	usbhs_pipe_stall(pipe);
> +
> +	usbhsg_recip_handler_std_control_done(priv, uep, ctrl);
> +
> +	return 0;
> +}
> +
> +static struct usbhsg_recip_handle req_set_feature = {
> +	.name		= "set feature",
> +	.device		= usbhsg_recip_handler_std_set_device,
> +	.interface	= usbhsg_recip_handler_std_control_done,
> +	.endpoint	= usbhsg_recip_handler_std_set_endpoint,
> +};
> +
> +/*
> + *		USB_TYPE_STANDARD / get status functions
> + */
> +static void __usbhsg_recip_send_complete(struct usb_ep *ep,
> +					 struct usb_request *req)
> +{
> +	struct usbhsg_request *ureq = usbhsg_req_to_ureq(req);
> +
> +	/* free allocated recip-buffer/usb_request */
> +	kfree(ureq->pkt.buf);
> +	usb_ep_free_request(ep, req);
> +}
> +
> +static void __usbhsg_recip_send_status(struct usbhsg_gpriv *gpriv,
> +				       unsigned short status)
> +{
> +	struct usbhsg_uep *dcp = usbhsg_gpriv_to_dcp(gpriv);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(dcp);
> +	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
> +	struct usb_request *req;
> +	__le16 *buf;
> +
> +	/* alloc new usb_request for recip */
> +	req = usb_ep_alloc_request(&dcp->ep, GFP_ATOMIC);
> +	if (!req) {
> +		dev_err(dev, "recip request allocation fail\n");
> +		return;
> +	}
> +
> +	/* alloc recip data buffer */
> +	buf = kmalloc(sizeof(*buf), GFP_ATOMIC);
> +	if (!buf) {
> +		usb_ep_free_request(&dcp->ep, req);
> +		return;
> +	}
> +
> +	/* recip data is status */
> +	*buf = cpu_to_le16(status);
> +
> +	/* allocated usb_request/buffer will be freed */
> +	req->complete	= __usbhsg_recip_send_complete;
> +	req->buf	= buf;
> +	req->length	= sizeof(*buf);
> +	req->zero	= 0;
> +
> +	/* push packet */
> +	pipe->handler = &usbhs_fifo_pio_push_handler;
> +	usbhsg_queue_push(dcp, usbhsg_req_to_ureq(req));
> +}
> +
> +static int usbhsg_recip_handler_std_get_device(struct usbhs_priv *priv,
> +					       struct usbhsg_uep *uep,
> +					       struct usb_ctrlrequest *ctrl)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	unsigned short status = 0;
> +
> +	if (usbhsg_status_has(gpriv, USBHSG_STATUS_SELF_POWERED))
> +		status = 1 << USB_DEVICE_SELF_POWERED;
> +
> +	__usbhsg_recip_send_status(gpriv, status);
> +
> +	return 0;
> +}
> +
> +static int usbhsg_recip_handler_std_get_interface(struct usbhs_priv *priv,
> +						  struct usbhsg_uep *uep,
> +						  struct usb_ctrlrequest *ctrl)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	unsigned short status = 0;
> +
> +	__usbhsg_recip_send_status(gpriv, status);
> +
> +	return 0;
> +}
> +
> +static int usbhsg_recip_handler_std_get_endpoint(struct usbhs_priv *priv,
> +						 struct usbhsg_uep *uep,
> +						 struct usb_ctrlrequest *ctrl)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> +	unsigned short status = 0;
> +
> +	if (usbhs_pipe_is_stall(pipe))
> +		status = 1 << USB_ENDPOINT_HALT;
> +
> +	__usbhsg_recip_send_status(gpriv, status);
> +
> +	return 0;
> +}
> +
> +static struct usbhsg_recip_handle req_get_status = {
> +	.name		= "get status",
> +	.device		= usbhsg_recip_handler_std_get_device,
> +	.interface	= usbhsg_recip_handler_std_get_interface,
> +	.endpoint	= usbhsg_recip_handler_std_get_endpoint,
> +};
> +
> +/*
> + *		USB_TYPE handler
> + */
> +static int usbhsg_recip_run_handle(struct usbhs_priv *priv,
> +				   struct usbhsg_recip_handle *handler,
> +				   struct usb_ctrlrequest *ctrl)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
> +	struct usbhsg_uep *uep;
> +	struct usbhs_pipe *pipe;
> +	int recip = ctrl->bRequestType & USB_RECIP_MASK;
> +	int nth = le16_to_cpu(ctrl->wIndex) & USB_ENDPOINT_NUMBER_MASK;
> +	int ret = 0;
> +	int (*func)(struct usbhs_priv *priv, struct usbhsg_uep *uep,
> +		    struct usb_ctrlrequest *ctrl);
> +	char *msg;
> +
> +	uep = usbhsg_gpriv_to_nth_uep(gpriv, nth);
> +	pipe = usbhsg_uep_to_pipe(uep);
> +	if (!pipe) {
> +		dev_err(dev, "wrong recip request\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (recip) {
> +	case USB_RECIP_DEVICE:
> +		msg	= "DEVICE";
> +		func	= handler->device;
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		msg	= "INTERFACE";
> +		func	= handler->interface;
> +		break;
> +	case USB_RECIP_ENDPOINT:
> +		msg	= "ENDPOINT";
> +		func	= handler->endpoint;
> +		break;
> +	default:
> +		dev_warn(dev, "unsupported RECIP(%d)\n", recip);
> +		func = NULL;
> +		ret = -EINVAL;
> +	}
> +
> +	if (func) {
> +		dev_dbg(dev, "%s (pipe %d :%s)\n", handler->name, nth, msg);
> +		ret = func(priv, uep, ctrl);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + *		irq functions
> + *
> + * it will be called from usbhs_interrupt
> + */
> +static int usbhsg_irq_dev_state(struct usbhs_priv *priv,
> +				struct usbhs_irq_state *irq_state)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
> +	int state = usbhs_status_get_device_state(irq_state);
> +
> +	gpriv->gadget.speed = usbhs_bus_get_speed(priv);
> +
> +	dev_dbg(dev, "state = %x : speed : %d\n", state, gpriv->gadget.speed);
> +
> +	if (gpriv->gadget.speed != USB_SPEED_UNKNOWN &&
> +	    (state & SUSPENDED_STATE)) {
> +		if (gpriv->driver && gpriv->driver->suspend)
> +			gpriv->driver->suspend(&gpriv->gadget);
> +		usb_gadget_set_state(&gpriv->gadget, USB_STATE_SUSPENDED);
> +	}
> +
> +	return 0;
> +}
> +
> +static int usbhsg_irq_ctrl_stage(struct usbhs_priv *priv,
> +				 struct usbhs_irq_state *irq_state)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +	struct usbhsg_uep *dcp = usbhsg_gpriv_to_dcp(gpriv);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(dcp);
> +	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
> +	struct usb_ctrlrequest ctrl;
> +	struct usbhsg_recip_handle *recip_handler = NULL;
> +	int stage = usbhs_status_get_ctrl_stage(irq_state);
> +	int ret = 0;
> +
> +	dev_dbg(dev, "stage = %d\n", stage);
> +
> +	/*
> +	 * see Manual
> +	 *
> +	 *  "Operation"
> +	 *  - "Interrupt Function"
> +	 *    - "Control Transfer Stage Transition Interrupt"
> +	 *      - Fig. "Control Transfer Stage Transitions"
> +	 */
> +
> +	switch (stage) {
> +	case READ_DATA_STAGE:
> +		pipe->handler = &usbhs_fifo_pio_push_handler;
> +		break;
> +	case WRITE_DATA_STAGE:
> +		pipe->handler = &usbhs_fifo_pio_pop_handler;
> +		break;
> +	case NODATA_STATUS_STAGE:
> +		pipe->handler = &usbhs_ctrl_stage_end_handler;
> +		break;
> +	case READ_STATUS_STAGE:
> +	case WRITE_STATUS_STAGE:
> +		usbhs_dcp_control_transfer_done(pipe);
> +		fallthrough;
> +	default:
> +		return ret;
> +	}
> +
> +	/*
> +	 * get usb request
> +	 */
> +	usbhs_usbreq_get_val(priv, &ctrl);
> +
> +	switch (ctrl.bRequestType & USB_TYPE_MASK) {
> +	case USB_TYPE_STANDARD:
> +		switch (ctrl.bRequest) {
> +		case USB_REQ_CLEAR_FEATURE:
> +			recip_handler = &req_clear_feature;
> +			break;
> +		case USB_REQ_SET_FEATURE:
> +			recip_handler = &req_set_feature;
> +			break;
> +		case USB_REQ_GET_STATUS:
> +			recip_handler = &req_get_status;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * setup stage / run recip
> +	 */
> +	if (recip_handler)
> +		ret = usbhsg_recip_run_handle(priv, recip_handler, &ctrl);
> +	else
> +		ret = gpriv->driver->setup(&gpriv->gadget, &ctrl);
> +
> +	if (ret < 0)
> +		usbhs_pipe_stall(pipe);
> +
> +	return ret;
> +}
> +
> +/*
> + *
> + *		usb_dcp_ops
> + *
> + */
> +static int usbhsg_pipe_disable(struct usbhsg_uep *uep)
> +{
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> +	struct usbhs_pkt *pkt;
> +
> +	while (1) {
> +		pkt = usbhs_pkt_pop(pipe, NULL);
> +		if (!pkt)
> +			break;
> +
> +		usbhsg_queue_pop(uep, usbhsg_pkt_to_ureq(pkt), -ESHUTDOWN);
> +	}
> +
> +	usbhs_pipe_disable(pipe);
> +
> +	return 0;
> +}
> +
> +/*
> + *
> + *		usb_ep_ops
> + *
> + */
> +static int usbhsg_ep_enable(struct usb_ep *ep,
> +			 const struct usb_endpoint_descriptor *desc)
> +{
> +	struct usbhsg_uep *uep   = usbhsg_ep_to_uep(ep);
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
> +	struct usbhs_pipe *pipe;
> +	int ret = -EIO;
> +	unsigned long flags;
> +
> +	usbhs_lock(priv, flags);
> +
> +	/*
> +	 * if it already have pipe,
> +	 * nothing to do
> +	 */
> +	if (uep->pipe) {
> +		usbhs_pipe_clear(uep->pipe);
> +		usbhs_pipe_sequence_data0(uep->pipe);
> +		ret = 0;
> +		goto usbhsg_ep_enable_end;
> +	}
> +
> +	pipe = usbhs_pipe_malloc(priv,
> +				 usb_endpoint_type(desc),
> +				 usb_endpoint_dir_in(desc));
> +	if (pipe) {
> +		uep->pipe		= pipe;
> +		pipe->mod_private	= uep;
> +
> +		/* set epnum / maxp */
> +		usbhs_pipe_config_update(pipe, 0,
> +					 usb_endpoint_num(desc),
> +					 usb_endpoint_maxp(desc));
> +
> +		/*
> +		 * usbhs_fifo_dma_push/pop_handler try to
> +		 * use dmaengine if possible.
> +		 * It will use pio handler if impossible.
> +		 */
> +		if (usb_endpoint_dir_in(desc)) {
> +			pipe->handler = &usbhs_fifo_dma_push_handler;
> +		} else {
> +			pipe->handler = &usbhs_fifo_dma_pop_handler;
> +			usbhs_xxxsts_clear(priv, BRDYSTS,
> +					   usbhs_pipe_number(pipe));
> +		}
> +
> +		ret = 0;
> +	}
> +
> +usbhsg_ep_enable_end:
> +	usbhs_unlock(priv, flags);
> +
> +	return ret;
> +}
> +
> +static int usbhsg_ep_disable(struct usb_ep *ep)
> +{
> +	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
> +	struct usbhs_pipe *pipe;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uep->lock, flags);
> +	pipe = usbhsg_uep_to_pipe(uep);
> +	if (!pipe)
> +		goto out;
> +
> +	usbhsg_pipe_disable(uep);
> +	usbhs_pipe_free(pipe);
> +
> +	uep->pipe->mod_private	= NULL;
> +	uep->pipe		= NULL;
> +
> +out:
> +	spin_unlock_irqrestore(&uep->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct usb_request *usbhsg_ep_alloc_request(struct usb_ep *ep,
> +						   gfp_t gfp_flags)
> +{
> +	struct usbhsg_request *ureq;
> +
> +	ureq = kzalloc(sizeof *ureq, gfp_flags);
> +	if (!ureq)
> +		return NULL;
> +
> +	usbhs_pkt_init(usbhsg_ureq_to_pkt(ureq));
> +
> +	return &ureq->req;
> +}
> +
> +static void usbhsg_ep_free_request(struct usb_ep *ep,
> +				   struct usb_request *req)
> +{
> +	struct usbhsg_request *ureq = usbhsg_req_to_ureq(req);
> +
> +	WARN_ON(!list_empty(&ureq->pkt.node));
> +	kfree(ureq);
> +}
> +
> +static int usbhsg_ep_queue(struct usb_ep *ep, struct usb_request *req,
> +			  gfp_t gfp_flags)
> +{
> +	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	struct usbhsg_request *ureq = usbhsg_req_to_ureq(req);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> +
> +	/* param check */
> +	if (usbhsg_is_not_connected(gpriv)	||
> +	    unlikely(!gpriv->driver)		||
> +	    unlikely(!pipe))
> +		return -ESHUTDOWN;
> +
> +	usbhsg_queue_push(uep, ureq);
> +
> +	return 0;
> +}
> +
> +static int usbhsg_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
> +	struct usbhsg_request *ureq = usbhsg_req_to_ureq(req);
> +	struct usbhs_pipe *pipe;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uep->lock, flags);
> +	pipe = usbhsg_uep_to_pipe(uep);
> +	if (pipe)
> +		usbhs_pkt_pop(pipe, usbhsg_ureq_to_pkt(ureq));
> +
> +	/*
> +	 * To dequeue a request, this driver should call the usbhsg_queue_pop()
> +	 * even if the pipe is NULL.
> +	 */
> +	usbhsg_queue_pop(uep, ureq, -ECONNRESET);
> +	spin_unlock_irqrestore(&uep->lock, flags);
> +
> +	return 0;
> +}
> +
> +bool usbhs_pipe_contains_transmittable_data(struct usbhs_pipe *pipe);
> +static int __usbhsg_ep_set_halt_wedge(struct usb_ep *ep, int halt, int wedge)
> +{
> +	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
> +	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> +	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
> +	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	dev_dbg(dev, "set halt %d (pipe %d)\n",
> +		halt, usbhs_pipe_number(pipe));
> +
> +	/********************  spin lock ********************/
> +	usbhs_lock(priv, flags);
> +
> +	/*
> +	 * According to usb_ep_set_halt()'s description, this function should
> +	 * return -EAGAIN if the IN endpoint has any queue or data. Note
> +	 * that the usbhs_pipe_is_dir_in() returns false if the pipe is an
> +	 * IN endpoint in the gadget mode.
> +	 */
> +	if (!usbhs_pipe_is_dir_in(pipe) && (__usbhsf_pkt_get(pipe) ||
> +	    usbhs_pipe_contains_transmittable_data(pipe))) {
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +	if (halt)
> +		usbhs_pipe_stall(pipe);
> +	else
> +		usbhs_pipe_disable(pipe);
> +
> +	if (halt && wedge)
> +		usbhsg_status_set(gpriv, USBHSG_STATUS_WEDGE);
> +	else
> +		usbhsg_status_clr(gpriv, USBHSG_STATUS_WEDGE);
> +
> +out:
> +	usbhs_unlock(priv, flags);
> +	/********************  spin unlock ******************/
> +
> +	return ret;
> +}
> +
> +static int usbhsg_ep_set_halt(struct usb_ep *ep, int value)
> +{
> +	return __usbhsg_ep_set_halt_wedge(ep, value, 0);
> +}
> +
> +static int usbhsg_ep_set_wedge(struct usb_ep *ep)
> +{
> +	return __usbhsg_ep_set_halt_wedge(ep, 1, 1);
> +}
> +
> +static const struct usb_ep_ops usbhsg_ep_ops = {
> +	.enable		= usbhsg_ep_enable,
> +	.disable	= usbhsg_ep_disable,
> +
> +	.alloc_request	= usbhsg_ep_alloc_request,
> +	.free_request	= usbhsg_ep_free_request,
> +
> +	.queue		= usbhsg_ep_queue,
> +	.dequeue	= usbhsg_ep_dequeue,
> +
> +	.set_halt	= usbhsg_ep_set_halt,
> +	.set_wedge	= usbhsg_ep_set_wedge,
> +};
> +
> +/*
> + *		pullup control
> + */
> +static int usbhsg_can_pullup(struct usbhs_priv *priv)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +
> +	return gpriv->driver &&
> +	       usbhsg_status_has(gpriv, USBHSG_STATUS_SOFT_CONNECT);
> +}
> +
> +static void usbhsg_update_pullup(struct usbhs_priv *priv)
> +{
> +	if (usbhsg_can_pullup(priv))
> +		usbhs_sys_function_pullup(priv, 1);
> +	else
> +		usbhs_sys_function_pullup(priv, 0);
> +}
> +
> +/*
> + *		usb module start/end
> + */
> +static int usbhsg_try_start(struct usbhs_priv *priv, u32 status)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +	struct usbhsg_uep *dcp = usbhsg_gpriv_to_dcp(gpriv);
> +	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	/********************  spin lock ********************/
> +	usbhs_lock(priv, flags);
> +
> +	usbhsg_status_set(gpriv, status);
> +	if (!(usbhsg_status_has(gpriv, USBHSG_STATUS_STARTED) &&
> +	      usbhsg_status_has(gpriv, USBHSG_STATUS_REGISTERD)))
> +		ret = -1; /* not ready */
> +
> +	usbhs_unlock(priv, flags);
> +	/********************  spin unlock ********************/
> +
> +	if (ret < 0)
> +		return 0; /* not ready is not error */
> +
> +	/*
> +	 * enable interrupt and systems if ready
> +	 */
> +	dev_dbg(dev, "start gadget\n");
> +
> +	/*
> +	 * pipe initialize and enable DCP
> +	 */
> +	usbhs_fifo_init(priv);
> +	usbhs_pipe_init(priv,
> +			usbhsg_dma_map_ctrl);
> +
> +	/* dcp init instead of usbhsg_ep_enable() */
> +	dcp->pipe		= usbhs_dcp_malloc(priv);
> +	dcp->pipe->mod_private	= dcp;
> +	usbhs_pipe_config_update(dcp->pipe, 0, 0, 64);
> +
> +	/*
> +	 * system config enble
> +	 * - HI speed
> +	 * - function
> +	 * - usb module
> +	 */
> +	usbhs_sys_function_ctrl(priv, 1);
> +	usbhsg_update_pullup(priv);
> +
> +	/*
> +	 * enable irq callback
> +	 */
> +	mod->irq_dev_state	= usbhsg_irq_dev_state;
> +	mod->irq_ctrl_stage	= usbhsg_irq_ctrl_stage;
> +	usbhs_irq_callback_update(priv, mod);
> +
> +	return 0;
> +}
> +
> +static int usbhsg_try_stop(struct usbhs_priv *priv, u32 status)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> +	struct usbhsg_uep *uep;
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	unsigned long flags;
> +	int ret = 0, i;
> +
> +	/********************  spin lock ********************/
> +	usbhs_lock(priv, flags);
> +
> +	usbhsg_status_clr(gpriv, status);
> +	if (!usbhsg_status_has(gpriv, USBHSG_STATUS_STARTED) &&
> +	    !usbhsg_status_has(gpriv, USBHSG_STATUS_REGISTERD))
> +		ret = -1; /* already done */
> +
> +	usbhs_unlock(priv, flags);
> +	/********************  spin unlock ********************/
> +
> +	if (ret < 0)
> +		return 0; /* already done is not error */
> +
> +	/*
> +	 * disable interrupt and systems if 1st try
> +	 */
> +	usbhs_fifo_quit(priv);
> +
> +	/* disable all irq */
> +	mod->irq_dev_state	= NULL;
> +	mod->irq_ctrl_stage	= NULL;
> +	usbhs_irq_callback_update(priv, mod);
> +
> +	gpriv->gadget.speed = USB_SPEED_UNKNOWN;
> +
> +	/* disable sys */
> +	usbhs_sys_set_test_mode(priv, 0);
> +	usbhs_sys_function_ctrl(priv, 0);
> +
> +	/* disable all eps */
> +	usbhsg_for_each_uep_with_dcp(uep, gpriv, i)
> +		usbhsg_ep_disable(&uep->ep);
> +
> +	dev_dbg(dev, "stop gadget\n");
> +
> +	return 0;
> +}
> +
> +/*
> + * VBUS provided by the PHY
> + */
> +static void usbhs_mod_phy_mode(struct usbhs_priv *priv)
> +{
> +	struct usbhs_mod_info *info = &priv->mod_info;
> +
> +	info->irq_vbus = NULL;
> +
> +	usbhs_irq_callback_update(priv, NULL);
> +}
> +
> +/*
> + *
> + *		linux usb function
> + *
> + */
> +static int usbhsg_gadget_start(struct usb_gadget *gadget,
> +		struct usb_gadget_driver *driver)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
> +	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
> +
> +	if (!driver || !driver->setup)
> +		return -EINVAL;
> +
> +	/* get vbus using phy versions */
> +	usbhs_mod_phy_mode(priv);
> +
> +	/* first hook up the driver ... */
> +	gpriv->driver = driver;
> +
> +	return usbhsg_try_start(priv, USBHSG_STATUS_REGISTERD);
> +}
> +
> +static int usbhsg_gadget_stop(struct usb_gadget *gadget)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
> +	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
> +
> +	usbhsg_try_stop(priv, USBHSG_STATUS_REGISTERD);
> +
> +	gpriv->driver = NULL;
> +
> +	return 0;
> +}
> +
> +/*
> + *		usb gadget ops
> + */
> +static int usbhsg_get_frame(struct usb_gadget *gadget)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
> +	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
> +
> +	return usbhs_frame_get_num(priv);
> +}
> +
> +static int usbhsg_pullup(struct usb_gadget *gadget, int is_on)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
> +	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
> +	unsigned long flags;
> +
> +	usbhs_lock(priv, flags);
> +	if (is_on)
> +		usbhsg_status_set(gpriv, USBHSG_STATUS_SOFT_CONNECT);
> +	else
> +		usbhsg_status_clr(gpriv, USBHSG_STATUS_SOFT_CONNECT);
> +	usbhsg_update_pullup(priv);
> +	usbhs_unlock(priv, flags);
> +
> +	return 0;
> +}
> +
> +static int usbhsg_set_selfpowered(struct usb_gadget *gadget, int is_self)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
> +
> +	if (is_self)
> +		usbhsg_status_set(gpriv, USBHSG_STATUS_SELF_POWERED);
> +	else
> +		usbhsg_status_clr(gpriv, USBHSG_STATUS_SELF_POWERED);
> +
> +	return 0;
> +}
> +
> +static int usbhsg_vbus_session(struct usb_gadget *gadget, int is_active)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
> +	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
> +
> +	gpriv->vbus_active = !!is_active;
> +
> +	usbhsc_hotplug(priv);
> +
> +	return 0;
> +}
> +
> +static const struct usb_gadget_ops usbhsg_gadget_ops = {
> +	.get_frame		= usbhsg_get_frame,
> +	.set_selfpowered	= usbhsg_set_selfpowered,
> +	.udc_start		= usbhsg_gadget_start,
> +	.udc_stop		= usbhsg_gadget_stop,
> +	.pullup			= usbhsg_pullup,
> +	.vbus_session		= usbhsg_vbus_session,
> +};
> +
> +static int usbhsg_start(struct usbhs_priv *priv)
> +{
> +	return usbhsg_try_start(priv, USBHSG_STATUS_STARTED);
> +}
> +
> +static int usbhsg_stop(struct usbhs_priv *priv)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +
> +	/* cable disconnect */
> +	if (gpriv->driver &&
> +	    gpriv->driver->disconnect)
> +		gpriv->driver->disconnect(&gpriv->gadget);
> +
> +	return usbhsg_try_stop(priv, USBHSG_STATUS_STARTED);
> +}
> +
> +int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
> +{
> +	struct usbhsg_gpriv *gpriv;
> +	struct usbhsg_uep *uep;
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	struct renesas_usbhs_driver_pipe_config *pipe_configs =
> +					usbhs_get_dparam(priv, pipe_configs);
> +	int pipe_size = usbhs_get_dparam(priv, pipe_size);
> +	int i;
> +	int ret;
> +
> +	gpriv = kzalloc(sizeof(struct usbhsg_gpriv), GFP_KERNEL);
> +	if (!gpriv)
> +		return -ENOMEM;
> +
> +	uep = kcalloc(pipe_size, sizeof(struct usbhsg_uep), GFP_KERNEL);
> +	if (!uep) {
> +		ret = -ENOMEM;
> +		goto usbhs_mod_gadget_probe_err_gpriv;
> +	}
> +
> +	/*
> +	 * CAUTION
> +	 *
> +	 * There is no guarantee that it is possible to access usb module here.
> +	 * Don't accesses to it.
> +	 * The accesse will be enable after "usbhsg_start"
> +	 */
> +
> +	/*
> +	 * register itself
> +	 */
> +	usbhs_mod_register(priv, &gpriv->mod, USBHS_GADGET);
> +
> +	/* init gpriv */
> +	gpriv->mod.name		= "gadget";
> +	gpriv->mod.start	= usbhsg_start;
> +	gpriv->mod.stop		= usbhsg_stop;
> +	gpriv->uep		= uep;
> +	gpriv->uep_size		= pipe_size;
> +	usbhsg_status_init(gpriv);
> +
> +	/*
> +	 * init gadget
> +	 */
> +	gpriv->gadget.dev.parent	= dev;
> +	gpriv->gadget.name		= "renesas_usbhs_udc";
> +	gpriv->gadget.ops		= &usbhsg_gadget_ops;
> +	gpriv->gadget.max_speed		= USB_SPEED_HIGH;
> +
> +	INIT_LIST_HEAD(&gpriv->gadget.ep_list);
> +
> +	/*
> +	 * init usb_ep
> +	 */
> +	usbhsg_for_each_uep_with_dcp(uep, gpriv, i) {
> +		uep->gpriv	= gpriv;
> +		uep->pipe	= NULL;
> +		snprintf(uep->ep_name, EP_NAME_SIZE, "ep%d", i);
> +
> +		uep->ep.name		= uep->ep_name;
> +		uep->ep.ops		= &usbhsg_ep_ops;
> +		INIT_LIST_HEAD(&uep->ep.ep_list);
> +		spin_lock_init(&uep->lock);
> +
> +		/* init DCP */
> +		if (usbhsg_is_dcp(uep)) {
> +			gpriv->gadget.ep0 = &uep->ep;
> +			usb_ep_set_maxpacket_limit(&uep->ep, 64);
> +			uep->ep.caps.type_control = true;
> +		} else {
> +			/* init normal pipe */
> +			if (pipe_configs[i].type == USB_ENDPOINT_XFER_ISOC)
> +				uep->ep.caps.type_iso = true;
> +			if (pipe_configs[i].type == USB_ENDPOINT_XFER_BULK)
> +				uep->ep.caps.type_bulk = true;
> +			if (pipe_configs[i].type == USB_ENDPOINT_XFER_INT)
> +				uep->ep.caps.type_int = true;
> +			usb_ep_set_maxpacket_limit(&uep->ep,
> +						   pipe_configs[i].bufsize);
> +			list_add_tail(&uep->ep.ep_list, &gpriv->gadget.ep_list);
> +		}
> +		uep->ep.caps.dir_in = true;
> +		uep->ep.caps.dir_out = true;
> +	}
> +
> +	ret = usb_add_gadget_udc(dev, &gpriv->gadget);
> +	if (ret)
> +		goto err_add_udc;
> +
> +
> +	dev_info(dev, "gadget probed\n");
> +
> +	return 0;
> +
> +err_add_udc:
> +	kfree(gpriv->uep);
> +
> +usbhs_mod_gadget_probe_err_gpriv:
> +	kfree(gpriv);
> +
> +	return ret;
> +}
> +
> +void usbhs_mod_gadget_remove(struct usbhs_priv *priv)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +
> +	usb_del_gadget_udc(&gpriv->gadget);
> +
> +	kfree(gpriv->uep);
> +	kfree(gpriv);
> +}
> +
> +struct usb_gadget *usbhsg_get_gadget(struct usbhs_priv *priv)
> +{
> +	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
> +	return &gpriv->gadget;
> +}
> diff --git a/drivers/usb/gadget/rcar/pipe.c b/drivers/usb/gadget/rcar/pipe.c
> new file mode 100644
> index 00000000000..a2b24f38144
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/pipe.c
> @@ -0,0 +1,849 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#include <linux/delay.h>
> +#include "common.h"
> +#include "pipe.h"
> +
> +/*
> + *		macros
> + */
> +#define usbhsp_addr_offset(p)	((usbhs_pipe_number(p) - 1) * 2)
> +
> +#define usbhsp_flags_set(p, f)	((p)->flags |=  USBHS_PIPE_FLAGS_##f)
> +#define usbhsp_flags_clr(p, f)	((p)->flags &= ~USBHS_PIPE_FLAGS_##f)
> +#define usbhsp_flags_has(p, f)	((p)->flags &   USBHS_PIPE_FLAGS_##f)
> +#define usbhsp_flags_init(p)	do {(p)->flags = 0; } while (0)
> +
> +/*
> + * for debug
> + */
> +static char *usbhsp_pipe_name[] = {
> +	[USB_ENDPOINT_XFER_CONTROL]	= "DCP",
> +	[USB_ENDPOINT_XFER_BULK]	= "BULK",
> +	[USB_ENDPOINT_XFER_INT]		= "INT",
> +	[USB_ENDPOINT_XFER_ISOC]	= "ISO",
> +};
> +
> +char *usbhs_pipe_name(struct usbhs_pipe *pipe)
> +{
> +	return usbhsp_pipe_name[usbhs_pipe_type(pipe)];
> +}
> +
> +static struct renesas_usbhs_driver_pipe_config
> +*usbhsp_get_pipe_config(struct usbhs_priv *priv, int pipe_num)
> +{
> +	struct renesas_usbhs_driver_pipe_config *pipe_configs =
> +					usbhs_get_dparam(priv, pipe_configs);
> +
> +	return &pipe_configs[pipe_num];
> +}
> +
> +/*
> + *		DCPCTR/PIPEnCTR functions
> + */
> +static void usbhsp_pipectrl_set(struct usbhs_pipe *pipe, u16 mask, u16 val)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	int offset = usbhsp_addr_offset(pipe);
> +
> +	if (usbhs_pipe_is_dcp(pipe))
> +		usbhs_bset(priv, DCPCTR, mask, val);
> +	else
> +		usbhs_bset(priv, PIPEnCTR + offset, mask, val);
> +}
> +
> +static u16 usbhsp_pipectrl_get(struct usbhs_pipe *pipe)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	int offset = usbhsp_addr_offset(pipe);
> +
> +	if (usbhs_pipe_is_dcp(pipe))
> +		return usbhs_read(priv, DCPCTR);
> +	else
> +		return usbhs_read(priv, PIPEnCTR + offset);
> +}
> +
> +/*
> + *		DCP/PIPE functions
> + */
> +static void __usbhsp_pipe_xxx_set(struct usbhs_pipe *pipe,
> +				  u16 dcp_reg, u16 pipe_reg,
> +				  u16 mask, u16 val)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +
> +	if (usbhs_pipe_is_dcp(pipe))
> +		usbhs_bset(priv, dcp_reg, mask, val);
> +	else
> +		usbhs_bset(priv, pipe_reg, mask, val);
> +}
> +
> +static u16 __usbhsp_pipe_xxx_get(struct usbhs_pipe *pipe,
> +				 u16 dcp_reg, u16 pipe_reg)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +
> +	if (usbhs_pipe_is_dcp(pipe))
> +		return usbhs_read(priv, dcp_reg);
> +	else
> +		return usbhs_read(priv, pipe_reg);
> +}
> +
> +/*
> + *		DCPCFG/PIPECFG functions
> + */
> +static void usbhsp_pipe_cfg_set(struct usbhs_pipe *pipe, u16 mask, u16 val)
> +{
> +	__usbhsp_pipe_xxx_set(pipe, DCPCFG, PIPECFG, mask, val);
> +}
> +
> +static u16 usbhsp_pipe_cfg_get(struct usbhs_pipe *pipe)
> +{
> +	return __usbhsp_pipe_xxx_get(pipe, DCPCFG, PIPECFG);
> +}
> +
> +/*
> + *		PIPEnTRN/PIPEnTRE functions
> + */
> +static void usbhsp_pipe_trn_set(struct usbhs_pipe *pipe, u16 mask, u16 val)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int num = usbhs_pipe_number(pipe);
> +	u16 reg;
> +
> +	/*
> +	 * It is impossible to calculate address,
> +	 * since PIPEnTRN addresses were mapped randomly.
> +	 */
> +#define CASE_PIPExTRN(a)		\
> +	case 0x ## a:			\
> +		reg = PIPE ## a ## TRN;	\
> +		break;
> +
> +	switch (num) {
> +	CASE_PIPExTRN(1);
> +	CASE_PIPExTRN(2);
> +	CASE_PIPExTRN(3);
> +	CASE_PIPExTRN(4);
> +	CASE_PIPExTRN(5);
> +	CASE_PIPExTRN(B);
> +	CASE_PIPExTRN(C);
> +	CASE_PIPExTRN(D);
> +	CASE_PIPExTRN(E);
> +	CASE_PIPExTRN(F);
> +	CASE_PIPExTRN(9);
> +	CASE_PIPExTRN(A);
> +	default:
> +		dev_err(dev, "unknown pipe (%d)\n", num);
> +		return;
> +	}
> +	__usbhsp_pipe_xxx_set(pipe, 0, reg, mask, val);
> +}
> +
> +static void usbhsp_pipe_tre_set(struct usbhs_pipe *pipe, u16 mask, u16 val)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int num = usbhs_pipe_number(pipe);
> +	u16 reg;
> +
> +	/*
> +	 * It is impossible to calculate address,
> +	 * since PIPEnTRE addresses were mapped randomly.
> +	 */
> +#define CASE_PIPExTRE(a)			\
> +	case 0x ## a:				\
> +		reg = PIPE ## a ## TRE;		\
> +		break;
> +
> +	switch (num) {
> +	CASE_PIPExTRE(1);
> +	CASE_PIPExTRE(2);
> +	CASE_PIPExTRE(3);
> +	CASE_PIPExTRE(4);
> +	CASE_PIPExTRE(5);
> +	CASE_PIPExTRE(B);
> +	CASE_PIPExTRE(C);
> +	CASE_PIPExTRE(D);
> +	CASE_PIPExTRE(E);
> +	CASE_PIPExTRE(F);
> +	CASE_PIPExTRE(9);
> +	CASE_PIPExTRE(A);
> +	default:
> +		dev_err(dev, "unknown pipe (%d)\n", num);
> +		return;
> +	}
> +
> +	__usbhsp_pipe_xxx_set(pipe, 0, reg, mask, val);
> +}
> +
> +/*
> + *		PIPEBUF
> + */
> +static void usbhsp_pipe_buf_set(struct usbhs_pipe *pipe, u16 mask, u16 val)
> +{
> +	if (usbhs_pipe_is_dcp(pipe))
> +		return;
> +
> +	__usbhsp_pipe_xxx_set(pipe, 0, PIPEBUF, mask, val);
> +}
> +
> +/*
> + *		DCPMAXP/PIPEMAXP
> + */
> +static void usbhsp_pipe_maxp_set(struct usbhs_pipe *pipe, u16 mask, u16 val)
> +{
> +	__usbhsp_pipe_xxx_set(pipe, DCPMAXP, PIPEMAXP, mask, val);
> +}
> +
> +/*
> + *		pipe control functions
> + */
> +static void usbhsp_pipe_select(struct usbhs_pipe *pipe)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +
> +	/*
> +	 * On pipe, this is necessary before
> +	 * accesses to below registers.
> +	 *
> +	 * PIPESEL	: usbhsp_pipe_select
> +	 * PIPECFG	: usbhsp_pipe_cfg_xxx
> +	 * PIPEBUF	: usbhsp_pipe_buf_xxx
> +	 * PIPEMAXP	: usbhsp_pipe_maxp_xxx
> +	 * PIPEPERI
> +	 */
> +
> +	/*
> +	 * if pipe is dcp, no pipe is selected.
> +	 * it is no problem, because dcp have its register
> +	 */
> +	usbhs_write(priv, PIPESEL, 0xF & usbhs_pipe_number(pipe));
> +}
> +
> +static int usbhsp_pipe_barrier(struct usbhs_pipe *pipe)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	int timeout = 1024;
> +	u16 mask = usbhs_mod_is_host(priv) ? (CSSTS | PID_MASK) : PID_MASK;
> +
> +	/*
> +	 * make sure....
> +	 *
> +	 * Modify these bits when CSSTS = 0, PID = NAK, and no pipe number is
> +	 * specified by the CURPIPE bits.
> +	 * When changing the setting of this bit after changing
> +	 * the PID bits for the selected pipe from BUF to NAK,
> +	 * check that CSSTS = 0 and PBUSY = 0.
> +	 */
> +
> +	/*
> +	 * CURPIPE bit = 0
> +	 *
> +	 * see also
> +	 *  "Operation"
> +	 *  - "Pipe Control"
> +	 *   - "Pipe Control Registers Switching Procedure"
> +	 */
> +	usbhs_write(priv, CFIFOSEL, 0);
> +	usbhs_pipe_disable(pipe);
> +
> +	do {
> +		if (!(usbhsp_pipectrl_get(pipe) & mask))
> +			return 0;
> +
> +		udelay(10);
> +
> +	} while (timeout--);
> +
> +	return -EBUSY;
> +}
> +
> +int usbhs_pipe_is_accessible(struct usbhs_pipe *pipe)
> +{
> +	u16 val;
> +
> +	val = usbhsp_pipectrl_get(pipe);
> +	if (val & BSTS)
> +		return 0;
> +
> +	return -EBUSY;
> +}
> +
> +bool usbhs_pipe_contains_transmittable_data(struct usbhs_pipe *pipe)
> +{
> +	u16 val;
> +
> +	/* Do not support for DCP pipe */
> +	if (usbhs_pipe_is_dcp(pipe))
> +		return false;
> +
> +	val = usbhsp_pipectrl_get(pipe);
> +	if (val & INBUFM)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + *		PID ctrl
> + */
> +static void __usbhsp_pid_try_nak_if_stall(struct usbhs_pipe *pipe)
> +{
> +	u16 pid = usbhsp_pipectrl_get(pipe);
> +
> +	pid &= PID_MASK;
> +
> +	/*
> +	 * see
> +	 * "Pipe n Control Register" - "PID"
> +	 */
> +	switch (pid) {
> +	case PID_STALL11:
> +		usbhsp_pipectrl_set(pipe, PID_MASK, PID_STALL10);
> +		fallthrough;
> +	case PID_STALL10:
> +		usbhsp_pipectrl_set(pipe, PID_MASK, PID_NAK);
> +	}
> +}
> +
> +void usbhs_pipe_disable(struct usbhs_pipe *pipe)
> +{
> +	int timeout = 1024;
> +	u16 val;
> +
> +	/* see "Pipe n Control Register" - "PID" */
> +	__usbhsp_pid_try_nak_if_stall(pipe);
> +
> +	usbhsp_pipectrl_set(pipe, PID_MASK, PID_NAK);
> +
> +	do {
> +		val  = usbhsp_pipectrl_get(pipe);
> +		val &= PBUSY;
> +		if (!val)
> +			break;
> +
> +		udelay(10);
> +	} while (timeout--);
> +}
> +
> +void usbhs_pipe_enable(struct usbhs_pipe *pipe)
> +{
> +	/* see "Pipe n Control Register" - "PID" */
> +	__usbhsp_pid_try_nak_if_stall(pipe);
> +
> +	usbhsp_pipectrl_set(pipe, PID_MASK, PID_BUF);
> +}
> +
> +void usbhs_pipe_stall(struct usbhs_pipe *pipe)
> +{
> +	u16 pid = usbhsp_pipectrl_get(pipe);
> +
> +	pid &= PID_MASK;
> +
> +	/*
> +	 * see
> +	 * "Pipe n Control Register" - "PID"
> +	 */
> +	switch (pid) {
> +	case PID_NAK:
> +		usbhsp_pipectrl_set(pipe, PID_MASK, PID_STALL10);
> +		break;
> +	case PID_BUF:
> +		usbhsp_pipectrl_set(pipe, PID_MASK, PID_STALL11);
> +		break;
> +	}
> +}
> +
> +int usbhs_pipe_is_stall(struct usbhs_pipe *pipe)
> +{
> +	u16 pid = usbhsp_pipectrl_get(pipe) & PID_MASK;
> +
> +	return (int)(pid == PID_STALL10 || pid == PID_STALL11);
> +}
> +
> +void usbhs_pipe_set_trans_count_if_bulk(struct usbhs_pipe *pipe, int len)
> +{
> +	if (!usbhs_pipe_type_is(pipe, USB_ENDPOINT_XFER_BULK))
> +		return;
> +
> +	/*
> +	 * clear and disable transfer counter for IN/OUT pipe
> +	 */
> +	usbhsp_pipe_tre_set(pipe, TRCLR | TRENB, TRCLR);
> +
> +	/*
> +	 * Only IN direction bulk pipe can use transfer count.
> +	 * Without using this function,
> +	 * received data will break if it was large data size.
> +	 * see PIPEnTRN/PIPEnTRE for detail
> +	 */
> +	if (usbhs_pipe_is_dir_in(pipe)) {
> +		int maxp = usbhs_pipe_get_maxpacket(pipe);
> +
> +		usbhsp_pipe_trn_set(pipe, 0xffff, DIV_ROUND_UP(len, maxp));
> +		usbhsp_pipe_tre_set(pipe, TRENB, TRENB); /* enable */
> +	}
> +}
> +
> +
> +/*
> + *		pipe setup
> + */
> +static int usbhsp_setup_pipecfg(struct usbhs_pipe *pipe, int is_host,
> +				int dir_in, u16 *pipecfg)
> +{
> +	u16 type = 0;
> +	u16 bfre = 0;
> +	u16 dblb = 0;
> +	u16 cntmd = 0;
> +	u16 dir = 0;
> +	u16 epnum = 0;
> +	u16 shtnak = 0;
> +	static const u16 type_array[] = {
> +		[USB_ENDPOINT_XFER_BULK] = TYPE_BULK,
> +		[USB_ENDPOINT_XFER_INT]  = TYPE_INT,
> +		[USB_ENDPOINT_XFER_ISOC] = TYPE_ISO,
> +	};
> +
> +	if (usbhs_pipe_is_dcp(pipe))
> +		return -EINVAL;
> +
> +	/*
> +	 * PIPECFG
> +	 *
> +	 * see
> +	 *  - "Register Descriptions" - "PIPECFG" register
> +	 *  - "Features"  - "Pipe configuration"
> +	 *  - "Operation" - "Pipe Control"
> +	 */
> +
> +	/* TYPE */
> +	type = type_array[usbhs_pipe_type(pipe)];
> +
> +	/* BFRE */
> +	if (usbhs_pipe_type_is(pipe, USB_ENDPOINT_XFER_ISOC) ||
> +	    usbhs_pipe_type_is(pipe, USB_ENDPOINT_XFER_BULK))
> +		bfre = 0; /* FIXME */
> +
> +	/* DBLB: see usbhs_pipe_config_update() */
> +
> +	/* CNTMD */
> +	if (usbhs_pipe_type_is(pipe, USB_ENDPOINT_XFER_BULK))
> +		cntmd = 0; /* FIXME */
> +
> +	/* DIR */
> +	if (dir_in)
> +		usbhsp_flags_set(pipe, IS_DIR_HOST);
> +
> +	if (!!is_host ^ !!dir_in)
> +		dir |= DIR_OUT;
> +
> +	if (!dir)
> +		usbhsp_flags_set(pipe, IS_DIR_IN);
> +
> +	/* SHTNAK */
> +	if (usbhs_pipe_type_is(pipe, USB_ENDPOINT_XFER_BULK) &&
> +	    !dir)
> +		shtnak = SHTNAK;
> +
> +	/* EPNUM */
> +	epnum = 0; /* see usbhs_pipe_config_update() */
> +	*pipecfg = type		|
> +		   bfre		|
> +		   dblb		|
> +		   cntmd	|
> +		   dir		|
> +		   shtnak	|
> +		   epnum;
> +	return 0;
> +}
> +
> +static u16 usbhsp_setup_pipebuff(struct usbhs_pipe *pipe)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	int pipe_num = usbhs_pipe_number(pipe);
> +	u16 buff_size;
> +	u16 bufnmb;
> +	u16 bufnmb_cnt;
> +	struct renesas_usbhs_driver_pipe_config *pipe_config =
> +					usbhsp_get_pipe_config(priv, pipe_num);
> +
> +	/*
> +	 * PIPEBUF
> +	 *
> +	 * see
> +	 *  - "Register Descriptions" - "PIPEBUF" register
> +	 *  - "Features"  - "Pipe configuration"
> +	 *  - "Operation" - "FIFO Buffer Memory"
> +	 *  - "Operation" - "Pipe Control"
> +	 */
> +	buff_size = pipe_config->bufsize;
> +	bufnmb = pipe_config->bufnum;
> +
> +	/* change buff_size to register value */
> +	bufnmb_cnt = (buff_size / 64) - 1;
> +
> +	dev_dbg(dev, "pipe : %d : buff_size 0x%x: bufnmb 0x%x\n",
> +		pipe_num, buff_size, bufnmb);
> +
> +	return	(0x1f & bufnmb_cnt)	<< 10 |
> +		(0xff & bufnmb)		<<  0;
> +}
> +
> +void usbhs_pipe_config_update(struct usbhs_pipe *pipe, u16 devsel,
> +			      u16 epnum, u16 maxp)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +	int pipe_num = usbhs_pipe_number(pipe);
> +	struct renesas_usbhs_driver_pipe_config *pipe_config =
> +					usbhsp_get_pipe_config(priv, pipe_num);
> +	u16 dblb = pipe_config->double_buf ? DBLB : 0;
> +
> +	if (devsel > 0xA) {
> +		struct device *dev = usbhs_priv_to_dev(priv);
> +
> +		dev_err(dev, "devsel error %d\n", devsel);
> +
> +		devsel = 0;
> +	}
> +
> +	usbhsp_pipe_barrier(pipe);
> +
> +	pipe->maxp = maxp;
> +
> +	usbhsp_pipe_select(pipe);
> +	usbhsp_pipe_maxp_set(pipe, 0xFFFF,
> +			     (devsel << 12) |
> +			     maxp);
> +
> +	if (!usbhs_pipe_is_dcp(pipe))
> +		usbhsp_pipe_cfg_set(pipe,  0x000F | DBLB, epnum | dblb);
> +}
> +
> +/*
> + *		pipe control
> + */
> +int usbhs_pipe_get_maxpacket(struct usbhs_pipe *pipe)
> +{
> +	/*
> +	 * see
> +	 *	usbhs_pipe_config_update()
> +	 *	usbhs_dcp_malloc()
> +	 */
> +	return pipe->maxp;
> +}
> +
> +int usbhs_pipe_is_dir_in(struct usbhs_pipe *pipe)
> +{
> +	return usbhsp_flags_has(pipe, IS_DIR_IN);
> +}
> +
> +int usbhs_pipe_is_dir_host(struct usbhs_pipe *pipe)
> +{
> +	return usbhsp_flags_has(pipe, IS_DIR_HOST);
> +}
> +
> +int usbhs_pipe_is_running(struct usbhs_pipe *pipe)
> +{
> +	return usbhsp_flags_has(pipe, IS_RUNNING);
> +}
> +
> +void usbhs_pipe_running(struct usbhs_pipe *pipe, int running)
> +{
> +	if (running)
> +		usbhsp_flags_set(pipe, IS_RUNNING);
> +	else
> +		usbhsp_flags_clr(pipe, IS_RUNNING);
> +}
> +
> +void usbhs_pipe_data_sequence(struct usbhs_pipe *pipe, int sequence)
> +{
> +	u16 mask = (SQCLR | SQSET);
> +	u16 val;
> +
> +	/*
> +	 * sequence
> +	 *  0  : data0
> +	 *  1  : data1
> +	 *  -1 : no change
> +	 */
> +	switch (sequence) {
> +	case 0:
> +		val = SQCLR;
> +		break;
> +	case 1:
> +		val = SQSET;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	usbhsp_pipectrl_set(pipe, mask, val);
> +}
> +
> +static int usbhs_pipe_get_data_sequence(struct usbhs_pipe *pipe)
> +{
> +	return !!(usbhsp_pipectrl_get(pipe) & SQMON);
> +}
> +
> +void usbhs_pipe_clear(struct usbhs_pipe *pipe)
> +{
> +	if (usbhs_pipe_is_dcp(pipe)) {
> +		usbhs_fifo_clear_dcp(pipe);
> +	} else {
> +		usbhsp_pipectrl_set(pipe, ACLRM, ACLRM);
> +		usbhsp_pipectrl_set(pipe, ACLRM, 0);
> +	}
> +}
> +
> +/* Should call usbhsp_pipe_select() before */
> +void usbhs_pipe_clear_without_sequence(struct usbhs_pipe *pipe,
> +				       int needs_bfre, int bfre_enable)
> +{
> +	int sequence;
> +
> +	usbhsp_pipe_select(pipe);
> +	sequence = usbhs_pipe_get_data_sequence(pipe);
> +	if (needs_bfre)
> +		usbhsp_pipe_cfg_set(pipe, BFRE, bfre_enable ? BFRE : 0);
> +	usbhs_pipe_clear(pipe);
> +	usbhs_pipe_data_sequence(pipe, sequence);
> +}
> +
> +void usbhs_pipe_config_change_bfre(struct usbhs_pipe *pipe, int enable)
> +{
> +	if (usbhs_pipe_is_dcp(pipe))
> +		return;
> +
> +	usbhsp_pipe_select(pipe);
> +	/* check if the driver needs to change the BFRE value */
> +	if (!(enable ^ !!(usbhsp_pipe_cfg_get(pipe) & BFRE)))
> +		return;
> +
> +	usbhs_pipe_clear_without_sequence(pipe, 1, enable);
> +}
> +
> +static struct usbhs_pipe *usbhsp_get_pipe(struct usbhs_priv *priv, u32 type)
> +{
> +	struct usbhs_pipe *pos, *pipe;
> +	int i;
> +
> +	/*
> +	 * find target pipe
> +	 */
> +	pipe = NULL;
> +	usbhs_for_each_pipe_with_dcp(pos, priv, i) {
> +		if (!usbhs_pipe_type_is(pos, type))
> +			continue;
> +		if (usbhsp_flags_has(pos, IS_USED))
> +			continue;
> +
> +		pipe = pos;
> +		break;
> +	}
> +
> +	if (!pipe)
> +		return NULL;
> +
> +	/*
> +	 * initialize pipe flags
> +	 */
> +	usbhsp_flags_init(pipe);
> +	usbhsp_flags_set(pipe, IS_USED);
> +
> +	return pipe;
> +}
> +
> +static void usbhsp_put_pipe(struct usbhs_pipe *pipe)
> +{
> +	usbhsp_flags_init(pipe);
> +}
> +
> +void usbhs_pipe_init(struct usbhs_priv *priv,
> +		     int (*dma_map_ctrl)(struct usbhs_pkt *pkt, int map))
> +{
> +	struct usbhs_pipe_info *info = usbhs_priv_to_pipeinfo(priv);
> +	struct usbhs_pipe *pipe;
> +	int i;
> +
> +	usbhs_for_each_pipe_with_dcp(pipe, priv, i) {
> +		usbhsp_flags_init(pipe);
> +		pipe->fifo = NULL;
> +		pipe->mod_private = NULL;
> +		INIT_LIST_HEAD(&pipe->list);
> +
> +		/* pipe force init */
> +		usbhs_pipe_clear(pipe);
> +	}
> +
> +	info->dma_map_ctrl = dma_map_ctrl;
> +}
> +
> +struct usbhs_pipe *usbhs_pipe_malloc(struct usbhs_priv *priv,
> +				     int endpoint_type,
> +				     int dir_in)
> +{
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	struct usbhs_pipe *pipe;
> +	int is_host = usbhs_mod_is_host(priv);
> +	int ret;
> +	u16 pipecfg, pipebuf;
> +
> +	pipe = usbhsp_get_pipe(priv, endpoint_type);
> +	if (!pipe) {
> +		dev_err(dev, "can't get pipe (%s)\n",
> +			usbhsp_pipe_name[endpoint_type]);
> +		return NULL;
> +	}
> +
> +	INIT_LIST_HEAD(&pipe->list);
> +
> +	usbhs_pipe_disable(pipe);
> +
> +	/* make sure pipe is not busy */
> +	ret = usbhsp_pipe_barrier(pipe);
> +	if (ret < 0) {
> +		dev_err(dev, "pipe setup failed %d\n", usbhs_pipe_number(pipe));
> +		return NULL;
> +	}
> +
> +	if (usbhsp_setup_pipecfg(pipe, is_host, dir_in, &pipecfg)) {
> +		dev_err(dev, "can't setup pipe\n");
> +		return NULL;
> +	}
> +
> +	pipebuf  = usbhsp_setup_pipebuff(pipe);
> +
> +	usbhsp_pipe_select(pipe);
> +	usbhsp_pipe_cfg_set(pipe, 0xFFFF, pipecfg);
> +	usbhsp_pipe_buf_set(pipe, 0xFFFF, pipebuf);
> +	usbhs_pipe_clear(pipe);
> +
> +	usbhs_pipe_sequence_data0(pipe);
> +
> +	dev_dbg(dev, "enable pipe %d : %s (%s)\n",
> +		usbhs_pipe_number(pipe),
> +		usbhs_pipe_name(pipe),
> +		usbhs_pipe_is_dir_in(pipe) ? "in" : "out");
> +
> +	/*
> +	 * epnum / maxp are still not set to this pipe.
> +	 * call usbhs_pipe_config_update() after this function !!
> +	 */
> +
> +	return pipe;
> +}
> +
> +void usbhs_pipe_free(struct usbhs_pipe *pipe)
> +{
> +	usbhsp_pipe_select(pipe);
> +	usbhsp_pipe_cfg_set(pipe, 0xFFFF, 0);
> +	usbhsp_put_pipe(pipe);
> +}
> +
> +void usbhs_pipe_select_fifo(struct usbhs_pipe *pipe, struct usbhs_fifo *fifo)
> +{
> +	if (pipe->fifo)
> +		pipe->fifo->pipe = NULL;
> +
> +	pipe->fifo = fifo;
> +
> +	if (fifo)
> +		fifo->pipe = pipe;
> +}
> +
> +
> +/*
> + *		dcp control
> + */
> +struct usbhs_pipe *usbhs_dcp_malloc(struct usbhs_priv *priv)
> +{
> +	struct usbhs_pipe *pipe;
> +
> +	pipe = usbhsp_get_pipe(priv, USB_ENDPOINT_XFER_CONTROL);
> +	if (!pipe)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&pipe->list);
> +
> +	/*
> +	 * call usbhs_pipe_config_update() after this function !!
> +	 */
> +
> +	return pipe;
> +}
> +
> +void usbhs_dcp_control_transfer_done(struct usbhs_pipe *pipe)
> +{
> +	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
> +
> +	WARN_ON(!usbhs_pipe_is_dcp(pipe));
> +
> +	usbhs_pipe_enable(pipe);
> +
> +	if (!usbhs_mod_is_host(priv)) /* funconly */
> +		usbhsp_pipectrl_set(pipe, CCPL, CCPL);
> +}
> +
> +void usbhs_dcp_dir_for_host(struct usbhs_pipe *pipe, int dir_out)
> +{
> +	usbhsp_pipe_cfg_set(pipe, DIR_OUT,
> +			    dir_out ? DIR_OUT : 0);
> +}
> +
> +/*
> + *		pipe module function
> + */
> +int usbhs_pipe_probe(struct usbhs_priv *priv)
> +{
> +	struct usbhs_pipe_info *info = usbhs_priv_to_pipeinfo(priv);
> +	struct usbhs_pipe *pipe;
> +	struct device *dev = usbhs_priv_to_dev(priv);
> +	struct renesas_usbhs_driver_pipe_config *pipe_configs =
> +					usbhs_get_dparam(priv, pipe_configs);
> +	int pipe_size = usbhs_get_dparam(priv, pipe_size);
> +	int i;
> +
> +	/* This driver expects 1st pipe is DCP */
> +	if (pipe_configs[0].type != USB_ENDPOINT_XFER_CONTROL) {
> +		dev_err(dev, "1st PIPE is not DCP\n");
> +		return -EINVAL;
> +	}
> +
> +	info->pipe = kcalloc(pipe_size, sizeof(struct usbhs_pipe),
> +			     GFP_KERNEL);
> +	if (!info->pipe)
> +		return -ENOMEM;
> +
> +	info->size = pipe_size;
> +
> +	/*
> +	 * init pipe
> +	 */
> +	usbhs_for_each_pipe_with_dcp(pipe, priv, i) {
> +		pipe->priv = priv;
> +
> +		usbhs_pipe_type(pipe) =
> +			pipe_configs[i].type & USB_ENDPOINT_XFERTYPE_MASK;
> +
> +		dev_dbg(dev, "pipe %x\t: %s\n",
> +			i, usbhsp_pipe_name[pipe_configs[i].type]);
> +	}
> +
> +	return 0;
> +}
> +
> +void usbhs_pipe_remove(struct usbhs_priv *priv)
> +{
> +	struct usbhs_pipe_info *info = usbhs_priv_to_pipeinfo(priv);
> +
> +	kfree(info->pipe);
> +}
> diff --git a/drivers/usb/gadget/rcar/pipe.h b/drivers/usb/gadget/rcar/pipe.h
> new file mode 100644
> index 00000000000..01c15178a28
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/pipe.h
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * Renesas USB driver
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#ifndef RENESAS_USB_PIPE_H
> +#define RENESAS_USB_PIPE_H
> +
> +#include "common.h"
> +#include "fifo.h"
> +
> +/*
> + *	struct
> + */
> +struct usbhs_pipe {
> +	u32 pipe_type;	/* USB_ENDPOINT_XFER_xxx */
> +
> +	struct usbhs_priv *priv;
> +	struct usbhs_fifo *fifo;
> +	struct list_head list;
> +
> +	int maxp;
> +
> +	u32 flags;
> +#define USBHS_PIPE_FLAGS_IS_USED		(1 << 0)
> +#define USBHS_PIPE_FLAGS_IS_DIR_IN		(1 << 1)
> +#define USBHS_PIPE_FLAGS_IS_DIR_HOST		(1 << 2)
> +#define USBHS_PIPE_FLAGS_IS_RUNNING		(1 << 3)
> +
> +	const struct usbhs_pkt_handle *handler;
> +
> +	void *mod_private;
> +};
> +
> +struct usbhs_pipe_info {
> +	struct usbhs_pipe *pipe;
> +	int size;	/* array size of "pipe" */
> +
> +	int (*dma_map_ctrl)(struct usbhs_pkt *pkt, int map);
> +};
> +
> +/*
> + * pipe list
> + */
> +#define __usbhs_for_each_pipe(start, pos, info, i)	\
> +	for ((i) = start;						\
> +	     ((i) < (info)->size) && ((pos) = (info)->pipe + (i));	\
> +	     (i)++)
> +
> +#define usbhs_for_each_pipe(pos, priv, i)			\
> +	__usbhs_for_each_pipe(1, pos, &((priv)->pipe_info), i)
> +
> +#define usbhs_for_each_pipe_with_dcp(pos, priv, i)		\
> +	__usbhs_for_each_pipe(0, pos, &((priv)->pipe_info), i)
> +
> +/*
> + * data
> + */
> +#define usbhs_priv_to_pipeinfo(pr)	(&(pr)->pipe_info)
> +
> +/*
> + * pipe control
> + */
> +char *usbhs_pipe_name(struct usbhs_pipe *pipe);
> +struct usbhs_pipe
> +*usbhs_pipe_malloc(struct usbhs_priv *priv, int endpoint_type, int dir_in);
> +void usbhs_pipe_free(struct usbhs_pipe *pipe);
> +int usbhs_pipe_probe(struct usbhs_priv *priv);
> +void usbhs_pipe_remove(struct usbhs_priv *priv);
> +int usbhs_pipe_is_dir_in(struct usbhs_pipe *pipe);
> +int usbhs_pipe_is_dir_host(struct usbhs_pipe *pipe);
> +int usbhs_pipe_is_running(struct usbhs_pipe *pipe);
> +void usbhs_pipe_running(struct usbhs_pipe *pipe, int running);
> +
> +void usbhs_pipe_init(struct usbhs_priv *priv,
> +		     int (*dma_map_ctrl)(struct usbhs_pkt *pkt, int map));
> +int usbhs_pipe_get_maxpacket(struct usbhs_pipe *pipe);
> +void usbhs_pipe_clear(struct usbhs_pipe *pipe);
> +void usbhs_pipe_clear_without_sequence(struct usbhs_pipe *pipe,
> +				       int needs_bfre, int bfre_enable);
> +int usbhs_pipe_is_accessible(struct usbhs_pipe *pipe);
> +void usbhs_pipe_enable(struct usbhs_pipe *pipe);
> +void usbhs_pipe_disable(struct usbhs_pipe *pipe);
> +void usbhs_pipe_stall(struct usbhs_pipe *pipe);
> +int usbhs_pipe_is_stall(struct usbhs_pipe *pipe);
> +void usbhs_pipe_set_trans_count_if_bulk(struct usbhs_pipe *pipe, int len);
> +void usbhs_pipe_select_fifo(struct usbhs_pipe *pipe, struct usbhs_fifo *fifo);
> +void usbhs_pipe_config_update(struct usbhs_pipe *pipe, u16 devsel,
> +			      u16 epnum, u16 maxp);
> +void usbhs_pipe_config_change_bfre(struct usbhs_pipe *pipe, int enable);
> +
> +#define usbhs_pipe_sequence_data0(pipe)	usbhs_pipe_data_sequence(pipe, 0)
> +#define usbhs_pipe_sequence_data1(pipe)	usbhs_pipe_data_sequence(pipe, 1)
> +void usbhs_pipe_data_sequence(struct usbhs_pipe *pipe, int data);
> +
> +#define usbhs_pipe_to_priv(p)	((p)->priv)
> +#define usbhs_pipe_number(p)	(int)((p) - (p)->priv->pipe_info.pipe)
> +#define usbhs_pipe_is_dcp(p)	((p)->priv->pipe_info.pipe == (p))
> +#define usbhs_pipe_to_fifo(p)	((p)->fifo)
> +#define usbhs_pipe_is_busy(p)	usbhs_pipe_to_fifo(p)
> +
> +#define usbhs_pipe_type(p)		((p)->pipe_type)
> +#define usbhs_pipe_type_is(p, t)	((p)->pipe_type == t)
> +
> +/*
> + * dcp control
> + */
> +struct usbhs_pipe *usbhs_dcp_malloc(struct usbhs_priv *priv);
> +void usbhs_dcp_control_transfer_done(struct usbhs_pipe *pipe);
> +void usbhs_dcp_dir_for_host(struct usbhs_pipe *pipe, int dir_out);
> +
> +#endif /* RENESAS_USB_PIPE_H */
> diff --git a/drivers/usb/gadget/rcar/renesas_usb.h b/drivers/usb/gadget/rcar/renesas_usb.h
> new file mode 100644
> index 00000000000..8155e3dcaf6
> --- /dev/null
> +++ b/drivers/usb/gadget/rcar/renesas_usb.h
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * Renesas USB
> + *
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + *
> + * Ported to u-boot
> + * Copyright (C) 2016 GlobalLogic
> + */
> +#ifndef RENESAS_USB_H
> +#define RENESAS_USB_H
> +
> +#include <linux/usb/ch9.h>
> +#include <linux/compat.h>
> +
> +struct platform_device {
> +	const char	*name;
> +	struct device	dev;
> +};
> +
> +/*
> + * module type
> + *
> + * it will be return value from get_id
> + */
> +enum {
> +	USBHS_HOST = 0,
> +	USBHS_GADGET,
> +	USBHS_MAX,
> +};
> +
> +/*
> + * parameters for renesas usbhs
> + *
> + * some register needs USB chip specific parameters.
> + * This struct show it to driver
> + */
> +
> +struct renesas_usbhs_driver_pipe_config {
> +	u8 type;	/* USB_ENDPOINT_XFER_xxx */
> +	u16 bufsize;
> +	u8 bufnum;
> +	bool double_buf;
> +};
> +#define RENESAS_USBHS_PIPE(_type, _size, _num, _double_buf)	{	\
> +			.type = (_type),		\
> +			.bufsize = (_size),		\
> +			.bufnum = (_num),		\
> +			.double_buf = (_double_buf),	\
> +	}
> +
> +struct renesas_usbhs_driver_param {
> +	/*
> +	 * pipe settings
> +	 */
> +	struct renesas_usbhs_driver_pipe_config *pipe_configs;
> +	int pipe_size; /* pipe_configs array size */
> +
> +	/*
> +	 * option:
> +	 *
> +	 * for BUSWAIT :: BWAIT
> +	 * see
> +	 *	renesas_usbhs/common.c :: usbhsc_set_buswait()
> +	 * */
> +	int buswait_bwait;
> +
> +	/*
> +	 * option:
> +	 *
> +	 * delay time from notify_hotplug callback
> +	 */
> +	int detection_delay; /* msec */
> +
> +	/*
> +	 * option:
> +	 *
> +	 * dma id for dmaengine
> +	 * The data transfer direction on D0FIFO/D1FIFO should be
> +	 * fixed for keeping consistency.
> +	 * So, the platform id settings will be..
> +	 *	.d0_tx_id = xx_TX,
> +	 *	.d1_rx_id = xx_RX,
> +	 * or
> +	 *	.d1_tx_id = xx_TX,
> +	 *	.d0_rx_id = xx_RX,
> +	 */
> +	int d0_tx_id;
> +	int d0_rx_id;
> +	int d1_tx_id;
> +	int d1_rx_id;
> +	int d2_tx_id;
> +	int d2_rx_id;
> +	int d3_tx_id;
> +	int d3_rx_id;
> +
> +	/*
> +	 * option:
> +	 *
> +	 * pio <--> dma border.
> +	 */
> +	int pio_dma_border; /* default is 64byte */
> +
> +	uintptr_t type;
> +	u32 enable_gpio;
> +
> +	/*
> +	 * option:
> +	 */
> +	u32 has_otg:1; /* for controlling PWEN/EXTLP */
> +	u32 has_sudmac:1; /* for SUDMAC */
> +	u32 has_usb_dmac:1; /* for USB-DMAC */
> +	u32 cfifo_byte_addr:1; /* CFIFO is byte addressable */
> +#define USBHS_USB_DMAC_XFER_SIZE	32	/* hardcode the xfer size */
> +	u32 multi_clks:1;
> +	u32 has_new_pipe_configs:1;
> +};
> +
> +#define USBHS_TYPE_RCAR_GEN3		2
> +
> +struct usbhs_priv;
> +struct usb_gadget *usbhsg_get_gadget(struct usbhs_priv *priv);
> +
> +#endif /* RENESAS_USB_H */
> -- 
> 2.45.2
