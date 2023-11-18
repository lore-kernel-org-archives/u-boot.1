Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE4EC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88C38700A;
	Sat, 18 Nov 2023 18:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PrmBZ+iP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F7F86FD5; Sat, 18 Nov 2023 18:11:14 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8332A86EF6
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7eef0b931so32734577b3.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327469; x=1700932269; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n39PRZVzJQgE+Ors7BC3E48g65Bol81so4fK1+89UgY=;
 b=PrmBZ+iPRB0RtQKuljH7+KeAtnFM2ggAnIFGrRLGxf2getgSEZCYiypwE0gPQq+ZfA
 HDdRcZUk18IC6DJE6c+7op9mCTVvzmj4TXaE4pSfa7eyQF55gwSb++yuoMxTl1CBtSaG
 SRic49L7fzOxCHPzaXcKcTD/0Ry+n2amc4Z4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327469; x=1700932269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n39PRZVzJQgE+Ors7BC3E48g65Bol81so4fK1+89UgY=;
 b=XZIy2J34No0QBwkLnjyRvmX1mScaB0+9T3WmS78HFo4jTY2OTnAPLFk2jYenuMn9Wz
 kBqFJMps5pvpjDqRsAVX21pkwrp9dlfbsDzayYQVC4peXV+WDs0nPKC+yRy0xNM/Tubi
 1E2QBN4GEXCzMrebJf3+lkIk3FqTUf0PAxbl9+Vz4qM+Pp3E2xoPkis1/0CntgYggF09
 SmBtynVlUhPhZGC+Qh0vcx5EORjrYJCIhKF6vuJAB5ujZGxfxT07ydqZMsP7M2HyJQRg
 HQ96GJLhJKonwIMsv1M7R3Fw7SrnT5m2VORv2l0hbpq9jDaP+zCZMsAc9GCEW+JQn1fj
 fkeg==
X-Gm-Message-State: AOJu0Yy4F2q4JEX7gcQ0URSCnIwJ8eQQstA+ej7l9Xny7/ejJzVTOLbh
 8ZMeh0llTkf8JOU8OcYT6POO1kiKwjUI65kqc83tNDsOmC0frzBZY64=
X-Google-Smtp-Source: AGHT+IE8MVOe0tHGIwHOs7xEVrAjqKVUOflEM4zPnOcjFNwgltrGn1zL0LQULvpZrypFFbTtzunAoB3h+bC6PLJFKi4=
X-Received: by 2002:a0d:d343:0:b0:5c8:708f:1ea with SMTP id
 v64-20020a0dd343000000b005c8708f01eamr3155819ywd.32.1700327469049; Sat, 18
 Nov 2023 09:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-3-trini@konsulko.com>
In-Reply-To: <20231117225313.2144665-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:09:54 -0700
Message-ID: <CAPnjgZ0gG3OYX3EH3sdimaWNLAw6iZTL3v8QHmbq=kZ3vZN4rg@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm: Partial cleanup and audit usage of <config.h>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, 17 Nov 2023 at 15:53, Tom Rini <trini@konsulko.com> wrote:
>
> We need to include <config.h> directly when a file needs to have
> something such as CFG_SYS_SDRAM_SIZE referenced as this file is not
> automatically globally included and is most commonly indirectly included
> via common.h.  Remove most cases of arm including config.h directly, but
> add it where needed. This includes a few board-specific fixes.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h | 2 --
>  arch/arm/include/asm/arch-ls102xa/fsl_serdes.h        | 2 --
>  arch/arm/include/asm/assembler.h                      | 1 -
>  arch/arm/include/asm/secure.h                         | 1 -
>  arch/arm/include/asm/string.h                         | 2 --
>  arch/arm/mach-davinci/include/mach/pinmux_defs.h      | 1 -
>  arch/arm/mach-exynos/exynos4_setup.h                  | 1 -
>  arch/arm/mach-exynos/exynos5_setup.h                  | 1 -
>  arch/arm/mach-k3/common.c                             | 1 +
>  arch/arm/mach-k3/include/mach/clock.h                 | 2 --
>  arch/arm/mach-k3/include/mach/j721e_hardware.h        | 1 -
>  arch/arm/mach-k3/include/mach/j721s2_hardware.h       | 1 -
>  arch/arm/mach-k3/r5_mpu.c                             | 1 +
>  board/freescale/ls1088a/eth_ls1088aqds.c              | 1 +
>  board/freescale/ls2080aqds/eth.c                      | 1 +
>  board/toradex/verdin-am62/verdin-am62.c               | 1 +
>  drivers/ddr/marvell/axp/ddr3_axp.h                    | 2 ++
>  17 files changed, 7 insertions(+), 15 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
