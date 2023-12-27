Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B85FC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 14:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C759E878A1;
	Wed, 27 Dec 2023 15:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="De8eh1GG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A58E878AF; Wed, 27 Dec 2023 15:38:10 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EEF387866
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 15:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e77a2805fso2155985e87.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 06:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703687887; x=1704292687; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ONP4WhGf1a3VviLs10tKvbgb5pkZNvPAHnLFUnie0eA=;
 b=De8eh1GGU/XHx+vabuiehuI3og7dp6ApPY97GYW0gEruk6yBKzMVhLjFV/rZcM1UZn
 /PRmFJ926vSME8Z0RpmQaV98xbLyJYbWdqCC2g5RB0WsijZhFPVC2JlM1Iv45eE6Ny3U
 qmQO13OMgfZ0pV34RHV3t16cTxY5+XgR17EehrZIhSbRw+uLbdMUS4vsC9IbYhIvkeP/
 aBJOpQVaBFUHtAbGefcjD8tzkojE1tXvvxQf4kAWRAFF7oppTfH4fg6udyzLc4Iu4QuP
 /qRDloCMo+71gLYDC0ndHsNPqPp3kaEAhNki1Xh/rMaWA0boWP2yHq6zC7GYuDIjpJZu
 Rgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703687887; x=1704292687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ONP4WhGf1a3VviLs10tKvbgb5pkZNvPAHnLFUnie0eA=;
 b=uEkZ5QflHVMiyKvFBnntyYSycby83omobTO2t5fYGKnO3xiRTpOLphdNbj2lONKCAk
 xx3sa0aT6O5WnsBn/0g4j7Gp+AgDQPTE4z0sZyZgTDfjsomKp/Vunpm7L9BUSC1kEhMb
 mSiSBAFoT4Lucnk8KvXSwnAeOHop9BBT2xFuXOzD6rKhn6SKmilvVal9nxVGYQKB5Z1q
 am+l/KeErBdk+TRPszszn8Be1tMfr6FpUHz+llKTglCYoweVUwpu/EH7XYtITLrEVUPN
 jEhs5hbbeHuhW+oiy2z6FXMqpjGSq7HgHR2kDvpmCdV65bB1A13ZF9pGc4bCNHtjhgVE
 27Pg==
X-Gm-Message-State: AOJu0YwnfdxudEiWCZYIM8lPsVq/yWFxbrsHZW/uqH4NLv1Yr/ig7WTb
 jDQztCACU2FyPt2O8pmd62k687LNrEeRq6JYDX7O2PI4tk6g2A==
X-Google-Smtp-Source: AGHT+IHy0TgVf/rbEbpa3FotBWxph4zVH7F+O/LmO8F95WoRav5m1ICeA4QvPafbk1BGihPiEYQ1q49FLdU4tsmUgbU=
X-Received: by 2002:ac2:5e63:0:b0:50e:77b1:a3a7 with SMTP id
 a3-20020ac25e63000000b0050e77b1a3a7mr1243859lfr.188.1703687887209; Wed, 27
 Dec 2023 06:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
 <20231221095258.592275-2-masahisa.kojima@linaro.org>
In-Reply-To: <20231221095258.592275-2-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 16:37:31 +0200
Message-ID: <CAC_iWj+=7cT0kqw_RYBBqKO=10FRWdVirNYymAFvjBBi1LABHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fwu: fix fwu_get_image_index interface
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Thu, 21 Dec 2023 at 11:54, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> The capsule update uses the DFU framework for updating
> storage. fwu_get_image_index() currently returns the
> image_index calculated by (dfu_alt_num + 1), but this is
> different from the image_index in UEFI terminology.
>
> Since capsule update implementation calls dfu_write_by_alt
> function, it is better that FWU returns the dfu_alt_num.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  include/fwu.h                 | 13 +++++--------
>  lib/efi_loader/efi_firmware.c | 11 +++++++++--
>  lib/fwu_updates/fwu.c         | 32 ++++++++++++--------------------
>  3 files changed, 26 insertions(+), 30 deletions(-)
>
> diff --git a/include/fwu.h b/include/fwu.h
> index ac5c5de870..eb5638f4f3 100644
> --- a/include/fwu.h
> +++ b/include/fwu.h
> @@ -122,21 +122,18 @@ int fwu_get_active_index(uint *active_idxp);
>  int fwu_set_active_index(uint active_idx);
>
>  /**
> - * fwu_get_image_index() - Get the Image Index to be used for capsule update
> - * @image_index: The Image Index for the image
> - *
> - * The FWU multi bank update feature computes the value of image_index at
> - * runtime, based on the bank to which the image needs to be written to.
> - * Derive the image_index value for the image.
> + * fwu_get_dfu_alt_num() - Get the dfu_alt_num to be used for capsule update
> + * @image_index:       The Image Index for the image
> + * @alt_num:           pointer to store dfu_alt_num
>   *
>   * Currently, the capsule update driver uses the DFU framework for
>   * the updates. This function gets the DFU alt number which is to
> - * be used as the Image Index
> + * be used for capsule update.
>   *
>   * Return: 0 if OK, -ve on error
>   *
>   */
> -int fwu_get_image_index(u8 *image_index);
> +int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num);
>
>  /**
>   * fwu_revert_boot_index() - Revert the active index in the FWU metadata
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 9abb29f1df..9b8630625f 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -611,6 +611,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>         u16 **abort_reason)
>  {
>         int ret;
> +       u8 dfu_alt_num;
>         efi_status_t status;
>         struct fmp_state state = { 0 };
>
> @@ -625,19 +626,25 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>         if (status != EFI_SUCCESS)
>                 return EFI_EXIT(status);
>
> +       /*
> +        * dfu_alt_num is assigned from 0 while image_index starts from 1.
> +        * dfu_alt_num is calculated by (image_index - 1) when multi bank update
> +        * is not used.
> +        */
> +       dfu_alt_num = image_index - 1;
>         if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
>                 /*
>                  * Based on the value of update bank, derive the
>                  * image index value.
>                  */
> -               ret = fwu_get_image_index(&image_index);
> +               ret = fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
>                 if (ret) {
>                         log_debug("Unable to get FWU image_index\n");
>                         return EFI_EXIT(EFI_DEVICE_ERROR);
>                 }
>         }
>
> -       if (dfu_write_by_alt(image_index - 1, (void *)image, image_size,
> +       if (dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
>                              NULL, NULL))
>                 return EFI_EXIT(EFI_DEVICE_ERROR);
>
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index b580574015..86518108c2 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -125,16 +125,14 @@ static int in_trial_state(struct fwu_mdata *mdata)
>         return 0;
>  }
>
> -static int fwu_get_image_type_id(u8 *image_index, efi_guid_t *image_type_id)
> +static int fwu_get_image_type_id(u8 image_index, efi_guid_t *image_type_id)
>  {
> -       u8 index;
>         int i;
>         struct efi_fw_image *image;
>
> -       index = *image_index;
>         image = update_info.images;
>         for (i = 0; i < update_info.num_images; i++) {
> -               if (index == image[i].image_index) {
> +               if (image_index == image[i].image_index) {
>                         guidcpy(image_type_id, &image[i].image_type_id);
>                         return 0;
>                 }
> @@ -332,24 +330,20 @@ int fwu_set_active_index(uint active_idx)
>  }
>
>  /**
> - * fwu_get_image_index() - Get the Image Index to be used for capsule update
> - * @image_index: The Image Index for the image
> - *
> - * The FWU multi bank update feature computes the value of image_index at
> - * runtime, based on the bank to which the image needs to be written to.
> - * Derive the image_index value for the image.
> + * fwu_get_dfu_alt_num() - Get the dfu_alt_num to be used for capsule update
> + * @image_index:       The Image Index for the image
> + * @alt_num:           pointer to store dfu_alt_num
>   *
>   * Currently, the capsule update driver uses the DFU framework for
>   * the updates. This function gets the DFU alt number which is to
> - * be used as the Image Index
> + * be used for capsule update.
>   *
>   * Return: 0 if OK, -ve on error
>   *
>   */
> -int fwu_get_image_index(u8 *image_index)
> +int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num)
>  {
>         int ret, i;
> -       u8 alt_num;
>         uint update_bank;
>         efi_guid_t *image_guid, image_type_id;
>         struct fwu_mdata *mdata = &g_mdata;
> @@ -365,7 +359,7 @@ int fwu_get_image_index(u8 *image_index)
>         ret = fwu_get_image_type_id(image_index, &image_type_id);
>         if (ret) {
>                 log_debug("Unable to get image_type_id for image_index %u\n",
> -                         *image_index);
> +                         image_index);
>                 goto out;
>         }
>
> @@ -380,15 +374,13 @@ int fwu_get_image_index(u8 *image_index)
>                         img_entry = &mdata->img_entry[i];
>                         img_bank_info = &img_entry->img_bank_info[update_bank];
>                         image_guid = &img_bank_info->image_uuid;
> -                       ret = fwu_plat_get_alt_num(g_dev, image_guid, &alt_num);
> -                       if (ret) {
> +                       ret = fwu_plat_get_alt_num(g_dev, image_guid, alt_num);
> +                       if (ret)
>                                 log_debug("alt_num not found for partition with GUID %pUs\n",
>                                           image_guid);
> -                       } else {
> +                       else
>                                 log_debug("alt_num %d for partition %pUs\n",
> -                                         alt_num, image_guid);
> -                               *image_index = alt_num + 1;
> -                       }
> +                                         *alt_num, image_guid);
>
>                         goto out;
>                 }
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
