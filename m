Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEBDEB5954
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 09:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E8B831AC;
	Wed, 11 Feb 2026 10:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XEsDPW9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0163B8367F; Wed, 11 Feb 2026 10:54:04 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C86082BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79427f739b0so68452537b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 01:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770803639; cv=none;
 d=google.com; s=arc-20240605;
 b=OPWLCfS0d1TjOliCzfamJIZ8/gOF4UGatkNuOkR5s5e31Dozm2kSj+Pl44mAxbja3R
 Uk8v7ZiQFVj3XWMjhaVzRzLBASJEqXOMKS5P66PWGcBHp8SqE2wbLNqyjp12KdytlabR
 oH9aFuM3QTYzdeWyMhTYNjrDuE3v+bToMmRJbJDMFbbl3fGTk0E4UGWURvFpjKfWI1Eh
 tGiQXrJdT6XLQK2q/dMaePj2iy7zRoaJPD4/VwfTFEHCt0vUaWj6pS7sYoeNe4R1f4RH
 oSIXojH+m2wlfuOvdnL7+8hsrOqTKjDFWFAdkoYR1AAZNyjFprsqOJA/BdleRaA38Kej
 KTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zxL/PgeogA0GrnLwk5BDJ2VHQloF9mBKs1O0ohkLwxI=;
 fh=scYkI2pdHmhnl5JNcajeOeRDElDDCijDpN9lSr2JUsY=;
 b=eatqWopvxh0uCOldt1V+czX0yhYDnyp39d8GkiSz1X8bRCP5ncLK334kZaDGwgZTKp
 WBTzcURFli+i1gu7LbhZGGWjI/PH8E0U9p8Wmb1f7zkNpNs7/cnpIbU27bN+uRMpndzj
 RNpR6/pAkCSJOHJd5ld6BwNvN+zRXpvQlTSIRt9jFqCD8jtAcjjFfVYaIhnBidmwjtQF
 2YfycXZ2Y72rDhz8IJZ+SfXvU+YIGJwyPBMzBKKJBOLrbc7Yz6Fo0sk2Z1sl2tZlUsSJ
 JiWcxYQ1dX6F/g79A+dN3cLWJ6fx97Y27Ke9nep4gI5mXHxNPB0jTmfWSGNkgUt4pKUj
 Nduw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770803639; x=1771408439; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zxL/PgeogA0GrnLwk5BDJ2VHQloF9mBKs1O0ohkLwxI=;
 b=XEsDPW9cZhcsc0OVVjEs/QLglIe0v4IQbzzdmhMH1qgEW1Ay3HwRzHgqggGtR0REDR
 wuZvJyAaUCySuXh6fzixY4MR8uhRffbvatWyrlsCM1t5gl6vSPmxoR+tDe/Zrrsz9rTp
 mFzmPP/D9K5rCx7E4XJp5fXR5Hx1fdu0cct9uG33VpufFiw1DE9YWtENLwUNwGct+anl
 k/ubIc7bIVyGLJliSesx9BHJqLwa211c4fkQUCEo9ZcVuMlkKXTumu7uk0ceMe3gr9yM
 E9XA4vtVjEtpXjqTAcXjOFUNwehL1o6ihd3LWM+oG6jtRV6pd9q3wsgc/Fj4n5YAfh3T
 1KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770803639; x=1771408439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxL/PgeogA0GrnLwk5BDJ2VHQloF9mBKs1O0ohkLwxI=;
 b=aQTjU7Bgw+PrOr6sdgx8vPQEW5u64p9n36/yyQpkuyJE/+dz8P+1LJ8HoVUA9pH4h1
 3OAwxrzpvgDZPQ3hUP8Bps6/dj2qyGXD9nEPJpj071Bl9ALS/K2VS6IsyDF78KK7xTGt
 7MzE5rYKQt8NV6ygr1xPQqfjEUwGmwO9j6ujMpL80ZpY04N4TBM5r4z72XvpnLgmcsci
 d9+r05cXjZWRwDHIN9kBBI0ocpbNZ+7LgsD6msLR0VtenVRBbY63nWDK9F3rVATAcGJr
 msoESZ5KK69jsjkw5jUpPYiQUJPrVtPqaoY+dWKP8aPam4DA/3WoSU/OaSl3h3q4XaNt
 QDug==
X-Gm-Message-State: AOJu0Yz7ski7FufRgz0EnyMirqk9fnVK4FRa2W4GaWIhahgWhl1Z9oLf
 K78E8uKTITxwhUCMCWA/7C4PtfeQrBuHlCmIEsMXRQqAyEo3bcayMd6OqqxRkGdlADqlz1VkNN+
 3ips0Rvti+Kz/LgXYat5ZZfGphc+xeA8aEwnqbG58vQ==
X-Gm-Gg: AZuq6aIObG+9DyZC54hDO0VaqDkULcla64OJ/EtoUcZ244mI6un3jeL00Z7iEw3NU8s
 5lOC6eILrziniRie3+6LVmMmOXjeI3fEv26JssYa5I02r0uP8Wj4TSgtbCttdQ7RPoqvWMeyjxd
 0VATZaFEUBWv9lWhacgEPZcx9sQ2c2ZQFxhYIoS+gsabchxoM2r8XnA2IZUHP/ym0X+WnUSZO4r
 hKlyeLoPO9RusVfhRHePmlsEVFWNmOndQM5jjPMw8M6s+4T4HmoB+2yRmjsGJUSNipdAhUcQwpd
 mA1bue1u/10lapAmQwvJU5OUZhpQnpmlGvqNK35JhySSZmDEcTMbt6wwwTPRJ3RTR/W0gUbKtql
 nyQ+W//fpwMfBSQuuhDmpy0aOkcck8IJJkFP3iUVJccME8M4JoG+hhV4LRxebVZ3hsP9PSB7q6s
 w01ExDJwSfrilQCs8lNkA5gVER9sGto1eucMfINDfT6VspuLtsaVQcUJpOS+FqEyDPirZRT2fgs
 +I5c30bGZmr8EEYqS4QLz7LG+aXf3SFVYobcnwS7t8g+I8jLnN1xJrs8tLAH1rrsJa3tGBVF9D7
 z72ZWU+uH6vWHfbvPO6J2CguPIwsxwBPgnAp4k0eRa3Q2cgA8Ahbeek=
X-Received: by 2002:a05:690c:39d:b0:78c:6854:2771 with SMTP id
 00721157ae682-7966be16315mr10765767b3.36.1770803639183; Wed, 11 Feb 2026
 01:53:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770119483.git.michal.simek@amd.com>
 <1f50d76c2370b9b032e73c35c05246cc70255b28.1770119483.git.michal.simek@amd.com>
In-Reply-To: <1f50d76c2370b9b032e73c35c05246cc70255b28.1770119483.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 11:53:23 +0200
X-Gm-Features: AZwV_QjrORbfJAPT3J2VZsOTOgRgNPrqi3sRRS4KGsvoXvrj7Nf5882qXseBC7g
Message-ID: <CAC_iWjKxshi4fEtUvvrwGrd8quSUNeeuqjTV=gFrW4x6uXi55A@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi_var_file: refactor to move buffer functions
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

Hi Michael

The CI seems to fail on this one for some reason.
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/29248

Can you take a look ?

Thanks
/Ilias




On Tue, 3 Feb 2026 at 13:51, Michal Simek <michal.simek@amd.com> wrote:
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
> ---
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
> index ba0bf33ffbd1..d32edaac277d 100644
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
