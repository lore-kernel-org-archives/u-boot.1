Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8439BC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 06:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 454AE87703;
	Fri, 10 Nov 2023 07:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EA5VtE68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD99877BB; Fri, 10 Nov 2023 07:50:11 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB3E86F6C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 07:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c51682fddeso30709281fa.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 22:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699599008; x=1700203808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i469lctJkpSDSiVd7mF87pUszdm59Oh/4dVsqt+ubNQ=;
 b=EA5VtE68JQk2EtCOblOtaZlxoEs+GsgbK2AXszRvIUUd+iI7QhcKPa5KwrblT5tkK0
 AJWARmjYcvPGm/A23t7HaGdbf7h4H31EMcg2cj6NWAuqYWSs1TPRkyv8pWE+u+b0/ckW
 IcUvkqhlLGbbuIQ0dptWy63gOBZH1pNhKA3GrnDexaw42zw7zssWrk+9AOROX5h7nwIR
 0Qe7tsL0npyvB1sO7VqNAUIrjm9VfAsWd3PzmtnYHU3OqIzUDib+zJM+/JkTVL1GuHcp
 8bu/t8erJp7bH24u5tVkq/1qx3bmq6XqEzgzQB9bu+2I0Xh2gdH7R2wgA8u9g1oUrMfs
 frug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699599008; x=1700203808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i469lctJkpSDSiVd7mF87pUszdm59Oh/4dVsqt+ubNQ=;
 b=Vtg3u0yoh9lz+Q95thHQAOYC0YPThNOIQ1F7bvJ7qefOPxMaeKMLsM+uYde+YiIELn
 zoaKVT9mW416XQtftG45/3zkIuXwr4NvJmKxE+qQYeZ3OZEVWleMhHZ/xMis7GZXqipA
 CpDrb9TN21F34lkHWOSjUx1tGy6LTFG6xuKYgtRc4XdVRbdMfaMruOLhTYe3nXzLN6ur
 bywL8S4CQus0RFzHEAGUjM03NGJzL23nDgep7RjpLi0A3hIc8nOx+2CY+XweNE82utcK
 tdSufiELlejJZhACCRowtyxztWhwoS0PDKV+V/y0IBdvroac3WIHsKmPPODRzhheuEGc
 SNdw==
X-Gm-Message-State: AOJu0Ywcb7Ca0YHaCMtc6+R/J6wn/kCFPLKdfepZwC0nIwIXJAOFPdsY
 N3IoIFTk97iyPm8wnU+nRDNjEApaH/tFThub2S6pSg==
X-Google-Smtp-Source: AGHT+IEnX2mOuuG13unidRzFziE51gHz09AoHoj3aUTPxpU0ro63v/TP/oxRFAW3oTtpvRKgtwMRbeJzw03kISu54K8=
X-Received: by 2002:a05:6512:e99:b0:509:542c:9d40 with SMTP id
 bi25-20020a0565120e9900b00509542c9d40mr640361lfb.32.1699599008038; Thu, 09
 Nov 2023 22:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
 <20231110042542.3797301-8-masahisa.kojima@linaro.org>
In-Reply-To: <20231110042542.3797301-8-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Nov 2023 08:49:32 +0200
Message-ID: <CAC_iWjKvgTwiC==bOfr+WWa0s2XSJoD+D7VPBXk_TtDroQxDpg@mail.gmail.com>
Subject: Re: [PATCH v12 7/9] efi_loader: support boot from URI device path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

Hi Kojima-san

Going through the patch one last time before I merge it I noticed some
memory leaks

On Fri, 10 Nov 2023 at 06:27, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This supports to boot from the URI device path.
> When user selects the URI device path, bootmgr downloads
> the file using wget into the address specified by loadaddr
> env variable.
> If the file is .iso or .img file, mount the image with blkmap
> then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> Since boot option indicating the default file is automatically
> created when new disk is detected, system can boot by selecting
> the automatically created blkmap boot option.
> If the file is PE-COFF file, load and start the downloaded file.
>
> The buffer used to download the ISO image file must be
> reserved to avoid the unintended access to the image and
> expose the ramdisk to the OS.
> For PE-COFF file case, this memory reservation is done
> in LoadImage Boot Service.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

[...]

> +
> +/**
> + * efi_bootmgr_image_return_notify() - return to efibootmgr callback
> + *
> + * @event:     the event for which this notification function is registered
> + * @context:   event context
> + */
> +static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
> +                                                  void *context)
> +{
> +       efi_status_t ret;
> +
> +       EFI_ENTRY("%p, %p", event, context);
> +       ret = efi_bootmgr_release_uridp_resource(context);
> +       EFI_EXIT(ret);
> +}
> +
> +/**
> + * try_load_from_uri_path() - Handle the URI device path
> + *
> + * @uridp:     uri device path
> + * @lo_label:  label of load option
> + * @handle:    pointer to handle for newly installed image
> + * Return:     status code
> + */
> +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> +                                          u16 *lo_label,
> +                                          efi_handle_t *handle)
> +{
> +       char *s;
> +       int err;
> +       int uri_len;
> +       efi_status_t ret;
> +       void *source_buffer;
> +       efi_uintn_t source_size;
> +       struct uridp_context *ctx;
> +       struct udevice *blk = NULL;
> +       struct efi_event *event = NULL;
> +       efi_handle_t mem_handle = NULL;
> +       struct efi_device_path *loaded_dp;
> +       static ulong image_size, image_addr;
> +
> +       ctx = calloc(1, sizeof(struct uridp_context));
> +       if (!ctx)
> +               return EFI_OUT_OF_RESOURCES;

ctx is allocated here

> +
> +       s = env_get("loadaddr");
> +       if (!s) {
> +               log_err("Error: loadaddr is not set\n");
> +               return EFI_INVALID_PARAMETER;

Should be freed here

> +       }
> +       image_addr = hextoul(s, NULL);
> +       err = wget_with_dns(image_addr, uridp->uri);
> +       if (err < 0)
> +               return EFI_INVALID_PARAMETER;

and here

> +       image_size = env_get_hex("filesize", 0);
> +       if (!image_size)
> +               return EFI_INVALID_PARAMETER;

and here

> +
> +       /*
> +        * If the file extension is ".iso" or ".img", mount it and try to load
> +        * the default file.
> +        * If the file is PE-COFF image, load the downloaded file.
> +        */
> +       uri_len = strlen(uridp->uri);
> +       if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> +           !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> +               ret = prepare_loaded_image(lo_label, image_addr, image_size,
> +                                          &loaded_dp, &blk);
> +               if (ret != EFI_SUCCESS)
> +                       goto err;
> +
> +               source_buffer = NULL;
> +               source_size = 0;
> +       } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> +               /*
> +                * loaded_dp must exist until efi application returns,
> +                * will be freed in return_to_efibootmgr event callback.
> +                */
> +               loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> +                                           (uintptr_t)image_addr, image_size);
> +               ret = efi_install_multiple_protocol_interfaces(
> +                       &mem_handle, &efi_guid_device_path, loaded_dp, NULL);
> +               if (ret != EFI_SUCCESS)
> +                       goto err;
> +
> +               source_buffer = (void *)image_addr;
> +               source_size = image_size;
> +       } else {
> +               log_err("Error: file type is not supported\n");
> +               return EFI_UNSUPPORTED;

and here

[...]

Should we just goto err and set the return value instead of returning
immediately?
If yes I can fix that during the merge

Thanks
/Ilias
