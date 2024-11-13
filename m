Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C40D637B2
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 20:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E573D88FFC;
	Wed, 13 Nov 2024 21:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PvlmnZn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B3A8916C; Wed, 13 Nov 2024 21:17:18 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F36F88E41
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 21:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so8351835ad.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 12:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731529035; x=1732133835; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d6dF4pdVQ996xUI2OpVx71o183MVJq2k5TgFHriu96c=;
 b=PvlmnZn3gdqNroT/FbEu8S23Vk3ay6q3AP1jUZeujc5Qo3TADl1GxCFsBnX2a91BeX
 dEmGzyXNU+ixiSun6gwYIPhv0ROZ3R/RMu96pJ5+R+etdl8ZQnoUHxJimMDEmkkxR/IT
 kqaSOvzYs68Ut3gvDP4httycshMIqqM2o5hI2uuV1Y+ND8OZOVfU2ScH3GkX9N7ayIA2
 PsJQzHsGqjg/aJWOsXpWqYEn28RhjBbe7bUZSSGU/rx27KTB+tAB5nX6woVryslAFmM9
 VRp4S3mDmMk9wPl1XxvS9oFznCRNmJMUPNzaDxXOrE4/aMvXjGyi1Tp9sg6NzuDtGDhB
 Ccdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731529035; x=1732133835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d6dF4pdVQ996xUI2OpVx71o183MVJq2k5TgFHriu96c=;
 b=ZMD+svV1/bgN1QXWYuhHhtm+jWUSoUYldP/1B3RkKb1OGUPbyhPloPJ0ih5XBqAYQC
 KC93dq9UXlSNiXymkRROFW7Kxa4SJTuqEPMhcNfknkzFMQfjuhFtlLV4WK1rHoimxhCr
 DuovtEG7cZbrWV2XIJ4gwzfNBVP51IMGkTVxVPMwaiYIRmt5ZX/Fdz9jR2vmyuveabxb
 vpNf1IKBbPF1kTzREHVPHJqkmHmcQFxMJmqnlzr1Cy+eeCOY/me/NAhGlRc4JwiC+QH9
 5M+6u9fWd9HSaZYl45kDE8YDRFkiX3RracUrSm6BijDWWEFCirr//klMSoaSmO8DCMm+
 z6Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX29wbqQnnQmv2eG3WaeFUIdG6FUSG9emFuYpMsE/FLeW8APjCzdaQz5bCClI34yIvwOP5cU9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwHetqdd/W21S1mwjxaY/26na67rMiMZiwpYth2sq0lZSxBKj5t
 SVPwe+WCTdGPBqpcHcSsxvAqkahSLUWToSTGoZXzAjDakSFeNxq7IGL5rf4iSCn3edccCOmnFgi
 qbpUXQZ805SXRjFLdagB+SMi0GpKju8azf+jCZg==
X-Google-Smtp-Source: AGHT+IG6rUOCBlZ1amNBZIzYASuEqiNeusN8p3oBSeAeAUKWjpDvY5CtfYaguFlWEF+HnJpJBkBwnT5vlssouRL03mg=
X-Received: by 2002:a17:903:1248:b0:20b:831f:e8f7 with SMTP id
 d9443c01a7336-211c0f21d06mr10230875ad.11.1731529033426; Wed, 13 Nov 2024
 12:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 22:16:37 +0200
Message-ID: <CAC_iWjL4MunLF7ZMUyggUG=p1EA5dYaQY_jqAUT5v=Zd6AtXGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Heinrich


On Wed, 13 Nov 2024 at 21:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Some hard devices need specific routines to scan for block devices,
> e.g. NVMe (nvme scan), SCSI (scsi start).
>
> Invoke bootdev_hunt() to find all block devices.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_setup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index aa59bc7779d..8e0ff16f3eb 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -7,6 +7,7 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> +#include <bootdev.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <log.h>
> @@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
>          * Probe block devices to find the ESP.
>          * efi_disks_register() must be called before efi_init_variables().
>          */
> +       if (CONFIG_IS_ENABLED(BOOTSTD)) {
> +               int r;
> +
> +               r = bootdev_hunt(NULL, 0);
> +               if (r)
> +                       log_debug("No boot device available\n");
> +       }
>         ret = efi_disks_register();
>         if (ret != EFI_SUCCESS)
>                 goto out;
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
