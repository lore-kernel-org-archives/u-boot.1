Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9422C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5578087E9D;
	Mon, 10 Jun 2024 11:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EwQ+QMnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A136287E0D; Mon, 10 Jun 2024 11:38:28 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE4487E9D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f6dfc17006so17188675ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718012305; x=1718617105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iT8Dw5X0r4fFTQcRUaFsnX4kLyr53aZ/+jF2O1ia8K0=;
 b=EwQ+QMnWsS16P1df2cejd8wKYA8PtqN94Cs0U5pFXrXhk4lY1NavxqLEUhbSB15NfT
 G+LfYiCmvdXKSdHpMaIPGhxxZVoqqffRMv9n2wj1124OQAh3dSYFn90UBpipbTYSwBHw
 xAsOJ9qa1JfBi+Pzw4yr/Vv3/efO2U63RYui5e1chbzHgTv6MJeJGIfVXUq59af7tsFc
 jdklK/vrhQYW80IUfhX+SbTYdXkpS1fq2i0EGI+3t5aNTsfuYN8HQQ3z69FYQc6kav4c
 ZNmJDtnAVkuWxFS5blDeIiwIE6GWz8ec7bGz37cv3TxIdjpl3LmIptZeqU9jYetdIUtC
 CysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718012305; x=1718617105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iT8Dw5X0r4fFTQcRUaFsnX4kLyr53aZ/+jF2O1ia8K0=;
 b=GRwNWrTTvObPR+KXM/x4rFBNMq8OWfwk5Kgjpqd+LHjx3P9XTAf3dehYZWvjP/JgUL
 QvYwLyUVadMtp6GDOlkqzNrPGOYVaOyNygsVGz8Dhu7FB1JmIZ+uVZ4Ll0WTzcDilEDa
 516/aBxNHz//SsBPF0B1EfboACg6QFMuwrMvmjGtMcZXuq7J2IMpiRAzLPo0Hj7draS7
 w5GDIKoqrlpNesZo+qP6oqTZmPKwVgW+qNTBSTUNOIcuOrvSN/LLMb6PAIph+OCJCzCt
 aiY+9YwYYKN+QD91sHjtbbGJTXVt2mcPMliw0O6fGuxB/QiE24PnTcSFWKtM5fPOxOaZ
 Ix0Q==
X-Gm-Message-State: AOJu0YxEsRRI+NOEo8oQ5bFnEWJoJ5ejK4dgC0XvORWlD89rVjodKqUX
 oSo5bVoWX3TZh8HeQ7AajojVPXFDbVpIRHvlY5qPMjhSD2rUW6XdERrh5h5YauuRwug4hD3Jicg
 f7er47JfODn/wutr+Y5/vlkxHNwRADpMJjBoUEIcq2qBpoXFz6YbzXQ==
X-Google-Smtp-Source: AGHT+IGhvh3aAfRkP8GO7TRoC7U9fLZKoAmno5/RpqwDSI3Pzh0hzOYTpMwvtchRx0yCPowy/JD/oEPiwZhp9PVOjsE=
X-Received: by 2002:a17:902:f690:b0:1f6:fa4a:5080 with SMTP id
 d9443c01a7336-1f6fa4a537cmr39157035ad.8.1718012304771; Mon, 10 Jun 2024
 02:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-3-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 12:37:47 +0300
Message-ID: <CAC_iWj++=PHS2mwpL70=qTQ-9SFR50X3KvKgDpEmq1BryWQKaw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/31] lmb: staticize __lmb_alloc_base()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Fri, 7 Jun 2024 at 21:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The __lmb_alloc_base() function is only called from within the lmb
> module. Moreover, the lmb_alloc() and lmb_alloc_base() API's are good
> enough for the allocation API calls. Make the __lmb_alloc_base()
> function static.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  include/lmb.h |  2 --
>  lib/lmb.c     | 39 ++++++++++++++++++++-------------------
>  2 files changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 6c50d93e83..7b87181b9e 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -112,8 +112,6 @@ long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base,
>  phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align);
>  phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
>                            phys_addr_t max_addr);
> -phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
> -                            phys_addr_t max_addr);
>  phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size);
>  phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index adc3abd5b4..4d39c0d1f9 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -435,30 +435,13 @@ static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
>         return (i < rgn->cnt) ? i : -1;
>  }
>
> -phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
> -{
> -       return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
> -}
> -
> -phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
> -{
> -       phys_addr_t alloc;
> -
> -       alloc = __lmb_alloc_base(lmb, size, align, max_addr);
> -
> -       if (alloc == 0)
> -               printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> -                      (ulong)size, (ulong)max_addr);
> -
> -       return alloc;
> -}
> -
>  static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
>  {
>         return addr & ~(size - 1);
>  }
>
> -phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
> +static phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size,
> +                                   ulong align, phys_addr_t max_addr)
>  {
>         long i, rgn;
>         phys_addr_t base = 0;
> @@ -499,6 +482,24 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phy
>         return 0;
>  }
>
> +phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
> +{
> +       return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
> +}
> +
> +phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
> +{
> +       phys_addr_t alloc;
> +
> +       alloc = __lmb_alloc_base(lmb, size, align, max_addr);
> +
> +       if (alloc == 0)
> +               printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> +                      (ulong)size, (ulong)max_addr);
> +
> +       return alloc;
> +}
> +
>  /*
>   * Try to allocate a specific address range: must be in defined memory but not
>   * reserved
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
