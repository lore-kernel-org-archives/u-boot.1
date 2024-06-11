Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82986C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 07:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2392883DB;
	Tue, 11 Jun 2024 09:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3aMOo+tm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA21885D0; Tue, 11 Jun 2024 09:14:31 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA206883DB
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-421757d217aso33186495e9.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718090069; x=1718694869;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YxwKzD94gHFPmEIGlISH4+cM/BWxNmEcdz9s5jwd86Y=;
 b=3aMOo+tmT+Dh67D6D+i6+K7j2gnF3v/sKf+FNS5h98TA0TjxVq9LWC+R377WQ7Z81Z
 KIkOiXTuHTRB+Gc7EKbnxb99TGMsoP5XOqUWBpwdpfDjTZF9GrZTTKGBLT0Vup8kA1Th
 ABQmo6yF7YyjmfG+b39s1QgmRtVWxi+JBp/SQARDo3PZo6mBcOu5ZR+a5t/cd6cK9ozJ
 J5XDfjKXguEICt/RoyQIbL2muNHBCeeXqARRG0he566bbhlz21xIPRHwIP8M/qQwhE/e
 cxA+NBPDZH++ymOYF4XLC8bxbe9Qy9RRiz9pZCJVIrrglb5WPDmPwhe66QMcpwvv96Jh
 k9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718090069; x=1718694869;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxwKzD94gHFPmEIGlISH4+cM/BWxNmEcdz9s5jwd86Y=;
 b=hX4rxoM0A7yDVx9ZCUL3Yu4031pJw35KwkGc0HkeB0d7vlBZvWoCp+c77FTaBVxFbN
 apk3KC6QLn+B2eFYy6fbJOZF4EkNZwa487pfvbeR5EfOt08aqoCxztFN7kA4g6FaEzh/
 byZU1lnB5cx+R0GBDr4EUHaMDze8JKPeTwknG4IVqidp30D2FKpwyVy01485uaoGuj/V
 7uyk5WqmXeIzKYPIhlHmUdl2gUtPUXPg0o1sPYqZwJJfuscO76FFg5CV/ZJhDQChMnxd
 1PtEtrEsfRGc0nXVMR9MqTxMfZRY9nWZ7OrGrKGvnh8x6k9QVd6nV0mYxYfCsbV9ohNz
 8C/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0pmjzCQJvuU5su2eHvGEqQP6dn1aZABhzIg9AAP0U+X9LMNYgrZevP3dpQhUuRmweQApQthcOZN11lfhRKjv4ojWLHg==
X-Gm-Message-State: AOJu0YySPLKyhxPuhVP4QT959D6qe4j06QsFo/Klvz3rn5NEzBeTuMSH
 2iTcLophEYpxZkzdQKfUFnCPV/bSzj7UfOL2zHvMziEA5uTVnj+Bhhq68kYwrgk=
X-Google-Smtp-Source: AGHT+IEaNxj1ijOn6miub68HRAvhyJDQDfaueO09hwnY3TCeV8UKw1uFO5abYC1KD/Z0mJQh6W6VMw==
X-Received: by 2002:a5d:5f91:0:b0:35f:276a:12d1 with SMTP id
 ffacd0b85a97d-35f276a17c7mr4224855f8f.18.1718090069044; 
 Tue, 11 Jun 2024 00:14:29 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2b46332esm1530319f8f.73.2024.06.11.00.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 00:14:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/6] usb: gadget: g_dnl: Drop
 usb_gadget_controller_number()
In-Reply-To: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
Date: Tue, 11 Jun 2024 09:14:21 +0200
Message-ID: <87cyoo0x4i.fsf@baylibre.com>
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

Compared with linux commit, and looks good to me.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Tested that I could use fastboot, ums and scan for storage devices on
khadas vim3

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3

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
>  drivers/usb/gadget/g_dnl.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
> index b5b5f5d8c11..631969b3405 100644
> --- a/drivers/usb/gadget/g_dnl.c
> +++ b/drivers/usb/gadget/g_dnl.c
> @@ -17,10 +17,10 @@
>  #include <usb_mass_storage.h>
>  #include <dfu.h>
>  #include <thor.h>
> +#include <version.h>
>  
>  #include <env_callback.h>
>  
> -#include "gadget_chips.h"
>  #include "composite.c"
>  
>  /*
> @@ -199,18 +199,6 @@ void g_dnl_clear_detach(void)
>  	g_dnl_detach_request = false;
>  }
>  
> -static int g_dnl_get_bcd_device_number(struct usb_composite_dev *cdev)
> -{
> -	struct usb_gadget *gadget = cdev->gadget;
> -	int gcnum;
> -
> -	gcnum = usb_gadget_controller_number(gadget);
> -	if (gcnum > 0)
> -		gcnum += 0x200;
> -
> -	return g_dnl_get_board_bcd_device_number(gcnum);
> -}
> -
>  /**
>   * Update internal serial number variable when the "serial#" env var changes.
>   *
> @@ -261,7 +249,8 @@ static int g_dnl_bind(struct usb_composite_dev *cdev)
>  	if (ret)
>  		goto error;
>  
> -	gcnum = g_dnl_get_bcd_device_number(cdev);
> +	gcnum = g_dnl_get_board_bcd_device_number((U_BOOT_VERSION_NUM << 4) |
> +						  U_BOOT_VERSION_NUM_PATCH);
>  	if (gcnum >= 0)
>  		device_desc.bcdDevice = cpu_to_le16(gcnum);
>  	else {
> -- 
> 2.43.0
