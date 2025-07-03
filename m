Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C2AC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 08:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C2682063;
	Thu,  3 Jul 2025 10:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eJ+Jv4G4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870F482103; Thu,  3 Jul 2025 10:53:42 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A6681FEE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 10:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-710f39f5cb9so76066877b3.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751532819; x=1752137619; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AOWnpKNvXQg/nS50vj9Wa33Tmj0d57e7mnzH/Hn4P9s=;
 b=eJ+Jv4G4mFbtgNhNbyCLIKAJJRVPylyQfCQdSASd0Q2g1eABUTU7381LnHR/Qm/wXq
 cL5tjxxM1wWHApDdENvGsFNWn/ApJ5/r0TGHZ4D2r0v0t3t44geVjarUmbdnxW9xGHt+
 VSJbACpJ2Jz3h/NfE5RHSQZkFPWwOXchw2yPqHRDO5P8D7cjX134pIXAi+pYQMHIaYSc
 kJVSGhRH/Nbf3Aw3IapX9PAQApxkRbjuXqMZvXjQgbwBn3+bXgtO5W1AqY1UdS3cvUnw
 8RahcVeGdVf6lTuF8FS7CeiZj0TYQoragGpv7HpbDjyGIs26meQ0AFK+wE/XfFogpE26
 aTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532819; x=1752137619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AOWnpKNvXQg/nS50vj9Wa33Tmj0d57e7mnzH/Hn4P9s=;
 b=sIgdh04eSUiga6p+Y11v8yokAAAyDRtuP3CwrJDib3vHi/KQNwahan/H7XhhjtiCzm
 GEUwDmneuWniZs6wgSyS2sGpDBaH94Eh6LPzQ/JwWH7WtT6oV7C05tyO0oYUmhw6hM0P
 FcQVfAYLKCO9be7ZKX9BFxsr5i691zpgBN6y2Qs5k+OcdR44ziYdlMEbhkJa1G9wkcvr
 IIDtDJCBufh5Jj9pHLGatlVTvmSB9GI0kR/E3FRT4ReRr/qYtwN6ZnJbCBDoQAuXe4nD
 PzxisXtis2Wh+wXtwtU6NQy9PMwduCgWARM1OYimsX+1DQIc5gPft12e3rbY5clH7Z1A
 7SPQ==
X-Gm-Message-State: AOJu0YwY8EylavVVoAjG5NA6QQcfySQ7mu0lnTMqzHYZCCnv9nQBzpBS
 rSAD6bGh92eihA7mrLRgqwqumKayDp3g6+kvgdx3gggYbq/Ybx8NWcO4lRTImo3FVVVpoMp7l0o
 L6evta7E7w3rBlZQSJwV1EM4es0lW1F5fYVST5jpPCw==
X-Gm-Gg: ASbGnctRxzFgnEuFvYmgJZ1qi9gAewzXR0z/SKaA/RVEvAyj9Phv8Mj4eQJ+6PG6C89
 qVZwiDsPrDl2QoEB/nRtGmoIz+8wtZluXwI93f0cOSg3yqJ4fle2Gbn2lJbwwXQ9xEDVH4r5hLo
 BQ8JSV+WuN1EEKumQSJiGBzeBO6FChiDeJ6/Xb4ppo5/Nl
X-Google-Smtp-Source: AGHT+IF++5SIh7GCOgmWC+UjS/rQD9bBxvUtae+VwGmDQL8Vll8iljgmuobSqUV+XnXTfzgeytwmTLh/y2rTC8WwEA4=
X-Received: by 2002:a05:690c:6601:b0:70e:26ef:95eb with SMTP id
 00721157ae682-7165a320362mr26373407b3.5.1751532819136; Thu, 03 Jul 2025
 01:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-6-paulliu@debian.org>
In-Reply-To: <20250703062811.72871-6-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Jul 2025 11:53:03 +0300
X-Gm-Features: Ac12FXwNsZx7k84b7YkInoHLtboLRtAb4MSiOV7jlYVurghBuTwIkTz8hTZJwvs
Message-ID: <CAC_iWjLdRvGR08-Y5imo+nVr_Fg4_+=QEtfB=gTJvYR4=3NvcA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] efi: selftest: add selftest for EFI_DEBUG_SUPPORT
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 3 Jul 2025 at 09:28, Ying-Chun Liu (PaulLiu) <paulliu@debian.org> wrote:
>
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>
> Add selftest to check the installed configuration table that has
> the correct GUID.
>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> V7: add selftest for EFI_DEBUG_SUPPORT
> V8: refine the selftest.
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_selftest/Makefile                     |  2 +
>  lib/efi_selftest/efi_selftest_debug_support.c | 40 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 lib/efi_selftest/efi_selftest_debug_support.c
>
> diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> index d78bf7d6191..842433f68aa 100644
> --- a/lib/efi_selftest/Makefile
> +++ b/lib/efi_selftest/Makefile
> @@ -78,6 +78,8 @@ endif
>
>  obj-$(CONFIG_EFI_ESRT) += efi_selftest_esrt.o
>
> +obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_selftest_debug_support.o
> +
>  targets += \
>  efi_miniapp_file_image_exception.h \
>  efi_miniapp_file_image_exit.h \
> diff --git a/lib/efi_selftest/efi_selftest_debug_support.c b/lib/efi_selftest/efi_selftest_debug_support.c
> new file mode 100644
> index 00000000000..9ca8b3f82f5
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_debug_support.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * efi_selftest_debug_support
> + *
> + * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
> + *
> + * Test the EFI_DEBUG_SUPPORT
> + */
> +
> +#include <efi_loader.h>
> +#include <efi_selftest.h>
> +
> +/**
> + * efi_st_debug_support_execute() - execute test
> + *
> + * Test EFI_DEBUG_SUPPORT tables.
> + *
> + * Return:     status code
> + */
> +static int efi_st_debug_support_execute(void)
> +{
> +       struct efi_debug_image_info_table_header *efi_st_debug_info_table_header = NULL;
> +       efi_guid_t efi_debug_image_info_table_guid = EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> +
> +       /* get EFI_DEBUG_IMAGE_INFO_TABLE */
> +       efi_st_debug_info_table_header = efi_st_get_config_table(&efi_debug_image_info_table_guid);
> +
> +       if (!efi_st_debug_info_table_header) {
> +               efi_st_error("Missing EFI_DEBUG_IMAGE_INFO_TABLE\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       return EFI_ST_SUCCESS;
> +}
> +
> +EFI_UNIT_TEST(debug_support) = {
> +       .name = "debug_support",
> +       .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> +       .execute = efi_st_debug_support_execute,
> +};
> --
> 2.39.5
>
