Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30705C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 07:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A12885DF;
	Tue, 11 Jun 2024 09:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q5QIaBII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DC0885EC; Tue, 11 Jun 2024 09:20:39 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD4B885D7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35f2c9e23d3so230037f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718090437; x=1718695237;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lw/xoFc/wCdP6H+9YsK1vQrjMa6OxYcAteXWxBlYnKs=;
 b=q5QIaBIIyb1ugesMFR0jXi+0j+XIaaB9HLxjk673v4G+thOt55urOCLsufO+wQ0pyP
 lS/yWCng0snK2qrsPV+44jE2ahPs4qzoZ3rT7UscVWHh2hLot+FE98RYAs/TBh0khcmM
 znuq3xWIN4vIadfCs3CyP3OkFTkmXtIHkI5WSJ+5zn8Nz0mqG6NXiuNA3Z8y3poc8S7K
 fBWV7giPjwqzrpX5lozmuI9gUn5DOGub5x2aw1HEcFG60tGBUdKEOPj0WvAK6kt8GlGA
 XzsqrKUgQ+WMIGaGZErd+stq4+FY+iVPwtBUt0qEAp/geMxU+GQeDLAUafDFwsvIi8vd
 ycww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718090437; x=1718695237;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lw/xoFc/wCdP6H+9YsK1vQrjMa6OxYcAteXWxBlYnKs=;
 b=VfVHl749xFCFb5ooBpqGMO7GgYInavRa7jt3L7EgrIt6Ue/zg53L4ZROjgoZhLaX98
 LlDKEaxR41fNJHt0+gMSS/um30qA6JotynI7zv/7T8PwyNHBUYNaiw9CIWWkAsChn64/
 b/SsYTs5WdB94xoad41+jEWVz8qtp1L7rvmw1aRdTRFGoGT11K6ZgjUg0NDEsgNpLkzg
 +sh7F67j6P/TAS9Eg+hLHIycU3PMSr7N/EykDZsbrL7h2+nj+ySgeeoxn6OjHR1R2N37
 9Rf9YZklgSpynegTz6TAcbACS4vNNHpkVbuQj4urjf7vLGph+7FfLT1cRn8VvKkQ1v1o
 DOsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Rlsd0SJsE0fYNUHA3YiKJRATYvexaCZEQ5UYVbPwxzJw3BLtl1iw7WUjn2sm6cDh8w52NhkG4JZYM4eWlJjI4B30Lg==
X-Gm-Message-State: AOJu0YzTOuwYFL3qBJP3HwjT+GteDIr/SBeohuNWz/hSB6GdP+WHhiVt
 6Sk0s2qKFWj7jhHn6LayRst1PnEzYFyUQaNOgpCAXY7C3VaIGwQqA3ejaMBYCyw=
X-Google-Smtp-Source: AGHT+IGbmG2mKNTHPHt67XfPTnLnBXov4ZO95pDLIRbMGIQBISDOfnjhpSq3+3dWwW3OZHCd/9RVNw==
X-Received: by 2002:adf:fc48:0:b0:35f:9ab:d06c with SMTP id
 ffacd0b85a97d-35f2b273b70mr1359396f8f.5.1718090436876; 
 Tue, 11 Jun 2024 00:20:36 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421791b1ea9sm114617135e9.21.2024.06.11.00.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 00:20:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/6] usb: gadget: Drop usb_gadget_controller_number()
In-Reply-To: <20240609213449.194762-3-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
 <20240609213449.194762-3-marek.vasut+renesas@mailbox.org>
Date: Tue, 11 Jun 2024 09:20:33 +0200
Message-ID: <877cew0wu6.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On dim., juin 09, 2024 at 23:32, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The bcdDevice field is defined as
> |Device release number in binary-coded decimal
> in the USB 2.0 specification. We use this field to distinguish the UDCs
> from each other. In theory this could be used on the host side to apply
> certain quirks if the "special" UDC in combination with this gadget is
> used. This hasn't been done as far as I am aware. In practice it would
> be better to fix the UDC driver before shipping since a later release
> might not need this quirk anymore.
>
> This patch removes the newly unused function. Linux stopped using this
> functionality in 2012, remove it from U-Boot as well.
>
> Matching Linux kernel commit:
> ed9cbda63d45 ("usb: gadget: remove usb_gadget_controller_number()")
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/usb/gadget/gadget_chips.h | 62 -------------------------------
>  1 file changed, 62 deletions(-)
>
> diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
> index 98156c312d2..316051686c4 100644
> --- a/drivers/usb/gadget/gadget_chips.h
> +++ b/drivers/usb/gadget/gadget_chips.h
> @@ -146,65 +146,3 @@
>  #else
>  #define gadget_is_dwc2(g)        0
>  #endif
> -
> -/**
> - * usb_gadget_controller_number - support bcdDevice id convention
> - * @gadget: the controller being driven
> - *
> - * Return a 2-digit BCD value associated with the peripheral controller,
> - * suitable for use as part of a bcdDevice value, or a negative error code.
> - *
> - * NOTE:  this convention is purely optional, and has no meaning in terms of
> - * any USB specification.  If you want to use a different convention in your
> - * gadget driver firmware -- maybe a more formal revision ID -- feel free.
> - *
> - * Hosts see these bcdDevice numbers, and are allowed (but not encouraged!)
> - * to change their behavior accordingly.  For example it might help avoiding
> - * some chip bug.
> - */
> -static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
> -{
> -	if (gadget_is_net2280(gadget))
> -		return 0x01;
> -	else if (gadget_is_dummy(gadget))
> -		return 0x02;
> -	else if (gadget_is_sh(gadget))
> -		return 0x04;
> -	else if (gadget_is_goku(gadget))
> -		return 0x06;
> -	else if (gadget_is_mq11xx(gadget))
> -		return 0x07;
> -	else if (gadget_is_omap(gadget))
> -		return 0x08;
> -	else if (gadget_is_n9604(gadget))
> -		return 0x09;
> -	else if (gadget_is_at91(gadget))
> -		return 0x12;
> -	else if (gadget_is_imx(gadget))
> -		return 0x13;
> -	else if (gadget_is_musbhsfc(gadget))
> -		return 0x14;
> -	else if (gadget_is_musbhdrc(gadget))
> -		return 0x15;
> -	else if (gadget_is_atmel_usba(gadget))
> -		return 0x17;
> -	else if (gadget_is_fsl_usb2(gadget))
> -		return 0x18;
> -	else if (gadget_is_amd5536udc(gadget))
> -		return 0x19;
> -	else if (gadget_is_m66592(gadget))
> -		return 0x20;
> -	else if (gadget_is_ci(gadget))
> -		return 0x21;
> -	else if (gadget_is_dwc3(gadget))
> -		return 0x23;
> -	else if (gadget_is_cdns3(gadget))
> -		return 0x24;
> -	else if (gadget_is_max3420(gadget))
> -		return 0x25;
> -	else if (gadget_is_mtu3(gadget))
> -		return 0x26;
> -	else if (gadget_is_dwc2(gadget))
> -		return 0x27;
> -	return -ENOENT;
> -}
> -- 
> 2.43.0
