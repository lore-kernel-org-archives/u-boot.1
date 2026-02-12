Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8DCEDF045
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 06:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E3E83015;
	Thu, 12 Feb 2026 07:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fcpS5Me3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46CDF8367F; Thu, 12 Feb 2026 07:15:08 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B823C82BF2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 07:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64aefa98fe6so2963528d50.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 22:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770876899; cv=none;
 d=google.com; s=arc-20240605;
 b=RTOPremRbG01Y1A0d9AicQATDPCAyECD2jCp4pGMoAdusD5Ec8jp8MlhryBLw3Cp4z
 8FONKfdyeDQCbpGsWUb9vrwbU+79nvmnMNMqiAlYx0CRhtNirIGUlcXvcbM3+WvJSFEV
 mHV3072aKBYKpRar/fQmgO6OzXAcNJGO2B/JbITy7bZEdIiwa61JiiDF/Pglv0VcbXnn
 S0zWb5Jq9B5MmZk4zDMQQ6YxgFtu7rKPTaT7fFg8X0FXRohy06XRD7s0GPnXlKwh2J8V
 3RlMGqcJtp0LXT3qphpHQOwja+zoNsNVOapuUTGCg4V7ZNAUtADinbTwnlGJ/r9aZajc
 uD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sbu7fdYS1JCl7fV9FkAbvpNE5Ng6rUKP8J/YfAkcQt0=;
 fh=in3i2Q7PzVcvYaAWwPJgNgjbQ3NtHqOWgs0r15QwdEA=;
 b=ZqQIOu06J0cV0q5cTYGu6VQlXqEIZ4iwHtJ64msPOqLK7xUO0zZhfdhg76KzeYK6Kj
 P5VeKLmz1W/6mtkjEDldSA+L2xNp85N6iWvwfbH5AsNZM8LB9hMOXgJ5F+5dyeBtt+nM
 85eDn6DwHY0VWtf3ZwzwUYEgHsACnRxu6sUGJhPaD/4gRA+XKGGTazEGegxM0Majxu0F
 z7fRVUJMuVEkOIsGoSSk7qHKwMGxJHBOP5uK8G/RHDXOgKaeumWQN8eA6WRVKu/rQIYg
 Dd+dwy2P1vNGrRtZQ+pXjHqV3DhYlLlPkg/wO4NfdWUS8zDhSlFxsic6YQYFMI2dWdzp
 CiLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770876899; x=1771481699; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sbu7fdYS1JCl7fV9FkAbvpNE5Ng6rUKP8J/YfAkcQt0=;
 b=fcpS5Me3z2jQafikSAM+SjH4PMlmslFq+Fby3uRkTSd/tqEqbCUv9wRZaFSef/MG+K
 IZ2B4oDBjKJgm8PV2kAkOvDokNNPivKuPrds08cwjwvbNEDM9b+cml8KTRw47Rp/rtrF
 6iBxfo2u3BRHSLXB5G6L/P9uDL0fy8qMz9a8sHs1NgFWx4xur0NoPdThTu7hjZ6RQeGm
 ObPT2Hg/VFRxC7HxNSnA1lQAL5ZLJnvSfLFbv2ZwKgqY9fb/oPbQd+2YdSpcaCve3+/E
 a7s36zjX8UNAHmhdUaIe3J0vFKONxEwXrYKmS/zYvYWmI0LD856TquXNSBFYJFKvetzb
 /R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770876899; x=1771481699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sbu7fdYS1JCl7fV9FkAbvpNE5Ng6rUKP8J/YfAkcQt0=;
 b=I+7UEvQGm2NHlu4VZwZ5QKqlwZxWtx/3dXf6SNRiZMF5ZAzC7wKrmnqF5OCST5uBWU
 VLZfVfYWSf7Hiy0AuV79bifEPSRAX2FPdIT5YsH3tYDpLRnmrUSnsf/bSdfmSN1AlCPx
 oeMzpGq2ctycXFlYTnk30afoTD/Oqj5LbpBIB4LF8Gmi88sfeqzvsByqbNlFENfB7wZx
 ARAZM4mRNhhZAWYc2YKrnw8Ebc+PtUcaphi7D3wvXJXe6N8zv+RJt5M2cqYenG2mZOmA
 ITaY5A52ofM0J+xPrX1amOzjbarFJ2RDThu0vfaO/K/cK/6imr3EhjM9Vt59MWK87y/K
 ltHw==
X-Gm-Message-State: AOJu0Yx4YmNdYb0CAmY8f7hHFtUc4pyYvTg1Aud28k7QcCPBQM/zuzad
 DdWRCsnil9CajrlQc2rbCQWxGiEXY+db1Xd11FAnWZmpCFU11DBFmXihhtx+AkMZ/lWWoUgb7CA
 63heviW+JYSNItCnru0lJaG7CjLNAWGldo5Ai0eMSUw==
X-Gm-Gg: AZuq6aKfxML6gAkrQqQs6LFwd5OCJhyq29XNkyddFi9fpv+2QWMQV5hDy1mjDJoxlg6
 IhdTfe6QkXx6J/zepWzsq3dtGVlZE/y5CqIAFd33z5gVJkg+Xk7feBfpcoghIR/mhoJoXuAGal6
 Xd+mYAhzfCoAxs8TxjCV5uAtJSSRpur9aNzzJ1INfVv3wmmcjtdTUkgZAOiFuaNTBfly/qFZHXF
 699dH6zlmUp7Xj9sBkUHDs9hsRQrsHvWpuS5wIxGX6mmWLY8hYIyk+1TLPApx2W8c9hETvvTxIP
 y/KdugabfO2nmgqLjR5hq6Sf9aTYZZSQdEgbUXolG3Y8OHlIX4l5JQfR/PiMN3R9HrXbSIHsm4N
 Fs8sH8s09vAVMr7cUbIiFT6+xoZn3Q8Eyt/yJUsilZPLZo3i/PwuOfo07IRBrkpjzRsT+veAneW
 J02mZdciIF/GtwBDcXuhGw1eBD5BL4mgtWX5tlaaeDhzdinIFi8qM/ICCCl1uENt214rH5y9h+8
 edFSCGsSZ/zK/o3TTxXwcOGbgpTfA83dPuMgvBsMr+vJoiq/sxmOOd8bMEF6tJfpkhF9M7EpS+M
 WKvAqDectNy0Ad2f5OaDBI96QDxe1HTYZQkSAfAYn7gH
X-Received: by 2002:a05:690c:d8e:b0:796:26af:6126 with SMTP id
 00721157ae682-7979309f71amr19643407b3.2.1770876898599; Wed, 11 Feb 2026
 22:14:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770825377.git.michal.simek@amd.com>
 <b0235b8e04227ac36c54b64659a5f98b04f437e7.1770825377.git.michal.simek@amd.com>
In-Reply-To: <b0235b8e04227ac36c54b64659a5f98b04f437e7.1770825377.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Feb 2026 08:14:22 +0200
X-Gm-Features: AZwV_QhRfGiowW6TVcvWFru2PC7cRg7kQRSW3UZEshkDoxmsgjBRe7dlI8IqdHk
Message-ID: <CAC_iWj+d17sozzCTWCiqvNs4mVYFX2PESYDryFTw4Grm-oT3qw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] efi_var_file: refactor to move buffer functions
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
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

On Wed, 11 Feb 2026 at 17:56, Michal Simek <michal.simek@amd.com> wrote:
>
> From: Shantur Rathore <i@shantur.com>
>
> Currently efi_var_file.c has functions to store/read
> EFI variables to/from memory buffer. These functions
> can be used with other EFI variable stores so move
> them out to efi_var_common.c
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v6)
>
> Changes in v6:
> - Return EFI_SUCCESS in efi_set_variable_int() when
>   CONFIG_EFI_VARIABLE_NO_STORE is enabled
>
> Changes in v5:
> - Invert logic in efi_variable.c and avoid #if
>
>  include/efi_variable.h          |  5 +++
>  lib/efi_loader/Makefile         |  2 +-
>  lib/efi_loader/efi_var_common.c | 42 ++++++++++++++++++++++++
>  lib/efi_loader/efi_var_file.c   | 57 ---------------------------------
>  lib/efi_loader/efi_variable.c   | 17 +++++++---
>  5 files changed, 60 insertions(+), 63 deletions(-)
>
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 4065cf45ecaf..ee68fa4a885f 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -161,6 +161,11 @@ efi_status_t efi_var_to_file(void);
>  efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
>                                             u32 check_attr_mask);
>
> +/* GUID used by Shim to store the MOK database */
> +#define SHIM_LOCK_GUID \
> +       EFI_GUID(0x605dab50, 0xe046, 0x4300, \
> +                0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> +
>  /**
>   * efi_var_restore() - restore EFI variables from buffer
>   *
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index f490081f6542..ca1775eb03be 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -53,7 +53,7 @@ ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
>  obj-y += efi_variable_tee.o
>  else
>  obj-y += efi_variable.o
> -obj-y += efi_var_file.o
> +obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
>  obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
>  endif
>  obj-y += efi_watchdog.o
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index 4b34a58b4cf7..5ea1688dca3d 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -41,6 +41,7 @@ static const struct efi_auth_var_name_type name_type[] = {
>
>  static bool efi_secure_boot;
>  static enum efi_secure_mode efi_secure_mode;
> +static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
>
>  /**
>   * efi_efi_get_variable() - retrieve value of a UEFI variable
> @@ -488,3 +489,44 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
>
>         return EFI_SUCCESS;
>  }
> +
> +efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> +{
> +       struct efi_var_entry *var, *last_var;
> +       u16 *data;
> +       efi_status_t ret;
> +
> +       if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
> +           buf->crc32 != crc32(0, (u8 *)buf->var,
> +                               buf->length - sizeof(struct efi_var_file))) {
> +               log_err("Invalid EFI variables file\n");
> +               return EFI_INVALID_PARAMETER;
> +       }
> +
> +       last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
> +       for (var = buf->var; var < last_var;
> +            var = (struct efi_var_entry *)ALIGN((uintptr_t)data + var->length, 8)) {
> +               data = var->name + u16_strlen(var->name) + 1;
> +
> +               /*
> +                * Secure boot related and volatile variables shall only be
> +                * restored from U-Boot's preseed.
> +                */
> +               if (!safe &&
> +                   (efi_auth_var_get_type(var->name, &var->guid) !=
> +                    EFI_AUTH_VAR_NONE ||
> +                    !guidcmp(&var->guid, &shim_lock_guid) ||
> +                    !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
> +                       continue;
> +               if (!var->length)
> +                       continue;
> +               if (efi_var_mem_find(&var->guid, var->name, NULL))
> +                       continue;
> +               ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
> +                                     var->length, data, 0, NULL,
> +                                     var->time);
> +               if (ret != EFI_SUCCESS)
> +                       log_err("Failed to set EFI variable %ls\n", var->name);
> +       }
> +       return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index f23a964a4180..4061a463b580 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -14,17 +14,9 @@
>  #include <mapmem.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> -#include <u-boot/crc.h>
>
>  #define PART_STR_LEN 10
>
> -/* GUID used by Shim to store the MOK database */
> -#define SHIM_LOCK_GUID \
> -       EFI_GUID(0x605dab50, 0xe046, 0x4300, \
> -                0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> -
> -static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
> -
>  /**
>   * efi_set_blk_dev_to_system_partition() - select EFI system partition
>   *
> @@ -59,7 +51,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
>   */
>  efi_status_t efi_var_to_file(void)
>  {
> -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>         efi_status_t ret;
>         struct efi_var_file *buf;
>         loff_t len;
> @@ -91,52 +82,6 @@ error:
>  out:
>         free(buf);
>         return ret;
> -#else
> -       return EFI_SUCCESS;
> -#endif
> -}
> -
> -efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> -{
> -       struct efi_var_entry *var, *last_var;
> -       u16 *data;
> -       efi_status_t ret;
> -
> -       if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
> -           buf->crc32 != crc32(0, (u8 *)buf->var,
> -                               buf->length - sizeof(struct efi_var_file))) {
> -               log_err("Invalid EFI variables file\n");
> -               return EFI_INVALID_PARAMETER;
> -       }
> -
> -       last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
> -       for (var = buf->var; var < last_var;
> -            var = (struct efi_var_entry *)
> -                  ALIGN((uintptr_t)data + var->length, 8)) {
> -
> -               data = var->name + u16_strlen(var->name) + 1;
> -
> -               /*
> -                * Secure boot related and volatile variables shall only be
> -                * restored from U-Boot's preseed.
> -                */
> -               if (!safe &&
> -                   (efi_auth_var_get_type(var->name, &var->guid) !=
> -                    EFI_AUTH_VAR_NONE ||
> -                    !guidcmp(&var->guid, &shim_lock_guid) ||
> -                    !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
> -                       continue;
> -               if (!var->length)
> -                       continue;
> -               if (efi_var_mem_find(&var->guid, var->name, NULL))
> -                       continue;
> -               ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
> -                                     var->length, data, 0, NULL,
> -                                     var->time);
> -               if (ret != EFI_SUCCESS)
> -                       log_err("Failed to set EFI variable %ls\n", var->name);
> -       }
> -       return EFI_SUCCESS;
>  }
>
>  /**
> @@ -155,7 +100,6 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
>   */
>  efi_status_t efi_var_from_file(void)
>  {
> -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>         struct efi_var_file *buf;
>         loff_t len;
>         efi_status_t ret;
> @@ -180,6 +124,5 @@ efi_status_t efi_var_from_file(void)
>                 log_err("Invalid EFI variables file\n");
>  error:
>         free(buf);
> -#endif
>         return EFI_SUCCESS;
>  }
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index f3533f4def3a..6e45134c61bf 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -397,11 +397,15 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 ret = EFI_SUCCESS;
>
>         /*
> -        * Write non-volatile EFI variables to file
> +        * Write non-volatile EFI variables
>          * TODO: check if a value change has occured to avoid superfluous writes
>          */
> -       if (attributes & EFI_VARIABLE_NON_VOLATILE)
> +       if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> +               if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
> +                       return EFI_SUCCESS;
> +
>                 efi_var_to_file();
> +       }
>
>         return EFI_SUCCESS;
>  }
> @@ -594,9 +598,12 @@ efi_status_t efi_init_variables(void)
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> -       ret = efi_var_from_file();
> -       if (ret != EFI_SUCCESS)
> -               return ret;
> +       if (!IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE)) {
> +               ret = efi_var_from_file();
> +               if (ret != EFI_SUCCESS)
> +                       return ret;
> +       }
> +
>         if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
>                 ret = efi_var_restore((struct efi_var_file *)
>                                       __efi_var_file_begin, true);
> --
> 2.43.0
>
