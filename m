Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AD5C369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 07:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CCC840D5;
	Sat, 12 Apr 2025 09:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZSchy75w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A12984130; Sat, 12 Apr 2025 09:40:47 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25AE82B9D
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 09:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e6e2971f79fso2308860276.0
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744443643; x=1745048443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nhRNzUnIN+vtWuUH63sAYJ68BBBCL6f8UWSnA2jl0u8=;
 b=ZSchy75wmyAVaqM0CJ++PWeu+uLMBoN/2o/8j0d1o+4xkVxeB1Esq8CugwpVbJBaho
 GRQY+JFf81YdXWswJeW+l5tlovVVxDl2PGyAtJ3VJpzzHccI9NUmy6clLz6N2CxN951e
 GhnWlHdBT5cCNcN10eUFxyYAVZjQeqYBNqn2ZeFYG88V6EFoYJSp9FKYgSlUEApn+C3f
 rAnkE8r2aS1kX9VpKYjCklLBfMqhfVh5Ug9/9Yp546ftPoxyjEQASxf46NVkgf5ZD92O
 sWFI1ISGnMkuzi5a95dfhOjz4cXAmbRsCFLWXLg/DJYNewsVeOVUTJ99J0J2ICR6hRIY
 ujQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744443643; x=1745048443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhRNzUnIN+vtWuUH63sAYJ68BBBCL6f8UWSnA2jl0u8=;
 b=X5r8bE8Yd18PlKkoyIv4obDRX6bWvgIX/nhH9P597tQ0RyL8R8EFJp1ZKZ3GJvCvw4
 gqKKtE3772Xda3k3cxqf0Cgyw4KQxgdFffHDgW3m4sDLgEV2teX3J9o7PLiBuYtswm5d
 cOzR5zNoCb/uw4hhbAE9AtXhmNp8zT6oZmIoocSeV+svemUrNweijvjfv1feKKkfttb9
 T6y4q/2xUXUAes0WvMs+UEpQcul0K+VMgF+hXRWCA2PV5lcJeUQyIRBA/7wWIRg+HnnR
 UIHsH/8zF1oW9yGVteztpA/8hUUQmbtw23Gw3+bkScJVtOheEzD8iFbrERlAVbFyhB39
 WZLQ==
X-Gm-Message-State: AOJu0YxZpnmlSE/62rx3ZlrGJdl5LrVpsDY0TBarK8ofdYKtBStz619z
 5VMPD6xl2oeKtI9YFDBrgxOax+DZpXOZrioPYKoKt05F/egmvbjbDXpWBVxiHGBquUoEfM/L7G7
 hipY2j4/SeU9r8anjtrC6d92/cF4iNSx0LJeqAA==
X-Gm-Gg: ASbGncu51jDmNAmQuC/Gs6s43Y4KmzT5OqowpILnwFSkKGDiwpO3EmjD6StDz7ADv/h
 BWEwKYCAz87UpWgCM57sk8QpNbd2ETcOvOHJuNdwJ1B5IlRQSUdNESr/TG7nO4WESTd0t35oATU
 UH/0mSj0nOg/r4RptrBiVX5rgX24tNyeet
X-Google-Smtp-Source: AGHT+IGeOhYiFTWebaiDoJbNId64undYx0PssMfnYM4lu0fIqxVU7Y08MQ7W9SOzkncGpSAXD0KbaBJgJ+LRTipDlcs=
X-Received: by 2002:a05:6902:1b81:b0:e63:ddc4:f5a9 with SMTP id
 3f1490d57ef6-e704df26551mr8282352276.20.1744443643507; Sat, 12 Apr 2025
 00:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
 <20250311164758.421900-14-adriano.cordova@canonical.com>
In-Reply-To: <20250311164758.421900-14-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 12 Apr 2025 10:40:07 +0300
X-Gm-Features: ATxdqUFQhmPSt04BMkXVeu6-Zubu4bJvZp5_2XWvV1vLX1vUQ9eKutSpRl2yqeY
Message-ID: <CAC_iWjL5XAUkr2qo=ofP6igf-jBKdmwnBKF1KS_yPdPLTy=U=Q@mail.gmail.com>
Subject: Re: [PATCH 13/16] efi_selftest: Add selftest for counting EFI
 netdevices
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, =trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

On Tue, 11 Mar 2025 at 18:48, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Please add a proper commit message

> ---
>  lib/efi_selftest/Makefile                  |  2 +-
>  lib/efi_selftest/efi_selftest_net_device.c | 65 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100644 lib/efi_selftest/efi_selftest_net_device.c
>
> diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> index 17fbfad116f..f7e8f02cb20 100644
> --- a/lib/efi_selftest/Makefile
> +++ b/lib/efi_selftest/Makefile
> @@ -51,7 +51,7 @@ efi_selftest_variables_runtime.o \
>  efi_selftest_watchdog.o
>
>  obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
> -obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o
> +obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o efi_selftest_net_device.o
>  obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_http.o
>  obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_ipconfig.o
>
> diff --git a/lib/efi_selftest/efi_selftest_net_device.c b/lib/efi_selftest/efi_selftest_net_device.c
> new file mode 100644
> index 00000000000..51963eb328c
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_net_device.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * efi_selftest_net_device
> + *
> + */
> +
> +#include <efi_selftest.h>
> +#include <net.h>
> +
> +static struct efi_boot_services *boottime;
> +
> +/*
> + * Setup unit test.
> + *
> + * @handle:    handle of the loaded image
> + * @systable:  system table
> + * Return:     EFI_ST_SUCCESS for success
> + */
> +static int setup(const efi_handle_t handle,
> +                const struct efi_system_table *systable)
> +{
> +       efi_uintn_t num_handles;
> +       efi_handle_t *handles;
> +
> +       boottime = systable->boottime;
> +
> +       num_handles = 0;
> +       boottime->locate_handle_buffer(BY_PROTOCOL, &efi_net_guid,
> +                                      NULL, &num_handles, &handles);
> +       efi_st_printf("Detected %u active EFI net devices\n", (unsigned int)num_handles);

Shouldn't this be moved to 'execute'?

> +
> +       return EFI_ST_SUCCESS;
> +}
> +
> +/*
> + * Execute unit test.
> + *
> + *
> + * Return:     EFI_ST_SUCCESS for success
> + */
> +static int execute(void)
> +{
> +       return EFI_ST_SUCCESS;
> +}
> +
> +/*
> + * Tear down unit test.
> + *
> + * Return:     EFI_ST_SUCCESS for success
> + */
> +static int teardown(void)
> +{
> +       int exit_status = EFI_ST_SUCCESS;
> +
> +       return exit_status;
> +}
> +
> +EFI_UNIT_TEST(netdevices) = {
> +       .name = "netdevices",
> +       .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> +       .setup = setup,
> +       .execute = execute,
> +       .teardown = teardown,
> +       .on_request = true,
> +};
> --
> 2.48.1
>

Thanks
/Ilias
