Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9787CF2591
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0189F83F1F;
	Wed, 19 Nov 2025 14:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ixghj5bH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF57883EFC; Wed, 19 Nov 2025 14:17:17 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A82B83F2D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b736ffc531fso900541166b.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558235; x=1764163035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ArchAiGYHcqM52F88B7QYtsM/P2HaCrtL15P+hcfLWo=;
 b=ixghj5bHQGUZwlUulukC0YDVGzLnZRGTHfHfnA73ZmlfJ7fcgyF8WDKKS8ceWfKyDm
 PWJ/5H35JLaNxz7oPvJUi1IgrqMVVancTEzZ9+ALE5E6EXVDApS63wlcS+vRISmIZiC1
 VllmDqb6wXbMp85TJMx/FPtdWLXWnO9zGDHYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558235; x=1764163035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArchAiGYHcqM52F88B7QYtsM/P2HaCrtL15P+hcfLWo=;
 b=n969is+KTPy1ueCg3z0oefaW9JH10oTjLNAoSEcxUaHLGTJos2zys27ko1RuEhqtYq
 fDIB74WRQgWcV75WTvj9dkcstA+p9dJYOl0nTxIwNCpEJ5Vgz21f6pbGVv9i12Vb90XK
 3PrZzCk8KU0NDkWPbukQ8aL7InUJyLlyn015NmJpYh3MwveC8OZf9JhYW8Tm0i3XUUOE
 YeUcHya7Z1G5/SHsx6UrPakY4Un67Y4RJvxuDKnp6gW85Qz2sxiXA7ipndq0Pm8L4idm
 IncsyWt0mkCyhBRqUvywGX0/fXoW0qJNKP6bfbMAHZ2WXjuOv7M+rDJN75prKDxz/uIH
 CM7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKwa38D95IdQfd9UE/oT/95dUEQOpvP9LljY3gfgVNp7OpTvHzG2NfZy5ZaqDWtKFd7XI4hh0=@lists.denx.de
X-Gm-Message-State: AOJu0YwsKCF+PVK5KoXj2VR7lYFw1e8rRYRvMWYKRw1LRKrOdbgAAp1F
 hjZEWLKBh+Zxwd3Of0qO0X1H/cgYoYGtrNkk0K/igDK68zFBh5VRHIt4nsj091dNVZM4DBpeipo
 3DVZP2Nc3E7Hbi0mac6n8NGtxyfh+lbWTT4plGmsN
X-Gm-Gg: ASbGncsY2hjBtMgRkQ6lGikIT7trR81GnhISA1ALD8Rcl+bNxhzwOGxLOaLdlSPyOmp
 tbvqivW3FSUxNy0lUN0wEEbfDTXZc8tzTZDVQzVd0VK1dX3tQaTuOvpeS0+n8Iv+ObVXe1kMLZk
 Z9ohRgNYqSHY59fxQ98V7qE3MlE2AdwFntP4q+NdcIDb3/2oAlW3AZe1PXfE0N1GVaMA8NXpc2r
 B3X4eE3KAtim3QrO8lyWijbPfmfG4B3podWYria5Yb3HyIVBShMjF+6KzkCbq68rkx77g==
X-Google-Smtp-Source: AGHT+IFSaRCLxxAsPAnDTOjYj+Bi/nCiRj4Wo1ydXFdlWOEDhNpSs7iYuQXSpAkmYqA81Z2u8WMAPAzXokCiFUEhVEo=
X-Received: by 2002:a17:906:dc89:b0:b72:70e7:5b62 with SMTP id
 a640c23a62f3a-b7637899c45mr280323566b.23.1763558234973; Wed, 19 Nov 2025
 05:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
 <20251114-bootconfig-v3-3-a28b813dba90@baylibre.com>
In-Reply-To: <20251114-bootconfig-v3-3-a28b813dba90@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:17:01 -0700
X-Gm-Features: AWmQ_bnHMisFMnviNrUf3ddtwW9QWuWY2P2dmai3c8zWN_nqgy0sJYklajjCa_8
Message-ID: <CAFLszTjw+pc8pK42fOpyyxwQ1K0MPjBaWEnv-UBGO36zFBCx7A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] boot: android: Add bootconfig support
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, 
 George Chan <gchan9527@gmail.com>, Sam Day <me@samcday.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>
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

Hi Guillaume,

On Fri, 14 Nov 2025 at 08:28, Guillaume La Roque (TI.com)
<glaroque@baylibre.com> wrote:
>
> For android vendor boot image version 4 bootconfig is mandatory.[1]
>
> In the android_image_get_ramdisk function, after copying both vendor and
> boot ramdisks, we extract all androidboot.* entries from the kernel
> command line. These entries are added to the bootconfig section.
> We then update the sizes of the ramdisk and bootconfig.
> Finally, all androidboot.* entries are removed from the kernel command
> line.
>
> [1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#bootloader-support
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>  boot/image-android.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 109 insertions(+), 11 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/boot/image-android.c b/boot/image-android.c
> index 613f2aa4b9e..94c2879dcd6 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -503,6 +503,112 @@ ulong android_image_get_kcomp(const void *hdr,
>                 return image_decomp_type(p, sizeof(u32));
>  }
>
> +static u32 android_image_set_bootconfig(const void *hdr,
> +                                       const void *vendor_boot_img,
> +                                       ulong ramdisk_ptr)

This could use a comment.

Also, ramdisk_ptr is a strange name for an address as it sounds like
it is a pointer. Perhaps use ramdisk_addr ?

> +{
> +       /* Extract androidboot.* parameters from bootargs */
> +       const char *bootargs = env_get("bootargs");
> +       char *androidboot_params = NULL;
> +       char *new_bootargs = NULL;
> +       size_t androidboot_params_len = 0;

As a general comment, some of the args are quite long and this makes
the code harder to read. For example this could be params_len, since
we know this is Android Boot.

> +       struct andr_image_data img_data;
> +       u32 bytes_added = 0;
> +
> +       if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
> +               return 0;
> +
> +       if (bootargs && img_data.bootconfig_size) {
> +               size_t len = strlen(bootargs);
> +
> +               androidboot_params = malloc(len + 1);
> +               new_bootargs = malloc(len + 1);
> +               if (!androidboot_params || !new_bootargs) {
> +                       free(androidboot_params);
> +                       free(new_bootargs);
> +                       printf("Error: malloc failed\n");
> +                       return -ENOMEM;
> +               }
> +
> +               /* Extract androidboot.* and build new bootargs in one pass */
> +               const char *src = bootargs;
> +               char *bc_dst = androidboot_params;
> +               char *args_dst = new_bootargs;
> +
> +               while (*src) {
> +                       /* Skip leading spaces */
> +                       while (*src == ' ')
> +                               src++;
> +                       if (!*src)
> +                               break;
> +
> +                       /* Check if this param starts with androidboot. */
> +                       if (strncmp(src, "androidboot.", 12) == 0) {
> +                               /* Copy to bootconfig (add newline if not first) */
> +                               if (bc_dst != androidboot_params)
> +                                       *bc_dst++ = '\n';
> +                               while (*src && *src != ' ')
> +                                       *bc_dst++ = *src++;
> +                       } else {
> +                               /* Copy to new bootargs (add space if not first) */
> +                               if (args_dst != new_bootargs)
> +                                       *args_dst++ = ' ';
> +                               while (*src && *src != ' ')
> +                                       *args_dst++ = *src++;
> +                       }
> +               }
> +
> +               *bc_dst++ = '\n'; /* Final newline for bootconfig */
> +               *bc_dst = '\0';
> +               *args_dst = '\0';
> +               androidboot_params_len = bc_dst - androidboot_params;
> +
> +               /* Update bootargs if we extracted any androidboot params */
> +               if (androidboot_params_len > 1)
> +                       env_set("bootargs", new_bootargs);
> +       }
> +
> +       /* Map addresses for memcpy operations */
> +       void *ramdisk_dest = map_sysmem(ramdisk_ptr, img_data.ramdisk_size);
> +       void *vendor_ramdisk_src =
> +               map_sysmem(img_data.vendor_ramdisk_ptr, img_data.vendor_ramdisk_size);
> +       void *boot_ramdisk_src =
> +               map_sysmem(img_data.ramdisk_ptr, img_data.boot_ramdisk_size);

We tend to declare things at the top of the function. You could split
the function if you like.

> +
> +       memcpy(ramdisk_dest, vendor_ramdisk_src, img_data.vendor_ramdisk_size);
> +       memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size, boot_ramdisk_src,
> +              img_data.boot_ramdisk_size);
> +
> +       if (img_data.bootconfig_size) {
> +               void *bootconfig_src =
> +                       map_sysmem(img_data.bootconfig_addr, img_data.bootconfig_size);
> +               memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size +
> +                       img_data.boot_ramdisk_size,
> +               bootconfig_src, img_data.bootconfig_size);
> +               unmap_sysmem(bootconfig_src);
> +
> +               /* Add androidboot.* parameters to bootconfig */
> +               if (androidboot_params && androidboot_params_len > 1) {
> +                       ulong bootconfig_ptr = (ulong)ramdisk_dest +
> +                                       img_data.vendor_ramdisk_size +
> +                                       img_data.boot_ramdisk_size;
> +                       bytes_added =
> +                               add_bootconfig_parameters(androidboot_params,
> +                                                         androidboot_params_len,
> +                                                         bootconfig_ptr,
> +                                                         img_data.bootconfig_size);
> +               }
> +       }
> +
> +       free(androidboot_params);
> +       free(new_bootargs);
> +
> +       unmap_sysmem(boot_ramdisk_src);
> +       unmap_sysmem(vendor_ramdisk_src);
> +       unmap_sysmem(ramdisk_dest);
> +       return bytes_added;
> +}
> +
>  int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>                               ulong *rd_data, ulong *rd_len)
>  {
> @@ -534,17 +640,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>                         ramdisk_ptr = img_data.ramdisk_addr;
>                 }
>                 *rd_data = ramdisk_ptr;
> -               memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
> -                      img_data.vendor_ramdisk_size);
> -               ramdisk_ptr += img_data.vendor_ramdisk_size;
> -               memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
> -                      img_data.boot_ramdisk_size);
> -               ramdisk_ptr += img_data.boot_ramdisk_size;
> -               if (img_data.bootconfig_size) {
> -                       memcpy((void *)
> -                              (ramdisk_ptr), (void *)img_data.bootconfig_addr,
> -                              img_data.bootconfig_size);
> -               }
> +               if (img_data.header_version > 3)
> +                       img_data.ramdisk_size +=
> +                               android_image_set_bootconfig(hdr, vendor_boot_img, ramdisk_ptr);
>         } else {
>                 /* Ramdisk can be used in-place, use current ptr */
>                 if (img_data.ramdisk_addr == 0 ||
>
> --
> 2.34.1
>

Regards,
Simon
