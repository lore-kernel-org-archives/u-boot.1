Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03008C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 08:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED1187251;
	Tue, 21 Nov 2023 09:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pPPqwDY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E078487251; Tue, 21 Nov 2023 09:15:24 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A75087232
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b2ad4953cso884985e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 00:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700554520; x=1701159320;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uk9+UAMEGGsflnbhMGtSJjhzRg99RvP6D2VkLk+HHWI=;
 b=pPPqwDY67aYw4MIvaHyZqc8CeqsJ8TeO3OHDk9cKvgJ4/YwfJhN4GTOC1w90TmpQh8
 /EGXDY3GugAimuSgGc+XBHovTd1Nf9GGQhFQ2NvB3TxU0XyguKA1kYmCObatt7Ehtf79
 d4U7RMBSJoRTmHqvoDm182y60FfADX5yzTkairE6zwCF5Xnqe7aouoBK8cqnTMxnXqiB
 IVMVUS2c7YEx97Zej304VQu0u1StVq7G2wtqY3kC2RvR85JecQiozoyRAsrgPf4UWRIU
 AVLQw67RM9QbjLh6twaMFN8cJZia3/4i6KgWyXZ9dT3TSlwAJ3xd7PFpxP9f7YrYrOMJ
 Dwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700554520; x=1701159320;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uk9+UAMEGGsflnbhMGtSJjhzRg99RvP6D2VkLk+HHWI=;
 b=cAXFz0plI6iQIj7mqd4wFqT+zWhpTaWqfxj1absEY67kubD+3jKJZf3ckvq5R6Zmgc
 AMVriNgLGGbnvCJddFm/8/DTJxpeAMpb57qLeMHYbbACZvz8SRVvL7hhcHPnlVvpFcU6
 KlaMQ2Ox1jURcrRI4D7JomGXQJf2BXvNW6kShRuTdHWvdEac9m0u4i3uc5gP7T0y+O0v
 SU1TxfBlohbWGnJJQHXxLbE/cfExo1h1cHEgsFfrxg8nmpkdFZAO6/PbmWTvj4i2gDn8
 sNAH03je2eitjkAPb8ysjxVNZZnJGIwl8QKgDQDCzA6uHFxXWU4St7k90N7msYhtMWZa
 T9QQ==
X-Gm-Message-State: AOJu0YytUmQRqPr2z2CsBWWXwLWXmakOrzHcaJtCtgR2a/RQPBn/aNPm
 /O+vLDUP85dxnJAxff2+Htx/Ug==
X-Google-Smtp-Source: AGHT+IHh4+tx/ieWBhArAW48RIzVDajkY3fcdbITxB043rwZs61Elyan+pdFMAPPVAzhhQvRg8oPdw==
X-Received: by 2002:a05:600c:5195:b0:403:aced:f7f4 with SMTP id
 fa21-20020a05600c519500b00403acedf7f4mr1459999wmb.12.1700554519815; 
 Tue, 21 Nov 2023 00:15:19 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 s6-20020adfdb06000000b0032da49e18fasm13697245wri.23.2023.11.21.00.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 00:15:19 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Holesch <simon@holesch.de>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>
Cc: Simon Holesch <simon@holesch.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] usb: ci: Fix gadget reinit
In-Reply-To: <20231120002024.32865-1-simon@holesch.de>
References: <20231120002024.32865-1-simon@holesch.de>
Date: Tue, 21 Nov 2023 09:15:18 +0100
Message-ID: <87fs0zmsix.fsf@baylibre.com>
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

Hi Simon,

Thank you for your patch.

On lun., nov. 20, 2023 at 01:08, Simon Holesch <simon@holesch.de> wrote:

> The ChipIdea device controller wasn't properly cleaned up when disabled.
> So enabling it again left it in a broken state. The problem occurred for
> example when the host unbinds the driver and binds it again.
>
> During the first setup, when the out request is queued, the endpoint is
> primed (`epprime`). If the endpoint is then disabled, it stayed primed
> with the initial buffer. So after the endpoint is re-enabled, the device
> controller and device driver were out of sync: the new out request was
> in the driver queue head, yet not submitted, but the "complete" function
> was still called, since the endpoint was primed with the old buffer.
>
> With the fastboot function this error led to the (rather confusing)
> error message "buffer overflow".
>
> Fixed by clearing the primed buffers with the `epflush` (`ENDPTFLUSH`)
> register.
>
> Signed-off-by: Simon Holesch <simon@holesch.de>
> Reviewed-by: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - use wait_for_bit_le32(), clrbits_le32
>
> I didn't use setbits_le32(), because the epflush register ignores 0 bits.
>
> Thanks for the review!
>
>  drivers/usb/gadget/ci_udc.c | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 2bfacfe59f..750d471487 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -13,6 +13,7 @@
>  #include <cpu_func.h>
>  #include <net.h>
>  #include <malloc.h>
> +#include <wait_bit.h>
>  #include <asm/byteorder.h>
>  #include <asm/cache.h>
>  #include <linux/delay.h>
> @@ -354,12 +355,49 @@ static int ci_ep_enable(struct usb_ep *ep,
>  	return 0;
>  }
>  
> +static int ep_disable(int num, int in)
> +{
> +	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
> +	unsigned int ep_bit, enable_bit;
> +	int err;
> +
> +	if (in) {
> +		ep_bit = EPT_TX(num);
> +		enable_bit = CTRL_TXE;
> +	} else {
> +		ep_bit = EPT_RX(num);
> +		enable_bit = CTRL_RXE;
> +	}
> +
> +	/* clear primed buffers */
> +	do {
> +		writel(ep_bit, &udc->epflush);
> +		err = wait_for_bit_le32(&udc->epflush, ep_bit, false, 1000, false);
> +		if (err)
> +			return err;
> +	} while (readl(&udc->epstat) & ep_bit);
> +
> +	/* clear enable bit */
> +	clrbits_le32(&udc->epctrl[num], enable_bit);
> +
> +	return 0;
> +}
> +
>  static int ci_ep_disable(struct usb_ep *ep)
>  {
>  	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
> +	int num, in, err;
> +
> +	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> +	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
> +
> +	err = ep_disable(num, in);
> +	if (err)
> +		return err;
>  
>  	ci_ep->desc = NULL;
>  	ep->desc = NULL;
> +	ci_ep->req_primed = false;
>  	return 0;
>  }
>  
> -- 
> 2.42.1
