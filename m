Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFBCEB596B
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 06:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B380F83A47;
	Wed, 11 Feb 2026 07:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xWPemapw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4918383A5A; Wed, 11 Feb 2026 07:40:38 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B4882BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-794f701a3e6so60341877b3.2
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 22:40:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770792034; cv=none;
 d=google.com; s=arc-20240605;
 b=iWsJgD4IEjC3ESDO1pVfzglNg4cUCJ2eWSwigjBSA4isOMG3QoDKFGDnl+ygv9wBAi
 LBuUhmbWayIEj+A2VRun9a6rSqqBbnZc57nCGXhvWEVaOxbycuBtSVm4t9YIJKGKOVd2
 VDvhQY0iwT+VbR2/S5qp+H0nQfiw3REzcXToRhJ3le+XqHd7mpjfgWVfbxD8f5er6UT5
 8YTvMVAb4ofHlCmW6Wjflgk5yRvwVu4w/VBSzPnBmbINqy/8Ssy4WlmYZYXsqD9rEsao
 EF5r8LJvu+8Uw8x8lOJHzphLluwgJaWSZdX5UFDD5x1h3+P0nom7RWTeVSuM+3Z+jgRh
 xZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zqL5qkBX+psut3OnsI7dxDfOoImMykbAXnqjv3EIbYI=;
 fh=Bi45BNOIaTlC2fxBbuvVx15YbEA4BS6w/USvLa70Wic=;
 b=gfVzXwFfUFy65stD3QN93YXE8Ytl0GHKDF4G7w7NcNMQ49C9KCMjafZ3dmsByREy5/
 Ont0Mj164wTuq21nKwn5PcbZ+RiB537WE2x9OBEXzv7xeEiudTPorZr9Z676eMNCTQQM
 peU6v/pATF/4EazLwkbK3TQQqVC93O2yc42AkyXijr78+c+OFssCH1rAgPcks8WbEN1T
 ToZBtvsJG5KY+0RwYAUJ4IMP7U7+TsITPvQsNdZP7RuaNfX4TZKKvVdDYESW8La3kOSS
 +ep4QtLpvw08qGVx4smGnKqilfBnctUztxtpO1abDj92U2092ZsJAN478fayizY6Pr/0
 TM0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770792034; x=1771396834; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zqL5qkBX+psut3OnsI7dxDfOoImMykbAXnqjv3EIbYI=;
 b=xWPemapwGKiRRcasRK+8OYeiIbuvbjj8Nb6vQqU0OAjYgvMV6MZdM5guiX58jXDzmQ
 p1oJR692WcsNkvhtf2LTcyjSPVnE/wbdwBUQGV5S9qbsiADlvXiQ/KQ8pfAzFlUkC0e0
 pkukJh5fYjDnmJYDvIfOl9UiFJplDpC53PAyle/nHQRdA6canJhETRPKS1IoLINRn+gN
 q8v+tJ+/wQ3w73Ea1TbV+tDAWF8/VAI2t0cLbe2vOJo9LRput8ddoNKW77uWJwHQ1vEF
 w0WBUFI7eAAb0t6CSKtfmKVvouJtsRlSUWcgCg/DB9n/ixCo1MVK3BW7nbkPHdbTXK+s
 RItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770792034; x=1771396834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqL5qkBX+psut3OnsI7dxDfOoImMykbAXnqjv3EIbYI=;
 b=lSjYt34aYxjseD4NOk7/PHZhhf4zrhqByB7DpDuGMCLlasF3EcE4OMnAdWTEr1AAsU
 x357/aX/nqeXcSOx8G5LJ7iHgzxoyvW2q7dnhtuDBhaaRCcn8dOKyrlnipugquCvPUcu
 MyNJVXR7uizBBYuAOLOcbl/OMjGBILJsQO/H4uUaRG9aBKY94CQW3bacwf8yr5QNXxjf
 QpJhnrSG52D5UDPYP29n6/Mtv58NNCTLfFWtPgWiPww2cLJ4fx1WOdAqycthdTeL90Ut
 bLwSA85fA36+LkoDCWBzo2hHIVxuxQtH5ikXzIERXqKJRcbdPyZHvVhCzHhLWuzi+jxC
 v4Eg==
X-Gm-Message-State: AOJu0YxZssiGAT8Gt1uabnw587v7sRQbzkrQ+6p3eBnM8JGxEJt9IntS
 EefqDkeJiyhLsgV4qnZX5xIRugpIRWanHoZcJhOcsUM/m/Zt/MUZ9yX/BZ2u2VGHE+SoUN2ockh
 gQDq2emuVtdJcrTBe+xbJYYx/xlSkfOzJvt1EUa5ekw==
X-Gm-Gg: AZuq6aJEQpLiyobxpnT7DPs+9MF0WVvO52Jh2FwFBsEcdOZfvym8nb/DUbvOk9SU64j
 z9G5CIq0n7eiW+ezWhVobd8kcad28HPyKp9NYYv5Rr9IIZUL6f6ny5eTqMG+6Cxa38UTWNDy0VS
 yaYMS3yNtTdm1YJVdP2NaL4edZqxA1+26vTN/D4lEce1y1M/Wcf+yX6D8YUtWGEcrkDR3QXCwgR
 5U8s5819hgvI+UhD/ia7u/2c3LOxlUEyOhF/zsJtrBbEdcjeQHIB8XCu4bbpP35/+V3Hvyrx6EN
 Ekr7xr/6aBUiQl/IZQKshcwrheb2MfQksdIZaKiUhe5sD+PGMWfz7Mk/rd8hl08ksygQMYh/aUg
 5drXdWid6ctNyPPtKpjZxsSwFffOrVbAhLV0qVrnbmv4mP/GflrF7vdOXv/FzchlDqpJaavyRrx
 SNVjVpbrf7qFY7ygdi0TUtQp5k+95lB21A3nNrHzI8H34S2Y/OtacYXS5HyoCRdG5hYa7+CaQez
 btpL+2OrrlrCHflZ81n02YRgtkiEP9AhEhrlO8DJLX1WSBdJQBNijBactLQbt8d6QdlaeoVf2Ah
 C8FBF94v9HVGwLrLaDcJROv8ez7COm0NVhQzEhAOtbjV
X-Received: by 2002:a05:690c:6d04:b0:796:34f7:8e51 with SMTP id
 00721157ae682-7966bdaf7c4mr7498367b3.20.1770792034168; Tue, 10 Feb 2026
 22:40:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770119483.git.michal.simek@amd.com>
 <eb7bfafc0b4a44375833b935bafa4df2550e9c3e.1770119483.git.michal.simek@amd.com>
In-Reply-To: <eb7bfafc0b4a44375833b935bafa4df2550e9c3e.1770119483.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 08:39:57 +0200
X-Gm-Features: AZwV_QiF_mPpkdKShyw_-BnXuqAgR6gcnjHhgLqG47mTLbDCM09f_yYoqn3Ieu8
Message-ID: <CAC_iWjKtexQULYwA8LUzwB1-06qkAHo1LVgRq4=He5Sse34Rnw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Tue, 3 Feb 2026 at 13:52, Michal Simek <michal.simek@amd.com> wrote:
>
> From: Shantur Rathore <i@shantur.com>
>
> Currently U-Boot uses ESP as storage for EFI variables.
> Devices with SPI Flash are used for storing environment with this
> commit we allow EFI variables to be stored on SPI Flash.
>
> https://github.com/rhboot/efivar
> is not updated to support this location that's why you can mimic it by
> running:
> dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
>    of=/tmp/vars skip=4 bs=1
> flashcp /tmp/vars /dev/mtdX
>
> where mtdX should match location defined by
> CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Changes in v7:
> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>
> Changes in v6:
> - sed -i 's/efi_var_read/efi_var_from/g'
> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>
> Changes in v4:
> - Extend Kconfig description
> - Extend commit message and describe efivar missing part
> - use unify methods for reading/writing variable
>
> Changes in v3:
> - Fixed compiler warnings.
>
> Changes in v2:
> - Refactored efi_var_file to move common parts out as requested
> - Changed ifdefs to use CONFIG_IS_DEFINED
> - Fixed typos
>
>  lib/efi_loader/Kconfig      | 34 +++++++++++++-
>  lib/efi_loader/Makefile     |  1 +
>  lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 126 insertions(+), 1 deletion(-)
>  create mode 100644 lib/efi_loader/efi_var_sf.c
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13e44be1d067..bb40cc899a13 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -123,6 +123,24 @@ config EFI_VARIABLE_FILE_STORE
>           Select this option if you want non-volatile UEFI variables to be
>           stored as file /ubootefi.var on the EFI system partition.
>
> +config EFI_VARIABLE_SF_STORE
> +       bool "Store non-volatile UEFI variables in SPI Flash"
> +       depends on SPI_FLASH
> +       help
> +         Select this option if you want non-volatile UEFI variables to be
> +         stored in SPI Flash.
> +
> +         Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
> +         the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
> +         needed.
> +
> +         Note that SPI Flash devices have a limited number of program/erase
> +         cycles. Frequent updates to UEFI variables may cause excessive wear
> +         and can permanently damage the flash device, particularly on SPI NAND
> +         or low-end SPI NOR parts without wear leveling. This option should be
> +         used with care on such systems, and is not recommended for platforms
> +         where UEFI variables are updated frequently.
> +
>  config EFI_MM_COMM_TEE
>         bool "UEFI variables storage service via the trusted world"
>         depends on OPTEE
> @@ -152,7 +170,7 @@ endchoice
>
>  config EFI_RT_VOLATILE_STORE
>         bool "Allow variable runtime services in volatile storage (e.g RAM)"
> -       depends on EFI_VARIABLE_FILE_STORE
> +       depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
>         help
>           When EFI variables are stored on file we don't allow SetVariableRT,
>           since the OS doesn't know how to write that file. At the same time
> @@ -193,6 +211,20 @@ config FFA_SHARED_MM_BUF_ADDR
>           the MM SP in secure world.
>           It is assumed that the MM SP knows the address of the shared MM communication buffer.
>
> +config EFI_VARIABLE_SF_OFFSET
> +       hex "EFI variables in SPI flash offset"
> +       depends on EFI_VARIABLE_SF_STORE
> +       help
> +         Offset from the start of the SPI Flash where EFI variables will be stored.
> +         This should be aligned to the sector size of SPI Flash.
> +
> +config EFI_VARIABLE_SF_DEVICE_INDEX
> +       int "Device Index for target SPI Flash"
> +       default 0
> +       help
> +         The index of SPI Flash device used for storing EFI variables. This would be
> +         needed if there are more than 1 SPI Flash devices available to use.
> +
>  config EFI_VARIABLES_PRESEED
>         bool "Initial values for UEFI variables"
>         depends on !COMPILE_TEST
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index ca1775eb03be..d73ad43951b1 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -54,6 +54,7 @@ obj-y += efi_variable_tee.o
>  else
>  obj-y += efi_variable.o
>  obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
> +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
>  obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
>  endif
>  obj-y += efi_watchdog.o
> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
> new file mode 100644
> index 000000000000..61d68f7c5c94
> --- /dev/null
> +++ b/lib/efi_loader/efi_var_sf.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SPI Flash interface for UEFI variables
> + *
> + * Copyright (c) 2023, Shantur Rathore
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#define LOG_CATEGORY LOGC_EFI
> +
> +#include <efi_loader.h>
> +#include <efi_variable.h>
> +#include <spi_flash.h>
> +#include <dm.h>
> +
> +efi_status_t efi_var_to_storage(void)
> +{
> +       efi_status_t ret;
> +       struct efi_var_file *buf;
> +       loff_t len;
> +       struct udevice *sfdev;
> +
> +       ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> +       if (len > EFI_VAR_BUF_SIZE) {
> +               log_err("EFI var buffer length more than target SPI Flash size");
> +               ret = EFI_OUT_OF_RESOURCES;
> +               goto error;
> +       }
> +
> +       log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);
> +
> +       if (ret != EFI_SUCCESS)
> +               goto error;
> +
> +       ret = uclass_get_device(UCLASS_SPI_FLASH, CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
> +       if (ret)
> +               goto error;
> +
> +       ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
> +       log_debug("%s - Erased SPI Flash offset %x\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
> +       if (ret)
> +               goto error;
> +
> +       ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
> +       log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> +
> +       if (ret)
> +               goto error;
> +
> +       ret = EFI_SUCCESS;
> +error:
> +       if (ret)
> +               log_err("Failed to persist EFI variables in SF\n");
> +       free(buf);
> +       return ret;
> +}
> +
> +efi_status_t efi_var_from_storage(void)
> +{
> +       struct efi_var_file *buf;
> +       efi_status_t ret;
> +       struct udevice *sfdev;
> +
> +       buf = calloc(1, EFI_VAR_BUF_SIZE);
> +       if (!buf) {
> +               log_err("%s - Unable to allocate buffer\n", __func__);
> +               return EFI_OUT_OF_RESOURCES;
> +       }
> +
> +       ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
> +       if (ret)
> +               goto error;
> +
> +       ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
> +                               EFI_VAR_BUF_SIZE, buf);
> +
> +       log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
> +
> +       if (ret || buf->length < sizeof(struct efi_var_file)) {
> +               log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
> +               goto error;
> +       }
> +
> +       ret = efi_var_restore(buf, false);
> +       if (ret != EFI_SUCCESS)
> +               log_err("%s - Unable to restore EFI variables from buffer\n", __func__);
> +
> +       ret = EFI_SUCCESS;
> +error:
> +       free(buf);
> +       return ret;
> +}
> --
> 2.43.0
>
