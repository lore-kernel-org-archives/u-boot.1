Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75118CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF2986D33;
	Thu, 21 Sep 2023 03:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="uNU+ZpLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EC586D53; Thu, 21 Sep 2023 03:06:12 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D3386D1C
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59e88a28b98so5182417b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258365; x=1695863165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lgR7GRVg4UUCtDgpkLx4Jiet93sXRJFQe0wtfE8rFsQ=;
 b=uNU+ZpLdJbnElE1Rex0pykU8NYH5kaLM8F8hYzP/2fP9bRY9/mno1wWrZheppw+dOQ
 4cxWxJAIaHKDzoGwknGN9zMQJws9aREAHBVeJ9PnHNFdM1fLzT8VBZMDTMNSmwK5A5SM
 EiJ22C8R/B/+Of/2bWDkfNPuhvzLUM9xUpXlbz7CuL9ymsknBodHQhQmOeq2vyLXrjIv
 gJHlm6v11WIIFURXaETPoIASAzKuO1MGFFxAE5+nqAO6ks8aAlS9VVHg0x/8ifFqQdr7
 z0E85O8qQVAL2jPN0akDFTVm3jCunIBMVEVqZBm876moVU+7bvLepmYFYI/eulq6Kqjg
 fN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258365; x=1695863165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lgR7GRVg4UUCtDgpkLx4Jiet93sXRJFQe0wtfE8rFsQ=;
 b=eLoS4LWAA29tLavL9cYJvfxlEvR75W0ThiWWMZ+rHZLeW32PwzHMDDVkefKTeKlBIb
 jPN/fUfyZuxZM0BIooMVSbuYlRIQnSySmw2HvVy5A0S2NRQ1XhiWFzorJnu0aLLW27At
 sooEsYZmPixB1heWmGJBFNDLd8VPp2CFTd04/X2ootvPZLCYv2jop3cNRfUOwQolq4v5
 uDLcD1tC8i7all9hYsAQKdLzZXlM5Lw0cs573vvU0KRQHVx1WBRlrOyIUPvXYHko7eui
 FtI52bcLA5jrxFt9+Vu6pb77jL8uOuo0eeDUae+meaEgnbNF9gFQcRgAAt0wZA0J/RDf
 03nA==
X-Gm-Message-State: AOJu0Ywu3ElWn87Eakfb8fo7j1WmRCr64NELVgeZAaBvKBW+PkAMKpK2
 BN0WT2jBCbWAbjkAXL7OwV6rr9tYpwFpbcUr+G5tBQ==
X-Google-Smtp-Source: AGHT+IGOtnDXz6BavSI9/YuRnplMNqy4KizkdGxhCop74n+YepJjAc6xARCE1QeoH1UB8PE6amzpTcjBLOigtUpiWBE=
X-Received: by 2002:a0d:e688:0:b0:59b:5bd2:1052 with SMTP id
 p130-20020a0de688000000b0059b5bd21052mr7062796ywe.5.1695258365294; Wed, 20
 Sep 2023 18:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230911163536.20735-1-avromanov@salutedevices.com>
 <20230911163536.20735-8-avromanov@salutedevices.com>
In-Reply-To: <20230911163536.20735-8-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:23 -0600
Message-ID: <CAPnjgZ1O8ZPaSX0c7Lh=AGhVUqmEeB5pBw8r_6qLa=3UEmixwQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arch: meson: sm: set correct order of the includes
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, 
 marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, 
 jh80.chung@samsung.com, paul.barker@sancloud.com, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, kernel@sberdevices.ru
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

On Mon, 11 Sept 2023 at 10:35, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> The common.h header should always be first, followed
> by other headers in order, then headers with directories,
> then local files.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  arch/arm/mach-meson/sm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index d600c64d0b..b5dd6c6d39 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -6,7 +6,10 @@
>   */
>
>  #include <common.h>
> +#include <dm.h>
>  #include <log.h>
> +#include <regmap.h>
> +#include <syscon.h>
>  #include <asm/arch/sm.h>
>  #include <asm/cache.h>
>  #include <asm/global_data.h>
> @@ -14,10 +17,7 @@
>  #include <linux/bitops.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> -#include <dm.h>
>  #include <linux/bitfield.h>
> -#include <regmap.h>
> -#include <syscon.h>
>
>  #define FN_GET_SHARE_MEM_INPUT_BASE    0x82000020
>  #define FN_GET_SHARE_MEM_OUTPUT_BASE   0x82000021
> --
> 2.25.1
>
