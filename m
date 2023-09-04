Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3138C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 07:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CAE9868D1;
	Mon,  4 Sep 2023 09:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IPEATKn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCA4868D1; Mon,  4 Sep 2023 09:56:26 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6177F868CB
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c6cd238e0so1175629f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693814181; x=1694418981;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jv1XIw9nxj64NeOIMt9ZqePCljFmelOMReL1TmFnGVk=;
 b=IPEATKn5wGlMRyOFkzWmMACjcThCiQ0VgQYhow/NbFXNclJ3gLdc8IqibNG3zkPiOM
 s6Gfa6FM3sYQSt2G5kqc+G9E2oos1T5xFNRP4MTgsinRs4cgUtAz7A5aEhL5fy/CZFmU
 OV3MkOItSUfb3zZpFBT68m8Ri3/yfKVant4g6+7bB6Gwg1YI7w59PLw8QNv9GpT0PwVs
 +ZabWudM7+ay8gTPoCJvwa4aflhD+35BH3/f47SBRHqu2+rrb6jCF/U3cbH0HXsOLpnr
 qe3BPfzhZVSv4DowPwjEE4oGStqscaolCAmwHqV0KC8Gx/rSqim0h0J68+TejnqTGvjY
 7dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693814181; x=1694418981;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jv1XIw9nxj64NeOIMt9ZqePCljFmelOMReL1TmFnGVk=;
 b=EdOmGeo+J+vygLr63WZgbbxTkp16OiULQQpo28qYLpMdD4Rq1RSqe2a6oTuhFptZFf
 mjFIluczTSw8lyNamd/7fT1zIbwQdZDXznlbCzEk5J+jeMX2QNUbQM224NnsnilP0OWx
 OcrNrkF/P+mEIezg0z8IU3OEFM0a69p96/sQz/zUP1KW75IfBYI7Qv4oaDwrcnzLXJKY
 hFesLpBSoSHIF+K/x6jps39LgFG2LGwtkyLDrSdYktJFXCQgYYOdEl7MMRpcwm4uGVmS
 Nse51ocPgYRBtFLVbe8glbeHN9Sn69yiXVOmwIsx2c9k+MgkWNF3e9QPV0dhj4TNe9d+
 FpSQ==
X-Gm-Message-State: AOJu0Ywcn0Wr6zO3OyX00zXZn60iJFDsKkRY+hsBVWk0pcFhCInqD5EA
 EMlL3h9XpJTbD3XS5tpCTzRWSg==
X-Google-Smtp-Source: AGHT+IFfmMW8DQ/ZZ5S38YgYsU2HP+hpknN3Zg8zhRNM3MjKkijqau/tbmPOTsis2vsibD9Pswxiuw==
X-Received: by 2002:a05:6000:151:b0:317:f3fd:21b0 with SMTP id
 r17-20020a056000015100b00317f3fd21b0mr7676050wrx.7.1693814180834; 
 Mon, 04 Sep 2023 00:56:20 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a5d69ca000000b00317731a6e07sm13594259wrw.62.2023.09.04.00.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 00:56:20 -0700 (PDT)
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
Subject: Re: [PATCH v2 15/17] usb: gadget: ether: Use plain udevice for UDC
 controller interaction
In-Reply-To: <20230901095003.352930-15-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
 <20230901095003.352930-15-marex@denx.de>
Date: Mon, 04 Sep 2023 09:56:19 +0200
Message-ID: <877cp62wyk.fsf@baylibre.com>
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
> V2: Use udev->parent for UDC access
> ---
>  drivers/usb/gadget/ether.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
> index 5ff06d3814b..11b1a6221b3 100644
> --- a/drivers/usb/gadget/ether.c
> +++ b/drivers/usb/gadget/ether.c
> @@ -1880,8 +1880,10 @@ static void eth_start(struct eth_dev *dev, gfp_t gfp_flags)
>  	}
>  }
>  
> -static int eth_stop(struct eth_dev *dev)
> +static int eth_stop(struct udevice *udev)
>  {
> +	struct ether_priv *priv = dev_get_priv(udev);
> +	struct eth_dev *dev = &priv->ethdev;
>  #ifdef RNDIS_COMPLETE_SIGNAL_DISCONNECT
>  	unsigned long ts;
>  	unsigned long timeout = CONFIG_SYS_HZ; /* 1 sec to stop RNDIS */
> @@ -1895,7 +1897,7 @@ static int eth_stop(struct eth_dev *dev)
>  		/* Wait until host receives OID_GEN_MEDIA_CONNECT_STATUS */
>  		ts = get_timer(0);
>  		while (get_timer(ts) < timeout)
> -			usb_gadget_handle_interrupts(0);
> +			dm_usb_gadget_handle_interrupts(udev->parent);
>  #endif
>  
>  		rndis_uninit(dev->rndis_config);
> @@ -2300,7 +2302,7 @@ static int usb_eth_start(struct udevice *udev)
>  			pr_err("The remote end did not respond in time.");
>  			goto fail;
>  		}
> -		usb_gadget_handle_interrupts(0);
> +		dm_usb_gadget_handle_interrupts(udev->parent);
>  	}
>  
>  	packet_received = 0;
> @@ -2370,7 +2372,7 @@ static int usb_eth_send(struct udevice *udev, void *packet, int length)
>  			printf("timeout sending packets to usb ethernet\n");
>  			return -1;
>  		}
> -		usb_gadget_handle_interrupts(0);
> +		dm_usb_gadget_handle_interrupts(udev->parent);
>  	}
>  	free(rndis_pkt);
>  
> @@ -2400,13 +2402,13 @@ static void usb_eth_stop(struct udevice *udev)
>  	 * 2) 'pullup' callback in your UDC driver can be improved to perform
>  	 * this deinitialization.
>  	 */
> -	eth_stop(dev);
> +	eth_stop(udev);
>  
>  	usb_gadget_disconnect(dev->gadget);
>  
>  	/* Clear pending interrupt */
>  	if (dev->network_started) {
> -		usb_gadget_handle_interrupts(0);
> +		dm_usb_gadget_handle_interrupts(udev->parent);
>  		dev->network_started = 0;
>  	}
>  }
> @@ -2416,7 +2418,7 @@ static int usb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
>  	struct ether_priv *priv = dev_get_priv(dev);
>  	struct eth_dev *ethdev = &priv->ethdev;
>  
> -	usb_gadget_handle_interrupts(0);
> +	dm_usb_gadget_handle_interrupts(dev->parent);
>  
>  	if (packet_received) {
>  		if (ethdev->rx_req) {
> @@ -2467,7 +2469,7 @@ int usb_ether_init(void)
>  		return ret;
>  	}
>  
> -	return usb_gadget_initialize(0);
> +	return 0;

No udc_device_get() here?

This looks a little suspicious, because in the unbind() we call
udc_device_put().

>  }
>  
>  static int usb_eth_probe(struct udevice *dev)
> @@ -2528,7 +2530,7 @@ static int usb_eth_remove(struct udevice *dev)
>  
>  static int usb_eth_unbind(struct udevice *dev)
>  {
> -	usb_gadget_release(0);
> +	udc_device_put(dev->parent);
>  
>  	return 0;
>  }
> -- 
> 2.40.1
