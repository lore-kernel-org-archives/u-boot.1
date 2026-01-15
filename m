Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4874D29FFA
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 07:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF71383015;
	Thu, 15 Jan 2026 08:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HOlHrxwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611A6835B3; Thu, 15 Jan 2026 08:56:16 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB52C82C7F
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-646b8d2431dso477930d50.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 23:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768463773; x=1769068573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Dbq1ikjxQmDUykAM69q4PKw+JaBkbvFAwmNt421vvg=;
 b=HOlHrxwTEbKsQ6+xq5hKTnfCisptPxBYau1XhuwtyC9uczGiyX253H3us8Yc15SyWz
 DBG6X6gpWQ5WhP3K1Hp+Tqd4niw3sKxD892+JkSg6jSs4KxhYOcQxieQcAGr/lPllE+o
 CdoaOb0FQ8J54BCJy96PaNRwNC04r5MFbZQd5y10CHG2xh8CSgT//hnBIve8OWpH9U04
 ArSzdx0LO5O0L4lRyRkrg14qX7WAq7QwOnjPH7A202NOnkq/8S6OO2k9CjyaazO0eEBD
 am5xM5PgPWQvbZvTXqkqPONJSttVKfUnA0fKMd7IKt8gUMedIL6tIVJzrFz7bSOnj8o6
 cVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768463773; x=1769068573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Dbq1ikjxQmDUykAM69q4PKw+JaBkbvFAwmNt421vvg=;
 b=vIMAUWrzSKuTfJ3SS7JuXlBtdwNCYphYylpZl248vLAQCC7b7kl6D2/I4i0K0VjKpQ
 KMdciSutM8Hw7VDBoMKchn8Sxb41DR+kRzHK49aBjW2uzlr8RUaIiXCBFTL7hmVZODtv
 xLAPGUbgE7ol92mD+jNVlvh8czq/iCXBmjHyNMahRNYxzlUQJ2J5mURtZgD6l21F6wyf
 RzB0r9YmbwYdrptA1YZNl+vPtg9UaJuvmaYfxHBDfDB++EdJ16CCevwk5pVkZ5hTXaLJ
 fQwAl4WZyuKQdC9Mwe9mjwvhYFFpv9wr3MN57R5zV/f7UG6jwGOoCm0dvYeaAA8ZsKiw
 Zv4Q==
X-Gm-Message-State: AOJu0YxRUDYWE3N3MVX17SQ3Tgde5Rfmt8rQIVrb9d2ikqqXftH/FmzC
 T1qou1AZJmfdR8uyu3M9CXUwf82TeBgdp/lLwOtW+zRziXixHEo1m/Oy/tg6Nt4SRTWzaVcy1W3
 LuUhWaBMvWCiq1T6FbflNd3DHkEOeOhIFN+EDAa+WAQ==
X-Gm-Gg: AY/fxX5P97MxrjI2orQlJUi27KAXWzOHZ6Hxe0vAinpY9amavjoG1T1/ZQNZlX5GMjc
 F8tGHYIyxlnnSBIiopHNpdaCg98H6jAViqmdYFODDcFoSPJ45UG3mL+h7fFJASr6GgQFlyNtbSa
 rpJJCE8YUALOZhCAA8mccbPnkk5DToDvA6UMabFLUGvfB9eLbkNnzTT2a2PE/haC4tF4NGmXOa6
 5zz1Q0JmNoTaS1WMYwM/Jpg+UJIIHnCzdWNYEMKEsMSbxCkb9LglD9vJIXrITe5h3k5Qw96S3z9
 T9K0ktxV8ZojWdDBUAufAGC7uUmSlRC91mdmaDvIeiTfc/R1e+FQwUWLe+d3Y36DWi56JwsuSsT
 1HG2uQ3Pi9YJUK3dJ9caxfF0yUx4Q1TgfuTUWqiJo8Z0nkwRSd6C5cNhIcHJx1FtOA4wgIY+BSb
 8YQzloMXD7ilD/YptxW+ijbaIaBJy/PDJXeLchEXJuHBXZAyljNTQdSa2SeQjNmJk6AfbQnZzlt
 G39yqNuCjFAQzuub7SjI5wl0l7vjn7POhnoiDVNaavynIKmzXR9OaYECmqmzm8FAno1gJTfrQUC
 cDvpWMH30Yf28hha8/9D/y4QIyVkT5WV
X-Received: by 2002:a05:690e:4186:b0:649:3b9:9257 with SMTP id
 956f58d0204a3-64903b99457mr3562554d50.1.1768463772695; Wed, 14 Jan 2026
 23:56:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
In-Reply-To: <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 15 Jan 2026 09:55:36 +0200
X-Gm-Features: AZwV_QgFOub3kuAmzSeL__OMryQdbP_j913MJgIsif97hwH7khMNccnCAnKhAxo
Message-ID: <CAC_iWj+_VfEAE3NRr9QxJHtR0oq3JdqrO3vj583TxBDetH6QkA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>, 
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
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

Hi Michal

Thanks for taking the time.

[...]

> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index be670a8e7c25..feab212b245b 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 ret = EFI_SUCCESS;
>
>         /*
> -        * Write non-volatile EFI variables to file
> +        * Write non-volatile EFI variables to file or SPI Flash
>          * TODO: check if a value change has occured to avoid superfluous writes
>          */
>         if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
>                 efi_var_write();
>  #else
>                 return EFI_NOT_READY;
> @@ -599,7 +599,7 @@ efi_status_t efi_init_variables(void)
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)

So I think this is might to come back and bite us in the future.
The name of the file is a bit misleading, but efi_variable.c is
supposed to handle the variables with a file backed storage and
efi_variable_tee.c is handling the variables when the storage is
isolated in the secure world.
The problem is that each case defines the boottime and runtime
services. The functions that are common across cases live in
efi_var_common.c. That files defines the boottime and runtime calls,
by calling the *_int() variants.

The file backed and SPI flash storage seem to have a lot in common.
e.g they both use the memory backend to expose the vairables the the
OS, query the available storage etc. But I am not they will end up
being 100% identical. If they do this approach is ok. But ifthey don't
it's better to expand the efi_var_sf.c you added and add code for
efi_variables_boot_exit_notify(), and any *_int() functions that are
different.

Heinrich any opinions? I'll need to think through the SPI case
inclduing runtime support before taking this in

Thanks
/Ilias

>         ret = efi_var_read();
>         if (ret != EFI_SUCCESS)
>                 return ret;
> --
> 2.43.0
>
