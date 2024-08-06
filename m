Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66285C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE2688A2A;
	Tue,  6 Aug 2024 16:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KTXGgIUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA9588A10; Tue,  6 Aug 2024 16:00:52 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240EE88A37
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3687fd09251so398534f8f.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722952847; x=1723557647;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=efGgCP8tW8T4i2uz/vmYvzNdVuTROOGU3KqS48OmtKQ=;
 b=KTXGgIUCMiInoPzCU70krpoylMxGjgtthvdOxAQ+UXZAKgVYt0tImo9hdgwfvRLIez
 uKXrXvJbR+El8OtSGU0OI0NFn0FA1Rpq7TeQ/SOQV1a+S98Kz1xpviDontc/PbD+p2Xa
 prk2batH8GsXHfUIs60196R0EPg6Q/09n7WW4t/BOTm3+FKAlL23/AMnL1s7DtSok0kc
 S2uj6F4Zaplfs/SB/qeDikyzu6wYeLdAiKtmrqtMMbtDVaT/Ynq4ZAdHhdrzQpKIZ8GR
 TdZNwB49VtqaIxKykd4UVwdTVMBQhRMuPH0uPRF9G4Qwge0o3i8fJO8HQBfqz2usyck5
 ceJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722952847; x=1723557647;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=efGgCP8tW8T4i2uz/vmYvzNdVuTROOGU3KqS48OmtKQ=;
 b=lN2ydg6FrLcDM7Vc1xt+afoETTzndHFR9JbVh+dWDlr1Zq/523v6Sc9LAxq1JTerIV
 yw7lRkuNF8gOnP21GvhLmpMKtKgPi26+kB9hETyPPeeRaxkq7w8sf3x3h8XtWJE6O9OK
 YQfWgrmpS63tF5WAJRiMjf4Ci9TQcz1O2d577ZhzXd1Xfdc8mjQFP0paMu5KPA3w6m1E
 ehn4LIGWQ6v1/JT5eBvcboW6kPMx8LcWCmJt7O+43aqqirWawhmW28T0a84SksdNLEFk
 X1CDem+lzpXeJfF4Og6IVizCDHpXnMZIYY7wQ7MmMpqFUDrrzHv8nJgutLFlRGxxkV9w
 1u1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqqOMui4jbT9x9pqGU3dW34pvAYrfLFrZB6p3f09/mNbkdXJpXsW7Et0uiW0r4bwZN/wiadVboGRuNBPRoUa2/X63qpg==
X-Gm-Message-State: AOJu0YzKaCHkhRQKTwj+918Cx1+7RZmeogdjUxY8+ZQGkJNR92a0CN2H
 ok0NOcRWTAGq01m5PZf5XJ3lnhyrnOwsdxI4ze5Sxmn7BAc2ZsLLPCYFOGRoLD0=
X-Google-Smtp-Source: AGHT+IF7OSBzdsKfjA8SNU2tQBzQbTzKKMh2klgOA4/wy+XTMMJogwP4GtIJh3vYiiCf3rXxCq4lRw==
X-Received: by 2002:a5d:6d83:0:b0:368:6633:c550 with SMTP id
 ffacd0b85a97d-36bbc17c691mr12140897f8f.52.1722952846371; 
 Tue, 06 Aug 2024 07:00:46 -0700 (PDT)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd05ad0csm13234627f8f.79.2024.08.06.07.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 07:00:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: ether: Handle gadget driver registration
 in start and stop
In-Reply-To: <20240726083102.380719-1-admin@hifiphile.com>
References: <20240726083102.380719-1-admin@hifiphile.com>
Date: Tue, 06 Aug 2024 16:00:25 +0200
Message-ID: <87y159oio6.fsf@baylibre.com>
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

On ven., juil. 26, 2024 at 10:31, Zixun LI <admin@hifiphile.com> wrote:

> Revert part of 718f1d41 to move
>  usb_gadget_register_driver()/usb_gadget_unregister_driver()
> back to usb_eth_start()/usb_eth_stop().
>
> usb_gadget_register_driver() will initialize the USB controller which
> enters ready to connect state with pull-up resistor enabled.
>
> From the host's point of view, a device is ready to be enumerated.
> However, since dm_usb_gadget_handle_interrupts() is only called when
> ethernet function is started, at this stage USB events are not managed,
> host's enumeration attempts will fail and resulting error like:
>     usb 1-1: new high-speed USB device number 50 using xhci_hcd
>     usb 1-1: device descriptor read/64, error -110
>     usb 1-1: device descriptor read/64, error -110
>     usb usb1-port1: attempt power cycle
>
> With this patch the USB controller will only be initialized when ethernet
> function is used, in which case USB controller events are handled, so the
> host won't see an unresponsive device.
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

I'd like to test this on my end as well. Could you please give some
details on how this has been tested?

A sequence of U-Boot commands would be helpful, for example.

> ---
>  drivers/usb/gadget/ether.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
> index b7b7bacb00..ed55f12662 100644
> --- a/drivers/usb/gadget/ether.c
> +++ b/drivers/usb/gadget/ether.c
> @@ -2277,6 +2277,9 @@ static int usb_eth_start(struct udevice *udev)
>  	packet_received = 0;
>  	packet_sent = 0;
>
> +	if (usb_gadget_register_driver(&priv->eth_driver) < 0)
> +		goto fail;
> +
>  	gadget = dev->gadget;
>  	usb_gadget_connect(gadget);
>
> @@ -2398,6 +2401,8 @@ static void usb_eth_stop(struct udevice *udev)
>  		dm_usb_gadget_handle_interrupts(udev->parent);
>  		dev->network_started = 0;
>  	}
> +
> +	usb_gadget_unregister_driver(&priv->eth_driver);
>  }
>
>  static int usb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
> @@ -2503,15 +2508,6 @@ static int usb_eth_probe(struct udevice *dev)
>  	priv->eth_driver.disconnect	= eth_disconnect;
>  	priv->eth_driver.suspend	= eth_suspend;
>  	priv->eth_driver.resume		= eth_resume;
> -	return usb_gadget_register_driver(&priv->eth_driver);
> -}
> -
> -static int usb_eth_remove(struct udevice *dev)
> -{
> -	struct ether_priv *priv = dev_get_priv(dev);
> -
> -	usb_gadget_unregister_driver(&priv->eth_driver);
> -
>  	return 0;
>  }
>
> @@ -2526,7 +2522,6 @@ U_BOOT_DRIVER(eth_usb) = {
>  	.name	= "usb_ether",
>  	.id	= UCLASS_ETH,
>  	.probe	= usb_eth_probe,
> -	.remove	= usb_eth_remove,
>  	.unbind	= usb_eth_unbind,
>  	.ops	= &usb_eth_ops,
>  	.priv_auto	= sizeof(struct ether_priv),
> --
> 2.45.2
