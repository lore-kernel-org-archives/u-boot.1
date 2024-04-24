Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CA9C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 07:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF19788DBB;
	Wed, 24 Apr 2024 09:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="obJ7JOWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A3188DDC; Wed, 24 Apr 2024 09:40:50 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D8D884BC
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 09:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso52990811fa.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713944447; x=1714549247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9i5OfWtMS3zQ44SUYe5cXA5S40Z+xA02xBSHT/55yFQ=;
 b=obJ7JOWyfhpLemNrdYo2ZCbyDx8KnFm9U4WhzSgQxlW3eCX9+6+74opx9wIuXrQ9ck
 3oWE641/CheX9BtcER732hO6z0Ij+KZgCz9BfiP2B0aLM5lOOjEYPpTmk1pU4cxaLwEd
 cJxhRomEztEpF3V1UlsGwBRKhOIthgJgkA4HkAgHJIl0gdVs0kevea4EEkFLrf389pfj
 jOi+8L69ykOYP5Udyi11daXqQykLBWklemBxi/DtZMFvRes8RpiTjImncquXHXMZjgwC
 VT50NdA0ruW8V056rBm1EHESyHg1nqurkJFYIVNh2eQqC4Jk7ywL8m0+xdkdz5cA0/wo
 X3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713944447; x=1714549247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9i5OfWtMS3zQ44SUYe5cXA5S40Z+xA02xBSHT/55yFQ=;
 b=AL/WoDg2Zrsa3TL7miQyBcGfgM1xwnysklpwKCVv6bwfFPhhOQz3kcY8Ubs7lfJE5I
 Oi3Tzbi8LWo72DA0wuW5kRKMwuDoSIH9h7CgqGDf5vp3YFRb1AQqCgdgtHs0kmsJAxpZ
 xsGiSnk2rBUVIZ6SRsPm7Xa1ui9pcgoCydaLKX2uRI5wUfaWpYbXzGidgTlSB3Qiea+X
 PZ/gj/kqlzy5ZjoupJTTVAanJRMARfkIW3Cfg/D/RzZUFx3J1CREZ0LdKI9XwzVrylfR
 EHIhRMKsNEh6yuo/LZwlrDR5pylnqhT0b9Bd8QqCUWZpv5C9B3bYs+nMmIr6qZR09Com
 XZPw==
X-Gm-Message-State: AOJu0YwhbWqI8XAvv7bfNdGDTmA87oTXSu470PJiYT/GFnXp5D9MEO2b
 F+h4oB/8A6yU23XrnVzIR0PK8/LZ1QiWdQfXmsBc7R/oe6l0TezwXp0oFh2r6qkL/k2UA/JqaYh
 aMsj7L4W/YSGw/0P3zco27ik/LUkd3qWvA/esQUTB0/ZpiaHi5n4=
X-Google-Smtp-Source: AGHT+IEkxQ6tLOaxcaF8qPlzFkhejwnj111Nl+Ga8VzzN05SPmN9dylc1/M4fonedBHyEC6pWXrwc66/UG+vTzlZd0o=
X-Received: by 2002:a2e:7801:0:b0:2de:48ef:c3df with SMTP id
 t1-20020a2e7801000000b002de48efc3dfmr1132673ljc.9.1713944447363; Wed, 24 Apr
 2024 00:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240424050351.318724-1-ilias.apalodimas@linaro.org>
 <20240424050351.318724-2-ilias.apalodimas@linaro.org>
 <81eb4c85-fd83-43ab-ad23-849bf61f7f8e@gmx.de>
In-Reply-To: <81eb4c85-fd83-43ab-ad23-849bf61f7f8e@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Apr 2024 10:40:10 +0300
Message-ID: <CAC_iWj+kCW2L7+zHvzTmYWPOZgvEZt=ZjPxoOGdYwV11VJvbfw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_selftest: add tests for QueryVariableInfo at
 runtime
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

On Wed, 24 Apr 2024 at 10:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 24.04.24 07:03, Ilias Apalodimas wrote:
> > Since we support QueryVariableInfo at runtime now add the relevant
> > tests. Since we want those to be reusable at bootime, add them
> > in a separate file
> >
> > Add tests for
> > - Test QueryVariableInfo returns EFI_SUCCESS
> > - Test null pointers for the function arguments
> > - Test invalid combination of attributes
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   include/efi_selftest.h                        |   9 ++
> >   lib/efi_selftest/Makefile                     |   1 +
> >   .../efi_selftest_variables_common.c           | 102 ++++++++++++++++++
> >   .../efi_selftest_variables_runtime.c          |  10 +-
> >   4 files changed, 118 insertions(+), 4 deletions(-)
> >   create mode 100644 lib/efi_selftest/efi_selftest_variables_common.c
> >
> > diff --git a/include/efi_selftest.h b/include/efi_selftest.h
> > index 5bcebb368287..ca7ae948663e 100644
> > --- a/include/efi_selftest.h
> > +++ b/include/efi_selftest.h
> > @@ -147,6 +147,15 @@ void *efi_st_get_config_table(const efi_guid_t *guid);
> >    */
> >   u16 efi_st_get_key(void);
> >
> > +/**
> > + * efi_st_query_variable_common - Common variable tests for boottime/runtime
> > + *
> > + * @runtime: Pointer to services table
> > + *
> > + * Return:   EFI_ST_SUCCESS/FAILURE
> > + */
> > +int efi_st_query_variable_common(struct efi_runtime_services *runtime);
> > +
> >   /**
> >    * struct efi_unit_test - EFI unit test
> >    *
> > diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> > index e4d75420bff6..414701893f65 100644
> > --- a/lib/efi_selftest/Makefile
> > +++ b/lib/efi_selftest/Makefile
> > @@ -45,6 +45,7 @@ efi_selftest_textinputex.o \
> >   efi_selftest_textoutput.o \
> >   efi_selftest_tpl.o \
> >   efi_selftest_util.o \
> > +efi_selftest_variables_common.o \
> >   efi_selftest_variables.o \
> >   efi_selftest_variables_runtime.o \
> >   efi_selftest_watchdog.o
> > diff --git a/lib/efi_selftest/efi_selftest_variables_common.c b/lib/efi_selftest/efi_selftest_variables_common.c
> > new file mode 100644
> > index 000000000000..36bdfe6ff9c3
> > --- /dev/null
> > +++ b/lib/efi_selftest/efi_selftest_variables_common.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * efi_selftest_variables_runtime
> > + *
> > + * Copyright (c) 2024 Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > + *
> > + * This unit test checks common service across boottime/runtime
> > + */
> > +
> > +#include <efi_selftest.h>
> > +
> > +#define EFI_INVALID_ATTR BIT(30)
> > +
> > +int efi_st_query_variable_common(struct efi_runtime_services *runtime)
> > +{
>
> EDK2's VariableServiceQueryVariableInfo() in
> MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c has different
> attribute requirements at runtime than at boot services time.
>
> I guess QueryVariables() should return EFI_INVALID_PARAMETER whenever
> SetVariables() does.

I think that's an easy fix. We can still keep a common file, but also
pass the attributes as a function argument depending on
bootime/runtime

I'll send a v2.

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> Best regards
>
> Heinrich
>
> > +     efi_status_t ret;
> > +     u64 max_storage, rem_storage, max_size;
> > +
> > +     ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> > +                                        &max_storage, &rem_storage,
> > +                                        &max_size);
> > +     if (ret != EFI_SUCCESS) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> > +                                        NULL, &rem_storage,
> > +                                        &max_size);
> > +     if (ret != EFI_INVALID_PARAMETER) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> > +                                        &max_storage, NULL,
> > +                                        &max_size);
> > +     if (ret != EFI_INVALID_PARAMETER) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> > +                                        &max_storage, &rem_storage,
> > +                                        NULL);
> > +     if (ret != EFI_INVALID_PARAMETER) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     ret = runtime->query_variable_info(0, &max_storage, &rem_storage,
> > +                                        &max_size);
> > +     if (ret != EFI_INVALID_PARAMETER) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     ret = runtime->query_variable_info(EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
> > +                                        EFI_VARIABLE_NON_VOLATILE,
> > +                                        &max_storage, &rem_storage,
> > +                                        &max_size);
> > +     if (ret != EFI_UNSUPPORTED) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     /* Use an attribute bit not described in the EFI spec */
> > +     ret = runtime->query_variable_info(EFI_INVALID_ATTR, &max_storage,
> > +                                        &rem_storage, &max_size);
> > +     if (ret != EFI_UNSUPPORTED) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     ret = runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS, &max_storage, &rem_storage,
> > +                                        &max_size);
> > +     if (ret != EFI_INVALID_PARAMETER) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     ret = runtime->query_variable_info(EFI_VARIABLE_NON_VOLATILE, &max_storage, &rem_storage,
> > +                                        &max_size);
> > +     if (ret != EFI_INVALID_PARAMETER) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     /*
> > +      * Use a mix existing/non-existing attribute bits from the
> > +      * UEFI spec
> > +      */
> > +     ret = runtime->query_variable_info(EFI_INVALID_ATTR | EFI_VARIABLE_NON_VOLATILE,
> > +                                        &max_storage, &rem_storage,
> > +                                        &max_size);
> > +     if (ret != EFI_INVALID_PARAMETER) {
> > +             efi_st_error("QueryVariableInfo failed\n");
> > +             return EFI_ST_FAILURE;
> > +     }
> > +
> > +     return EFI_ST_SUCCESS;
> > +}
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > index 5794a7b2d405..6cb86771fe78 100644
> > --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> > +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -55,18 +55,20 @@ static int execute(void)
> >       u16 varname[EFI_ST_MAX_VARNAME_SIZE];
> >       efi_guid_t guid;
> >       u64 max_storage, rem_storage, max_size;
> > +     int test_ret;
> >
> >       memset(v2, 0x1, sizeof(v2));
> > -     ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> > -                                        &max_storage, &rem_storage,
> > -                                        &max_size);
> >
> >       if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
> > -             if (ret != EFI_SUCCESS) {
> > +             test_ret = efi_st_query_variable_common(runtime);
> > +             if (test_ret != EFI_ST_SUCCESS) {
> >                       efi_st_error("QueryVariableInfo failed\n");
> >                       return EFI_ST_FAILURE;
> >               }
> >       } else {
> > +             ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> > +                                        &max_storage, &rem_storage,
> > +                                        &max_size);
> >               if (ret != EFI_UNSUPPORTED) {
> >                       efi_st_error("QueryVariableInfo failed\n");
> >                       return EFI_ST_FAILURE;
>
