Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F4BC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 15:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9D488412;
	Tue, 28 May 2024 17:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oEFS9g2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E1A4884DC; Tue, 28 May 2024 17:41:05 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFFE387F8D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f32b1b5429so6986645ad.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716910861; x=1717515661; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AKa0lBhlhqAPqNal/FXfIY4yb2goiNvNQRl95Ypp0Z8=;
 b=oEFS9g2Ar3oBc5QifvJM1rn71AO/ZUWbJ3fFOs5WoAihXDIYvxispdVroYHSQdbOCT
 UZmbYkbZxQDoz/niTtXPcQrwkUuq9xu8EzjL3uK4SkxGI5YkFoapmAiygxGrh85l2wzj
 yyeVd88494cNL51sTauC4bbCv7i1Jr8w0DWP1RlGoQeuxypw0ZbwJo+mRnAa4bGdCzG4
 77uFh0F9ngUKVuDJDV2UnZa50eXH0kph8EoOCa7tdvx5vmyKi/hHXmFuw/fy/u54lGLS
 DP2fe1mxwLbI0QqvvZ/FNsWKkRjenF7An1uY73aS8juY5OpIS00PDYnB+0j21vbCo8Mg
 b74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910861; x=1717515661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AKa0lBhlhqAPqNal/FXfIY4yb2goiNvNQRl95Ypp0Z8=;
 b=wJNpGYCOanqgNagP7RaEHSwN5QKqm6hllG294Bbg3zAlT8t5w3VFW3xm9QPwKpNXQ0
 QPxinoKv6v8o+bxJaV1tKAlq8I1NUtZBZHboUjDD9paiNdGDaU7uDx/kDaBOrxLvjTyw
 rMwWUzjc99u6RA370XlZM0JvWV14lh3pCwmvT+e0clmpq8BeYjaeUBwEyvVneaA3zc8+
 qztXPeSbPAi5uivuwcxXJc0MgxEkuFy8U6bVD0GmqAByNxjSwEXzXA/mpnAuj72Mj/51
 r/8s1BzZ6K0sVBgiISw2FA1J42xilU2DP0Br0cufLOnfnf90MZOFxRAIWvu1fUtydDD9
 vLlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ4v0Ee+949FWXk8OuNZNKjvUXZ8kJrP0uti7+JhdbhFKPeU0+MFPDc90FG+U90wJcsALbxVyK0il9gYciSyjtgcWEFw==
X-Gm-Message-State: AOJu0YyeVzkLmH0XoOMkZO4apcC+iqjKatwC7WUCdCLjhW4tZIRTgaCs
 r40cA1sPjpOu4bO3HB66062EBlFRNZGUfJ59ZGz7YMEnhhMzLkf0so2NZ09dnYxaqUO9Y2yjEMP
 cOpjF3jM9U8Gjj5WI3NfuumLZiGn3htVHpAMVUQ==
X-Google-Smtp-Source: AGHT+IFIgGHi9Bs0sP9Mn1DETkWWeUXWtIfAd8mcOkk8TYy/S9kV93XZT/C+g0W0s9JwzX+1zUMj0scmqJ7FyK/cnLI=
X-Received: by 2002:a17:903:1c4:b0:1f3:7a3:8fc9 with SMTP id
 d9443c01a7336-1f4486c56f1mr174838735ad.3.1716910860822; Tue, 28 May 2024
 08:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 18:40:24 +0300
Message-ID: <CAC_iWj+Z-ZGi+eAuq_LrWMCwOn0BMisH7oyUU8cUubo7W6ng_Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] efi_loader: load device-tree specified in boot
 option
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

> +
> +       *fdt = malloc(filesize);

Use calloc instead

> +       if (!*fdt) {
> +               log_err("Out of memory\n");
> +               ret = EFI_OUT_OF_RESOURCES;
> +               goto out;
> +       }
> +       ret = EFI_CALL(f->read(f, &filesize, *fdt));
> +       if (ret != EFI_SUCCESS) {
> +               log_err("Can't read fdt\n");
> +               free(*fdt);
> +               *fdt = NULL;
> +       }
> +
> +out:
> +       efi_free_pool(dp);
> +       if (f)
> +               EFI_CALL(f->close(f));
> +
> +       return ret;
> +}
> +
>  /**
>   * efi_bootmgr_run() - execute EFI boot manager
>   * @fdt:       Flat device tree
> @@ -1200,6 +1253,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>         efi_handle_t handle;
>         void *load_options;
>         efi_status_t ret;
> +       void *fdt_lo;
>
>         /* Initialize EFI drivers */
>         ret = efi_init_obj_list();
> @@ -1215,7 +1269,23 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                 return ret;
>         }
>
> +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> +               ret = load_fdt_from_load_option(&fdt_lo);
> +               if (ret != EFI_SUCCESS)
> +                       return ret;
> +               if (fdt_lo)
> +                       fdt = fdt_lo;
> +       }
> +
> +       /*
> +        * Needed in ACPI case to create reservations based on
> +        * control device-tree.
> +        */
>         ret = efi_install_fdt(fdt);
> +
> +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> +               free(fdt_lo);
> +
>         if (ret != EFI_SUCCESS) {
>                 if (EFI_CALL(efi_unload_image(handle)) == EFI_SUCCESS)
>                         free(load_options);
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
