Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6C9C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB4A875E9;
	Wed, 22 Nov 2023 14:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HMPYX/hJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 409F2875CA; Wed, 22 Nov 2023 14:46:57 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5870A875E9
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507a62d4788so9607882e87.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700660813; x=1701265613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HTOK++Huo7x75t1mZQqVbzkUn+8cOBQ9Sy/5TDeWsyc=;
 b=HMPYX/hJui+wGsSHQYz1EhzNX1JssZpSQWxAn5BPQOnqYRjgcZKxxWnksa1bhmApxm
 AjQUTpxm49IMGDBg9wFYdF3vbJT3e4D7n4rYJyMCB0IYVQxc5kiop6/LqKJ5hoxEOpHG
 gQNutDI3xUId3rkOBOWI1LvHQkBz0deDw/EYMrpbSiEblTnGPLdM1u+ibYgA3BzI8OBF
 DHP0XKtBlL7cQ9igD8Hi6319eg2U4/lZ/2X4T5XoErVvD5l7JMYvEtZGv8ltkh3Uz5ut
 wtimwIMqjmL7D95Omyyo4JVFqfat1kue1TqmMyAxYd8M+kFZkaYe60aVbQSODwT1nzsu
 Gksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700660813; x=1701265613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HTOK++Huo7x75t1mZQqVbzkUn+8cOBQ9Sy/5TDeWsyc=;
 b=sc7tehEnyqo6hyU61L6xza4nXeQSncQS4utkPxmNO/WO+jhNEBQBazEICdmiU2eQHG
 +Xgy1waaBryMgLyIrqMg1xd5Ex4NDJlYgPguyUKYVqrdaqMdr7t/K0BH+bLz7wxUEljh
 ncZLC8dSGQKmjwHT/TPq6ILi9x+2LW9xx2+jzYNCU/wCXNkjRtX7fZeGAs0bCfGMmgib
 coXPrPcmoVVpbGq7G/bpJ3IFQhLKvPan8we8ohDK8cXe/JguReMeYA3h+hRBUprknc1A
 RYord/nQ9fa7Ckof1euLMakb2BHuvhqrJ1I1mK2UAS3sIiljb7yxRF6N5gId1H3DtXYM
 Pczw==
X-Gm-Message-State: AOJu0YzDAYSEQhOplIrEjV05JZvYtnQbiJHup7sOBgQKlLJrgDzbKTnl
 8ABBauehn+JAwDSUxlEUZ7AaMRX+ZvUkerPSQjrNEQ==
X-Google-Smtp-Source: AGHT+IFsChXBbfK8kGjqFE1/+TUaEVA8Lpn92TaOjKm9kLh8QQjJ63cqAoso8mkN2twtQMKRktZghaOjYRx14WTPH1c=
X-Received: by 2002:a05:6512:6cf:b0:503:2e6:685e with SMTP id
 u15-20020a05651206cf00b0050302e6685emr2166773lff.14.1700660813413; Wed, 22
 Nov 2023 05:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-8-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-8-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 Nov 2023 15:46:16 +0200
Message-ID: <CAC_iWjJ_91fPNOVkLCDz3QSjCEnS0nHRMZ2n_KZyv_8wj5D19g@mail.gmail.com>
Subject: Re: [PATCH 08/11] efi_loader: Remove <common.h>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,
Thanks for the cleanup

On Wed, 22 Nov 2023 at 15:12, Tom Rini <trini@konsulko.com> wrote:

> We largely do not need <common.h> in these files, so drop it. The only
> exception here is that efi_freestanding.c needs <linux/types.h> and had
> been getting that via <common.h>.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  include/efi_loader.h                       | 1 -
>  lib/efi_loader/dtbdump.c                   | 1 -
>  lib/efi_loader/efi_acpi.c                  | 1 -
>  lib/efi_loader/efi_bootmgr.c               | 1 -
>  lib/efi_loader/efi_boottime.c              | 1 -
>  lib/efi_loader/efi_capsule.c               | 1 -
>  lib/efi_loader/efi_conformance.c           | 1 -
>  lib/efi_loader/efi_console.c               | 1 -
>  lib/efi_loader/efi_device_path.c           | 1 -
>  lib/efi_loader/efi_device_path_to_text.c   | 1 -
>  lib/efi_loader/efi_device_path_utilities.c | 1 -
>  lib/efi_loader/efi_disk.c                  | 1 -
>  lib/efi_loader/efi_dt_fixup.c              | 1 -
>  lib/efi_loader/efi_esrt.c                  | 1 -
>  lib/efi_loader/efi_file.c                  | 1 -
>  lib/efi_loader/efi_firmware.c              | 1 -
>  lib/efi_loader/efi_freestanding.c          | 2 +-
>  lib/efi_loader/efi_gop.c                   | 1 -
>  lib/efi_loader/efi_helper.c                | 1 -
>  lib/efi_loader/efi_hii.c                   | 1 -
>  lib/efi_loader/efi_hii_config.c            | 1 -
>  lib/efi_loader/efi_image_loader.c          | 1 -
>  lib/efi_loader/efi_load_initrd.c           | 1 -
>  lib/efi_loader/efi_load_options.c          | 1 -
>  lib/efi_loader/efi_memory.c                | 1 -
>  lib/efi_loader/efi_net.c                   | 1 -
>  lib/efi_loader/efi_riscv.c                 | 1 -
>  lib/efi_loader/efi_rng.c                   | 1 -
>  lib/efi_loader/efi_root_node.c             | 1 -
>  lib/efi_loader/efi_runtime.c               | 1 -
>  lib/efi_loader/efi_setup.c                 | 1 -
>  lib/efi_loader/efi_signature.c             | 1 -
>  lib/efi_loader/efi_smbios.c                | 1 -
>  lib/efi_loader/efi_string.c                | 1 -
>  lib/efi_loader/efi_tcg2.c                  | 1 -
>  lib/efi_loader/efi_unicode_collation.c     | 1 -
>  lib/efi_loader/efi_var_common.c            | 1 -
>  lib/efi_loader/efi_var_file.c              | 1 -
>  lib/efi_loader/efi_var_mem.c               | 1 -
>  lib/efi_loader/efi_variable.c              | 1 -
>  lib/efi_loader/efi_variable_tee.c          | 1 -
>  lib/efi_loader/efi_watchdog.c              | 1 -
>  lib/efi_loader/initrddump.c                | 1 -
>  43 files changed, 1 insertion(+), 43 deletions(-)
>


 Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e24410505f40..247be060e1c0 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -8,7 +8,6 @@
>  #ifndef _EFI_LOADER_H
>  #define _EFI_LOADER_H 1
>
> -#include <common.h>
>  #include <blk.h>
>  #include <event.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> index 3ce2a07f9eb0..5f39cf22da79 100644
> --- a/lib/efi_loader/dtbdump.c
> +++ b/lib/efi_loader/dtbdump.c
> @@ -6,7 +6,6 @@
>   * to a file.
>   */
>
> -#include <common.h>
>  #include <efi_api.h>
>  #include <efi_dt_fixup.h>
>  #include <part.h>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index f755af76f866..67bbd2a01c0b 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -5,7 +5,6 @@
>   *  Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <mapmem.h>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a40762c74c83..47691d8a3d4d 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <charset.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 0b7579cb5af1..f82b1a809f8f 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -5,7 +5,6 @@
>   * Copyright (c) 2016 Alexander Graf
>   */
>
> -#include <common.h>
>  #include <bootm.h>
>  #include <div64.h>
>  #include <dm/device.h>
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index af8a2ee940ce..de0d49ebebda 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -8,7 +8,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <env.h>
> diff --git a/lib/efi_loader/efi_conformance.c
> b/lib/efi_loader/efi_conformance.c
> index 0ca26f57a7f2..167067e26cd1 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -5,7 +5,6 @@
>   *  Copyright (C) 2022 Arm Ltd.
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <efi_api.h>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index a2d137d7a9e1..03dece51aeaa 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -8,7 +8,6 @@
>  #define LOG_CATEGORY LOGC_EFI
>
>  #include <ansi.h>
> -#include <common.h>
>  #include <charset.h>
>  #include <malloc.h>
>  #include <time.h>
> diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> index ed7214f3a347..8dbd8105ae26 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <blk.h>
>  #include <dm.h>
>  #include <dm/root.h>
> diff --git a/lib/efi_loader/efi_device_path_to_text.c
> b/lib/efi_loader/efi_device_path_to_text.c
> index 8c76d8be605d..0c7b30a26e7e 100644
> --- a/lib/efi_loader/efi_device_path_to_text.c
> +++ b/lib/efi_loader/efi_device_path_to_text.c
> @@ -5,7 +5,6 @@
>   *  Copyright (c) 2017 Heinrich Schuchardt
>   */
>
> -#include <common.h>
>  #include <blk.h>
>  #include <efi_loader.h>
>  #include <malloc.h>
> diff --git a/lib/efi_loader/efi_device_path_utilities.c
> b/lib/efi_loader/efi_device_path_utilities.c
> index a07d9bab3a3c..844d8acd67c0 100644
> --- a/lib/efi_loader/efi_device_path_utilities.c
> +++ b/lib/efi_loader/efi_device_path_utilities.c
> @@ -5,7 +5,6 @@
>   *  Copyright (c) 2017 Leif Lindholm
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>
>  const efi_guid_t efi_guid_device_path_utilities_protocol =
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index f0d76113b001..321f9b82b73c 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <blk.h>
>  #include <dm.h>
>  #include <dm/device-internal.h>
> diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
> index 838023c78ff7..2176388f4207 100644
> --- a/lib/efi_loader/efi_dt_fixup.c
> +++ b/lib/efi_loader/efi_dt_fixup.c
> @@ -5,7 +5,6 @@
>   * Copyright (c) 2020 Heinrich Schuchardt
>   */
>
> -#include <common.h>
>  #include <efi_dt_fixup.h>
>  #include <efi_loader.h>
>  #include <efi_rng.h>
> diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
> index 7f46d651e6f2..dafd447b6d76 100644
> --- a/lib/efi_loader/efi_esrt.c
> +++ b/lib/efi_loader/efi_esrt.c
> @@ -5,7 +5,6 @@
>   *  Copyright (C) 2021 Arm Ltd.
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <efi_api.h>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 3c56cebf9653..222001d6a3b5 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -5,7 +5,6 @@
>   * Copyright (c) 2017 Rob Clark
>   */
>
> -#include <common.h>
>  #include <charset.h>
>  #include <efi_loader.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 9abb29f1dff1..1fde1885e3ca 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -6,7 +6,6 @@
>   *                     Author: AKASHI Takahiro
>   */
>
> -#include <common.h>
>  #include <charset.h>
>  #include <dfu.h>
>  #include <efi_loader.h>
> diff --git a/lib/efi_loader/efi_freestanding.c
> b/lib/efi_loader/efi_freestanding.c
> index 4b65fc64dd04..b2786095c323 100644
> --- a/lib/efi_loader/efi_freestanding.c
> +++ b/lib/efi_loader/efi_freestanding.c
> @@ -8,7 +8,7 @@
>   * memset(), and memcmp().
>   */
>
> -#include <common.h>
> +#include <linux/types.h>
>
>  /**
>   * memcmp() - compare memory areas
> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> index a09db31eb465..41e12fa72460 100644
> --- a/lib/efi_loader/efi_gop.c
> +++ b/lib/efi_loader/efi_gop.c
> @@ -5,7 +5,6 @@
>   *  Copyright (c) 2016 Alexander Graf
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <efi_loader.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index cdfd16ea7742..17f27ca1a0b2 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -4,7 +4,6 @@
>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> -#include <common.h>
>  #include <env.h>
>  #include <malloc.h>
>  #include <dm.h>
> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> index 3b54ecb11ac1..74e402df1b8a 100644
> --- a/lib/efi_loader/efi_hii.c
> +++ b/lib/efi_loader/efi_hii.c
> @@ -6,7 +6,6 @@
>   *  Copyright (c) 2018 AKASHI Takahiro, Linaro Limited
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <malloc.h>
>  #include <asm/unaligned.h>
> diff --git a/lib/efi_loader/efi_hii_config.c
> b/lib/efi_loader/efi_hii_config.c
> index 31b0c97eb286..ae0f3ecd3b18 100644
> --- a/lib/efi_loader/efi_hii_config.c
> +++ b/lib/efi_loader/efi_hii_config.c
> @@ -10,7 +10,6 @@
>   * the Makefile.
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>
>  const efi_guid_t efi_guid_hii_config_routing_protocol
> diff --git a/lib/efi_loader/efi_image_loader.c
> b/lib/efi_loader/efi_image_loader.c
> index 97547571ce33..604243603289 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -9,7 +9,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <efi_loader.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_load_initrd.c
> b/lib/efi_loader/efi_load_initrd.c
> index 193433782c24..2b467b554810 100644
> --- a/lib/efi_loader/efi_load_initrd.c
> +++ b/lib/efi_loader/efi_load_initrd.c
> @@ -4,7 +4,6 @@
>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <efi_load_initrd.h>
>  #include <efi_variable.h>
> diff --git a/lib/efi_loader/efi_load_options.c
> b/lib/efi_loader/efi_load_options.c
> index 5f62184da1cd..01984235e248 100644
> --- a/lib/efi_loader/efi_load_options.c
> +++ b/lib/efi_loader/efi_load_options.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <charset.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index f752703b438e..edfad2d95a1d 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 96a5bcca2758..7cd536705f43 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -15,7 +15,6 @@
>   * Reset():     EfiSimpleNetworkInitialized -> EfiSimpleNetworkInitialized
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <malloc.h>
>  #include <net.h>
> diff --git a/lib/efi_loader/efi_riscv.c b/lib/efi_loader/efi_riscv.c
> index 064172755b95..4d398c5be348 100644
> --- a/lib/efi_loader/efi_riscv.c
> +++ b/lib/efi_loader/efi_riscv.c
> @@ -7,7 +7,6 @@
>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
> index bb11d8d0e0cb..9bad7ed69317 100644
> --- a/lib/efi_loader/efi_rng.c
> +++ b/lib/efi_loader/efi_rng.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <dm.h>
>  #include <efi_loader.h>
>  #include <efi_rng.h>
> diff --git a/lib/efi_loader/efi_root_node.c
> b/lib/efi_loader/efi_root_node.c
> index 108c14b95bd6..4d7fb74b5d6f 100644
> --- a/lib/efi_loader/efi_root_node.c
> +++ b/lib/efi_loader/efi_root_node.c
> @@ -5,7 +5,6 @@
>   *  Copyright (c) 2018 Heinrich Schuchardt
>   */
>
> -#include <common.h>
>  #include <malloc.h>
>  #include <efi_dt_fixup.h>
>  #include <efi_loader.h>
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index bf54d6ad871d..18da6892e796 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -5,7 +5,6 @@
>   *  Copyright (c) 2016 Alexander Graf
>   */
>
> -#include <common.h>
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <dm.h>
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index e6de685e8795..36f66c51921b 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_signature.c
> b/lib/efi_loader/efi_signature.c
> index 742d8919402c..f338e7327599 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -4,7 +4,6 @@
>   * Copyright (c) 2019 Linaro Limited, Author: AKASHI Takahiro
>   */
>
> -#include <common.h>
>  #include <charset.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 48446f654d9b..2a79c0b1ba60 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/lib/efi_loader/efi_string.c b/lib/efi_loader/efi_string.c
> index e21e09c94617..413e329b600c 100644
> --- a/lib/efi_loader/efi_string.c
> +++ b/lib/efi_loader/efi_string.c
> @@ -5,7 +5,6 @@
>   * Copyright (c) 2020 AKASHI Takahiro, Linaro Limited
>   */
>
> -#include <common.h>
>  #include <charset.h>
>  #include <efi_loader.h>
>  #include <malloc.h>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 463ea4c15416..8db35d0b3c85 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -8,7 +8,6 @@
>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> -#include <common.h>
>  #include <dm.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> diff --git a/lib/efi_loader/efi_unicode_collation.c
> b/lib/efi_loader/efi_unicode_collation.c
> index c4c75720634a..2b6912c50921 100644
> --- a/lib/efi_loader/efi_unicode_collation.c
> +++ b/lib/efi_loader/efi_unicode_collation.c
> @@ -5,7 +5,6 @@
>   * Copyright (c) 2018 Heinrich Schuchardt <xypron.glpk@gmx.de>
>   */
>
> -#include <common.h>
>  #include <charset.h>
>  #include <cp1250.h>
>  #include <cp437.h>
> diff --git a/lib/efi_loader/efi_var_common.c
> b/lib/efi_loader/efi_var_common.c
> index ad50bffd2b26..d528747f3fb4 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -6,7 +6,6 @@
>   * Copyright (c) 2020 Linaro Limited, Author: AKASHI Takahiro
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <stdlib.h>
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index d7dba050710a..532b6b40eefe 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <charset.h>
>  #include <fs.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 5fa7dcb8d3ed..6c21cec5d457 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -5,7 +5,6 @@
>   * Copyright (c) 2020, Heinrich Schuchardt
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <u-boot/crc.h>
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index be95ed44e6ef..40f7a0fb10d5 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <env.h>
> diff --git a/lib/efi_loader/efi_variable_tee.c
> b/lib/efi_loader/efi_variable_tee.c
> index 09d03c0eee78..dde135fd9f81 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -10,7 +10,6 @@
>   *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */
>
> -#include <common.h>
>  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
>  #include <arm_ffa.h>
>  #endif
> diff --git a/lib/efi_loader/efi_watchdog.c b/lib/efi_loader/efi_watchdog.c
> index d741076dcdd9..f5fb9117717c 100644
> --- a/lib/efi_loader/efi_watchdog.c
> +++ b/lib/efi_loader/efi_watchdog.c
> @@ -5,7 +5,6 @@
>   *  Copyright (c) 2017 Heinrich Schuchardt
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>
>  /* Conversion factor from seconds to multiples of 100ns */
> diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
> index 5b470f481946..0004b6b042b4 100644
> --- a/lib/efi_loader/initrddump.c
> +++ b/lib/efi_loader/initrddump.c
> @@ -9,7 +9,6 @@
>   * clearing of the screen.
>   */
>
> -#include <common.h>
>  #include <efi_api.h>
>  #include <efi_load_initrd.h>
>
> --
> 2.34.1
>
>
