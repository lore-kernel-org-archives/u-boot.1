Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B314C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B278775F;
	Sat, 16 Dec 2023 19:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZvqUa0Md";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8297B870DF; Sat, 16 Dec 2023 19:47:42 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4C28775F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-db3a09e96daso1167794276.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752459; x=1703357259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ux/RF2imMd0gHtXSAPF221tADmizvBHUbCNoIUEjpME=;
 b=ZvqUa0MdLPxr7QPe7ZtLzKFbu3FkbocUH422MyVOMSEYGhWer2LlZjCJ2MmzXjhHPW
 OdP1YrjksoSMCPbf1g1zY4FjyifsrbJP+Wu+72Zg/9kgLfNTV5RQEmcoobhU6kMC2o8g
 +lwTw33Gs1QTpaziipIENWtB/I8ENELTqpgvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752459; x=1703357259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ux/RF2imMd0gHtXSAPF221tADmizvBHUbCNoIUEjpME=;
 b=xK8MGQUUrfoFf/SZ3c+Rf4dLBA/ivopvLbTv/rV5CcfLkyZ72bRRCZejIa3wLy0js/
 R6+L7UnFreTcUGc7F2r5PL00bVI1kX9Zbb3syQUD2X6qZzlj1+OvN3L/YIDOcNgRgSI+
 Sgg8grWpcE+EVILiqURAjIakpbc3a9HvIwRLYtGB61ZJyW5BZGH5r6D1XmVU5voN0iAQ
 tinGe04yLmAJUcHyBGaeZ2TJTRR1PSZMtPdDTL4GbQSjTDa0DIeLwJgijSAX0NWR1CLm
 Xg4WCi6Yav1nd9zuvarY3Qt4NernklQWuvBzvKrviC2hcIZIl2TuXv6H7eZDYD4tQLNm
 SG0g==
X-Gm-Message-State: AOJu0Yygkr3/hk8OOXQcWtEyEtIOu58QI8Oe+69OqfPEsA+xdLeX6zZf
 4/xfzLRdHJeK0y+GSou/SYPNti5Tsx3orktLvuC56HUgXBmRzU62RCw=
X-Google-Smtp-Source: AGHT+IFMvEF+tTEgdTtDKpZoDDt77lDhj8ksPFQA93xrcKstd/fbu4Q3PL20w7++XHEgCF1LJihDy+xa1s/mGThrHLQ=
X-Received: by 2002:a25:fb02:0:b0:db5:4e2d:8bb2 with SMTP id
 j2-20020a25fb02000000b00db54e2d8bb2mr8561025ybe.1.1702752458862; Sat, 16 Dec
 2023 10:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20231214181658.3359902-1-trini@konsulko.com>
 <20231214181658.3359902-3-trini@konsulko.com>
In-Reply-To: <20231214181658.3359902-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:51 -0700
Message-ID: <CAPnjgZ3hazbPtPDOxTSONHRRPCzQ8qcZ92iHRebEiJnkPLgScA@mail.gmail.com>
Subject: Re: [v2 03/16] arm: Partial cleanup and audit usage of <config.h>
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

On Thu, 14 Dec 2023 at 11:17, Tom Rini <trini@konsulko.com> wrote:
>
> We need to include <config.h> directly when a file needs to have
> something such as CFG_SYS_SDRAM_SIZE referenced as this file is not
> automatically globally included and is most commonly indirectly included
> via common.h.  Remove most cases of arm including config.h directly, but
> add it where needed. This includes a few board-specific fixes.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Update arch/arm/mach-keystone/cmd_mon.c
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
>  arch/arm/mach-keystone/cmd_mon.c                      | 1 +
>  board/freescale/ls1088a/eth_ls1088aqds.c              | 1 +
>  board/freescale/ls2080aqds/eth.c                      | 1 +
>  board/toradex/verdin-am62/verdin-am62.c               | 1 +
>  drivers/ddr/marvell/axp/ddr3_axp.h                    | 2 ++
>  17 files changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
