Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB892C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28012812BC;
	Thu, 24 Apr 2025 14:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ii41+DOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CBBB817C4; Thu, 24 Apr 2025 14:52:10 +0200 (CEST)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EF7806FC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86715793b1fso446990241.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745499127; x=1746103927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVEZbAnf7PSghlDB60x3OsXlumsKqZpPZ5tfxEEVcgQ=;
 b=ii41+DOvWN8bNnAh7WhyI5A5zDPFJK+/NuMNqDte+wNYGbF6Nt+oITzH7fuIJ1y8dG
 AOMf0gUzdEIb2TE6gHIxIwLPDsxukutcvbQ2z53IdWiIo3AwqW9p0wwv+4Zw1FXpYnSJ
 NuzM26e6PvrIxfVP0T1ZL+uo2ITkcpG1S21l6WZwqR3u5Ujsi1Xtn63adcra7basGOw1
 NDRljpY/Lx0zJedJgBZ2maF18+hCnM6wmnW/EDS+egEYV04qIDzM2BEeFC8zU8VrA1k4
 d0fxhCV9jPqRlohMzuhpaDwh3bPGENmpXRHGx8zY5QpUiKQpWqA9ZzTThe8lHUi+YMN7
 Mn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745499127; x=1746103927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZVEZbAnf7PSghlDB60x3OsXlumsKqZpPZ5tfxEEVcgQ=;
 b=ho6kWJztJ5lPtFmKE8yLdSpPLmASsB1rQeA+yInaSLapgnAA6j1vaetKI7EqZGIPfs
 B6EjFCEfrVtlv7ex4kM50EnP8L27enyUeuaQD95c3+tw9/b55lpOdIBJVPKmwK47qANG
 Oe8YyWwkMbmk0h/HoPrIK3/wy1CZCMaLMKCg/Z2tf+jfbPkRaOT+tBs/yPtEVXA2808R
 /41yKa7h3GY40pqAr5sAo4Tq8a8zd49t7zVL6TB9UtbLfjzEgsi0efFHx6zcJK20TG0G
 oQHxCbO3roh1anLLwKYCOJ2ymktS44xNi8X3F7pIP+FCugFIkRboBa0rPidCaTOG2jw7
 MhZA==
X-Gm-Message-State: AOJu0Yx1u9FMGNDARLvsI/YWXRT30YcqmgRNNU/JOPg3aMsQYfrj33So
 9eGKF/vIzn2bmuQRrMGNXumWUgN7SRKGIvDdo9IdMY2Dn596NpW9r5hs5ULHNlsVynR0gR8UHaM
 SqOLNGItW7mLZqXYQKzIc5rZqLRtzNpQoapbZ9Q==
X-Gm-Gg: ASbGncvepjE73KN+elLzeuv6ntad4rfCrCBTnZMKd3TsFI3CSmqzVDJ98hTsPxYV8k7
 caeGQYY714OvQ/j24ar3kGpPSANv7BQEys33FpFsFtNutFG6hBHewE5bXSklz924sUnrFe5v6Fe
 hpMPYhpq2fYjnYxNBDMhmH2go=
X-Google-Smtp-Source: AGHT+IHOgq4qvvbyRto1hDT6F6PIiQMOQHLLHLvqCdSLneQSuHSVkxe4sCagvWcYyNZ22CAbh6cEoEg/sk1bgQbGFN0=
X-Received: by 2002:a05:6102:4b03:b0:4c4:e36b:e8bf with SMTP id
 ada2fe7eead31-4d38cf2516emr2136826137.3.1745499127145; Thu, 24 Apr 2025
 05:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250417132718.2023555-1-jerome.forissier@linaro.org>
 <20250417132718.2023555-5-jerome.forissier@linaro.org>
In-Reply-To: <20250417132718.2023555-5-jerome.forissier@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 24 Apr 2025 18:21:56 +0530
X-Gm-Features: ATxdqUEqb7-YTPxRNdKgR-5TF1pcIG5Y2prtTPC2fG7boxTuYxkKVp4pyAZJhVU
Message-ID: <CADg8p97-dzciEqMLhxSzEPGWRyB1ZU9q2=BgwrT8+g8GGk9Vrw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] net-lwip: tftp: add LMB and buffer checks
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, 17 Apr 2025 at 18:57, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Legacy NET tftp invokes a store_block() function which performs buffer
> validation (LMB, address wrapping). Do the same with NET_LWIP.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---

Tested that the LMB checks are performed and wget/tftp commands do not
overwrite on an existing LMB reservation.

Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

>
> (no changes since v3)
>
> Changes in v3:
> - store_block(): add Sphinx-like documentation
>
>  net/lwip/tftp.c | 56 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 123d66b5dba..c7f1420ca0f 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -8,6 +8,7 @@
>  #include <efi_loader.h>
>  #include <image.h>
>  #include <linux/delay.h>
> +#include <linux/kconfig.h>
>  #include <lwip/apps/tftp_client.h>
>  #include <lwip/timeouts.h>
>  #include <mapmem.h>
> @@ -31,6 +32,47 @@ struct tftp_ctx {
>         enum done_state done;
>  };
>
> +/**
> + * store_block() - copy received data
> + *
> + * This function is called by the receive callback to copy a block of data
> + * into its final location (ctx->daddr). Before doing so, it checks if the copy
> + * is allowed.
> + *
> + * @ctx: the context for the current transfer
> + * @src: the data received from the TCP stack
> + * @len: the length of the data
> + */
> +static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
> +{
> +       ulong store_addr = ctx->daddr;
> +       void *ptr;
> +
> +       if (CONFIG_IS_ENABLED(LMB)) {
> +               if (store_addr + len < store_addr ||
> +                   lmb_read_check(store_addr, len)) {
> +                       puts("\nTFTP error: ");
> +                       puts("trying to overwrite reserved memory...\n");
> +                       return -1;
> +               }
> +       }
> +
> +       ptr = map_sysmem(store_addr, len);
> +       memcpy(ptr, src, len);
> +       unmap_sysmem(ptr);
> +
> +       ctx->daddr += len;
> +       ctx->size += len;
> +       ctx->block_count++;
> +       if (ctx->block_count % 10 == 0) {
> +               putc('#');
> +               if (ctx->block_count % (65 * 10) == 0)
> +                       puts("\n\t ");
> +       }
> +
> +       return 0;
> +}
> +
>  static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
>  {
>         return NULL;
> @@ -71,17 +113,9 @@ static int tftp_write(void *handle, struct pbuf *p)
>         struct tftp_ctx *ctx = handle;
>         struct pbuf *q;
>
> -       for (q = p; q; q = q->next) {
> -               memcpy((void *)ctx->daddr, q->payload, q->len);
> -               ctx->daddr += q->len;
> -               ctx->size += q->len;
> -               ctx->block_count++;
> -               if (ctx->block_count % 10 == 0) {
> -                       putc('#');
> -                       if (ctx->block_count % (65 * 10) == 0)
> -                               puts("\n\t ");
> -               }
> -       }
> +       for (q = p; q; q = q->next)
> +               if (store_block(ctx, q->payload, q->len) < 0)
> +                       return -1;
>
>         return 0;
>  }
> --
> 2.43.0
>
