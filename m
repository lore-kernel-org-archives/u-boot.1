Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24420D339A2
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 07:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C67488D5C;
	Tue, 29 Oct 2024 08:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VmPBqMTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A14A890D1; Tue, 29 Oct 2024 08:35:26 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6263388C05
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-72097a5ca74so222283b3a.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730187323; x=1730792123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VpisTAM7XWNpq5UNGWKsp0lAg20Jy1WQqYtPm9mIxTM=;
 b=VmPBqMTZ/INAhwIPYpU/XcF/HKvRxvJGxi4MAhtJcZDYV9JugD+cZVNyuTG+tbGZCS
 uOuL7tHOx57JDXvDQZQYmyA3RFzVZTYek/TLZtt9GBrzvYVC2YjcERysG7S1QwWcr99c
 AjXliHrPM5AaGxWhYVyFn/nNzjPgF2P5yl05DNDkh0BIR9CyiLqg9KWAtZqWyYZCxcjN
 i73vhoq2WDxJX1PovuRWAtySR1swriGOsML03dzQzOtbQFZIg103TT+MIGMr/lMu7652
 Cr1Dvb6e+g080a6iATwoz7wRbiw/r7u/CZ/lq6FjvVHEwDysDi/jB2MLcxmEgrvLJ8Lb
 a07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730187323; x=1730792123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VpisTAM7XWNpq5UNGWKsp0lAg20Jy1WQqYtPm9mIxTM=;
 b=NgY2ZVOF5Ac3q7lbTxsW0mszoIY2I7HevZFTlV7X6AUkClZL0rdGbpW+X/L3e2s5q+
 ekOXaatgJTroI4g8mlWVwfSX9+NcRvLk3qwctTCoB3NSpAD6KPtEX0R4w1JcUUKtpPMP
 Y3kZP7vnWvw7jJSlacqqqQmQl5fAgHT6PslNB69gnvCPnEPJkYBMvC99DueiH1cdXwVf
 6tufakVNmaEM+gSyj3V7zgrcb39VtcoxO4CkXGTABxHN7udFSGvjc37epB4KAawHd+8u
 l1qnVyiQzVEOB4++p9MDhrQo2K7w1uIil1G/O2t+zZqMbJR7FY9cn7v/jZcD+zG0yRJ7
 PCIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXowN1UYfeZ0WbkvT4zspieGmiC4uDjSqhhHcvckTzaPcbhG2hFYPo1LcASNAcmGctTt4uPyI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy40qdkPHyxUQjmHJt8aY5Rts8iI/uENORDLbbXCQtSVF0hzdof
 p1AlVJHYiILz/16MJF3im85TNUHsgUiK3KlXc+k3bICZN6n7gFoc6BXDV3imqG80Xnss9maQWfE
 PxkOEA/DMi5/IUjnyukFKL/prVXAOgXhgfliuuw==
X-Google-Smtp-Source: AGHT+IHTFPcZSnKY58JMUshMA5MHnRasENi3rNUbHVZ+OZ5npEQHdNeIvBBWJ6Uy9Lo0er80Vq09IO5EXylSFOYJ5bI=
X-Received: by 2002:a05:6a00:1818:b0:71d:f7ea:89f6 with SMTP id
 d2e1a72fcca58-7206306c2dbmr13892728b3a.18.1730187322839; Tue, 29 Oct 2024
 00:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241028062136.10742-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241028062136.10742-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 09:34:46 +0200
Message-ID: <CAC_iWjKcB-gMD6pxUv0X9w0R6zCKLcnpJxfWYA6ceKjrr+B3cQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] lmb: remove __maybe_unused from lmb_map_update_notify
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Mon, 28 Oct 2024 at 08:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Function lmb_map_update_notify() is always referenced.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/lmb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index eec99c185ee..802fdb84489 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -38,9 +38,7 @@ static bool lmb_should_notify(enum lmb_flags flags)
>                 CONFIG_IS_ENABLED(EFI_LOADER);
>  }
>
> -static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
> -                                               phys_size_t size,
> -                                               u8 op)
> +static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op)
>  {
>         u64 efi_addr;
>         u64 pages;
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
