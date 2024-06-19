Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C79C2BA1A
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F80D8845B;
	Wed, 19 Jun 2024 14:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KP5D8LYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A7C8846D; Wed, 19 Jun 2024 14:24:16 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DD487F5C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-707040e3018so2553015a12.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718799853; x=1719404653; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MPhjVQVUe1vv6tiizIRMc4RfsP/MdECZRVlNCgCZpCw=;
 b=KP5D8LYnE8G1TKj01q9sHv+9kjpl6I8O7W9Vas/WtBzU7wwHfE2FdkWH3wBJnYSwIt
 C+kD2s5kGtqwtZqkqdWiR660sG2NZGPXCjR50Tiw6whtwHlbf4rZWdMTJQ2mAjxdDCDI
 ncjD6PV/4F+J4QcfR5yUblh07VBwaaoHbuiQGOi6P2Rd/7zcCHtbsos3gJIjv9N6FtZg
 dDdwS679lt54+TvA6XIipeKznoIytgMK0+doiDcIz6b8FUs2vx002OKBnBoq3TO9QCaV
 9+TOSHDV6KTZlMz1bbUnRj9hAEIEA4dn7UtAYDJuxWJsem83gP4Y9MA0xLVFK5fuRFZ2
 LJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718799853; x=1719404653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MPhjVQVUe1vv6tiizIRMc4RfsP/MdECZRVlNCgCZpCw=;
 b=l33i47Sv1cn83I4gj67tjBKjwF+nJy7tErWy31+KBTIAoFh3RcVIQlfDuF6qhZ7bji
 il2rBbAhTLTvT/uoqAoTsxoxOFcnrHHy/RpIMamqQGGF8fK9+87Lqjc0Q8SIJEB88sy8
 VugYYVVNcusmdyDzKIqMYjW8RPENqdNk2BJXjHa9sy93Vy92v+yuzJKN9D4lkEA7vN2a
 /uGGBj3BzOgXZ6/PLWyccU3P879JO4hX1gs649MVSEpWcDKgPHCoI62fGmZ7qYaybukA
 2+NfThtJmVhfrMAZK+yZNfpSWrt6R1lulyrO9K5xZlRt0OPhzXLkXS0U8bRDSqLF7B+z
 h28A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+39+V9UHjB+QM6Dkn7TJ/DbxKEDG0KMNX2jeyZFoQmIsw1Po9vL+3ckqvUe21KZgTmXTm/oFGROX6B/lFfsdxMmI/3Q==
X-Gm-Message-State: AOJu0YyM8yVz5mItBvr6suc6wuemaOyiaWczDyp11nd/w3U5vNn+ePD6
 PEqC6uUQijs4nW6/cyPX/KNhiuHBNYNgBsyI4/koRxASFhtucVi2yWtFE/chcva0me0aWtr/Kty
 l9OjnxoHeI+Q88VSbTFjNBLY2Hp5FqNfNmuHQwg==
X-Google-Smtp-Source: AGHT+IGFwyqJGQX9BZuKKNrMiP9jAn6bGYTnSo7QxPoL/nrVXnQnje5FDOoA0nVyPoO/4WcjXo2QFAJ8f7MXeC82xtc=
X-Received: by 2002:a05:6a20:914b:b0:1b2:ccf7:4ad1 with SMTP id
 adf61e73a8af0-1bcbb646a99mr2826519637.57.1718799852793; Wed, 19 Jun 2024
 05:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240616173105.7430-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 15:23:36 +0300
Message-ID: <CAC_iWj+W5grPjuD9=v7ZOYGPFDE7_mFxF7fJhERTTJCjjpk4aQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmd: avoid duplicate weak flush_dcache_all()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
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

On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If we have multiple weak implementations of functions, the linker might
> choose any of these. ARM and RISC-V already provide a weak implementation
> of flush_dcache_all().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/cache.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/cmd/cache.c b/cmd/cache.c
> index 0254ff17f9b..16fa0f7c652 100644
> --- a/cmd/cache.c
> +++ b/cmd/cache.c
> @@ -52,11 +52,14 @@ static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
>         return 0;
>  }
>
> +/* ARM and RISC-V define a weak flush_dcache_all() themselves. */
> +#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
>  void __weak flush_dcache_all(void)
>  {
>         puts("No arch specific flush_dcache_all available!\n");
>         /* please define arch specific flush_dcache_all */
>  }

Aren't we supposed to add a single __weak function so the linker can
replace it? IOW why is the declaration for Arm/riscv a weak one?

Thanks
/Ilias
> +#endif
>
>  static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
>                      char *const argv[])
> --
> 2.43.0
>
