Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A04CCD0425
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B76F583E7F;
	Tue,  6 Jan 2026 00:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H5kmRZ5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5718383E7F; Tue,  6 Jan 2026 00:31:00 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE52C83EC9
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b7ce5d6627dso93490966b.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655857; x=1768260657; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AHLjLbP0hJw3oqb/wag4KY7ilXTXOyIpbkwRPQRHpRc=;
 b=H5kmRZ5rd5X0XnCZ1Ptgyrx56pXlsHrUba31Zb59vzRiqLF8Lb8Z1m2/L+QcC+IZr3
 8uzGtLBdA3mTbS758FhQhmpqenQC7YhlKgQ25RcyQudvXTsYuMn6Jwqx8koUqdsgkLPZ
 0wgI2UWlKJ0EwvWRevSsrH6caGhB+OTJ7tnVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655857; x=1768260657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHLjLbP0hJw3oqb/wag4KY7ilXTXOyIpbkwRPQRHpRc=;
 b=YTRgIsZ5LAX6syfJZ64mEZ9Zwi7nqj9e8dEtAl1znJjOmQMGSQBxSlBH+vxoyOs1PU
 MzYJq9GadH8uGJssThIfWUh3ufNkh4xxVuqK/IgygMAMi4GAv0JNddrsIty3XQmLJdiq
 DoRvpvjEuN56DggaTfd4SL9nTgNa9+VjrOuiwtTs6RwyG0y43uzkHRsdsAq/b5nWPvgJ
 JufOEPoKGWo9ifgxFXvcIdilok7RBJQ9m/fwS+RkRCRQzZC8xHVClE8EkG0Dk/3roSmA
 bqKOAYDwdMupQeqSkHgLN9yAha2sMEcqUhu6BvXH9kcr4jEQoRO8mdXhJH3SIXQc9jAD
 60HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1luuAyMut0Pf5eISSNVX9uu0sBCGCJSo2wCWpOs4AK1ncHNgx0qCNu/qjjzEHu5YU4z3Hyxo=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ2oRue51EGYbqZYtGQ+HmSl8F47u1mYJQn0C9/HOpknxa6X6S
 O7vHlo9lxsTbKgOaG4ImQXKeb7qktcDQEnURmCGkuSeJ+C5t4nRtLghH+FLbRl6OkxeJnYuc1Z0
 rQNHvngdpfK45mBufHAmATo3Z4du+DZ5t/0vCdSV0
X-Gm-Gg: AY/fxX4a03QqaNtMCNZ/x2LwJaJ4uXwyVfemFa7aCewjW12JzxCsP1zsu5Urm9o9rH+
 1gymwCSbJumYyt6CB4cvf+ZRmHogV9SVzzLTHndYsOgvO8LNGQE2rDiZwO8tBDqr8LoWdlmjp5d
 zh9utWeobP7bHelKfolTe1yRer9Yr02CjsdscXsLTUrdyPszLdg1rFcpqTSBK/6zAPRwaUHPOn1
 FSqJ50xi8zUw4Ga8vCTzdmHneKdEIq6eUdGJxpCtcTMSb2Wl7IJ6u9I9pZo3mLaVlR8cA==
X-Google-Smtp-Source: AGHT+IF24LXl6eMGrESCPuv4DG45xnSxSCgFUqEtIs+fQJxVSlafGohV7bGcdrPtiT/50ZIZjXvPKC74EEncxfxAKjg=
X-Received: by 2002:a17:907:97c7:b0:b75:7b39:847a with SMTP id
 a640c23a62f3a-b8426c1ebe4mr115660166b.60.1767655857257; Mon, 05 Jan 2026
 15:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-4-visitorckw@gmail.com>
In-Reply-To: <20260105165221.1816070-4-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:26 -0700
X-Gm-Features: AQt7F2q6OdoxxiwTPPLCXF9ld014tbwUtMz7t0r1hnL7XGqTIh52WVHATFQXkXo
Message-ID: <CAFLszTiMZLXoXEk=JL3siZURVD2YdnmQ7HXy=Viw8uUFbrL6qg@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] rtc: goldfish: Support platform data for non-DT
 probing
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Mon, 5 Jan 2026 at 11:20, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Currently, the Goldfish RTC driver exclusively relies on device tree
> to retrieve the base address, failing immediately if dev_read_addr()
> returns FDT_ADDR_T_NONE. This restriction prevents the driver from
> being used on platforms that instantiate devices via U_BOOT_DRVINFO()
> instead of device tree, such as the QEMU m68k virt machine.
>
> Add support for platform data to address this limitation. Update the
> probe function to fall back to retrieving the base address from
> struct goldfish_rtc_plat if the device tree address is unavailable.
> Introduce a new header file include/goldfish_rtc.h to define the
> platform data structure.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> Changes in v5:
> - Rebase on u-boot/next branch.
>
>  drivers/rtc/goldfish_rtc.c | 13 ++++++++++---
>  include/goldfish_rtc.h     | 15 +++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
>  create mode 100644 include/goldfish_rtc.h
>

You can package your own devicetree in the U-Boot source, to handle
what you need.

> diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
> index e63a2766c76..f6316896595 100644
> --- a/drivers/rtc/goldfish_rtc.c
> +++ b/drivers/rtc/goldfish_rtc.c
> @@ -9,6 +9,7 @@
>
>  #include <div64.h>
>  #include <dm.h>
> +#include <goldfish_rtc.h>
>  #include <mapmem.h>
>  #include <rtc.h>
>  #include <linux/io.h>
> @@ -77,12 +78,18 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
>  static int goldfish_rtc_probe(struct udevice *dev)
>  {
>         struct goldfish_rtc *priv = dev_get_priv(dev);
> +       struct goldfish_rtc_plat *plat;
>         fdt_addr_t addr;
>
>         addr = dev_read_addr(dev);
> -       if (addr == FDT_ADDR_T_NONE)
> -               return -EINVAL;
> -       priv->base = map_sysmem(addr, 0x20);
> +       if (addr != FDT_ADDR_T_NONE) {
> +               priv->base = map_sysmem(addr, 0x20);
> +       } else {
> +               plat = dev_get_plat(dev);
> +               if (!plat)
> +                       return -EINVAL;
> +               priv->base = plat->base;
> +       }
>
>         return 0;
>  }
> diff --git a/include/goldfish_rtc.h b/include/goldfish_rtc.h
> new file mode 100644
> index 00000000000..bb113a0bd79
> --- /dev/null
> +++ b/include/goldfish_rtc.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef _GOLDFISH_RTC_H_
> +#define _GOLDFISH_RTC_H_
> +
> +#include <linux/types.h>
> +
> +struct goldfish_rtc_plat {
> +       void __iomem *base;
> +};
> +
> +#endif /* _GOLDFISH_RTC_H_ */
> --
> 2.52.0.358.g0dd7633a29-goog
>

Regards,
Simon
