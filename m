Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8ABC83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 11:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896E9830E4;
	Mon,  7 Jul 2025 13:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uUahy2Gp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F09C83121; Mon,  7 Jul 2025 13:48:54 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA5E830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4a44b3526e6so46954981cf.0
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751888931; x=1752493731; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M8EZaHbq/lYUD1c/KoO5zB/jxWd4r2UDblRtZrrNXlI=;
 b=uUahy2Gp6O7pUEJ1G02ebtOBb9CoiNy3EFvQkThsKql7KFxezYv3eoQon8+ZlGZXaT
 bzRYyQiAT60+mqLa08p6RFU1Q0CA2OLu9UksXxR/oKVTFd5igmxXMitzPf83lOF2cjjB
 oV1zefvvCMnndS6EWI1EWZ0qRq0ZWtjNJNquT83pEMr4+O3Xpnglis4Mb7evPn+8bxB0
 atfQ5L7PEnvywK2K4WuEuI0qLjWdQLZ4PeCPLln7A/mqapyanN6nK28KfajU+q9ldiiw
 xxTkinwBr6BjVDEz8ZDS/4ZXQwRYlMLmYQP7qpaEby0kmVvQ/wxsK8f3FXX/V/TnQ5q2
 eEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751888931; x=1752493731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M8EZaHbq/lYUD1c/KoO5zB/jxWd4r2UDblRtZrrNXlI=;
 b=Ro4qH4Z9VnCfkTog+yno9KJmfYHGTmV55Us5KRk8SUrb3cOzs252eytpus6kTt4I9u
 HUhp0XN5GySzPVpVifACQSKqn899kX0jAyTD41Xb2ZwVn1sX02Amxf3KgAQ+mXoTzdA7
 uNNDNu3310oVHFDMlDm5ygSpl+Ee8dLcZsrwXUu0yR70iahrvmv5lf8roHTDX7H8uiel
 Aj0uexaRbVLvLZz2qUFIVDr0SrWuD8athedUYCrRFQa07j9RmjjK5hYZPkTiXLZF+UZ2
 lHUpzAQMqlS7U1I630avCV1bmS9qatVplwkpWfoiWGBSCjf959wNUOv06Eod7W8sfZia
 EwfQ==
X-Gm-Message-State: AOJu0Yx0wuTA53NYyaw+qqbvV1vwzaNK+4TiLUV5AZvbDbiFP0bl3sP/
 rLCLGRdYIvnGZ/lyS/2+H3TKbV8y9PTCWtO3pJ/QgUE3oc+BOP6LU3lV39t3mNJJwdXbDYbpYUV
 IEZaQnX1iYVqEy7wNp8rnwDaxkeEl5FfiIcwriKYAkW5C4rrhJnWb
X-Gm-Gg: ASbGncuG6lVRrXsQKcZvB9TwyDQo9vw2hVwUKRJr4vWc+flBqhjpvdtH9VyrnImp6zK
 DC1llHOeani3yCP1RcMqs2U5tgwasnPn+jkcZT/+WG5rGo+UrRymN7NsVJi1KhoV0ldh4sI/t25
 8zHNjowdoFk2DKsaVuRGQxyUDOvZja5fVLhsoEZhSo9yQU
X-Google-Smtp-Source: AGHT+IHYclVEVTAiATrt+5RW6RlR5QwhUGequqI84q+C2wWh+RXLj0lN/LSBNhDg+2cCqfxQ8VhwKWGDhcBeoqRTWIo=
X-Received: by 2002:a05:622a:4e8c:b0:4a4:31c5:fc8a with SMTP id
 d75a77b69052e-4a9a69abec4mr131166241cf.47.1751888930858; Mon, 07 Jul 2025
 04:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250707103918.4189148-1-padmarao.begari@amd.com>
 <20250707103918.4189148-2-padmarao.begari@amd.com>
In-Reply-To: <20250707103918.4189148-2-padmarao.begari@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 7 Jul 2025 17:18:39 +0530
X-Gm-Features: Ac12FXyoqp5nfExwldfNf48g1gbNlXrbokrijaLYuNBLnrlBK14BHEyMO40oYYc
Message-ID: <CADg8p97bXHr984mEpcNdXEk9dDeW8Kn4R8hen-dp49DphC7LTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] FWU: Add platform hook support for fwu metata
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com
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

On Mon, 7 Jul 2025 at 16:09, Padmarao Begari <padmarao.begari@amd.com> wrote:
>
> FWU metadata information is unavailable for platform-specific
> operations since FWU initialization has not yet occurred.
> The initialization function is invoked as part of the main
> loop event. To address this, the FWU platform hook function
> is introduced during FWU initialization, allowing metadata
> processing with platform-specific operations.
>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  include/fwu.h         | 11 +++++++++++
>  lib/fwu_updates/fwu.c | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/include/fwu.h b/include/fwu.h
> index 6441de370c9..8d0b856cc81 100644
> --- a/include/fwu.h
> +++ b/include/fwu.h
> @@ -129,6 +129,17 @@ int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
>  int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
>                     bool primary, uint32_t size);
>
> +/**
> + * fwu_platform_hook() - Hook the given FWU data copy

This can be phrased better. Something like "platform specific
processing with FWU metadata".

> + * @dev: FWU metadata device
> + * @data: FWU metadata
> + *
> + * It is a platform-specific function that processes fwu metadata.

More details please. This is an API. Something like, "Provide a
platform specific function for processing with the FWU metadata".

> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int fwu_platform_hook(struct udevice *dev, struct fwu_data *data);
> +
>  /**
>   * fwu_get_mdata() - Read, verify and return the FWU metadata
>   *
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index 7f085a0211f..9e913a04ed4 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -655,6 +655,16 @@ __weak void fwu_plat_get_bootidx(uint *boot_idx)
>                 *boot_idx = 0; /* Dummy value */
>  }
>
> +/**
> + * fwu_platform_hook() - Hook the given FWU data copy
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +__weak int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
> +{
> +       return 0;
> +}
> +
>  /**
>   * fwu_update_checks_pass() - Check if FWU update can be done
>   *
> @@ -712,6 +722,7 @@ static int fwu_boottime_checks(void)
>  {
>         int ret;
>         u32 boot_idx, active_idx;
> +       struct fwu_data *data;
>
>         ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
>         if (ret) {
> @@ -770,6 +781,13 @@ static int fwu_boottime_checks(void)
>         if (!ret)
>                 boottime_check = 1;
>
> +       data = fwu_get_data();
> +       ret = fwu_platform_hook(g_dev, data);
> +       if (ret && ret != -ENOSYS) {

Is there any scenario for returning ENOSYS. This is not a DM uclass
call where an operation might not be defined.

-sughosh

> +               log_err("fwu_platform_hook() failed\n");
> +               return ret;
> +       }
> +
>         return 0;
>  }
>  EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
> --
> 2.25.1
>
