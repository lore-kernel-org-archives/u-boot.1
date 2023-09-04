Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4E0C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 07:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F82864C5;
	Mon,  4 Sep 2023 09:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e10fVOPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B4286497; Mon,  4 Sep 2023 09:37:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8518A86500
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so11215555e9.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693813059; x=1694417859;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OpChcBcSC9fZ0Iirc5LHZJY8L2hgOpyXMAVOsZfeYGA=;
 b=e10fVOPmffUyWzHorIcH38rNMMsX151eMB6XjFdBjD7wBZnvgNX5zwEtjF2TeZYuR6
 e8A8PCV4rssIp4ek1IHgXAQ8olOm3hnh+Lnv5RowgHBZ+U6OI+sLzsRS0OhFTmlXepMa
 Oa/j8r0F6KDQJ4T/MIQN7A5GP95W1xfcgXuu1rFy8S30lURcZXQrL4fNMHwRpQo0jHjo
 tckW8/6VQwi9d8iAOC6Qjc3g5zERVw6+hvjn26cPV3f9FmeE5z55xEGB+6COF7gchlAB
 tXq3qvlebQiFICQOVMie2R7h9m/X7tl7vOPk6gP+CNDge/P5AONgxVRSSoOI8XNyrP3r
 5aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693813059; x=1694417859;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OpChcBcSC9fZ0Iirc5LHZJY8L2hgOpyXMAVOsZfeYGA=;
 b=LjbhBm+xydKIlHnaWaWG6UCgXsH/82LR7nZF07uOJDeb7BWlWpW76I0R8KeyLdqAF8
 ttocF5PfhbRcT/iCkS9wnQooK2UG96Aw9s9Mtr5Nnrg0Ti8sPP/AnhNEyuaZF3F5oHwt
 5UX0ZYW4AqS+T4yaJ8PNT0LGoxzbWcd/HZlF4BS9nJMsM60E++GSqUeOLEsMaSx/wPZ1
 WI47exsA5V97tYTF+Z5Y04AN5b+GgdB75pDeKatkbJvEiZB7TPApwDDelSyD6mszoEwu
 YC2e8QYLvdWS0fnUKAOLIryojIc1AhSP//VPanTuA8uTbnJvy9T6BLmHn0os0pJpfF+K
 Ef6A==
X-Gm-Message-State: AOJu0YzCd913Q7oh6NlfpJCc2Togp6kWj120Am9a9RDF/qgpY1p0G+dD
 B7jRY+ps/1ldQZoYHBlaNK9vJQ==
X-Google-Smtp-Source: AGHT+IEl3fTHIjHCvXTLC5ivoUDcNnuq5y2ckyDyNOgLDDDz8MqfnzjdeUp00tBnPx/JIShYnRc4dQ==
X-Received: by 2002:a7b:cd8f:0:b0:401:bd2e:49f2 with SMTP id
 y15-20020a7bcd8f000000b00401bd2e49f2mr7063909wmj.0.1693813058870; 
 Mon, 04 Sep 2023 00:37:38 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a05600c220800b003ff3b964a9asm16483770wml.39.2023.09.04.00.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 00:37:38 -0700 (PDT)
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
Subject: Re: [PATCH v2 05/17] cmd: rockusb: Use plain udevice for UDC
 controller interaction
In-Reply-To: <20230901095003.352930-5-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
 <20230901095003.352930-5-marex@denx.de>
Date: Mon, 04 Sep 2023 09:37:37 +0200
Message-ID: <87il8q2xtq.fsf@baylibre.com>
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

On ven., sept. 01, 2023 at 11:49, Marek Vasut <marex@denx.de> wrote:

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
>  cmd/rockusb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/cmd/rockusb.c b/cmd/rockusb.c
> index f181ec61119..07088564a10 100644
> --- a/cmd/rockusb.c
> +++ b/cmd/rockusb.c
> @@ -15,6 +15,7 @@ static int do_rockusb(struct cmd_tbl *cmdtp, int flag, int argc,
>  {
>  	int controller_index, dev_index;
>  	char *usb_controller;
> +	struct udevice *udc;
>  	char *devtype;
>  	char *devnum;
>  	int ret;
> @@ -34,7 +35,7 @@ static int do_rockusb(struct cmd_tbl *cmdtp, int flag, int argc,
>  	dev_index = simple_strtoul(devnum, NULL, 0);
>  	rockusb_dev_init(devtype, dev_index);
>  
> -	ret = usb_gadget_initialize(controller_index);
> +	ret = udc_device_get_by_index(controller_index, &udc);
>  	if (ret) {
>  		printf("USB init failed: %d\n", ret);
>  		return CMD_RET_FAILURE;
> @@ -56,14 +57,14 @@ static int do_rockusb(struct cmd_tbl *cmdtp, int flag, int argc,
>  			break;
>  		if (ctrlc())
>  			break;
> -		usb_gadget_handle_interrupts(controller_index);
> +		dm_usb_gadget_handle_interrupts(udc);
>  	}
>  	ret = CMD_RET_SUCCESS;
>  
>  exit:
>  	g_dnl_unregister();
>  	g_dnl_clear_detach();
> -	usb_gadget_release(controller_index);
> +	udc_device_put(udc);
>  
>  	return ret;
>  }
> -- 
> 2.40.1
