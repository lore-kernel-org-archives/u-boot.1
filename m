Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0746C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 05:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C349884D2;
	Thu, 20 Jun 2024 07:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DN53RxCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1182C884DC; Thu, 20 Jun 2024 07:49:18 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE7F882E8
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7042a8ad9f5so1027947b3a.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 22:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718862554; x=1719467354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=US+sIcYo8c28KHosQ19Im91UTQbLeYj6BH5eUNXd6BU=;
 b=DN53RxCF7c8kElwdJnrX14LOMG7KFb1/2+Et9hoceGBf0jnB9D9GN1E4aR+5CIJIEN
 oku18ajOmde/y6PPSulefwWtoYM6ZUl1yBi7hbm6x2JU9dNSPwco1r6wArZBtyRzNgU1
 BOdw5WoJuxbVDRdNdsqBY1sSpdNWhxRL3UXj3oCSxaGM3S0QctYllCsv0p3NissxLC7P
 LxkefijgW99s6a7UYzW8wQ4wMvAhZvYL1OZAXLtm1nMJjG1NwJ0Q67a0piwVqkb6oMkV
 2mquiLvCXuV15x4E95EPK0bsb9yywKdFmw3xA8xb+RFIY5nKIg4MZvYL3a0zffhs1G7P
 tW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718862554; x=1719467354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=US+sIcYo8c28KHosQ19Im91UTQbLeYj6BH5eUNXd6BU=;
 b=rWkJPTguqAXFe5snjCv/spKmK18o03rgkCMMib7sN2QOUjJRnC/vKNmtt5e9aOwlu/
 gsFkPLsmfqtdfJ4ktPYvo/e1aDOx12isW2mI+Jgmp0GAiFy85m9AOxV43Jo7umxC8k1z
 iq4fAaOU3zU5xt9mxE7lExvdeBpHRHO1men5ZGE1LZHTop2pSbRJQhoIQvPJ/bcwc8Sj
 x6SfQW03osMsN3zjTgSKWt7TQwbUlQQJ5O+5OegDyINsUgwTOFGMCqNoukJSnW+e5OwT
 Vl/3otXqwWRCyv481SEcUt5FluM6EMfS8qAEJh/Tlo0BY7KzEwhNrTmh81LVnKRGXS0J
 +DCg==
X-Gm-Message-State: AOJu0YyD9etNZEn83uveguq9SElHnaHuMmxX9ed1Jkh72laA9mB7Qafz
 C3vMUzUTH+J7QyISbkoZqa+tvahejhfte1qE2nnNzMbDEAppyigO8ifhsPwTgfsgBLumzeuKi13
 p9PYFKJQUgwGDZZ7rbPznyUq86W9kQ5jT8Ud52A==
X-Google-Smtp-Source: AGHT+IEsiOfIsE1TyA79GK7I7BSZbjZTRhGDIKNyZUFqQ2E7Y+/QRA3HPnuKFR+WH1Zq90IsGKnUh0AEC/T79dgoo64=
X-Received: by 2002:a17:90a:ea89:b0:2c7:fdcf:7cf2 with SMTP id
 98e67ed59e1d1-2c7fdcf7de6mr42692a91.9.1718862554010; Wed, 19 Jun 2024
 22:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240619212759.3456158-1-trini@konsulko.com>
 <20240619212759.3456158-7-trini@konsulko.com>
In-Reply-To: <20240619212759.3456158-7-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Jun 2024 08:48:38 +0300
Message-ID: <CAC_iWjLk30o_UuLjMU2f7BbG9B-Z9KuHifM1WFBQDcO_o=P-rQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] cmd: cache: Remove weak functions
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
> It should be up to an architecture to decide how to implement cache
> functions, and if they need to use weak functions or not. Allowing the
> cache command to be built without cache functionality implemented is
> unhelpful. Further, guard the call to noncached_set_region with
> CONFIG_SYS_NONCACHED_MEMORY as that's when it's implemented and again is
> an architecture specific detail.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This patch series is intended to replace
> https://patchwork.ozlabs.org/project/uboot/patch/20240616173105.7430-2-heinrich.schuchardt@canonical.com/
> ---
>  cmd/cache.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/cmd/cache.c b/cmd/cache.c
> index 0254ff17f9b2..7a2068296ef1 100644
> --- a/cmd/cache.c
> +++ b/cmd/cache.c
> @@ -13,16 +13,6 @@
>
>  static int parse_argv(const char *);
>
> -void __weak invalidate_icache_all(void)
> -{
> -       /* please define arch specific invalidate_icache_all */
> -       puts("No arch specific invalidate_icache_all available!\n");
> -}
> -
> -__weak void noncached_set_region(void)
> -{
> -}
> -
>  static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
>                      char *const argv[])
>  {
> @@ -52,12 +42,6 @@ static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
>         return 0;
>  }
>
> -void __weak flush_dcache_all(void)
> -{
> -       puts("No arch specific flush_dcache_all available!\n");
> -       /* please define arch specific flush_dcache_all */
> -}
> -
>  static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
>                      char *const argv[])
>  {
> @@ -69,7 +53,9 @@ static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
>                         break;
>                 case 1:
>                         dcache_enable();
> +#ifdef CONFIG_SYS_NONCACHED_MEMORY
>                         noncached_set_region();
> +#endif
>                         break;
>                 case 2:
>                         flush_dcache_all();
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
