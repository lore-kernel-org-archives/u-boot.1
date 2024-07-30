Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D619C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 19:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 235B4888B9;
	Tue, 30 Jul 2024 21:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JxqtNZK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2A1888B8; Tue, 30 Jul 2024 21:44:51 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151F5888A2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 21:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b7a4668f07so26320516d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722368688; x=1722973488; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PABWvx5kCOsc1iZzC9KfaoqBfVOxzUDcU/THjo6QAY8=;
 b=JxqtNZK5JgXEfojeQx7hSwVV8vU/yuj3MNIRwxkHrqyu7X8ILGP0uDgqF3I/QZmB1V
 upsrY41KJVg1clllGRJZdayqHvDpthKT5VeiGRpz9MIRi3j00QKRp08NL5/6tclW/Xqn
 AwIwGhWGRueRXSl/ip4NLJ2jnOMFf8ptqqMMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722368688; x=1722973488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PABWvx5kCOsc1iZzC9KfaoqBfVOxzUDcU/THjo6QAY8=;
 b=ipoE9Hu+KIh0+dk/f+fMXEW4EF1baDKFJgpHmVv6ENZKx0iQv0cjZ8X71PMSY8NycP
 N0/VP5TK9krOWWma4aOf40W9XU5Llq6jGgf7wLGJd5hJNuO7ZhJJ27hEgVin4LsiCohF
 ZX5ImkpeI/8Rl9ex8xRVhvk3ZfOPDn4b1kj1blaejEDloX6TjQgdEBNk3bFPafhdPRNN
 +3YEZR9zjH+0zBP3y5O2eB6k7ujCwuVn/vjmPjEzOXMjXtt+xJWPs57VBwpZRVIzJEVU
 PHWfuG4fC9U9zmfzZtJ/KCuwAS/6cJ215c9FzeWnaO5HP7RUTX2Ov5KNexaFMPADMLSM
 GuUw==
X-Gm-Message-State: AOJu0YwwfPXQAnjWg3eOvKmSLT86eoL0Iup5a68WaFdUvAo5DWJGWPoG
 lYNSjtMICA/nT2+xLlaaxZjWGfBsF23OU1xsN9gAqMf1pIU5H17Q8zUq22gAa6QTJXtexLcmSvi
 7QSiCDrxCQw4oMJiIXivd7TgtXQp4qWvU24Pa
X-Google-Smtp-Source: AGHT+IHKSYFh10KGvv3iapluzGhbO8Sc/Hnopp2wGsNZyVny9nLicpUrNPNDfLqg3IGq+DJ/MTBcEyHZOlQnm5c9Ffo=
X-Received: by 2002:a05:6214:2261:b0:6b5:1976:98ac with SMTP id
 6a1803df08f44-6bb55a6f10bmr165945036d6.28.1722368687958; Tue, 30 Jul 2024
 12:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-3-sughosh.ganu@linaro.org>
In-Reply-To: <20240730111132.1097315-3-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 13:44:37 -0600
Message-ID: <CAFLszTiW+iptGpeV_Ou+dRgTTrtvVuXq6+ickgwyzD0GXc+6gw@mail.gmail.com>
Subject: Re: [PATCH 3/5] efi_memory: avoid possible null pointer dereference
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 30 Jul 2024 at 05:11, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Populate the previous memory descriptor node pointer only after it's

its

> parent struct has been initialised. The compiler fixes this logic to
> do the right thing, but it is better to have correct code in place.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/efi_loader/efi_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index bfadd6bd41..8d4f6e339d 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -138,7 +138,7 @@ static void efi_mem_sort(void)
>                 merge_again = false;
>                 list_for_each(lhandle, &efi_mem) {
>                         struct efi_mem_list *lmem;
> -                       struct efi_mem_desc *prev = &prevmem->desc;
> +                       struct efi_mem_desc *prev;
>                         struct efi_mem_desc *cur;
>                         uint64_t pages;
>
> @@ -149,6 +149,7 @@ static void efi_mem_sort(void)
>                         }
>
>                         cur = &lmem->desc;
> +                       prev = &prevmem->desc;
>
>                         if ((desc_get_end(cur) == prev->physical_start) &&
>                             (prev->type == cur->type) &&
> --
> 2.34.1
>
