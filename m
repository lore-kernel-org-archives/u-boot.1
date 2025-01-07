Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4D7E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C812F801E8;
	Tue,  7 Jan 2025 14:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PxI9QKbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C617E801E8; Tue,  7 Jan 2025 14:29:39 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C87A58007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e54bd61e793so3513995276.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736256573; x=1736861373; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/hzGnYNuAc8kf9QKa0/Z7QYRVYtqdyU3RWszFK0ff/E=;
 b=PxI9QKbet5HK5AcrA/RelscgKNO3n6YDu5zsXXC1BtwVznyq31y38WzAJB1CunsHh9
 WnPSuQ1izg7K1tw3MNdL2AiwUbCrWA0yHLUaOo1re2wyxjnuTwEz2jGlHH5olQ5xWX6a
 gympSMtCZd8glFTucXQtZXRRypfs/QVzvi7OUBpNxl+49bQGTr4dkIjP+cd8XLvmiMok
 jvGAzjP+lyKiqIARnf64WvFTk6zTZIhGcyN8fWb+nWxisFa78qXRFntMO5wgEEO1chJT
 CNt6UNszxu3nvJLMpFvlhLLQc6l/RXyEnxmDIQosKf1Wghah05fmjOwOIp6K8uj2t6sl
 0g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736256573; x=1736861373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hzGnYNuAc8kf9QKa0/Z7QYRVYtqdyU3RWszFK0ff/E=;
 b=oNLHcnrh7O3YipmDvKIKUGIWr9YFhyP+UjZIDcyFuTFqntyDjOImBgZRDCQDJLtNEg
 zhE9onCIVcdyHzqAJFWQ8xqm93gp3b4wkrcKfOFXzEwefkiap7GK9MMFUrgqLDfhBfgr
 1wYS5QLf9JoEIBs9RtIk4ykaxTeT5PtvsyL96r17mSfn+NhBSCUzpaya9XmcRguZzYG1
 q3EywE4qXsyQ96XwFCZ/HF5tzNMy5CUBzAqOfEXF8HWZTaoatWuTmJ6R/p3PiRW7SUfE
 CKUuaqY765oRbp63nYCkA/NPKhjnQu4Ek6u9L594A+Ac0hWIItuAf5kdsLSXo0TkoZUQ
 Gfdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPKoX6+s72Lovb7sf1M99U8wzerwUSJuYjY18afHaBEKsx4C5BecEiFyjb0fhzPf9yfpBq+Ps=@lists.denx.de
X-Gm-Message-State: AOJu0YwtIrtinBnWNGQJyhBCHaFnWWy8cQrnGCkEVPEK0gJzDqTwW+c7
 QmTnPcKjKOGCAx8cTVnAipFnXW8uN8NMAY0V1xJm07JCy/zgxbOqT5HmpeW7gOdbEeh2+ktIDyM
 Y8PVfhnONK2dDOQ+WR9m7EiCHKYjETB8iGOvoUA==
X-Gm-Gg: ASbGncsYH1hpakZrAQAkqn+c4oASzGBsbxmZkPXLUkjLqAUaPKTpAn9eFQjxe7tMIa7
 yIMgluCITBrKFnf+VaS6L/29X8QfYV/1OAffuhw==
X-Google-Smtp-Source: AGHT+IE/6kj7Rd8qC35Muh/0Vf07zi3sBu/Cs0XPGlsGwM2Oe8seZqHPDnH8dBov57Dt1EVK3m3pRsPWhvAnqfgXa80=
X-Received: by 2002:a05:6902:140c:b0:e30:c614:5c40 with SMTP id
 3f1490d57ef6-e538c1f1a2dmr40578401276.2.1736256573414; Tue, 07 Jan 2025
 05:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <20250102181133.378867-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250102181133.378867-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jan 2025 15:28:57 +0200
X-Gm-Features: AbW1kvZ4F0PuMsJKgWfj4cx4Aq4ZwWZMFOddkTtV-b5j_DsRz3EywOMoqmLapP4
Message-ID: <CAC_iWjLB-qgzt9HZn6giamneg5RpCy32xuANE-ojbWSc2UBhNg@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi_loader: build with HII configuration protocol
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

On Thu, 2 Jan 2025 at 20:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Without the HII configuration protocol the debug version of the UEFI shell
> cannot be used.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Makefile         | 2 +-
>  lib/efi_loader/efi_hii_config.c | 4 ----
>  lib/efi_loader/efi_root_node.c  | 3 +++
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 7d1f04e9fbd..195ed8667fe 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -36,7 +36,7 @@ obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
>  obj-y += efi_dt_fixup.o
>  obj-y += efi_fdt.o
>  obj-y += efi_file.o
> -obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
> +obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o efi_hii_config.o
>  obj-$(CONFIG_EFI_HOB) += efi_hob.o
>  obj-y += efi_image_loader.o
>  obj-y += efi_load_options.o
> diff --git a/lib/efi_loader/efi_hii_config.c b/lib/efi_loader/efi_hii_config.c
> index ae0f3ecd3b1..54a72d573be 100644
> --- a/lib/efi_loader/efi_hii_config.c
> +++ b/lib/efi_loader/efi_hii_config.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright (c) 2017 Leif Lindholm
>   * Copyright (c) 2018 AKASHI Takahiro, Linaro Limited
> - *
> - * As this is still a non-working stub and the protocol is neither required
> - * by the EFI shell nor by the UEFI SCT this module has been removed from
> - * the Makefile.
>   */
>
>  #include <efi_loader.h>
> diff --git a/lib/efi_loader/efi_root_node.c b/lib/efi_loader/efi_root_node.c
> index 4d7fb74b5d6..426f77cb2ad 100644
> --- a/lib/efi_loader/efi_root_node.c
> +++ b/lib/efi_loader/efi_root_node.c
> @@ -78,6 +78,9 @@ efi_status_t efi_root_node_register(void)
>                  /* HII database protocol */
>                  &efi_guid_hii_database_protocol,
>                  &efi_hii_database,
> +                /* EFI HII Configuration Routing Protocol */
> +                &efi_guid_hii_config_routing_protocol,
> +                &efi_hii_config_routing,
>  #endif
>                  NULL);
>         efi_root->type = EFI_OBJECT_TYPE_U_BOOT_FIRMWARE;
> --
> 2.47.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
