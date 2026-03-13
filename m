Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C1A105F79D
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 11:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B9384221;
	Fri, 13 Mar 2026 12:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cgF7Q41A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55DD084242; Fri, 13 Mar 2026 12:44:34 +0100 (CET)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7CDB83FA4
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 12:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so2628812d50.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 04:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773402270; cv=none;
 d=google.com; s=arc-20240605;
 b=PjUQC+L7vQg6Y8qh7P0Q8JmlK7VceBPJCymRH6n6vAWlFwF8pPoyNVxanNTQYsSYMg
 tSjwBTGuw8AroBYSr1HVa2G4n+tBRWrH2vrkteOcMZUhXrDJsKRod7HoaOT8To4lDCip
 snyxzvnKQkCUbxQ3T1QjfYNPrb+njpNDCdCdudItJ0zoSIegVdo7oW6GgBQsO4niwlXC
 YWNkTF1ZYd2XmFpYydRL4eWr4w47yjsk721ercx52izpGJu0nw9xvs0PaaX8VXlcpGbA
 Kw8aqF7qQ2AhtpLCOWj0KN4gJqOWQgfJvtTzerfHQ5G/wGktE0ggKRsEosQnGqQRlfSZ
 /fiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0kQkMWwT97MbrPVyASqJqtZ6oL59YIqhrfDP3H5S630=;
 fh=HB5wkI7dZ7MxpfLBYSMLx28UP7gaZCTLU3e5kMF7ZPc=;
 b=CLBN+oUQBwameKF7hkXyLz47jpnY+wuxoWEjfC6z7gzoWWStWJLp2rJhFhigB1cFSt
 hCYOSI7War0p6dgDtGaenIcp9pHQ0kbtUHM/6exIKp9THWwOrbRyE5C1obJTZALdC+JU
 D11Ar/DdcOYMPxWX6yzZ1K7wlmwOtlLFIzYVS3kdftOd6Xt7CjV5h6QKKaWbYBnepR4U
 yvxXgQNO1Ar75CkTsOwuB2Zm7WyNZM3QlGIfXYswqtwCFM4ESPZrfOy0fvHbRP2SBohj
 ACZbtMXNoyeYOa2Sf5h5t+nehx/PkNk84BPJ59Uoak2p3JiPgz/q4LJHbr1z3WJCaUel
 SFKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773402270; x=1774007070; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0kQkMWwT97MbrPVyASqJqtZ6oL59YIqhrfDP3H5S630=;
 b=cgF7Q41AQrVn3reAGWryTkpdcf3iukw6mi/cn2gw35/EMwexMFYKIW2lMH4YtoosjU
 ZBKglajphIC+ZH08SbbyH8f8CBDCU/lwaiW7jfnJY+CmZ/R9nh2XReAUIBYjih0LW2ne
 57CsRfkfqOfcAD7/TAYLyEnZpGUg7xqxmMVmJS6UQKPEr923jOEfi7PbKRs907FjQ7vv
 aJduWvqMXkvjX7iAO3MMz7+m6t+bB7/duVh7nzr5OalCoa06lTFnhXswdv9yS+BWMmB0
 Eu6WjIoXcWd9ygkBQOES0JkKjUAiVY6uZ4tS5yS6I3UYctzGyiKdXxakpu1b5pP3ievs
 nL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773402270; x=1774007070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kQkMWwT97MbrPVyASqJqtZ6oL59YIqhrfDP3H5S630=;
 b=A1Wo8AHIupWJxvWv67gsCT/OmA/GUuhtdu3svgDIOj4dgp/AgS21dyhLxhUUQYCuy+
 f5wF6Wn2q5H810tiHHlCLQDDqplSDJIzUi542+YCb4spYdAdxfhdPbGqEkWSnorw4YW4
 d3gNFb39nRZUYbUdExOJSOzh7cWNhxslz6V2VEgKkJg+lOFewARkaVV0F8QCg2/615ns
 HBvcgVTiOh0GjhrvDsu70PXw9qQFYvC3lPcn5ZexvAwPSbZGVLwEleSHglfP2SaAyHd6
 4pTMBjtJAfGk9mzdk4h7SlN59jsw5PwDtf68U18vvSsH5XDdIMde3gOW6WD9vx3Gksqv
 9mVQ==
X-Gm-Message-State: AOJu0Yy0/gVwPXwH0muQAavZ643I+M3FEYLJGVtCgqk2GYOC+vYx2ctR
 IDomYoewBj/L0RJom6sSkYeDMPAx2cDw72vpN+1SX01oZqEKk4aWqmhHzzHy2mODg1DmY7YBLFz
 XNyPqDv6Hy7D7q5+wqBJznoxGoCPWL8ra1bpPqm9uNA==
X-Gm-Gg: ATEYQzzgPzVZPJr2zgT7znrxoRSBfnFwBQ/WqKrTH8h0ZBJi5oTdjTHkoWk/rPWt1+K
 iPHpjTuT5fhtiVJtRMZcw+vXvfL3LFK+oy6/WpNlo3i5Ar+TC0apK6+dmXdh7+po91vSVeQ4yjn
 r4JfN8L59gCfDl/AnXLCLyhHG/RyANiHOl0zcVCdwaPuvBevu2DTEflYFNTXbI3c4MAnglQXNdo
 0+SL3uvdiMdmdtl8vDH7T8bn6bhAMTEL110fT7fyiC9xBu/yD1v+17+17RVS79q+60E9wtmAP00
 Eq0QJI+PXTvhJBsEjRuAFEcHD2ZSE0MYZF9HhcbTTafZvXPVnSgPO3Bnj+qkLnCbUINxjTtghBk
 soAhbU4e1/Oj6wjuti+okn819G1fA2OpBe7J4lls5hfAwPCMSV+WpUGnSqtjcs2VlNC95yl2kD8
 Sj/jRzrZWka4nHMDFswG8NPYV8BswSifyuxVJgZSLHqNpSUba/O+QroWtdWCSa2/cfoYFsMJos+
 NqoZGzc6Hsk1YSx4vHEJ9dzNsljhdQibVMFVr1H8lzuh9DOvbtAyMofUWwNjcqml4XLmu42XHhD
 xK+KY5I9dBGU9JMlByArl4SHCdiwb87mPiv+emGonNp+
X-Received: by 2002:a53:d60a:0:b0:64c:561a:1dff with SMTP id
 956f58d0204a3-64e630887e3mr2271235d50.65.1773402269460; Fri, 13 Mar 2026
 04:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <095f258648b2e0283c671f6fbc95dd9f39f55a8e.1773400835.git.michal.simek@amd.com>
In-Reply-To: <095f258648b2e0283c671f6fbc95dd9f39f55a8e.1773400835.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Mar 2026 13:43:52 +0200
X-Gm-Features: AaiRm536kgPCZR6Ob3Bbx6oJjMDDzrvj4LVymSFgTwjxLFkH2TsxbtJD39Du210
Message-ID: <CAC_iWj+pQv1pma2H7chVk735928VKjXUinPqxH4dz_FmWzxa_w@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: avoid superfluous variable store writes on
 unchanged data
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, 
 Adriano Cordova <adrianox@gmail.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Fri, 13 Mar 2026 at 13:21, Michal Simek <michal.simek@amd.com> wrote:
>
> Every SetVariable() call triggers efi_var_mem_ins() followed by
> efi_var_to_storage(), even when the variable value is not actually
> changing. This is unfriendly to flash-backed stores that suffer
> wear from unnecessary erase/write cycles.
>
> Add a change-detection path to efi_var_mem_ins(): when size2 == 0
> (i.e. not an append) and the caller passes a non-NULL changep flag,
> look up the existing variable and compare attributes, length, time
> and data byte-by-byte. If everything matches, set *changep = false
> and return EFI_SUCCESS without touching the variable buffer.
>
> Both efi_set_variable_int() and efi_set_variable_runtime() now
> check the flag and skip efi_var_mem_del() / efi_var_to_storage()
> when nothing changed.
>
> Introduce efi_memcmp_runtime() - a runtime-safe byte-by-byte memory
> comparison helper, following the same pattern as the existing
> efi_memcpy_runtime(). The standard memcmp() is not available after
> ExitBootServices() and calling it from Linux will crash.
>
> Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Changes in v2:
> - Using efi_memcmp_runtime() Suggested-by Ilias
>
>  include/efi_loader.h            |  3 +++
>  include/efi_variable.h          |  8 +++++++-
>  lib/efi_loader/efi_runtime.c    | 24 ++++++++++++++++++++++++
>  lib/efi_loader/efi_var_common.c |  2 +-
>  lib/efi_loader/efi_var_mem.c    | 29 ++++++++++++++++++++++++++++-
>  lib/efi_loader/efi_variable.c   | 27 ++++++++++++++++++---------
>  6 files changed, 81 insertions(+), 12 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3e70ac070550..4ff83960c3cf 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1144,6 +1144,9 @@ struct pkcs7_message *efi_parse_pkcs7_header(const void *buf,
>  /* runtime implementation of memcpy() */
>  void efi_memcpy_runtime(void *dest, const void *src, size_t n);
>
> +/* runtime implementation of memcmp() */
> +int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
> +
>  /* commonly used helper functions */
>  u16 *efi_create_indexed_name(u16 *buffer, size_t buffer_size, const char *name,
>                              unsigned int index);
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index fc1184e5ca1a..c3229c717d89 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -216,6 +216,11 @@ void efi_var_mem_del(struct efi_var_entry *var);
>   * The variable is appended without checking if a variable of the same name
>   * already exists. The two data buffers are concatenated.
>   *
> + * When @changep is non-NULL and @size2 is 0, the function compares the new
> + * value against an existing variable with the same name and vendor. If
> + * attributes and data are identical the insertion is skipped and *@changep
> + * is set to false, avoiding superfluous writes.
> + *
>   * @variable_name:     variable name
>   * @vendor:            GUID
>   * @attributes:                variable attributes
> @@ -224,13 +229,14 @@ void efi_var_mem_del(struct efi_var_entry *var);
>   * @size2:             size of the second data field
>   * @data2:             second data buffer
>   * @time:              time of authentication (as seconds since start of epoch)
> + * @changep:           pointer to change flag (may be NULL)
>   * Result:             status code
>   */
>  efi_status_t efi_var_mem_ins(const u16 *variable_name,
>                              const efi_guid_t *vendor, u32 attributes,
>                              const efi_uintn_t size1, const void *data1,
>                              const efi_uintn_t size2, const void *data2,
> -                            const u64 time);
> +                            const u64 time, bool *changep);
>
>  /**
>   * efi_var_mem_free() - determine free memory for variables
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 35eb6a777665..73d4097464c0 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -209,6 +209,30 @@ void __efi_runtime efi_memcpy_runtime(void *dest, const void *src, size_t n)
>                 *d++ = *s++;
>  }
>
> +/**
> + * efi_memcmp_runtime() - compare memory areas
> + *
> + * At runtime memcmp() is not available.
> + *
> + * @s1:                first memory area
> + * @s2:                second memory area
> + * @n:         number of bytes to compare
> + * Return:     0 if equal, negative if s1 < s2, positive if s1 > s2
> + */
> +int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
> +{
> +       const u8 *pos1 = s1;
> +       const u8 *pos2 = s2;
> +
> +       for (; n; --n) {
> +               if (*pos1 != *pos2)
> +                       return *pos1 - *pos2;
> +               ++pos1;
> +               ++pos2;
> +       }
> +       return 0;
> +}
> +
>  /**
>   * efi_update_table_header_crc32() - Update crc32 in table header
>   *
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index c89a4fce4ff8..d63c2d1b1cd8 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -526,7 +526,7 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
>                         continue;
>                 ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
>                                       var->length, data, 0, NULL,
> -                                     var->time);
> +                                     var->time, NULL);
>                 if (ret != EFI_SUCCESS)
>                         log_err("Failed to set EFI variable %ls\n", var->name);
>         }
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 31180df9e3a0..8d5f99f48703 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -159,12 +159,39 @@ efi_status_t __efi_runtime efi_var_mem_ins(
>                                 const efi_guid_t *vendor, u32 attributes,
>                                 const efi_uintn_t size1, const void *data1,
>                                 const efi_uintn_t size2, const void *data2,
> -                               const u64 time)
> +                               const u64 time, bool *changep)
>  {
>         u16 *data;
>         struct efi_var_entry *var;
>         u32 var_name_len;
>
> +       if (changep)
> +               *changep = true;
> +
> +       /*
> +        * If this is not an append (size2 == 0), check whether the variable
> +        * already exists with identical attributes and data. When nothing
> +        * changed we can skip the write and avoid superfluous erases.
> +        */
> +       if (!size2 && changep) {
> +               struct efi_var_entry *old;
> +
> +               old = efi_var_mem_find(vendor, variable_name, NULL);
> +               if (old && old->attr == attributes &&
> +                   old->length == size1 && old->time == time) {
> +                       u16 *old_data;
> +
> +                       for (old_data = old->name; *old_data; ++old_data)
> +                               ;
> +                       ++old_data;
> +
> +                       if (!efi_memcmp_runtime(old_data, data1, size1)) {
> +                               *changep = false;
> +                               return EFI_SUCCESS;
> +                       }
> +               }
> +       }
> +
>         var = (struct efi_var_entry *)
>               ((uintptr_t)efi_var_buf + efi_var_buf->length);
>         var_name_len = u16_strlen(variable_name) + 1;
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 8512bc20f11e..9923936c1b59 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -277,6 +277,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>         struct efi_var_entry *var;
>         efi_uintn_t ret;
>         bool append, delete;
> +       bool changed = false;
>         u64 time = 0;
>         enum efi_auth_var_type var_type;
>
> @@ -366,6 +367,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>         if (delete) {
>                 /* EFI_NOT_FOUND has been handled before */
>                 attributes = var->attr;
> +               changed = true;
>                 ret = EFI_SUCCESS;
>         } else if (append && var) {
>                 /*
> @@ -380,15 +382,19 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 ret = efi_var_mem_ins(variable_name, vendor,
>                                       attributes & ~EFI_VARIABLE_APPEND_WRITE,
>                                       var->length, old_data, data_size, data,
> -                                     time);
> +                                     time, &changed);
>         } else {
>                 ret = efi_var_mem_ins(variable_name, vendor, attributes,
> -                                     data_size, data, 0, NULL, time);
> +                                     data_size, data, 0, NULL, time,
> +                                     &changed);
>         }
>
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> +       if (!changed)
> +               return EFI_SUCCESS;
> +
>         efi_var_mem_del(var);
>
>         if (var_type == EFI_AUTH_VAR_PK)
> @@ -396,10 +402,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>         else
>                 ret = EFI_SUCCESS;
>
> -       /*
> -        * Write non-volatile EFI variables
> -        * TODO: check if a value change has occured to avoid superfluous writes
> -        */
> +       /* Write non-volatile EFI variables to storage */
>         if (attributes & EFI_VARIABLE_NON_VOLATILE) {
>                 if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
>                         return EFI_SUCCESS;
> @@ -498,6 +501,7 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
>         struct efi_var_entry *var;
>         efi_uintn_t ret;
>         bool append, delete;
> +       bool changed = false;
>         u64 time = 0;
>
>         if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> @@ -549,6 +553,7 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
>         if (delete) {
>                 /* EFI_NOT_FOUND has been handled before */
>                 attributes = var->attr;
> +               changed = true;
>                 ret = EFI_SUCCESS;
>         } else if (append && var) {
>                 u16 *old_data = (void *)((uintptr_t)var->name +
> @@ -556,15 +561,19 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
>
>                 ret = efi_var_mem_ins(variable_name, vendor, attributes,
>                                       var->length, old_data, data_size, data,
> -                                     time);
> +                                     time, &changed);
>         } else {
>                 ret = efi_var_mem_ins(variable_name, vendor, attributes,
> -                                     data_size, data, 0, NULL, time);
> +                                     data_size, data, 0, NULL, time,
> +                                     &changed);
>         }
>
>         if (ret != EFI_SUCCESS)
>                 return ret;
> -       /* We are always inserting new variables, get rid of the old copy */
> +
> +       if (!changed)
> +               return EFI_SUCCESS;
> +
>         efi_var_mem_del(var);
>
>         return EFI_SUCCESS;
> --
> 2.43.0
>
> base-commit: 1e8eb1c27210e3beb5d3f4402a40d2e8886bcf9f
> branch: debian-sent3
