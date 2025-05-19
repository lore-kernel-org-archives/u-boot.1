Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD28C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 12:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF7F382B0E;
	Mon, 19 May 2025 14:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LUrYQEcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15DE782B26; Mon, 19 May 2025 14:42:41 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB3081FEE
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 14:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso708036766b.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747658558; x=1748263358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ymx5B3L6BWYb3MeqpsbJkCZeDsf3jd45eKwodMAFeZI=;
 b=LUrYQEcn1soSMw+/VZ5M0mfG0768g9P9mZbxHnHYp++A0xfVBXVWSQqanIlhG7oEKW
 30JpD/eruBdzY1Z2JHPLzl31QNzUOxgBUFcMY+SpOVG2GSRlbC1oSe2ITTDoOhWYnekY
 0XYBtPI1BNkaAZF11mioEQphZc62GvDXOlr+84udzKfXdhm11s8K6QPkojbYqzGnTrh7
 TOoQzvg+6L+m0oFAqagA2sL5BD+StBwx8JKJnin6qdOgaE3NE8GQjmGA7ko3u7qWO8Gw
 Fyfp94jGZbPo19CM0BsT23G45UxJl1hHbT6QLnuGqC3cZmlfwgNqMhGT+t2bGmX/JNyK
 /BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747658558; x=1748263358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymx5B3L6BWYb3MeqpsbJkCZeDsf3jd45eKwodMAFeZI=;
 b=I5C7M0458PSeAwRBXx7ZZzMZLVvYwe0iQOhAll6s2nN/smOcnZLFm5YVLsCn1oRN78
 ufPQ31werhdDB9xPtpeWtf8llkR+9dpnDs77ldGP/ieamEUq6y/2lQo1jmFqpOY6aNYX
 LMtI6TzcOKEuoG3M4MjEqXkInwqkTPpaoABy+JQYEPolKKB7IsMetvFS4GEFhJg74oYO
 Yb1Mbaw43PutJsQOR1gJcv4GD/hVSZlyM+0pUCEr9MK3rrvM/d7ykI6HF8qU7s5ce0OQ
 IM616WVhU69yUNw/iQzj7YRb99bzPW7mFwKVTp0Jd3eruAWEJSUTndqGgTM3pdXkYUdl
 /shg==
X-Gm-Message-State: AOJu0Ywhwr9wTLN8rTwnA3hnt8O9NekEl+sDSPCp0uDIx31zOZgKeWkZ
 QxxzD3pYeWzBKgkSyKbv+8tcbku/H3gS+ep6edeycPOZc1PMNHDzdCkmX5RTixh3OT9vbukb4v9
 GbMo/j/s9OY8wAZR7NYUe7e0LRJttfcs=
X-Gm-Gg: ASbGncuGSJZLH/aAbxOkS2+jpdA8L/xLyKtRb9uwLd65RzXgtbHXCjVhbwwg9YR0rty
 hiKIkMuPsYQb1/+jRyJaen9kuTIhDVpuNwSeeQ+xzEJ+jViQNF6r7ew9C329Q0ke5DT3JtTpamP
 ktdJgo9zarE35yniSxICSzw2JIeD6jGsI=
X-Google-Smtp-Source: AGHT+IGXUxHedwOTEXHXVe1WF5yP6J5xLpTPQsGjJTyhg5KW+cwM0eo8QGdMpOCpX39pDxgq6ZczN0heEQqysKHLcpI=
X-Received: by 2002:a17:907:2d1f:b0:ad4:d8cf:ce9a with SMTP id
 a640c23a62f3a-ad536b7bf1fmr897123366b.9.1747658558202; Mon, 19 May 2025
 05:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 19 May 2025 18:12:21 +0530
X-Gm-Features: AX0GCFtkcEurCvC09QPYmhml9uH4leHPb1AZkQG4Sd7ZEHRimKSRuaCn-ExG7Ck
Message-ID: <CANAwSgSMJGy6hXP8++pfnqkuzH66zhn=UROK4MTs5mrdnyyhFA@mail.gmail.com>
Subject: Re: [PATCH 1/4] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tom Rini <trini@konsulko.com>
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

Hi Lukasz,

On Fri, 25 Apr 2025 at 16:32, Lukasz Czechowski
<lukasz.czechowski@thaumatec.com> wrote:
>
> Currently the check in usb_onboard_hub_bind is relying on specific
> compatible string for the Michrochip USB5744. Replace this with
> more generic approach that will allow to add new types of devices
> to the of_match table. Because the driver only needs to bind one
> "half" of the hub, the peer-hub node is used to find out if it
> was already done. In case peer-hub was bound, -ENODEV is returned.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>  common/usb_onboard_hub.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 7fe62b043e6a..9f8c1a304cdf 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -9,6 +9,7 @@
>
>  #include <asm/gpio.h>
>  #include <dm.h>
> +#include <dm/device.h>
>  #include <dm/device_compat.h>
>  #include <i2c.h>
>  #include <linux/delay.h>
> @@ -179,8 +180,8 @@ err:
>  static int usb_onboard_hub_bind(struct udevice *dev)
>  {
>         struct ofnode_phandle_args phandle;
> -       const void *fdt = gd->fdt_blob;
> -       int ret, off;
> +       struct udevice *peerdev;
> +       int ret;
>
>         ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
>         if (ret == -ENOENT) {
> @@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *dev)
>                 return ret;
>         }
>
> -       off = ofnode_to_offset(phandle.node);
> -       ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
> -       if (!ret)
> +       ret = device_find_global_by_ofnode(phandle.node, &peerdev);
> +       if (ret) {
> +               dev_dbg(dev, "binding before peer-hub %s\n",
> +                       ofnode_get_name(phandle.node));
>                 return 0;
> +       }
> +
> +       dev_dbg(dev, "peer-hub %s has been bound\n", peerdev->name);
>
>         return -ENODEV;
>  }
>

Thanks for your work

I'm currently trying to reorder my changes for the
Odroid Amlogic platform on top of your patch series.
However, I'm facing an issue where the probe is not getting called
and it isn't working on the Odroid N2+ board. I'm struggling to identify the
missing piece that's causing this failure. Could you share some pointers?

# dm tree
 simple_bus   11  [ + ]   dwc3-meson-g12a       |   `-- usb@ffe09000
 usb_gadget    0  [   ]   dwc2-udc-otg          |       |-- usb@ff400000
 usb           0  [ + ]   xhci-dwc3             |       `-- usb@ff500000
 usb_hub       0  [ + ]   usb_hub               |           `-- usb_hub
 usb_hub       1  [ + ]   usb_hub               |               |-- usb_hub
 usb_mass_s    0  [ + ]   usb_mass_storage      |               |
`-- usb_mass_storage
 blk           2  [ + ]   usb_storage_blk       |               |
 |-- usb_mass_storage.lun0
 partition     0  [ + ]   blk_partition         |               |
 |   `-- usb_mass_storage.lun0:1
 bootdev       3  [   ]   usb_bootdev           |               |
 `-- usb_mass_storage.lun0.bootdev
 usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub

# dm devices
                                  usb_hub
usb_kbd                   062 keyboard             <none>
usb_mass_storage          066 usb_mass_storage     usb_mass_storage
usb_onboard_hub           128 usb_hub              <none>
usb_storage_blk           022 blk                  usb_mass_storage.lun0

Thanks
-Anand
