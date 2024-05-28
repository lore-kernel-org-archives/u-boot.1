Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CECC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F1D883A0;
	Tue, 28 May 2024 18:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gu3oYsUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0C58854F; Tue, 28 May 2024 18:03:28 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE40087128
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 18:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f48bd643a0so7913945ad.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912204; x=1717517004; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eBBuqVMb/7irP9gL+rZDR6aFRwTq5RdMiu3E4YcrcYI=;
 b=gu3oYsUhvF3vkDdbQ2mdryfH2DCYoSxdWsgzJj/Ie5E7qfFMlpbdLZPLj1AG3yWg/K
 ieBlJgCVKQFw+BEL9UGX5RL+DqDlrov6HHObqRrLsnxqeXbrxy4mjPzve4TXf/SV/i1W
 h+mE+kymOISttI1PVSCKJUOWpkuOc2vMGFsm3SrC1sp2/SQdriakAEh+fZXjBJF9pGdi
 wfevn4R9UMpOLWCOtbm8q0EnECOJhWi8SNWW4VsPbyCqk9Kk3D5nthSR8KXlBpg1r52f
 JuRyr8O1JAoSidFp1AYMJnjPkYcpJQ18Oiaj49dH2+kNO+7bXiQFjfFrAJPgDaucvF52
 Mu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912204; x=1717517004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eBBuqVMb/7irP9gL+rZDR6aFRwTq5RdMiu3E4YcrcYI=;
 b=Nj9TzgguQFvQlycqU0ol7RtHw8qvQhD6brYkczXFiwXqxJY97KtYFTMLnMAQQzOQC7
 cglsS3Bx2/Va0ebKEWU72P+DiiU6vjxTb1OZKBcxrObqZYQZWUedywpXkXVEUZsMXKx1
 piCHTuHPQjeMA9TgI9IJvIUUwvNug/4V/Rb1tiA8nIGluw1sPtWAH28YTf2q5F6LyYGL
 kRBs0IJ7m7QDxUtKhlF3qxDrulqaiSgjue4nsmG6MSD+WsfWJ7uojncE6u6z1EhGRuJi
 iOEeV2Yg9GvxXYF2ei8FRImvbfYaSs+FuScRY2RYExCPqd7omLsXGXQRykv2sNUybtaH
 MyWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViBMiJqgJDu0NuKMDn1X+b60dcuPpKm12k623fzuUKVX2tGDHWUnPVjuFq3J1ADvcGcxLb40LNpt1KThgHCIIxmcBkrA==
X-Gm-Message-State: AOJu0Yy7Eo30CktNZ7Geld6A4x85eK9VfL1ewCpPisT1fzM/GKnitX4x
 cQbcahIjUDvWQ4k0eWzzv8qR97swYS1eNMJk1f/vvtZoc9QXTU+V2lBWzOQUbViN2+slqenkIaA
 ibkS89p43TwIW+l2Fb/jH2xEQjhnKxhaR/eEVcw==
X-Google-Smtp-Source: AGHT+IEj2pBOJa7oVVdzkrKbOWonWt/lo91bagziW0+ZZpnzsk9GHz0wbaH1Wy52z/NFJuan5pwL+X7wI8MKY2WWG4U=
X-Received: by 2002:a17:903:1208:b0:1f2:f46a:41bf with SMTP id
 d9443c01a7336-1f4498f0c2bmr141004865ad.57.1716912204111; Tue, 28 May 2024
 09:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 19:02:46 +0300
Message-ID: <CAC_iWjJFiSrPZveDDhX7wW9J-gBiTCUw2jXpw9MG_+K3nsGaEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] efi_loader: allow concatenation with contained end
 node
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 17:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Allow appending a device-path to a device-path that contains an end node
> as separator. We need this feature for creating boot options specifying
> kernel, initrd, and dtb.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         update efi_dp_concat() instead of new function efi_dp_merge()
> ---
>  cmd/eficonfig.c                            |  6 +++---
>  cmd/efidebug.c                             |  4 ++--
>  include/efi_loader.h                       |  2 +-
>  lib/efi_loader/efi_bootbin.c               |  2 +-
>  lib/efi_loader/efi_bootmgr.c               |  2 +-
>  lib/efi_loader/efi_boottime.c              |  2 +-
>  lib/efi_loader/efi_device_path.c           | 20 +++++++++++++-------
>  lib/efi_loader/efi_device_path_utilities.c |  2 +-
>  8 files changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 0ba92c60e03..b13d9a3d2d9 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -531,7 +531,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
>         dp = efi_dp_shorten(dp_volume);
>         if (!dp)
>                 dp = dp_volume;
> -       dp = efi_dp_concat(dp, &fp->dp, false);
> +       dp = efi_dp_concat(dp, &fp->dp, 0);
>         free(buf);
>
>         return dp;
> @@ -1485,7 +1485,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>                         goto out;
>                 }
>                 initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
> -                                         dp, false);
> +                                         dp, 0);
>                 efi_free_pool(dp);
>         }
>
> @@ -1496,7 +1496,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>         }
>         final_dp_size = efi_dp_size(dp) + sizeof(END);
>         if (initrd_dp) {
> -               final_dp = efi_dp_concat(dp, initrd_dp, true);
> +               final_dp = efi_dp_concat(dp, initrd_dp, 1);
>                 final_dp_size += efi_dp_size(initrd_dp) + sizeof(END);
>         } else {
>                 final_dp = efi_dp_dup(dp);
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index c2c525f2351..762027daf8a 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -697,7 +697,7 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
>                 short_fp = tmp_fp;
>
>         initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
> -                                 short_fp, false);
> +                                 short_fp, 0);
>
>  out:
>         efi_free_pool(tmp_dp);
> @@ -917,7 +917,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>                 goto out;
>         }
>
> -       final_fp = efi_dp_concat(file_path, initrd_dp, true);
> +       final_fp = efi_dp_concat(file_path, initrd_dp, 1);
>         if (!final_fp) {
>                 printf("Cannot create final device path\n");
>                 r = CMD_RET_FAILURE;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 9600941aa32..ddf2e41a95c 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -946,7 +946,7 @@ struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>                                        const efi_guid_t *guid);
>  struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>                                       const struct efi_device_path *dp2,
> -                                     bool split_end_node);
> +                                     size_t split_end_node);
>  struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
>  efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
>                                          efi_uintn_t *size);
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index b7910f78fb6..a87006b3c0e 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -150,7 +150,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>                 msg_path = file_path;
>         } else {
>                 file_path = efi_dp_concat(bootefi_device_path,
> -                                         bootefi_image_path, false);
> +                                         bootefi_image_path, 0);
>                 msg_path = bootefi_image_path;
>                 log_debug("Loaded from disk\n");
>         }
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 7da3139f917..b0bf21cf841 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -130,7 +130,7 @@ static efi_status_t try_load_from_file_path(efi_handle_t *fs_handles,
>                 if (!dp)
>                         continue;
>
> -               dp = efi_dp_concat(dp, fp, false);
> +               dp = efi_dp_concat(dp, fp, 0);
>                 if (!dp)
>                         continue;
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 1951291747c..630c5f52c4f 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -1816,7 +1816,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
>         if (device_path) {
>                 info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
>
> -               dp = efi_dp_concat(device_path, file_path, false);
> +               dp = efi_dp_concat(device_path, file_path, 0);
>                 if (!dp) {
>                         ret = EFI_OUT_OF_RESOURCES;
>                         goto failure;
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index aec224d8466..c8c8d54f733 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -276,10 +276,11 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>   *
>   * @dp1:           First device path
>   * @dp2:           Second device path
> - * @split_end_node: If true the two device paths will be concatenated and
> - *                  separated by an end node (DEVICE_PATH_SUB_TYPE_END).
> - *                 If false the second device path will be concatenated to the
> - *                 first one as-is.
> + * @split_end_node:
> + * * 0 to concatenate
> + * * 1 to concatenate with end node added as separator
> + * * size of dp1 excluding last end node to concatenate with end node as
> + *   separator in case dp1 contains an end node
>   *
>   * Return:
>   * concatenated device path or NULL. Caller must free the returned value
> @@ -287,7 +288,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>  struct
>  efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>                                const struct efi_device_path *dp2,
> -                              bool split_end_node)
> +                              size_t split_end_node)
>  {
>         struct efi_device_path *ret;
>         size_t end_size;
> @@ -301,10 +302,15 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>                 ret = efi_dp_dup(dp1);
>         } else {
>                 /* both dp1 and dp2 are non-null */
> -               unsigned sz1 = efi_dp_size(dp1);
> -               unsigned sz2 = efi_dp_size(dp2);
> +               size_t sz1;
> +               size_t sz2 = efi_dp_size(dp2);
>                 void *p;
>
> +               if (split_end_node < sizeof(struct efi_device_path))

Can we be more explicit here pls? Someone might misuse this in the future
split_end_node < =1 ? And we can document we can use values up to
sizeof(struct efi_device_path) if we ever need extra functionality

> +                       sz1 = efi_dp_size(dp1);
> +               else
> +                       sz1 = split_end_node;
> +
>                 if (split_end_node)
>                         end_size = 2 * sizeof(END);
>                 else
> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
> index c95dbfa9b5f..ac250bbfcc9 100644
> --- a/lib/efi_loader/efi_device_path_utilities.c
> +++ b/lib/efi_loader/efi_device_path_utilities.c
> @@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
>         const struct efi_device_path *src2)
>  {
>         EFI_ENTRY("%pD, %pD", src1, src2);
> -       return EFI_EXIT(efi_dp_concat(src1, src2, false));
> +       return EFI_EXIT(efi_dp_concat(src1, src2, 0));
>  }
>
>  /*
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
