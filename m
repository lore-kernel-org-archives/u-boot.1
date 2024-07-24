Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B363C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E97F8883E;
	Wed, 24 Jul 2024 12:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NOgr1O88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5971988800; Wed, 24 Jul 2024 12:06:13 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B418889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42726d6eca5so48219435e9.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721815569; x=1722420369;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SjYn9GR82II85Oda9JSCYJ1boz4AI/ScYpPX97cucEA=;
 b=NOgr1O88SPTNdtNfUuv0lkSgV0Ic4Tn044kz2hL1/yEXtBamrE75zzK8buezyQf2ez
 jnKXaOBVwPAkrkaVsfe66jrb9JQwDUywoaknkVzQskk5N70lE7f3kAaMyl+MCE0bU6UX
 DXlaRswZVozo3upFf/VRXDsuc7LzPx/nNS0fg9kxtsDe0bjqdxqXEqzvvK11YUs9Q8UU
 uDkQPQElFxOCgqs4je+N/Qi421umvYc4cVDq9SpwkfgQ2bH04VkslMiy8qtucfyyLWRE
 qT5TMzEDh42N1g1FK6Fw9JE382z+I2A5XOWrJf5yCpakjbhz1A7sSyQwfJjAqRC9z0jK
 SV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721815569; x=1722420369;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SjYn9GR82II85Oda9JSCYJ1boz4AI/ScYpPX97cucEA=;
 b=TuGvb/Z27cggDc70WTzuTkZF/fYUR4g+8DNx0EhJ5vKZm/jMNtqqZzeZDIKt/YNZd0
 fO7O5luX7d0jKuNyqffOXRMB9FLxi/U24WmwM0dSKlbWqBliwIwNVSPOIkeJkxOK52FX
 mrKOSwOybi2xk9UpWOw2v4CVjYZmDLimFhXIB0bek9sgm/YDD0Enwxu4WO7rYIX3F5K5
 Tzn0a2VoTzL+Y6OhqKt0k1tsYyixht9vP68eIlWkCo/56zXXJ8++AXP45U3wVuNsoW9V
 nztI2zeaD9jDhc0JTgr4p6J0icijqmS98rsNBx0ep2CSx7vphuAV2z40HwEyV3KymPgT
 anow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnMHM/HUERAHwvG3oy3yE7mOI9655bSSAGju7a7QYdpkD/rILwnzcY0LDrd9vzoWUBleHc3dIwGbeRELBZDLueJ1G5nw==
X-Gm-Message-State: AOJu0YwnEDScUZiILAla2RwfuXC9Hp+v5fRKOzAYOjt4+gNudhrX+WW9
 MdDj63CQs5DcJ54Lv16dO/1PDxcfZM94XCEmuQwP3P28oYuh7mRl6ILqYcQRHrE=
X-Google-Smtp-Source: AGHT+IGrkFSmfx4IBDHxSucvgPF8pnjqU+0eCPLIm5nprnwqNXya2HJZKzFXIxtedWA/DATklTHQ3A==
X-Received: by 2002:adf:f00c:0:b0:368:6336:6051 with SMTP id
 ffacd0b85a97d-369f09b6294mr1564507f8f.22.1721815568659; 
 Wed, 24 Jul 2024 03:06:08 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b24csm13842004f8f.25.2024.07.24.03.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:06:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/7] usb: gadget: atmel: Sort includes
In-Reply-To: <20240723131817.262596-2-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-2-zli@ogga.fr>
Date: Wed, 24 Jul 2024 12:06:07 +0200
Message-ID: <87ikwv5ckw.fsf@baylibre.com>
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

> Sort includes in alphabetical order.
>
> Signed-off-by: Zixun LI <zli@ogga.fr>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f99553df8d..5f78251fdb 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -7,16 +7,16 @@
>   *			   Bo Shen <voice.shen@atmel.com>
>   */
>  
> -#include <linux/bitops.h>
> -#include <linux/errno.h>
> +#include <malloc.h>
>  #include <asm/gpio.h>
>  #include <asm/hardware.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/atmel_usba_udc.h>
> -#include <malloc.h>
>  
>  #include "atmel_usba_udc.h"
>  
> -- 
> 2.45.2
