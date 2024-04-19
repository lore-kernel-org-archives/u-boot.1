Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF199C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 13:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175BB887FB;
	Fri, 19 Apr 2024 15:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ntB7o+Pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E3A8882F; Fri, 19 Apr 2024 15:26:15 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 482C8887D4
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 15:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516d68d7a8bso1938067e87.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713533172; x=1714137972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zeak2j2qW+J+dV5nGIjUlJFS73C4FB2pK/FDm7mYQIs=;
 b=ntB7o+PjffB7ruEaqFwsvn4P8ZbhmUydEK3mxNkJV2E+1cQJOE2Lnc0p+N7vEGuJO3
 a5Q+7imCDt/JNkA440C5pJqw7+Tk3lLblsiyTAyedFd7jzDdknJxTyGcTCyMhkvhqG56
 rFrBSKBA3iMDjla+QgywwVizC++Qx6DbMpSLWx8OoYkWx22mIerJSsGfT+QrexB1RTDr
 ogy1646ltiDSLkSR/NYoyOaFewicv32NZiCs26q8FFxa4/VOU5+hjMB+KR1yylEGWd5/
 A75/rnUHcxNGj6GKMxtTIPFbXE7fAIzxLPwgB+58uiqL83K8ZZORV0dT62lyRfJ7B6r9
 k99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713533172; x=1714137972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zeak2j2qW+J+dV5nGIjUlJFS73C4FB2pK/FDm7mYQIs=;
 b=VwJOd+ZkvWT4Sh1OcuhtYTywAPlVNlR+IRdTE8gsr5PVQBwE8ZALEKk/5jy3Pu8NT8
 JyJ8Tr5KaLR1VJn04kslunlaset/rNTbqcqq9IWLKDfTmXE2awyGOXERETY/393MPmXp
 uIUDwuDyCrZ6cdGfv+RzqiadI636PMKMoEs0MlZndE21DcTTzsiGXG1suAGiSxKMt3h2
 ZHyE5S0a16hsrd5veBtavttiMW6aCZUOYrrwZBsiIQECGgM//9f0RO/iD/S9rKp2LQgc
 sWSDiWNkSblW2fbc/IK/KfVVA6vv84OrRIYDd2JFGFQxIq6aohhARgzfB6Za4RavHIg3
 S8QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVG8asUavr03cwrgeP4UmvgPZziRrQM78fRKztCpsp5nJZJqHxzCOU0w3Ln7oqqdYR3Yj0qYMk0moA3T2Wl3Sm0vBEsg==
X-Gm-Message-State: AOJu0Yzv75hm6IzdN6czL6D24wso7UmVbHrJ3hDB5XeAgKlFkv/evDf9
 QsG596Suu3kxhOo6o61J97hf3SsbersExIO85xm73K8YucRAri2Ar2c7PVbBoNg8ycCO12Qh8l0
 nE8sQ81j3GnT7XHkxM3JqT1yFAYmfUaKn2NNP18bRA3nQbtEYMF8vww==
X-Google-Smtp-Source: AGHT+IFRWd93Scxb6kchInE4n1XVT3xNd9yol9T4gQP/T+WB4vf9NBbsULI3+rpri79zcCVE4HTbMhTkUeznXNjp61k=
X-Received: by 2002:a05:6512:289:b0:51a:a6a8:e3ce with SMTP id
 j9-20020a056512028900b0051aa6a8e3cemr1142786lfp.20.1713533172285; Fri, 19 Apr
 2024 06:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240419095901.47201-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240419095901.47201-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 19 Apr 2024 16:25:36 +0300
Message-ID: <CAC_iWjJtE4Y1M=GFhG4U0u7otQCZN1BLutJzqfyZVqWE993NKw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: superfluous efi_restore_gd after EFI_CALL
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Fri, 19 Apr 2024 at 12:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> EFI_CALL() invokes __efi_entry_check() which executes set_gd(efi_gd).
> There is no need to execute set_gd(efi_gd) again via efi_restore_gd().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/bootefi.c               | 1 -
>  cmd/efidebug.c              | 2 --
>  lib/efi_loader/efi_helper.c | 2 --
>  3 files changed, 5 deletions(-)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 578dbb19a7e..c1454ffb948 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -107,7 +107,6 @@ static int do_efi_selftest(void)
>
>         /* Execute the test */
>         ret = EFI_CALL(efi_selftest(&image_obj->header, &systab));
> -       efi_restore_gd();
>         free(loaded_image_info->load_options);
>         efi_free_pool(test_device_path);
>         efi_free_pool(test_image_path);
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 32c64711b6c..30def6b6831 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -1466,8 +1466,6 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
>         if (ret && exit_data)
>                 efi_free_pool(exit_data);
>
> -       efi_restore_gd();
> -
>         free(load_options);
>         return CMD_RET_SUCCESS;
>  }
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 58761fae784..88c3586787e 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -544,8 +544,6 @@ efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
>                 }
>         }
>
> -       efi_restore_gd();
> -
>  out:
>         free(load_options);
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
