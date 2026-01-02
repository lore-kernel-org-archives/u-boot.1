Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30031EEE25C
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 11:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A22EE84220;
	Fri,  2 Jan 2026 12:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w0cIJBza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1081E84221; Fri,  2 Jan 2026 12:07:04 +0100 (CET)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4460E84207
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 12:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-642fcb38f35so9040250d50.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 03:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767352020; x=1767956820; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cM74lwfNAfTVaW1ZBHCRyb2apJur/9NExX7yCBhqWbo=;
 b=w0cIJBzae/hVwjbZ5Km8cteiUIm+ue2dVHJY0G7U52bb2RZaK5QIAHY7SyN0u7ikPl
 GLMMzLDPoNVVhlXQEf+brkA4Gt53jRk2tSUXGuzZ09BjEmntrN/6mutjJ/0pxn56/k/e
 kNEUMKofthkyw5f8hUdlc2kYBrjKYZ7r+UBgCWGgO8Q2b0Hei/mbc6bl2YFuEFlIxEII
 F29mCs6gLECUEPWs4uzMwKdFwxEMzbf/3royXc1PMuC4r4xxgMhLA9vLpRt7zw88DsSc
 8zg6i/aZNE1vzap6fPsW7VP6a3IvsY5RUq6xKusTMy45OAPC8dJHeNinUdqUogs4ux5D
 1B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767352020; x=1767956820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cM74lwfNAfTVaW1ZBHCRyb2apJur/9NExX7yCBhqWbo=;
 b=mLFgNQ0R1RgllkWhB0lGKwXIOgMu/AllhvBiOd5zK5xo9bnCUc9WVr7vylfTwKrl9b
 SezYcmp5sx5xZcp3ntBpHEbLI4SidTQ/E6oEkLsOchpaSqFaUr3Al7lcItDcay7s80Wc
 Ty+srssA0TWkJAQyC1nwqzs6EAWpUBM5a6pGP8goHF9ZsoPpkF1/Unblivpk7SoUwERT
 wzdT1ZE6JVM0GSdeQwHc2YSbY4ihJByk+alHjTqeEc/YieboiGPcfSyZaJtUtufViO44
 wuymfdIwB0dshcCxALCRmz8E2OISRtU7FA8fT9inlYk1JTjOwrsKz/ctP4UR1ucXVL61
 2H7w==
X-Gm-Message-State: AOJu0Yyoc/3rNisPsEF7gQRHgZWbWJ41J46NtYAU5OFO1OgcWeuH0RA0
 dO7jhsPdotJrZ8IvE/ustjTTGRzIkAD1qIHhfvnB7dPMRCo1LVBEhHFFQffWTWY6wa1siMeLN86
 Opv4Q/tgClHwTf+29MGFsGo5ugYLZeFair8xoKUSgMp17zlBnH7gss7o=
X-Gm-Gg: AY/fxX6bKF3MU/tdMuEILRAjfzYs947tY0d7ncnQybO33284D9q+WWc23FH6/iKfqfY
 /rkjigEVRHc2DHqSPAWp8EfxZrB/SqEIP73WFZChRhCtq0A6uk6tQFVwe+yy3L8X+lsk4bjvLbr
 +ifHb2pXyjCZcXHaMAq8yEzFVdqd36FvmWKQFrO3Yce0RsE0YLRy7hav1X2iA4gVAYDhu93Mx77
 JVRkIzglWpQEoiMIGuJ355eRgB7yJXSgPcu6FwdlSmty4C8Pp8tF7HGix8O92t1SmzPzR+RniG7
 N3Ruqss99qRe4KpQnlRZEtnE9rejzYsBxPmyf1LNS0yB5L1H0XmQIFt9Yurw/r4mutuQnX13Kjo
 MLdYyLCyswI0q297gwDv2Df5bMUAq/CQuV/F4Pb/r6XP1jZGAP0DU00rAolZg9mA1Iy7EZTR7jt
 PXp+WTNxJfKzbLfOUN2e/j3wrb5WE9EDIpYqzV+PcZTdgR16lWgQ1grU4jzZbh0qsb9Ip8oChS7
 re7BNUf0lMjEhFnOcUxHSRJfMHK6WPK1a7X0KwH2Z7T5IhtFDJ34GpN0vwp3igWDgorES+MD1JZ
 cQjPhBc9cy2MKelA0HsEMGsnRP73Fe8IXZiOTK777/Ugdjo7qHGGVEA9eqHHQTqA9g==
X-Google-Smtp-Source: AGHT+IEbOfGurWVwNKbvM32W9JMDbb7dMDgSz5lCgck0NiS09cpMt26BCFmIWiQEDVX+ei0zEY74xWK7oSxMs+yOTmo=
X-Received: by 2002:a53:e7d1:0:b0:644:7a72:a506 with SMTP id
 956f58d0204a3-6466a8e7558mr22079101d50.94.1767352019841; Fri, 02 Jan 2026
 03:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20251231104726.14633-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251231104726.14633-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Jan 2026 13:06:24 +0200
X-Gm-Features: AQt7F2quwAEbO3DsaxGOQZUS0HwjQvh-uqvNVtmQ1N6ZJNjY1g0fXLq36pJq9J4
Message-ID: <CAC_iWjLH=_OQrVUr2U3uH_5EiRF5ZMuvyv8KBt4-ruq6s4DXdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: implement a HOB list
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

Hi Heinrich

On Wed, 31 Dec 2025 at 12:48, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The debug version of the UEFI shell on x86 requires a HOB list.
> This implementation allows to generate an empty HOB list.
>
> Generate the HOB list on the sandbox and on x86 by default.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Free allocated memory if efi_install_configuration_table() fails.
> ---
>  include/efi_hob.h          | 32 ++++++++++++++++++++++++++++++++
>  include/efi_loader.h       |  9 +++++++++
>  lib/efi_loader/Kconfig     |  8 ++++++++
>  lib/efi_loader/Makefile    |  1 +
>  lib/efi_loader/efi_hob.c   | 38 ++++++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_setup.c |  7 +++++++
>  6 files changed, 95 insertions(+)
>  create mode 100644 include/efi_hob.h
>  create mode 100644 lib/efi_loader/efi_hob.c

[...]

> +efi_status_t efi_hob_list_register(void)
> +{
> +       struct efi_hob_header *hob;
> +       efi_status_t ret;
> +
> +       hob = efi_alloc(sizeof(struct efi_hob_header));
> +       if (!hob)
> +               return EFI_OUT_OF_RESOURCES;
> +
> +       hob->hob_type = EFI_HOB_TYPE_END_OF_HOB_LIST;
> +       hob->hob_length = sizeof(struct efi_hob_header);

I generally prefer sizeof(*hob), but up to you

> +       hob->reserved = 0;
> +
> +       ret = efi_install_configuration_table(&efi_guid_hob_list, hob);
> +       if (ret != EFI_SUCCESS)
> +               efi_free_pool(hob);
> +
> +       return ret;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index f06cf49e443..e9b6ffd27b8 100644
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
> @@ -308,6 +309,12 @@ efi_status_t efi_init_obj_list(void)
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
> 2.51.0
>

With or without the change
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
