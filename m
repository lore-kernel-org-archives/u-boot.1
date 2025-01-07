Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E00E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BFE801E8;
	Tue,  7 Jan 2025 14:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x4b/Nsbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0328036D; Tue,  7 Jan 2025 14:28:56 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F268F8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e39779a268bso19455537276.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 05:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736256531; x=1736861331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3En8+OldtIPuOjuzBko4ytqRN7kqPHNxgVTNEQ+nbXM=;
 b=x4b/Nsbi4LxhDxV+QagXkcKrkAesdaLAK9qcPtzGblcg95xO8qToL9/2lLUMoFajQn
 wRDMG9HTZTsIwmugfM/8b5JA5tt6MOcgnkcWpkixKGoKPFUmTLcpPd4lSyQjOw+Fw9S/
 3noX53gnPLOZvsK/KDGMxu2iJc/brVus1y/vXH7ysl/O1azjeMzhph3dJGR8t5QO/WCx
 ts8OQ/RFYqj9F01CtZQIezf7D+qFPE/6OZjPC4HpDUY0ptp+LP/OlQmQ5ZEUsJHH/Spr
 Be+9QItlh1o/C7mkZqfPG97b7LF52fD9qvZbxPoHqTYj4JpCjJeYe/Ro+/t75FRWKIJ9
 UY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736256531; x=1736861331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3En8+OldtIPuOjuzBko4ytqRN7kqPHNxgVTNEQ+nbXM=;
 b=pJWmoJhk0qqIPVgoQydf8k2JxgB1ptOCids0fjoxO7s7cT82IpxScCHUub7uJr6i41
 vrbI7Ytxw7+kAmTcTgY0MNwGJxGHBbh6hWWnEsL+ATa1AdZ8HWaIyR/dtj3+dFWIj/zv
 oJMp7z2QETRvrq0K7wiXe6FItzq71W2TP/F1BP36K1VDdWXU77XX6inOvBhzowY9nnSX
 NeHfuuYclMbKVnGZ8/rpo2xt7KlSq/umsvqcXjmHnuJ0r64VIRISXhaXKFQgZsMGknGp
 pMl0Zuv8GFchOvdyTVml0FYwW86qznxPbCF0K1gL3A0s/QyzHxRVOMR5q7t96VhSJvZk
 M+Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJcPJPkQ4vC+3pYmbCqbLaLWWvqcmmRZOJ44ZWhdIUOWHwEH8EPJ6Hrf7JmJX1J2v2oz+WcmQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzcJb5tjH16pQyOIroPcZ+Uk1t8TxflS7Zog9BYKvR+g1EPNVmL
 +E4jrQjXVdPvbxi7812eyzT+7ndWxcAz4PWitF4M5/8JhPsP8IhJ81QdEKYM8B3thyIymoaWikd
 70l/Qi2I1GXQaBxfYkS16yGMxGGRDyvCUJeEQTQ==
X-Gm-Gg: ASbGncv2mpPGWYPt546C3nOeup7mOYzZw4fLgr7YkJf9jwGvGcCQAP/DGx7DSRYdJTy
 BsNnt+0pl5BjreK1UHeAe9ia2JfqhpEuT54osLg==
X-Google-Smtp-Source: AGHT+IHlQYDQZlbnZCX1f/IxnYDTbF5TgJd+Wa7nNSISQXLjM2PECVCrqBWEjjapiC0WdwScGiqKbVCy8qsScqHC+9Q=
X-Received: by 2002:a25:870e:0:b0:e38:8d3b:66e0 with SMTP id
 3f1490d57ef6-e54d24adb12mr2155459276.19.1736256530670; Tue, 07 Jan 2025
 05:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <20250102181133.378867-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250102181133.378867-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jan 2025 15:28:14 +0200
X-Gm-Features: AbW1kvZZ0e_VM1oknKkhwro0j8mN3ere2Ta7GFIffPYZhrFORa69HgMQhletTG4
Message-ID: <CAC_iWj+qtNVwikJGMfyNgUFMU=N+LP1dmabUAFVDj6P6u_0jug@mail.gmail.com>
Subject: Re: [PATCH 1/4] efi_loader: implement a HOB list
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de
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

[...]

> +
> +/**
> + * efi_hob_list_register() - install HOB list
> + *
> + * The EFI shell on X86 requires a HOB list
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_hob_list_register(void)
> +{
> +       struct efi_hob_header *hob;
> +
> +       hob = efi_alloc(sizeof(struct efi_hob_header));
> +       if (!hob)
> +               return EFI_OUT_OF_RESOURCES;
> +
> +       hob->hob_type = EFI_HOB_TYPE_END_OF_HOB_LIST;
> +       hob->hob_length = sizeof(struct efi_hob_header);
> +       hob->reserved = 0;
> +
> +       return efi_install_configuration_table(&efi_guid_hob_list, hob);\

If this fails no one frees the  'hob' allocated memory

> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index aa59bc7779d..393b690c3ee 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -7,6 +7,7 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> +#include <efi_hob.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <log.h>
> @@ -271,6 +272,12 @@ efi_status_t efi_init_obj_list(void)
>                         goto out;
>         }
>
> +       if (IS_ENABLED(CONFIG_EFI_HOB)) {
> +               ret = efi_hob_list_register();
> +               if (ret != EFI_SUCCESS)
> +                       goto out;
> +       }
> +
>         if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>                 ret = efi_tcg2_register();
>                 if (ret != EFI_SUCCESS)
> --
> 2.47.1
>

Cheers
/Ilias
