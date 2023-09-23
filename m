Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470F8CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 16:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39D9868D8;
	Sat, 23 Sep 2023 18:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oBpm9G7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C26D8691E; Sat, 23 Sep 2023 18:39:21 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79811868D8
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 18:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4051fea48a8so43839215e9.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695487159; x=1696091959;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=17Uj/Vrx9nHbX2YZuepkoyAeoFaiyzwFEicGo5WNUF4=;
 b=oBpm9G7GucbE0Wveg3h27BDbdQmex0Rs/C8XRMpU2GKHVazp/HiwwaYfr9zCmNFLgB
 Dpm/L7BwdAaheUuar7Ds4m92v+jeeb0mNmC2YbiSFo1CqcK87CKFRaIDREFrG+/WQjE8
 rv59x9Pwno/mY3SwOMvbjOy2BIGMfbD0jw+B1Q3iia2ZCxw/Np1CPZeMUfVicM2WMECR
 eqMbplWo9Aj3s4rP8z6IgadPXaUwlKyde66OE5bApamCNNTPbyWldxNU5gwsKZ4rCLPY
 aVm2Bl/vRWY130KMNTcAAyCU6mUYyr0EZj8MwNgA/+9elyJahXwXkCif1oo9MSZpqR/O
 O/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695487159; x=1696091959;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=17Uj/Vrx9nHbX2YZuepkoyAeoFaiyzwFEicGo5WNUF4=;
 b=WU2y+qszxANvli6XTft4X20Y0nfKDBsVS4Gylp4F6mVT1IJZYo5Ub+POdbPnwP6UqF
 Y36f2I/H8aFQ8lFwzbeJmwdOT0yv8e6CZkVfdae15thV2k2DaBikYIBTZ+6189i3vVU2
 kqZZdC/LVB+xluXFKHNC38aySydcl5YIpvL0UiYj2utzgMI+2uA3hbHggcOdKLEXb6AR
 GGUO+eIWKyT4mQzGnmkIfpOGpfxKp1ymUJJ+mvavo0BWDdRybmKTVnnBxKq+nWyfyAMO
 QyX3jrnNWV4VAHAd+6x73Yk1olOWMXYTrk0oBpY3Jli71YwTIgcnjkn0aBGuSmH/RFe5
 5/8w==
X-Gm-Message-State: AOJu0YzVad2l/KLCYNwiPni7D4HpKH2qbP3ccg0QZNFRNNukVwh2VSYi
 bS8HdkEc5yO5bKnpJeTgtiMLbw==
X-Google-Smtp-Source: AGHT+IEXr+0katDVeo9d5hMlxPggy/49vsQpHmyl1GeXIvvKICUtyIe/99s0DDUlBDBNMurZzBAcGQ==
X-Received: by 2002:adf:f34b:0:b0:320:11f:2d48 with SMTP id
 e11-20020adff34b000000b00320011f2d48mr2361338wrp.54.1695487158874; 
 Sat, 23 Sep 2023 09:39:18 -0700 (PDT)
Received: from localhost ([2a01:e0a:324:38a0:25d4:3d10:65f9:654e])
 by smtp.gmail.com with ESMTPSA id
 y2-20020adffa42000000b0031423a8f4f7sm7398382wrr.56.2023.09.23.09.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 09:39:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 4/4] usb: Avoid unbinding devices in use by bootflows
In-Reply-To: <20230922153814.v2.4.If206027372f73ce32480223e5626f4b944e281b7@changeid>
References: <20230922213819.1886094-1-sjg@chromium.org>
 <20230922153814.v2.4.If206027372f73ce32480223e5626f4b944e281b7@changeid>
Date: Sat, 23 Sep 2023 18:39:17 +0200
Message-ID: <8734z4974a.fsf@baylibre.com>
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

On ven., sept. 22, 2023 at 15:38, Simon Glass <sjg@chromium.org> wrote:

> When a USB device is unbound, it causes any bootflows attached to it to
> be removed, via a call to bootdev_clear_bootflows() from
> bootdev_pre_unbind(). This obviously makes it impossible to boot the
> bootflow.
>
> However, when booting a bootflow that relies on USB, usb_stop() is
> called, which unbinds the device. For EFI, this happens in
> efi_exit_boot_services() which means that the bootflow disappears
> before it is finished with.
>
> There is no need to unbind all the USB devices just to quiesce them.
> Add a new usb_pause() call which removes them but leaves them bound.
>
> This resolves a hang on x86 when booting a distro from USB. This was
> found using a device with 4 bootflows, the last of which was USB.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Add new patch to avoid unbinding devices in use by bootflows
>
>  boot/bootm.c                  |  2 +-
>  common/usb.c                  |  7 ++++++-
>  drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
>  include/usb.h                 | 15 ++++++++++++++-
>  4 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index b1c3afe0a3a..5c9ba083e64 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -501,7 +501,7 @@ ulong bootm_disable_interrupts(void)
>  	 * updated every 1 ms within the HCCA structure in SDRAM! For more
>  	 * details see the OpenHCI specification.
>  	 */
> -	usb_stop();
> +	usb_pause();
>  #endif
>  	return iflag;
>  }
> diff --git a/common/usb.c b/common/usb.c
> index 836506dcd9e..4d6ac69111e 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -126,7 +126,7 @@ int usb_init(void)
>  /******************************************************************************
>   * Stop USB this stops the LowLevel Part and deregisters USB devices.
>   */
> -int usb_stop(void)
> +int usb_pause(void)

nit: I know this is the "legacy" (pre-DM) stuff, but isn't renaming the above
function making the comment wrong?

Can't we keep this function usb_stop() and create another one named
usb_pause() which calls usb_stop() ?

>  {
>  	int i;
>  
> @@ -144,6 +144,11 @@ int usb_stop(void)
>  	return 0;
>  }
>  
> +int usb_stop(void)
> +{
> +	return usb_pause();
> +}
> +
>  /******************************************************************************
>   * Detect if a USB device has been plugged or unplugged.
>   */
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> index a1cd0ad2d66..c26c65d7986 100644
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

What happens if someone calls usb_pause() followed by usb_init() on a
root hub ?

I think it behaves properly because usb_init() calls
remove_inactive_children().

> +
>  static void usb_scan_bus(struct udevice *bus, bool recurse)
>  {
>  	struct usb_bus_priv *priv;
> diff --git a/include/usb.h b/include/usb.h
> index 09e3f0cb309..ad39b09a6e4 100644
> --- a/include/usb.h
> +++ b/include/usb.h
> @@ -265,7 +265,20 @@ int usb_kbd_deregister(int force);
>   */
>  int usb_init(void);
>  
> -int usb_stop(void); /* stop the USB Controller */
> +/**
> + * usb_stop() - stop the USB Controller and unbind all USB controllers/devices
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int usb_stop(void);
> +
> +/**
> + * usb_pause() - stop the USB Controller DMA, etc.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int usb_pause(void);
> +
>  int usb_detect_change(void); /* detect if a USB device has been (un)plugged */
>  
>  
> -- 
> 2.42.0.515.g380fc7ccd1-goog
