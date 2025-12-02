Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA46BCFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 12:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C94583E62;
	Tue,  2 Dec 2025 13:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cDbzf4z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCACC83E72; Tue,  2 Dec 2025 13:44:24 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D2583CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 13:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-786635a8ce4so39271567b3.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 04:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764679461; x=1765284261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JAphqL8uMcUO0iMQcm8nG6kqv5LlCRwN0MDTamdHRAE=;
 b=cDbzf4z0zZHls+Ucena90SYE14WXMldLMqo1K2ZxnCUzqSE78PYP4ltPUg1c4VnL+o
 YOp9nyxN5PnSB4kwwxb6lAyOdZn4hdrLyWfk0q7mq/vmMVMK7Z6vpl0uBHFVOXGabPQR
 TevaLyjMHQsKdASOpxt989w8RhJqldNpd0oEZf0sUgxOs+aZW6/8ynzw07FNOobtLd+0
 jlBlWWuX0MJQUcPJw2x0/V0KpDoxap0I0v7eEAvvNBbUIXPE7dADqP9GRRIaUJYrSfLL
 Zrr/kW9SFi1hhW3pioWwFMykJA43NG+MC2jJNUHPSiZ4PwXfuOg3fxHMBsVtuzGP6ENS
 CGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764679461; x=1765284261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAphqL8uMcUO0iMQcm8nG6kqv5LlCRwN0MDTamdHRAE=;
 b=QOxzUB8SHFvuHkXltAJssmPFuPriV2YbGN+CRySRU48bW6ByDM62Cl8YWAkrirTLVd
 cNlP/dXWaMVzaudXmdTiXiA8GbUE5TI/7z/oFtrM53CntBnTSaEUzuOIQK/5T2nQyXSr
 7uG41AV2t7GpSZJrEd7YdHecvn/EUjCr29UIXnDFAd4q4M7ckBrwRC5yW10ZlwPQgm7c
 31nWLXNS9loOPQG/qRfq6uEg3mP/IjZ46HFtGT8f9dS3+cydfx57+9+eAJAFyxQybtm/
 PBW0Xk8lwOD7o8Icat/LEhadtuJbes8fc7o8MVHF4bvERuMaSqX0/xVjdFD4/pg+Sv0a
 wR9w==
X-Gm-Message-State: AOJu0YzlWry2f2r/SzOy+lKMwu0kX0Gp8Q3c+cd7FBJZjS2B/711dpNJ
 e5Nc91+QX4OyIvZlRQY0Mn1/PkhAxVIfiNV40EfkDlANrXjbu3KF6rARRQg6pbGgOHLRW6Rsw0/
 2e6qNDUuupfNwf60TAzwu4VTIkCXKtxCQnnEaNafYRw==
X-Gm-Gg: ASbGncuUr/u3LEp6cwYxdMnKIiTITwGKFDR0yQXyEpXBDrzcZFRDP0T2bYFh7lmQKuk
 udT7UtvMU5AGnpI2XT27Do8CwZs1nLrLZtnmX7YDjC/KaB8X86sNm4mhJRExEJ/Y8r8cpXWpmb+
 Eza3sbnUgHzdFRzRToBXjj2Y/pDQ3Li6Y5QWY9xdYAT11s5BB8wMVwZybWpNLO+Gk7ctRpQfCTh
 qrKbsazA6QHmxCejsN33zUQT0lFGd+QRu0udl2dNqzGYo8N+8JBCgIPIp6Kra7JDtBMJZrECHD4
 6y5WeDIJ0esuwc4Zw+hxurVVgy0+xo2ctc8tvXcyTBz21ATDt3YXgbJHQu4825r1cg5XdKz2Akf
 Ijtpq4Qg=
X-Google-Smtp-Source: AGHT+IHRoa0rZo8VOD8ZWEuqSSiE/3i5i6baGMn+QiW/EOex3ShEVIgzmCumVLlKGH32LfcdiAEOtIOgaa+oV2YWR3k=
X-Received: by 2002:a05:690c:4b89:b0:786:5789:57c4 with SMTP id
 00721157ae682-78a8b529c82mr354434087b3.39.1764679460780; Tue, 02 Dec 2025
 04:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
 <20251114093246.56422-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251114093246.56422-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Dec 2025 14:43:44 +0200
X-Gm-Features: AWmQ_bnBS1NPRtVWI6fhLVY7COG1jdXXdTaR67suN8qQSOLtDJn6rl376pe6awQ
Message-ID: <CAC_iWj+9J+N-nj7QL71PFexUuqQmUekMBRRYfotNnv1Zs0FQng@mail.gmail.com>
Subject: Re: [PATCH 5/7] efi_selftest: simplify efi_st_query_variable_common
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 14 Nov 2025 at 11:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use global st_runtime.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  include/efi_selftest.h                        |  4 +-
>  lib/efi_selftest/efi_selftest_variables.c     |  3 +-
>  .../efi_selftest_variables_common.c           | 55 ++++++++-----------
>  .../efi_selftest_variables_runtime.c          |  4 +-
>  4 files changed, 28 insertions(+), 38 deletions(-)
>
> diff --git a/include/efi_selftest.h b/include/efi_selftest.h
> index 4ee46cbbb66..874f8b5efe7 100644
> --- a/include/efi_selftest.h
> +++ b/include/efi_selftest.h
> @@ -151,13 +151,11 @@ u16 efi_st_get_key(void);
>  /**
>   * efi_st_query_variable_common - Common variable tests for boottime/runtime
>   *
> - * @runtime:   Pointer to services table
>   * @attributes: Attributes used
>   *
>   * Return:     EFI_ST_SUCCESS/FAILURE
>   */
> -int efi_st_query_variable_common(struct efi_runtime_services *runtime,
> -                                u32 attributes);
> +int efi_st_query_variable_common(u32 attributes);
>
>  /**
>   * struct efi_unit_test - EFI unit test
> diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
> index 3d5f38c6897..b92c3276b61 100644
> --- a/lib/efi_selftest/efi_selftest_variables.c
> +++ b/lib/efi_selftest/efi_selftest_variables.c
> @@ -53,8 +53,7 @@ static int execute(void)
>         efi_guid_t guid;
>         int test_ret;
>
> -       test_ret = efi_st_query_variable_common(runtime,
> -                                               EFI_VARIABLE_BOOTSERVICE_ACCESS);
> +       test_ret = efi_st_query_variable_common(EFI_VARIABLE_BOOTSERVICE_ACCESS);
>         if (test_ret != EFI_ST_SUCCESS) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
> diff --git a/lib/efi_selftest/efi_selftest_variables_common.c b/lib/efi_selftest/efi_selftest_variables_common.c
> index 453bc8709a6..704da016c6d 100644
> --- a/lib/efi_selftest/efi_selftest_variables_common.c
> +++ b/lib/efi_selftest/efi_selftest_variables_common.c
> @@ -11,15 +11,13 @@
>
>  #define EFI_INVALID_ATTR BIT(30)
>
> -int efi_st_query_variable_common(struct efi_runtime_services *runtime,
> -                                u32 attributes)
> +int efi_st_query_variable_common(u32 attributes)
>  {
>         efi_status_t ret;
>         u64 max_storage, rem_storage, max_size;
>
> -       ret = runtime->query_variable_info(attributes,
> -                                          &max_storage, &rem_storage,
> -                                          &max_size);
> +       ret = st_runtime->query_variable_info(attributes, &max_storage,
> +                                             &rem_storage, &max_size);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
> @@ -28,58 +26,54 @@ int efi_st_query_variable_common(struct efi_runtime_services *runtime,
>                 return EFI_ST_FAILURE;
>         }
>
> -       ret = runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS,
> -                                          &max_storage, &rem_storage,
> -                                          &max_size);
> +       ret = st_runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS,
> +                                             &max_storage, &rem_storage,
> +                                             &max_size);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
>         }
>
> -       ret = runtime->query_variable_info(attributes,
> -                                          NULL, &rem_storage,
> -                                          &max_size);
> +       ret = st_runtime->query_variable_info(attributes, NULL, &rem_storage,
> +                                             &max_size);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
>         }
>
> -       ret = runtime->query_variable_info(attributes,
> -                                          &max_storage, NULL,
> -                                          &max_size);
> +       ret = st_runtime->query_variable_info(attributes, &max_storage, NULL,
> +                                             &max_size);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
>         }
>
> -       ret = runtime->query_variable_info(attributes,
> -                                          &max_storage, &rem_storage,
> -                                          NULL);
> +       ret = st_runtime->query_variable_info(attributes, &max_storage,
> +                                             &rem_storage, NULL);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
>         }
>
> -       ret = runtime->query_variable_info(0, &max_storage, &rem_storage,
> -                                          &max_size);
> +       ret = st_runtime->query_variable_info(0, &max_storage, &rem_storage,
> +                                             &max_size);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
>         }
>
> -       ret = runtime->query_variable_info(attributes |
> -                                          EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
> -                                          EFI_VARIABLE_NON_VOLATILE,
> -                                          &max_storage, &rem_storage,
> -                                          &max_size);
> +       ret = st_runtime->query_variable_info(
> +               attributes | EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
> +                       EFI_VARIABLE_NON_VOLATILE,
> +               &max_storage, &rem_storage, &max_size);
>         if (ret != EFI_UNSUPPORTED) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
>         }
>
> -       ret = runtime->query_variable_info(EFI_VARIABLE_NON_VOLATILE,
> -                                          &max_storage, &rem_storage,
> -                                          &max_size);
> +       ret = st_runtime->query_variable_info(EFI_VARIABLE_NON_VOLATILE,
> +                                             &max_storage, &rem_storage,
> +                                             &max_size);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
> @@ -89,10 +83,9 @@ int efi_st_query_variable_common(struct efi_runtime_services *runtime,
>          * Use a mix existing/non-existing attribute bits from the
>          * UEFI spec
>          */
> -       ret = runtime->query_variable_info(attributes | EFI_INVALID_ATTR |
> -                                          EFI_VARIABLE_NON_VOLATILE,
> -                                          &max_storage, &rem_storage,
> -                                          &max_size);
> +       ret = st_runtime->query_variable_info(
> +               attributes | EFI_INVALID_ATTR | EFI_VARIABLE_NON_VOLATILE,
> +               &max_storage, &rem_storage, &max_size);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("QueryVariableInfo failed\n");
>                 return EFI_ST_FAILURE;
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> index 379c4f9c47b..4be37efc1fc 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -60,8 +60,8 @@ static int execute(void)
>         memset(v2, 0x1, sizeof(v2));
>
>         if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
> -               test_ret = efi_st_query_variable_common(runtime, EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                                                EFI_VARIABLE_RUNTIME_ACCESS);
> +               test_ret = efi_st_query_variable_common(EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                                                       EFI_VARIABLE_RUNTIME_ACCESS);
>                 if (test_ret != EFI_ST_SUCCESS) {
>                         efi_st_error("QueryVariableInfo failed\n");
>                         return EFI_ST_FAILURE;
> --
> 2.51.0
>
