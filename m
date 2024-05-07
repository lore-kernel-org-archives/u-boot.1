Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0CBC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 07:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AEE188723;
	Tue,  7 May 2024 09:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LLwWGwXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB6088724; Tue,  7 May 2024 09:37:26 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1BD882C0
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59a0168c75so707559366b.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715067443; x=1715672243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=77PTX0K6UtWZ9NjNex4bAvsyRH8N4pDhzQXmVcSeNsQ=;
 b=LLwWGwXEh3tmDOoCcRtR4rOIFwqlQeBNMLggX1f/hRrZv6j339BonagiHIrR6etRbu
 4AJelA1jdJwzf2qybCldPsV7v7iOjAntZZzpCXRe42ecVWbAQnse6vEGeCLOnZvapv2h
 +LVD+0ukmnSMnk93Be7tC2p/sZ20MtMl1p3e/2wQqpLOnpO/di/iGUx2Uw/m6innRvpV
 bBGvYxBpDhwz9jVMGz+qiDkZAyqkibE7ArWQINNIXIE7uZTR13LOvboB+g3gT7bA0wt4
 VyFRJBiRaLNl8VhPiSTINpmoyoOFzamLRJB0LxqLdrrkGPkn1DxW1VcXJHm5DBtFoAdi
 UWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715067443; x=1715672243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77PTX0K6UtWZ9NjNex4bAvsyRH8N4pDhzQXmVcSeNsQ=;
 b=PRIhaDxi85RmB/v1CA8Amhd4UHFSMJSU0EQTySETT0DoQn+3c+UVUP1c/P/Bg8IHXg
 mQhh/19ilwtzX+JszXEHRtxVlcPmkt5YVc2GkK+4eKrFnz+74aN2szXXEuXigm8HYqGH
 hyPh6qgoBh+BpKs7vVD6BVmaE2rTvMK7nN+ypLZWJghGbzvgC6Hp+uR+nozqfsJYOnO7
 I3SaMli3ULReB/LtWNgnqdDwIc37MmbRFX3xp7LPbL9PPkKrjvsrgXof3LTJcK32nowq
 QQSJNBBm8F6REoZ+yo1fzKShF7Lz4MIEjfpV86e6Vzgqhm9xYfJCP+y8TnxGrpYCUH9J
 ajNQ==
X-Gm-Message-State: AOJu0YxZJOt3x7UdI1SUJ6VvZ5/RnsNvLqtAc2Tgjhan8AowoQ/V29GA
 FFQwMJ0yCLutD66p23Uoq2xOPCwEEs4qJtcblYZ4dXFsWKu5+ultvwBMjzpASRmmkXxRiIgMmXl
 bWQVi6Psl0qD0iNJmKljn43HJvpEj3HpHmibhGLUZeF9Nja2qEWzI+g==
X-Google-Smtp-Source: AGHT+IF2P/XxU8uIfwPwSvkRqsaK7Nw4YOu3s5aKFuF0R3Q2UapSVyJW4q9L+QCURr98v0c3knvcoOWR8uPgfDa4efs=
X-Received: by 2002:a17:906:1c0e:b0:a59:aff8:c713 with SMTP id
 k14-20020a1709061c0e00b00a59aff8c713mr4165662ejg.10.1715067443311; Tue, 07
 May 2024 00:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-71-trini@konsulko.com>
In-Reply-To: <20240502013138.2383421-71-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 May 2024 10:36:46 +0300
Message-ID: <CAC_iWjLtOTLzuNQ6ojm_JvCQ6vPmaGHZ4_430zRmjCn5eE4iEA@mail.gmail.com>
Subject: Re: [PATCH 71/81] tpm: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Thu, 2 May 2024 at 04:34, Tom Rini <trini@konsulko.com> wrote:
>
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  drivers/tpm/cr50_i2c.c             | 2 +-
>  drivers/tpm/sandbox_common.c       | 1 -
>  drivers/tpm/tpm-uclass.c           | 2 +-
>  drivers/tpm/tpm2_ftpm_tee.c        | 1 -
>  drivers/tpm/tpm2_tis_core.c        | 2 +-
>  drivers/tpm/tpm2_tis_i2c.c         | 1 -
>  drivers/tpm/tpm2_tis_mmio.c        | 1 -
>  drivers/tpm/tpm2_tis_sandbox.c     | 1 -
>  drivers/tpm/tpm2_tis_spi.c         | 2 +-
>  drivers/tpm/tpm_atmel_twi.c        | 2 +-
>  drivers/tpm/tpm_tis_infineon.c     | 2 +-
>  drivers/tpm/tpm_tis_lpc.c          | 1 -
>  drivers/tpm/tpm_tis_sandbox.c      | 1 -
>  drivers/tpm/tpm_tis_st33zp24_i2c.c | 1 -
>  drivers/tpm/tpm_tis_st33zp24_spi.c | 1 -
>  15 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
> index acf4c7859a9f..08ec179346e2 100644
> --- a/drivers/tpm/cr50_i2c.c
> +++ b/drivers/tpm/cr50_i2c.c
> @@ -7,12 +7,12 @@
>
>  #define LOG_CATEGORY UCLASS_TPM
>
> -#include <common.h>
>  #include <dm.h>
>  #include <i2c.h>
>  #include <irq.h>
>  #include <log.h>
>  #include <spl.h>
> +#include <time.h>
>  #include <tpm-common.h>
>  #include <tpm-v2.h>
>  #include <acpi/acpigen.h>
> diff --git a/drivers/tpm/sandbox_common.c b/drivers/tpm/sandbox_common.c
> index 7e0b2502e35d..596e01563899 100644
> --- a/drivers/tpm/sandbox_common.c
> +++ b/drivers/tpm/sandbox_common.c
> @@ -7,7 +7,6 @@
>
>  #define LOG_CATEGORY   UCLASS_TPM
>
> -#include <common.h>
>  #include <tpm-v1.h>
>  #include <tpm-v2.h>
>  #include <asm/unaligned.h>
> diff --git a/drivers/tpm/tpm-uclass.c b/drivers/tpm/tpm-uclass.c
> index b2286f7e7edc..0fade2dcc0ad 100644
> --- a/drivers/tpm/tpm-uclass.c
> +++ b/drivers/tpm/tpm-uclass.c
> @@ -6,9 +6,9 @@
>
>  #define LOG_CATEGORY UCLASS_TPM
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
> +#include <time.h>
>  #include <tpm_api.h>
>  #include <tpm-v1.h>
>  #include <tpm-v2.h>
> diff --git a/drivers/tpm/tpm2_ftpm_tee.c b/drivers/tpm/tpm2_ftpm_tee.c
> index c61ff2c2af63..f2ced50c4eb7 100644
> --- a/drivers/tpm/tpm2_ftpm_tee.c
> +++ b/drivers/tpm/tpm2_ftpm_tee.c
> @@ -13,7 +13,6 @@
>   * https://github.com/microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM/optee_ta/fTPM
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <tpm-v2.h>
> diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
> index 81b9210056db..680a6409433e 100644
> --- a/drivers/tpm/tpm2_tis_core.c
> +++ b/drivers/tpm/tpm2_tis_core.c
> @@ -5,8 +5,8 @@
>   * Based on the Linux TIS core interface and U-Boot original SPI TPM driver
>   */
>
> -#include <common.h>
>  #include <dm.h>
> +#include <time.h>
>  #include <tpm-v2.h>
>  #include <linux/delay.h>
>  #include <linux/unaligned/be_byteshift.h>
> diff --git a/drivers/tpm/tpm2_tis_i2c.c b/drivers/tpm/tpm2_tis_i2c.c
> index 99d1cf218daf..93efccc77575 100644
> --- a/drivers/tpm/tpm2_tis_i2c.c
> +++ b/drivers/tpm/tpm2_tis_i2c.c
> @@ -3,7 +3,6 @@
>   * Copyright 2022 IBM Corp.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <fdtdec.h>
>  #include <i2c.h>
> diff --git a/drivers/tpm/tpm2_tis_mmio.c b/drivers/tpm/tpm2_tis_mmio.c
> index a646ce41ff4e..dee5503c055f 100644
> --- a/drivers/tpm/tpm2_tis_mmio.c
> +++ b/drivers/tpm/tpm2_tis_mmio.c
> @@ -5,7 +5,6 @@
>   * Specifications at www.trustedcomputinggroup.org
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <tpm-v2.h>
> diff --git a/drivers/tpm/tpm2_tis_sandbox.c b/drivers/tpm/tpm2_tis_sandbox.c
> index d15a28d9fc82..50e308e71161 100644
> --- a/drivers/tpm/tpm2_tis_sandbox.c
> +++ b/drivers/tpm/tpm2_tis_sandbox.c
> @@ -4,7 +4,6 @@
>   * Author: Miquel Raynal <miquel.raynal@bootlin.com>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <tpm-v2.h>
>  #include <asm/state.h>
> diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> index de9cf8f21e07..28079b5039a3 100644
> --- a/drivers/tpm/tpm2_tis_spi.c
> +++ b/drivers/tpm/tpm2_tis_spi.c
> @@ -13,11 +13,11 @@
>   * It is based on the U-Boot driver tpm_tis_infineon_i2c.c.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <fdtdec.h>
>  #include <log.h>
>  #include <spi.h>
> +#include <time.h>
>  #include <tpm-v2.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> diff --git a/drivers/tpm/tpm_atmel_twi.c b/drivers/tpm/tpm_atmel_twi.c
> index fd2a45d34b03..05dd66525c77 100644
> --- a/drivers/tpm/tpm_atmel_twi.c
> +++ b/drivers/tpm/tpm_atmel_twi.c
> @@ -5,11 +5,11 @@
>   * Written by Dirk Eibach <dirk.eibach@gdsys.cc>
>   */
>
> -#include <common.h>
>  #include <display_options.h>
>  #include <dm.h>
>  #include <tpm-v1.h>
>  #include <i2c.h>
> +#include <time.h>
>  #include <asm/unaligned.h>
>  #include <linux/delay.h>
>
> diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
> index 16f4af0e331e..e2f6238cbc71 100644
> --- a/drivers/tpm/tpm_tis_infineon.c
> +++ b/drivers/tpm/tpm_tis_infineon.c
> @@ -19,11 +19,11 @@
>   * Version: 2.1.1
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <fdtdec.h>
>  #include <i2c.h>
>  #include <log.h>
> +#include <time.h>
>  #include <tpm-v1.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> diff --git a/drivers/tpm/tpm_tis_lpc.c b/drivers/tpm/tpm_tis_lpc.c
> index 13a133d58ebd..dec7acb0c7b1 100644
> --- a/drivers/tpm/tpm_tis_lpc.c
> +++ b/drivers/tpm/tpm_tis_lpc.c
> @@ -12,7 +12,6 @@
>   * slb9635), so this driver provides access to locality 0 only.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <mapmem.h>
> diff --git a/drivers/tpm/tpm_tis_sandbox.c b/drivers/tpm/tpm_tis_sandbox.c
> index 7350e1c4d525..2bc7dc87ed30 100644
> --- a/drivers/tpm/tpm_tis_sandbox.c
> +++ b/drivers/tpm/tpm_tis_sandbox.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2013 Google, Inc
>   */
>
> -#include <common.h>
>  #include <display_options.h>
>  #include <dm.h>
>  #include <tpm-v1.h>
> diff --git a/drivers/tpm/tpm_tis_st33zp24_i2c.c b/drivers/tpm/tpm_tis_st33zp24_i2c.c
> index e0eeabb93371..1a265b28b22f 100644
> --- a/drivers/tpm/tpm_tis_st33zp24_i2c.c
> +++ b/drivers/tpm/tpm_tis_st33zp24_i2c.c
> @@ -12,7 +12,6 @@
>   * STMicroelectronics Protocol Stack Specification version 1.2.0.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <fdtdec.h>
>  #include <i2c.h>
> diff --git a/drivers/tpm/tpm_tis_st33zp24_spi.c b/drivers/tpm/tpm_tis_st33zp24_spi.c
> index f0de8a65b093..2cf690328d87 100644
> --- a/drivers/tpm/tpm_tis_st33zp24_spi.c
> +++ b/drivers/tpm/tpm_tis_st33zp24_spi.c
> @@ -12,7 +12,6 @@
>   * STMicroelectronics Protocol Stack Specification version 1.2.0.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <fdtdec.h>
>  #include <log.h>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
