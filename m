Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8710EC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2410C80B98;
	Sat, 15 Feb 2025 18:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y2hO0sQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224F180C6F; Sat, 15 Feb 2025 18:23:44 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA13A80077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abb7aecd39fso86544266b.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640221; x=1740245021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NS0jxiGeBC/rFA5RETpu2JrhddRmINmsmH8qCwxLibA=;
 b=Y2hO0sQc0enfyg1P3oig6AyIZsvyzUBfNw1QvPZVHGOqUGo/ukRdh4hk388eQn+OeR
 jHGu+tlYUqbQPCzkQ4qz0FUAOpGQxA6qCEwxX+1IhmFanbqWzfBzR6xesvTJpaNODrwI
 EGCXOrUSCA0zwiJ07jugChIeWg1AOTqLGTGA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640221; x=1740245021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NS0jxiGeBC/rFA5RETpu2JrhddRmINmsmH8qCwxLibA=;
 b=Iic2w6RRn7/AtaK7vnzsWQY1sRUhMGZaF5hSRAMFBhLmAwdj/iqHcZ7oEAYhWlHE3y
 O5MMZ3acFFlu98WVT3+OroUyAF11HqwkO4ngqEnC30VqBceokgY6SKLXfdWyphFfe/aG
 iHdXj8xOFXnGhQQvHO3z86MC0MBcUtmMhRE6CGDTST7YAwFP/RvpwsjHmX5/Lg4eoN/D
 PL0gDByi9mzNxOBTwso5BbHalL1pQg+VwT/jTvmRJby14gU/AEx7UZ2Oi8fv1rtMS1cK
 jL+u2ps47anepm64mLRXbtetIXPP8wvgTiQWwcM3u8hn8MOZjhXHdQXF3ulKWDGxXDrm
 9HgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1RbxFxR7ivYRDT/2sA1bbBePEcyK/Uxk6YloxTDMMmKntnI8dmiICIh0HNkEVU3qzQgtHZmM=@lists.denx.de
X-Gm-Message-State: AOJu0YzcYo6bPc8kmZGxNQlno3BopFIGsYmWrtJnW2/PcwjrkKjm/KTK
 obMc8YiY/XcJQ//U7nAnFihKXb2yfw/e123klp4oI7I/KOA8c+q7CpMx/44GyXq/AB1M0rJAhsP
 hmU9H+CM8p/dme8D2tjGMucpmbQJPHjg6EbhC
X-Gm-Gg: ASbGncu0hbfonIcccM+0tkoSP5w5xIKOuZmKXj1+KXeBxP073jsAUy9Ft8MSAU9wbWK
 4U//wxgb9OQhNHVzyu/dfnowNIlUC9TM5GSMNxW+7aGm5cXwmEj4VAfVzQ/KQ97RQ++nDzzTUIA
 ==
X-Google-Smtp-Source: AGHT+IFzt9P2Gg6MdYX1Le3IqBeE4gtB4LGz3oOK/yEXib07u+epJxN4wYLl7XcvGNtj5TPD8WQpZRvfGytBttvv29M=
X-Received: by 2002:a17:907:d509:b0:abb:8cff:156 with SMTP id
 a640c23a62f3a-abb8cff04fdmr10718866b.7.1739640221240; Sat, 15 Feb 2025
 09:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20250215152206.135147-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250215152206.135147-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:23:29 -0700
X-Gm-Features: AWEUYZkyqBtY4S_pqTeo91xf52HMv_HZIe0xz-BN5EblTJ_Y_MRCEkKUV0CMnpw
Message-ID: <CAFLszThia4nosVyv+uPRngZXy6LMKAV50LeNJPmyeZm1Poo7Fg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_driver: create a parent device for all EFI block
 devices
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 15 Feb 2025 at 08:22, Heinrich Schuchardt
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

This looks very similar to this patch, which you shot down a few years back.

https://lore.kernel.org/u-boot/30f22c59-c6ce-1cea-9ef0-bdc31f7d57c2@gmx.de/

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

Regards,
Simon
