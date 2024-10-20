Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D01D3C927
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 04:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E8F88EB7;
	Sun, 20 Oct 2024 06:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wqiK5rLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568EC89161; Sun, 20 Oct 2024 06:34:03 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 234988878A
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 06:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2fb304e7dso2847590a91.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729398839; x=1730003639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=teFRpHPQUGt9kmNYLXF78LCwGaqB941UmVnUBQixpGs=;
 b=wqiK5rLL6vMCVYdCb2ek7xuWENQ0AQhfWa8gbor67RNCEOuIrddNCJQTprZUGosrAu
 4v9rKrYjhJGAqi47bS4TiocWEU9DrcNaHLfsohdSmQjuwPlJQl5vrWZ9zWQvjZqDyBuf
 sZJJTFbv2YMR7Hq0VLl0urFYh7lCGU7moCEOBLqmUY86EW54CzMahOHOo6W8U7jD+/4O
 7TY+Lr0GlW56cywoxXHFF5eZr/D/D8mZoIn8+D8ByRZ0/dfHqeV59cB4J1h4d12+QHTr
 PQnVjfIGUsJvOVCe735das9Z4tetyQ/ohjqsUvCYssh5LDP5MPUbupPfTvqCJi+l0Bq5
 5Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729398839; x=1730003639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=teFRpHPQUGt9kmNYLXF78LCwGaqB941UmVnUBQixpGs=;
 b=Lgo3JCKHFsRGlzcPQB41AYKx4y9jgGEQifSJ/looyGiqTPA5T9ev/oMzRmlgzz7yFt
 Evx92GEVGBSGKxB+bmKkq2/w1ihkfsH7eIrF4IV4Icm9grRp7r5vE1JZkU1uwQkOJlBT
 2eAzytnbg2uEmzWZn/LFeu5YWyhIK74KNuHt4v4ewo0zTntCZmra7rIw0JOIIwzvG6Wh
 8XydH6qnG0VN6fXKOxGrR5z+3rx/ZGeoHlpe9bZhPgqnUfggYA7qqtSrymBd8WYdxj6l
 WYeXXkT9VtZzscBfMMSTllgPQ04NMhhYAMhnTxvQiFBOUiZ97VA8FF9CT9fUos7FO/q1
 zHoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuU0bD9YPoRfnRJaMoe8d+qIR0j/9S9VceM8GKKGuE7AfuCaRc5FIFuaghYttV5xQiogY1WiA=@lists.denx.de
X-Gm-Message-State: AOJu0YxdH4d/rs70xpgf33OvP8PltAFDF8Gn8AC/6k1+7mTefy+dNVmp
 rcHp7yMJXv9klpgLKjN+/aSVW0FRSuFd2l2xWW1IGJYlNnQMoaXar9+D7b1q7oXqhC7sD+v5Stb
 fW48c4A8SP35As6IHUXVt1zYqbb+wToLjQpDPB0nyQszNerHDBUw=
X-Google-Smtp-Source: AGHT+IFocAFFvqbioRJRVlk3aY/4RuEwK/vRw6D0NGKxdbSbY/dSAML7y9mp8AErOC0lgrxidg/iJs8FuFBTci5gotM=
X-Received: by 2002:a17:90a:dd93:b0:2e2:bb32:73eb with SMTP id
 98e67ed59e1d1-2e561a012camr8561988a91.31.1729398839626; Sat, 19 Oct 2024
 21:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241019105957.54751-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241019105957.54751-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 20 Oct 2024 07:33:23 +0300
Message-ID: <CAC_iWjKhN6BUHNOHJMR+hKhP0pOAO4iUjBKFmGVaY_OQXyp5Ug@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix CONFIG_EFI_HTTP dependencies
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Sat, 19 Oct 2024 at 14:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> CONFIG_CMD_DNS and CONFIG_CMD_WGET depend on CONFIG_CMD_NET.
> CONFIG_CMD_NET depends on CONFIG_NET or CONFIG_NET_LWIP.
>
> We shall only enable CONFIG_EFI_HTTP if there is network support.
> We have to select CONFIG_CMD_NET.
>
> Fixes: d7d07a8b508b ("efi_loader: support boot from URI device path")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 69b2c9360d8..066f0ca0da7 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -545,6 +545,8 @@ config EFI_BOOTMGR
>
>  config EFI_HTTP_BOOT
>         bool "EFI HTTP Boot support"
> +       depends on NET || NET_LWIP
> +       select CMD_NET
>         select CMD_DNS
>         select CMD_WGET
>         select BLKMAP
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
