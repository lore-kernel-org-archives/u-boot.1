Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F42C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EA0889AA;
	Wed, 14 Aug 2024 14:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fT9jTJVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B781C8899D; Wed, 14 Aug 2024 14:40:16 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C45889AA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a1d3874c1eso349249585a.2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723639212; x=1724244012; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MyyNRenyYo1bd5Ta6o8Jsysclm22iom6/hx/Qdee1Eg=;
 b=fT9jTJVDcDqQMBPA/FBAiCVPXnDxmr/2lc2AXE/uM3TSRhK8mk19WPLQlyfm6ZKrW1
 Z7HQx8KGT7GsIQXGPoHlUpVUmlhImDIBwI8mSoAkAKVzDrYtw2N9sb0D9F3v+0gU1du1
 iPBbw8s3anDiWN40ySpjDOafmOI3zDGeS2zXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723639212; x=1724244012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MyyNRenyYo1bd5Ta6o8Jsysclm22iom6/hx/Qdee1Eg=;
 b=FqznoLioymme8xVrldyz3VDM2F1IL+xLNLO/91ZtCaU8uzejJbBUlfOAoLBG3Q14LG
 IpJs6S0KzQ+cocC3XPaH9oX+yKAPcQpXBcAWXtkifVU0R/YOmdWxkLW1RMy7wcY6erDO
 V1kPc1h9Rw9xF8oLa1WHcK+HC/o5LRRTRqeVuJBUj3MWmtQUPcDCqpuMh9TPGOCRO5LI
 EctwTaLEtK0wKurUj0RPkzYYH/nV8kNncEeXiPv18bA5Tw4cxdxHyfV/kNG8x1nZC88S
 o2bIzlx/rcLCRwR/0vNB6Uk6UC6ruyNSJP4MuWaHbSPAqvepG3msIMsbjmdMzT6B4BHU
 4BMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW39+yevst3X+UMT9diU7mlKYCUO8uUz+rtGE7dPGLGRdxvW0MzAaCbAGnzGHc4uxcnCSEAJrod2DD60W7s85GDHEzLaw==
X-Gm-Message-State: AOJu0YxhISASp1IZ5t5VTNmT9+RpVOeQ+bEI2WdWe8a8tw84w7u1sA/C
 z2hW2feNtW50qgae5UG/OFIQlWWLlJDbLePTEiwtR/thGkdodD8FYpjHUBl2o4/sdXTgErd0c3b
 DOBaQPO8fidBXFHIBxDXspPEqtr5hGqb0E6c5
X-Google-Smtp-Source: AGHT+IHjOhjmW7PmXiWt5i4tlQtEHYYShaR5z+cj7NRwBGER4KcybDA3DItMcrmKT3n8/f4UWspIs0iba0F+IVKwVdQ=
X-Received: by 2002:a05:6214:5342:b0:6b5:eba0:d0ab with SMTP id
 6a1803df08f44-6bf5d1f4cd3mr28162026d6.15.1723639212057; Wed, 14 Aug 2024
 05:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 14 Aug 2024 06:40:01 -0600
Message-ID: <CAFLszTj29ZXtVSmyA-pDp61UuvvMEVks5barSYjNRqUH+mgSpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 01:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> A system may have multiple SATA controller. Removing the controller with
> the lowest sequence number before probing all SATA controllers makes no
> sense.
>
> In sata_rescan we remove all block devices which are children of SATA
> controllers. We also have to remove the bootdev devices as they will be
> created when scanning for block devices.
>
> After probing all SATA controllers we must scan for block devices otherwise
> we end up without any SATA block device.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         continue unbinding and scanning if one device fails
>         write a message if scanning fails
>         add device name to error message
> v2:
>         Scanning for device on an unprobed SATA controller leads
>         to an illegal memory access.
>         Use uclass_foreach_dev_probe() instead of uclass_foreach_dev().
> ---
>  drivers/ata/sata.c | 48 +++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> index 84437d3d346..89cd516f3d6 100644
> --- a/drivers/ata/sata.c
> +++ b/drivers/ata/sata.c
> @@ -9,9 +9,12 @@
>   *             Dave Liu <daveliu@freescale.com>
>   */
>
> +#define LOG_CATEGORY UCLASS_AHCI
> +
>  #include <ahci.h>
>  #include <blk.h>
>  #include <dm.h>
> +#include <log.h>
>  #include <part.h>
>  #include <sata.h>
>  #include <dm/device-internal.h>
> @@ -49,38 +52,39 @@ int sata_scan(struct udevice *dev)
>
>  int sata_rescan(bool verbose)
>  {
> +       struct uclass *uc;
> +       struct udevice *dev; /* SATA controller */
>         int ret;
> -       struct udevice *dev;
>
>         if (verbose)
> -               printf("Removing devices on SATA bus...\n");
> -
> -       blk_unbind_all(UCLASS_AHCI);
> -
> -       ret = uclass_find_first_device(UCLASS_AHCI, &dev);
> -       if (ret || !dev) {
> -               printf("Cannot find SATA device (err=%d)\n", ret);
> -               return -ENOENT;
> -       }
> -
> -       ret = device_remove(dev, DM_REMOVE_NORMAL);
> -       if (ret) {
> -               printf("Cannot remove SATA device '%s' (err=%d)\n", dev->name, ret);
> -               return -ENOSYS;
> +               printf("scanning bus for devices...\n");
> +
> +       ret = uclass_get(UCLASS_AHCI, &uc);
> +       if (ret)
> +               return ret;
> +
> +       /* Remove all children of SATA devices (blk and bootdev) */
> +       uclass_foreach_dev(dev, uc) {
> +               log_debug("unbind %s\n", dev->name);
> +               ret = device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
> +               if (!ret)
> +                       ret = device_chld_unbind(dev, NULL);
> +               if (ret && verbose) {
> +                       log_err("Unbinding from %s failed (%dE)\n",
> +                               dev->name, ret);
> +               }
>         }

This code is in usb_stop() to, so please put it in a shared function.
How about uclass_unbind_children(enum uclass_id) ?

>
>         if (verbose)
>                 printf("Rescanning SATA bus for devices...\n");
>
> -       ret = uclass_probe_all(UCLASS_AHCI);
> -
> -       if (ret == -ENODEV) {
> -               if (verbose)
> -                       printf("No SATA block device found\n");
> -               return 0;
> +       uclass_foreach_dev_probe(UCLASS_AHCI, dev) {
> +               ret = sata_scan(dev);
> +               if (ret && verbose)
> +                       log_err("Scanning %s failed (%dE)\n", dev->name, ret);
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static unsigned long sata_bread(struct udevice *dev, lbaint_t start,
> --
> 2.45.2
>

If you have time, please add a test for ahci (dm/test/ahci)

Regards,
Simon
