Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA84C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 07:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA42885CF;
	Tue, 11 Jun 2024 09:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S5K0QWOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3A7885CC; Tue, 11 Jun 2024 09:36:01 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 942F0885CF
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35dc1d8867eso4126712f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718091357; x=1718696157;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KgdwuaaolbsVyaTVE36VH6+8y7NIELYm9ZUnNejCvKg=;
 b=S5K0QWOMdbBjjUscYEdTpSPQCJ1RXMgA8Y5AZZ5W2pcX/yqDto+sVJ0ioLOs+REsCN
 ZndFdg7TAne0bhEOlrOtwdpyoSQp9uJyB1NvKqRWNUM18OTsmeVkuEARXLsvf/jHuHd0
 GVrIm6J7LrzNz3Gz4iXVoNz5UHR8rBkWLKf86TZ+8PdTvw9ZhQy8w5BAX20OrWNgCWgZ
 f58TW+3HFZJTqB8nLxy5qAtJv/KKDpl4VCc8ZbjAb2E8aub+hBItV+x9eS8b0oiKF2Lk
 ob/4N7sg2R81s4W6rygPc439LdCPRPD4oQ9rnfGHgLhwkQ46P5Mf8YGnqSlf3jsABAGB
 D3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718091357; x=1718696157;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KgdwuaaolbsVyaTVE36VH6+8y7NIELYm9ZUnNejCvKg=;
 b=hpEIYEXvY+zxoBLqbaEMNdTkdX9LHVD2xGsVKpvPIFO6CzgCjI5Bfw3an/pvqlNhAy
 CompADCEgIT/v6EzC6xuzfCGkNS+aXgV1vQz2SDWFD+7XTTpGZzUsAOX2t1IrTWKAVbz
 qWPkzryv18KnZ7yP1KZbG1+ckRP+Cx+8jUjkdL4UGYj4WU4m7IuRLM5t7pgRhUM8sAbf
 7D6B442rWrgVedmuap5oTr4Yt/Vkd98f79S3FQk4/5FEP+y+pNdzJdXmgcqHQHiJfEPU
 cLi2U+KVZCQjeysDmv83y4xzPHbojKXOiB3/h78dw1bnRE1Xjvmi9hv7jU7fC8qRFI6D
 2BGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+U+nU1R3uoKumnY6TwlcFdqDL7uNoMW9x8PfG4O4Kv+PKFtKJf7I0kyL8o2VOsDeHjWk/s3aCQTDLEa6+h4bk5bZukw==
X-Gm-Message-State: AOJu0YwP7OCdJe02R88bfFf/AHlqiETipXAHe9FsK22tQSyLeu2+OzEF
 WlciKK3Sx5YbMc7HwnN2DYrr1uompNLWydeL0X9covmI/6kBrSC1BbttLas050I=
X-Google-Smtp-Source: AGHT+IEOKI9mrvN/amSD/7cDdsXTOdHquTxBRbuMoG6VtsTJTsqJJEqBel0ZnTQMnURGzv9UERVRGA==
X-Received: by 2002:a05:6000:1b09:b0:35f:275c:fb6f with SMTP id
 ffacd0b85a97d-35f275cfc9dmr2652579f8f.65.1718091356910; 
 Tue, 11 Jun 2024 00:35:56 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f22ba68absm5263024f8f.9.2024.06.11.00.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 00:35:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 4/6] usb: gadget: Drop all gadget_is_*() functions
In-Reply-To: <20240609213449.194762-4-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
 <20240609213449.194762-4-marek.vasut+renesas@mailbox.org>
Date: Tue, 11 Jun 2024 09:35:52 +0200
Message-ID: <871q540w4n.fsf@baylibre.com>
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

On dim., juin 09, 2024 at 23:32, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The only actually used gadget_is_*() functions are the one for DWC3
> used in epautoconf.c usb_ep_autoconfig() and one for MUSB in ether.c.
> The DWC3 one should be fixed in some separate patch.
>
> Inline the gadget_is_dwc3() and stop using ifdefs in favor of
> IS_ENABLED() macro.
>
> The rest of gadget_is_*() calls in usb_ep_autoconfig() can never
> be anything but 0, since those gadgets are not supported in U-Boot,
> so remove all that unused code. Remove gadget_chips.h as well.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

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
>  drivers/usb/gadget/epautoconf.c   |  40 +-------
>  drivers/usb/gadget/ether.c        |   8 +-
>  drivers/usb/gadget/gadget_chips.h | 148 ------------------------------
>  3 files changed, 6 insertions(+), 190 deletions(-)
>  delete mode 100644 drivers/usb/gadget/gadget_chips.h
>
> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index 0a70035ce04..09950ceeaed 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -12,7 +12,6 @@
>  #include <linux/errno.h>
>  #include <linux/usb/gadget.h>
>  #include <asm/unaligned.h>
> -#include "gadget_chips.h"
>  
>  #define isdigit(c)      ('0' <= (c) && (c) <= '9')
>  
> @@ -222,41 +221,9 @@ struct usb_ep *usb_ep_autoconfig(
>  	/* First, apply chip-specific "best usage" knowledge.
>  	 * This might make a good usb_gadget_ops hook ...
>  	 */
> -	if (gadget_is_net2280(gadget) && type == USB_ENDPOINT_XFER_INT) {
> -		/* ep-e, ep-f are PIO with only 64 byte fifos */
> -		ep = find_ep(gadget, "ep-e");
> -		if (ep && ep_matches(gadget, ep, desc))
> -			return ep;
> -		ep = find_ep(gadget, "ep-f");
> -		if (ep && ep_matches(gadget, ep, desc))
> -			return ep;
> -
> -	} else if (gadget_is_goku(gadget)) {
> -		if (USB_ENDPOINT_XFER_INT == type) {
> -			/* single buffering is enough */
> -			ep = find_ep(gadget, "ep3-bulk");
> -			if (ep && ep_matches(gadget, ep, desc))
> -				return ep;
> -		} else if (USB_ENDPOINT_XFER_BULK == type
> -				&& (USB_DIR_IN & desc->bEndpointAddress)) {
> -			/* DMA may be available */
> -			ep = find_ep(gadget, "ep2-bulk");
> -			if (ep && ep_matches(gadget, ep, desc))
> -				return ep;
> -		}
> -
> -	} else if (gadget_is_sh(gadget) && USB_ENDPOINT_XFER_INT == type) {
> -		/* single buffering is enough; maybe 8 byte fifo is too */
> -		ep = find_ep(gadget, "ep3in-bulk");
> -		if (ep && ep_matches(gadget, ep, desc))
> -			return ep;
> -
> -	} else if (gadget_is_mq11xx(gadget) && USB_ENDPOINT_XFER_INT == type) {
> -		ep = find_ep(gadget, "ep1-bulk");
> -		if (ep && ep_matches(gadget, ep, desc))
> -			return ep;
> -#ifndef CONFIG_SPL_BUILD
> -	} else if (gadget_is_dwc3(gadget)) {
> +	if (!IS_ENABLED(CONFIG_SPL_BUILD) &&
> +	    IS_ENABLED(CONFIG_USB_DWC3_GADGET) &&
> +	    !strcmp("dwc3-gadget", gadget->name)) {
>  		const char *name = NULL;
>  		/*
>  		 * First try standard, common configuration: ep1in-bulk,
> @@ -278,7 +245,6 @@ struct usb_ep *usb_ep_autoconfig(
>  			ep = find_ep(gadget, name);
>  		if (ep && ep_matches(gadget, ep, desc))
>  			return ep;
> -#endif
>  	}
>  
>  	if (gadget->ops->match_ep)
> diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
> index e76464e121b..b7b7bacb00d 100644
> --- a/drivers/usb/gadget/ether.c
> +++ b/drivers/usb/gadget/ether.c
> @@ -1989,13 +1989,11 @@ static int eth_bind(struct usb_gadget *gadget)
>  	 * standard protocol is _strongly_ preferred for interop purposes.
>  	 * (By everyone except Microsoft.)
>  	 */
> -	if (gadget_is_musbhdrc(gadget)) {
> +
> +	if (IS_ENABLED(CONFIG_USB_MUSB_GADGET) &&
> +	    !strcmp("musb-hdrc", gadget->name)) {
>  		/* reduce tx dma overhead by avoiding special cases */
>  		zlp = 0;
> -	} else if (gadget_is_sh(gadget)) {
> -		/* sh doesn't support multiple interfaces or configs */
> -		cdc = 0;
> -		rndis = 0;
>  	}
>  
>  	gcnum = (U_BOOT_VERSION_NUM << 4) | U_BOOT_VERSION_NUM_PATCH;
> diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
> deleted file mode 100644
> index 316051686c4..00000000000
> --- a/drivers/usb/gadget/gadget_chips.h
> +++ /dev/null
> @@ -1,148 +0,0 @@
> -/*
> - * USB device controllers have lots of quirks.  Use these macros in
> - * gadget drivers or other code that needs to deal with them, and which
> - * autoconfigures instead of using early binding to the hardware.
> - *
> - * This SHOULD eventually work like the ARM mach_is_*() stuff, driven by
> - * some config file that gets updated as new hardware is supported.
> - * (And avoiding all runtime comparisons in typical one-choice configs!)
> - *
> - * NOTE:  some of these controller drivers may not be available yet.
> - * Some are available on 2.4 kernels; several are available, but not
> - * yet pushed in the 2.6 mainline tree.
> - *
> - * Ported to U-Boot by: Thomas Smits <ts.smits@gmail.com> and
> - *                      Remy Bohmer <linux@bohmer.net>
> - */
> -#ifdef CONFIG_USB_GADGET_NET2280
> -#define	gadget_is_net2280(g)	(!strcmp("net2280", (g)->name))
> -#else
> -#define	gadget_is_net2280(g)	0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_AMD5536UDC
> -#define	gadget_is_amd5536udc(g)	(!strcmp("amd5536udc", (g)->name))
> -#else
> -#define	gadget_is_amd5536udc(g)	0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_DUMMY_HCD
> -#define	gadget_is_dummy(g)	(!strcmp("dummy_udc", (g)->name))
> -#else
> -#define	gadget_is_dummy(g)	0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_GOKU
> -#define	gadget_is_goku(g)	(!strcmp("goku_udc", (g)->name))
> -#else
> -#define	gadget_is_goku(g)	0
> -#endif
> -
> -/* SH3 UDC -- not yet ported 2.4 --> 2.6 */
> -#ifdef CONFIG_USB_GADGET_SUPERH
> -#define	gadget_is_sh(g)		(!strcmp("sh_udc", (g)->name))
> -#else
> -#define	gadget_is_sh(g)		0
> -#endif
> -
> -/* handhelds.org tree (?) */
> -#ifdef CONFIG_USB_GADGET_MQ11XX
> -#define	gadget_is_mq11xx(g)	(!strcmp("mq11xx_udc", (g)->name))
> -#else
> -#define	gadget_is_mq11xx(g)	0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_OMAP
> -#define	gadget_is_omap(g)	(!strcmp("omap_udc", (g)->name))
> -#else
> -#define	gadget_is_omap(g)	0
> -#endif
> -
> -/* not yet ported 2.4 --> 2.6 */
> -#ifdef CONFIG_USB_GADGET_N9604
> -#define	gadget_is_n9604(g)	(!strcmp("n9604_udc", (g)->name))
> -#else
> -#define	gadget_is_n9604(g)	0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_ATMEL_USBA
> -#define gadget_is_atmel_usba(g)	(!strcmp("atmel_usba_udc", (g)->name))
> -#else
> -#define gadget_is_atmel_usba(g)	0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_AT91
> -#define gadget_is_at91(g)	(!strcmp("at91_udc", (g)->name))
> -#else
> -#define gadget_is_at91(g)	0
> -#endif
> -
> -/* status unclear */
> -#ifdef CONFIG_USB_GADGET_IMX
> -#define gadget_is_imx(g)	(!strcmp("imx_udc", (g)->name))
> -#else
> -#define gadget_is_imx(g)	0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_FSL_USB2
> -#define gadget_is_fsl_usb2(g)	(!strcmp("fsl-usb2-udc", (g)->name))
> -#else
> -#define gadget_is_fsl_usb2(g)	0
> -#endif
> -
> -/* Mentor high speed function controller */
> -/* from Montavista kernel (?) */
> -#ifdef CONFIG_USB_GADGET_MUSBHSFC
> -#define gadget_is_musbhsfc(g)	(!strcmp("musbhsfc_udc", (g)->name))
> -#else
> -#define gadget_is_musbhsfc(g)	0
> -#endif
> -
> -/* Mentor high speed "dual role" controller, in peripheral role */
> -#ifdef CONFIG_USB_MUSB_GADGET
> -#define gadget_is_musbhdrc(g)	(!strcmp("musb-hdrc", (g)->name))
> -#else
> -#define gadget_is_musbhdrc(g)	0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_M66592
> -#define	gadget_is_m66592(g)	(!strcmp("m66592_udc", (g)->name))
> -#else
> -#define	gadget_is_m66592(g)	0
> -#endif
> -
> -#ifdef CONFIG_CI_UDC
> -#define gadget_is_ci(g)        (!strcmp("ci_udc", (g)->name))
> -#else
> -#define gadget_is_ci(g)        0
> -#endif
> -
> -#ifdef CONFIG_USB_DWC3_GADGET
> -#define gadget_is_dwc3(g)        (!strcmp("dwc3-gadget", (g)->name))
> -#else
> -#define gadget_is_dwc3(g)        0
> -#endif
> -
> -#ifdef CONFIG_USB_CDNS3_GADGET
> -#define gadget_is_cdns3(g)        (!strcmp("cdns3-gadget", (g)->name))
> -#else
> -#define gadget_is_cdns3(g)        0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_MAX3420
> -#define gadget_is_max3420(g)        (!strcmp("max3420-udc", (g)->name))
> -#else
> -#define gadget_is_max3420(g)        0
> -#endif
> -
> -#ifdef CONFIG_USB_MTU3_GADGET
> -#define gadget_is_mtu3(g)        (!strcmp("mtu3-gadget", (g)->name))
> -#else
> -#define gadget_is_mtu3(g)        0
> -#endif
> -
> -#ifdef CONFIG_USB_GADGET_DWC2_OTG
> -#define gadget_is_dwc2(g)        (!strcmp("dwc2-udc", (g)->name))
> -#else
> -#define gadget_is_dwc2(g)        0
> -#endif
> -- 
> 2.43.0
