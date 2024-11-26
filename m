Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE73D3B7C1
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E843890BC;
	Tue, 26 Nov 2024 09:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RBTiPQ22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F4F88FAA; Tue, 26 Nov 2024 09:51:23 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C00B8999F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso36008995e9.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732611079; x=1733215879;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=c1SOGBJe2eY+CpyYoaqGoPrrg6d26WLo0nboHZrgeJM=;
 b=RBTiPQ22mlWSz5RbcC8hPc8ClkGuExri/WISNja49/zvzXfSAG/b4GoIz8bQ1FVPmO
 DR+LwMdQxzYf1dty1DKOO+6yjnt2F+6tw5V4CG60GxdiYybIZW5kbMy9LyuG8+218RtE
 pmuofmFYkuIYaUImZHWrhwvoZvcFqAq3EsWVcVfI7rdPbxmWeZ3IoYGtOQ2f2uveOcFr
 IyB3Mqy3iKA7VUgRL97y5RVsaaU8DNyDddpcl8Vz7n9vIijcY0wM7wUbPPP3lbQU/m3f
 rJBiTjiM6YZ9JaWpkcz6cAoay+KxE0VLal1PvynJ8HWdT7Jo8RfrTn09W2Gv0iipj+7g
 c5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732611079; x=1733215879;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c1SOGBJe2eY+CpyYoaqGoPrrg6d26WLo0nboHZrgeJM=;
 b=wV98YNcJDdkA3BvMW/6HJst1eg00aUdFZAF9oLi+Y5anF4kKXs120ryEhrcWN5H7m1
 sWLp3OO7u0Aorz/yoersm9dcSt2O39dJp0h4KL5IqOc7T7h6k0hV63LYCIS6gTqsi2hd
 A++s1J2QL9YBw5g7dk3ijiNOnSJ1f4Ft6tVf4Ltc5LFLw8qnktiXNjo7O1WjsLtxtz98
 SA6CqsPRIZnv7o/YJA+OaNjX25aTW70FpIJKNqyATN6NA9sKdryHLJrp1rZYqEpbHRDt
 p6U+JidydqiiTiZFLU/TOkOeLvuW93sNAVMTq11UkNwFf+YKnjcx4VSqAeABFVNZ2CHt
 99tg==
X-Gm-Message-State: AOJu0YzCEWXaOGcYpr5lOH72NURFBmDpmmGI+IRvGoShmauJz8rmfhht
 vqWwmsZyivBDaeRKNxaAA5aKdsrcDcQT/62zncCrI28sOHZF9GLc553dDSCq7OU=
X-Gm-Gg: ASbGnctM3YVBcEmi7Ce1fJfcaKxMyoCb0QvResInE9U1oW4f+Xsdxs2calL0QZm6Vgr
 fQPdWar8Lrjv9EjLTM5lKj/XWH250iulA2/zO5ArYu5/4qM4Qj+e+jz+Z9M4j2P1SAVF5xJ0Zpz
 LNo87In2+mTzzhV9u0lJDCk7zrpxAyKTHey0U9a7Iq9lgDzFOQI7dfiVbPwKkH5Q1eSB5jAfsym
 rAjUAixsv27rFb4iZZS9HwcwjE+l6r3RdFZkmev5MGirwZ+Q7jmng==
X-Google-Smtp-Source: AGHT+IF/euqXeUqkLNYavYsbnM0pSS8E2WcjTM/SIZnb9r+EfkZ0+hyBaGUJzvFcrHk1OH9LHnQnrQ==
X-Received: by 2002:a05:600c:35cf:b0:434:9fca:d6c3 with SMTP id
 5b1f17b1804b1-434a4e72c47mr18550295e9.9.1732611079577; 
 Tue, 26 Nov 2024 00:51:19 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9e87sm12593318f8f.29.2024.11.26.00.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:51:15 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Holesch
 <simon@holesch.de>, Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
In-Reply-To: <20241126072956.64778-2-clamor95@gmail.com>
References: <20241126072956.64778-1-clamor95@gmail.com>
 <20241126072956.64778-2-clamor95@gmail.com>
Date: Tue, 26 Nov 2024 09:51:11 +0100
Message-ID: <871pyyqsxs.fsf@baylibre.com>
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

Hi Svyatoslav,

Thank you for the patch.

On mar., nov. 26, 2024 at 09:29, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> In the older USB controllers like for example in ChipIdea controller
> used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
> does not exist, so the new device address set during SET_ADDRESS
> can't be deferred by hardware, which causes the host to not recognize
> the device and give an error.
>
> Instead store it until ep completes to apply the change into the hw
> register as Linux kernel does. This should fix regression on old and
> and be compatible with newer controllers.
>
> Inspired by: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef15e5490edc7edf808d3477ab32e0e320792f65
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
>  drivers/usb/gadget/ci_udc.h |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index bbe03cfff1f..4bff75da759 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
>  	}
>  }
>  
> +/*
> + * This function explicitly sets the address, without the "USBADRA" (advance)
> + * feature, which is not supported by older versions of the controller.
> + */
> +static void ci_set_address(struct ci_udc *udc, u8 address)
> +{
> +	DBG("%s %x\n", __func__, address);
> +	writel(address << 25, &udc->devaddr);
> +}
> +
>  static void handle_ep_complete(struct ci_ep *ci_ep)
>  {
>  	struct ept_queue_item *item, *next_td;
>  	int num, in, len, j;
>  	struct ci_req *ci_req;
>  
> +	/* Set the device address that was previously sent by SET_ADDRESS */
> +	if (controller.next_device_address != 0) {
> +		struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
> +
> +		ci_set_address(udc, controller.next_device_address);
> +		controller.next_device_address = 0;
> +	}
> +
>  	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>  	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
>  	item = ci_get_qtd(num, in);
> @@ -783,7 +801,7 @@ static void handle_setup(void)
>  		 * write address delayed (will take effect
>  		 * after the next IN txn)
>  		 */
> -		writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
> +		controller.next_device_address = r.wValue;
>  		req->length = 0;
>  		usb_ep_queue(controller.gadget.ep0, req, 0);
>  		return;
> @@ -814,6 +832,9 @@ static void stop_activity(void)
>  	int i, num, in;
>  	struct ept_queue_head *head;
>  	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
> +
> +	ci_set_address(udc, 0);
> +
>  	writel(readl(&udc->epcomp), &udc->epcomp);
>  #ifdef CONFIG_CI_UDC_HAS_HOSTPC
>  	writel(readl(&udc->epsetupstat), &udc->epsetupstat);
> @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget, int is_on)
>  	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
>  	if (is_on) {
>  		/* RESET */
> +		controller.next_device_address = 0;
>  		writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->usbcmd);
>  		udelay(200);
>  
> diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc.h
> index bea2f9f3fe3..807f2084c1e 100644
> --- a/drivers/usb/gadget/ci_udc.h
> +++ b/drivers/usb/gadget/ci_udc.h
> @@ -105,6 +105,7 @@ struct ci_drv {
>  	struct ept_queue_head		*epts;
>  	uint8_t				*items_mem;
>  	struct ci_ep			ep[NUM_ENDPOINTS];
> +	u8				next_device_address;
>  };
>  
>  struct ept_queue_head {
> -- 
> 2.43.0
