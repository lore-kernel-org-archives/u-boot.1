Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E56DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D6E87735;
	Wed,  8 Nov 2023 05:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aTy4TJqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1F287718; Wed,  8 Nov 2023 05:26:55 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27C887742
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5af5b532d8fso75016937b3.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iV/Oo9Ij/KoyDGUfju0nMzyDTncooDEoNDzh3qFy1Yg=;
 b=aTy4TJqMI1943EPwWT/JuEt8IGdV+XjSDy9ihBf7bzTQkPjij2wXiXqSsoTLMUxe8P
 rDeHTnrt7jlDhelcNWQKXHl+PeOgXRElddmhV0rsz48qt6U+EO9QQo4aYyACdzTuFvby
 wUPeQfc3CV2dX6R9WMewjTpLuwFnU3o/B3POM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iV/Oo9Ij/KoyDGUfju0nMzyDTncooDEoNDzh3qFy1Yg=;
 b=Bd60ah+E+lrG/2Mzz+OlqOYDwWGwVKqmdSfm5v000Z98t68l9QBUXjEEfSS6y/hm73
 iOUsMwnRlAD/WM0gqTZazjXXqYpfcJxSQUP1YUmIwrmokDfgsY1NmFsY6LCqyDE5rxPt
 9AuNYxY7+Kk1t5bxakercANC/m8amdvoo1Mizn9WPDZbwcdl5R/lXRTqTOcJjudQjv8a
 AE8YqyTK/iob36CRl44ogHfejsjvD9nOn+e4ck5Dc2p0BzqosGeY/9+g35Geh5X5vlZU
 /Nr9FsgQ3mxt3yAgUnCPssn3HEB/rXUjWfSqB5Xsi9kiCVXOMnfkjN3pAmrzmKE439Jg
 FNCA==
X-Gm-Message-State: AOJu0YxZNs6M6+NA4q19eKPGUgeVLySFFnU4vtzSKoVszBXPWLOdvKvJ
 5c3gREydzdqN1/fdtph9pcSnnmRhRQBw2wUMyif8uA==
X-Google-Smtp-Source: AGHT+IG8kg8cqVXkHUuYKDoUxhPfzMuNkn2RukgYEqpDmtTQGBpZki9P2VUcn7b305lRkl90u5NKSYLG5xnMS4J7GPw=
X-Received: by 2002:a81:5b07:0:b0:5a7:b81a:7f5d with SMTP id
 p7-20020a815b07000000b005a7b81a7f5dmr726630ywb.18.1699417608082; Tue, 07 Nov
 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-16-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-16-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:00 -0700
Message-ID: <CAPnjgZ3z7Y7DgGkgkSb5n1oKTu6SqX1tzngEzBkBV7Xc0w_ovA@mail.gmail.com>
Subject: Re: [PATCH v6 15/25] spl: Convert ext to use spl_load
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

Hi Sean,

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> This converts the ext load method to use spl_load. As a consequence, it
> also adds support for FIT and IMX images.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - Explicitly initialize load_info members
>
> Changes in v5:
> - Rework to load header in spl_load
>
>  common/spl/spl_ext.c     | 36 ++++++++++++++++++------------------
>  include/spl_load.h       |  1 +
>  test/image/spl_load_fs.c |  9 ++++++---
>  3 files changed, 25 insertions(+), 21 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

but nit below

>
> diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
> index af836ca15b8..d280b69c387 100644
> --- a/common/spl/spl_ext.c
> +++ b/common/spl/spl_ext.c
> @@ -2,25 +2,35 @@
>
>  #include <common.h>
>  #include <env.h>
> -#include <mapmem.h>
>  #include <part.h>
>  #include <spl.h>
> +#include <spl_load.h>
>  #include <asm/u-boot.h>
>  #include <ext4fs.h>
>  #include <errno.h>
>  #include <image.h>
>
> +static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
> +                         ulong size, void *buf)
> +{
> +       int ret;
> +       loff_t actlen;
> +
> +       ret = ext4fs_read(buf, file_offset, size, &actlen);
> +       if (ret)
> +               return ret;
> +       return actlen;
> +}
> +
>  int spl_load_image_ext(struct spl_image_info *spl_image,
>                        struct spl_boot_device *bootdev,
>                        struct blk_desc *block_dev, int partition,
>                        const char *filename)
>  {
>         s32 err;
> -       struct legacy_img_hdr *header;
> -       loff_t filelen, actlen;
> +       loff_t filelen;
>         struct disk_partition part_info = {};
> -
> -       header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
> +       struct spl_load_info load;
>
>         if (part_get_info(block_dev, partition, &part_info)) {
>                 printf("spl: no partition table found\n");
> @@ -42,20 +52,10 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
>                 puts("spl: ext4fs_open failed\n");
>                 goto end;
>         }
> -       err = ext4fs_read((char *)header, 0, sizeof(struct legacy_img_hdr), &actlen);
> -       if (err < 0) {
> -               puts("spl: ext4fs_read failed\n");
> -               goto end;
> -       }
>
> -       err = spl_parse_image_header(spl_image, bootdev, header);
> -       if (err < 0) {
> -               puts("spl: ext: failed to parse image header\n");
> -               goto end;
> -       }
> -
> -       err = ext4fs_read(map_sysmem(spl_image->load_addr, filelen), 0, filelen,
> -                         &actlen);
> +       spl_set_bl_len(&load, 1);
> +       load.read = spl_fit_read;
> +       err = spl_load(spl_image, bootdev, &load, filelen, 0);
>
>  end:
>  #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 406f8b577b2..65aa6bb4493 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -95,6 +95,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>   * inline if there is one caller, and extern otherwise.
>   */
>  #define SPL_LOAD_USERS \
> +       IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
>         0
>
>  #if SPL_LOAD_USERS > 1
> diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
> index 59d0244d44b..01559e98c4f 100644
> --- a/test/image/spl_load_fs.c
> +++ b/test/image/spl_load_fs.c
> @@ -422,20 +422,23 @@ static int spl_test_mmc(struct unit_test_state *uts, const char *test_name,
>         spl_mmc_clear_cache();
>         spl_fat_force_reregister();
>
> -       if (type == LEGACY &&
> -           spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
> +       if (spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
>                 return CMD_RET_FAILURE;
>
> -       if (type != IMX8 &&
> +       if (type != IMX8 && type != LEGACY_LZMA &&
>             spl_test_mmc_fs(uts, test_name, type, create_fat, false))
>                 return CMD_RET_FAILURE;

This is not a command.

How about:

if (type != IMX8 && type != LEGACY_LZMA &&
   ut_assertok(spl_test_mmc_fs(...

>
> +       if (type == LEGACY_LZMA)
> +               return 0;
> +
>         return do_spl_test_load(uts, test_name, type,
>                                 SPL_LOAD_IMAGE_GET(0, BOOT_DEVICE_MMC1,
>                                                    spl_mmc_load_image),
>                                 spl_test_mmc_write_image);
>  }
>  SPL_IMG_TEST(spl_test_mmc, LEGACY, DM_FLAGS);
> +SPL_IMG_TEST(spl_test_mmc, LEGACY_LZMA, DM_FLAGS);
>  SPL_IMG_TEST(spl_test_mmc, IMX8, DM_FLAGS);
>  SPL_IMG_TEST(spl_test_mmc, FIT_EXTERNAL, DM_FLAGS);
>  SPL_IMG_TEST(spl_test_mmc, FIT_INTERNAL, DM_FLAGS);
> --
> 2.37.1
>

Regards,
Simon
