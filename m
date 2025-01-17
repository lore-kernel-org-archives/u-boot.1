Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1990EC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F058076E;
	Fri, 17 Jan 2025 10:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KBTXOsg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1277380771; Fri, 17 Jan 2025 10:21:04 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692AD80737
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e573136107bso3276362276.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737105660; x=1737710460; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BTGkfQwMrbAfoxNQAThOKS12NCHrS0VR1NM9Llnx7Oo=;
 b=KBTXOsg2DMTcAIPmX+MDmGG/TcpLDbuz1J+3HlQh1r/cX4oDCzIfgQ8Uqedp19dohs
 AJ+QLAo2WI7TTmd0jsAUcR3lENr6xHIIsUFg4REvwrr/bljJOJ9zM85x17y23Pyy5OHW
 olhadO8MvrPPm/Zfz4+3JqtRIdpW9bQNI83DVPhgf6Xpt+twDhq0gb55YKQ5NcCCzYpf
 D89Pv2ffk4oH6ywHnt9tKJ9EfMkijGkUAZkgttqRx91eshxhiMc9oSLwW6AnI/LHuyqz
 OrKdlbmh3ZFitjn7Srur7CdGHViRp9Nj7vbzGfYCdvBI2xOZx/Oefm7adZTGEZCkHB1u
 dDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737105660; x=1737710460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BTGkfQwMrbAfoxNQAThOKS12NCHrS0VR1NM9Llnx7Oo=;
 b=I0iMaIfS1QZBe9I0a263d8mLYi3WWEZjjZ2dCM6AmoLIkwqgpiEYZN3vsbJJi4+EdY
 kTVxhfLMw80OrRcQEG1qD4/8jboKG9B9LIqXm9LewxnMc60Gb9u075pWFC0MF94EWKMZ
 l+Lvy/JOQUsuCLkxHc2dMtEPcPmr8raUlBSpO//30Jmrbe0CjUCq8hcsrLjLszfXquXb
 Uf+q61EyWu8ybTFc/JhU66vHDaeC6RN6BJSFhfSBmwKOWCuUFMN3A6/JPKwXBeD4TGuX
 1m9iwOYoe3v/1pMpJ+7yvTPThmh/7qSBxdO00Iqb97np6b8ZYtg4F2b5wtfc2/R1COHH
 1uhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrLXPu1h8rlXFnCyVw5lX/MbO1z84hiYBoYmLNb2Z+1Lupydf/r/0o77SkwW8WNk9gNFAuxNo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8ZURCEodxxH9xXeuRToAoKcVONwJ5/9rz9jvGeGwi5934us+K
 zcCFj0fL7x5ZFTV8fGu/SKdWkirpma1J6Hraj5/ean1DVJ1DvnNDyp5/OpoEYgRiOEL/9rHNjS1
 jJEoQh1RQl6Z34w6sqG9h6IyaX2h3TjqJfQiS1xXxCYyKxvnVCAo=
X-Gm-Gg: ASbGncsPgJw132aetezg9HxMSSSzFWr4ceK6ujT1RsianasdGPOaShVmMR5OOPQogl1
 Yg6Gaqd9pjQFi6tGavp+IDEZzKiqTOr9OXkz7pA==
X-Google-Smtp-Source: AGHT+IHbYlQIYryinjXAxMbaYUI/iLfnyjf1Mffe7VFBWfJWPYXYHmGI6lGpc3weBYWBI068CDJGAyZuFYBKBwxdL1Y=
X-Received: by 2002:a05:690c:67c2:b0:6ef:57ad:9d6e with SMTP id
 00721157ae682-6f6eb67b0f9mr11917657b3.15.1737105660115; Fri, 17 Jan 2025
 01:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20250116192659.374576-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250116192659.374576-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Jan 2025 11:20:24 +0200
X-Gm-Features: AbW1kvb10_5hhcmQUEfJmuthH0-t7QsovH1shCnzcUn83pzf0h6T0ulBki7Gc8I
Message-ID: <CAC_iWjLE89a5Of+Pb44gbR_bo7OajQyYR4Roa8Zp=6jTZSmt_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: use LOGC_EFI consistently
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Thu, 16 Jan 2025 at 21:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The log category should be LOGC_EFI all over the EFI sub-system.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_driver/efi_block_device.c          | 2 ++
>  lib/efi_driver/efi_uclass.c                | 2 ++
>  lib/efi_loader/efi_acpi.c                  | 2 ++
>  lib/efi_loader/efi_boottime.c              | 2 ++
>  lib/efi_loader/efi_conformance.c           | 2 ++
>  lib/efi_loader/efi_device_path_to_text.c   | 2 ++
>  lib/efi_loader/efi_device_path_utilities.c | 2 ++
>  lib/efi_loader/efi_dt_fixup.c              | 2 ++
>  lib/efi_loader/efi_esrt.c                  | 2 ++
>  lib/efi_loader/efi_fdt.c                   | 2 ++
>  lib/efi_loader/efi_file.c                  | 2 ++
>  lib/efi_loader/efi_firmware.c              | 2 ++
>  lib/efi_loader/efi_gop.c                   | 2 ++
>  lib/efi_loader/efi_helper.c                | 1 +
>  lib/efi_loader/efi_hii.c                   | 2 ++
>  lib/efi_loader/efi_hii_config.c            | 2 ++
>  lib/efi_loader/efi_http.c                  | 2 ++
>  lib/efi_loader/efi_ipconfig.c              | 2 ++
>  lib/efi_loader/efi_load_initrd.c           | 1 +
>  lib/efi_loader/efi_net.c                   | 2 ++
>  lib/efi_loader/efi_riscv.c                 | 1 +
>  lib/efi_loader/efi_root_node.c             | 2 ++
>  lib/efi_loader/efi_runtime.c               | 2 ++
>  lib/efi_loader/efi_signature.c             | 2 ++
>  lib/efi_loader/efi_string.c                | 2 ++
>  lib/efi_loader/efi_tcg2.c                  | 1 +
>  lib/efi_loader/efi_unicode_collation.c     | 2 ++
>  lib/efi_loader/efi_var_common.c            | 2 ++
>  lib/efi_loader/efi_var_mem.c               | 2 ++
>  lib/efi_loader/efi_variable_tee.c          | 2 ++
>  lib/efi_loader/efi_watchdog.c              | 2 ++
>  31 files changed, 58 insertions(+)
>
> diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
> index 19a5ee24794..d3c668dc183 100644
> --- a/lib/efi_driver/efi_block_device.c
> +++ b/lib/efi_driver/efi_block_device.c
> @@ -28,6 +28,8 @@
>   * iPXE uses the simple file protocol to load Grub or the Linux Kernel.
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <blk.h>
>  #include <dm.h>
>  #include <efi_driver.h>
> diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
> index e1e28df20b2..495be53cb77 100644
> --- a/lib/efi_driver/efi_uclass.c
> +++ b/lib/efi_driver/efi_uclass.c
> @@ -17,6 +17,8 @@
>   * controllers.
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <dm.h>
>  #include <efi_driver.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 67bd7f8ca24..c1cc6e7b311 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -5,6 +5,8 @@
>   *  Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <mapmem.h>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index ccbaad2b549..9f51db90f33 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -5,6 +5,8 @@
>   * Copyright (c) 2016 Alexander Graf
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <bootm.h>
>  #include <div64.h>
>  #include <dm/device.h>
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
> index 167067e26cd..2bae93a94bd 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -5,6 +5,8 @@
>   *  Copyright (C) 2022 Arm Ltd.
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <efi_api.h>
> diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
> index 481a9712d9d..f6889cb7399 100644
> --- a/lib/efi_loader/efi_device_path_to_text.c
> +++ b/lib/efi_loader/efi_device_path_to_text.c
> @@ -5,6 +5,8 @@
>   *  Copyright (c) 2017 Heinrich Schuchardt
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <blk.h>
>  #include <efi_loader.h>
>  #include <malloc.h>
> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
> index ac250bbfcc9..552c5bb1f05 100644
> --- a/lib/efi_loader/efi_device_path_utilities.c
> +++ b/lib/efi_loader/efi_device_path_utilities.c
> @@ -5,6 +5,8 @@
>   *  Copyright (c) 2017 Leif Lindholm
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>
>  const efi_guid_t efi_guid_device_path_utilities_protocol =
> diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
> index 0dac94b0c6c..26928cfc454 100644
> --- a/lib/efi_loader/efi_dt_fixup.c
> +++ b/lib/efi_loader/efi_dt_fixup.c
> @@ -5,6 +5,8 @@
>   * Copyright (c) 2020 Heinrich Schuchardt
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_dt_fixup.h>
>  #include <efi_loader.h>
>  #include <efi_rng.h>
> diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
> index 443bd999ce1..e235c8fe91c 100644
> --- a/lib/efi_loader/efi_esrt.c
> +++ b/lib/efi_loader/efi_esrt.c
> @@ -5,6 +5,8 @@
>   *  Copyright (C) 2021 Arm Ltd.
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <efi_api.h>
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index f882622fdad..1ba6641d821 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -6,6 +6,8 @@
>   * Written by Simon Glass <sjg@chromium.org>
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <env.h>
>  #include <errno.h>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 95b3c890ee9..201fa5f8f3c 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -5,6 +5,8 @@
>   * Copyright (c) 2017 Rob Clark
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <charset.h>
>  #include <efi_loader.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 112775daf4c..5a754c9cd03 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -6,6 +6,8 @@
>   *                     Author: AKASHI Takahiro
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <charset.h>
>  #include <dfu.h>
>  #include <efi_loader.h>
> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> index 41e12fa7246..4593975be5a 100644
> --- a/lib/efi_loader/efi_gop.c
> +++ b/lib/efi_loader/efi_gop.c
> @@ -5,6 +5,8 @@
>   *  Copyright (c) 2016 Alexander Graf
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <dm.h>
>  #include <efi_loader.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index bf96f61d3d0..04b2efc4a3b 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -4,6 +4,7 @@
>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> +
>  #include <bootm.h>
>  #include <env.h>
>  #include <image.h>
> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> index 74e402df1b8..44235970a7c 100644
> --- a/lib/efi_loader/efi_hii.c
> +++ b/lib/efi_loader/efi_hii.c
> @@ -6,6 +6,8 @@
>   *  Copyright (c) 2018 AKASHI Takahiro, Linaro Limited
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <malloc.h>
>  #include <asm/unaligned.h>
> diff --git a/lib/efi_loader/efi_hii_config.c b/lib/efi_loader/efi_hii_config.c
> index 54a72d573be..521481a86d8 100644
> --- a/lib/efi_loader/efi_hii_config.c
> +++ b/lib/efi_loader/efi_hii_config.c
> @@ -6,6 +6,8 @@
>   * Copyright (c) 2018 AKASHI Takahiro, Linaro Limited
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>
>  const efi_guid_t efi_guid_hii_config_routing_protocol
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 694e1993418..88816256b03 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -7,6 +7,8 @@
>   * IP4_CONFIG2_PROTOCOL
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <charset.h>
>  #include <efi_loader.h>
>  #include <image.h>
> diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
> index 0b247a4c028..f1c092daafd 100644
> --- a/lib/efi_loader/efi_ipconfig.c
> +++ b/lib/efi_loader/efi_ipconfig.c
> @@ -4,6 +4,8 @@
>   *
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <image.h>
>  #include <malloc.h>
> diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
> index 23508431c83..fb8cc7bcbe3 100644
> --- a/lib/efi_loader/efi_load_initrd.c
> +++ b/lib/efi_loader/efi_load_initrd.c
> @@ -4,6 +4,7 @@
>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <efi_load_initrd.h>
>  #include <efi_variable.h>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 67593ef50c0..ce9272fa240 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -15,6 +15,8 @@
>   * Reset():     EfiSimpleNetworkInitialized -> EfiSimpleNetworkInitialized
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <dm.h>
>  #include <linux/sizes.h>
> diff --git a/lib/efi_loader/efi_riscv.c b/lib/efi_loader/efi_riscv.c
> index 4d398c5be34..6f2ccf4f7e6 100644
> --- a/lib/efi_loader/efi_riscv.c
> +++ b/lib/efi_loader/efi_riscv.c
> @@ -7,6 +7,7 @@
>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <log.h>
> diff --git a/lib/efi_loader/efi_root_node.c b/lib/efi_loader/efi_root_node.c
> index 426f77cb2ad..e5246f65df2 100644
> --- a/lib/efi_loader/efi_root_node.c
> +++ b/lib/efi_loader/efi_root_node.c
> @@ -5,6 +5,8 @@
>   *  Copyright (c) 2018 Heinrich Schuchardt
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <malloc.h>
>  #include <efi_dt_fixup.h>
>  #include <efi_loader.h>
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 05369c47b01..35eb6a77766 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -5,6 +5,8 @@
>   *  Copyright (c) 2016 Alexander Graf
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <dm.h>
> diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
> index 184eac8cddb..93a4f257016 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) 2019 Linaro Limited, Author: AKASHI Takahiro
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <charset.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> diff --git a/lib/efi_loader/efi_string.c b/lib/efi_loader/efi_string.c
> index 413e329b600..50d1daf33a9 100644
> --- a/lib/efi_loader/efi_string.c
> +++ b/lib/efi_loader/efi_string.c
> @@ -5,6 +5,8 @@
>   * Copyright (c) 2020 AKASHI Takahiro, Linaro Limited
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <charset.h>
>  #include <efi_loader.h>
>  #include <malloc.h>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index a15c73162ee..c697b53441a 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -8,6 +8,7 @@
>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> +
>  #include <dm.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> diff --git a/lib/efi_loader/efi_unicode_collation.c b/lib/efi_loader/efi_unicode_collation.c
> index d48700a352b..df2a988ee39 100644
> --- a/lib/efi_loader/efi_unicode_collation.c
> +++ b/lib/efi_loader/efi_unicode_collation.c
> @@ -5,6 +5,8 @@
>   * Copyright (c) 2018 Heinrich Schuchardt <xypron.glpk@gmx.de>
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <charset.h>
>  #include <cp1250.h>
>  #include <cp437.h>
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index ea8d2a4cf98..4b34a58b4cf 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -5,6 +5,8 @@
>   * Copyright (c) 2020 Linaro Limited, Author: AKASHI Takahiro
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <stdlib.h>
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 139e16aad7c..b265d95dd6b 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -5,6 +5,8 @@
>   * Copyright (c) 2020, Heinrich Schuchardt
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <u-boot/crc.h>
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> index 8b6b0a39086..0d090d051dd 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -10,6 +10,8 @@
>   *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
>  #include <arm_ffa.h>
>  #endif
> diff --git a/lib/efi_loader/efi_watchdog.c b/lib/efi_loader/efi_watchdog.c
> index f5fb9117717..c21d8086074 100644
> --- a/lib/efi_loader/efi_watchdog.c
> +++ b/lib/efi_loader/efi_watchdog.c
> @@ -5,6 +5,8 @@
>   *  Copyright (c) 2017 Heinrich Schuchardt
>   */
>
> +#define LOG_CATEGORY LOGC_EFI
> +
>  #include <efi_loader.h>
>
>  /* Conversion factor from seconds to multiples of 100ns */
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
