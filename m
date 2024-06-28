Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E68C3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 07:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CF888155;
	Fri, 28 Jun 2024 09:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZidmUktZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E7288027; Fri, 28 Jun 2024 09:33:04 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44768824A
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 09:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-444be1a2b01so1716641cf.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719559980; x=1720164780; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1IX5wwC+AUawoa015e+m5RZ5b5PTYBiykGiYpwP2I7k=;
 b=ZidmUktZbLjNTtYvGfBnmVK8zFQiMXb/x23wM7V5zLy1oskc1vO5zOEcpI+XH8SJQn
 e5+nNAaykRTw881/TrTSV0HO0i4gCh3DEvsB7S06UcTSUkzQ15J7NKShKZ/Wm3UgXUh7
 LNfZbE5k0VvwC4QLxChH+9YHx5CGuPoQzDgnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719559980; x=1720164780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1IX5wwC+AUawoa015e+m5RZ5b5PTYBiykGiYpwP2I7k=;
 b=YCFKyOem3mHQ05aeZdL14tSHBhjBS/8vb8zdbQxGUIeIP1EMCtjG/oFeDvQ8G4QlBa
 kAg4ym+uC0WIg0XpKSE6XvL1sJ8mX4my4bMvvQCr0OHRzkW+citP+ijBhfbrWfKpOFU3
 GmB66N0CyjOh9Eu4mViLVOpOlBBNvQUP5if7rbnJFaZ4wVNLv1+111suzmakd8oSWIF7
 2SOJ/x2jVFdf4Ru0AaD0WC3KnZo8NF/ggc/3glAq3j+HyYm9wutvrBFt27PuYGWcytZ7
 PwKJ734gzI/m/MyuKwztHeIbpM9OwqmxxVEgSxQVa7AFXJ0FM4gmla2MZMq147awndzp
 lSyw==
X-Gm-Message-State: AOJu0YyMrhBqke5ztG/E24pyKxVV9APHeMTg7NrrAtGx+iJ0l6CCRKJy
 r6AXJjBfe+1D4JaD318OCsFxfLDi1RxfDB9QXsAZo9obyv628Zt5WGJUoWCH0BOq+FF9qytUlRC
 Y57loR7WhJx7XB50NmB+4SZXvRYMwIqS8ksWIf8Z1eo0ABfonTw==
X-Google-Smtp-Source: AGHT+IF3MY9tHjsyAkEFsx0LUu6x/OLx42vR9WtnvXpj136rTHDN3zAAfkWHyBFDKDWooDE1flCA8esRCzqSAtn67TY=
X-Received: by 2002:a05:6214:1630:b0:6b2:c840:7a2 with SMTP id
 6a1803df08f44-6b540aa8879mr154967676d6.45.1719559980574; Fri, 28 Jun 2024
 00:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240628024804.149871-1-marex@denx.de>
In-Reply-To: <20240628024804.149871-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 08:32:49 +0100
Message-ID: <CAFLszTh_u8ipmSqyi73TVZ=kCGnk8mnb7Ww3HeHwUXSEdGqVEg@mail.gmail.com>
Subject: Re: [PATCH v2] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

Hi Marek,

On Fri, 28 Jun 2024 at 03:48, Marek Vasut <marex@denx.de> wrote:
>
> Insert /u-boot,spl-applied-dto-<dto-name> = <index> property into the
> U-Boot control DT during SPL DTO application process. This can be used
> by user to inspect which DTOs got applied by the SPL and in which order
> from running U-Boot.
>
> Example:
> ```
> u-boot=> fdt addr $fdtcontroladdr && fdt list /
> Working FDT set to aee9aeb0
> / {
>         u-boot,spl-applied-dto-fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 = <0x00000005>;
>         u-boot,spl-applied-dto-fdt-dto-imx8mp-dhcom-som-overlay-rev100 = <0x00000004>;
>         u-boot,spl-applied-dto-fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast = <0x00000003>;
>         u-boot,spl-applied-dto-fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast = <0x00000002>;
> ...
> ```
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Suniel Mahesh <sunil@amarulasolutions.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
> V2: - Expand the DT by one more byte to cater for trailing NUL byte
>     - Update comment related to the expansion of DT
>     - Flip the !ret conditional, which was incorrect and missed
>     - Expand prefix to u-boot,spl-applied-dto-
>     - Document the binding
> ---
>  common/spl/spl_fit.c                | 29 +++++++++++++++++++++++++++--
>  doc/device-tree-bindings/config.txt | 11 +++++++++++
>  2 files changed, 38 insertions(+), 2 deletions(-)

Once this is figured out, can you extend test/image/spl_load_os.c to
test this code?

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 988125be008..0a6b5ea8212 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -363,6 +363,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>  {
>         struct spl_image_info image_info;
>         int node, ret = 0, index = 0;
> +       char dtoname[256];
>
>         /*
>          * Use the address following the image as target address for the
> @@ -448,9 +449,13 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>                         if (ret < 0)
>                                 break;
>
> -                       /* Make room in FDT for changes from the overlay */
> +                       /*
> +                        * Make room in FDT for changes from the overlay,
> +                        * the overlay name and the trailing NUL byte in
> +                        * that name.
> +                        */
>                         ret = fdt_increase_size(spl_image->fdt_addr,
> -                                               image_info.size);
> +                                               image_info.size + strlen(str) + 1);

Oh and I missed the room for the property, sorry. It needs something like this:

ALIGN(strlen(str) + 1, 4) + 12 + 4

the first bit is the string-table size increase

12 is sizeof(struct fdt_property)
4 is the u32 size

Alos, is there any way to check that there is actually enough space to
increase the size?


>                         if (ret < 0)
>                                 break;
>
> @@ -464,6 +469,26 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>
>                         debug("%s: DT overlay %s applied\n", __func__,
>                               fit_get_name(ctx->fit, node, NULL));
> +
> +                       /*
> +                        * Insert /u-boot,<dto-name> = <index> property into
> +                        * the U-Boot control DT. This can be used by user
> +                        * to inspect which DTOs got applied by the SPL from
> +                        * a running U-Boot.
> +                        */
> +                       snprintf(dtoname, sizeof(dtoname), "u-boot,spl-applied-dto-%s", str);
> +                       ret = fdt_setprop_u32(spl_image->fdt_addr, 0, dtoname,
> +                                             index);
> +                       if (ret) {
> +                               /*
> +                                * The DTO itself was applied, do not treat the
> +                                * insertion of /u-boot,<dto-name> as an error
> +                                * so the system can possibly boot somehow.
> +                                */
> +                               debug("%s: DT overlay %s name not inserted into / node (%d)\n",
> +                                     __func__,
> +                                     fit_get_name(ctx->fit, node, NULL), ret);
> +                       }
>                 }
>                 free(tmpbuffer);
>                 if (ret)
> diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
> index f50c68bbdc3..7aa6d9a72c6 100644
> --- a/doc/device-tree-bindings/config.txt
> +++ b/doc/device-tree-bindings/config.txt
> @@ -95,6 +95,17 @@ rootdisk-offset (int)
>  silent-console (int)
>         If present and non-zero, the console is silenced by default on boot.
>
> +u-boot,spl-applied-dto-* (int)
> +       Emitted by SPL into U-Boot control DT root node in case a DTO from
> +       fitImage was applied on top of U-Boot control DT by the SPL fitImage
> +       loader. The single integer cell indicates in which order was the DTO
> +       applied by the SPL and matches the index of the DTO in the fitImage.
> +       DTOs in fitImage may be skipped using board_spl_fit_append_fdt_skip(),
> +       therefore the integers might not be monotonically incrementing, there
> +       may be gaps. This property can be used to determine which DTOs were
> +       applied by the SPL from running U-Boot by inspecting the U-Boot
> +       control DT.

Should we send a binding with this? I wonder if it would be better to
make the filename a property value rather than including it in the
property name/string table? That way you would not need the
integers...the ordering would be enough.

E.g.

u-boot,spl-applied-dtos = "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast",
      "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast";

But that might be more annoying to construct as you would probably
need fdt_setprop_placeholder()

> +
>  u-boot,spl-payload-offset (int)
>         If present (and SPL is controlled by the device-tree), this allows
>         to override the CONFIG_SYS_SPI_U_BOOT_OFFS setting using a value
> --
> 2.43.0
>

Regards,
Simon
