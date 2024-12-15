Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D5CE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 07:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020888006E;
	Sun, 15 Dec 2024 08:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RFDCWgb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E3C8006F; Sun, 15 Dec 2024 08:35:12 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17918006C
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 08:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6efeb120f4dso23474687b3.0
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734248108; x=1734852908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=te2NgjYqWkirSujAPMxt9SuNfyMxiCuqypRVzpZGjXs=;
 b=RFDCWgb9kMvLAchcg2VVRlxExfzhZhAVz3pKhl3VLQzoayF4SPfct2rPj9gMFf0tXB
 uUtDkcl5NeaNYeo+eUNHVkw0gdBHigg3nWO8LKsQ4b4smqOoF9GztISNYLhHecX8OWnC
 T9oBnMBta+KOSRvj+Th8I91TbEzLQ9aH4D0JABux/Bpw0/ToSzU6tWIpLsLpoIDtHdve
 3sO3i/4iQZQWzx1gzVIT0UeNUHcHQRQz9PMs0Is0qaCKuXCNuZ76zPPtjfS3caftbN95
 74wmTuMHqBib4GpcfCnNSEiptKgBN5LF6e1230aX5mR/2P4Ad7dn+HpVNl7e+q7jqJoK
 FdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734248108; x=1734852908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=te2NgjYqWkirSujAPMxt9SuNfyMxiCuqypRVzpZGjXs=;
 b=of4hXfOyq1994EkkM3QzmSGq9SJR0oYETlGDRgS1h/kwt4atk2+mvfKx+TfOXOBiIW
 R/+IjNnotnxb5hKTNHsrzJOOsqrk6jVYrPSfrmTheE8TBpeFWYesof5wSZi+ncPL6XqN
 jP2EhqERzwByQ1CC+2EfUqbjICaiRpkyWlWyzl1pZbqYya281G0ZcKAXkvQRlQoL3ASd
 hlCj752FZelNzlc5LrPn9c85OrOS4o1yLFNjsZkjelsEKVuqbgZ2tNmLOmtCJSLDYQ4K
 AsCIYpE2a0j1vhrzhMBXL0pkkMwFFexTBGBbJ0QzpIGjs/Papq9kjr1yWEQFOdE6DHq1
 jltA==
X-Gm-Message-State: AOJu0Yw8CRMwhXxjvEP3Bfufv3AOIWTZWFmNyHKMMl2nsUKtIB1gTOvh
 AfSoz0tHkB5T2/CeFaK4+WbcRb+zcQpcsnJsx0obDtJqO3CI2ArYbW+DQtffVH2BCAaoTHdvSJO
 Tp6iksOCcgqwbmpXW4a2oFpt0GaHaUVvrO4oS6Q==
X-Gm-Gg: ASbGncsWAUD0J14/xJkYr7+OsSmRzYu+fV7I9lDlyqaFk/yVl6AGH3P7ygHXMv+yHOa
 yW0uymdvFg/fsM5ZRSV55SvIsGXmjIaV8HL2cvw==
X-Google-Smtp-Source: AGHT+IG5ITYUhQBQghWG1HCv2QqjP6Qa2kcIyG4UDgzUEKnBa6V87W7O/1wnzOVHzn88OReMct/KPqIhcnCNlvrHhJc=
X-Received: by 2002:a05:690c:608a:b0:6ef:641a:2a90 with SMTP id
 00721157ae682-6f279b885e9mr64005287b3.32.1734248108604; Sat, 14 Dec 2024
 23:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
In-Reply-To: <20241213225543.392282-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 15 Dec 2024 09:34:32 +0200
Message-ID: <CAC_iWjKwm9uC09mE-Fbq6V_2tzf9DV1GrLmh2Qn=BpNSGA9irg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
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

On Sat, 14 Dec 2024 at 00:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get tpm event log from bloblist instead of FDT when bloblist is
> enabled and valid from previous boot stage.
>
> Note:
> This patch depends on:
> [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/tpm_tcg2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 7f868cc883..acaf0acb88 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -19,6 +19,7 @@
>  #include <linux/unaligned/generic.h>
>  #include <linux/unaligned/le_byteshift.h>
>  #include "tpm-utils.h"
> +#include <bloblist.h>
>
>  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
>                       u32 *pcr_banks)
> @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>         *addr = NULL;
>         *size = 0;
>
> +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) && !bloblist_maybe_init()) {
> +               *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> +               if (*addr && *size)
> +                       return 0;
> +       }
> +
>         addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
>         if (!addr_prop)
>                 addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> --
> 2.25.1
>

Tom, this is a mix of TPM & bloblist series. Do you want me to carry
them via the TPM tree?

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
