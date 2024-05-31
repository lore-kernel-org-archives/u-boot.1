Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4DEC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629C48829B;
	Fri, 31 May 2024 08:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vc8c9CLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C183388786; Fri, 31 May 2024 08:51:53 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E7FA88270
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c199abdbcbso1240568a91.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717138310; x=1717743110; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TYVyBYaeI+sZ8P/ozZVWfUwYoBDUXoTNNkckz+8llsc=;
 b=Vc8c9CLzRxURsAyLPUrhI1tt9mUGcCKKY0CPnLN8C2rJlT+DvJlZPxvJoK8DSWtPj6
 76EE7gJuqbE3VWJAxrWzyLHJcd11LXef43qV9LdqWq5Bb1alSUDve5stN/zlmeiMroCT
 IBWx0PvnhEvdLVwuUaZZDzkcb32g4Mq+5Ug4RJ1XU6fsrn8u5spHKOx1DMHsfOVhZWXV
 mZRc00mM1IfzNs6s5ufG9LIHbqOzheDa+luvNiy4mh2G2dxj6Bv4fDGMTvd2vOeFLg4f
 rjWcPeH8LwrMrld8BR+fWfTIGmOXlFnsmbJJspgs9FysaKAADZo9i5sF+BZWZwsjecc4
 lE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717138310; x=1717743110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYVyBYaeI+sZ8P/ozZVWfUwYoBDUXoTNNkckz+8llsc=;
 b=k3XKO+Mh+iTPW2AK5soS/VdmCE+ZD739hBxGRWfkMfawvI2Kd4/lXuhqaa36mEIxHo
 VFP6/+JV8bUZg3++88Mv475wnx8Jp5GKi7ESFfe73lPgzgtGdnYApKloRGE/H/L/2jO5
 YKLEFXfBHBgs6Q8hjCi1y4Nc1BUnMxv+SqP/SCFtubqRAuFmOP9eW8wHPw7HtmCSqwGL
 cnSLKoHxYZ0advAiA3hk+QIGtl9YnkukH9ho19oCah1iJ1dfp/jZxHAt1IS9y+WzWgJu
 uOs1r83HOMWkzhMUuidPahVRjnOzjW2vWnkNwZJo4Z0ShH8QdzU8mHoR7mY65Aomhw1A
 Jsnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbNnBEKUexj95bpkvgH8328vQDnAUAnD6RdnbcmeUjLXvgmIB/SVvs1tbJeIUS0Wh1ADpyKfXg3YdSu4S1/T4Vmd/6hw==
X-Gm-Message-State: AOJu0Yz4m6UZhdClH830koBnoCtPW4Ntrh5cYLC41MAl/KI8vA/+D9IZ
 YzvKXXzoW6ECkkBxEeAkFVUqeUe4C63QxDaWCT/Y14bAIYqd8MYn1PRq+mEeKvWOXeBjdYBEgwq
 bacYcRVxFxtTSm12TTUT3nop7eSU=
X-Google-Smtp-Source: AGHT+IH6SiG513st2EvFhJ7p81gfJhZL+ei6C4+zK44EET5CHLaUVeYi33eiQznvzzRifQZQK6WplEQZXzsiV/M+VEA=
X-Received: by 2002:a17:90a:f083:b0:2b1:b6f:e297 with SMTP id
 98e67ed59e1d1-2c1dc5c8effmr977222a91.36.1717138309870; Thu, 30 May 2024
 23:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240525215138.11936-1-semen.protsenko@linaro.org>
In-Reply-To: <20240525215138.11936-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 31 May 2024 15:51:36 +0900
Message-ID: <CALrBrZ2YHP8Zr=2sfE0sy8b0YiziqBkpWJ0xup139gKFkAO+Nw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: e850-96: Remove not needed bootph-all flags
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

On Sun, 26 May 2024 at 06:51, Sam Protsenko <semen.protsenko@linaro.org>
wrote:

> Most of the nodes in e850-96 appended device tree that add bootph-all
> flags are not necessary. All those nodes are instantiated as
> dependencies of other nodes anyway. Remove those nodes to avoid
> cluttering the appended dts. 'bdinfo' reports 768 bytes reduction for
> "Early malloc usage", and 'dm tree' output doesn't change. Keep only
> pmu_system_controller changes, which are actually needed for serial to
> work properly.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  arch/arm/dts/exynos850-e850-96-u-boot.dtsi | 28 ----------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> index 7ad11e9faab2..6d7148f7264a 100644
> --- a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> +++ b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> @@ -3,35 +3,7 @@
>   * Copyright (c) 2023 Linaro Ltd.
>   */
>
> -&cmu_top {
> -       bootph-all;
> -};
> -
> -&cmu_peri {
> -       bootph-all;
> -};
> -
> -&oscclk {
> -       bootph-all;
> -};
> -
> -&pinctrl_alive {
> -       bootph-all;
> -};
> -
>  &pmu_system_controller {
>         bootph-all;
>         samsung,uart-debug-1;
>  };
> -
> -&serial_0 {
> -       bootph-all;
> -};
> -
> -&uart1_pins {
> -       bootph-all;
> -};
> -
> -&usi_uart {
> -       bootph-all;
> -};
> --
> 2.39.2
>
>
applied to u-boot-samsung.

-- 
Thanks,
Minkyu Kang.
