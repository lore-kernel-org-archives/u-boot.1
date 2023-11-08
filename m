Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D43C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67518772A;
	Wed,  8 Nov 2023 05:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PsU5e+4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371328772B; Wed,  8 Nov 2023 05:26:55 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65268772A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7b91faf40so76924277b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a0qsNF8lnDbr8f/05LmFjl6930W81xZ6BaKJpvH9sts=;
 b=PsU5e+4jQnns5EKfszgHlSB4UPZe5gbi4FkEwnukLNrBuJ1uhk2AkdwJQY8zfOjdDv
 EBWBapr76kdEOBaBAv40Z6bROm8sGtaDDzFLaOhBWQ+F3UnErZr7mFO5FZb7YxbLpaK+
 wEYk8xlppu+HLkZKMXaiY/aufi5HKFW7T8Ruw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0qsNF8lnDbr8f/05LmFjl6930W81xZ6BaKJpvH9sts=;
 b=DnE4jpLcxAUGqcCuzHaS5xSdPfFdTn8tFhX8uYmHuVmzPM7pqPbTBjDlyeXRrPw5jA
 PYV2Qq1W9jbs3iKhXe+5W9IrHDfUlnRkTE1FOZyx7YFwck8WQT2N3oKwqYi0Shv+6ZDI
 y53usrUXmV5uL57jWnCuGrpgp0Im6GTM7t3ZqpfGQjFZ8aVqDPyT+OTjNZoH9OEkCO47
 Z/MprLwzpEG4pLHj2J/pAbqiomGB2pKRVE4g84My5xrVbl5Ox5MbBSEyi0HBlgxPhcw5
 Gjwfy5qVRlMt0HLXbuNLtAWaoNxLTs4qcbKKvuso425SGQX8T4aXzXRTPkWPC8z9UfR+
 +Y6g==
X-Gm-Message-State: AOJu0YzfupwTES8ONl8IoO/1scSfsPV+7me4faMIiIiUKOvuMt2D3+Sq
 UXzDClRDvsYX2+FgjgUfReia+WkwV4+815lWuz3Nlg==
X-Google-Smtp-Source: AGHT+IFzjFTaX/tY49UNipWO9uM1UfTyR/+cPYoNBybS88TlRpbUpL/ffbdEdqJQLstjwLXEKcaRbvihJLM7TmFOxCQ=
X-Received: by 2002:a05:690c:270d:b0:5be:a164:5671 with SMTP id
 dy13-20020a05690c270d00b005bea1645671mr140859ywb.20.1699417608081; Tue, 07
 Nov 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-17-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-17-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:01 -0700
Message-ID: <CAPnjgZ1m7MW+LcpQNJEaUfXLZ8Xq5843+ZdPyrKDtS-q9ztj=g@mail.gmail.com>
Subject: Re: [PATCH v6 16/25] spl: Convert fat to spl_load
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
> This converts the fat loader to use spl_load. Some platforms are very
> tight on space, so we take care to only include the code we really need.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> (no changes since v5)
>
> Changes in v5:
> - Rework to load header in spl_load
>
> Changes in v3:
> - Fix failing on success
>
>  common/spl/spl_fat.c     | 56 +++++++++++++---------------------------
>  include/spl_load.h       |  1 +
>  test/image/spl_load_fs.c |  3 +--
>  3 files changed, 20 insertions(+), 40 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

>
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index a0c34eba48f..569f2b32928 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -11,8 +11,8 @@
>  #include <common.h>
>  #include <env.h>
>  #include <log.h>
> -#include <mapmem.h>
>  #include <spl.h>
> +#include <spl_load.h>
>  #include <asm/u-boot.h>
>  #include <fat.h>
>  #include <errno.h>
> @@ -66,58 +66,38 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
>                        const char *filename)
>  {
>         int err;
> -       struct legacy_img_hdr *header;
> +       loff_t size;
> +       struct spl_load_info load;
>
>         err = spl_register_fat_device(block_dev, partition);
>         if (err)
>                 goto end;
>
> -       header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
> -
> -       err = file_fat_read(filename, header, sizeof(struct legacy_img_hdr));
> -       if (err <= 0)
> -               goto end;
> -
> -       if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL) &&
> -           image_get_magic(header) == FDT_MAGIC) {
> -               err = file_fat_read(filename,
> -                                   map_sysmem(CONFIG_SYS_LOAD_ADDR, 0), 0);
> -               if (err <= 0)
> -                       goto end;
> -               err = spl_parse_image_header(spl_image, bootdev,
> -                                            map_sysmem(CONFIG_SYS_LOAD_ADDR,
> -                                                       err));
> -               if (err == -EAGAIN)
> -                       return err;
> -               if (err == 0)
> -                       err = 1;
> -       } else if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
> -           image_get_magic(header) == FDT_MAGIC) {
> -               struct spl_load_info load;
> -
> -               debug("Found FIT\n");
> -               load.read = spl_fit_read;
> -               spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
> -               load.priv = (void *)filename;
> -
> -               return spl_load_simple_fit(spl_image, &load, 0, header);
> -       } else {
> -               err = spl_parse_image_header(spl_image, bootdev, header);
> +       /*
> +        * Avoid pulling in this function for other image types since we are
> +        * very short on space on some boards.
> +        */
> +       if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)) {
> +               err = fat_size(filename, &size);
>                 if (err)
>                         goto end;
> -
> -               err = file_fat_read(filename, map_sysmem(spl_image->load_addr,
> -                                                        spl_image->size), 0);
> +       } else {
> +               size = 0;
>         }
>
> +       load.read = spl_fit_read;
> +       spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
> +       load.priv = (void *)filename;
> +       err = spl_load(spl_image, bootdev, &load, size, 0);
> +
>  end:
>  #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
> -       if (err <= 0)
> +       if (err < 0)
>                 printf("%s: error reading image %s, err - %d\n",
>                        __func__, filename, err);

Do we still need this sort of #ifdef? I thought printf() would melt
away without SPL_LIBCOMMON_SUPPORT? I haven't looked though. Also it
isn't related to your patch.

>  #endif
>
> -       return (err <= 0);
> +       return err;
>  }
>
>  #if CONFIG_IS_ENABLED(OS_BOOT)
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 65aa6bb4493..5e0460d956d 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -96,6 +96,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>   */
>  #define SPL_LOAD_USERS \
>         IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
> +       IS_ENABLED(CONFIG_SPL_FS_FAT) + \
>         0
>
>  #if SPL_LOAD_USERS > 1
> diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
> index 01559e98c4f..333df2dfb53 100644
> --- a/test/image/spl_load_fs.c
> +++ b/test/image/spl_load_fs.c
> @@ -425,8 +425,7 @@ static int spl_test_mmc(struct unit_test_state *uts, const char *test_name,
>         if (spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
>                 return CMD_RET_FAILURE;
>
> -       if (type != IMX8 && type != LEGACY_LZMA &&
> -           spl_test_mmc_fs(uts, test_name, type, create_fat, false))
> +       if (spl_test_mmc_fs(uts, test_name, type, create_fat, false))
>                 return CMD_RET_FAILURE;
>
>         if (type == LEGACY_LZMA)
> --
> 2.37.1
>

Regards,
Simon
