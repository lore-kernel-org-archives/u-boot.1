Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7716DE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A3C80379;
	Tue, 31 Dec 2024 19:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668795;
	bh=C/bh7TMQu4dvJ6BHFSlhl75vAeDEsHLrgQGlJmlFMMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DznmKU5k4eJNKaJdifThvvmUSVqryE5B3UpheGS41feglxZR7ewXjTzaJzB8vb2V2
	 5HRgUiPknMz7neGHZW67Ikm1LfQqpy8ZID9GJwWgHxGo1WAPYdHtfXMC1/wsWtF3H+
	 PWAjqRJvbWBcbXGWuc2iUmqNPU9qMeEpZ4KS4OgAw+D5MH2m/cIs9AASqUUv2KpWoH
	 7MfDigTh0y+BIxx5kizeObaz/tmKV5FGyYMk65U17rqxZupB2oUUcVAKb+CMCbg1Uu
	 sqn0U4Hx9O36YtOt14vD8GDcLkL/DbnrYWbe5mfgd/aCzW5kv3QhLLUid8s047C9x7
	 VRuo/BXw7+x3g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00AF80374; Tue, 31 Dec 2024 19:13:14 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DC4801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GBGj0vTY"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 58CEB10486D85; Tue, 31 Dec 2024 19:13:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/bh7TMQu4dvJ6BHFSlhl75vAeDEsHLrgQGlJmlFMMs=;
 b=GBGj0vTYAhVx2gWTVBQIKiloWTV7I+13eSBF93Rnk0Le2/2iypmtPKD3Q8vqkyhugH61ni
 Yi/Xo9NCqQm48X0rha05ipuV6kyCYenSCRwmsxCdiVpokJeJZQyoxl4eslAEj0LhFp60mb
 Dz5ux7akHlem6tlyepIPwKCBRiIBrHG2UjWBawYmsFzEWJzDvBkDL/wYnn9eL7rLyEnt8J
 hrB7ec9vU58TWcDHrdCvdqSnn5NGyQf1yn41yFKL/IydwmIQJff7lPY0BVWKDg4fjZy7bu
 80N2t7yJ924nkGk6ZGt45ahf81nZnqjbzi6LAvi2isph1q12sPK1py/VaSGxYw==
Message-ID: <18ea1084-69be-4370-b8b2-95a6c06e3e0f@denx.de>
Date: Tue, 31 Dec 2024 19:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] usb: dwc2: Clean up with bitfield macros
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-4-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-4-12cd9b8a2358@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:

[...]

> diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dwc2_udc_otg_regs.h
> index 198ba7a7c37d05dca084ef017534265f5fb5fd70..33359ba56f7864525fb435ab52f2b21538e4647f 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
> +++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h

[...]

> @@ -78,15 +77,15 @@ struct dwc2_usbotg_phy {
>   #define HIGH_SPEED_CONTROL_PKT_SIZE	64
>   #define HIGH_SPEED_BULK_PKT_SIZE	512
>   
> -#define RX_FIFO_SIZE			(1024)
> -#define NPTX_FIFO_SIZE			(1024)
> -#define PTX_FIFO_SIZE			(384)
> +#define RX_FIFO_SIZE			1024
> +#define NPTX_FIFO_SIZE			1024
> +#define PTX_FIFO_SIZE			384
>   
> -#define DEPCTL_TXFNUM_0		(0x0<<22)
> -#define DEPCTL_TXFNUM_1		(0x1<<22)
> -#define DEPCTL_TXFNUM_2		(0x2<<22)
> -#define DEPCTL_TXFNUM_3		(0x3<<22)
> -#define DEPCTL_TXFNUM_4		(0x4<<22)
> +#define DEPCTL_TXFNUM_0			(0x0<<22)
> +#define DEPCTL_TXFNUM_1			(0x1<<22)
> +#define DEPCTL_TXFNUM_2			(0x2<<22)
> +#define DEPCTL_TXFNUM_3			(0x3<<22)
> +#define DEPCTL_TXFNUM_4			(0x4<<22)

Nitpick -- please add spaces around << , I think checkpatch would warn 
about this.

[...]

> diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> index e2a24c53b4c8d632163484d52b4338820dcb1731..76c0b03c355b47e9523a071bd76ab8d6a17cd3ac 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> @@ -19,6 +19,7 @@
>   
>   #include <cpu_func.h>
>   #include <log.h>
> +#include <linux/bitfield.h>
>   #include <linux/bug.h>
>   
>   static u8 clear_feature_num;
> @@ -174,11 +175,11 @@ static int setdma_tx(struct dwc2_ep *ep, struct dwc2_request *req)
>   	ctrl = readl(&reg->device_regs.in_endp[ep_num].diepctl);
>   
>   	/* Write the FIFO number to be used for this endpoint */
> -	ctrl &= DIEPCTL_TX_FIFO_NUM_MASK;
> -	ctrl |= DIEPCTL_TX_FIFO_NUM(ep->fifo_num);
> +	ctrl &= ~DIEPCTL_TX_FIFO_NUM_MASK;
> +	ctrl |= FIELD_PREP(DIEPCTL_TX_FIFO_NUM_MASK, ep->fifo_num);
>   
>   	/* Clear reserved (Next EP) bits */
> -	ctrl = (ctrl&~(EP_MASK<<DEPCTL_NEXT_EP_BIT));
> +	ctrl &= ~DEPCTL_NEXT_EP_MASK;
>   
>   	writel(DEPCTL_EPENA|DEPCTL_CNAK|ctrl, &reg->device_regs.in_endp[ep_num].diepctl);
Nitpick -- in some follow up separate series, this could also be 
replaced by clrsetbits_le32() , but that's really for separate patch/series.
