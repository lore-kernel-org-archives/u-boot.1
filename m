Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11338C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0F880283;
	Thu, 16 Jan 2025 10:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xZMYSU8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D858069D; Thu, 16 Jan 2025 10:22:08 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D58801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso5929905e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737019325; x=1737624125;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aOZduFlq2ysVRVptfK08SUzGmHbwgRPtzTZqSh8eYHQ=;
 b=xZMYSU8TwGnwnCz6QyUaAbftQ2QwjInT0Hzw4+4ZrSoHyBDpXUNt6hdJzIlTotbHLM
 HNZ4744KoZGHUmhc574s0T73/SS7Ri9j7xL/hv5VjwuaYESQsM0XLGrX4YDhKd08RL/W
 jaQ7JO1sJeR6FINr0Wck7M0qVkFNTj/8LaZGVWLymOmKFhlT1vUSiineOzozX7PyLFy0
 TxHd6Mo+UJSN2telppGinKvNrQL0cFlUd65LaWwe9Q+DqqFqWMggbljh9DAml9BejOXX
 PLG8sYs+sH6q5p+FgnJxqI0/wxRRNvI+kTrPsjEFtsTG24nepmk6pQP1RsJCJ4PWjgmu
 A/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737019325; x=1737624125;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aOZduFlq2ysVRVptfK08SUzGmHbwgRPtzTZqSh8eYHQ=;
 b=dcyuT46AiK5b45drqJH4mQEu4s9/GFlu3RpZMSjuW5oIM6ugPdE/2QTRHLqZVrGy5e
 uzuNDIQ8qLCH4I2jqWImn1ZACMoV4y9G4VMywuNC0fx4iLQXWV6JbGAkrqlDJOrr73TU
 yWMdMh6hKkuX5qCdB2vp7DnharuubxhEp3Rgk3l2QzvLRSXe684VduMzxuuhTNosC9s7
 Q70POFaaibDOF0VSwomZMIuxVF4WNeCwMXUFgvEKoN54mQGQPGT0pyJ86+9RBE9XI3+k
 3dfO7pbGPxgg1bwhgMhnCkV0MdUDb+tfd9Y8eHztpmdPL3V6JuKymUaM2weZB2HowU8x
 m04A==
X-Gm-Message-State: AOJu0YxlKPflg5dVutNOybWMl/NK6aaW9NzYej9QGRwuI/5DEc2XAK5z
 wuBWuP2KXFJSQJCOCU4ZYrc1WT4BwTuyzc6SDB8OiWyzWF84Y2ReKvnH1+23vFI=
X-Gm-Gg: ASbGncvX0BckmsXBILIi/PdIeH+mYDi6sCaIbWGr2SkAJLfTfsuAy5HvddRp9gX/ujB
 4T1QFb5y5noO0FQIcx1UUovTw45Y/+GwKRAzd0GAzwfcjLMwbxZEE4HxU6+wcga0jCxoL8KXsdM
 IQMHMteF6pkX8g/hjFcGj8Dk6Nbr8gws3RaP735QhsM7L7x2bNoThwULbE3XbS2bsCTdK4K45T/
 rekeYlZF8aVLigBsTLlCfWHw2oXo4APa07h9teYLUBY3Q39GLxJ9OKxpfurY4fnjw==
X-Google-Smtp-Source: AGHT+IEqOGeu0XDk8MCD0OAhxzG3t+yr6qUg1yq9njcG8vKAx3ARHuPfjPhVtDi1DGJUXhJEIiWYqw==
X-Received: by 2002:a05:600c:4455:b0:434:f623:a004 with SMTP id
 5b1f17b1804b1-436e26adfd8mr4846205e9.16.1737019325543; 
 Thu, 16 Jan 2025 01:22:05 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e3b97sm51548035e9.32.2025.01.16.01.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:22:05 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com,
 junhui.liu@pigmoral.tech
Subject: Re: [PATCH v4 7/8] usb: dwc2: Unify flush and reset logic with
 v4.20a support
In-Reply-To: <20250110-dwc2-dev-v4-7-987f4fd6f8b2@pigmoral.tech>
References: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
 <20250110-dwc2-dev-v4-7-987f4fd6f8b2@pigmoral.tech>
Date: Thu, 16 Jan 2025 10:22:04 +0100
Message-ID: <87ldvb866b.fsf@baylibre.com>
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

Hi Junhui,

Thank you for the patch.

On ven., janv. 10, 2025 at 21:55, Junhui Liu <junhui.liu@pigmoral.tech> wrote:

> From: Kongyang Liu <seashell11234455@gmail.com>
>
> This patch merges flush and reset logic for both host and gadget code
> into a common set of functions, reducing duplication. It also adds support
> for the updated reset logic to compatible with core version since v4.20a.
>
> This patch mainly refers to the patch in the kernel.
> link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> ---
> This commit does not add the handling of ret returned from the
> dwc2_core_reset, dwc2_flush_tx_fifo and dwc2_flush_rx_fifo, because this
> may involve changes to the code logic, I think this should be a separate
> patch to handle with it.
> ---
>  drivers/usb/common/Makefile                |   2 +
>  drivers/usb/common/dwc2_core.c             | 131 +++++++++++++++++++++++++++++
>  drivers/usb/common/dwc2_core.h             |   4 +
>  drivers/usb/gadget/dwc2_udc_otg.c          |  12 +--
>  drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c |   6 +-
>  drivers/usb/host/dwc2.c                    |  80 +-----------------
>  6 files changed, 145 insertions(+), 90 deletions(-)
>
> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
> index 11cc4657a0f403b84b1b8336781e1893d9c7a8f1..73e5bc6d7fdca692276e119911b47db4bf03586a 100644
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile
> @@ -4,6 +4,8 @@
>  #
>  
>  obj-$(CONFIG_$(XPL_)DM_USB) += common.o
> +obj-$(CONFIG_USB_DWC2) += dwc2_core.o
> +obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
>  obj-$(CONFIG_USB_ISP1760) += usb_urb.o
>  obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
>  obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
> diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..63062d5cc943b0367100d43e4443be7b3d59b77c
> --- /dev/null
> +++ b/drivers/usb/common/dwc2_core.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024-2025, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <wait_bit.h>
> +
> +#include "dwc2_core.h"
> +
> +int dwc2_core_reset(struct dwc2_core_regs *regs)
> +{
> +	u32 snpsid;
> +	int ret;
> +	bool host_mode = false;
> +
> +	if (!(readl(&regs->global_regs.gotgctl) & GOTGCTL_CONID_B) ||
> +	    (readl(&regs->global_regs.gusbcfg) & GUSBCFG_FORCEDEVMODE))
> +		host_mode = true;
> +
> +	/* Core Soft Reset */
> +	snpsid = readl(&regs->global_regs.gsnpsid);
> +	writel(GRSTCTL_CSFTRST, &regs->global_regs.grstctl);
> +	if (FIELD_GET(GSNPSID_VER_MASK, snpsid) < 0x420a) {
> +		ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST,
> +					false, 1000, false);
> +		if (ret) {
> +			log_warning("%s: Waiting for GRSTCTL_CSFTRST timeout\n", __func__);
> +			return ret;
> +		}
> +	} else {
> +		ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST_DONE,
> +					true, 1000, false);
> +		if (ret) {
> +			log_warning("%s: Waiting for GRSTCTL_CSFTRST_DONE timeout\n", __func__);
> +			return ret;
> +		}
> +		clrsetbits_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST, GRSTCTL_CSFTRST_DONE);
> +	}
> +
> +	/* Wait for AHB master IDLE state. */
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,
> +				true, 1000, false);
> +	if (ret) {
> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
> +		return ret;
> +	}
> +
> +	if (host_mode) {
> +		ret = wait_for_bit_le32(&regs->global_regs.gintsts, GINTSTS_CURMODE_HOST,
> +					host_mode, 1000, false);
> +		if (ret) {
> +			log_warning("%s: Waiting for GINTSTS_CURMODE_HOST timeout\n", __func__);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num)
> +{
> +	int ret;
> +
> +	log_debug("Flush Tx FIFO %d\n", num);
> +
> +	/* Wait for AHB master IDLE state */
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
> +	if (ret) {
> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
> +		return ret;
> +	}
> +
> +	writel(GRSTCTL_TXFFLSH | FIELD_PREP(GRSTCTL_TXFNUM_MASK, num), &regs->global_regs.grstctl);
> +
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_TXFFLSH, false, 1000, false);
> +	if (ret) {
> +		log_warning("%s: Waiting for GRSTCTL_TXFFLSH timeout\n", __func__);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Wait for at least 3 PHY clocks.
> +	 *
> +	 * The PHY clock frequency can be configured to 6/30/48/60 MHz
> +	 * based on the speed mode. A fixed delay of 1us ensures that the
> +	 * wait time is sufficient even at the lowest PHY clock frequency
> +	 * (6 MHz), where 1us corresponds to twice the duration of 3 PHY
> +	 * clocks.
> +	 */
> +	udelay(1);
> +
> +	return 0;
> +}
> +
> +int dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
> +{
> +	int ret;
> +
> +	log_debug("Flush Rx FIFO\n");
> +
> +	/* Wait for AHB master IDLE state */
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
> +	if (ret) {
> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
> +		return ret;
> +	}
> +
> +	writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
> +
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH, false, 1000, false);
> +	if (ret) {
> +		log_warning("%s: Waiting for GRSTCTL_RXFFLSH timeout\n", __func__);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Wait for at least 3 PHY clocks.
> +	 *
> +	 * The PHY clock frequency can be configured to 6/30/48/60 MHz
> +	 * based on the speed mode. A fixed delay of 1us ensures that the
> +	 * wait time is sufficient even at the lowest PHY clock frequency
> +	 * (6 MHz), where 1us corresponds to twice the duration of 3 PHY
> +	 * clocks.
> +	 */
> +	udelay(1);
> +
> +	return 0;
> +}
> diff --git a/drivers/usb/common/dwc2_core.h b/drivers/usb/common/dwc2_core.h
> index 862d3b3691c9caf84590d34960df21117848df0a..1897ad7cb540ed7a24fd8cd21650a40da20363fb 100644
> --- a/drivers/usb/common/dwc2_core.h
> +++ b/drivers/usb/common/dwc2_core.h
> @@ -125,6 +125,10 @@ struct dwc2_core_regs {
>  	u8  ep_fifo[16][0x1000];		/* 0x1000 */
>  };
>  
> +int dwc2_core_reset(struct dwc2_core_regs *regs);
> +int dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num);
> +int dwc2_flush_rx_fifo(struct dwc2_core_regs *regs);
> +
>  /* Core Global Register */
>  #define GOTGCTL_CHIRPEN				BIT(27)
>  #define GOTGCTL_MULT_VALID_BC_MASK		GENMASK(26, 22)
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index b08ea5ba79a5f1f094a2407687e5f5aad9f3577e..084e9824faac03d47e23e0d52e81a9d12308e06a 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -471,7 +471,7 @@ static void reconfig_usbd(struct dwc2_udc *dev)
>  	u32 max_hw_ep;
>  	int pdata_hw_ep;
>  
> -	writel(GRSTCTL_CSFTRST, &reg->global_regs.grstctl);
> +	dwc2_core_reset(reg);
>  
>  	debug("Resetting OTG controller\n");
>  
> @@ -575,16 +575,10 @@ static void reconfig_usbd(struct dwc2_udc *dev)
>  		       &reg->global_regs.dptxfsizn[i]);
>  	}
>  	/* Flush the RX FIFO */
> -	writel(GRSTCTL_RXFFLSH, &reg->global_regs.grstctl);
> -	while (readl(&reg->global_regs.grstctl) & GRSTCTL_RXFFLSH)
> -		debug("%s: waiting for DWC2_UDC_OTG_GRSTCTL\n", __func__);
> +	dwc2_flush_rx_fifo(reg);
>  
>  	/* Flush all the Tx FIFO's */
> -	writel(FIELD_PREP(GRSTCTL_TXFNUM_MASK, GRSTCTL_TXFNUM_ALL), &reg->global_regs.grstctl);
> -	writel(FIELD_PREP(GRSTCTL_TXFNUM_MASK, GRSTCTL_TXFNUM_ALL) | GRSTCTL_TXFFLSH,
> -	       &reg->global_regs.grstctl);
> -	while (readl(&reg->global_regs.grstctl) & GRSTCTL_TXFFLSH)
> -		debug("%s: waiting for DWC2_UDC_OTG_GRSTCTL\n", __func__);
> +	dwc2_flush_tx_fifo(reg, GRSTCTL_TXFNUM_ALL);
>  
>  	/* 13. Clear NAK bit of EP0, EP1, EP2*/
>  	/* For Slave mode*/
> diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> index 64d2fe7bbde4494b4cbcdf57032b720901fdd4eb..2be93592c423df7a9acea473b0e84e1f948999be 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> @@ -164,11 +164,7 @@ static int setdma_tx(struct dwc2_ep *ep, struct dwc2_request *req)
>  		pktcnt = (length - 1)/(ep->ep.maxpacket) + 1;
>  
>  	/* Flush the endpoint's Tx FIFO */
> -	writel(FIELD_PREP(GRSTCTL_TXFNUM_MASK, ep->fifo_num), &reg->global_regs.grstctl);
> -	writel(FIELD_PREP(GRSTCTL_TXFNUM_MASK, ep->fifo_num) | GRSTCTL_TXFFLSH,
> -	       &reg->global_regs.grstctl);
> -	while (readl(&reg->global_regs.grstctl) & GRSTCTL_TXFFLSH)
> -		;
> +	dwc2_flush_tx_fifo(reg, ep->fifo_num);
>  
>  	writel(phys_to_bus((unsigned long)ep->dma_buf), &reg->device_regs.in_endp[ep_num].diepdma);
>  	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, pktcnt) |
> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> index ff7885f8195c0bc08669dd99ef6c94992c991945..b27429235798ce223bb8a11999e3d520c26ef377 100644
> --- a/drivers/usb/host/dwc2.c
> +++ b/drivers/usb/host/dwc2.c
> @@ -108,78 +108,6 @@ static void init_fslspclksel(struct dwc2_core_regs *regs)
>  			FIELD_PREP(HCFG_FSLSPCLKSEL_MASK, phyclk));
>  }
>  
> -/*
> - * Flush a Tx FIFO.
> - *
> - * @param regs Programming view of DWC_otg controller.
> - * @param num Tx FIFO to flush.
> - */
> -static void dwc_otg_flush_tx_fifo(struct udevice *dev,
> -				  struct dwc2_core_regs *regs, const int num)
> -{
> -	int ret;
> -
> -	writel(GRSTCTL_TXFFLSH | FIELD_PREP(GRSTCTL_TXFNUM_MASK, num),
> -	       &regs->global_regs.grstctl);
> -	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_TXFFLSH,
> -				false, 1000, false);
> -	if (ret)
> -		dev_info(dev, "%s: Timeout!\n", __func__);
> -
> -	/* Wait for 3 PHY Clocks */
> -	udelay(1);
> -}
> -
> -/*
> - * Flush Rx FIFO.
> - *
> - * @param regs Programming view of DWC_otg controller.
> - */
> -static void dwc_otg_flush_rx_fifo(struct udevice *dev,
> -				  struct dwc2_core_regs *regs)
> -{
> -	int ret;
> -
> -	writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
> -	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH,
> -				false, 1000, false);
> -	if (ret)
> -		dev_info(dev, "%s: Timeout!\n", __func__);
> -
> -	/* Wait for 3 PHY Clocks */
> -	udelay(1);
> -}
> -
> -/*
> - * Do core a soft reset of the core.  Be careful with this because it
> - * resets all the internal state machines of the core.
> - */
> -static void dwc_otg_core_reset(struct udevice *dev,
> -			       struct dwc2_core_regs *regs)
> -{
> -	int ret;
> -
> -	/* Wait for AHB master IDLE state. */
> -	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,
> -				true, 1000, false);
> -	if (ret)
> -		dev_info(dev, "%s: Timeout!\n", __func__);
> -
> -	/* Core Soft Reset */
> -	writel(GRSTCTL_CSFTRST, &regs->global_regs.grstctl);
> -	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST,
> -				false, 1000, false);
> -	if (ret)
> -		dev_info(dev, "%s: Timeout!\n", __func__);
> -
> -	/*
> -	 * Wait for core to come out of reset.
> -	 * NOTE: This long sleep is _very_ important, otherwise the core will
> -	 *       not stay in host mode after a connector ID change!
> -	 */
> -	mdelay(100);
> -}
> -
>  #if CONFIG_IS_ENABLED(DM_USB) && defined(CONFIG_DM_REGULATOR)
>  static int dwc_vbus_supply_init(struct udevice *dev)
>  {
> @@ -281,8 +209,8 @@ static void dwc_otg_core_host_init(struct udevice *dev,
>  	clrbits_le32(&regs->global_regs.gotgctl, GOTGCTL_HSTSETHNPEN);
>  
>  	/* Make sure the FIFOs are flushed. */
> -	dwc_otg_flush_tx_fifo(dev, regs, GRSTCTL_TXFNUM_ALL);	/* All Tx FIFOs */
> -	dwc_otg_flush_rx_fifo(dev, regs);
> +	dwc2_flush_tx_fifo(regs, GRSTCTL_TXFNUM_ALL);	/* All Tx FIFOs */
> +	dwc2_flush_rx_fifo(regs);
>  
>  	/* Flush out any leftover queued requests. */
>  	num_channels = FIELD_GET(GHWCFG2_NUM_HOST_CHAN_MASK, readl(&regs->global_regs.ghwcfg2)) + 1;
> @@ -352,7 +280,7 @@ static void dwc_otg_core_init(struct udevice *dev)
>  	writel(usbcfg, &regs->global_regs.gusbcfg);
>  
>  	/* Reset the Controller */
> -	dwc_otg_core_reset(dev, regs);
> +	dwc2_core_reset(regs);
>  
>  	/*
>  	 * This programming sequence needs to happen in FS mode before
> @@ -413,7 +341,7 @@ static void dwc_otg_core_init(struct udevice *dev)
>  	writel(usbcfg, &regs->global_regs.gusbcfg);
>  
>  	/* Reset after setting the PHY parameters */
> -	dwc_otg_core_reset(dev, regs);
> +	dwc2_core_reset(regs);
>  #endif
>  
>  	usbcfg = readl(&regs->global_regs.gusbcfg);
>
> -- 
> 2.47.1
