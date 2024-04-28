Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA26C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 13:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54FC58824A;
	Sun, 28 Apr 2024 15:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y4QG/5Fa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6112288274; Sun, 28 Apr 2024 15:30:16 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A5088233
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 15:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a58ebdd8b64so85382866b.0
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714311014; x=1714915814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qvC/TqGVGN6oMoUyKBb3T0Uz8F3ptzFmuJJ+w3mzid8=;
 b=Y4QG/5Fac5CaxcrFGoW9KppRU9rzRPhxgWZCdBI5iMFukzz+9F68rsIsZbreG2rZjB
 FiVPf805buXCI6x+qbiDX9brRb3bwRd8Ml7uKRDy2qpxV/rnLwSZN8j89W9mjD2xmmxs
 ylc9T+hmFwyp3qMoOOhQCBFxHHp0XOJYSBTqtqesdDcUNxaV0VlOf7WjT5fe77yJPxlv
 iVZbBlOmtzf8OagQJReRvjArEf5KDvDPLza9f80HlCVBJlESoWFZTfv7/0vYCKqBe2Ac
 PhfzNjDNaJP7iU6iFaAJRblmw/lCzWIVJ43qhl5U3vN5sL2/mSecJnYaA3Jawg0fcR8S
 oGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714311014; x=1714915814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qvC/TqGVGN6oMoUyKBb3T0Uz8F3ptzFmuJJ+w3mzid8=;
 b=owEmyJ4ShYEBdHyoauJSA64k7SCNk+uGWROhfdfHq5h+GgsiF2+Vw2LCTSnm6xXqmS
 6nAMSAonndI0I9hXknTJ23MnpB3QWVwhAWlqYV4IsTaRcn236PPlOs5+hTp37KUab5f3
 QG9qRU3HmBzuXkA7c/4FyaquGz3hMxbAJEM54Dgk0MwWnweUpUpx+Rbl/O2oZKGA4bd1
 gZVGWz18WJ5sgmro1SvNfD+3jAUZmTk65Te8YDDfQ36CzvVnj4yKQHuOnpJ00zVIHFyS
 zS8VcEICG6ui2t7hLtvwiV9VE7etfcAH+dXwJdZ2ev/JIZC5isIi7q0A9sRCCLINGP7/
 1lug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWViUm2gVC8fPGD+2LEAXF6dVTz8NqgaJzdVniuevW9R8xXfPcVQbW0tlp9yVoG3IXVUl0RHkegSLp6xOJ09nsr2S9ssw==
X-Gm-Message-State: AOJu0YzqHL2PIJOITW1qjWQHk3WFQY7eHejd4SMJDPz+C/IeWvvlXIv8
 vJ7+I8BjmTe/FWouFVfmpPz5JY+B+Q3CQUySOdNV5Kai9At6+VV7NfPY8ZPjxdFTBaZ5d9syHhq
 Fob6D6JeeTlhqDieQMZYlLTQffrmLOK9HGNIwB1wdNDqk/SB/ixg=
X-Google-Smtp-Source: AGHT+IEKZ+nUeOz2KhQk8uvAap5VgPP5q3NM+IkLnpNPm8zu4TN+A8ikMHJzOcU1Gyg4GtYsKzHRwZchS7CfcPnuU4g=
X-Received: by 2002:a17:906:c303:b0:a58:7aab:96bf with SMTP id
 s3-20020a170906c30300b00a587aab96bfmr5392260ejz.18.1714311013600; Sun, 28 Apr
 2024 06:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240426141321.232236-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 28 Apr 2024 16:29:37 +0300
Message-ID: <CAC_iWj+bREfgzcfV4Yc+2P8L0vM08qrC=PnbdtF+B3FEqe4ueA@mail.gmail.com>
Subject: Re: [RFC 03/14] efi_loader: simplify efi_dp_concat()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
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

On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> As we now have efi_dp_merge() we can use this function to replace
> efi_dp_concat(,,true) and remove the last parameter from efi_dp_concat()
> otherwise.
>

This patch looks correct, but I prefer keeping the existing efi_dp_concat as-is

Thanks
/Ilias
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/eficonfig.c                            | 22 +++++++++---------
>  cmd/efidebug.c                             | 17 +++++++++-----
>  include/efi_loader.h                       |  3 +--
>  lib/efi_loader/efi_bootbin.c               |  2 +-
>  lib/efi_loader/efi_bootmgr.c               |  2 +-
>  lib/efi_loader/efi_boottime.c              |  2 +-
>  lib/efi_loader/efi_device_path.c           | 26 ++++------------------
>  lib/efi_loader/efi_device_path_utilities.c |  2 +-
>  8 files changed, 31 insertions(+), 45 deletions(-)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 0ba92c60e03..1c57e66040b 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -531,7 +531,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
>         dp = efi_dp_shorten(dp_volume);
>         if (!dp)
>                 dp = dp_volume;
> -       dp = efi_dp_concat(dp, &fp->dp, false);
> +       dp = efi_dp_concat(dp, &fp->dp);
>         free(buf);
>
>         return dp;
> @@ -1485,7 +1485,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>                         goto out;
>                 }
>                 initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
> -                                         dp, false);
> +                                         dp);
>                 efi_free_pool(dp);
>         }
>
> @@ -1494,17 +1494,17 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>                 ret = EFI_OUT_OF_RESOURCES;
>                 goto out;
>         }
> -       final_dp_size = efi_dp_size(dp) + sizeof(END);
> +
> +       final_dp = dp;
> +       final_dp_size = efi_dp_size(final_dp) + sizeof(END);
> +
>         if (initrd_dp) {
> -               final_dp = efi_dp_concat(dp, initrd_dp, true);
> -               final_dp_size += efi_dp_size(initrd_dp) + sizeof(END);
> -       } else {
> -               final_dp = efi_dp_dup(dp);
> +               final_dp = efi_dp_merge(final_dp, &final_dp_size, initrd_dp);
> +               if (!final_dp) {
> +                       ret = EFI_OUT_OF_RESOURCES;
> +                       goto out;
> +               }
>         }
> -       efi_free_pool(dp);
> -
> -       if (!final_dp)
> -               goto out;
>
>         if (utf16_utf8_strlen(bo->optional_data)) {
>                 len = utf16_utf8_strlen(bo->optional_data) + 1;
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index a587860e2a5..93ba16efc7d 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -697,7 +697,7 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
>                 short_fp = tmp_fp;
>
>         initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
> -                                 short_fp, false);
> +                                 short_fp);
>
>  out:
>         efi_free_pool(tmp_dp);
> @@ -917,11 +917,16 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>                 goto out;
>         }
>
> -       final_fp = efi_dp_concat(file_path, initrd_dp, true);
> -       if (!final_fp) {
> -               printf("Cannot create final device path\n");
> -               r = CMD_RET_FAILURE;
> -               goto out;
> +       final_fp = file_path;
> +       fp_size = efi_dp_size(final_fp) + sizeof(END);
> +
> +       if (initrd_dp) {
> +               final_fp = efi_dp_merge(final_fp, &fp_size, initrd_dp);
> +               if (!final_fp) {
> +                       printf("Cannot create final device path\n");
> +                       r = CMD_RET_FAILURE;
> +                       goto out;
> +               }
>         }
>
>         lo.file_path = final_fp;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index a7d7b8324f1..0ac04990b8e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -948,8 +948,7 @@ struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
>                                      efi_uintn_t *size,
>                                      const struct efi_device_path *dp2);
>  struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> -                                     const struct efi_device_path *dp2,
> -                                     bool split_end_node);
> +                                     const struct efi_device_path *dp2);
>  struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
>  efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
>                                          efi_uintn_t *size);
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index b7910f78fb6..745b941b6ca 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -150,7 +150,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>                 msg_path = file_path;
>         } else {
>                 file_path = efi_dp_concat(bootefi_device_path,
> -                                         bootefi_image_path, false);
> +                                         bootefi_image_path);
>                 msg_path = bootefi_image_path;
>                 log_debug("Loaded from disk\n");
>         }
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 4ac519228a6..db394df6bf4 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -130,7 +130,7 @@ static efi_status_t try_load_from_file_path(efi_handle_t *fs_handles,
>                 if (!dp)
>                         continue;
>
> -               dp = efi_dp_concat(dp, fp, false);
> +               dp = efi_dp_concat(dp, fp);
>                 if (!dp)
>                         continue;
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 1951291747c..33f03c0cb0f 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -1816,7 +1816,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
>         if (device_path) {
>                 info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
>
> -               dp = efi_dp_concat(device_path, file_path, false);
> +               dp = efi_dp_concat(device_path, file_path);
>                 if (!dp) {
>                         ret = EFI_OUT_OF_RESOURCES;
>                         goto failure;
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index 16cbe41d32f..75fe95c9c1e 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -307,21 +307,15 @@ struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
>   *
>   * @dp1:           First device path
>   * @dp2:           Second device path
> - * @split_end_node: If true the two device paths will be concatenated and
> - *                  separated by an end node (DEVICE_PATH_SUB_TYPE_END).
> - *                 If false the second device path will be concatenated to the
> - *                 first one as-is.
>   *
>   * Return:
>   * concatenated device path or NULL. Caller must free the returned value
>   */
>  struct
>  efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> -                              const struct efi_device_path *dp2,
> -                              bool split_end_node)
> +                              const struct efi_device_path *dp2)
>  {
>         struct efi_device_path *ret;
> -       size_t end_size;
>
>         if (!dp1 && !dp2) {
>                 /* return an end node */
> @@ -333,29 +327,17 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>         } else {
>                 /* both dp1 and dp2 are non-null */
>                 unsigned sz1 = efi_dp_size(dp1);
> -               unsigned sz2 = efi_dp_size(dp2);
> +               /* the end node of the second device path has to be retained */
> +               unsigned int sz2 = efi_dp_size(dp2) + sizeof(END);
>                 void *p;
>
> -               if (split_end_node)
> -                       end_size = 2 * sizeof(END);
> -               else
> -                       end_size = sizeof(END);
> -               p = efi_alloc(sz1 + sz2 + end_size);
> +               p = efi_alloc(sz1 + sz2);
>                 if (!p)
>                         return NULL;
>                 ret = p;
>                 memcpy(p, dp1, sz1);
>                 p += sz1;
> -
> -               if (split_end_node) {
> -                       memcpy(p, &END, sizeof(END));
> -                       p += sizeof(END);
> -               }
> -
> -               /* the end node of the second device path has to be retained */
>                 memcpy(p, dp2, sz2);
> -               p += sz2;
> -               memcpy(p, &END, sizeof(END));
>         }
>
>         return ret;
> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
> index c95dbfa9b5f..5f06602dba6 100644
> --- a/lib/efi_loader/efi_device_path_utilities.c
> +++ b/lib/efi_loader/efi_device_path_utilities.c
> @@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
>         const struct efi_device_path *src2)
>  {
>         EFI_ENTRY("%pD, %pD", src1, src2);
> -       return EFI_EXIT(efi_dp_concat(src1, src2, false));
> +       return EFI_EXIT(efi_dp_concat(src1, src2));
>  }
>
>  /*
> --
> 2.43.0
>
