Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A440C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 12:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E263A80C7E;
	Sun, 16 Feb 2025 13:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SLrwB0DY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEEA80F10; Sun, 16 Feb 2025 13:57:16 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086628056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 13:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abb9709b5b5so34880066b.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 04:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739710633; x=1740315433; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GyrX4iY4iXU6BsB5mSw9HSmipmMHz8g1o5CHWHZO95g=;
 b=SLrwB0DYk2ylE85kwrk1bHmb3qXNorEzn5W06j1Ey84UIRJZh3TQiBqhkAqzCOgrQo
 +LKRoJLtwl6tIZ2yqOGPln7Q/gwK5TbrRZB7+iaWDgLJ2cWp59wlUqXcvrYhzYy5QS3l
 GV/Qh0SMgYncNv6BB2d/JwwY+Ai8EhZC/75mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739710633; x=1740315433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GyrX4iY4iXU6BsB5mSw9HSmipmMHz8g1o5CHWHZO95g=;
 b=tqM3cpTFqZXVN5d0GGXFfrEljVN+tX8GlYENHd3b0H2ksfWLbZhPYh+chQOKznVS5X
 UDNfLWsZWE6BRLpRHp2zyDyc2k8OtwUEXXxnMKaRm91n3xIVVmPXdec++XOYAPrwALjH
 OZiKMtenVVQykRcskjWdNOLHSSN8UueGjw68VZccqwWPw2iMNYCeu4IvZy2djKI9XuHh
 Z6KZ9jd3YrJBJNhxT3F1X8a5sGxsQEs8pE/pnsFltrpWv8KPZuYjBIb6mq+mlEwlpF5R
 UuKpjGpCsb7NOqnjfRLScNFHS//xU7lf6y3L2uc/B7RWEv2Bhzgg8OVHpDDK7WD5YzEv
 wLmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU32beVAkhDu80VsAiYNEoL9oq0UkT330JpdYKK8RT7Bq4l6qokKq4oDT8A0iTc3bekmjUWNuE=@lists.denx.de
X-Gm-Message-State: AOJu0YxeL0qo0XX2AzBbN5iMhEXv7Rrm3x8gJ0Vv+17LcD4lIKEbhoOZ
 w/nvG8CIr+5NTBhyIcxXb6TypiJ/FDX+SQZjBwOJETfGDZtAME5AOvzHXR2ACKB7BOcafdnrCts
 KN7JnFqK7kZuBgxMkzyrr9eDzyPyF33Pu0jnTViv3KAWaplc=
X-Gm-Gg: ASbGncto6r+2/2rS70y1Yw4jVUizurzhWPDPipkLv1/bqJkIXx+tqFWU5/Z7/PapSBn
 IUBAk6N7RxE6l1a3A2mWCHUZouPh6a5X9+QsL5ImqeqL8yvyQ5pDHLRo1708Vi4PMC6gPV0PvxA
 ==
X-Google-Smtp-Source: AGHT+IGtJgKrN+OCI4n9aS+x2OP3ByeRkjsjzQqw9U3J1eHN8tjk3yBA/0AwprSV533d6Aw2uBt/Y4xIYXyMT8fDaa8=
X-Received: by 2002:a17:907:7716:b0:ab7:c152:a3ca with SMTP id
 a640c23a62f3a-abb70c366e5mr532066266b.6.1739710633380; Sun, 16 Feb 2025
 04:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20250215152206.135147-1-heinrich.schuchardt@canonical.com>
 <CAFLszThia4nosVyv+uPRngZXy6LMKAV50LeNJPmyeZm1Poo7Fg@mail.gmail.com>
In-Reply-To: <CAFLszThia4nosVyv+uPRngZXy6LMKAV50LeNJPmyeZm1Poo7Fg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 05:57:02 -0700
X-Gm-Features: AWEUYZncYoqDfngHXk7ILqctBf6yCJBzZTj7ltyi8h48O0-2R7-YqQx4TNzZOCE
Message-ID: <CAFLszTjmxbObBDZj=KykpoR-vU6kOc=60q-Fdmmt+6qJdzbMGQ@mail.gmail.com>
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

On Sat, 15 Feb 2025 at 10:23, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Sat, 15 Feb 2025 at 08:22, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Up to now root has been the parent device for all block devices created via
> > calling ConnectController(). This does not work well together with the
> > implementation of bootstd.
> >
> > Add a dummy parent device for all EFI block devices.
> >
> > With this change EFI block devices are also accessible via commands like
> > 'cat', 'load', and 'ls'.
> >
> >     => dm tree
> >      Class     Seq    Probed  Driver                Name
> >     -----------------------------------------------------------
> >      efi           0  [ + ]   EFI block driver      `-- efi
> >      blk           3  [ + ]   efi_blk                   `-- efi.efiblk#0
> >      partition     0  [ + ]   blk_partition                 `-- efi.efiblk#0:1
> >
> >     => ls efiloader 0:1
> >            13   hello.txt
> >             7   u-boot.txt
> >     2 file(s), 0 dir(s)
> >
> >     => cat efiloader 0:1 hello.txt
> >     Hello world!
> >
> >     => efidebug dh
> >     0000000018df1700 (efi.efiblk#0:1)
> >       /VenHw(dbca4c98-6cb0-694d-0872-819c650cb7b8)/HD(1,MBR,0xd1535d21,0x1,0x7f)
> >       Block IO
> >       Simple File System
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_driver/efi_block_device.c | 29 ++++++++++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
>
> This looks very similar to this patch, which you shot down a few years back.
>
> https://lore.kernel.org/u-boot/30f22c59-c6ce-1cea-9ef0-bdc31f7d57c2@gmx.de/

In any case, we did and do need this, so this patch seems fine to me.


>
> >
> > diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
> > index d3c668dc183..070747de515 100644
> > --- a/lib/efi_driver/efi_block_device.c
> > +++ b/lib/efi_driver/efi_block_device.c
> > @@ -35,8 +35,10 @@
> >  #include <efi_driver.h>
> >  #include <malloc.h>
> >  #include <dm/device-internal.h>
> > +#include <dm/lists.h>
> >  #include <dm/root.h>
> >  #include <dm/tag.h>
> > +#include <dm/uclass-internal.h>
> >
> >  /**
> >   * struct efi_blk_plat - attributes of a block device
> > @@ -118,13 +120,18 @@ static ulong efi_bl_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >  static efi_status_t
> >  efi_bl_create_block_device(efi_handle_t handle, void *interface)
> >  {
> > -       struct udevice *bdev = NULL, *parent = dm_root();
> > +       struct udevice *bdev = NULL, *parent;
> >         efi_status_t ret;
> > +       int r;
> >         int devnum;
> >         char *name;
> >         struct efi_block_io *io = interface;
> >         struct efi_blk_plat *plat;
> >
> > +       r = uclass_find_first_device(UCLASS_EFI_LOADER, &parent);
> > +       if (r)
> > +               return EFI_OUT_OF_RESOURCES;
> > +
> >         devnum = blk_next_free_devnum(UCLASS_EFI_LOADER);
> >         if (devnum < 0)
> >                 return EFI_OUT_OF_RESOURCES;
> > @@ -221,6 +228,24 @@ efi_bl_init(struct efi_driver_binding_extended_protocol *this)
> >         return EFI_SUCCESS;
> >  }
> >
> > +/**
> > + * efi_block_device_create() - create parent for EFI block devices
> > + *
> > + * Create a device that serves as parent for all block devices created via
> > + * ConnectController().
> > + *
> > + * Return:     0 for success
> > + */
> > +static int efi_block_device_create(void)
> > +{
> > +       int ret;
> > +       struct udevice *dev;
> > +
> > +       ret = device_bind_driver(gd->dm_root, "EFI block driver", "efi", &dev);
> > +
> > +       return ret;
> > +}
> > +
> >  /* Block device driver operators */
> >  static const struct blk_ops efi_blk_ops = {
> >         .read   = efi_bl_read,
> > @@ -249,3 +274,5 @@ U_BOOT_DRIVER(efi_block) = {
> >         .id             = UCLASS_EFI_LOADER,
> >         .ops            = &driver_ops,
> >  };
> > +
> > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, efi_block_device_create);
> > --
> > 2.47.1
> >

Regards,
Simon
