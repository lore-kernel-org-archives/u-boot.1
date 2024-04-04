Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130F7CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C6D88164;
	Thu,  4 Apr 2024 09:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZVdk0UIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C6288235; Thu,  4 Apr 2024 09:36:31 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9247F88044
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d68cf90ec4so8410261fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712216187; x=1712820987; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N9JIN/eiBd2SJwJumOU92DnI2L08i89ib8txoVLS1sY=;
 b=ZVdk0UIVjuZDbZhCzPtVp6tIH2JPvLvrVzKywTIGKLz7ubsXrHd+YJvaEdf7Fmg+Mn
 bKEYtliAVjhROC02oR4g+P/F2wNgHWzuvyx/8gmwaubGCqdzCYe0mjtwHWK12dCzPsCg
 ZUVVC9wKc+HKjcx2ipXOcWDEIOOXUr2UzPwnAjkg8Wnrj0bg/QPhLqUbSZnOEw9jbsSZ
 8HcCCWacVx/rIRwj3ReP5IiPX9H/DfDKf2FMr3+VfsaOtn5Ht4EWUtazoExSb3MVxKMW
 ek9OziUVV2EW86YK+uXb3OpRRINIKAI6+PWfObxKKc7fFwKnbGU/ruRoQ2djWx2x4Q8H
 3nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712216187; x=1712820987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N9JIN/eiBd2SJwJumOU92DnI2L08i89ib8txoVLS1sY=;
 b=mKEmjIXMuqy9x+9nt9kj5uNHjbEhxuQSZ4V6e+Uk30RyYboKX+Ft8V13XaDW71qwGf
 6agX/at1P7IJS8wPQdo/4xXD+5Eu1QahbAPmXww/D3az7UBwWqZkxgid+xnK9FT6AJPH
 T4EGbrteHvjlLSUT9/knumoPp2Uw6IRFmArjAdsEobTTsxlrxJV+jDvzpbXc8Czb/l0t
 SIRdgaZHWdAh6iyEb4d420E4aBn+JOxeUp22BKBMf0H04MU3IMVcihUNTvIOSZKk6sD+
 iScr2vT3qSZGALpj2o3ZT85PyWnW1as6KdJekFKIytgTG0tTAT6Y1LND5K8rkaELN5A8
 V5sw==
X-Gm-Message-State: AOJu0YzQXH7MkgB1XRKBi7OkTra0NwPmqR1n4AJmkUZtVfaiIet64onC
 hwA1iUf3zuETKPfedk4ryt3O7XyuyQeBnjAUJ9YFX3/+e4dKt7kFYxYDxVgZn7JknOYxVhuEjtr
 p5PZMLGWsHZtCiy7X/ECA+1LyUGZU60p9wDmA2qTQHwVjxDXFH/4=
X-Google-Smtp-Source: AGHT+IF6bJCOYLSrO/aZsRNbbK5LyOL2yg+Jw4vacteuiJWbmX4eDXdaJ71qWck+PvFwUxUp28WBt34ayts+/BbLV0o=
X-Received: by 2002:a2e:9058:0:b0:2d8:2d48:18f7 with SMTP id
 n24-20020a2e9058000000b002d82d4818f7mr1250193ljg.9.1712216187267; Thu, 04 Apr
 2024 00:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240402090950.3819705-1-kojima.masahisa@socionext.com>
In-Reply-To: <20240402090950.3819705-1-kojima.masahisa@socionext.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 10:35:51 +0300
Message-ID: <CAC_iWjLtDjj1GXK5GaOfG90hRHk_n9R0Uy89q=7eRykjX1Gu3w@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: fix append write behavior to non-existent
 variable
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

On Tue, 2 Apr 2024 at 12:09, Masahisa Kojima
<kojima.masahisa@socionext.com> wrote:
>
> Current "variables" efi_selftest result is inconsistent
> between the U-Boot file storage and the tee-based StandaloneMM
> RPMB secure storage.
>
> U-Boot file storage implementation does not accept SetVariale
> call to non-existent variable with EFI_VARIABLE_APPEND_WRITE,
> it return EFI_NOT_FOUND.
> However it is accepted and new variable is created in EDK II
> StandaloneMM implementation if valid data and size are specified.
> If data size is 0, EFI_SUCCESS is returned.
>
> Since UEFI specification does not clearly describe the behavior
> of the append write to non-existent variable, let's update
> the U-Boot file storage implementation to get aligned with
> the EDK II reference implementation.
>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> ---
> v1 -> v2
> - return EFI_SUCCESS for append write with data size 0
> - add comment that we follow the EDK II implementation
>
>  lib/efi_loader/efi_variable.c             | 26 +++++++++---
>  lib/efi_selftest/efi_selftest_variables.c | 48 ++++++++++++++++++++++-
>  2 files changed, 66 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 40f7a0fb10..d1db7ade0a 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -282,11 +282,21 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 }
>                 time = var->time;
>         } else {
> -               if (delete || append)
> -                       /*
> -                        * Trying to delete or to update a non-existent
> -                        * variable.
> -                        */
> +               /*
> +                * UEFI specification does not clearly describe the expected
> +                * behavior of append write with data size 0, we follow
> +                * the EDK II reference implementation.
> +                */
> +               if (append && !data_size)
> +                       return EFI_SUCCESS;
> +
> +               /*
> +                * EFI_VARIABLE_APPEND_WRITE to non-existent variable is accepted
> +                * and new variable is created in EDK II reference implementation.
> +                * We follow it and only check the deletion here.
> +                */
> +               if (delete)
> +                       /* Trying to delete a non-existent variable. */
>                         return EFI_NOT_FOUND;
>         }
>
> @@ -329,7 +339,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
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
> index c7a3fdbaa6..39ad03a090 100644
> --- a/lib/efi_selftest/efi_selftest_variables.c
> +++ b/lib/efi_selftest/efi_selftest_variables.c
> @@ -131,13 +131,57 @@ static int execute(void)
>                             (unsigned int)len);
>         if (memcmp(data, v, len))
>                 efi_st_todo("GetVariable returned wrong value\n");
> -       /* Append variable 2 */
> +
> +       /* Append variable 2, write to non-existent variable with datasize=0 */
> +       ret = runtime->set_variable(u"efi_none", &guid_vendor1,
> +                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                                   EFI_VARIABLE_APPEND_WRITE,
> +                                   0, v);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error(
> +                       "SetVariable(APPEND_WRITE) with size 0 to non-existent variable returns wrong code\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       len = EFI_ST_MAX_DATA_SIZE;
> +       ret = runtime->get_variable(u"efi_none", &guid_vendor1,
> +                                   &attr, &len, data);
> +       if (ret != EFI_NOT_FOUND) {
> +               efi_st_error("Variable must not be created\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       /* Append variable 2, write to non-existent variable with valid data size*/
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
>         }
>         /* Enumerate variables */
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
