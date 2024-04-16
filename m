Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F89C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 08:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE477881BD;
	Tue, 16 Apr 2024 10:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jR18Ni5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498CC881BD; Tue, 16 Apr 2024 10:54:49 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3797E881CF
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 10:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-343cfa6faf0so3440489f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713257684; x=1713862484;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ydqqcm/8pe1l3eJjuIMGK5NsJDM2c612heGLwcs8hxc=;
 b=jR18Ni5CJkzv6qkMuL/ZDjrX7xqLHEpcVeit+HsBcLiGkurax8E/0XSUGXZI4+oFMy
 V+PP1OvB3zak+F818MlaFZ3sojQEl53hX5J2tZPLX7GuLSYekPvPtSTomfUR9kYZToFT
 LYKs1YUMvv+/5JJAGzCUfaLZvCsmQkidFzmbDbkLQ3aqE4oRb/i8KlXIYh5or48qYN7x
 +A7XSZOF6qdT76y7PJZZOvZA5wY2CRxRaX1YlBxCGJlwn16BljoMVi2I/8mjQXEN24pB
 vHjxjkUeiqpYDS82ouO2Iksklppi93hL0HtFoyGIvZmMXRKcf+PAF1BDBy+cnIgBwPIA
 lYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713257684; x=1713862484;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ydqqcm/8pe1l3eJjuIMGK5NsJDM2c612heGLwcs8hxc=;
 b=kCqWYWY69U1AyvZ4Ibo77Jvmh54/Pa8+fGGKHM4hekNQPcQDUpxSFYd45mECI+P0mH
 wg/nzHPPnRKcwlOAFIZ81IUQZ7x5M8E5qCMrwoazo93bNwj0gxt976MZ2ehXTKK2Hyw1
 Qn+37JIJ+q0n02fNwsB9TT0GN/Q0c+f9pZeYz2UhXbeh5+3mT+Aijtr+zSK03P+L0whx
 sIug4NOKBF31boUf43Z+Q63c6plM+B44iwBLms1CUqIpxyjLenaXhDKdJVj9ptj3z8R3
 3JXSbz0F+apL/WvJPSczVNQITYH6qCW+Nn/5opC2m/aVTf2hgqjOr+ewZsh/JhIMg2oT
 498A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnfLUDAIlfbMknOiDcVFcz13dMwfDsn5fXoIr7bjqWFHcIYv88Z3k5uf5/pEExFku0vtdv5qZCP0UVlrx6yeje/ie1yw==
X-Gm-Message-State: AOJu0Yx2TChln6cUEv7Ken7CjB48iFGrwQkDybp2rR+/t1LfHZ5qTA6v
 0Pi5mFXN/6sWX0Gl+Jzqb8YyJ14qpeWmiZWbCvxklZlMqS2UQvzjWwwgsouPOq4=
X-Google-Smtp-Source: AGHT+IHmxZJN8vqLmt/omP7lY7dlz0VXp/ZHZOAikozDDfvTNDsDeZPI91lrTh4dJE8s49VEiGsnuQ==
X-Received: by 2002:a5d:42c2:0:b0:33e:ca3a:1bba with SMTP id
 t2-20020a5d42c2000000b0033eca3a1bbamr10123937wrr.20.1713257683606; 
 Tue, 16 Apr 2024 01:54:43 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 t16-20020a5d6a50000000b0034403ee44b1sm14342561wrw.14.2024.04.16.01.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 01:54:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>, Simon
 Glass <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>, Tom
 Rini <trini@konsulko.com>, Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH] usb: dwc2: update reset method for host and device mode
In-Reply-To: <87y19d4rp3.fsf@baylibre.com>
References: <20240328131811.94559-1-seashell11234455@gmail.com>
 <87y19d4rp3.fsf@baylibre.com>
Date: Tue, 16 Apr 2024 10:54:40 +0200
Message-ID: <87v84h4rhr.fsf@baylibre.com>
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

On mar., avril 16, 2024 at 10:50, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Kongyang,
>
> Thank you for the patch.
>
> On jeu., mars 28, 2024 at 21:14, Kongyang Liu <seashell11234455@gmail.com> wrote:
>
>> Starting from version 4.20a, there has been a change in the reset method.
>> A new bit, GRSTCTL_CSFTRST_DONE, has been introduced in the GRSTCTL
>> register to indicate whether the reset has been completed.
>>
>> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
>
> I've compared this with the equivalent Linux patch found here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Also tested on VIM3 that I could use fastboot.
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3
>
> I will add the linux link in the commit message when applying. Please
> consider adding it yourself if you receive review comments that require
> sending a v2.

Just noticed that this also touches the host part of the driver.

Marek, do you want to review/pick this up, or can this go through
u-boot-dfu ?

>
> Thanks
> Mattijs
>
>> ---
>>
>>  drivers/usb/gadget/dwc2_udc_otg.c      | 18 ++++++++++++++++--
>>  drivers/usb/gadget/dwc2_udc_otg_regs.h | 19 +++++++++++++------
>>  drivers/usb/host/dwc2.c                | 19 ++++++++++++++++---
>>  drivers/usb/host/dwc2.h                |  6 ++++++
>>  4 files changed, 51 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
>> index 27082f5152..d1dd469a0f 100644
>> --- a/drivers/usb/gadget/dwc2_udc_otg.c
>> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
>> @@ -42,7 +42,7 @@
>>  #include <asm/unaligned.h>
>>  #include <asm/io.h>
>>  
>> -#include <asm/mach-types.h>
>> +#include <wait_bit.h>
>>  
>>  #include <power/regulator.h>
>>  
>> @@ -464,12 +464,26 @@ static void reconfig_usbd(struct dwc2_udc *dev)
>>  {
>>  	/* 2. Soft-reset OTG Core and then unreset again. */
>>  	int i;
>> -	unsigned int uTemp = writel(CORE_SOFT_RESET, &reg->grstctl);
>> +	unsigned int uTemp;
>>  	uint32_t dflt_gusbcfg;
>>  	uint32_t rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
>>  	u32 max_hw_ep;
>>  	int pdata_hw_ep;
>>  
>> +	u32 snpsid, greset;
>> +
>> +	snpsid = readl(&reg->gsnpsid);
>> +	writel(CORE_SOFT_RESET, &reg->grstctl);
>> +	if ((snpsid & SNPSID_VER_MASK) < (SNPSID_VER_420a & SNPSID_VER_MASK)) {
>> +		wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET, false, 1000, false);
>> +	} else {
>> +		wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET_DONE, true, 1000, false);
>> +		greset = readl(&reg->grstctl);
>> +		greset &= ~CORE_SOFT_RESET;
>> +		greset |= CORE_SOFT_RESET_DONE;
>> +		writel(greset, &reg->grstctl);
>> +	}
>> +
>>  	debug("Resetting OTG controller\n");
>>  
>>  	dflt_gusbcfg =
>> diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dwc2_udc_otg_regs.h
>> index 9ca6f42375..b3d9117033 100644
>> --- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
>> +++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h
>> @@ -63,24 +63,26 @@ struct dwc2_usbotg_reg {
>>  	u32 gnptxfsiz; /* Non-Periodic Transmit FIFO Size */
>>  	u8  res0[12];
>>  	u32 ggpio;     /* 0x038 */
>> -	u8  res1[20];
>> +	u8  res1[4];
>> +	u32 gsnpsid;
>> +	u8  res2[12];
>>  	u32 ghwcfg4; /* User HW Config4 */
>> -	u8  res2[176];
>> +	u8  res3[176];
>>  	u32 dieptxf[15]; /* Device Periodic Transmit FIFO size register */
>> -	u8  res3[1728];
>> +	u8  res4[1728];
>>  	/* Device Configuration */
>>  	u32 dcfg; /* Device Configuration Register */
>>  	u32 dctl; /* Device Control */
>>  	u32 dsts; /* Device Status */
>> -	u8  res4[4];
>> +	u8  res5[4];
>>  	u32 diepmsk; /* Device IN Endpoint Common Interrupt Mask */
>>  	u32 doepmsk; /* Device OUT Endpoint Common Interrupt Mask */
>>  	u32 daint; /* Device All Endpoints Interrupt */
>>  	u32 daintmsk; /* Device All Endpoints Interrupt Mask */
>> -	u8  res5[224];
>> +	u8  res6[224];
>>  	struct dwc2_dev_in_endp in_endp[16];
>>  	struct dwc2_dev_out_endp out_endp[16];
>> -	u8  res6[768];
>> +	u8  res7[768];
>>  	struct ep_fifo ep[16];
>>  };
>>  
>> @@ -118,6 +120,7 @@ struct dwc2_usbotg_reg {
>>  /* DWC2_UDC_OTG_GRSTCTL */
>>  #define AHB_MASTER_IDLE		(1u<<31)
>>  #define CORE_SOFT_RESET		(0x1<<0)
>> +#define CORE_SOFT_RESET_DONE		(0x1<<29)
>>  
>>  /* DWC2_UDC_OTG_GINTSTS/DWC2_UDC_OTG_GINTMSK core interrupt register */
>>  #define INT_RESUME			(1u<<31)
>> @@ -285,6 +288,10 @@ struct dwc2_usbotg_reg {
>>  #define DAINT_IN_EP_INT(x)                        (x << 0)
>>  #define DAINT_OUT_EP_INT(x)                       (x << 16)
>>  
>> +/* DWC2_UDC_OTG_GSNPSID */
>> +#define SNPSID_VER_420a					0x4f54420a
>> +#define SNPSID_VER_MASK					0xffff
>> +
>>  /* User HW Config4 */
>>  #define GHWCFG4_NUM_IN_EPS_MASK		(0xf << 26)
>>  #define GHWCFG4_NUM_IN_EPS_SHIFT	26
>> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
>> index 637eb2dd06..1baeff96ee 100644
>> --- a/drivers/usb/host/dwc2.c
>> +++ b/drivers/usb/host/dwc2.c
>> @@ -159,6 +159,7 @@ static void dwc_otg_core_reset(struct udevice *dev,
>>  			       struct dwc2_core_regs *regs)
>>  {
>>  	int ret;
>> +	u32 snpsid, greset;
>>  
>>  	/* Wait for AHB master IDLE state. */
>>  	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_AHBIDLE,
>> @@ -167,9 +168,20 @@ static void dwc_otg_core_reset(struct udevice *dev,
>>  		dev_info(dev, "%s: Timeout!\n", __func__);
>>  
>>  	/* Core Soft Reset */
>> +	snpsid = readl(&regs->gsnpsid);
>>  	writel(DWC2_GRSTCTL_CSFTRST, &regs->grstctl);
>> -	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
>> -				false, 1000, false);
>> +	if ((snpsid & DWC2_SNPSID_VER_MASK) < (DWC2_SNPSID_DEVID_VER_420a & DWC2_SNPSID_VER_MASK)) {
>> +		ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
>> +					false, 1000, false);
>> +	} else {
>> +		ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_GSFTRST_DONE,
>> +					true, 1000, false);
>> +		greset = readl(&regs->grstctl);
>> +		greset &= ~DWC2_GRSTCTL_CSFTRST;
>> +		greset |= DWC2_GRSTCTL_GSFTRST_DONE;
>> +		writel(greset, &regs->grstctl);
>> +	}
>> +
>>  	if (ret)
>>  		dev_info(dev, "%s: Timeout!\n", __func__);
>>  
>> @@ -1180,7 +1192,8 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
>>  		 snpsid >> 12 & 0xf, snpsid & 0xfff);
>>  
>>  	if ((snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_2xx &&
>> -	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx) {
>> +		(snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx &&
>> +	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_4xx) {
>>  		dev_info(dev, "SNPSID invalid (not DWC2 OTG device): %08x\n",
>>  			 snpsid);
>>  		return -ENODEV;
>> diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
>> index 6f022e33a1..e1f0f59b82 100644
>> --- a/drivers/usb/host/dwc2.h
>> +++ b/drivers/usb/host/dwc2.h
>> @@ -207,6 +207,8 @@ struct dwc2_core_regs {
>>  #define DWC2_GRSTCTL_TXFFLSH_OFFSET			5
>>  #define DWC2_GRSTCTL_TXFNUM_MASK			(0x1F << 6)
>>  #define DWC2_GRSTCTL_TXFNUM_OFFSET			6
>> +#define DWC2_GRSTCTL_GSFTRST_DONE			(1 << 29)
>> +#define DWC2_GRSTCTL_GSFTRST_DONE_OFFSET	29
>>  #define DWC2_GRSTCTL_DMAREQ				(1 << 30)
>>  #define DWC2_GRSTCTL_DMAREQ_OFFSET			30
>>  #define DWC2_GRSTCTL_AHBIDLE				(1 << 31)
>> @@ -739,8 +741,12 @@ struct dwc2_core_regs {
>>  #define DWC2_PCGCCTL_DEEP_SLEEP_OFFSET			7
>>  #define DWC2_SNPSID_DEVID_VER_2xx			(0x4f542 << 12)
>>  #define DWC2_SNPSID_DEVID_VER_3xx			(0x4f543 << 12)
>> +#define DWC2_SNPSID_DEVID_VER_4xx			(0x4f544 << 12)
>> +#define DWC2_SNPSID_DEVID_VER_420a			0x4f54420a
>>  #define DWC2_SNPSID_DEVID_MASK				(0xfffff << 12)
>>  #define DWC2_SNPSID_DEVID_OFFSET			12
>> +#define DWC2_SNPSID_VER_MASK				0xffff
>> +#define DWC2_SNPSID_VER_OFFSET				0
>>  
>>  /* Host controller specific */
>>  #define DWC2_HC_PID_DATA0		0
>> -- 
>> 2.41.0
