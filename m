Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B829CD63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712678969B;
	Wed, 20 Nov 2024 14:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l2MIeK5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D5989649; Wed, 20 Nov 2024 14:48:34 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DFBE895F3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so2116115e87.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110511; x=1732715311; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fbrmmB9W56G+DhA/dIAe69/Q9eHj2E0zkVH8rnDwjE0=;
 b=l2MIeK5FYtMue2Z6p/+ZxTyRKj1sGvnb4W1SYXIBXIz2+MyWFDUXY18KehMaldacqm
 vrmUwc3Q0p1fQ+pdNrzjHX2H3gYTBL437RKtEYxZ2GrvNf8XAXAqyelAJn5PtjDkuVok
 gJHeykjcjWSpUpD6whPvUyxJa00jV6jZLyCCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110511; x=1732715311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fbrmmB9W56G+DhA/dIAe69/Q9eHj2E0zkVH8rnDwjE0=;
 b=h7kpgw/6kuoQ5oiSTx8203pN7znpyEKI/I7cfhJuxaCXyEeswn71TtdtIE9722rTcd
 65UCCCvUgE33eudq8CM+2ADie0z4JpnzTEgipJ1tHZRLHCXd0lmKUT6Pt1ciIgfaRkiG
 kgSH7iM8A4uwWStZdP1ZLh9Ydhuqho0HKyPI31anTeIPjnQHUAwRmmJOqgvjcMbCjl7p
 6Tj9NYhFYzbMc0ZMqnVJ1m8VwTYFbsw4wWP11eVaKhZMY2Gvt+EUu0jUQnVgovmnxnF8
 KA7mmNAQix3iUcUqrpc0RGaEy1oMV3uFeSnDdL+Ilftql66X+FMH0D+srCNpvOWzMO/8
 yoew==
X-Gm-Message-State: AOJu0Yz5eRXy0oPKL26NRQnvcaHLXXvJZUk+QKndgSB9AiHRobXv0yoU
 ZHIhvht6vw5dz5xMsa6ecOAMKNKd810eE0V4RX3yYfQoBa+raldZWJHB5SaX7BuGzk/aqSucfBj
 CRkFfjMqq4KMqepPw8kB/sSYWBTe1zPcqvn/iVOxIbDWgE8o=
X-Gm-Gg: ASbGncvCkk58ZMqtLzT2FOHwQK1RJpMDOgKnHXD/n+EXuWszzvMixnhA61KsxyQAzjf
 Rgzc5rajLqboHWKtG9XYM5zstDlq271s=
X-Google-Smtp-Source: AGHT+IGxoGJedDOGwOjsgdVI2RAjgOWA9GRFaE2mELy35rvkZs7flxLBxtSBScx1QCyrdvA/CTD6ggHsiU6F3eG4URY=
X-Received: by 2002:a05:6512:2393:b0:53d:a596:2d24 with SMTP id
 2adb3069b0e04-53dc136cf46mr1506808e87.44.1732110511373; Wed, 20 Nov 2024
 05:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20241120100157.485418-1-andrew.goodbody@linaro.org>
 <20241120100157.485418-5-andrew.goodbody@linaro.org>
In-Reply-To: <20241120100157.485418-5-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:48:10 -0700
Message-ID: <CAFLszTgsdubkumLO+0wO2qjVGxfmR=pVWc0o4vh2cEQjNtLHgw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] test: lib: Use CONFIG_64BIT to detect 64 bit
 compile
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Wed, 20 Nov 2024 at 03:02, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> Should use CONFIG_64BIT to detect a 64 bit compile and not
> CONFIG_PHYS_64BIT. This allows more platforms to run the
> full test code.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
> Changes in v3:
> New patch added for this version.
>
>  test/lib/str.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>




>
> diff --git a/test/lib/str.c b/test/lib/str.c
> index 3cc9dfea6a..0505aed09d 100644
> --- a/test/lib/str.c
> +++ b/test/lib/str.c
> @@ -206,13 +206,13 @@ static int str_itoa(struct unit_test_state *uts)
>         ut_asserteq_str("4294967295", simple_itoa(0xffffffff));
>
>         /* Use #ifdef here to avoid a compiler warning on 32-bit machines */
> -#ifdef CONFIG_PHYS_64BIT
> +#ifdef CONFIG_64BIT
>         if (sizeof(ulong) == 8) {
>                 ut_asserteq_str("9223372036854775807",
>                                 simple_itoa((1UL << 63) - 1));
>                 ut_asserteq_str("18446744073709551615", simple_itoa(-1));
>         }
> -#endif /* CONFIG_PHYS_64BIT */
> +#endif /* CONFIG_64BIT */
>
>         return 0;
>  }
> @@ -226,13 +226,13 @@ static int str_xtoa(struct unit_test_state *uts)
>         ut_asserteq_str("ffffffff", simple_xtoa(0xffffffff));
>
>         /* Use #ifdef here to avoid a compiler warning on 32-bit machines */
> -#ifdef CONFIG_PHYS_64BIT
> +#ifdef CONFIG_64BIT
>         if (sizeof(ulong) == 8) {
>                 ut_asserteq_str("7fffffffffffffff",
>                                 simple_xtoa((1UL << 63) - 1));
>                 ut_asserteq_str("ffffffffffffffff", simple_xtoa(-1));
>         }
> -#endif /* CONFIG_PHYS_64BIT */
> +#endif /* CONFIG_64BIT */
>
>         return 0;
>  }
> --
> 2.39.5
>
