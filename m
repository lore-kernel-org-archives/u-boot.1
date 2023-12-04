Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32048C10F04
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBA58709C;
	Mon,  4 Dec 2023 12:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yUdwfyG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504C1870A0; Mon,  4 Dec 2023 12:38:57 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F73587032
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c9f099cf3aso25230841fa.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701689934; x=1702294734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JJvSTHWuTq1Ke0y1mUX6UfNhJdfCVZMaKWEDCRFcHZw=;
 b=yUdwfyG2tIn7LnJEXBTJZG8dxd/a3USSqK28Jo7Lpis7OGJV0G0dWRwE6IG3l42Jva
 b6G3paAJCShcwTpN4f0/+5X/i3WQ96BKVXHfRbhAoRDHqaDDK5bjS68R32WCkdw+TXJs
 vLgw4jG8qry1+k3kywhyTfyZ1UmYRylHeLbuxivosN7t8RmpHSiiujqfJhBCdc1JYdoy
 HViK0ao5qqUnBb/nvYxDJpLPA3roKPwdpXxQDZhsUjH9YH0IA7d2nlKoMRX9HgeimxC6
 GfQTA+5+V7qT7RjO+RcCKuzldq3IqfPZJIf8AdxaFMCdqHrVnoNQ4xXN2keSope3Qu7i
 EJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701689934; x=1702294734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJvSTHWuTq1Ke0y1mUX6UfNhJdfCVZMaKWEDCRFcHZw=;
 b=PeRStR022bA66CWOgLdYnyzv5aeA41v2gbtOY3DSiShbADZIuDdFMzTxed19aTwygc
 GT865lqFKeoIVK1hZitN5MZERRqqC3NBvF/jeB0yJiMF2Hn/wASZwy85Yb04809D7EDC
 cQ2lrgB6LugvvxiITLuEF+XWBzQJjezMAWWbPi9lB63Q2mZUPspiwvpKpC/LBTajDUUW
 3x7Ao6Z50UCVUPJNnGlabMuI1PUHySMupJ1JC+i56zah6yRmJvR+YwVUjBTBkjjICRwW
 a4m0e7BjdrzVGD5Y3LtxJxptGNGA0XEFZ4fg+y/6R9r06z/qjMnW+177InWTVEsXNbgZ
 Vt5A==
X-Gm-Message-State: AOJu0Yyrb0WwpCmMSITBQRX9QuJ/TyNQNmhTIwg7Nkxfzlh8Ubqwx2aT
 mmzQnTny9f9KOrCp/A4mpg4FRYkRA+3GbL3DHFsu+g==
X-Google-Smtp-Source: AGHT+IGuMA69qV0ILZT7+b1iZF+Z+vVyEdkRiCAJpE/nVpmByubZa3UtuOxb1Qap9QraxKTBbWGeeR+LX9H1sDElcJU=
X-Received: by 2002:a2e:8747:0:b0:2c9:f643:d6c8 with SMTP id
 q7-20020a2e8747000000b002c9f643d6c8mr1181922ljj.95.1701689934434; Mon, 04 Dec
 2023 03:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20231204043014.122793-1-masahisa.kojima@linaro.org>
In-Reply-To: <20231204043014.122793-1-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 13:38:17 +0200
Message-ID: <CAC_iWj+giW2Wyagi2eH9668G2HtU=BXuhjUvTpPWHFH5sA23rA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: use event callback for initrd deregistration
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Thanks for cleaning this up!

On Mon, 4 Dec 2023 at 06:31, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> Currently efi_initrd_deregister() is called in bootefi.c
> when the image started from bootefi command returns.
> Since efi_guid_event_group_return_to_efibootmgr event is
> implemented, so let's use this event for invoking
> initrd deregistration.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
> Note that this patch can be applied to u-boot/next.
> This patch requires the patch e0d1a1ea68("efi_loader: add return to efibootmgr event group")
>
>  cmd/bootefi.c                    |  5 --
>  lib/efi_loader/efi_load_initrd.c | 82 +++++++++++++++++++++-----------
>  2 files changed, 55 insertions(+), 32 deletions(-)

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 4d74969ad6..e52bd3f743 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -390,11 +390,6 @@ static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
>  out:
>         free(load_options);
>
> -       if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> -               if (efi_initrd_deregister() != EFI_SUCCESS)
> -                       log_err("Failed to remove loadfile2 for initrd\n");
> -       }
> -
>         /* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
>         list_for_each_entry(evt, &efi_events, link) {
>                 if (evt->group &&
> diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
> index 193433782c..7ca7785c04 100644
> --- a/lib/efi_loader/efi_load_initrd.c
> +++ b/lib/efi_loader/efi_load_initrd.c
> @@ -184,6 +184,50 @@ out:
>         return ret;
>  }
>
> +/**
> + * efi_initrd_deregister() - delete the handle for loading initial RAM disk
> + *
> + * This will delete the handle containing the Linux specific vendor device
> + * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_initrd_deregister(void)
> +{
> +       efi_status_t ret;
> +
> +       if (!efi_initrd_handle)
> +               return EFI_SUCCESS;
> +
> +       ret = efi_uninstall_multiple_protocol_interfaces(efi_initrd_handle,
> +                                                        /* initramfs */
> +                                                        &efi_guid_device_path,
> +                                                        &dp_lf2_handle,
> +                                                        /* LOAD_FILE2 */
> +                                                        &efi_guid_load_file2_protocol,
> +                                                        &efi_lf2_protocol,
> +                                                        NULL);
> +       efi_initrd_handle = NULL;
> +
> +       return ret;
> +}
> +
> +/**
> + * efi_initrd_return_notify() - return to efibootmgr callback
> + *
> + * @event:     the event for which this notification function is registered
> + * @context:   event context
> + */
> +static void EFIAPI efi_initrd_return_notify(struct efi_event *event,
> +                                                 void *context)
> +{
> +       efi_status_t ret;
> +
> +       EFI_ENTRY("%p, %p", event, context);
> +       ret = efi_initrd_deregister();
> +       EFI_EXIT(ret);
> +}
> +
>  /**
>   * efi_initrd_register() - create handle for loading initial RAM disk
>   *
> @@ -197,6 +241,7 @@ out:
>  efi_status_t efi_initrd_register(void)
>  {
>         efi_status_t ret;
> +       struct efi_event *event;
>
>         /*
>          * Allow the user to continue if Boot#### file path is not set for
> @@ -215,34 +260,17 @@ efi_status_t efi_initrd_register(void)
>                                                        &efi_guid_load_file2_protocol,
>                                                        &efi_lf2_protocol,
>                                                        NULL);
> +       if (ret != EFI_SUCCESS) {
> +               log_err("installing EFI_LOAD_FILE2_PROTOCOL failed\n");
> +               return ret;
> +       }
>
> -       return ret;
> -}
> -
> -/**
> - * efi_initrd_deregister() - delete the handle for loading initial RAM disk
> - *
> - * This will delete the handle containing the Linux specific vendor device
> - * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
> - *
> - * Return:     status code
> - */
> -efi_status_t efi_initrd_deregister(void)
> -{
> -       efi_status_t ret;
> -
> -       if (!efi_initrd_handle)
> -               return EFI_SUCCESS;
> -
> -       ret = efi_uninstall_multiple_protocol_interfaces(efi_initrd_handle,
> -                                                        /* initramfs */
> -                                                        &efi_guid_device_path,
> -                                                        &dp_lf2_handle,
> -                                                        /* LOAD_FILE2 */
> -                                                        &efi_guid_load_file2_protocol,
> -                                                        &efi_lf2_protocol,
> -                                                        NULL);
> -       efi_initrd_handle = NULL;
> +       ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
> +                              efi_initrd_return_notify, NULL,
> +                              &efi_guid_event_group_return_to_efibootmgr,
> +                              &event);
> +       if (ret != EFI_SUCCESS)
> +               log_err("Creating event failed\n");
>
>         return ret;
>  }
>
> base-commit: 4a363dd516856344558034027e40d903868f67b4
> --
> 2.34.1
>
