Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B7CC78849
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 14:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942A287FA7;
	Fri, 20 Sep 2024 16:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tD3T+mFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E22C0887FA; Fri, 20 Sep 2024 16:01:25 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7BFE87E30
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 16:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71923d87be4so1563109b3a.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726840882; x=1727445682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AC4FecRGNlK/tn4nFG+7eXNHTY9pDpZWznqoJL6zy6k=;
 b=tD3T+mFfePHUg9wyjdk3XPoZ4OR/Fsbb0eLjz9RW+pZQnKCBc+OyQby3RdRqWpIaRL
 KGGh7gsjeW5dGx+YoofFpurdftUIO1EhK/0YqECHsJvkPrVqcP8kF4o+aOSGA/S7LBvh
 Z4Wr5K7GtzDUjqJW9xuS86pnezVNvwoNtPTVq3uYAJlRTqsSK6hCC/Den9jgS43mlHHm
 hCpe2oTBYwYrj7KM1mPj1yYTN1kH7nB4YoQAEJnHAPrmPVm9bFhex4Qc0PD5BYeL/Sh5
 siHF6viGBWIjaitLsaJv75/R0Co4hoVGIh9+6K4Wl9ZEdNrrlAxjOin3yhu7uj1oZGfO
 fA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726840882; x=1727445682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AC4FecRGNlK/tn4nFG+7eXNHTY9pDpZWznqoJL6zy6k=;
 b=YzVULuOoiNC1o+82d+ALiLdYRKQ6kB0ASdN1rHeEKyJQLVLJQ6QlvJu2/ztnK65xTn
 v+IekbKwVuBZxBxwdYkFh/ouyhzOmk6OBqi9juv450NO0Mb4l2lsNu1eidqKZjhmRzF5
 dAkWEOgIJh0pEvvtQ0A4Sedpqu071zum8oN7KR7HlFVg507n3UYFmp5hA9wmnRwEV7Lz
 4O05/8x50pECIFKCWTh2aoIlyuQ5k8COoblpqmjEgFImCFLg5uMR1QDEClG/6P3NLx4c
 6D0iI6xeSnLFkdPW9nBhO5fN5U9pDXI0FEnrKt+xb29JXfy0EckmO4FCdeTQ00d5NlaU
 0lKQ==
X-Gm-Message-State: AOJu0YzK3pfjdnhcoGZWCegBV09ax0P/u5I48OHRth4iUCBGkv4aHgAw
 XqnPcx6teqFHs0ANkcoNc81Fo5o1p/uycSvbmYSKrdhoq6VCfnFurtfI0Hvke8iDNMK52sH0q/T
 d1AU+qezDfXuPu+huGKmfd9DnxusblXIs2QAOeQ==
X-Google-Smtp-Source: AGHT+IFOxsDrXY7Qw7mcbjDgfbveCoiBGQMZ83hEgADCQDz4CnXjdJZVdA4r6OsCwvEwq4N7/692dax5AYaMEKToKrE=
X-Received: by 2002:a05:6a00:996:b0:70d:3337:7820 with SMTP id
 d2e1a72fcca58-7199c952806mr3948764b3a.8.1726840881998; Fri, 20 Sep 2024
 07:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-12-sjg@chromium.org>
In-Reply-To: <20240920072444.134997-12-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Sep 2024 17:00:44 +0300
Message-ID: <CAC_iWjLDQqGH2cgFXZD5AqphkxqGYstEEA3HuYoPRx3ostwbwA@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] arm: Fix up a stale comment in sections.c
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
>
> There are currently four symbols here, so drop the word 'two'.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm/lib/sections.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> index 07efabaa7dc..8955aa6111c 100644
> --- a/arch/arm/lib/sections.c
> +++ b/arch/arm/lib/sections.c
> @@ -5,7 +5,7 @@
>  #include <linux/compiler.h>
>
>  /**
> - * These two symbols are declared in a C file so that the linker
> + * These symbols are declared in a C file so that the linker
>   * uses R_ARM_RELATIVE relocation, rather than the R_ARM_ABS32 one
>   * it would use if the symbols were defined in the linker file.
>   * Using only R_ARM_RELATIVE relocation ensures that references to
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
