Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0085C54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 13:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7EC87D6B;
	Thu, 14 Mar 2024 14:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J3tR2BXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E229C87D6B; Thu, 14 Mar 2024 14:55:02 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0693787F04
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 14:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-513ccc70a6dso1482293e87.1
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710424498; x=1711029298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fd4c2sjm0QTf8v0jHbGxNe5fXVkv4ALdmUM4QBTd1qU=;
 b=J3tR2BXBSRZt1Wd4UF54FERW6hy7v7iAQjMTf560ouZv5P3z5PRxPgMb8Nu8DcZKlo
 cK37397Je6UPyiKT74q52v5gleuW5+l+wCnuNAKF6P/PtE6sQJh4idetddF0MN2tdtQ3
 dyIq8IrDBfuEIB5c8fJ0ZVqQLSWlS/+FFxxKkGBUNZDgxNM3jIALGvpvme0BYdEqFRE+
 WEat6eiXe64EpzRVo+NghYE84z2bMOk/fuF8PfmXdIlKp28jaGmSIMiWT+GBAf1R6PjF
 O0erNciucLgj4tXAoYnRIPUvLRMx06B5Dpw8ViaD5a7CaOiwtGEQmGGWuIUPngxPnqmx
 EtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710424498; x=1711029298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fd4c2sjm0QTf8v0jHbGxNe5fXVkv4ALdmUM4QBTd1qU=;
 b=AcZMj5++E2kXw1q0npe6ViFlAN6S/+B6Yvxk24k1lVSxWzCaNXyy2shORSYzQOc+bA
 RLevEYLITQ2+LkXPD5Bc/83c8FWCLOMzNGb0owYz6TMd0Y5UfEY0kRSZ7dtnKdu7XEl5
 qDz2eTbWNklhBs0qs4fL2eFkgeUZtMoYw/r3lUK8RXJIAmkmi1yTW1Q98q7HhQ/ZH+N9
 nQZTA4XVbPM0P3aXJuUUZe/DFJUB0+jS5oEEdvtOFEDq00hSC8CjrYR2NywhcTbYwIyx
 n4nF0gakSWjjmoAOUqrvP2WKQXAa89NOyjp1YygvIbxZXllE40cAnnDtYzRitgTb5nzK
 OhbQ==
X-Gm-Message-State: AOJu0Yz535I+mt3o5r1MGi0jl3ZkGFO0ujOj/D8UQ1QfNS3kNEXFPxud
 /dnYiKgk2DV/N6lcFnMn2J88PEl83Qp3FumpA8ve6mVQtbrjA8uHZK5tFM/Hwec+h85OAum1FKX
 FpVU3KSE+xs/5aUqhV1g0L0yWJOjNVjTGOZc4EA==
X-Google-Smtp-Source: AGHT+IFUeegFs+8+WMUOuaGan1/sSMNxFV8YkAwYpHk0VTCYB9m37e2PVfO8HYnw+/RKZRu+v4j9YveT8kj1cr8SACU=
X-Received: by 2002:a19:8c10:0:b0:513:ca40:fafc with SMTP id
 o16-20020a198c10000000b00513ca40fafcmr173513lfd.11.1710424497946; Thu, 14 Mar
 2024 06:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240304061100.2386856-1-kojima.masahisa@socionext.com>
In-Reply-To: <20240304061100.2386856-1-kojima.masahisa@socionext.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Mar 2024 15:54:21 +0200
Message-ID: <CAC_iWjL1P0HLv+PJ6aH+=n-PBtaq=dqYujzVA+J+_yp1x20Nkg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: accept append write with valid size and data
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Kojima-san

Apologies for the late reply

On Mon, 4 Mar 2024 at 08:10, Masahisa Kojima
<kojima.masahisa@socionext.com> wrote:
>
> Current "variables" efi_selftest result is inconsistent
> between the U-Boot file storage and the tee-based StandaloneMM
> RPMB secure storage.
> U-Boot file storage implementation does not accept SetVariale
> call to non-existent variable with EFI_VARIABLE_APPEND_WRITE
> attribute and valid size and data, however it is accepted
> in EDK II StandaloneMM implementation.

Yes,

>
> Since UEFI specification does not clearly describe the behavior
> of the append write to non-existent variable, let's update
> the U-Boot file storage implementation to get aligned with
> the EDK II reference implementation.
>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> ---
>  lib/efi_loader/efi_variable.c             | 13 +++++-----
>  lib/efi_selftest/efi_selftest_variables.c | 30 +++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 40f7a0fb10..1693c3387b 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -282,11 +282,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 }
>                 time = var->time;
>         } else {
> -               if (delete || append)
> -                       /*
> -                        * Trying to delete or to update a non-existent
> -                        * variable.
> -                        */
> +               if (delete)
> +                       /* Trying to delete a non-existent variable. */
>                         return EFI_NOT_FOUND;

I am not sure about this tbh. The UEFI spec says
"When the EFI_VARIABLE_APPEND_WRITE attribute is set, then a
SetVariable() call with a DataSize of zero will not cause any change
to the variable value (the timestamp
associated with the variable may be updated however, even if no new
data value is provided;see the description
of the EFI_VARIABLE_AUTHENTICATION_2 descriptor below). In this case
the DataSize will not be zero
since the EFI_VARIABLE_AUTHENTICATION_2 descriptor will be populated)"

I think this assumes the variable exists. Is there a different chapter
in the spec that describes the behavior?

>         }
>
> @@ -329,7 +326,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 /* EFI_NOT_FOUND has been handled before */
>                 attributes = var->attr;
>                 ret = EFI_SUCCESS;
> -       } else if (append) {
> +       } else if (append && var) {
> +               /*
> +                * data is appended if EFI_VARIABLE_APPEND_WRITE is set and
> +                * variable exists.
> +                */
>                 u16 *old_data = var->name;
>
>                 for (; *old_data; ++old_data)
> diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
> index c7a3fdbaa6..0c2c76599e 100644
> --- a/lib/efi_selftest/efi_selftest_variables.c
> +++ b/lib/efi_selftest/efi_selftest_variables.c
> @@ -131,13 +131,39 @@ static int execute(void)
>                             (unsigned int)len);
>         if (memcmp(data, v, len))
>                 efi_st_todo("GetVariable returned wrong value\n");
> -       /* Append variable 2 */
> +       /* Append variable 2, write to non-existent variable */
>         ret = runtime->set_variable(u"efi_none", &guid_vendor1,
>                                     EFI_VARIABLE_BOOTSERVICE_ACCESS |
>                                     EFI_VARIABLE_APPEND_WRITE,
>                                     15, v);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("SetVariable(APPEND_WRITE) with valid size and data to non-existent variable must be succcessful\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       len = EFI_ST_MAX_DATA_SIZE;
> +       ret = runtime->get_variable(u"efi_none", &guid_vendor1,
> +                                   &attr, &len, data);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("GetVariable failed\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       if (len != 15)
> +               efi_st_todo("GetVariable returned wrong length %u\n",
> +                           (unsigned int)len);
> +       if (memcmp(data, v, len))
> +               efi_st_todo("GetVariable returned wrong value\n");
> +       /* Delete variable efi_none */
> +       ret = runtime->set_variable(u"efi_none", &guid_vendor1,
> +                                   0, 0, NULL);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("SetVariable failed\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       len = EFI_ST_MAX_DATA_SIZE;
> +       ret = runtime->get_variable(u"efi_none", &guid_vendor1,
> +                                   &attr, &len, data);
>         if (ret != EFI_NOT_FOUND) {
> -               efi_st_error("SetVariable(APPEND_WRITE) with size 0 to non-existent variable returns wrong code\n");
> +               efi_st_error("Variable was not deleted\n");
>                 return EFI_ST_FAILURE;

This used to fail as well [0]. Does it work now?

>         }
>         /* Enumerate variables */
> --
> 2.34.1
>

[0] https://lore.kernel.org/u-boot/CAC_iWjL2G2mvQb6WNGLTxr+xj64xrYuOKr8G3-3z8Lv7yX5XSg@mail.gmail.com/

Regards
/Ilias
