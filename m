Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8092C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 07:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A741864ED;
	Mon,  4 Sep 2023 09:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="utAY4RR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEED486497; Mon,  4 Sep 2023 09:46:30 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F863868CB
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso11568535e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693813585; x=1694418385;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WHiIub8hNZcw7n3CPRU0DNyxQ6GKGaHhV9m7/+U1lxs=;
 b=utAY4RR9xqzYe9PcAP8zK/Gc4t2Bdo2QqzgwTOCm4ebebLVdCeQqMj4oRtQynF3VfE
 vEY9G/+5W7aqAg5QlG1qnnXvmo4E8dDqbs1lYpSIwTup0U2SXv5hvf0a7hI33F5bSHzI
 KwKzJU5BN9C4CX2WFcY2Coj5UPxPX77bLpo9aD1kPaP3V24/pdGQaezMU2JSD/4ivL8O
 Bex5JHp/J5518n37TfyXSTifV6/EZ6XTdgmHKRe1nQocBoffzfzsyCeGWwD8WdPu3TyW
 9ewfK5INkq8pAAPel3rQqf+iOpBWV2COYH2XyTdAGakQaOm2SQIY24FGW7Wvwbq63One
 ttAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693813585; x=1694418385;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WHiIub8hNZcw7n3CPRU0DNyxQ6GKGaHhV9m7/+U1lxs=;
 b=Qv+PCD9Js++O1UO1RHKafR1Xh0Ymmi1tBXe/jvs7Flj1LEXiFR64g3NQ2mXn1dh+LC
 xuh1RhZ3rcSKX99pzpYkQ22c3JtQoLB+F2QsMJtpHZQw6qt83dgHucV3g5XlaEO0QLQR
 VzbZj8cxPtzRQ2+na76gS1DIhVWiDnPGUk1HkxP1tfQgbWlMOZZAnbFdgwQTqJ9mrIWi
 O8LRFm5qpCk3gPpjmdm1R7TS1UQM3M4M5o+jNTayzr9CbjbegQgPPEQZ7hdi/xpoVamc
 6W3DbGjATdHZEnjPy2UIS5OEw7B3xrfu7h7XhalCLG/TZ+8OaoEufqw9ZQNclPRa23tY
 OAuQ==
X-Gm-Message-State: AOJu0YyTys59LrN+tEb3w1I+gQBX6LcaTiVPM2RZEFBodC3H7VV3h7ry
 Is7BaypVL45aOlPDuBsfr0ElHg==
X-Google-Smtp-Source: AGHT+IHTghE2DerrJ7u2U0myLo6QkC9dI9ux5V6zqO0l+UWlISJV2EsoVD1E7ylWHsuHv9cL90hjHg==
X-Received: by 2002:a05:600c:21cd:b0:401:5443:5591 with SMTP id
 x13-20020a05600c21cd00b0040154435591mr6753642wmj.20.1693813585113; 
 Mon, 04 Sep 2023 00:46:25 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a1c7704000000b003fefe70ec9csm16230551wmi.10.2023.09.04.00.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 00:46:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>, Dmitrii
 Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH v2 14/17] usb: gadget: acm: Use plain udevice for UDC
 controller interaction
In-Reply-To: <20230901095003.352930-14-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
 <20230901095003.352930-14-marex@denx.de>
Date: Mon, 04 Sep 2023 09:46:24 +0200
Message-ID: <87a5u22xf3.fsf@baylibre.com>
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

On ven., sept. 01, 2023 at 11:50, Marek Vasut <marex@denx.de> wrote:

> Convert to plain udevice interaction with UDC controller
> device, avoid the use of UDC uclass dev_array .
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---
> V2: No change
> ---
>  drivers/usb/gadget/f_acm.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
> index b2ddd1ada8b..de42e0189e8 100644
> --- a/drivers/usb/gadget/f_acm.c
> +++ b/drivers/usb/gadget/f_acm.c
> @@ -51,7 +51,7 @@ struct f_acm {
>  #define ACM_CTRL_RTS	BIT(1)	/* unused with full duplex */
>  #define ACM_CTRL_DTR	BIT(0)	/* host is ready for data r/w */
>  
> -	int controller_index;
> +	struct udevice *udc;
>  };
>  
>  static struct f_acm *default_acm_function;
> @@ -489,7 +489,7 @@ static void __acm_tx(struct f_acm *f_acm)
>  	int len, ret;
>  
>  	do {
> -		usb_gadget_handle_interrupts(f_acm->controller_index);
> +		dm_usb_gadget_handle_interrupts(f_acm->udc);
>  
>  		if (!(f_acm->handshake_bits & ACM_CTRL_DTR))
>  			break;
> @@ -520,7 +520,7 @@ static bool acm_connected(struct stdio_dev *dev)
>  	struct f_acm *f_acm = stdio_to_acm(dev);
>  
>  	/* give a chance to process udc irq */
> -	usb_gadget_handle_interrupts(f_acm->controller_index);
> +	dm_usb_gadget_handle_interrupts(f_acm->udc);
>  
>  	return f_acm->connected;
>  }
> @@ -543,7 +543,10 @@ static int acm_add(struct usb_configuration *c)
>  	f_acm->usb_function.descriptors = acm_fs_function;
>  	f_acm->usb_function.hs_descriptors = acm_hs_function;
>  	f_acm->usb_function.setup = acm_setup;
> -	f_acm->controller_index = 0;
> +
> +	status = udc_device_get_by_index(0, &f_acm->udc);
> +	if (status)
> +		return status;
>  
>  	status = usb_add_function(c, &f_acm->usb_function);
>  	if (status) {
> @@ -567,7 +570,7 @@ static int acm_stdio_tstc(struct stdio_dev *dev)
>  {
>  	struct f_acm *f_acm = stdio_to_acm(dev);
>  
> -	usb_gadget_handle_interrupts(f_acm->controller_index);
> +	dm_usb_gadget_handle_interrupts(f_acm->udc);
>  
>  	return (f_acm->rx_buf.size > 0);
>  }
> -- 
> 2.40.1
