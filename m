Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC274C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63C53884CA;
	Tue, 18 Jun 2024 09:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Y4ZaHeK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7457884CA; Tue, 18 Jun 2024 09:46:31 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74C18839F
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421820fc26dso40693045e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718696789; x=1719301589;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=a7QJ2KWa8NHXu9AtSkIHL1LR1c0vKxxQxBcbM6wPyF0=;
 b=0Y4ZaHeKOqsLeAtIU3EZV/EgkbwPRAs9lPd337xeUoXknSNezLncM3f3KAnV7StWZE
 mVh/xSSO38fxeA2+/8MR7hyqFmjbNyE5CJY3BsT6rvgml8KZCpjWdbKwWGJRhqKOhby7
 bIT2FXqtI3yy/1K7++WRP9iplvYr4evXfrQBMziuPjdq+/hVbXgOp9KxQqo5F3CyzkmJ
 CBXhO11nuqu1yS+lbyjYAMIhR7QPQnhwDSq98CWTwXbBJ1QwkzI9Zyy2nuTeEa2mO+wB
 bu2Q9YCB415PcehtMWD561Hae0fkDzcJcAA67lCzZd5CtSFoVJ/Mn1vlq9A3KQmewdK2
 tzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718696789; x=1719301589;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a7QJ2KWa8NHXu9AtSkIHL1LR1c0vKxxQxBcbM6wPyF0=;
 b=Reusr/Un0RRiHo2tRNG+N5NoQ8tixb/vKoEHE0IfbT0kC0S91rcZDsgWhTCDTPuhN2
 7/cIaj0U/E+yYfdtFYVjEieulwpqcQURIZuypq1zm8Hl2v9/aiWLwfKxqxkFG3EzxYJK
 TZp8OcIYgIs8uRr6sF0eacNNxbdFWCfN37RiU0AGSVnEk6WDglwBXlcVo9nB70K+L+td
 sOyU5qrawJk0YvQlz3NUDBrzQnQUW9GAe2RRzCYWe+rNHwWpLWE+8iW7JWqByICXfEnB
 Msuq4TcITNwCkKe5tPI03ZZXkig4Ltm2MvjLryQ6jLJt+3czXkw9uvZ93ag04fyoi7zd
 c+IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa7qU7aQvOdzHS5QUQINuPV1zQFSM5jpgzVhiQbvn1v/JWgOSojjoPn3Pc/mqCGNjIdGfSgTWtIy341UQgc/mZgCsd5w==
X-Gm-Message-State: AOJu0YwgvjwtOH8d/5SM9WXmrs6ULWq0OeiM64Z60hL252inzCUd5Rav
 I6byuYfohz8zzkj4YoCRXMusFX2KLM9G+/MSvZ3Q/zNO5KCcZ2F5Ep6I2rE1n+k=
X-Google-Smtp-Source: AGHT+IHJxDXgQ1clKesBzFjIrZ5YRifx5aj3H9ZDVHpsG5ju9xXrVJQk0J5sPHXW1uvRHY11YJSIvQ==
X-Received: by 2002:a05:6000:bcd:b0:35f:26e7:f978 with SMTP id
 ffacd0b85a97d-3607a75c3b2mr8539719f8f.37.1718696789197; 
 Tue, 18 Jun 2024 00:46:29 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750ad2cdsm13579897f8f.61.2024.06.18.00.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:46:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 11/11] usb: gadget: Mark dm_usb_gadget_handle_interrupts
 as non-weak for DM_USB_GADGET
In-Reply-To: <20240614005309.34433-12-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-12-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:46:26 +0200
Message-ID: <87h6dqitgt.fsf@baylibre.com>
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

Thank you for the patch

On ven., juin 14, 2024 at 02:51, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The dm_usb_gadget_handle_interrupts() is not implemented by any USB
> gadget controller drivers which do enable DM_USB_GADGET anymore. Set
> the symbol as non-weak.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

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
>  drivers/usb/gadget/udc/udc-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
> index 2320039fe3b..fbe62bbce47 100644
> --- a/drivers/usb/gadget/udc/udc-uclass.c
> +++ b/drivers/usb/gadget/udc/udc-uclass.c
> @@ -18,7 +18,7 @@ usb_gadget_generic_dev_ops(struct udevice *dev)
>  	return (const struct usb_gadget_generic_ops *)dev->driver->ops;
>  }
>  
> -__weak int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	const struct usb_gadget_generic_ops *ops;
>  
> -- 
> 2.43.0
