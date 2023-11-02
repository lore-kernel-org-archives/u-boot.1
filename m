Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58BBC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 09:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B1A87616;
	Thu,  2 Nov 2023 10:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ukVp74ZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C09A8762A; Thu,  2 Nov 2023 10:34:44 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D5A87605
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 10:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a98517f3so819103e87.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698917680; x=1699522480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3TUi7oeOUKilSbUz1t03K2l1uvmVIY0YnSGJo6bU744=;
 b=ukVp74ZVqV0wg4W2jeWY++JmvExTKkIARf8zRMt6XqylWXadyoQGe0gFkBx2rcDTh+
 8ZlfSX/nlUQabhEZEPJOfMS/zHqy4alSFXUQQxx+aS5D/2u8/O+Eg+BXXWJ1StuAnO1R
 rJ7qLH8nXSdU0TzqIlpLoyVxIwW9EKzEnm0DjlKbf6BHJIXP/UKudO365ozlaoSm5a6u
 /2OUl9q9HFtwOtltoALvKze4szmmxx06IqdcE09MofaNT2oUlfOHr3HlerLFLeb8Viqm
 xM6BIlYY0lObJlm1kYZdbAsDQLL4VX7V6lVOjCFzCksGNrH+zoochcHScmWceDnsMH96
 3A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698917680; x=1699522480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TUi7oeOUKilSbUz1t03K2l1uvmVIY0YnSGJo6bU744=;
 b=HiyhEe8BskvOuIqsr1tv3XRhMjmyZ8PJ4408gEZKhkr8og9sGhdOUEPkrkhT9sC4Pf
 XCTp/P7zFIk0sj83p4uvxl8X50eMmsYI2yHaj74C5LMAGyXC1uNeIV0PRj2I1kax5jRO
 pL2NLbXREi7RMahqrZrB1r2X6WEIp/sGgwmqLI6ovu85i16rhnMwL3lEZmF+loc1xB1A
 W4yQNUr/l1eVHFmQt0IPsbI5GKTya9RyiXY7yVuMUPbt8l38MtB4fqL5ZPQRBzvp65U9
 eiaEwXGHj9KmT77/0U4i07rnQiLc0yg4bxKX6M0OClRJdcJJ3f8eesxIg7pmepO3f8js
 ISyg==
X-Gm-Message-State: AOJu0YyvS9zVb4Exifwquzemz31Vm8jXPIfthmaNcM/lUwwnNbjA1KFZ
 LLhVpQuGrYRng0O6EF1sHcCzKj6yyWFRWj0K5tZxlw==
X-Google-Smtp-Source: AGHT+IHKx9VwK1lelZN5rNnSvEf/qXUdCAnJCh77jnDsoRzpipfpl8dAJO8Vj4cUpMMxH7ZWI1EoCA1YTTnncshVZhs=
X-Received: by 2002:a19:4344:0:b0:507:a0d6:f178 with SMTP id
 m4-20020a194344000000b00507a0d6f178mr12588649lfj.35.1698917679832; Thu, 02
 Nov 2023 02:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
 <20231102064459.3466953-7-masahisa.kojima@linaro.org>
In-Reply-To: <20231102064459.3466953-7-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Nov 2023 11:34:03 +0200
Message-ID: <CAC_iWj+_1iULpBZbhY2OommJOW93uO2mANy+O7uzPZK9+Om29w@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] efi_loader: add return to efibootmgr event group
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

On Thu, 2 Nov 2023 at 08:46, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> When the image loaded by efibootmgr returns, efibootmgr
> needs to clean the resources. Adding the event of returning
> to efibootmgr is useful to simplify the implementation.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  cmd/bootefi.c                 | 12 ++++++++++++
>  include/efi_api.h             |  3 +++
>  include/efi_loader.h          |  2 ++
>  lib/efi_loader/efi_boottime.c |  3 +++
>  4 files changed, 20 insertions(+)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 20e5c94a33..4d74969ad6 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -356,6 +356,7 @@ static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
>         efi_status_t ret;
>         efi_uintn_t exit_data_size = 0;
>         u16 *exit_data = NULL;
> +       struct efi_event *evt;
>
>         /* On ARM switch from EL3 or secure mode to EL2 or non-secure mode */
>         switch_to_non_secure_mode();
> @@ -394,6 +395,17 @@ out:
>                         log_err("Failed to remove loadfile2 for initrd\n");
>         }
>
> +       /* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
> +       list_for_each_entry(evt, &efi_events, link) {
> +               if (evt->group &&
> +                   !guidcmp(evt->group,
> +                            &efi_guid_event_group_return_to_efibootmgr)) {
> +                       efi_signal_event(evt);
> +                       EFI_CALL(systab.boottime->close_event(evt));
> +                       break;
> +               }
> +       }
> +
>         /* Control is returned to U-Boot, disable EFI watchdog */
>         efi_set_watchdog(0);
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index c2d6964467..0e92cb8a7f 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -404,6 +404,9 @@ struct efi_runtime_services {
>  #define EFI_EVENT_GROUP_RESET_SYSTEM \
>         EFI_GUID(0x62da6a56, 0x13fb, 0x485a, 0xa8, 0xda, \
>                  0xa3, 0xdd, 0x79, 0x12, 0xcb, 0x6b)
> +#define EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR \
> +       EFI_GUID(0xb4a40fe6, 0x9149, 0x4f29, 0x94, 0x47, \
> +                0x49, 0x38, 0x7a, 0x7f, 0xab, 0x87)
>
>  /* EFI Configuration Table and GUID definitions */
>  #define NULL_GUID \
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e164e6067d..31954e84c3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -290,6 +290,8 @@ extern const efi_guid_t efi_guid_event_group_memory_map_change;
>  extern const efi_guid_t efi_guid_event_group_ready_to_boot;
>  /* event group ResetSystem() invoked (before ExitBootServices) */
>  extern const efi_guid_t efi_guid_event_group_reset_system;
> +/* event group return to efibootmgr */
> +extern const efi_guid_t efi_guid_event_group_return_to_efibootmgr;
>  /* GUID of the device tree table */
>  extern const efi_guid_t efi_guid_fdt;
>  extern const efi_guid_t efi_guid_loaded_image;
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index f9b10a9763..3767fa2db4 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -90,6 +90,9 @@ const efi_guid_t efi_guid_event_group_ready_to_boot =
>  /* event group ResetSystem() invoked (before ExitBootServices) */
>  const efi_guid_t efi_guid_event_group_reset_system =
>                         EFI_EVENT_GROUP_RESET_SYSTEM;
> +/* event group return to efibootmgr */
> +const efi_guid_t efi_guid_event_group_return_to_efibootmgr =
> +                       EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR;
>  /* GUIDs of the Load File and Load File2 protocols */
>  const efi_guid_t efi_guid_load_file_protocol = EFI_LOAD_FILE_PROTOCOL_GUID;
>  const efi_guid_t efi_guid_load_file2_protocol = EFI_LOAD_FILE2_PROTOCOL_GUID;
> --
> 2.34.1
>

Now that we have the event we have touse it for loadfie2 in the future

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
