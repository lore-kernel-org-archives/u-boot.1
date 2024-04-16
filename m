Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97E9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 08:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF93A8833F;
	Tue, 16 Apr 2024 10:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zmbx1/Xb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D3B88340; Tue, 16 Apr 2024 10:50:25 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D50358833F
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 10:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-417f5268b12so36296135e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713257420; x=1713862220;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vp0DSmEGXDslRDvyEs9u/wW9QeV8VNWt+okwiihwM9U=;
 b=zmbx1/XbTt03W8QYvIRSzs+F/DvO0KUkexid/QPfY5SjgBly0r34iWXMGfRa5Icj/V
 cqLrjHoFyiR9l116TuQgQpS7d+++xU2MolVrpAC0sbiupzRZ3wpT2HImydImqgSuRKub
 eIv0H9FaqHXobaPvikW1Rj3a9HzdkdvgruI0HZHSnDXy2uJmwZLCxJK4mh310NGWDfNo
 yp/Hg4JX5OZ+/BBJqOr/rUv1OrSuWfzVowTxHMo8M4Xi40eYeLqY5uuLMLnbVxcLKZIM
 OKwOzoiEe36RYoCPfY1H3u3MjdOjD4gvgLV7YZrwkYMkqlD4XsMlcNMaM/M0G54c//QK
 sfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713257420; x=1713862220;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vp0DSmEGXDslRDvyEs9u/wW9QeV8VNWt+okwiihwM9U=;
 b=SXp8WUq/+2/MKcZK6ooh759aH8y8HFmZFNzHWVVkPjv6yMuaGfrJ+Hp3ex6JpFQLI8
 canMwOr+t9y+n4YuV+71nr9yKyeXFB5AV2hMmoqoaG2Gf5dTfCLTrASL84qiPLYytwFf
 OUzkDxRpp2e/wd7FKkxZhOvH6iIFYjJGe1TEyWJNPV/d1a26QC5QAdp3tct0Dewz5S9T
 lE5U46/VIISb1WklnFBi15lDf8VsRJ+1H6w0u1djiUa6Z2APWbkxWcJpzFbnS1uXBN3M
 fSYdg8o8RnC7uFNv1kO5oBT18AYbU5XRztbT65G4FFsnN51i6lDIGnVBgppr8NX/l+YI
 dtjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4B7Yy+aYQugBk28iGkadFcAkQgqOnoMMgOw5loi3v11puevn9mp8HGb4f9D+v8Xakd3G1prvtG4UD4UdYU74WhF7/AQ==
X-Gm-Message-State: AOJu0YwIGDxN1LY+p6Mk6MV+07QQA6SAPHq5CQumylEXJSmctRVmTJ9E
 NpUxZ9Vg/rmQvLCn2WVhgfWVC1+5d/j/6XAA6FHiHsgYvgjbzB5k6WlKtkzDzaw=
X-Google-Smtp-Source: AGHT+IGcrv4n9dLO4oHyDnQbk/D6JPyVSJvOYEZswORDHTP49WWFYfMCPPAu1CWOvkXk8JDjXGNjrA==
X-Received: by 2002:a05:600c:4fd6:b0:418:9dd2:fd04 with SMTP id
 o22-20020a05600c4fd600b004189dd2fd04mr532919wmq.13.1713257420180; 
 Tue, 16 Apr 2024 01:50:20 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f20-20020a05600c155400b0041665d968f1sm19060637wmg.47.2024.04.16.01.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 01:50:19 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, Teik Heng Chong
 <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc2: update reset method for host and device mode
In-Reply-To: <20240328131811.94559-1-seashell11234455@gmail.com>
References: <20240328131811.94559-1-seashell11234455@gmail.com>
Date: Tue, 16 Apr 2024 10:50:16 +0200
Message-ID: <87y19d4rp3.fsf@baylibre.com>
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

Hi Kongyang,

Thank you for the patch.

On jeu., mars 28, 2024 at 21:14, Kongyang Liu <seashell11234455@gmail.com> wrote:

> Starting from version 4.20a, there has been a change in the reset method.
> A new bit, GRSTCTL_CSFTRST_DONE, has been introduced in the GRSTCTL
> register to indicate whether the reset has been completed.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

I've compared this with the equivalent Linux patch found here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Also tested on VIM3 that I could use fastboot.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

I will add the linux link in the commit message when applying. Please
consider adding it yourself if you receive review comments that require
sending a v2.

Thanks
Mattijs

> ---
>
>  drivers/usb/gadget/dwc2_udc_otg.c      | 18 ++++++++++++++++--
>  drivers/usb/gadget/dwc2_udc_otg_regs.h | 19 +++++++++++++------
>  drivers/usb/host/dwc2.c                | 19 ++++++++++++++++---
>  drivers/usb/host/dwc2.h                |  6 ++++++
>  4 files changed, 51 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index 27082f5152..d1dd469a0f 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -42,7 +42,7 @@
>  #include <asm/unaligned.h>
>  #include <asm/io.h>
>  
> -#include <asm/mach-types.h>
> +#include <wait_bit.h>
>  
>  #include <power/regulator.h>
>  
> @@ -464,12 +464,26 @@ static void reconfig_usbd(struct dwc2_udc *dev)
>  {
>  	/* 2. Soft-reset OTG Core and then unreset again. */
>  	int i;
> -	unsigned int uTemp = writel(CORE_SOFT_RESET, &reg->grstctl);
> +	unsigned int uTemp;
>  	uint32_t dflt_gusbcfg;
>  	uint32_t rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
>  	u32 max_hw_ep;
>  	int pdata_hw_ep;
>  
> +	u32 snpsid, greset;
> +
> +	snpsid = readl(&reg->gsnpsid);
> +	writel(CORE_SOFT_RESET, &reg->grstctl);
> +	if ((snpsid & SNPSID_VER_MASK) < (SNPSID_VER_420a & SNPSID_VER_MASK)) {
> +		wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET, false, 1000, false);
> +	} else {
> +		wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET_DONE, true, 1000, false);
> +		greset = readl(&reg->grstctl);
> +		greset &= ~CORE_SOFT_RESET;
> +		greset |= CORE_SOFT_RESET_DONE;
> +		writel(greset, &reg->grstctl);
> +	}
> +
>  	debug("Resetting OTG controller\n");
>  
>  	dflt_gusbcfg =
> diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dwc2_udc_otg_regs.h
> index 9ca6f42375..b3d9117033 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
> +++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h
> @@ -63,24 +63,26 @@ struct dwc2_usbotg_reg {
>  	u32 gnptxfsiz; /* Non-Periodic Transmit FIFO Size */
>  	u8  res0[12];
>  	u32 ggpio;     /* 0x038 */
> -	u8  res1[20];
> +	u8  res1[4];
> +	u32 gsnpsid;
> +	u8  res2[12];
>  	u32 ghwcfg4; /* User HW Config4 */
> -	u8  res2[176];
> +	u8  res3[176];
>  	u32 dieptxf[15]; /* Device Periodic Transmit FIFO size register */
> -	u8  res3[1728];
> +	u8  res4[1728];
>  	/* Device Configuration */
>  	u32 dcfg; /* Device Configuration Register */
>  	u32 dctl; /* Device Control */
>  	u32 dsts; /* Device Status */
> -	u8  res4[4];
> +	u8  res5[4];
>  	u32 diepmsk; /* Device IN Endpoint Common Interrupt Mask */
>  	u32 doepmsk; /* Device OUT Endpoint Common Interrupt Mask */
>  	u32 daint; /* Device All Endpoints Interrupt */
>  	u32 daintmsk; /* Device All Endpoints Interrupt Mask */
> -	u8  res5[224];
> +	u8  res6[224];
>  	struct dwc2_dev_in_endp in_endp[16];
>  	struct dwc2_dev_out_endp out_endp[16];
> -	u8  res6[768];
> +	u8  res7[768];
>  	struct ep_fifo ep[16];
>  };
>  
> @@ -118,6 +120,7 @@ struct dwc2_usbotg_reg {
>  /* DWC2_UDC_OTG_GRSTCTL */
>  #define AHB_MASTER_IDLE		(1u<<31)
>  #define CORE_SOFT_RESET		(0x1<<0)
> +#define CORE_SOFT_RESET_DONE		(0x1<<29)
>  
>  /* DWC2_UDC_OTG_GINTSTS/DWC2_UDC_OTG_GINTMSK core interrupt register */
>  #define INT_RESUME			(1u<<31)
> @@ -285,6 +288,10 @@ struct dwc2_usbotg_reg {
>  #define DAINT_IN_EP_INT(x)                        (x << 0)
>  #define DAINT_OUT_EP_INT(x)                       (x << 16)
>  
> +/* DWC2_UDC_OTG_GSNPSID */
> +#define SNPSID_VER_420a					0x4f54420a
> +#define SNPSID_VER_MASK					0xffff
> +
>  /* User HW Config4 */
>  #define GHWCFG4_NUM_IN_EPS_MASK		(0xf << 26)
>  #define GHWCFG4_NUM_IN_EPS_SHIFT	26
> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> index 637eb2dd06..1baeff96ee 100644
> --- a/drivers/usb/host/dwc2.c
> +++ b/drivers/usb/host/dwc2.c
> @@ -159,6 +159,7 @@ static void dwc_otg_core_reset(struct udevice *dev,
>  			       struct dwc2_core_regs *regs)
>  {
>  	int ret;
> +	u32 snpsid, greset;
>  
>  	/* Wait for AHB master IDLE state. */
>  	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_AHBIDLE,
> @@ -167,9 +168,20 @@ static void dwc_otg_core_reset(struct udevice *dev,
>  		dev_info(dev, "%s: Timeout!\n", __func__);
>  
>  	/* Core Soft Reset */
> +	snpsid = readl(&regs->gsnpsid);
>  	writel(DWC2_GRSTCTL_CSFTRST, &regs->grstctl);
> -	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
> -				false, 1000, false);
> +	if ((snpsid & DWC2_SNPSID_VER_MASK) < (DWC2_SNPSID_DEVID_VER_420a & DWC2_SNPSID_VER_MASK)) {
> +		ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
> +					false, 1000, false);
> +	} else {
> +		ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_GSFTRST_DONE,
> +					true, 1000, false);
> +		greset = readl(&regs->grstctl);
> +		greset &= ~DWC2_GRSTCTL_CSFTRST;
> +		greset |= DWC2_GRSTCTL_GSFTRST_DONE;
> +		writel(greset, &regs->grstctl);
> +	}
> +
>  	if (ret)
>  		dev_info(dev, "%s: Timeout!\n", __func__);
>  
> @@ -1180,7 +1192,8 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
>  		 snpsid >> 12 & 0xf, snpsid & 0xfff);
>  
>  	if ((snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_2xx &&
> -	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx) {
> +		(snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx &&
> +	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_4xx) {
>  		dev_info(dev, "SNPSID invalid (not DWC2 OTG device): %08x\n",
>  			 snpsid);
>  		return -ENODEV;
> diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
> index 6f022e33a1..e1f0f59b82 100644
> --- a/drivers/usb/host/dwc2.h
> +++ b/drivers/usb/host/dwc2.h
> @@ -207,6 +207,8 @@ struct dwc2_core_regs {
>  #define DWC2_GRSTCTL_TXFFLSH_OFFSET			5
>  #define DWC2_GRSTCTL_TXFNUM_MASK			(0x1F << 6)
>  #define DWC2_GRSTCTL_TXFNUM_OFFSET			6
> +#define DWC2_GRSTCTL_GSFTRST_DONE			(1 << 29)
> +#define DWC2_GRSTCTL_GSFTRST_DONE_OFFSET	29
>  #define DWC2_GRSTCTL_DMAREQ				(1 << 30)
>  #define DWC2_GRSTCTL_DMAREQ_OFFSET			30
>  #define DWC2_GRSTCTL_AHBIDLE				(1 << 31)
> @@ -739,8 +741,12 @@ struct dwc2_core_regs {
>  #define DWC2_PCGCCTL_DEEP_SLEEP_OFFSET			7
>  #define DWC2_SNPSID_DEVID_VER_2xx			(0x4f542 << 12)
>  #define DWC2_SNPSID_DEVID_VER_3xx			(0x4f543 << 12)
> +#define DWC2_SNPSID_DEVID_VER_4xx			(0x4f544 << 12)
> +#define DWC2_SNPSID_DEVID_VER_420a			0x4f54420a
>  #define DWC2_SNPSID_DEVID_MASK				(0xfffff << 12)
>  #define DWC2_SNPSID_DEVID_OFFSET			12
> +#define DWC2_SNPSID_VER_MASK				0xffff
> +#define DWC2_SNPSID_VER_OFFSET				0
>  
>  /* Host controller specific */
>  #define DWC2_HC_PID_DATA0		0
> -- 
> 2.41.0
