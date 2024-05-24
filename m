Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492CBC25B79
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 06:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6974288546;
	Fri, 24 May 2024 08:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="olhku10A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0CA88546; Fri, 24 May 2024 08:38:13 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB3187E9D
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2bdeb5b80c1so1050203a91.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 23:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716532689; x=1717137489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z0KvJANJl4MtWD1KqeI1BU5JJnsletiv2PliAO+PHEM=;
 b=olhku10AeS13q6FW8PvisDhd6QFeZPMdaIi8sne05gseA/i8LXMbrP82o19PItiqrr
 0kNSlGJxMiPBfGGtVCu88yaamG9l+JTY1KS/usuC+aEotIcGtSQpTiO0wJYqLlcL2M1q
 55tSbRwLM4ZrB5tK4n+GYExtoCJCBEO21JAfrI19xetti6tQ8vE2mIuoInJaTHhWJVOQ
 xbMWgDA8nSdyX5Jz+2OJ96eELNFK/WUbTZCzcy8eWL6um7LzYI5vUJBjnbGR8O00FqBh
 8jwCp0yRDMORr3l77PCfyZE98drZVKi7Cwq3YWUoKzhwRv2s/BAj7JAFguyM06tuzpQS
 5NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716532689; x=1717137489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0KvJANJl4MtWD1KqeI1BU5JJnsletiv2PliAO+PHEM=;
 b=AiCF9rWRB8xhxZjzIqrZUhWMp5z3YGBVh/sXOQs0EDSlwDZtQfPdiZWH1+gFgm/m1I
 NZ6W+mouL66M5QawcdeEWDA210OOR3a0SG1Cp4zWIIFhxpq6iXn7mymtAICLXXpH9xKU
 VMcAftbP8AjqlIiSoufbo7ZdXCPQmGOQHm+cGptGAJFn8EzDxnmCRwUmlzlDkp0tdNbs
 Mo4Us8AGXIHFb2bTT9OjH/mwhom9LmCQx3EmKorMiTaThwtRTmLgLybmQ+RIqNJmSHvG
 3Q1/8lVYUkHrMIvIq+3RRXT+NDeuwCF/cy/NrQZL7/MU7TYbCogHYrScZWqjTqeO5PaC
 uZwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKP5be115xALtrz4QhmGXH82VT7cEbNtpCySt11QY5+2RsLOXSTKrFAm/WFPhxNs7rbg5BCyyShXIm298ktS7K25AKRg==
X-Gm-Message-State: AOJu0Yy34KiL63fL1N0isYA0fWMv8vTCVuVN4q92CmCxx+ZQnofcjMSY
 51Mbna2TPuOB7NOe1itqspOUCSaCMD2MSH5JYxnt5Sv+PFvYfIJrBs1qKvBS5CwVZAhOh3pR7Wq
 TsHPuzbhbMe7wctmhYqT0gBe0FLixIWb0Cn1LbQ==
X-Google-Smtp-Source: AGHT+IHbTp8V+IAj3YJNpzUe+sKPxFt4nC4DPS6FRgY6Yk3F3uMDC7jMK+T3H7AzdloxQX+iwDdCxTbdKzh+/iVsJiQ=
X-Received: by 2002:a17:90a:bc85:b0:2b9:c9d5:47d4 with SMTP id
 98e67ed59e1d1-2bf5f204d6emr1429440a91.34.1716532689392; Thu, 23 May 2024
 23:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
 <20240426-b4-dynamic-uuid-v1-2-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-2-e8154e00ec44@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 09:37:33 +0300
Message-ID: <CAC_iWjKZe+0EMC76TxdtBZju99QAApodqEZHdaKJt1E-mMw6ow@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] efi: add a helper to generate dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

[...]


>  config EFI_CAPSULE_FIRMWARE_MANAGEMENT
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index de0d49ebebda..9ef67d1b4405 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -19,8 +19,9 @@
>  #include <mapmem.h>
>  #include <sort.h>
>  #include <sysreset.h>
>  #include <asm/global_data.h>
> +#include <uuid.h>
>
>  #include <crypto/pkcs7.h>
>  #include <crypto/pkcs7_parser.h>
>  #include <linux/err.h>
> @@ -403,8 +404,40 @@ out:
>         return status;
>  }
>  #endif /* CONFIG_EFI_CAPSULE_AUTHENTICATE */
>
> +#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
> +int efi_capsule_update_info_gen_ids(efi_guid_t *namespace, const char *soc, const char *model, const char *compatible)
> +{
> +       int i;

Perhaps irrelevant to this patch, but do we need to define the name
space in platform code?
Can't we just put it on a Kconfig and do the dynamic UUIID generation
in efi_capsule.c?

Thanks
/Ilias
> +
> +       if (!soc || !model || !compatible) {
> +               log_err("%s: soc, model, or compatible not defined\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       if (!update_info.num_images) {
> +               log_err("%s: no fw_images, make sure update_info.num_images is set\n", __func__);
> +               return -ENODATA;
> +       }
> +
> +       for (i = 0; i < update_info.num_images; i++) {
> +               gen_uuid_v5((struct uuid*)namespace,
> +                           (struct uuid *)&update_info.images[i].image_type_id,
> +                           soc, strlen(soc),
> +                           model, strlen(model),
> +                           compatible, strlen(compatible),
> +                           update_info.images[i].fw_name, u16_strlen(update_info.images[i].fw_name),
> +                           NULL);
> +
> +               log_debug("Image %ls generated UUID %pUs\n", update_info.images[i].fw_name,
> +                         &update_info.images[i].image_type_id);
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  static __maybe_unused bool fwu_empty_capsule(struct efi_capsule_header *capsule)
>  {
>         return !guidcmp(&capsule->capsule_guid,
>                         &fwu_guid_os_request_fw_revert) ||
>
> --
> 2.44.0
>
