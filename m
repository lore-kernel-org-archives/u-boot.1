Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1989DD1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740BF89080;
	Sun, 27 Oct 2024 17:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730045375;
	bh=JtTtbvoPmYDXTcPSATscWdVYGyf+fchIPYvxmoh5RzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t4jiY3Mtder/Vmdv/Ct9ZnqWiL3896/7F4qZOoFsTuyy9PqtFbBXUsIpyShKXuDz+
	 RXhDJsfTPE9KO07R6OTXQV2+9jwfZ7Y1VXHiHQlFhM9umuMfB5LgKn80e8Uy3DfrKi
	 TfNpRL5yR38MfeVxTfkmCzikuaLDYHtm4JbtdUUa3Ce4FIvcfwp689O0etwtwNHo3m
	 iODHwWU6fHxYT7vE97CYouEGKYWOgz37Plb98EWrFCGStuBVYXgooOh+asX5d2F1hx
	 WU44E4muQhphkdxYYcw3DZ7WdftmLRlc60TsJVNfcP0dfl1+BX62mrqW1oYcNWbKkQ
	 mN3W3KOUgWAtw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0C7F589031;
 Sun, 27 Oct 2024 17:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730045372;
 bh=JtTtbvoPmYDXTcPSATscWdVYGyf+fchIPYvxmoh5RzU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pCqVCatwYE9GHynWPoS4+LVtUg0RpjLH9I3MFPdNleJxvmyFh7hXL6hju+LbHGjvA
 YOD89YhsRDZrrJ6lCaz+GKhxIR2YL3s2ANUnCB89X2tOMfgPU+PmP5lr0oBsLMGupR
 FNBbrypPOl9BofIEd08l4ntISxZk35yL1zg+PMBdqJFwqnLdWwY82Ii1LrfJ9bh8MT
 ZtLyJHiMou2sI5K+Y/7C9UFiLH3dqsgdz68aK6cTri7qFSXd7++oJJt34JzFDuqC6f
 zod9znVrUv1I/nLfbvEZjHfnXkzfbBstWJEKLwqpM1K+QvGJUQw0rBAfnj+DDs+YID
 5rLue6UzlADfA==
Message-ID: <6f3ce823-93e8-46b5-86f3-52038efc5271@denx.de>
Date: Sun, 27 Oct 2024 17:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
To: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Holesch <simon@holesch.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013145820.85426-2-clamor95@gmail.com>
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

On 10/13/24 4:58 PM, Svyatoslav Ryhel wrote:

Sorry for the late reply.

> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
>   	}
>   }
>   
> +/*
> + * This function explicitly sets the address, without the "USBADRA" (advance)
> + * feature, which is not supported by older versions of the controller.
> + */
> +static void ci_set_address(struct ci_udc *udc, u8 address)
> +{
> +	DBG("%s %x\n", __func__, address);

log_debug() or dev_dbg() please.

> +	writel(address << 25, &udc->devaddr);
> +}
> +
>   static void handle_ep_complete(struct ci_ep *ci_ep)
>   {
>   	struct ept_queue_item *item, *next_td;
>   	int num, in, len, j;
>   	struct ci_req *ci_req;
>   
> +	/* Set the device address that was previously sent by SET_ADDRESS */
> +	if (controller.next_device_address != 0) {
> +		struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
> +
> +		ci_set_address(udc, controller.next_device_address);
> +		controller.next_device_address = 0;
> +	}
> +
>   	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>   	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
>   	item = ci_get_qtd(num, in);
> @@ -783,7 +801,7 @@ static void handle_setup(void)
>   		 * write address delayed (will take effect
>   		 * after the next IN txn)
>   		 */
> -		writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
> +		controller.next_device_address = r.wValue;

wValue is word , u16 , but next_device_address is u8 below , why ?

>   		req->length = 0;
>   		usb_ep_queue(controller.gadget.ep0, req, 0);
>   		return;
> @@ -814,6 +832,9 @@ static void stop_activity(void)
>   	int i, num, in;
>   	struct ept_queue_head *head;
>   	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
> +
> +	ci_set_address(udc, 0);
> +
>   	writel(readl(&udc->epcomp), &udc->epcomp);
>   #ifdef CONFIG_CI_UDC_HAS_HOSTPC
>   	writel(readl(&udc->epsetupstat), &udc->epsetupstat);
> @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget, int is_on)
>   	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
>   	if (is_on) {
>   		/* RESET */
> +		controller.next_device_address = 0;
>   		writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->usbcmd);
>   		udelay(200);
>   
> diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc.h
> index bea2f9f3fe3..807f2084c1e 100644
> --- a/drivers/usb/gadget/ci_udc.h
> +++ b/drivers/usb/gadget/ci_udc.h
> @@ -105,6 +105,7 @@ struct ci_drv {
>   	struct ept_queue_head		*epts;
>   	uint8_t				*items_mem;
>   	struct ci_ep			ep[NUM_ENDPOINTS];
> +	u8				next_device_address;

Should this be u16 ?
