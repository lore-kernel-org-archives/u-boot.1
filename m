Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34F3C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 06:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4099986E65;
	Sun, 19 Nov 2023 07:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700375877;
	bh=xm6YWyFmDDH59P/5ldoG/1V1539DT1l+G+GHtMeDkTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jijxGXkcYornma9wOQ6vntaLpTwkUz8FIjgus8hp9N92eiMZXnylMwz2OCyWjqoMN
	 uypTHpBcLSIN4ee0dBzjOj8dP7Bksz7E0XfJng1xxfjKAoFi/CumZBd6JvnymnasQY
	 e8mjdODLP6Or0XhCZcEmIBJqFLDTRc8v3F60J1F6dmU+b3d4koxzTfnAs1IndBZuwJ
	 c7oGmlzv3AJ2LiQ1Ax51Tp59edYZ/1pgJwLvVeKcypRd6XghAghyDiEvTG4OilumFX
	 MVjYWPgoE+oGnQ6mIeWXLEmcqLMsofNzx0mF5pZ3k7lFwYE+VO2f7lkBw4D0O5zvct
	 qCvEtFj9IzJFQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 864AA86F40;
 Sun, 19 Nov 2023 07:37:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700375869;
 bh=xm6YWyFmDDH59P/5ldoG/1V1539DT1l+G+GHtMeDkTs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=t4ZMCghy6N1IAJ3rzeR4nUGwhVu6mSpxN8fojOx0MapJjsiZ2lXsveMQx+rRBXi7T
 ALfvjbAcs8hPhGeEDL/dDY48AfSYxLCbaoOSQmN2kGJenj4R10CfHh9gZATTdGMX3s
 RzvEzEooJ/Ypib+X3yz2zTHfJ+FVOGcJJQ1tBuGyHIa9Oz5c+isz5ZpzwI3iETEOck
 7YoQXjZOZdGTr2tqLa3lo/6ygfJfEtNj4IXyPzmUM74etqOUzXgRotVnY2z52d7GEu
 ebNWvUEZcMcDzm2lOnT1BnT7kfhnWUz6Egndo1QsYDdhHX3iJnMsp6iDI1PFZO9Gk9
 DI4z/HGsP5s0g==
Message-ID: <db979264-a009-4e65-889a-99900455071a@denx.de>
Date: Sun, 19 Nov 2023 03:19:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: ci: Fix gadget reinit
Content-Language: en-US
To: Simon Holesch <simon@holesch.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
References: <20231119010453.294168-1-simon@holesch.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231119010453.294168-1-simon@holesch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/19/23 02:04, Simon Holesch wrote:
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
> ---
>   drivers/usb/gadget/ci_udc.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 2bfacfe59f..4ad991c72b 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -354,12 +354,45 @@ static int ci_ep_enable(struct usb_ep *ep,
>   	return 0;
>   }
>   
> +static void ep_disable(int num, int in)
> +{
> +	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
> +	unsigned int ep_bit, n, enable_bit;
> +
> +	if (in) {
> +		ep_bit = EPT_TX(num);
> +		enable_bit = CTRL_TXE;
> +	} else {
> +		ep_bit = EPT_RX(num);
> +		enable_bit = CTRL_RXE;
> +	}

Please use setbits_le32()

> +	/* clear primed buffers */
> +	do {
> +		writel(ep_bit, &udc->epflush);
> +		while (readl(&udc->epflush) & ep_bit)
> +			;
> +	} while (readl(&udc->epstat) & ep_bit);

wait_for_bit_le32() with suitable timeout

> +	/* clear enable bit */
> +	n = readl(&udc->epctrl[num]);
> +	n &= ~enable_bit;
> +	writel(n, &udc->epctrl[num]);

clrbits_le32()

> +}
> +
>   static int ci_ep_disable(struct usb_ep *ep)
>   {
>   	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
> +	int num, in;
> +
> +	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> +	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
> +
> +	ep_disable(num, in);
>   
>   	ci_ep->desc = NULL;
>   	ep->desc = NULL;
> +	ci_ep->req_primed = false;
>   	return 0;
>   }

With those fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
