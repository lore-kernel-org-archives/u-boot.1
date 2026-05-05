Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91444CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9818469F;
	Tue,  5 May 2026 07:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tssrjTxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B51A58469F; Tue,  5 May 2026 07:45:26 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881C784683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-651bc83e74aso4236727d50.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959923; cv=none;
 d=google.com; s=arc-20240605;
 b=YI9x121l1CgsB6vf+zUluEZLph4l/njaD+MKiExOd/q8gYJfxbJDbEjZCi/59MsnNn
 jDzZKVf69R6+6Z7Hc9Y4dXl4NPcYMfyhYxuH/aZmJPReEBZdXYB1otNMRsj/8fRqyeu5
 XnoQXIWMvoGEUMkLSmf5QMWuJFYEwRZRgeO2N0R83wih6XQXhF583u8F57rYiQJX4I1L
 //cYMECd1mZALEVpwN7w0R8wVI7t3WqJnlbjk9OeZ1TzrwNdwoNFQdPzCPd7eH6S8kUP
 wrPR9NmDQ4M0q5aqbv2nhengICkERI+Ps5CP2UnWlHJFKrNsMQnyX1/sQPxQQt73ewVK
 qgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0c4JXITskKwklPaahS80uXtiDWLIKfiVlXm0AOlP0tM=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=eHBIrVHZXtN7cyJkmmAzDQIwB3678/zDZy8qjPGx4Mkgnw6A8wRIMlnJPpt8lhMS9n
 X+N9qn9m6V1YMFuy1qGWsYVTZ/sgmipuDv9gJhAsEDxQ5ilaWwHkHdFXYB/XMbplg+4g
 3aBSbM+sgrEHpOUQ6htq/YbBZtaKSO6/yhVlto6LTQH8U8eMQJFbzVIQ0QFSjcsLqwep
 9p1ZxemdwLhRQEX5g8V4ilzWNLIb2cc6czVW2SEUBpuIjtTWOiHZ3elzrim/9OWaMkmp
 NiNz6erqBzkSneiPsorG3vqDcLO3Zx18HM8D6BXWWZaJ1uEXqgoCDmZ2oT1aiI1jwvhA
 brjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959923; x=1778564723; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0c4JXITskKwklPaahS80uXtiDWLIKfiVlXm0AOlP0tM=;
 b=tssrjTxKa1Wq3e44BRRwBnlAwtabghlB4JrHEqRyVlO570FtVwqAjz3hWkCH1GeJmV
 xGZZ9E4CiVXqAgIdYuvMnut+ktDHYIpDaT1ClIKMDd4IVLCvpoPoHLl8x1Fd7o9oV6oI
 yG6Ice8Fd3mGg6lu6s63Ttp3xEQsmUeTsYInqe6YFnCRnge2utedhTlGw3UOPtBvB8a3
 IGUuqGhnjSBdf+NsiWXxxxyK3CizUqpQiTDi8gFaDLhXIOHhzZfX1mNuvc9S965FBimC
 7jqBCc+Kmg6KtrPCcE/zTopn535bcxnj4ks1X2foMNudQcfVZT5bFIv7cKLHUE0LTjz2
 BWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959923; x=1778564723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0c4JXITskKwklPaahS80uXtiDWLIKfiVlXm0AOlP0tM=;
 b=oHOMwcvGh+LphOwWY+4O0TmMmhQmSLDxLKKZG2hkPvSjwXQ4MwEKSNP4fKI3gIK+2z
 d362D1l3n8nz+OWKYorJXYDxenFDdB/nMGhJlKBHoE+n/9IFCORxCO0m7Z8Cu9eNJuLy
 0VaD3Vnpj5+KPThVZ+fxBi1LU1FP+Cj6TAmhrb+WU9sPhHkDfmdWsWdHw+Bdy5niAkT0
 nE9XSYyxDMHaBV2ZAXUXuK+KhU5a3AH08yP7DVWQd5b2iaXy+NEz71DkUX7nOLIoMIQC
 rjudijJ3Vy6jW+ySvqKijcsrG1OwZbAqyk5rIq56jrngAOlfwhJ6GMDiGgHtjnMP29cc
 4qvA==
X-Gm-Message-State: AOJu0YxLp+B54Wdq3zpf1KdVlehucZKESf8tencyaHCX6z4i2kURd8hg
 NH243HtYFBT9WdYx8ZCJ6t4lYhKCttlXVhRAK4J+u8jCGqDZKTZRDAPoYRbiQ4l+wWqnGGqpGau
 a7fNgt0nvfcHNWpPJ8qdLmOgM6M/aWBddM3uXTYucUA==
X-Gm-Gg: AeBDietqx+WiazlLC33NKITFtkfXYwTJlgWgetE3nuPTxT2nJYtFrX68LMPnOCeGrHA
 wmthIaxqyofzvd345/9ZNPAdfwFz55RoSz7z5ga9TMpZRBM7Tg/n/N7JTInQYojCxkvjfqBsMcI
 kaRrQ0S5Qmb9QRFFsU8zKJURa087pAeSGLHr8mmO66r0K4Qdj55LqCzpDi5iAu2VBnpQcATgN10
 UJPTYOEBGdzmaRBw1uC0tMPuI2KIAwC8UvTnO6gQggizEv9cf0fyGYcMjP8JYT3oUtLbgLd/POW
 LIrLt4bqECA/wGBQDmneiM1cvtZC4/c/9t16GZO42e5V7vJtSHRYB+whD4rNVpq0j9GOUi+E4YB
 GcHl+bgxTmZV+jbfheCf+nmWk1JNDprQXg1DllJptxFg7ERPBO2yCnn1u39MfOUii2Vkbf1TY0/
 DDx9ERB03e6RRmDDXwrBdiI+54kfgCVkHvrnt9he6t8DOxsdj3PoWYeBYxWxoImRFfStyXq6YvZ
 vyUlAY/D9hHHCioc4zOoAgvBLmVvLdba+7zB0YW3fE/31yqfLJAPAd2Z0pOUd+E50AOSM5XekiN
 1yN2AOd7XyOTSXe7qqfvvRtG3gmpFuqehF3U+kyKIqs5uruxCLnhUUEZotu+7OZF1EhWlfTeVYb
 520RJ1a6NI1Q5yKME
X-Received: by 2002:a05:690e:4090:b0:65c:2738:c687 with SMTP id
 956f58d0204a3-65c3da0e21bmr13093578d50.21.1777959923277; Mon, 04 May 2026
 22:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-10-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-10-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:44:47 +0300
X-Gm-Features: AVHnY4LZ3jD-wuhRFfxaegv9UL-JQKIrWbDO62EwbL5waCrqntYETdiHHBgJ3CI
Message-ID: <CAC_iWjKL0N50HA71oWYzSLTsQ5off7LKd9+EV6g5vk7bgaTEFg@mail.gmail.com>
Subject: Re: [PATCH RFC next 10/18] kbuild: align W=e with CONFIG_WERROR
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit f852ce052a8b78d6fade371bd1fad583541e78fa ]
>
> Original commit log:
>
>   CONFIG_WERROR sets KBUILD_CPPFLAGS while W=e would only set KBUILD_CFLAGS.
>
>   As a preparation to unify the two mechanism, align their effects.
>
>   While at it, add some alignment whitespace to prepare for later additions
>   to the list of changed variables.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  scripts/Makefile.extrawarn | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index b1881d83e06..65954320e0f 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -103,6 +103,6 @@ endif
>  #
>  ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
>
> -KBUILD_CFLAGS += -Werror
> +KBUILD_CPPFLAGS                += -Werror
>
>  endif
>
> --
> 2.54.0
>
