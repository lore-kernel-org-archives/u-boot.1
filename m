Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77B9D637DF
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FB388FFC;
	Thu, 14 Nov 2024 04:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q0JTvVog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8AE9895B4; Thu, 14 Nov 2024 04:54:36 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C441C88E31
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f367f97so215793a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731556474; x=1732161274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2WBp1gZP9nGX3uz5jWSMEPJ39gpfHs0wGRrU48D5gY=;
 b=Q0JTvVogJOTC1nJInxfboL38hrCrkZOgrNNM4vUP+R/lX1AXRUNYacLPxzH7ywHoB2
 JYaGFlJCc0MucZnhl8A9hZXUfzhPTlklxmUXCgCf+FVgFTBUsPz5N3V/EPZUMbvjDe1d
 J4CvtBqZPalfjvp+AyrKk1GHhZdtXZyyNjS18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731556474; x=1732161274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q2WBp1gZP9nGX3uz5jWSMEPJ39gpfHs0wGRrU48D5gY=;
 b=vrZB2Hj1pOIhLZ8IzubnZg0tbiiYO+CRrD94OxPQ/3mSUdqSiRR9z9bgw9b0WV/hwm
 TI7rLGD6cHM6GN0R2ut2IRNhSxeplkhhQXobPneZZUIob1flUnn8Gckl6jRDtDc3Cypq
 KDib2P+9bKDQpY/aXEe6GiYYU3+N7ChROO325j/A9hbhzxACzMBQqfdcUg6Ylj84RpjI
 zATDX7kqD3qW/TgfTE80Rg/P323rI3LHGwZJ+vN9Io3uebvvGWYEwyafaQ1+tC3ukclf
 90dEnkW7O9f/o6jG4xZ19AQZZQ2OxSUO8lA35SlOcDNegce06YSoOTtOc4KX1ae8sBum
 ctZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOfvwt2/U6mrK1cqrNPaeuiHsDUYpYVpiFm5SXe9Wg09JALCfR3hWdHqjJr6iqCu7GUfIaAps=@lists.denx.de
X-Gm-Message-State: AOJu0YzHU7t4D0lBQpGy3nsxyGS4Ig7JWYtir0xOQMwIFhIPzCKszFAE
 TOt9+nEHcPvWkjO9lMsE+PaDDlfU6PEb81erUgVjBHpro3M/DO7bCGOAA/mRtteC4kfcmT5Nzw3
 L4BflpEl9hPt+k4cFIfRjqYXp1D/HXUQuiMGq
X-Google-Smtp-Source: AGHT+IFIVyWfmQdJb0YJCjpJmQ4KPGzYKu1OT4cRRoV2ZorlXKc09O53UCx5BRjr5QGPzX68WrPD+diXQ1Y5ZvIi/Y0=
X-Received: by 2002:a17:907:c2a:b0:a9e:4e86:bbf8 with SMTP id
 a640c23a62f3a-aa1f813efd7mr443720966b.60.1731556473965; Wed, 13 Nov 2024
 19:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 20:54:22 -0700
Message-ID: <CAFLszThV5a16Q2BqxNn6jX=EavRf--gWESs-4riz_paqgzo9dQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 13 Nov 2024 at 12:55, Heinrich Schuchardt
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

Reviewed-by: Simon Glass <sjg@chromium.org>

Can we do this later, e.g. when we need to boot? What specifically
needs to scan for block devices? Perhaps a better question is: when is
the ESP needed? It would be nice to have that info in the commit
message.

I wonder if we could/should delete efi_disks_register() now?

Regards,
Simon
