Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D2D2E9F0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 14:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D998E890D9;
	Mon, 11 Nov 2024 15:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jI+YdLT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E418931A; Mon, 11 Nov 2024 15:48:44 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6835988C4C
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 15:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2eba31d3aso3442512a91.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 06:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731336520; x=1731941320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y/nt7RickQlZAjs1xZf26aCZldldAGI3UjzTh1Gj32M=;
 b=jI+YdLT0hNQuDuItcfuvDwWl7q95jTXUE6R1h/6lN0cOFp2kJlf5W5DIKkL4i9NHeb
 xJHkNhoyBrqOJtzB6/ZTPef9JyF0JC3QrasDOEHef/fDQuIlQkqp8Y5pleEXRrKtHu7u
 FoJFaRVEzc0s+3UeTr4P97ImH24nvTmUflWNuQTiz7lP/34VSq9+g85xLrD7ySDkZTT4
 riCyGa+YiQwkeTDE0PSp8AWP2f8shR0M/MFF/pkpl5nU7paF6oHsYobljKA6cb2O+MQZ
 sLMG0gGoa/CjdDRjHoQCE5kKuzsO7/nv+7gLVxGKwahK/+2UoYBXRgLW+tQBe4QWPDF+
 6oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731336520; x=1731941320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y/nt7RickQlZAjs1xZf26aCZldldAGI3UjzTh1Gj32M=;
 b=BFWTiPeeZse7A9lEDoo/4oqGq31BfX7nGxpVf55Dsv3Kh3qrTMvA4ASZ7UdBBe//7m
 NoFQtOFHCRTFHCXupJAEqO+frXuiBxmqrxlr+czgo3JigiNCYnNnC7FVusegsx38P6/4
 zWXovUhQyGbfd7BO3lfOpi1ElvzOjjNhk5iMGIt0lRN7035w2R1KS71FPCqRyda9D5el
 /hKOeUCb1qySK4+yh985/XeWnq+vjm56yAfXBIgBPQIR1v9TFZIwBUKaahw0Uw037CsG
 CGVdHbNLhp7L1ruPe3+UpiAinWqVNHk9omyPhCJDrarfJltBOJuOFcsYbvvrrqA10jhf
 iPYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeFPPqQO1M2f1x9ISeuCkm1IR0X4ElIMWTlGIG+Sm+Yy3s/LVEZ2FUzUWu457qkzSUDifsTgA=@lists.denx.de
X-Gm-Message-State: AOJu0YxBoK8auhwFI4D1TP4xSAEnU6Gfhq3gUGn2EmoiVu45dfLEsJUP
 HWLrbVTB+4T1Bh18xOI6CzwBD4kdusgDNQHK1pRpi6o7FunZDfs5FCL4CIneph/Bk34BEPq+WG6
 O9+6aCuridlJTtKUAYO/VcmP+zF167Xl8QcIS/A==
X-Google-Smtp-Source: AGHT+IEFwebsFLFDZkjh1AYbFY5lOHYQ5u7/Tu52N8XpAK5ovKDCVFz2Q8xursqgA852Pfn8kS5T1m1PpMeDAj/THOM=
X-Received: by 2002:a17:90b:1f8b:b0:2e2:b219:40a2 with SMTP id
 98e67ed59e1d1-2e9b177fca6mr18579604a91.28.1731336519921; Mon, 11 Nov 2024
 06:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20241107025831.5459-1-semen.protsenko@linaro.org>
In-Reply-To: <20241107025831.5459-1-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 16:48:02 +0200
Message-ID: <CAC_iWjJVRvi2WB5ChTq26KLVdhoACq2FyFqM5jrk5uKM_CZ93A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] armv8: Fix get_sctlr() return type
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Feng <fenghua@phytium.com.cn>, u-boot@lists.denx.de
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

On Thu, 7 Nov 2024 at 04:58, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> SCTLR_EL2 is a 64-bit register [1]. Return its value as long (64 bit)
> instead of int (32 bit) in get_sctlr() to make sure it's not trimmed.
>
> [1] https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/SCTLR-EL2--System-Control-Register--EL2-?lang=en
>
> Fixes: 0ae7653128c8 ("arm64: core support")
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - None (this patch was introduced in v2)
>
>  arch/arm/cpu/armv8/cache_v8.c | 2 +-
>  arch/arm/include/asm/system.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index e6be6359c5d9..5d6953ffedd1 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -825,7 +825,7 @@ void dcache_enable(void)
>
>  void dcache_disable(void)
>  {
> -       uint32_t sctlr;
> +       unsigned long sctlr;

Although that's correct since it's a 64bit platform, isn't it better
to define it as u64 to be sure we'll have at least 64 bits?

Thanks
/Ilias
>
>         sctlr = get_sctlr();
>
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 52f6c9b934d7..dbf9ab43e280 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -171,7 +171,7 @@ static inline unsigned int current_el(void)
>         return 3 & (el >> 2);
>  }
>
> -static inline unsigned int get_sctlr(void)
> +static inline unsigned long get_sctlr(void)
>  {
>         unsigned int el;
>         unsigned long val;
> --
> 2.39.5
>
