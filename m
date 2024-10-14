Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E91AD1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C73891AA;
	Mon, 14 Oct 2024 17:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DyVXPdW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC3B889187; Mon, 14 Oct 2024 17:51:02 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1BC88936
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so23277696d6.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921058; x=1729525858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LOuFdjpUxq7XRgFFXLizvawC/dWqI45c50/qZfUUQH0=;
 b=DyVXPdW6chdLUaIxaeNc5H+Lu84VEuvja3s9DlBNow27JqYGlkO5Q9As0RVS+vocN8
 +iM8vpkkzFCDy2WI3ANDirmebHq1N8FzIQBCz6PfrAH3fsy3Z8ukeMt5cloLjRTqp/7W
 /9m75Qkg0apl0xhkW6wE0gd2br20tQdfIHKSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921058; x=1729525858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOuFdjpUxq7XRgFFXLizvawC/dWqI45c50/qZfUUQH0=;
 b=faf8qTu6MweqH82W3+mDKVPzad+Jq0+NYFQ977NGZUDMkHu0gkjHZsWs6AwoiPPoXF
 tuwI5NYYNOH3vikCDZrFjqr7PTzn2tMgY+bFb8H0TKz4tp5wuyZjSeX8ITfzLd8WnTrv
 fZdZcDWnDh+mWOMB3lUlgw30xzeAdVa/XYEAurisUADJCDb2Amt14CwBiJhzA++rZIde
 svYzIQ4LYZyU9X6s4PKOyZYfCrhXkjamEuNora1xN1oKEWVzslNRKVtzrXKtmfzRCASj
 QuKiB472GPymK0qKMJ6UwY6HYBuLWUUnd0YJ1u2DqRPaC1GHBmIfSwCoksVGvszS1QHZ
 YDzA==
X-Gm-Message-State: AOJu0YwWCWq75JBJhIyjPC6ocBmaEY2r82WdYNCg9bQ+7eNzagcMm/q1
 UL3TPFmtCxE1OMX+UIIMH6iLKJKptbiNNW/hw0tUPIb3YgIIyJ6KpAznhyI35ZILQt//FyPY8Q6
 59j1qXTWP2iqKufLWATTwoxKxzlkEvgSi1LFt
X-Google-Smtp-Source: AGHT+IGpSRvu5mhhdCbNkMZAjqx0clKHQXGAamttNt1K3Jd3/GhHGy0KWcUqa7AxtnJrxWdrVH1ztXNP8CSFQ02rSNA=
X-Received: by 2002:a05:6214:5d84:b0:6cb:f7f1:4643 with SMTP id
 6a1803df08f44-6cbf7f149d7mr147418456d6.45.1728921058623; Mon, 14 Oct 2024
 08:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-10-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-10-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:47 -0600
Message-ID: <CAFLszTgc458kkdyziZKhtsnD5B6gS2NvPHDtwt-DdxZnLGLmNw@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] stm32mp: remove efi_add_known_memory() function
 definition
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The efi_add_known_memory() function for the stm32mp platforms is adding
> the EFI_CONVENTIONAL_MEMORY type. This memory is now being handled
> through the LMB module -- the lmb_add_memory() adds this memory to the
> memory map. Remove the definition of the now superfluous
> efi_add_known_memory() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since V2: None
>
>  arch/arm/mach-stm32mp/dram_init.c | 11 -----------
>  1 file changed, 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
