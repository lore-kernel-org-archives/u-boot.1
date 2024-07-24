Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17E8C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E8EE888F6;
	Wed, 24 Jul 2024 12:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yHo+1XdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F668890A; Wed, 24 Jul 2024 12:18:27 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A94B88881
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3685afd0c56so2069979f8f.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721816305; x=1722421105;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qs4VvlR8m1eNYQtpf+3ipFG417XOysEDoJoQTJC8sL8=;
 b=yHo+1XdKE30tzYUrw5Bk4Hp222eqCl5iB3wT9lEp35/CYmDkA7Aa52HOuuGhd3UXFZ
 D22MoB/YsbuCMWyxjyG24DVtFoDrIHI0DVLdqCpG9RUBcWhTAdiPK3pUjBshztEoo5NW
 U+Vhl8C8J7A7MRSRYyUXSxFmFUyMcc1QvQyTPDWi8xQV1+7zq3gy7uey+dfmh6SG205p
 SAb1wNo/fNHNsZLzmDFw7s5/HDh7euRFapHinB9sekbH/a1IMqIXqafzJCbYMHaH4Ohz
 6NVW1Qhb1+ijE9z2Bm1V3GoG05Qqxe48Vvb1qlL1/uI2AHHHkynEh1bgoxj+yKm0gr5u
 keLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816305; x=1722421105;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qs4VvlR8m1eNYQtpf+3ipFG417XOysEDoJoQTJC8sL8=;
 b=D4YIbIzjp/7Gcwn4vnlDKyvg02KW+5GsEOYnRph5+S/+d3zxv1QhvKKR/z0e6KHN++
 +2U6grdk8v+iM7UOyOSlUeXe8re85zD52KA1EkU9hCQahcrTkTjZQI1sDku7wEjh64nA
 5Kw3I/ySY+bO/vXf4z/I6LmNqGiXrBejYLEC5/OFchHSX1jMNF9KJeQtHeyQRViCcfz5
 ywGHm6dZjr3LVdmzXQHRDmOCqcthbcNKAaLsqEzhkKnwjkAD7LBpQI6lrbdI548/Lq99
 up99X77z01383eI5nzqAzGZQlVBsgXa4pfAnJd8eRSBOB13CRzdmYLr07GrNAUINCBkU
 A1iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbILRoUBbcyiXTQpEvayYAgMkmpod8tkCUwgz9q65NcwBLUyscYrTRcmgJs6BXgNAclJPqTKMWQBuKW8/tIOWliMeUQQ==
X-Gm-Message-State: AOJu0Yz9G8FfujVD9t9hhXLnegQSyhUPh7f+cjIlCFqBurchrpRQaY4i
 7QhpcfPbkLAJKxVjaXOTzrlUWMoFCqKEv71bnuYlrXAyEktHil5c34j3MyaNAL4=
X-Google-Smtp-Source: AGHT+IHeduLb1Bh+ENefMAIaameWGfsOIoTLQhSRAPk1RMB/qurNBrP6zhALWSPS1Bpuv1+398QZVg==
X-Received: by 2002:a05:6000:1568:b0:368:4e86:14cc with SMTP id
 ffacd0b85a97d-369f5b0ec39mr1432313f8f.10.1721816304519; 
 Wed, 24 Jul 2024 03:18:24 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868420fsm13955400f8f.3.2024.07.24.03.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:18:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 6/7] usb: gadget: atmel: Add attach/detach support
In-Reply-To: <20240723131817.262596-7-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-7-zli@ogga.fr>
Date: Wed, 24 Jul 2024 12:18:23 +0200
Message-ID: <874j8f5c0g.fsf@baylibre.com>
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

Hi Zixun,

Thank you for the patch.

On mar., juil. 23, 2024 at 15:18, Zixun LI <admin@hifiphile.com> wrote:

> Add controller attach/detach support by using
> usb_gadget_ops.pullup() method.
>
> Signed-off-by: Zixun LI <zli@ogga.fr>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index ea9ad7585e..a7b96449f8 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -506,10 +506,28 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
>  	return 0;
>  }
>  
> +static int usba_udc_pullup(struct usb_gadget *gadget, int is_on)
> +{
> +	struct usba_udc *udc = to_usba_udc(gadget);
> +	u32 ctrl;
> +
> +	ctrl = usba_readl(udc, CTRL);
> +
> +	if (is_on)
> +		ctrl &= ~USBA_DETACH;
> +	else
> +		ctrl |= USBA_DETACH;
> +
> +	usba_writel(udc, CTRL, ctrl);
> +
> +	return 0;
> +}
> +
>  static const struct usb_gadget_ops usba_udc_ops = {
>  	.get_frame		= usba_udc_get_frame,
>  	.wakeup			= usba_udc_wakeup,
>  	.set_selfpowered	= usba_udc_set_selfpowered,
> +	.pullup			= usba_udc_pullup,
>  };
>  
>  static struct usb_endpoint_descriptor usba_ep0_desc = {
> -- 
> 2.45.2
