Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB98C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 07:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4454829E7;
	Wed, 30 Apr 2025 09:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KM93vhQ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556A782AFD; Wed, 30 Apr 2025 09:45:43 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1018216C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6ecfbf8fa76so96313376d6.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745999139; x=1746603939; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FtvrDwPFmKeV7UMufqh7empWoMeX1pmXpdDeROmEjUo=;
 b=KM93vhQ1iIZF7MENqXqPnHJ40b3+h0X1ZQjJpOsvKLJficNgY2gBRXFd4FJzfmNbsf
 i9Ay0vepF5DMSDUPPMJnIJxcGTAmrT494ht4RxgGVmg3M4LDZ4wseWeThURE0gDtqHlh
 dCZenei+vpol8kW6OySna5QVdI9D4lYDiQzOweHN4gLamtW3jfuM46VYNsKjyI2XO3pH
 LMlcPg7xHINBxkVNfOZHqt0suBQOZcZf7d2TwkqG2vC10FqNvadKyrwx0TgpkZ5A7hM9
 y/mRNVh8B6/INpte4G8zgf8wSGwtlSS9q++/CTDTILaNIengTvk4i2P488lKAKKByTwi
 Goaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745999139; x=1746603939;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FtvrDwPFmKeV7UMufqh7empWoMeX1pmXpdDeROmEjUo=;
 b=qW491Xkiqp83xRVS8GiYUbqXXDwt2eobD3NvZXJZDbmH0YtoRhEpFqEUIb51O9COph
 037aV0UsiRWPlyrtgA/LOMBkN5/0ZkNqX1ALZbUiGWpL7hbVTEvSCB8o0lOq4L1rLWOQ
 vTqOJQseyMYze0ine6nu6zr7Rca4Q6xYLcbONux153ENd91gOSKl7v9388Dszlaf2xEa
 M1wuad3OBBP4l69u67McA+KSWnbdBCu3+nFsZEEoleL99LjEmJTLZyPOaDZv0dhOyYev
 pHR8LX6YuZVyZCMZkpiT8ihM6EEC4zrlAfnCxCWC2Qlvr2vogwTr0ijF51kh802DRp2K
 K6rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr14YpWgRxM8FcA/sqal0AFv0zRUkLnOJutdUmRBGN6WyEDfH7dymaEQ+JX97cnF/rLzWRNgA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1bLelJhLfjBMNCgTuofubN5ZFARYppMZAvIrGZzf8SrGjbGKO
 lNqBU444bwzJrOjULav3PqEDf1Oo7AYnSg3oltPkct+Bt4ZRpAc9W06RGrnqhuoNqwjMlBbK/Y9
 XdcS61m3F8JVGDVNJ4jufS7ttL0EL4w==
X-Gm-Gg: ASbGncuscF8SvmmcahyhIBavhLvLImbKQxzGrL2CbDPsxNlTmHMLpxVvOU+QN2r/xP/
 rXhsCf++ka4CKRGMREGzlriwOP4hy8sBiVGG6cA0KH/Tgt60t38e+tR116pBrfhUs2DHNk3eXTx
 XA69CbhONTtwzTJpZTnhQCwFL3bk7zUAvP
X-Google-Smtp-Source: AGHT+IFpPFy1llRtt8kFyaE8sPDh1esJqML5L0nmjLrnP9VSoGvePgeF6oGFH506w0y1XdZjZTQQb/QlXxNB611w418=
X-Received: by 2002:a05:6214:258c:b0:6e8:9394:cbbe with SMTP id
 6a1803df08f44-6f4fe08108dmr27280926d6.20.1745999139566; Wed, 30 Apr 2025
 00:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250407185958.15479-1-ansuelsmth@gmail.com>
In-Reply-To: <20250407185958.15479-1-ansuelsmth@gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Wed, 30 Apr 2025 09:45:27 +0200
X-Gm-Features: ATxdqUF6D_s4HHBeEoFhpvRopU9MLQUx-VlNdVZdYN_8sY3lzLPCYW1ZDEEoXpk
Message-ID: <CA+_ehUzdKZ=gcOFi4o+-06ZFxd=yXMZGoCs5N0U1C6L8RBOSAw@mail.gmail.com>
Subject: Re: [PATCH] env: Introduce support for MTD
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de
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

Il giorno lun 7 apr 2025 alle ore 21:00 Christian Marangi
<ansuelsmth@gmail.com> ha scritto:
>
> Introduce support for env in generic MTD. Currently we only support SPI
> flash based on the lagacy sf cmd that assume SPI flash are always NOR.
> This is not the case as to SPI controller also NAND can be attached.
>
> To support also these flash scenario, add support for storing and
> reading ENV from generic MTD device by adding an env driver that
> base entirely on the MTD api.
>
> Introduce a new kconfig CONFIG_ENV_IS_IN_MTD and
> CONFIG_ENV_MTD_DEV to define the name of the MTD device as exposed
> by mtd list.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  env/Kconfig            |  33 +++-
>  env/Makefile           |   1 +
>  env/env.c              |   3 +
>  env/mtd.c              | 338 +++++++++++++++++++++++++++++++++++++++++
>  include/env_internal.h |   1 +
>  5 files changed, 372 insertions(+), 4 deletions(-)
>  create mode 100644 env/mtd.c
>
> diff --git a/env/Kconfig b/env/Kconfig
> index 4438f0b392c..74678c43334 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -74,7 +74,7 @@ config ENV_IS_DEFAULT
>                      !ENV_IS_IN_MMC && !ENV_IS_IN_NAND && \
>                      !ENV_IS_IN_NVRAM && !ENV_IS_IN_ONENAND && \
>                      !ENV_IS_IN_REMOTE && !ENV_IS_IN_SPI_FLASH && \
> -                    !ENV_IS_IN_UBI
> +                    !ENV_IS_IN_UBI && !ENV_IS_IN_MTD
>         select ENV_IS_NOWHERE
>
>  config ENV_IS_NOWHERE
> @@ -387,6 +387,25 @@ config ENV_IS_IN_SPI_FLASH
>           during a "saveenv" operation. CONFIG_ENV_OFFSET_REDUND must be
>           aligned to an erase sector boundary.
>
> +config ENV_IS_IN_MTD
> +       bool "Environment is in MTD flash"
> +       depends on !CHAIN_OF_TRUST && (SPI_FLASH || DM_SPI_FLASH)
> +       default y if ARCH_AIROHA
> +       help
> +         Define this if you have a MTD Flash memory device which you
> +         want to use for the environment.
> +
> +         - CONFIG_ENV_MTD_DEV:
> +
> +         Specifies which SPI NAND device the environment is stored in.
> +
> +         - CONFIG_ENV_OFFSET:
> +         - CONFIG_ENV_SIZE:
> +
> +         These two #defines specify the offset and size of the
> +         environment area within the MTD Flash.
> +         CONFIG_ENV_OFFSET must be aligned to an erase sector boundary.
> +
>  config ENV_SECT_SIZE_AUTO
>         bool "Use automatically detected sector size"
>         depends on ENV_IS_IN_SPI_FLASH
> @@ -562,8 +581,8 @@ config ENV_EXT4_FILE
>  config ENV_ADDR
>         hex "Environment address"
>         depends on ENV_IS_IN_FLASH || ENV_IS_IN_NVRAM || ENV_IS_IN_ONENAND || \
> -                    ENV_IS_IN_REMOTE || ENV_IS_IN_SPI_FLASH
> -       default 0x0 if ENV_IS_IN_SPI_FLASH
> +                    ENV_IS_IN_REMOTE || ENV_IS_IN_SPI_FLASH || ENV_IS_IN_MTD
> +       default 0x0 if ENV_IS_IN_SPI_FLASH || ENV_IS_IN_MTD
>         help
>           Offset from the start of the device (or partition)
>
> @@ -577,7 +596,7 @@ config ENV_ADDR_REDUND
>  config ENV_OFFSET
>         hex "Environment offset"
>         depends on ENV_IS_IN_EEPROM || ENV_IS_IN_MMC || ENV_IS_IN_NAND || \
> -                   ENV_IS_IN_SPI_FLASH
> +                   ENV_IS_IN_SPI_FLASH || ENV_IS_IN_MTD
>         default 0x3f8000 if ARCH_ROCKCHIP && ENV_IS_IN_MMC
>         default 0x140000 if ARCH_ROCKCHIP && ENV_IS_IN_SPI_FLASH
>         default 0xF0000 if ARCH_SUNXI
> @@ -666,6 +685,12 @@ config SYS_RELOC_GD_ENV_ADDR
>           Relocate the early env_addr pointer so we know it is not inside
>           the binary. Some systems need this and for the rest, it doesn't hurt.
>
> +config ENV_MTD_DEV
> +       string "mtd device name"
> +       depends on ENV_IS_IN_MTD
> +       help
> +         MTD device name on the platform where the environment is stored.
> +
>  config SYS_MMC_ENV_DEV
>         int "mmc device number"
>         depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT || ENV_IS_IN_EXT4 || \
> diff --git a/env/Makefile b/env/Makefile
> index a54e924d419..3b9c71d5681 100644
> --- a/env/Makefile
> +++ b/env/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FAT) += fat.o
>  obj-$(CONFIG_$(PHASE_)ENV_IS_IN_EXT4) += ext4.o
>  obj-$(CONFIG_$(PHASE_)ENV_IS_IN_NAND) += nand.o
>  obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SPI_FLASH) += sf.o
> +obj-$(CONFIG_$(PHASE_)ENV_IS_IN_MTD) += mtd.o
>  obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FLASH) += flash.o
>
>  CFLAGS_embedded.o := -Wa,--no-warn -DENV_CRC=$(shell tools/envcrc 2>/dev/null)
> diff --git a/env/env.c b/env/env.c
> index bcc189e14db..dbaeedc3c3b 100644
> --- a/env/env.c
> +++ b/env/env.c
> @@ -58,6 +58,9 @@ static enum env_location env_locations[] = {
>  #ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>         ENVL_SPI_FLASH,
>  #endif
> +#ifdef CONFIG_ENV_IS_IN_MTD
> +       ENVL_MTD,
> +#endif
>  #ifdef CONFIG_ENV_IS_IN_UBI
>         ENVL_UBI,
>  #endif
> diff --git a/env/mtd.c b/env/mtd.c
> new file mode 100644
> index 00000000000..721faebd8f2
> --- /dev/null
> +++ b/env/mtd.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Author: Christian Marangi <ansuelsmth@gmail.com>
> + */
> +#include <env_internal.h>
> +#include <errno.h>
> +#include <malloc.h>
> +#include <mtd.h>
> +#include <asm/cache.h>
> +#include <asm/global_data.h>
> +#include <linux/mtd/mtd.h>
> +#include <u-boot/crc.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static int setup_mtd_device(struct mtd_info **mtd_env)
> +{
> +       struct mtd_info *mtd;
> +
> +       mtd_probe_devices();
> +
> +       mtd = get_mtd_device_nm(CONFIG_ENV_MTD_DEV);
> +       if (IS_ERR_OR_NULL(mtd)) {
> +               env_set_default("get_mtd_device_nm() failed", 0);
> +               return mtd ? PTR_ERR(mtd) : -EINVAL;
> +       }
> +
> +       *mtd_env = mtd;
> +
> +       return 0;
> +}
> +
> +static int env_mtd_save(void)
> +{
> +       char *saved_buf, *write_buf, *tmp;
> +       struct erase_info ei = { };
> +       struct mtd_info *mtd_env;
> +       u32 sect_size, sect_num;
> +       size_t ret_len = 0;
> +       u32 write_size;
> +       env_t env_new;
> +       int remaining;
> +       u32 offset;
> +       int ret;
> +
> +       ret = setup_mtd_device(&mtd_env);
> +       if (ret)
> +               return ret;
> +
> +       sect_size = mtd_env->erasesize;
> +
> +       /* Is the sector larger than the env (i.e. embedded) */
> +       if (sect_size > CONFIG_ENV_SIZE) {
> +               saved_buf = malloc(sect_size);
> +               if (!saved_buf) {
> +                       ret = -ENOMEM;
> +                       goto done;
> +               }
> +
> +               offset = CONFIG_ENV_OFFSET;
> +               remaining = sect_size;
> +               tmp = saved_buf;
> +
> +               while (remaining) {
> +                       /* Skip the block if it is bad */
> +                       if (!(offset % sect_size) &&
> +                           mtd_block_isbad(mtd_env, offset)) {
> +                               offset += sect_size;
> +                               continue;
> +                       }
> +
> +                       ret = mtd_read(mtd_env, offset, mtd_env->writesize,
> +                                      &ret_len, tmp);
> +                       if (ret)
> +                               goto done;
> +
> +                       tmp += ret_len;
> +                       offset += ret_len;
> +                       remaining -= ret_len;
> +               }
> +       }
> +
> +       ret = env_export(&env_new);
> +       if (ret)
> +               goto done;
> +
> +       sect_num = DIV_ROUND_UP(CONFIG_ENV_SIZE, sect_size);
> +
> +       ei.mtd = mtd_env;
> +       ei.addr = CONFIG_ENV_OFFSET;
> +       ei.len = sect_num * sect_size;
> +
> +       puts("Erasing MTD...");
> +       ret = mtd_erase(mtd_env, &ei);
> +       if (ret)
> +               goto done;
> +
> +       if (sect_size > CONFIG_ENV_SIZE) {
> +               memcpy(saved_buf, &env_new, CONFIG_ENV_SIZE);
> +               write_size = sect_size;
> +               write_buf = saved_buf;
> +       } else {
> +               write_size = sect_num * sect_size;
> +               write_buf = (char *)&env_new;
> +       }
> +
> +       offset = CONFIG_ENV_OFFSET;
> +       remaining = sect_size;
> +       tmp = write_buf;
> +
> +       puts("Writing to MTD...");
> +       while (remaining) {
> +               /* Skip the block if it is bad */
> +               if (!(offset % sect_size) &&
> +                   mtd_block_isbad(mtd_env, offset)) {
> +                       offset += sect_size;
> +                       continue;
> +               }
> +
> +               ret = mtd_write(mtd_env, offset, mtd_env->writesize,
> +                               &ret_len, tmp);
> +               if (ret)
> +                       goto done;
> +
> +               offset += mtd_env->writesize;
> +               remaining -= ret_len;
> +               tmp += ret_len;
> +       }
> +
> +       ret = 0;
> +       puts("done\n");
> +
> +done:
> +       if (saved_buf)
> +               free(saved_buf);
> +
> +       return ret;
> +}
> +
> +static int env_mtd_load(void)
> +{
> +       struct mtd_info *mtd_env;
> +       char *buf, *tmp;
> +       size_t ret_len;
> +       int remaining;
> +       u32 sect_size;
> +       u32 offset;
> +       int ret;
> +
> +       buf = (char *)memalign(ARCH_DMA_MINALIGN, CONFIG_ENV_SIZE);
> +       if (!buf) {
> +               env_set_default("memalign() failed", 0);
> +               return -EIO;
> +       }
> +
> +       ret = setup_mtd_device(&mtd_env);
> +       if (ret)
> +               goto out;
> +
> +       sect_size = mtd_env->erasesize;
> +
> +       offset = CONFIG_ENV_OFFSET;
> +       remaining = CONFIG_ENV_SIZE;
> +       tmp = buf;
> +
> +       while (remaining) {
> +               /* Skip the block if it is bad */
> +               if (!(offset % sect_size) &&
> +                   mtd_block_isbad(mtd_env, offset)) {
> +                       offset += sect_size;
> +                       continue;
> +               }
> +
> +               ret = mtd_read(mtd_env, offset, mtd_env->writesize,
> +                              &ret_len, tmp);
> +               if (ret) {
> +                       env_set_default("mtd_read() failed", 1);
> +                       goto out;
> +               }
> +
> +               tmp += ret_len;
> +               offset += ret_len;
> +               remaining -= ret_len;
> +       }
> +
> +       ret = env_import(buf, 1, H_EXTERNAL);
> +       if (!ret)
> +               gd->env_valid = ENV_VALID;
> +
> +out:
> +       free(buf);
> +
> +       return ret;
> +}
> +
> +static int env_mtd_erase(void)
> +{
> +       struct mtd_info *mtd_env;
> +       u32 sect_size, sect_num;
> +       char *saved_buf, *tmp;
> +       struct erase_info ei;
> +       size_t ret_len;
> +       int remaining;
> +       u32 offset;
> +       int ret;
> +
> +       ret = setup_mtd_device(&mtd_env);
> +       if (ret)
> +               return ret;
> +
> +       sect_size = mtd_env->erasesize;
> +
> +       /* Is the sector larger than the env (i.e. embedded) */
> +       if (sect_size > CONFIG_ENV_SIZE) {
> +               saved_buf = malloc(sect_size);
> +               if (!saved_buf) {
> +                       ret = -ENOMEM;
> +                       goto done;
> +               }
> +
> +               offset = CONFIG_ENV_OFFSET;
> +               remaining = sect_size;
> +               tmp = saved_buf;
> +
> +               while (remaining) {
> +                       /* Skip the block if it is bad */
> +                       if (!(offset % sect_size) &&
> +                           mtd_block_isbad(mtd_env, offset)) {
> +                               offset += sect_size;
> +                               continue;
> +                       }
> +
> +                       ret = mtd_read(mtd_env, offset, mtd_env->writesize,
> +                                      &ret_len, tmp);
> +                       if (ret)
> +                               goto done;
> +
> +                       tmp += ret_len;
> +                       offset += ret_len;
> +                       remaining -= ret_len;
> +               }
> +       }
> +
> +       sect_num = DIV_ROUND_UP(CONFIG_ENV_SIZE, sect_size);
> +
> +       ei.mtd = mtd_env;
> +       ei.addr = CONFIG_ENV_OFFSET;
> +       ei.len = sect_num * sect_size;
> +
> +       ret = mtd_erase(mtd_env, &ei);
> +       if (ret)
> +               goto done;
> +
> +       if (sect_size > CONFIG_ENV_SIZE) {
> +               memset(saved_buf, 0, CONFIG_ENV_SIZE);
> +
> +               offset = CONFIG_ENV_OFFSET;
> +               remaining = sect_size;
> +               tmp = saved_buf;
> +
> +               while (remaining) {
> +                       /* Skip the block if it is bad */
> +                       if (!(offset % sect_size) &&
> +                           mtd_block_isbad(mtd_env, offset)) {
> +                               offset += sect_size;
> +                               continue;
> +                       }
> +
> +                       ret = mtd_write(mtd_env, offset, mtd_env->writesize,
> +                                       &ret_len, tmp);
> +                       if (ret)
> +                               goto done;
> +
> +                       offset += mtd_env->writesize;
> +                       remaining -= ret_len;
> +                       tmp += ret_len;
> +               }
> +       }
> +
> +       ret = 0;
> +
> +done:
> +       if (saved_buf)
> +               free(saved_buf);
> +
> +       return ret;
> +}
> +
> +__weak void *env_mtd_get_env_addr(void)
> +{
> +       return (void *)CONFIG_ENV_ADDR;
> +}
> +
> +/*
> + * Check if Environment on CONFIG_ENV_ADDR is valid.
> + */
> +static int env_mtd_init_addr(void)
> +{
> +       env_t *env_ptr = (env_t *)env_mtd_get_env_addr();
> +
> +       if (!env_ptr)
> +               return -ENOENT;
> +
> +       if (crc32(0, env_ptr->data, ENV_SIZE) == env_ptr->crc) {
> +               gd->env_addr = (ulong)&env_ptr->data;
> +               gd->env_valid = ENV_VALID;
> +       } else {
> +               gd->env_valid = ENV_INVALID;
> +       }
> +
> +       return 0;
> +}
> +
> +static int env_mtd_init(void)
> +{
> +       int ret;
> +
> +       ret = env_mtd_init_addr();
> +       if (ret != -ENOENT)
> +               return ret;
> +
> +       /*
> +        * return here -ENOENT, so env_init()
> +        * can set the init bit and later if no
> +        * other Environment storage is defined
> +        * can set the default environment
> +        */
> +       return -ENOENT;
> +}
> +
> +U_BOOT_ENV_LOCATION(mtd) = {
> +       .location       = ENVL_MTD,
> +       ENV_NAME("MTD")
> +       .load           = env_mtd_load,
> +       .save           = ENV_SAVE_PTR(env_mtd_save),
> +       .erase          = ENV_ERASE_PTR(env_mtd_erase),
> +       .init           = env_mtd_init,
> +};
> diff --git a/include/env_internal.h b/include/env_internal.h
> index c1c0727e4d0..ee939ba4293 100644
> --- a/include/env_internal.h
> +++ b/include/env_internal.h
> @@ -113,6 +113,7 @@ enum env_location {
>         ENVL_ONENAND,
>         ENVL_REMOTE,
>         ENVL_SPI_FLASH,
> +       ENVL_MTD,
>         ENVL_UBI,
>         ENVL_NOWHERE,
>
> --
> 2.48.1
>

Any news for this?
