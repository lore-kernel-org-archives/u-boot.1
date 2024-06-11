Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C6EC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 07:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8946E88440;
	Tue, 11 Jun 2024 09:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cVGyFfhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AB088365; Tue, 11 Jun 2024 09:16:49 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C5CB88440
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35f1c209893so2718008f8f.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718090205; x=1718695005;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JuCmpmbUNpCO4aYAnHlUOmL7j4cc1bauf/SIBmDJoAY=;
 b=cVGyFfhN1BSu0+Vd03WrvbzDfktMWgu1v8YK6yKIw7E0saBu2BoU8y76Dnk9jeZBe2
 XuZ0p37u1YtUc6jxDZX3QfED89AeRPXqeTHt4xtH68sTLW5VTiPVUop8+VyY0TxH807x
 qvl9Djk5k3jJq4OcepHw2Atrf4d2NHAc6jyE8jq9ctfJjQHtGxQh+qMbUQJbEaL8mvES
 7MGxjw+q06f04CeNADbuLZRFluKVA6F5YRuKufntL/9v9LqXgIazSua8sEzVIMiEXIyr
 KSy3WqZbm17OGgj1BvfHTdkohMcJ/Neo8XbZZDBx7XIpAtaO0R0taVIYs+8f2IP+x28V
 nOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718090205; x=1718695005;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JuCmpmbUNpCO4aYAnHlUOmL7j4cc1bauf/SIBmDJoAY=;
 b=uHJOr/dzGEj0utVRmnu+Mbs6xR7xG0w4haHzHF50JXXz3/SIPnmy2vMOui4yZNIl5V
 VGRlGQk9ZswYho+7zADAde9A8yMAycFQzTnilT0K5CppPr4m8TkPE/JrvlmhFA8Syru3
 nJvSRsA80iDUsYRWD11fbtXt0bNOcQOPipGQdeArOp8LZ7OF/IMdb42pVFdT483UfS+1
 1nbdtR8MUeIuTPLfNr95ZGhFIvODxj4IM45MX852OGZokkQJDdTQ7hxrziYRFccYVGdE
 Gx8ZcO3pR9e4hHa9b3R9p0DzyMKpQxTPhK1Qz68dkSXramIl5Lp31dA6QHmlcNcic4Xi
 DrkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtn0yzs7i/K7ZLduE5Tkblyk2r+dlNssv//yfCMfDP1AiTnRKkUVx+vHpGOAHOqN3bA2ik4je8txBmycbLbgU89GArpw==
X-Gm-Message-State: AOJu0Ywrx0q3RPRdJY25TvjOnStpRWDl/T5K1Wxzat4Wn7fl6xB4owj7
 aXJWpM+ST3X1iIiS96p1cryc5bm+pibIBr4BqJ7U0bw2xav0E7zLgcSE0TyPJTFb0Mwcexn1+1+
 cGHs=
X-Google-Smtp-Source: AGHT+IGXnDKoENIuHQDV44q76ivRpBl/rsdTOhUv0ZHSjThLbbFnWNrEMqx2tC9Ij6815cie/JKNUw==
X-Received: by 2002:a5d:5987:0:b0:355:4cb:5048 with SMTP id
 ffacd0b85a97d-35efedd95f9mr10244354f8f.43.1718090205430; 
 Tue, 11 Jun 2024 00:16:45 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f24fb3fa4sm4355008f8f.102.2024.06.11.00.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 00:16:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/6] usb: gadget: ether: Drop
 usb_gadget_controller_number()
In-Reply-To: <20240609213449.194762-2-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
 <20240609213449.194762-2-marek.vasut+renesas@mailbox.org>
Date: Tue, 11 Jun 2024 09:16:41 +0200
Message-ID: <87a5js0x0m.fsf@baylibre.com>
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
> This patch converts this gadget to use the U-Boot version instead of a
> random 2 or 3 plus the UDC number. Linux stopped using this functionality
> in 2012, remove it from U-Boot as well.
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
>  drivers/usb/gadget/ether.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
> index b8b29d399b1..e76464e121b 100644
> --- a/drivers/usb/gadget/ether.c
> +++ b/drivers/usb/gadget/ether.c
> @@ -22,8 +22,8 @@
>  #include <malloc.h>
>  #include <memalign.h>
>  #include <linux/ctype.h>
> +#include <version.h>
>  
> -#include "gadget_chips.h"
>  #include "rndis.h"
>  
>  #include <dm.h>
> @@ -1998,19 +1998,8 @@ static int eth_bind(struct usb_gadget *gadget)
>  		rndis = 0;
>  	}
>  
> -	gcnum = usb_gadget_controller_number(gadget);
> -	if (gcnum >= 0)
> -		device_desc.bcdDevice = cpu_to_le16(0x0300 + gcnum);
> -	else {
> -		/*
> -		 * can't assume CDC works.  don't want to default to
> -		 * anything less functional on CDC-capable hardware,
> -		 * so we fail in this case.
> -		 */
> -		pr_err("controller '%s' not recognized",
> -			gadget->name);
> -		return -ENODEV;
> -	}
> +	gcnum = (U_BOOT_VERSION_NUM << 4) | U_BOOT_VERSION_NUM_PATCH;
> +	device_desc.bcdDevice = cpu_to_le16(gcnum);
>  
>  	/*
>  	 * If there's an RNDIS configuration, that's what Windows wants to
> -- 
> 2.43.0
