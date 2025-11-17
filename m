Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA14CEBF61
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 14:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D19483A64;
	Mon, 17 Nov 2025 15:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uVx/WxQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD91D83BA1; Mon, 17 Nov 2025 15:52:48 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848D3839A1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 15:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-640daf41b19so5063844d50.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 06:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763391165; x=1763995965; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c7soXyYsCclLcQXAStdOmwNYwiISqPI/JFr9PnQ+I0Y=;
 b=uVx/WxQp6x4dEajYhWoX25VYEVV43qdWPdmKAz3ubzcIcMgJjrHJjLHFdzfCq+xgBi
 n+s9d2aKVu5XRvtd0IFifCVbQWU+86XoW0gnx70+JgFCD/TyqF1Q8kYtlW27y4xHKoUk
 y2vwAdFWuJXWn5RmQu0rfTd5CwuxksWEJIdQOEqobwG2VPl2aTY2iHZT1TlK0wMcNox1
 hvmtJIQWkpdJtlr+KkqzDDA5Ar7bHzj9ct4F1xDZoDNr36L/KyBveumyL5acxt6WsucT
 t1hH6HtsJEZRPVVmLDHONW3jIiTWJCLKL5TzaLx+xpSF8X9EY/qd/mg6Z6xJyn01c5sa
 P+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763391165; x=1763995965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7soXyYsCclLcQXAStdOmwNYwiISqPI/JFr9PnQ+I0Y=;
 b=HU/cz4QUEyGH9ZgkhVkOg8wYONme9AHfZQhEmim5012G1ku+OhcpeEtpCc/pjvszfn
 y63QohnRu2BU07WJC+zOamVL8mR9Xj6UXySPUMLSklT+tYz0MG5zOHZSaErVQH5KK9oH
 l/K7QVIEEQd19e+LTRp5WU1pj0uB9191RatfI3WPOKBP8KJlgoEQBk10zARWxcS7xPhu
 OUCtsicxYmEXVws8WlN3d4y4vWffALq2XFvbdLFQM0ZNQq4e3Vn58GHdmNGJiPGsl6qk
 MLbViaZ5GTUQ/5juu+hYb2pK6CxVOzEIWHjhDY6Aj4XMhadgM3v9HnaPV7iKsm4rv2HQ
 gUNw==
X-Gm-Message-State: AOJu0YycoSOuSyaP7Lx+d/y7THXiUkq/F5iryQrlVOXJTNlpV8zVeWR3
 GT0fDbeovaclbXSSSTsX+T0H3L1lX629hTz7yz/aFxpcg2jGCcaMBWt9peWPMAbuyoNi8LekXUf
 DjA+Dd1ygiWUXisk/BrJx0GYJKdkDOlrxYScrUlCUcQ==
X-Gm-Gg: ASbGncviy2KyW+0SYEKYLxvN3hl0G2s6Ia+8UX7Py6nWLw1TxtOr0d5iWOJSTGcINaY
 ot2RCr0ShgAjflgMdm8mK/nztLfm0/CayJ2egV6SSKfF8W430IYYEkVzVg9T+fj76bqHsn6x1Mz
 1GaRHBY8fxATGhuMfuIJXtKVt+MWCADNwrKzW3uKS6Xkk/IPs+vZgI6qQIhQaa2GUJhi8mfO8SV
 7GItUTkayuf0V9FefYg034fRbYenOVZ6vR16f3suGWEL6AZ2gX+ILyBgPXvzOzYX9KnUSOvGlGK
 kt0d6fJcMWcv6UI1XuzxLP+RNvCPLT2UQfMqQ20daUxtqIhvQXQ=
X-Google-Smtp-Source: AGHT+IG6Ol9HMD+1FTBsrw2TOxBwx/5qNTFIlZzZTbp2mEXC2EFZxlYddE2ZqFSxPiBMCEJCkrY7OMvhXPMFD4meQsE=
X-Received: by 2002:a05:690e:1346:b0:63f:a876:ae58 with SMTP id
 956f58d0204a3-6410d093868mr13328499d50.9.1763391165334; Mon, 17 Nov 2025
 06:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
 <20251114093246.56422-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251114093246.56422-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 17 Nov 2025 16:52:09 +0200
X-Gm-Features: AWmQ_bkwA9F2ApTZM2_wpf9atMPZ_otaKyx8MAD5LMbslRAgfYMuvD4FNePmcCk
Message-ID: <CAC_iWjLPoTwKLGwxG20Ckk-U=y7b7-01H1aZK=1s428-iaedsw@mail.gmail.com>
Subject: Re: [PATCH 3/7] efi_selftest: simplify efi_selftest_rtc
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 14 Nov 2025 at 11:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use global st_runtime.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_selftest/efi_selftest_rtc.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_rtc.c b/lib/efi_selftest/efi_selftest_rtc.c
> index e9e47e96c4b..54d4e786a8f 100644
> --- a/lib/efi_selftest/efi_selftest_rtc.c
> +++ b/lib/efi_selftest/efi_selftest_rtc.c
> @@ -12,22 +12,6 @@
>  #define EFI_ST_NO_RTC "Could not read real time clock\n"
>  #define EFI_ST_NO_RTC_SET "Could not set real time clock\n"
>
> -static struct efi_runtime_services *runtime;
> -
> -/*
> - * Setup unit test.
> - *
> - * @handle:    handle of the loaded image
> - * @systable:  system table
> - * Return:     EFI_ST_SUCCESS for success
> - */
> -static int setup(const efi_handle_t handle,
> -                const struct efi_system_table *systable)
> -{
> -       runtime = systable->runtime;
> -       return EFI_ST_SUCCESS;
> -}
> -
>  /*
>   * Execute unit test.
>   *
> @@ -53,7 +37,7 @@ static int execute(void)
>  #endif
>
>         /* Display current time */
> -       ret = runtime->get_time(&tm_old, NULL);
> +       ret = st_runtime->get_time(&tm_old, NULL);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error(EFI_ST_NO_RTC);
>                 return EFI_ST_FAILURE;
> @@ -63,12 +47,12 @@ static int execute(void)
>                       tm_old.year, tm_old.month, tm_old.day,
>                       tm_old.hour, tm_old.minute, tm_old.second);
>  #ifdef CONFIG_EFI_SET_TIME
> -       ret = runtime->set_time(&tm_new);
> +       ret = st_runtime->set_time(&tm_new);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error(EFI_ST_NO_RTC_SET);
>                 return EFI_ST_FAILURE;
>         }
> -       ret = runtime->get_time(&tm, NULL);
> +       ret = st_runtime->get_time(&tm, NULL);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error(EFI_ST_NO_RTC);
>                 return EFI_ST_FAILURE;
> @@ -84,7 +68,7 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>         /* Set time back to old value */
> -       ret = runtime->set_time(&tm_old);
> +       ret = st_runtime->set_time(&tm_old);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error(EFI_ST_NO_RTC_SET);
>                 return EFI_ST_FAILURE;
> @@ -97,6 +81,5 @@ static int execute(void)
>  EFI_UNIT_TEST(rtc) = {
>         .name = "real time clock",
>         .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> -       .setup = setup,
>         .execute = execute,
>  };
> --
> 2.51.0
>
