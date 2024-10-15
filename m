Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801E4CFC27F
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 09:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD1D88DED;
	Tue, 15 Oct 2024 11:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PY6W68z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DED488C7C; Tue, 15 Oct 2024 11:56:54 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F0689079
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43057f4a16eso45014505e9.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728986210; x=1729591010;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qBtp+F+IlaTbTpNlDp658bfu5QSihSpwxJ0eIIzsryM=;
 b=PY6W68z0c9e98BjzkaBAiWaAKHuEKbIlPdUvviQtGnEw5ln60aYDCCptux/a8Je+6x
 B6Hq+DwKsmcZ/GWL8ZsHQapRsZcwaVi7s4ajT+QgR7vSutlpIGFtMagzFmPBkxyRsBbq
 UWqEWsFIK9XqXmUE8H8C8rjlQUxlp4OQSg0TGeEp542THDe05ItKy3OG1tLGwk2WGfX4
 M+lGPar7WhJ0viCI5tJELTiJ29eiI7Nj3AwuLfbr+OCStOTyARPB+ACRFfgGRctmNJwx
 0a9O2LUPTpsvdpv9u+3Fn8DzdCJnDtJna1UEXD1wMn+8ULYsldBAhkrThJYAsjyX5Qgc
 FEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728986210; x=1729591010;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qBtp+F+IlaTbTpNlDp658bfu5QSihSpwxJ0eIIzsryM=;
 b=LbzOcHbupLqknYhK32/n4CwZaTwPT+nYi2uVWSXn1TRkgAjBtR2d6EwiDmmKKFsiXV
 Gv5S5YxO5q4czsUxyByhCwsETM+GG2PGrDa6WRJgvdf6dYmfbIgz9aogw3E+5SPd0X5/
 D3WSbLTSjXbg4y/SvuuBfWjI0qu6vZc18m03H3CzGnykOEPFS+s9HjLndWL9n+caWwbm
 gX4v315LS4XE7ja+FhC5UB/74ooFhvfTXh6+gQt9/TTBg46pnf8czqPZJvO+SMvxDfLt
 9TEgpDkhqS32KDjpReOBHuxSskYh2FvhtZqeRroHKDhwS9F5g5ZCij5y7ZIzG1Y3TcKF
 H/rg==
X-Gm-Message-State: AOJu0YxZktJ2dsxig/9akZicFSfu8iMjkWHgxRnVf3aERzjrU3mBpJ2V
 FjSSuFrewNgb+F21G76Lf0W7zFHPpb+WJj9o5Wd8J2PBbWotUhazDnLcz35KnH4=
X-Google-Smtp-Source: AGHT+IG1pix6341x+yFnDMOTsnB0hL4RZWeAb50zkwvtZSQwO6vHVmeVsHFUYNN7X1rjiv1neGkjYQ==
X-Received: by 2002:a05:600c:4e8a:b0:42c:af06:718 with SMTP id
 5b1f17b1804b1-4311df435e7mr134869265e9.28.1728986210456; 
 Tue, 15 Oct 2024 02:56:50 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87d48sm1130732f8f.32.2024.10.15.02.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 02:56:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Holesch
 <simon@holesch.de>, Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
In-Reply-To: <20241013145820.85426-2-clamor95@gmail.com>
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
Date: Tue, 15 Oct 2024 11:56:47 +0200
Message-ID: <87sesxzo2o.fsf@baylibre.com>
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

On dim., oct. 13, 2024 at 17:58, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

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

Since this is based on a linux commit, can we please mention the
revision in the commit message?

Per my understanding, this would be:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef15e5490edc7edf808d3477ab32e0e320792f65

>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
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

Comparing to
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef15e5490edc7edf808d3477ab32e0e320792f65,

Can we please keep similar logic ?
Having both:
- bool setaddr
- u8 address

This way, we keep the diff with the linux driver a bit lower.

>  };
>  
>  struct ept_queue_head {
> -- 
> 2.43.0
