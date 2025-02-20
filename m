Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A258C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 08:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1BCC80A46;
	Thu, 20 Feb 2025 09:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="njPi7+mu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD6580EC0; Thu, 20 Feb 2025 09:55:01 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93F7801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e587cca1e47so690722276.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 00:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740041698; x=1740646498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bHP0JMx8oYZ2+tlcGfrJitjE7Yvpxn0unGBkX3KRKzU=;
 b=njPi7+muj21kHUo0VvHo2jYWBNvsTv0+h5y7U5rt2TCkP7ajw4rnpGRBxPXos14QL3
 tuD6aJH3/qRQa5ZBBNnBLrNzAxWhUX4W496F9b7uCWbVBGdd51M7dQ7fu0VtO1Tgc+Wz
 0gCcWbWIqhl6GPtaRcovkTT0LNQmI+gkRl4YdJzWyd6VsiQg4qnm5Z6+BLIyElRnOdx5
 4O6GHx7MXKRNnrBaboEsT/HfJBWNKbs4YwbqJ6LY00ccSAg+mMP6mW7R/L0Lg5JuCq3A
 vvuktV0TUOw1ZWoOxuswDwn2kvmYEuvtqiaECwVhT+A1OqTB6qVhndifaMor/PZwSAyq
 bmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740041698; x=1740646498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bHP0JMx8oYZ2+tlcGfrJitjE7Yvpxn0unGBkX3KRKzU=;
 b=ecI5bo2qQ4ojc5Tf9xNuSqfu1EtOwlB54PYkiNYvcEKt9/xHsAZo2BjsH+5NvxLh1l
 URHgD7IS6jUnimkc5uzyHSkTv895zzGNxeuLit52PBbXMglbigXZHo7j/wyIob2IEKX+
 XV2WGT0oMzr/27/tgpww0f2oZ740sCmT3dffp6hhBZdYf9SZ5gnzDTw++XgxTiVG3w7E
 DZ6hMdxENREJZ1IKMRwtdkePsMYvirdJDAjHpILxZb2hEufvRE2BlcKB3ajRUjM9JNO8
 AlpUDewAfsrq6HdwRfKHR7FHwuaXpbL64actI7jMpkxCxhSBhqzjPQwksueyLa3kAZkc
 ZWRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDfg/5Rkm3xuYvJURM8j1wp4etVrmdCRJmkSx3QS6GK8i0Sg8MATCopPGRFTFTeCoJW5u1dnc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb+Ual5oN9LCyZ3q4O9dvZFNIP9OFdYydGFKf82FFhNPsAQ6qx
 1QjBZ/2VgQ7CtbZcfhmmDpwf1TQvuXik4FvWgayGQggrzNPa7XXCH1kjGlKJeg2T3kkA5mPRNMK
 saWEgsoJCjUyZPNTjzo4lOSc9ukWL4bp6fpsdUe3bDFOco/9QTX4=
X-Gm-Gg: ASbGncuHihI4NSUh+i64n/lChD+P1dteI8dFa4JmaT+hHMEQwixL2/1y6NHcDODtBAK
 RrKpQzdAQsq67Wdbz3SSUlvvkBNINBDR8HxRfkvP/ICiY3wMPwBg2AbGO26h9PejIbyuvTWjHmg
 ==
X-Google-Smtp-Source: AGHT+IEJaAnApvNhMwztf1Np1gqWToWIa0UoA6qEhFkOaOwaH/JSJ+iPZcHhLjnmdtHRM5t88c2er2LaU/ImfB13ECg=
X-Received: by 2002:a05:6902:2182:b0:e5a:c7a1:98bc with SMTP id
 3f1490d57ef6-e5e1b386f29mr931497276.20.1740041697651; Thu, 20 Feb 2025
 00:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20250215152206.135147-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250215152206.135147-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 10:54:21 +0200
X-Gm-Features: AWEUYZklEvAS5-HGbekm8oYxE3CIyKF_vbArSnncVV_4GsejX2h9A231Xg0rml4
Message-ID: <CAC_iWjK5e2UWbCHAgomCY_asQq5k_723Enp1VhuejdrVdmdUUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_driver: create a parent device for all EFI block
 devices
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 15 Feb 2025 at 17:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Up to now root has been the parent device for all block devices created via
> calling ConnectController(). This does not work well together with the
> implementation of bootstd.
>
> Add a dummy parent device for all EFI block devices.
>
> With this change EFI block devices are also accessible via commands like
> 'cat', 'load', and 'ls'.
>
>     => dm tree
>      Class     Seq    Probed  Driver                Name
>     -----------------------------------------------------------
>      efi           0  [ + ]   EFI block driver      `-- efi
>      blk           3  [ + ]   efi_blk                   `-- efi.efiblk#0
>      partition     0  [ + ]   blk_partition                 `-- efi.efiblk#0:1
>
>     => ls efiloader 0:1
>            13   hello.txt
>             7   u-boot.txt
>     2 file(s), 0 dir(s)
>
>     => cat efiloader 0:1 hello.txt
>     Hello world!
>
>     => efidebug dh
>     0000000018df1700 (efi.efiblk#0:1)
>       /VenHw(dbca4c98-6cb0-694d-0872-819c650cb7b8)/HD(1,MBR,0xd1535d21,0x1,0x7f)
>       Block IO
>       Simple File System
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_driver/efi_block_device.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
> index d3c668dc183..070747de515 100644
> --- a/lib/efi_driver/efi_block_device.c
> +++ b/lib/efi_driver/efi_block_device.c
> @@ -35,8 +35,10 @@
>  #include <efi_driver.h>
>  #include <malloc.h>
>  #include <dm/device-internal.h>
> +#include <dm/lists.h>
>  #include <dm/root.h>
>  #include <dm/tag.h>
> +#include <dm/uclass-internal.h>
>
>  /**
>   * struct efi_blk_plat - attributes of a block device
> @@ -118,13 +120,18 @@ static ulong efi_bl_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>  static efi_status_t
>  efi_bl_create_block_device(efi_handle_t handle, void *interface)
>  {
> -       struct udevice *bdev = NULL, *parent = dm_root();
> +       struct udevice *bdev = NULL, *parent;
>         efi_status_t ret;
> +       int r;
>         int devnum;
>         char *name;
>         struct efi_block_io *io = interface;
>         struct efi_blk_plat *plat;
>
> +       r = uclass_find_first_device(UCLASS_EFI_LOADER, &parent);
> +       if (r)
> +               return EFI_OUT_OF_RESOURCES;
> +
>         devnum = blk_next_free_devnum(UCLASS_EFI_LOADER);
>         if (devnum < 0)
>                 return EFI_OUT_OF_RESOURCES;
> @@ -221,6 +228,24 @@ efi_bl_init(struct efi_driver_binding_extended_protocol *this)
>         return EFI_SUCCESS;
>  }
>
> +/**
> + * efi_block_device_create() - create parent for EFI block devices
> + *
> + * Create a device that serves as parent for all block devices created via
> + * ConnectController().
> + *
> + * Return:     0 for success
> + */
> +static int efi_block_device_create(void)
> +{
> +       int ret;
> +       struct udevice *dev;
> +
> +       ret = device_bind_driver(gd->dm_root, "EFI block driver", "efi", &dev);
> +
> +       return ret;
> +}
> +
>  /* Block device driver operators */
>  static const struct blk_ops efi_blk_ops = {
>         .read   = efi_bl_read,
> @@ -249,3 +274,5 @@ U_BOOT_DRIVER(efi_block) = {
>         .id             = UCLASS_EFI_LOADER,
>         .ops            = &driver_ops,
>  };
> +
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, efi_block_device_create);
> --
> 2.47.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
