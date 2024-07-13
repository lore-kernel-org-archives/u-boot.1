Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21670C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D7D887BF;
	Sat, 13 Jul 2024 17:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DB9AKs2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BCF888EF; Sat, 13 Jul 2024 17:15:34 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7F888817
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70af3d9169bso2390351b3a.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883730; x=1721488530; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eleInpEfFe9t8TjTS8kZ7DhKwCgYDFpTq3NTlXOJ6HM=;
 b=DB9AKs2JmkcxDmQyHXaawvZOlsYigrF3dIhlPvzusqK4cW6yu2Y51RdA32ipaMF+4k
 NZq2b6t5wPTAZhiSLGSRbNhccx7sjgbEJkgOIseFwoqL+L42Q2w9ZhPzdMuMaGCfue11
 m134cNMd5XyP01ftuz98rvB8SH9vm6QLKD5NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883730; x=1721488530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eleInpEfFe9t8TjTS8kZ7DhKwCgYDFpTq3NTlXOJ6HM=;
 b=YfX/i8lSAha1XimPLF4DpCANc+tzV98FpJUbzZty3Bn2nm7KzP2vzHee1wPSkBvzrz
 AXFgj/uYQAEH3pwoBuLbg+vILknJtucgIEEgQ9aGg//E6E+CqQdk/K6mcRs3BSoMaVYY
 TMjf1LypK5wrouX2rfvWfu9wn4J47VD3dVaBghhdVqgtl2jFGm87pOAsUskfq92HSIFu
 RO10UZ8lvde1JYSdVEncXbE6Uyp9IXxQIDR0/8BSADVNgjRaBdpGBQXqPMd8fdlPT2qT
 TWeaAOiuTB14MRM1957U5ieMCqunxptbdCXl3IVCG7Yv69L+d2klnWQYhpdyRvsj9bfQ
 KqSg==
X-Gm-Message-State: AOJu0YwFfu+prRL3EYjnkwnnHqF1Pti8VyndVXPI6C6rtQILmYAHAwiP
 yyO5QLOeTGZqvfaHwMVV9LNRjJYL5PcupC3equ3WVAy00ELudZlD/fUNHQj2pcHOG+92DgtaOEx
 NUyB0CqWDWYomxdvfaLPT8LCaXhCe9nm1D0C8
X-Google-Smtp-Source: AGHT+IEF0vo4yAyCqni2a4C5es8iJesFM5k6oylzuj6kRYcAVwm8a59KmivBcOem56TZImbHpQu0NV6RnfynhjkBzvo=
X-Received: by 2002:a05:6a20:914f:b0:1c1:b653:a754 with SMTP id
 adf61e73a8af0-1c29821ad32mr17098198637.25.1720883730446; Sat, 13 Jul 2024
 08:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-46-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-46-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:19 +0100
Message-ID: <CAFLszTjQdZ060yGxLeKzGBLX+HLMm0ECq5Fc3GfYr=VUYdi1QA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 45/48] efi_memory: do not add RAM memory to the
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI_CONVENTIONAL_MEMORY type, which is the usable RAM memory is
> now being managed by the LMB module. Remove the addition of this
> memory type to the EFI memory map. This memory now gets added to the
> EFI memory map as part of the LMB memory map update event handler.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  include/efi_loader.h        | 12 +++---
>  lib/efi_loader/efi_memory.c | 75 +++----------------------------------
>  2 files changed, 12 insertions(+), 75 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

This is definitely moving EFI in the right direction...using the
existing U-Boot memory stuff rather than inventing its own.
