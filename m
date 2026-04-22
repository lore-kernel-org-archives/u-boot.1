Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4263F94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 00:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A1D68352B;
	Wed, 22 Apr 2026 02:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fOIIs5N5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6058683AC5; Wed, 22 Apr 2026 02:13:12 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B53805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 02:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso463076166b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816789; cv=none;
 d=google.com; s=arc-20240605;
 b=gQBye0vjAdsXrXSqzVDldqIeAqui9JKDBzTtuSoY7qybTz+2yyT8TPxlNqbHDM6aem
 CzAIWsKarW/YCbSqp5hMHPa6bWcQbXCOAzWzf1/zdGIxwN20PgZTfyrcYPjeCqQYlBHr
 5sa/xM7+miJCpSa5mDSd9KehUE25KTvBtuYoowAgjj4EymRnXNotaCiTdkoF+pETL6sH
 xESlQKU5RAv/tgjd4Dg4NxUbG1zxRcQ5m1KUeNkYWOYEb1S6YSnywzTtKFF1beT7tXCS
 gaHl25zl9gaWSAsbiMh6D0h3V1fy7N/Rjfnl3VVMPlEy0bySfpalM97zRlnP/waaRtfz
 NVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jyjfIQcSftFAylXzsKPrC0AWe0hc9g5QRAy3Jh+Tdjg=;
 fh=W+sppDaEmylgYtfj8wklqZS5+WrCEISPF8M8G6j8M6g=;
 b=JWD9r3K9ti7L3lgxAA8XOOS6HjHNxtR7HGeah2WuhCxkzu0vWIu1hiGRj7SDNdmbyG
 /D+3iHjRxWz3DxMBI3UUWeWhFPznMldIKmMQJCQlZoe3JwOeLqwPrJWGCV6kCXb3pg4i
 w26QdUu+bNggJk10FRpj561brQ+wHjjIyymPucMMTQtGrDRKZL/MltQCJNE+7EXwNODV
 D/+Uba8pPL+IfeXMCuOIMqKQvVMF5mfDrhWzYEonAVp2YqQpReGfnv/SsV0CNSHsqqaQ
 +DcUFbfkz+9c4Va3NaEb21x5Xb6QeF8vQsmyII7VFd6gwGQ6wN/GC9EtA4In5j1sobuT
 pyyg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776816789; x=1777421589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jyjfIQcSftFAylXzsKPrC0AWe0hc9g5QRAy3Jh+Tdjg=;
 b=fOIIs5N55ZNK0BbV8SeB4S+bBil4nmpcyJKpPY1t5uqn2wCCF8GDdXnkIsigrAlhD3
 YloxXM/YBk04U36R6EeM4DDnl9hfC7/zfpXXTk3Q4A5oEbOEQlc1Fj0ukGYhnEQ1swRv
 ieFU3xltZdAt5+UdWQPSeBqhjkYKeNdtIPbVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816789; x=1777421589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyjfIQcSftFAylXzsKPrC0AWe0hc9g5QRAy3Jh+Tdjg=;
 b=PiDT2Omc/m6qyI+bmj4uN0CYpc808tk+QZDqnp1grpms02PO0cBq8DbjHh77uiRCBB
 fC1y2XGnSiJHThBc9m3SJlfvOr+zLvsZpAwTcOoXsslt8ST+oBu8+o6IgQ9Nwl7xzblT
 rGkYKTNMVMrsaqFd6ESmYdxRWSCkx8NDwnFAFlsip0xttGKUOTJJXH30Jz+3mTjX2ZBc
 IxMBvqPVQrG7qIv0HeFiVh/9iXx/IZl8b9fd63aNJutOWNA55yD1Z5nD+WDIT42keGWE
 YFYKn5ILQhn2zEBrPmwwjIFAPHIpGRfvrN7ub3F48ZH0yWFsbjGlJ5o1hhiDmtYfQQD6
 9Nkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Z9r0bXKXakpNtgXugXock9yqcRMppLmknpfsX0QmK2R38bL7Au6vWXlnCqfXXHWmR4pSJjb0=@lists.denx.de
X-Gm-Message-State: AOJu0YyjJ4ueJyw5m4P55vtB3bjqv6do2NwDv9o9+PEL5IiXTAsYFLcY
 f+fGvfi0uRwvkGoY27Z5r9iUMTJkElrpu8pVe8DFiF47F0VS/qI9X4eg148dpLx9lEEnajOAlLb
 UYj9Su+vnoZGZ5uWmsc4xFSK3muF9QtHRP6QlH4s+
X-Gm-Gg: AeBDietY94zL+rFljZ7A1VMgnNHBHI3fTjSlO6VAqDxEpYD7BBY09lRto67fVkejA+c
 pPIL50J6fl0ojfL7G73Y+phBsol2V9NzIjAgPLlBonq5CxX+Uari/lR1HwvZZtPu95GCvpm95uD
 7zpwC66kAMo4Rd3HxrHVGhNsaIoxQRg5hSTqtTtunjGkbyxNhsLb6LWOfxMd2pdjjHIDs8An2cu
 lFeWY4JDHHMGzhx+hmMoVIkM3FdFsYzgA3Qc6XjD8JkAqjbMDC0s6gqYSxoocJpiDF+YOTtlDJU
 RlG9xEIVYpfrDrVc4oJq
X-Received: by 2002:a17:906:8e15:b0:b9c:4fa:9141 with SMTP id
 a640c23a62f3a-ba419077377mr894224466b.9.1776816789346; Tue, 21 Apr 2026
 17:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-7-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-7-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 12:12:56 +1200
X-Gm-Features: AQROBzCBBOIy6JCV0GOBaDaHmHCMcV4pLEdNS-sRKS77buW78PVJpQbs5hFGg8E
Message-ID: <CAFLszTi3ns1zta_zAwDScdcB+VaLqWYM4MZS0hjUt5bC3Y64QA@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-21T21:09:51, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: dm: ecdsa.c: clean this test as software ecdsa is now implemented
>
> The test ecdsa was done when ecdsa was only supported by hardware.
> So it wasn't possible to test ecdsa on sandbox, and there is a test
> to check that ecdsa is not supported on sandbox.
> Now, there is a software implementation of ecdsa. So we remove
> this outdated test.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> test/dm/ecdsa.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 97 insertions(+), 10 deletions(-)

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@

The commit message says "we remove this outdated test" but this patch
refactors it to perform actual ECDSA verification. Please can you
rephrase to describe what it actually does.

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@
> +#define CHECK(op) ({                                                 \
> +             int err = op;                                           \
> +             if (err < 0) {                                          \
> +                     printf("%s: %s: %s\n", __func__, #op,           \
> +                            fdt_strerror(err));                      \
> +                     return err;                                     \
> +             }                                                       \
> +                                                                     \
> +             err;                                                    \
> +     })

hex2bin() returns -1 on error, which is not a valid fdt_strerror()
input. Consider using a more generic error message.

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@
> +     value = malloc(len / 2);
> +     if (!value) {
> +             ret = -EINVAL;
> +             goto out;
> +     }

We use -ENOMEM when out of malloc() space.

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@
> +     size_t fdt_size = 512;
> +     char fdt[512];

The value 512 is duplicated. Please can you use a #define for clarity.

Regards,
Simon
