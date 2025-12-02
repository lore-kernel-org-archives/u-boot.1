Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F99CCFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 12:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD37C83E63;
	Tue,  2 Dec 2025 13:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WwFvqyvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69FC083E69; Tue,  2 Dec 2025 13:43:26 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA97F83CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 13:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64308342458so4820803d50.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 04:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764679403; x=1765284203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5UILr27EHuk6nngYX7ti25HvX1cJVNIJQJs1M4uEU7g=;
 b=WwFvqyvGN/CL5x8ms8iaCzXnmKu/naswk+BgE/L3VWo2wemed+ny2ElLkf7cwI9tfB
 bi03JiCY5xEgbz1kvWCUE+hKzODVBgtgWbkIj4zcZOY4MH2pwzEQMN3dK6V9EgaPGv9Z
 dB9heoHtBK1b4dD/swVbrlnsyi8SMKBPRNOcbWBtVtq9BHqdKjY/8FoMMOOQD4qh/U0S
 U1OLyCFdXPNIzBz/yqMWADWzX7oQL33a8yULqvRF2WzGHL9Fi7MIvXHked7OhiQIDMbj
 ocF5du3Y2PKWY0q3RFYm/zAIzux8Jf7UurMpGXDeYzwVZcNzUxZoJJ5APvem9EkqMrcV
 +NLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764679403; x=1765284203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UILr27EHuk6nngYX7ti25HvX1cJVNIJQJs1M4uEU7g=;
 b=iwXBKbmxmI2qENafai/LgZLdJ5jd4dEuFnVptEE0TSZE6ziwFKqAV0Soy//8ZShiyc
 86HpgP9c+OpQBfrxkBzetoxVNaZtlAXtXvfineNaKuPnvb76rlxnsX6tC4W0/EObnzwC
 81/PfNtToqvAKfwgHYVKjD/zaOOGrgAgOIvKHRFOgj5SL7kMjt1lpdtPd827c5Cg+HEN
 1C89ovj5WnhpH0dpYex3AfTvelwcOqcOUWC+WM1UeyOzZnH3akqLo62OCeXgceOeYK88
 SgIL+F9Vt8FUTuJHejLBc3UvdhBSIvRR6TEASt5mptRGovHvGnjDVhygQEVfpW/3VPXN
 iJnw==
X-Gm-Message-State: AOJu0Ywsze7kpOsXrIv/eAvHaSpVcE60XSpwMs6tyArS9hl7wd5DHiec
 1R+OUVx2aKPd+UUxKrBvPL2P/K2ev7y247iCAW9uvwGMEhFdpAohyI88Mj57f5lGS7Zb/NCLTxl
 0S2637Ju6VoYeya9ohmj6TXMHrTWEhVQbIEVXgX1kUA==
X-Gm-Gg: ASbGnctq0iQ4AAdRSb6KeWmzTxusR16gKdjXHsSUChOaVHjhqKf/ucy+qwEu5Iixs8c
 vPTUK93qVO4zgjm/ec/JkD+TQPhca/fIah0eNszeNI20RRaJpMKqgehdDGsCb8HqAkYbkav0Xin
 FQ+FwizJzdOfNcfwE8aIoO8Vc5mK6Qm/bF0lq4wy8dRRAk6ttsq0J6yV5cw9gO2Pb+uJM7g1YZP
 AuTsSZJGcZvojqHRMvRtvqw8EWbxkjNCWaGGQAu1U93tl/UE41E3uH2J1q0EVI4aUVueKwcJcvL
 mJyFSs+FKkQ1d0OUQZnjQzQaWRpTvRtYiAW0dgcec726So4Oexl7CZZrbv/3w/F5iQQKW0UEaiO
 I5BEkKQLo2rA1UP5/ig==
X-Google-Smtp-Source: AGHT+IG8lnS75fX4Bacp6/Mglojp0991JL+FDwW9MLeLVP8G2n7bRYonz3P7Htwa3YW4xwukG7F2peQDAi1XP0AqFKg=
X-Received: by 2002:a53:d84e:0:b0:640:db91:33d4 with SMTP id
 956f58d0204a3-64302aafecfmr24735296d50.26.1764679402604; Tue, 02 Dec 2025
 04:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
 <20251114093246.56422-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251114093246.56422-8-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Dec 2025 14:42:46 +0200
X-Gm-Features: AWmQ_bndwyAPp9LTkTyeR4R2zrDFCRLjHxNLIuK4-Z-stebyNY4JPd_63sO76Aw
Message-ID: <CAC_iWjJv+fu7SpSuHLVgvxH9i45PuMnQmaVX3PXmftq7nLDJGg@mail.gmail.com>
Subject: Re: [PATCH 7/7] efi_selftest: simplify efi_selftest_variables_runtime
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
> Use global st_boottime and st_runtime.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  .../efi_selftest_variables_runtime.c          | 183 +++++++++---------
>  1 file changed, 88 insertions(+), 95 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> index 4be37efc1fc..0886b4894b8 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -16,26 +16,9 @@
>  #define EFI_ST_MAX_DATA_SIZE 16
>  #define EFI_ST_MAX_VARNAME_SIZE 40
>
> -static struct efi_boot_services *boottime;
> -static struct efi_runtime_services *runtime;
>  static const efi_guid_t guid_vendor0 = EFI_GLOBAL_VARIABLE_GUID;
>  static const efi_guid_t __efi_runtime_data efi_rt_var_guid =
> -                                               U_BOOT_EFI_RT_VAR_FILE_GUID;
> -
> -/*
> - * Setup unit test.
> - *
> - * @handle     handle of the loaded image
> - * @systable   system table
> - */
> -static int setup(const efi_handle_t img_handle,
> -                const struct efi_system_table *systable)
> -{
> -       boottime = systable->boottime;
> -       runtime = systable->runtime;
> -
> -       return EFI_ST_SUCCESS;
> -}
> +       U_BOOT_EFI_RT_VAR_FILE_GUID;
>
>  /**
>   * execute() - execute unit test
> @@ -60,26 +43,27 @@ static int execute(void)
>         memset(v2, 0x1, sizeof(v2));
>
>         if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
> -               test_ret = efi_st_query_variable_common(EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                                       EFI_VARIABLE_RUNTIME_ACCESS);
> +               test_ret = efi_st_query_variable_common(
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                       EFI_VARIABLE_RUNTIME_ACCESS);
>                 if (test_ret != EFI_ST_SUCCESS) {
>                         efi_st_error("QueryVariableInfo failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>         } else {
> -               ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> -                                          &max_storage, &rem_storage,
> -                                          &max_size);
> +               ret = st_runtime->query_variable_info(
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS, &max_storage,
> +                       &rem_storage, &max_size);
>                 if (ret != EFI_UNSUPPORTED) {
>                         efi_st_error("QueryVariableInfo failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>         }
>
> -       ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                   EFI_VARIABLE_RUNTIME_ACCESS,
> -                                   3, v + 4);
> +       ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +                                      EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                                              EFI_VARIABLE_RUNTIME_ACCESS,
> +                                      3, v + 4);
>         if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
>                 efi_uintn_t prev_len, delta;
>                 struct efi_var_entry *var;
> @@ -91,20 +75,21 @@ static int execute(void)
>                         return EFI_ST_FAILURE;
>                 }
>
> -               /* runtime atttribute must be set */
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           3, v + 4);
> +               /* runtime attribute must be set */
> +               ret = st_runtime->set_variable(
> +                       u"efi_st_var0", &guid_vendor0,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       3, v + 4);
>                 if (ret != EFI_INVALID_PARAMETER) {
>                         efi_st_error("SetVariable failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>
>                 len = sizeof(data);
> -               ret = runtime->get_variable(u"RTStorageVolatile",
> -                                           &efi_rt_var_guid,
> -                                           &attr, &len, data);
> +               ret = st_runtime->get_variable(u"RTStorageVolatile",
> +                                              &efi_rt_var_guid, &attr, &len,
> +                                              data);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("GetVariable failed\n");
>                         return EFI_ST_FAILURE;
> @@ -118,8 +103,8 @@ static int execute(void)
>                 }
>
>                 len = sizeof(data2);
> -               ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> -                                           &attr, &len, data2);
> +               ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +                                              &attr, &len, data2);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("GetVariable failed\n");
>                         return EFI_ST_FAILURE;
> @@ -129,12 +114,12 @@ static int execute(void)
>                  * Store it now, we'll use it later
>                  */
>                 prev_len = len;
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_RUNTIME_ACCESS |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           sizeof(v2),
> -                                           v2);
> +               ret = st_runtime->set_variable(
> +                       u"efi_st_var0", &guid_vendor0,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_RUNTIME_ACCESS |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       sizeof(v2), v2);
>                 /*
>                  * This will try to update VarToFile as well and must fail,
>                  * without changing or deleting VarToFile
> @@ -144,60 +129,64 @@ static int execute(void)
>                         return EFI_ST_FAILURE;
>                 }
>                 len = sizeof(data2);
> -               ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> -                                           &attr, &len, data2);
> +               ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +                                              &attr, &len, data2);
>                 if (ret != EFI_SUCCESS || prev_len != len) {
>                         efi_st_error("Get/SetVariable failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>
>                 /* Add an 8byte aligned variable */
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_RUNTIME_ACCESS |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           sizeof(v), v);
> +               ret = st_runtime->set_variable(
> +                       u"efi_st_var0", &guid_vendor0,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_RUNTIME_ACCESS |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       sizeof(v), v);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("SetVariable failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>
>                 /* Delete it by setting the attrs to 0 */
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           0, sizeof(v), v);
> +               ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0, 0,
> +                                              sizeof(v), v);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("SetVariable failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>
>                 /* Add it back */
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_RUNTIME_ACCESS |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           sizeof(v), v);
> +               ret = st_runtime->set_variable(
> +                       u"efi_st_var0", &guid_vendor0,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_RUNTIME_ACCESS |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       sizeof(v), v);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("SetVariable failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>
>                 /* Delete it again by setting the size to 0 */
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_RUNTIME_ACCESS |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           0, NULL);
> +               ret = st_runtime->set_variable(
> +                       u"efi_st_var0", &guid_vendor0,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_RUNTIME_ACCESS |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       0, NULL);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("SetVariable failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>
>                 /* Delete it again and make sure it's not there */
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_RUNTIME_ACCESS |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           0, NULL);
> +               ret = st_runtime->set_variable(
> +                       u"efi_st_var0", &guid_vendor0,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_RUNTIME_ACCESS |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       0, NULL);
>                 if (ret != EFI_NOT_FOUND) {
>                         efi_st_error("SetVariable failed\n");
>                         return EFI_ST_FAILURE;
> @@ -207,11 +196,12 @@ static int execute(void)
>                  * Add a non-aligned variable
>                  * VarToFile updates must include efi_st_var0
>                  */
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_RUNTIME_ACCESS |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           9, v + 4);
> +               ret = st_runtime->set_variable(
> +                       u"efi_st_var0", &guid_vendor0,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_RUNTIME_ACCESS |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       9, v + 4);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("SetVariable failed\n");
>                         return EFI_ST_FAILURE;
> @@ -223,8 +213,8 @@ static int execute(void)
>                 }
>                 delta = efi_var_entry_len(var);
>                 len = sizeof(data2);
> -               ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> -                                           &attr, &len, data2);
> +               ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +                                              &attr, &len, data2);
>                 if (ret != EFI_SUCCESS || prev_len + delta != len) {
>                         efi_st_error("Get/SetVariable failed\n");
>                         return EFI_ST_FAILURE;
> @@ -237,25 +227,27 @@ static int execute(void)
>                  */
>                 prev_len = len;
>                 avail = efi_var_entry_len(var) -
> -                       (sizeof(u16) * (u16_strlen(var->name) + 1) + sizeof(*var)) -
> +                       (sizeof(u16) * (u16_strlen(var->name) + 1) +
> +                        sizeof(*var)) -
>                         var->length;
>                 if (avail >= append_len)
>                         delta = 0;
>                 else
>                         delta = ALIGN(append_len - avail, 8);
> -               ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_RUNTIME_ACCESS |
> -                                           EFI_VARIABLE_APPEND_WRITE |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           append_len, v2);
> +               ret = st_runtime->set_variable(
> +                       u"efi_st_var0", &guid_vendor0,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_RUNTIME_ACCESS |
> +                               EFI_VARIABLE_APPEND_WRITE |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       append_len, v2);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("SetVariable failed\n");
>                         return EFI_ST_FAILURE;
>                 }
>                 len = sizeof(data2);
> -               ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> -                                           &attr, &len, data2);
> +               ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +                                              &attr, &len, data2);
>                 if (ret != EFI_SUCCESS) {
>                         efi_st_error("GetVariable failed\n");
>                         return EFI_ST_FAILURE;
> @@ -267,20 +259,22 @@ static int execute(void)
>
>                 /* Make sure that variable contains a valid file */
>                 hdr = (struct efi_var_file *)data2;
> -               if (hdr->magic != EFI_VAR_FILE_MAGIC ||
> -                   len != hdr->length ||
> -                   hdr->crc32 != crc32(0, (u8 *)((uintptr_t)data2 + sizeof(struct efi_var_file)),
> +               if (hdr->magic != EFI_VAR_FILE_MAGIC || len != hdr->length ||
> +                   hdr->crc32 != crc32(0,
> +                                       (u8 *)((uintptr_t)data2 +
> +                                              sizeof(struct efi_var_file)),
>                                         len - sizeof(struct efi_var_file))) {
>                         efi_st_error("VarToFile invalid header\n");
>                         return EFI_ST_FAILURE;
>                 }
>
>                 /* Variables that are BS, RT and volatile are RO after EBS */
> -               ret = runtime->set_variable(u"VarToFile", &efi_rt_var_guid,
> -                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                           EFI_VARIABLE_RUNTIME_ACCESS |
> -                                           EFI_VARIABLE_NON_VOLATILE,
> -                                           sizeof(v), v);
> +               ret = st_runtime->set_variable(
> +                       u"VarToFile", &efi_rt_var_guid,
> +                       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                               EFI_VARIABLE_RUNTIME_ACCESS |
> +                               EFI_VARIABLE_NON_VOLATILE,
> +                       sizeof(v), v);
>                 if (ret != EFI_WRITE_PROTECTED) {
>                         efi_st_error("Get/SetVariable failed\n");
>                         return EFI_ST_FAILURE;
> @@ -292,8 +286,8 @@ static int execute(void)
>                 }
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
> -       ret = runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
> +                                      &attr, &len, data);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("GetVariable failed\n");
>                 return EFI_ST_FAILURE;
> @@ -301,7 +295,7 @@ static int execute(void)
>         memset(&guid, 0, 16);
>         *varname = 0;
>         len = 2 * EFI_ST_MAX_VARNAME_SIZE;
> -       ret = runtime->get_next_variable_name(&len, varname, &guid);
> +       ret = st_runtime->get_next_variable_name(&len, varname, &guid);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("GetNextVariableName failed\n");
>                 return EFI_ST_FAILURE;
> @@ -313,6 +307,5 @@ static int execute(void)
>  EFI_UNIT_TEST(variables_run) = {
>         .name = "variables at runtime",
>         .phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
> -       .setup = setup,
>         .execute = execute,
>  };
> --
> 2.51.0
>
