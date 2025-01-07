Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F754E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7780806D5;
	Tue,  7 Jan 2025 16:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z/BLX4zs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA74806D5; Tue,  7 Jan 2025 16:33:22 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1DE8069A
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso22992065a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263997; x=1736868797; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C6LzvwbO6iMc46HdHH9Vgqiukz92xQFHZG6pMCVTHU4=;
 b=Z/BLX4zs0qc2A+LsYYThsGmKIXIDHq3dtKhD9lMMN/ktIDvf+pKGF42B1b+W0xlSK0
 hf7193qkxtBwATW60hys1Ea8VnH24FKOZIDyoIUkh+1YOTqgz2fpT96uCcJKmE3S+o8T
 KTVtecWNywuYikjeluQQc1agKCOlGgnXe3V4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263997; x=1736868797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C6LzvwbO6iMc46HdHH9Vgqiukz92xQFHZG6pMCVTHU4=;
 b=tnK680yikEURRTri/ZOHxmmE3lttu5TBxMXhYYI/4+JAvMnb6uQgedNT7UoEfz8TLX
 NyOSYrKKpL5Gh2KI/VjhLtZtONntUOOAYD3rFnJjkjIvTKM7TvJrNYTg6m6LIePGMKCD
 5c4CC4hMTw40tM9fswDFjK4ltkwghkPc3xIWxSAjNMingFaCTn0R9w3fJ4hoQ4s/ZDSZ
 IKM83AznohbDl0ZnltY3mBOD5l6S4cDCZj8J76DsHp7bcV5k4ArA0tm/s+WJotJ+TEiQ
 xwIewN9EW2fcnhXAp9jobY2NSryktf9wAH0ph6V7UBb5SdTERGrIPg670wTlKm/dPBeg
 VOsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTsN3GsfubHH8f4gi9pqRBqIKFlXwm+XKlOcZPnemDe/86Kb2daubdfAMWevxVjtmD/NABhTU=@lists.denx.de
X-Gm-Message-State: AOJu0YyTCd2MfGyAplhR8+d+Lh8mQXkv2SEzqM5YBuSq1hIjavCZorXu
 BApYgwyZMVVJ230GvkS5VjA3W+5zyURGGZTocyXJwI2Ha0ftFBRa6A00jl4z/CV9U68hqYcVaPl
 KpO5rczwrTjHcM/mvxQ6wHh5qWTRbZdPmYhcq
X-Gm-Gg: ASbGnctBxdl4JvmANJJ7upTHpQX+FnnXBwOlTG3IjIgIWSpjza1KfcoACXxRSH8cRRs
 sFK+dcLJVNOS/rAkR2OrosuvLAzn4hAs4YuhO2fY=
X-Google-Smtp-Source: AGHT+IFgnDZiLOaeoxaq3C6/dwogk7iVu64m4AyhwhlYxS6DDwLskUuHAamyn1ILLfLUxmvwokvbSrkaoUReB8x6z0o=
X-Received: by 2002:a17:90b:2b86:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2f452e0a44dmr89569663a91.13.1736263997034; Tue, 07 Jan 2025
 07:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-14-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-14-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:32:35 -0700
X-Gm-Features: AbW1kvagaV_PMtCUjpFUmmHNIhcjsylqB4pTBCCH3WoKxDFjNVdzmVF9ouFZyt8
Message-ID: <CAFLszThinPHnJ5BRDMGFMuOyYBmvP93+fBzBzbEPuX2vEoJG3w@mail.gmail.com>
Subject: Re: [PATCH 14/15] mach-snapdragon: fetch serial# from SMEM
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Sun, 24 Nov 2024 at 12:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> If available, otherwise fall back to cmdline.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thoughts below

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 269d39e4f6e1..dbac8aa2709a 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -30,8 +30,9 @@
>  #include <malloc.h>
>  #include <fdt_support.h>
>  #include <usb.h>
>  #include <sort.h>
> +#include <soc/qcom/smem.h>
>  #include <time.h>
>
>  #include "qcom-priv.h"
>
> @@ -198,11 +199,16 @@ static const char *get_cmdline(void)
>  }
>
>  void qcom_set_serialno(void)
>  {
> -       const char *cmdline = get_cmdline();
> +       const char *cmdline;
>         char serial[32];
>
> +       if (!qcom_socinfo_init())

Hmmm that function should return an error code, i.e. 0 on success.
Does Linux use a boot interface here?

> +               return;

Shouldn't this return an error?

> +
> +       cmdline = get_cmdline();
> +

drop blank line

>         if (!cmdline) {
>                 log_debug("Failed to get bootargs\n");

Shouldn't this be an error? If not, please add a comment.

>                 return;
>         }
> @@ -353,8 +359,11 @@ int board_late_init(void)
>
>         /* By default copy U-Boots FDT, it will be used as a fallback */
>         memcpy((void *)addr, (void *)gd->fdt_blob, fdt32_to_cpu(fdt_blob->totalsize));
>
> +       /* Initialise SMEM if it wasn't done already */
> +       qcom_smem_init();
> +
>         configure_env();
>         qcom_late_init();
>
>         /* Configure the dfu_string for capsule updates */
>
> --
> 2.47.0
>

Regards,
Simon
