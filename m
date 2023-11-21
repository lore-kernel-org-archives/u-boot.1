Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC75C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B0787197;
	Tue, 21 Nov 2023 15:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="va75qCtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B45863F8; Tue, 21 Nov 2023 15:20:59 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C9987264
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso25981605e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700576457; x=1701181257;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cluqEBqOTcuIHyOP71zgMBwcEjBCIBor79nfJ+/hfjc=;
 b=va75qCtcUvfQ2vhLwF6BSmPLwiRODwSMyLFTuZHOK5cgcK7Qv4ZPjP6/d3vfw05DVQ
 H0jmI776dYjI/2oW+UVx4nPLXOuRm0JtW9nhST1o6Vz5lLHqy/f/4vzmFDoAkzKekU2k
 75cM0aVOUqoajpZZKvQOou5QH2X2VLjX2aepd4CX/nzvqmldnbhebzDlo55pRwLM7O6z
 dcmE8lvnjxfEmIDleG9WrymCGmS0Bwc31qydiAXHHQP2fk6nIyhlr4C37CDkmD/IUseQ
 GQ4NFIpjKka70BLLfD7l/z0yJG5tMrBjUN/VSUv8MB/t7pjFvkHB9bfyqY0mkJTsZYHt
 FEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700576457; x=1701181257;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cluqEBqOTcuIHyOP71zgMBwcEjBCIBor79nfJ+/hfjc=;
 b=F1sG2laSVcEp/YMnuZVLeo6iq1WPRb/NtS45Qo30kwFqnY/lw+1YYgormcoG/cFDco
 USIC/c5YklTJj7vgKim4KiN2octR6FGs38VY5jCFaOwQCWOfzOJoDATQY6KZGSiJvT4e
 nW0NRQsDAlpDgJRJshynmTVFbOsrg4jB8l4AEOKEZPDfCR0ZP5yvZcVru+IHC4Md3QbQ
 1R53JdD+kGZ9ehN0KkH2lPimABBipaefOwH4jRsxrCFiqtZLVLrcy+Axi8fN1zEDPXsf
 g3esJQ7aEXpmJeMgW2yumwitAxwuisUQHkEp36CTa0RWC0UP1VQmyEIdWZ1bUx5q5uDi
 mZ3Q==
X-Gm-Message-State: AOJu0Yxv2JOwFCQcmYES8Fd49J8XRR8lp2P6xtY4qWPZDUAj0QllZGFe
 +A2k/RqKgatKi/U5pitwPTiVEw==
X-Google-Smtp-Source: AGHT+IFm1/l8jzHwzij68PEGOh6zv2d9FzPQvPSWsmdoR2fVf2R5EwAeRGZNfRnefdgRHrfd575f5Q==
X-Received: by 2002:a05:6000:2a5:b0:332:c9f5:e5e6 with SMTP id
 l5-20020a05600002a500b00332c9f5e5e6mr3714956wry.17.1700576456542; 
 Tue, 21 Nov 2023 06:20:56 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 m17-20020adfe0d1000000b0033130644c87sm14564334wri.54.2023.11.21.06.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 06:20:56 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>, Bin
 Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v5 05/12] usb: Avoid unbinding devices in use by bootflows
In-Reply-To: <20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
References: <20231119191202.667180-1-sjg@chromium.org>
 <20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
Date: Tue, 21 Nov 2023 15:20:54 +0100
Message-ID: <87o7fnkx15.fsf@baylibre.com>
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

Hi Simon,

Thank you for your patch.

On dim., nov. 19, 2023 at 12:11, Simon Glass <sjg@chromium.org> wrote:

> When a USB device is unbound, it causes any bootflows attached to it to
> be removed, via a call to bootdev_clear_bootflows() from
> bootdev_pre_unbind(). This obviously makes it impossible to boot the
> bootflow.
>
> However, when booting a bootflow that relies on USB, usb_stop() is
> called, which unbinds the device. At that point any information
> attached to the bootflow is dropped.
>
> This is quite risky since the contents of freed memory are not
> guaranteed to remain unchanged. Depending on what other options are
> done before boot, a hard-to-find bug may crop up.
>
> There is no need to unbind all the USB devices just to quiesce them.
> Add a new usb_pause() call which removes them but leaves them bound.
>
> Tested-by: Shantur Rathore <i@shantur.com>
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v5:
> - Adjust motivation for patch, since the EFI hang is fixed
>
> Changes in v4:
> - Don't rename the legacy-USB functions
> - Add a bit more detail to the comment
>
> Changes in v2:
> - Add new patch to avoid unbinding devices in use by bootflows
>
>  boot/bootm.c                  |  2 +-
>  common/usb.c                  |  5 +++++
>  drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
>  include/usb.h                 | 21 ++++++++++++++++++++-
>  4 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index cb61485c226c..d9c3fa8dad99 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -502,7 +502,7 @@ ulong bootm_disable_interrupts(void)
>  	 * updated every 1 ms within the HCCA structure in SDRAM! For more
>  	 * details see the OpenHCI specification.
>  	 */
> -	usb_stop();
> +	usb_pause();
>  #endif
>  	return iflag;
>  }
> diff --git a/common/usb.c b/common/usb.c
> index 836506dcd9e9..a486d1c87d4d 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -144,6 +144,11 @@ int usb_stop(void)
>  	return 0;
>  }
>  
> +int usb_pause(void)
> +{
> +	return usb_stop();
> +}
> +
>  /******************************************************************************
>   * Detect if a USB device has been plugged or unplugged.
>   */
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> index a1cd0ad2d669..c26c65d7986b 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -173,7 +173,7 @@ int usb_get_max_xfer_size(struct usb_device *udev, size_t *size)
>  	return ops->get_max_xfer_size(bus, size);
>  }
>  
> -int usb_stop(void)
> +static int usb_finish(bool unbind_all)
>  {
>  	struct udevice *bus;
>  	struct udevice *rh;
> @@ -195,7 +195,7 @@ int usb_stop(void)
>  
>  		/* Locate root hub device */
>  		device_find_first_child(bus, &rh);
> -		if (rh) {
> +		if (rh && unbind_all) {
>  			/*
>  			 * All USB devices are children of root hub.
>  			 * Unbinding root hub will unbind all of its children.
> @@ -222,6 +222,16 @@ int usb_stop(void)
>  	return err;
>  }
>  
> +int usb_stop(void)
> +{
> +	return usb_finish(true);
> +}
> +
> +int usb_pause(void)
> +{
> +	return usb_finish(false);
> +}
> +
>  static void usb_scan_bus(struct udevice *bus, bool recurse)
>  {
>  	struct usb_bus_priv *priv;
> diff --git a/include/usb.h b/include/usb.h
> index 09e3f0cb309c..b964e2e1f6b2 100644
> --- a/include/usb.h
> +++ b/include/usb.h
> @@ -265,7 +265,26 @@ int usb_kbd_deregister(int force);
>   */
>  int usb_init(void);
>  
> -int usb_stop(void); /* stop the USB Controller */
> +/**
> + * usb_stop() - stop the USB Controller and unbind all USB controllers/devices
> + *
> + * This unbinds all devices on the USB buses.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int usb_stop(void);
> +
> +/**
> + * usb_pause() - stop the USB Controller DMA, etc.
> + *
> + * Note that this does not unbind bus devices, so using usb_init() after this
> + * call is not permitted. This function is only useful just before booting, to
> + * ensure that devices are dormant.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int usb_pause(void);
> +
>  int usb_detect_change(void); /* detect if a USB device has been (un)plugged */
>  
>  
> -- 
> 2.43.0.rc0.421.g78406f8d94-goog
