Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EFBC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 05:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A041E884D2;
	Thu, 20 Jun 2024 07:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jlh4Cy4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFDEE882E8; Thu, 20 Jun 2024 07:47:55 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF42884F6
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-711b1512aeaso397797a12.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718862472; x=1719467272; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Br7c61/P2OIjqlAyx0RNDdZV9Q2YuJEe1WLoLoS2xi8=;
 b=Jlh4Cy4jFrpB4xVlYL+LrWFJYiBT6fL/jlHRhmBTwgZAWgAklHnZ1vZxpmDsiT/kyA
 7G/9wJ9HDx+/yv6pGxV+eVGGw5ppZCnFxuh37fe11s1jHmOwGnunYZsL8yuPgUed6s73
 +iKwvb+exhaPZGY0TR2LH4FNbO2hIwmYU31jRD9id8Oo741c0likYkEh5MSv41crfpEt
 +l1VlZs5h13du2ImTCqehcZ7P1b3gyCH9FoQypV2YUECXrPzU01DG/40bF1F8t3g87+r
 GH/2T/wb9aF2/ZukEI5JR9tr3mogn1WkVYgIWiuFDediUKq9TIyxi7uXHu9kp9Kbbd0n
 Z++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718862472; x=1719467272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Br7c61/P2OIjqlAyx0RNDdZV9Q2YuJEe1WLoLoS2xi8=;
 b=HVF9d4ZcbcTD6RLZI9TlTwhX5yVFttPKxft1FDn9Xp75/GimRo/bGPBXHXx47xHjrJ
 nK3kO1laruEQWxUo1ImnZM2ojjll9HPYqj8kOyT3kPl/7k0o419oF3fQ3nlhbi3Pe4PK
 O4x8eeJ8+HDBug8Tdh+KzZ9vcaQ9b3U952DFD6tlAxXKvL9/QUVyI19BjcIhA2xKEywd
 8hPTtR9XSQvOWl7zD4Bb2plwxaEBr5sF+G5OGIiYVXwbOfK46fYgRnhS3fgM9KWmyXYu
 0Emnh0XfZ2O7mWCOs3lqVXF1fnAZ3llpJ6aCBR/2zTX6FkhHS2q2UEeov24N+c8OeHzV
 a96A==
X-Gm-Message-State: AOJu0YzrCMGIHhoJzbewAkeFIWKww/bFrkG7JcLHGxEdKPt8/FhfbX4G
 nAiIWouqXaoqFv7OdolN2o237Xq3KfYF7o/HKL+dKM/9L/dCbpI8djd21lsqqw16o2Nz8ShnNeq
 QVePKzh0ccb6q/SRA9KKadf4hM2qdwISdBxf3NQ==
X-Google-Smtp-Source: AGHT+IHn3eUalA480wAknrcpJrV4xRErRxPPCpbu0gAF0TKkxZPAVGA9Tf0EeRJyCb9u/Kvg/B753oexz/Q81Lmw0Ms=
X-Received: by 2002:a17:90b:60b:b0:2c2:ebc5:ffec with SMTP id
 98e67ed59e1d1-2c7b59fa605mr4559314a91.5.1718862471771; Wed, 19 Jun 2024
 22:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240619212759.3456158-1-trini@konsulko.com>
 <20240619212759.3456158-2-trini@konsulko.com>
In-Reply-To: <20240619212759.3456158-2-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Jun 2024 08:47:15 +0300
Message-ID: <CAC_iWj+5qZYWpnAWkErrXHEngMYuWMrzfs=Od5L1QDMcZjA4Dw@mail.gmail.com>
Subject: Re: [PATCH 2/7] m68k: Rename icache_invalid to invalidate_icache_all
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 20 Jun 2024 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> The implementation of icache_invalid appears to be doing what other
> architectures call invalidate_icache_all so rename to match.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Huan Wang <alison.wang@nxp.com>
> Angelo Dureghello <angelo@kernel-space.org>
> ---
>  arch/m68k/include/asm/cache.h | 1 -
>  arch/m68k/lib/cache.c         | 6 +++---
>  drivers/net/mcffec.c          | 5 +++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/m68k/include/asm/cache.h b/arch/m68k/include/asm/cache.h
> index 6ef7f7be1af8..aa8d2edb40ba 100644
> --- a/arch/m68k/include/asm/cache.h
> +++ b/arch/m68k/include/asm/cache.h
> @@ -185,7 +185,6 @@
>
>  #ifndef __ASSEMBLY__           /* put C only stuff in this section */
>
> -void icache_invalid(void);
>  void dcache_invalid(void);
>
>  #endif
> diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
> index dab834c1cbd8..370ad40f1423 100644
> --- a/arch/m68k/lib/cache.c
> +++ b/arch/m68k/lib/cache.c
> @@ -29,7 +29,7 @@ int dcache_status(void)
>
>  void icache_enable(void)
>  {
> -       icache_invalid();
> +       invalidate_icache_all();
>
>         *cf_icache_status = 1;
>
> @@ -53,7 +53,7 @@ void icache_disable(void)
>         u32 temp = 0;
>
>         *cf_icache_status = 0;
> -       icache_invalid();
> +       invalidate_icache_all();
>
>  #if defined(CONFIG_CF_V4) || defined(CFG_CF_V4E)
>         __asm__ __volatile__("movec %0, %%acr2"::"r"(temp));
> @@ -68,7 +68,7 @@ void icache_disable(void)
>  #endif
>  }
>
> -void icache_invalid(void)
> +void invalidate_icache_all(void)
>  {
>         u32 temp;
>
> diff --git a/drivers/net/mcffec.c b/drivers/net/mcffec.c
> index 04b711e4f650..7e53492733ed 100644
> --- a/drivers/net/mcffec.c
> +++ b/drivers/net/mcffec.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include <config.h>
> +#include <cpu_func.h>
>  #include <env.h>
>  #include <hang.h>
>  #include <malloc.h>
> @@ -399,7 +400,7 @@ static int mcffec_send(struct udevice *dev, void *packet, int length)
>  #endif
>
>  #ifdef CONFIG_SYS_UNIFY_CACHE
> -       icache_invalid();
> +       invalidate_icache_all();
>  #endif
>
>         j = 0;
> @@ -433,7 +434,7 @@ static int mcffec_recv(struct udevice *dev, int flags, uchar **packetp)
>
>         for (;;) {
>  #ifdef CONFIG_SYS_UNIFY_CACHE
> -               icache_invalid();
> +               invalidate_icache_all();
>  #endif
>                 /* If nothing received - leave for() loop */
>                 if (info->rxbd[info->rx_idx].cbd_sc & BD_ENET_RX_EMPTY)
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
