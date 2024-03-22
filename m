Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74BC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 08:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A27F488197;
	Fri, 22 Mar 2024 09:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R53rgXUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61EF28816F; Fri, 22 Mar 2024 09:17:09 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5A388197
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 09:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C25483FB77
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711095424;
 bh=waoreCry+a1Vb7hradii+A7Cq8C1LwGB6/0iMWUCzak=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=R53rgXUBS+2mUzYs0BNbq4seyFMGl+oKI5PeHlPvzMWGAySZ6WPK9aY1oOWNTcbHg
 4BBxW+JjLt21R05p2IjA4gXCjz3e+OnSMOtwU9tYF0uuWbu3sumdtIAF2anwHCSyLE
 yC0UesqJw5pdF0A60GtX3xvwfpmKGeMa7md4qPex3DjiSfLd7UQ2bzsq3o0N+Hvh4x
 7KcgQXY9uCgATp4TH4XWa8DPkbR9/H+Vcth8wa5sTjaJZkr08KUhTH88xPflsc2jzc
 xOg/srX8ywZD5ppHz5JUwA5tevev1Ztf7XG5PuecYTn6nug8fv77k3ZvNdRBr0Gbxw
 xBAQCCvX66NJg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e4478a3afso9486085e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 01:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711095424; x=1711700224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=waoreCry+a1Vb7hradii+A7Cq8C1LwGB6/0iMWUCzak=;
 b=A4PwQxHu+mueAVu2Cm+WuOIRIxflZlp5m6zSwoxvvveDo63+4tA5BRdKblzBaZn6Dv
 jC3kew9vygZq3+w0IVphcAcXZCNm9Hma+DZ2iM2yg733p0+yMV/08/AFt2txvOvLbsdM
 fvWng1Ngh7XAy8wZdFhduiz4cs4MiMxaLTryz8mD794kcSImF1MiJQAdbg/R+T1JKUzN
 UpEs2Xk+bwu186UbWd7JAoRCC/LyXL5bfIRSyhuLj9abvoCLiRkDfnklMg+VKxPY8tHW
 Hc1nDHcbEqOHfnGfmouzTK7PzEtdpxBAjsRg07jMuEnamON1evdmZrp5wH9eS2P/96nf
 thew==
X-Gm-Message-State: AOJu0YzkboIbn1QlQ28fwqEuBJ9aIYrEDfvo14EcfRg1TJ2Kb/b2zJtS
 UPHvhynlFB6rlzsj7yHgh914JXqenbrRmFWOfVHsRwtaNfmVYvObD9JlMsnL+mbfG2t2xod+sCl
 0uxn7VoSfon0VxKjxK7jxiM2/R/1nZzYsUwwv6bEchwaq8VZabww1dIeljTOB25RtLu4=
X-Received: by 2002:a05:600c:354a:b0:414:37f:18dc with SMTP id
 i10-20020a05600c354a00b00414037f18dcmr1041976wmq.1.1711095423801; 
 Fri, 22 Mar 2024 01:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj5hISS3UXi1u508xBRgQtssS9QgIDWAJCncZvR5xeiHkOsMVlQzyKga4tdgzD+fhhAyAylA==
X-Received: by 2002:a05:600c:354a:b0:414:37f:18dc with SMTP id
 i10-20020a05600c354a00b00414037f18dcmr1041946wmq.1.1711095423390; 
 Fri, 22 Mar 2024 01:17:03 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 k37-20020a05600c1ca500b004140a3d34fasm2281801wms.41.2024.03.22.01.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 01:17:03 -0700 (PDT)
Message-ID: <082bfd68-1dd4-4bc5-acb3-1000de1a19b8@canonical.com>
Date: Fri, 22 Mar 2024 09:17:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] usb: xhci: Set up endpoints for the first 2
 interfaces
To: j@jannau.net
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
References: <20240322-asahi-keyboards-v3-0-3106dd4c4e19@jannau.net>
 <20240322-asahi-keyboards-v3-2-3106dd4c4e19@jannau.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240322-asahi-keyboards-v3-2-3106dd4c4e19@jannau.net>
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

On 3/22/24 08:47, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> The xhci driver currently only does the necessary initialization for
> endpoints found in the first interface descriptor. Apple USB keyboards
> (released 2021) use the second interface descriptor for the HID keyboard
> boot protocol. To allow USB drivers to use endpoints from other
> interface descriptors the xhci driver needs to ensure these endpoints
> are initialized as well.
> Use USB_MAX_ACTIVE_INTERFACES to control how many interface descriptors
> are considered during endpoint initialisation.
> For now define it to 2 as that is sufficient for supporting the Apple
> keyboards.
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   drivers/usb/host/xhci.c | 31 +++++++++++++++++++------------
>   include/usb.h           |  6 ++++++
>   2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 534c4b973f..741e186ee0 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -606,24 +606,28 @@ static int xhci_set_configuration(struct usb_device *udev)
>   	int slot_id = udev->slot_id;
>   	struct xhci_virt_device *virt_dev = ctrl->devs[slot_id];
>   	struct usb_interface *ifdesc;
> +	unsigned int ifnum;
> +	unsigned int max_ifnum = min((unsigned int)USB_MAX_ACTIVE_INTERFACES,

no_of_if being of type u8 limits the number of interfaces to 255. 
Introducing USB_MAX_ACTIVE_INTERFACES limit us to the first two 
interfaces. Is this really needed? Handling all interface would avoid 
the introduction of artificial limitations which may hit us on the next 
device.

Best regards

Heinrich

> +				     (unsigned int)udev->config.no_of_if);
>   
>   	out_ctx = virt_dev->out_ctx;
>   	in_ctx = virt_dev->in_ctx;
>   
> -	num_of_ep = udev->config.if_desc[0].no_of_ep;
> -	ifdesc = &udev->config.if_desc[0];
> -
>   	ctrl_ctx = xhci_get_input_control_ctx(in_ctx);
>   	/* Initialize the input context control */
>   	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG);
>   	ctrl_ctx->drop_flags = 0;
>   
> -	/* EP_FLAG gives values 1 & 4 for EP1OUT and EP2IN */
> -	for (cur_ep = 0; cur_ep < num_of_ep; cur_ep++) {
> -		ep_flag = xhci_get_ep_index(&ifdesc->ep_desc[cur_ep]);
> -		ctrl_ctx->add_flags |= cpu_to_le32(1 << (ep_flag + 1));
> -		if (max_ep_flag < ep_flag)
> -			max_ep_flag = ep_flag;
> +	for (ifnum = 0; ifnum < max_ifnum; ifnum++) {
> +		ifdesc = &udev->config.if_desc[ifnum];
> +		num_of_ep = ifdesc->no_of_ep;
> +		/* EP_FLAG gives values 1 & 4 for EP1OUT and EP2IN */
> +		for (cur_ep = 0; cur_ep < num_of_ep; cur_ep++) {
> +			ep_flag = xhci_get_ep_index(&ifdesc->ep_desc[cur_ep]);
> +			ctrl_ctx->add_flags |= cpu_to_le32(1 << (ep_flag + 1));
> +			if (max_ep_flag < ep_flag)
> +				max_ep_flag = ep_flag;
> +		}
>   	}
>   
>   	xhci_inval_cache((uintptr_t)out_ctx->bytes, out_ctx->size);
> @@ -637,9 +641,12 @@ static int xhci_set_configuration(struct usb_device *udev)
>   	xhci_endpoint_copy(ctrl, in_ctx, out_ctx, 0);
>   
>   	/* filling up ep contexts */
> -	err = xhci_init_ep_contexts_if(udev, ctrl, virt_dev, ifdesc);
> -	if (err < 0)
> -		return err;
> +	for (ifnum = 0; ifnum < max_ifnum; ifnum++) {
> +		ifdesc = &udev->config.if_desc[ifnum];
> +		err = xhci_init_ep_contexts_if(udev, ctrl, virt_dev, ifdesc);
> +		if (err < 0)
> +			return err;
> +	}
>   
>   	return xhci_configure_endpoints(udev, false);
>   }
> diff --git a/include/usb.h b/include/usb.h
> index 09e3f0cb30..3aafdc8bfd 100644
> --- a/include/usb.h
> +++ b/include/usb.h
> @@ -49,6 +49,12 @@ extern bool usb_started; /* flag for the started/stopped USB status */
>    */
>   #define USB_TIMEOUT_MS(pipe) (usb_pipebulk(pipe) ? 5000 : 1000)
>   
> +/*
> + * The xhcd hcd driver prepares only a limited number interfaces / endpoints.
> + * Define this limit so that drivers do not exceed it.
> + */
> +#define USB_MAX_ACTIVE_INTERFACES	2
> +
>   /* device request (setup) */
>   struct devrequest {
>   	__u8	requesttype;
> 

