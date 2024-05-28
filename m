Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A1FC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 15:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A708850A;
	Tue, 28 May 2024 17:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SPG3EQ60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A6A884DC; Tue, 28 May 2024 17:37:26 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE93F88511
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7007324a568so735986b3a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716910642; x=1717515442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b4F0KWpbdsxJPoPv02v91i2+PZ2HvOTBa4fQsm2gpQg=;
 b=SPG3EQ60hVnVOwC7khLXxt9HkoCI7RIUMVQcPrpnw2mCrHVM3uSgFdqjKYkjrQwUpp
 pxBc+kh2pHEocnc6hvodygACAR59aiob+zQCeO6EmC2Iqsu0CZCE5oTY8TI5BkeCuCBe
 2UVRQRtsjQqaH8AsX9wnoa+jTQ2Fe4jZXDgemZCex9AvWZQhINTGbybNlD+zeNMc9S4c
 irsmokRSFBErFO1RzpUeCALHcCKbcT9gzhNrVvQez3H7W+LipTrDABLN9/z9PHAnQwPv
 QR8BgTyrweM9oInjUhFIXXPsIIzEL/KSqmYzKrSZlZu5heSPZB71dIJ58pYdkfWyyWK4
 HyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910642; x=1717515442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b4F0KWpbdsxJPoPv02v91i2+PZ2HvOTBa4fQsm2gpQg=;
 b=D3TskomZz9zTT7ffS90KEKv/4zdNIIHr+8NzYWHdLxPUDVFh0CrCU9PE2ExuQmGpX1
 UTEY4HwmUzCRazFl+U58hmZGmbYpDOGZKi5f27GqYyAcX6BxgQp1nOo0QolwKoJ4M16V
 B5bD9maXvOXFltcPOizYIRUmTiwIOranS0aa2v9LaPs6HJ7a0OG53qrVyBjheRAOHvv8
 ESBNUzKNKTSPKz11qEuWPGSawy//2PxmTeo7OkEkuBaBPTsOiw0og3eZaQEtu7VWvsFw
 ABZWZzetf5MeiCJQYkJuWG0y+yqUxMy8tq0vYu39QDEFs+AmzqrUpHX0XnA1wlL4szjU
 xNSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPGCYFiiZ/6BBqfk8PQZNClxJz6YcAOwEoPoFRTEheLN+nSRP46JAujdR2jpW5ImXACu37OAvaso1QJ6P6RFC4npHzvA==
X-Gm-Message-State: AOJu0Yx2u+uZwmDBsMPrwNJgGKOR+FJ1CHgFEortDq5f07FwmD/hZjkM
 yR+LYYlPNUGOxyVOaFy0f8AfC68vOhIZ7T41Zp0bqCuk9vEz2CFQpjhyIdZMUztyqFs2ocLsJJc
 0zuL3czhmnWA6vytxrcXa2vf/BcSE1QE9YqJIeA==
X-Google-Smtp-Source: AGHT+IF4eAe6a8M2TWaTqnoD7cMP2+kYy7+hevY0CuNag88qLWfehcZnZxTZsWSgmSoLmQIVX3ak8QOl/p249gq5U7I=
X-Received: by 2002:a17:90b:204:b0:2bf:5bb1:6d79 with SMTP id
 98e67ed59e1d1-2bf5ef1de67mr12671655a91.26.1716910642241; Tue, 28 May 2024
 08:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 18:36:45 +0300
Message-ID: <CAC_iWjLpp7CAs=LvxV0=UFspeBKurSnhAY=tUWi5suEhW19Zdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] cmd: efidebug: add support for setting fdt
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
> We already support creating a load option where the device-path
> field contains the concatenation of the binary device-path and
> optionally the device path of the initrd which we expose via the
> EFI_LOAD_FILE2_PROTOCOL.
>
> Allow to append another device-path pointing to the device-tree
> identified by the device-tree GUID.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Rename create_initrd_dp() to create_lo_dp_part().
>         Use enum as parameter for create_lo_dp_part().
>         Use function efi_load_option_dp_join() to avoid code duplication.
> ---
>  cmd/efidebug.c | 130 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 93 insertions(+), 37 deletions(-)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 762027daf8a..966b4b83361 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -654,38 +654,80 @@ static int do_efi_show_tables(struct cmd_tbl *cmdtp, int flag,
>  }
>
>  /**
> - * create_initrd_dp() - create a special device for our Boot### option
> + * enum efi_lo_dp_part - part of device path in load option
> + */
> +enum efi_lo_dp_part {
> +       /** @EFI_LO_DP_PART_BINARY: binary */
> +       EFI_LO_DP_PART_BINARY,
> +       /** @EFI_LO_DP_PART_INITRD: initial RAM disk */
> +       EFI_LO_DP_PART_INITRD,
> +       /** EFI_LP_DP_PART_FDT: device-tree */
> +       EFI_LP_DP_PART_FDT,
> +};
> +
> +/**
> + * create_lo_dp() - create a special device path for our Boot### option
>   *
>   * @dev:       device
>   * @part:      disk partition
>   * @file:      filename
>   * @shortform: create short form device path
> + * @type:      part of device path to be created
>   * Return:     pointer to the device path or ERR_PTR
>   */
>  static
> -struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
> -                                        const char *file, int shortform)
> +struct efi_device_path *create_lo_dp_part(const char *dev, const char *part,
> +                                         const char *file, bool shortform,
> +                                         enum efi_lo_dp_part type)
>
>  {
>         struct efi_device_path *tmp_dp = NULL, *tmp_fp = NULL, *short_fp = NULL;
> -       struct efi_device_path *initrd_dp = NULL;
> +       struct efi_device_path *dp = NULL;
> +       const struct efi_device_path *dp_prefix;
>         efi_status_t ret;
> -       const struct efi_initrd_dp id_dp = {
> +       const struct efi_initrd_dp fdt_dp = {
> +               .vendor = {
> +                       {
> +                       DEVICE_PATH_TYPE_MEDIA_DEVICE,
> +                       DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> +                       sizeof(fdt_dp.vendor),
> +                       },
> +                       EFI_FDT_GUID,
> +               },
> +               .end = {
> +                       DEVICE_PATH_TYPE_END,
> +                       DEVICE_PATH_SUB_TYPE_END,
> +                       sizeof(fdt_dp.end),
> +               }
> +       };
> +       const struct efi_initrd_dp initrd_dp = {
>                 .vendor = {
>                         {
>                         DEVICE_PATH_TYPE_MEDIA_DEVICE,
>                         DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> -                       sizeof(id_dp.vendor),
> +                       sizeof(initrd_dp.vendor),
>                         },
>                         EFI_INITRD_MEDIA_GUID,
>                 },
>                 .end = {
>                         DEVICE_PATH_TYPE_END,
>                         DEVICE_PATH_SUB_TYPE_END,
> -                       sizeof(id_dp.end),
> +                       sizeof(initrd_dp.end),
>                 }
>         };
>
> +       switch (type) {
> +       case EFI_LO_DP_PART_INITRD:
> +               dp_prefix = &initrd_dp.vendor.dp;
> +               break;
> +       case EFI_LP_DP_PART_FDT:
> +               dp_prefix = &fdt_dp.vendor.dp;
> +               break;
> +       default:
> +               dp_prefix = NULL;
> +               break;
> +       }
> +
>         ret = efi_dp_from_name(dev, part, file, &tmp_dp, &tmp_fp);
>         if (ret != EFI_SUCCESS) {
>                 printf("Cannot create device path for \"%s %s\"\n", part, file);
> @@ -696,13 +739,12 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
>         if (!short_fp)
>                 short_fp = tmp_fp;
>
> -       initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
> -                                 short_fp, 0);
> +       dp = efi_dp_concat(dp_prefix, short_fp, 0);
>
>  out:
>         efi_free_pool(tmp_dp);
>         efi_free_pool(tmp_fp);
> -       return initrd_dp;
> +       return dp;
>  }
>
>  /**
> @@ -793,9 +835,8 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>         efi_guid_t guid;
>         u16 *label;
>         struct efi_device_path *file_path = NULL;
> -       struct efi_device_path *fp_free = NULL;
> -       struct efi_device_path *final_fp = NULL;
>         struct efi_device_path *initrd_dp = NULL;
> +       struct efi_device_path *fdt_dp = NULL;
>         struct efi_load_option lo;
>         void *data = NULL;
>         efi_uintn_t size;
> @@ -843,22 +884,31 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>                         lo.label = label; /* label will be changed below */
>
>                         /* file path */
> -                       ret = efi_dp_from_name(argv[3], argv[4], argv[5],
> -                                              NULL, &fp_free);
> -                       if (ret != EFI_SUCCESS) {
> -                               printf("Cannot create device path for \"%s %s\"\n",
> -                                      argv[3], argv[4]);
> +                       file_path = create_lo_dp_part(argv[3], argv[4], argv[5],
> +                                                     shortform,
> +                                                     EFI_LO_DP_PART_BINARY);
> +                       argc -= 5;
> +                       argv += 5;
> +                       break;
> +               case 'd':
> +                       shortform = 1;
> +                       fallthrough;
> +               case 'D':
> +                       if (argc < 3 || fdt_dp) {
> +                               r = CMD_RET_USAGE;
> +                               goto out;
> +                       }
> +
> +                       fdt_dp = create_lo_dp_part(argv[1], argv[2], argv[3],
> +                                                  shortform,
> +                                                  EFI_LP_DP_PART_FDT);
> +                       if (!fdt_dp) {
> +                               printf("Cannot add a device-tree\n");
>                                 r = CMD_RET_FAILURE;
>                                 goto out;
>                         }
> -                       if (shortform)
> -                               file_path = efi_dp_shorten(fp_free);
> -                       if (!file_path)
> -                               file_path = fp_free;
> -                       fp_size += efi_dp_size(file_path) +
> -                               sizeof(struct efi_device_path);
> -                       argc -= 5;
> -                       argv += 5;
> +                       argc -= 3;
> +                       argv += 3;
>                         break;
>                 case 'i':
>                         shortform = 1;
> @@ -869,8 +919,9 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>                                 goto out;
>                         }
>
> -                       initrd_dp = create_initrd_dp(argv[1], argv[2], argv[3],
> -                                                    shortform);
> +                       initrd_dp = create_lo_dp_part(argv[1], argv[2], argv[3],
> +                                                     shortform,
> +                                                     EFI_LO_DP_PART_INITRD);
>                         if (!initrd_dp) {
>                                 printf("Cannot add an initrd\n");
>                                 r = CMD_RET_FAILURE;
> @@ -878,8 +929,6 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>                         }
>                         argc -= 3;
>                         argv += 3;
> -                       fp_size += efi_dp_size(initrd_dp) +
> -                               sizeof(struct efi_device_path);
>                         break;
>                 case 's':
>                         if (argc < 1 || lo.optional_data) {
> @@ -897,7 +946,6 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>                                                      &file_path, &fp_size);
>                                 if (r != CMD_RET_SUCCESS)
>                                         goto out;
> -                               fp_free = file_path;
>                                 argc -= 3;
>                                 argv += 3;
>                         } else{
> @@ -917,14 +965,14 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>                 goto out;
>         }
>
> -       final_fp = efi_dp_concat(file_path, initrd_dp, 1);
> -       if (!final_fp) {
> +       ret = efi_load_option_dp_join(&file_path, &fp_size, initrd_dp, fdt_dp);
> +       if (ret != EFI_SUCCESS) {
>                 printf("Cannot create final device path\n");
>                 r = CMD_RET_FAILURE;
>                 goto out;
>         }
>
> -       lo.file_path = final_fp;
> +       lo.file_path = file_path;
>         lo.file_path_length = fp_size;
>
>         size = efi_serialize_load_option(&lo, (u8 **)&data);
> @@ -945,9 +993,9 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>
>  out:
>         free(data);
> -       efi_free_pool(final_fp);
>         efi_free_pool(initrd_dp);
> -       efi_free_pool(fp_free);
> +       efi_free_pool(fdt_dp);
> +       efi_free_pool(file_path);
>         free(lo.label);
>
>         return r;
> @@ -1009,7 +1057,8 @@ static int do_efi_boot_rm(struct cmd_tbl *cmdtp, int flag,
>   */
>  static void show_efi_boot_opt_data(u16 *varname16, void *data, size_t *size)
>  {
> -       struct efi_device_path *initrd_path = NULL;
> +       struct efi_device_path *fdt_path;
> +       struct efi_device_path *initrd_path;
>         struct efi_load_option lo;
>         efi_status_t ret;
>
> @@ -1038,6 +1087,12 @@ static void show_efi_boot_opt_data(u16 *varname16, void *data, size_t *size)
>                 efi_free_pool(initrd_path);
>         }
>
> +       fdt_path = efi_dp_from_lo(&lo, &efi_guid_fdt);
> +       if (fdt_path) {
> +               printf("  device-tree path: %pD\n", fdt_path);
> +               efi_free_pool(fdt_path);
> +       }
> +
>         printf("  data:\n");
>         print_hex_dump("    ", DUMP_PREFIX_OFFSET, 16, 1,
>                        lo.optional_data, *size, true);
> @@ -1565,8 +1620,9 @@ U_BOOT_LONGHELP(efidebug,
>         "\n"
>         "efidebug boot add - set UEFI BootXXXX variable\n"
>         "  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
> +       "  -d|-D <interface> <devnum>[:<part>] <device-tree file path>\n"
>         "  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
> -       "  (-b, -i for short form device path)\n"
> +       "  (-b, -d, -i for short form device path)\n"
>  #if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
>         "  -u <bootid> <label> <uri>\n"
>  #endif
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
