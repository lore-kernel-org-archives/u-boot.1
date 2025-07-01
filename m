Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0A7C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 07:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED4F81FEE;
	Tue,  1 Jul 2025 09:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QO9I5ZHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDB682ADA; Tue,  1 Jul 2025 09:51:26 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D0118006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 09:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-714066c7bbbso59535077b3.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 00:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751356278; x=1751961078; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ikfEYJbjrtsQ4Pm1NB1DkPRPAOh7X31sDORv1IOpnH4=;
 b=QO9I5ZHyYKtWwEDALjrXsI/X7wJ3zdiCLQBipTAQhTViir7s5ZTxaya0LVsI/IjZes
 68q13tD4RLxYmT7QmiTqQtF89oWZ91gos4Fiqo68WCY/db03gaKOU2ixlOjawPTfhHlm
 UGsluNekzIGBQxgUSvKW9UCDGfFYCaPubdk2dvZIascewg4BaXDWOib82RwordAJ3h/O
 mY4gSneofR9UstB3gsc92URlEk1Q+8SH7Ng2c4gQ5Zwf75BqKmYoL5WO/ksaxjogsEWF
 aysbdMgf3Xh88IYTMrKhBG+Vc58STmLx7ya7OMV8ySybzq8OkZ5i2yjHUdO0C/BsiQSt
 U3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751356278; x=1751961078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ikfEYJbjrtsQ4Pm1NB1DkPRPAOh7X31sDORv1IOpnH4=;
 b=S7RweZMK6t8SJkiJxabIpmVTZhzYxZv078q0mWfXZnBatwubsld1PhgNeRwlGhyauE
 dOJaO1w3TiDD+pDYNtGbPB7MLfTPvQ5mr+SmM4BKqlayR94GE0LslRmCTPvM7nsFzMho
 CzeWMC2qNvRRX+aaRd4lz3H3gnQAn5nXq17Yx1fg7yKoRnk97LBOe3cBGOmBtQRdZyjD
 0jSYxwFVYu85AngFPPqVnvANzIt4x4yIANy9Cnp9EoD2C/ybxJdQxljdt0Z8pESDJUui
 EsYIMFy2rkESJy9Wyw3aLqPuQZwJSBEOF2EXoomC0zxogifZC+f8ckqu3QF5kCb+bhW2
 KjIg==
X-Gm-Message-State: AOJu0YwmLcJqsjhSwXhUpnSZRhaQ/TdPYdcg71K8nKyFBmiBK+F0cnxS
 QwYnkUKYXfk6c/5Kyx+9k8JebeLe5p6KqnTBqIyld3hFPbxkO6gyvatY9ui8l9q+eOzRc4nLnMz
 23SDW6UuZ7SvFkxHIqcvzA7TXk4rDvvi3NAoHMrIolQ==
X-Gm-Gg: ASbGncsK6THahQnXLXkCTjWJrQ7+fTEfKgzWD5cjciZdEb0wdS58/rP4ao9Bp3MNeap
 8/B3c4GwPj7dQHTZkfVN3JIKw+nUQ0UkWrNiERMw7JATELoWzdSV1HAsDmyJxBcATgcKkH92ZuZ
 nJsxQMZ4qu5wbXFEftrDR3R0PsEqiJCyeo1hVUFQgyGCpj
X-Google-Smtp-Source: AGHT+IHEOeTQ4Oz8ZEH7pLJlISOj4lEsBZOa+dne7Tl/qqteQp1RVEpH4ez5sn7bD3hrF+TeT7WBLobO49lkZjrElDU=
X-Received: by 2002:a05:690c:708b:b0:711:6419:5ce1 with SMTP id
 00721157ae682-715171c769bmr239145717b3.31.1751356278641; Tue, 01 Jul 2025
 00:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250627112509.264221-1-sughosh.ganu@linaro.org>
 <20250627112509.264221-2-sughosh.ganu@linaro.org>
In-Reply-To: <20250627112509.264221-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Jul 2025 10:50:42 +0300
X-Gm-Features: Ac12FXwE4cVei9K_9LFCytgO5IAAd5Temv2he9Rlgv-hS-1gpsNpWJSdDHLBtUA
Message-ID: <CAC_iWj+9WBOxjciXBTVa945qgse8nuet85YEeksS+tmg5k+RzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cmd: eficonfig: add support for URI device path
 based boot options
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Sughosh

[...]

> +
>  static struct eficonfig_item select_file_menu_items[] = {
>         {"Select File", eficonfig_process_select_file},
>         {"Clear", eficonfig_process_clear_file_selection},
> @@ -1042,16 +1101,30 @@ static struct eficonfig_item select_file_menu_items[] = {
>  efi_status_t eficonfig_process_show_file_option(void *data)
>  {
>         efi_status_t ret;
> +       unsigned int menu_count;
>         struct efimenu *efi_menu;
> +       struct eficonfig_item *menu_items;
> +       struct eficonfig_select_file_info *file_info = data;
> +
> +       menu_items = file_info->boot_file_option ? select_boot_file_menu_items :
> +               select_file_menu_items;

Why do we need boot_file_option? Won't the len of the URI be 0 if it's a file?

[...]

>
> +/**
> + * fill_dp_uri() - copy the URI string in the device path
> + * @dp:                pointer to the URI device path
> + * @uri_str:   URI string to be copied
> + *
> + * Copy the passed URI string to the URI device path. This
> + * requires utf8_utf16_strcpy() to copy the u16 string to
> + * the u8 array in the device path structure.
> + *
> + * Return: None
> + */
> +static void fill_dp_uri(struct efi_device_path *dp, u16 **uri_str)
> +{
> +       u16 *p = *uri_str;
> +       struct efi_device_path_uri *uridp;
> +
> +       uridp = (struct efi_device_path_uri *)dp;
> +
> +       utf8_utf16_strcpy(&p, uridp->uri);
> +}
> +
>  /**
>   * fill_file_info() - fill the file info from efi_device_path structure
>   *
> @@ -1392,10 +1486,13 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>         size_t len;
>         efi_status_t ret;
>         char *tmp = NULL, *p;
> +       u16 *current_path = NULL;
>         struct efi_load_option lo = {0};
>         efi_uintn_t dp_size;
>         struct efi_device_path *dp = NULL;
>         efi_uintn_t size = load_option_size;
> +       struct efi_device_path *dp_volume = NULL;
> +       struct efi_device_path *uri_dp = NULL;
>         struct efi_device_path *device_dp = NULL;
>         struct efi_device_path *initrd_dp = NULL;
>         struct efi_device_path *fdt_dp = NULL;
> @@ -1464,6 +1561,14 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>                 goto out;
>         }
>
> +       bo->file_info.uri = calloc(1, EFICONFIG_URI_MAX * sizeof(u16));
> +       if (!bo->file_info.uri) {
> +               ret =  EFI_OUT_OF_RESOURCES;
> +               goto out;
> +       }
> +
> +       bo->file_info.boot_file_option = true;
> +
>         /* copy the preset value */
>         if (load_option) {
>                 ret = efi_deserialize_load_option(&lo, load_option, &size);
> @@ -1481,7 +1586,10 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>                 u16_strcpy(bo->description, lo.label);
>
>                 /* EFI image file path is a first instance */
> -               if (lo.file_path)
> +               if (lo.file_path && EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE,
> +                                               MSG_URI))
> +                       fill_dp_uri(lo.file_path, &bo->file_info.uri);
> +               else

This else does something different now. Shouldn't it be else if (lo.file_path)>

>                         fill_file_info(lo.file_path, &bo->file_info, device_dp);
>

[...]

Thanks
/Ilias
