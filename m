Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE68C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 10:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE1788D52;
	Thu, 25 Apr 2024 12:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SGWe5hQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C9188DC3; Thu, 25 Apr 2024 12:26:09 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4EB88CF5
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 12:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5171a529224so970854e87.0
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714040766; x=1714645566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HKfKMbLEU3ox3SbmHO9D/solmFAPovxUYQYx0m2Y+YY=;
 b=SGWe5hQP47kvW2VdkN1ig79uDzvy5JM/oPcON3lUTqAhhgnXvfWtANawZVW8KeuA1u
 3n87qyH3cw7iEbzGGahmwn6PCmqRJuQCisdppK4KJQpKr85ghF4SuuPj5dCz3Iy4P72o
 FSX0spj+sQ3VxvCgpJ2YA0QfWfOYwqkTlPOaRO4DP6HS1Igfq5bMQ+QU8AqZulXIT/2c
 ULeAdMtUTkAuJfjUjwOowSFoI3PZ99IO6cKOmReD2mGd3AtWZ6T0XPw7ZdhjE/1ZlmBh
 3unWkIdI81E/6d4Dh5k020KhLH0RYfalg/hwEMW0hOHNZgOoNCWbGrjQRyWYS3njCEEo
 iZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714040766; x=1714645566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKfKMbLEU3ox3SbmHO9D/solmFAPovxUYQYx0m2Y+YY=;
 b=YhSPw+M/m+9UJkwfTsqT7jlSC/PborPdfskQqAlkpF0nAvDtGuGi2B5ZGv2K8p9xG2
 mb7niai9qQUohypj3UvLWnpSlF38ZGHPRSWrhnxwXWlKKouNhSgxYNYFt6sU+uZRIWSB
 XWmSsKhy5Tg95DbQ8CXaNi3qzmj7oHsvuphv0yQaUaE93IjmiZhPXanUZui5QVmublTT
 RG8xOSbErkRJgnQUfsZ2z6aUNGfy6LfXXrx73Jn3gex9QDLUw7hqJ823Rm/VPKOZw8AO
 adZaZwtozOg0yZKBldLwydhsUlgszGudjcJDy+zRUqtvNCFFWvTGA7vRkY3AbBGjuW75
 i1dg==
X-Gm-Message-State: AOJu0Yy4n9KB9W6lXm8tkbM/QiBPQGXV8lygymSEXegQnaKSrpzX7FqC
 vbiIoHwnfROSMlYqm5i5viwP8KXofPS/eP3VKZ+nWM0oHtcSjxaflIB9kggpQL2k9ch/76TjSjB
 ais/p8a2wcASRT1ENMpvEVIyJRYI8W0eOd8Xdfw==
X-Google-Smtp-Source: AGHT+IGdnzqLfX7KyJ5NbRPYcm4qB5JGOWtgP0wqhUG6GSOaBH0f7hTZ89D9QKxmihGevftfg8l8wxmm2pOC9/4DHEs=
X-Received: by 2002:a05:6512:2ed:b0:51b:3493:81ce with SMTP id
 m13-20020a05651202ed00b0051b349381cemr3174028lfq.40.1714040766255; Thu, 25
 Apr 2024 03:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240425051821.338842-1-ilias.apalodimas@linaro.org>
 <334d2ff7-5012-40b9-8542-3d77427b5774@gmx.de>
In-Reply-To: <334d2ff7-5012-40b9-8542-3d77427b5774@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Apr 2024 13:25:29 +0300
Message-ID: <CAC_iWjLjrwN0Q8oHCCEy7WFpY8ySB3JuxfQSCGYSAk3xB_HmBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] efi_loader: enable QueryVariableInfo at runtime
 for file backed variables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Heinrich,

On Thu, 25 Apr 2024 at 11:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.04.24 07:18, Ilias Apalodimas wrote:
> > Since commit c28d32f946f0 ("efi_loader: conditionally enable SetvariableRT")
> > we are enabling the last bits of missing runtime services.
> > Add support for QueryVariableInfo which we already support at boottime
> > and we just need to mark some fucntions available at runtime and move
> > some checks around.
> >
> > It's worth noting that pointer checks for maxmimum and remaining
> > variable storage aren't when we store variables on the RPMB, since the
> > Secure World backend is already performing them.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since v1:
> > - require EFI_VARIABLE_RUNTIME_ACCESS to be set at runtime
> > - return EFI_UNSUPPORTED for auth variables
> >   lib/efi_loader/efi_runtime.c                  |  4 +++
> >   lib/efi_loader/efi_var_common.c               |  6 -----
> >   lib/efi_loader/efi_variable.c                 | 25 ++++++++++++++-----
> >   lib/efi_loader/efi_variable_tee.c             |  5 ++++
> >   .../efi_selftest_variables_runtime.c          | 14 ++++++++---
> >   5 files changed, 39 insertions(+), 15 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> > index 73831c527e00..011bcd04836d 100644
> > --- a/lib/efi_loader/efi_runtime.c
> > +++ b/lib/efi_loader/efi_runtime.c
> > @@ -129,6 +129,10 @@ efi_status_t efi_init_runtime_supported(void)
> >                               EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
> >                               EFI_RT_SUPPORTED_CONVERT_POINTER;
> >
> > +     if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE))
> > +             rt_table->runtime_services_supported |=
> > +                     EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO;
> > +
> >       if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> >               u8 s = 0;
> >
> > diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> > index 961139f005af..ea8d2a4cf98c 100644
> > --- a/lib/efi_loader/efi_var_common.c
> > +++ b/lib/efi_loader/efi_var_common.c
> > @@ -1,4 +1,3 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> >   /*
> >    * UEFI runtime variable services
> >    *
> > @@ -163,11 +162,6 @@ efi_status_t EFIAPI efi_query_variable_info(
> >       EFI_ENTRY("%x %p %p %p", attributes, maximum_variable_storage_size,
> >                 remaining_variable_storage_size, maximum_variable_size);
> >
> > -     if (!maximum_variable_storage_size ||
> > -         !remaining_variable_storage_size ||
> > -         !maximum_variable_size)
> > -             return EFI_EXIT(EFI_INVALID_PARAMETER);
> > -
> >       ret = efi_query_variable_info_int(attributes,
> >                                         maximum_variable_storage_size,
> >                                         remaining_variable_storage_size,
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index 0cbed53d1dbf..1cc02acb3b26 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -406,12 +406,15 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >       return EFI_SUCCESS;
> >   }
> >
> > -efi_status_t efi_query_variable_info_int(u32 attributes,
> > -                                      u64 *maximum_variable_storage_size,
> > -                                      u64 *remaining_variable_storage_size,
> > -                                      u64 *maximum_variable_size)
> > +efi_status_t __efi_runtime
> > +efi_query_variable_info_int(u32 attributes,
> > +                         u64 *maximum_variable_storage_size,
> > +                         u64 *remaining_variable_storage_size,
> > +                         u64 *maximum_variable_size)
> >   {
> > -     if (attributes == 0)
> > +     if (!maximum_variable_storage_size ||
> > +         !remaining_variable_storage_size ||
> > +         !maximum_variable_size || !attributes)
> >               return EFI_INVALID_PARAMETER;
> >
> >       /* EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS is deprecated */
> > @@ -460,7 +463,17 @@ static efi_status_t __efi_runtime EFIAPI efi_query_variable_info_runtime(
> >                       u64 *remaining_variable_storage_size,
> >                       u64 *maximum_variable_size)
> >   {
> > -     return EFI_UNSUPPORTED;
>
> According to the UEFI 2.10 specification EFI_UNSUPPORTED must be returned if
>
> "The attribute is not supported on this platform, and the
> MaximumVariableStorageSize, RemainingVariableStorageSize,
> MaximumVariableSize are undefined."
>
> I wonder if in the spec the 'and' should be replaced by 'or'.

Probably 'or'

>
> I guess we should return EFI_UNSUPPORTED if
> CONFIG_EFI_VARIABLE_RUNTIME_ACCESS=n and change the corresponding test
> accordingly. This check should be placed first.

The spec isn't clear indeed, but looking at the flags usually passed
in QueyVariable, there's nothing that checks for SetVariable at
runtime -- which isn't even an attr, it's a property of the RT_PROP
table.
We do return EFI_UNSUPPORTED for authenticated variables, which we
can't reliably support (and auth variables have their own attr).
I would prefer merging this with the existing checks and in the future
(perhaps the next stable release) make CONFIG_EFI_RT_VOLATILE_STORE=y
by default or get rid of the config options entirely once the
userspace tools are mature enough to support it.

In any case, I don't have a strong opinion, I am fine with both. Just
tell me what you prefer.

Regards
/Ilias

>
> Best regards
>
> Heinrich
>
> > +     if (!(attributes & EFI_VARIABLE_RUNTIME_ACCESS))
> > +             return EFI_INVALID_PARAMETER;
> > +     if ((attributes & (EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
> > +                        EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS |
> > +                        EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS)))
> > +             return EFI_UNSUPPORTED;
> > +
> > +     return efi_query_variable_info_int(attributes,
> > +                                        maximum_variable_storage_size,
> > +                                        remaining_variable_storage_size,
> > +                                        maximum_variable_size);
> >   }
> >
> >   /**
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > index 4f1aa298da13..8b6b0a390869 100644
> > --- a/lib/efi_loader/efi_variable_tee.c
> > +++ b/lib/efi_loader/efi_variable_tee.c
> > @@ -873,6 +873,11 @@ efi_status_t efi_query_variable_info_int(u32 attributes,
> >       efi_status_t ret;
> >       u8 *comm_buf;
> >
> > +     if (!max_variable_storage_size ||
> > +         !remain_variable_storage_size ||
> > +         !max_variable_size || !attributes)
> > +             return EFI_INVALID_PARAMETER;
> > +
> >       payload_size = sizeof(*mm_query_info);
> >       comm_buf = setup_mm_hdr((void **)&mm_query_info, payload_size,
> >                               SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > index afa91be62c85..5794a7b2d405 100644
> > --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> > +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -60,9 +60,17 @@ static int execute(void)
> >       ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> >                                          &max_storage, &rem_storage,
> >                                          &max_size);
> > -     if (ret != EFI_UNSUPPORTED) {
> > -             efi_st_error("QueryVariableInfo failed\n");
> > -             return EFI_ST_FAILURE;
> > +
> > +     if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("QueryVariableInfo failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +     } else {
> > +             if (ret != EFI_UNSUPPORTED) {
> > +                     efi_st_error("QueryVariableInfo failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> >       }
> >
> >       ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > --
> > 2.40.1
> >
>
