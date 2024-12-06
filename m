Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7EAE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFA1589741;
	Fri,  6 Dec 2024 20:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LdFUJCj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3918A8974B; Fri,  6 Dec 2024 20:21:25 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A10589376
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d889a1f7a6so22824776d6.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512882; x=1734117682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SJlNP5xaXOmb1q7FMxQAPBxyYNP7qm4UY1tAFWlG61Y=;
 b=LdFUJCj28xDQFTZML7i9PGJDoM9ui/+FeDp6/YoJpx+HBqS6XoPKny8NXADGOxPVGa
 i9CMqr8NbVnt97YIVoJ+45FA7v52apA7aQZRsx1bm+Q4rdJITUsthjJcqr8o75peAI32
 ukXspSkYGQQ6FH+5d6GMpanpTYkrtnfg4uDxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512882; x=1734117682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJlNP5xaXOmb1q7FMxQAPBxyYNP7qm4UY1tAFWlG61Y=;
 b=E+08wc4ZZRT/hbHFY1fTUCBqTTffYFI0yIw4AGkMH9vfGMVmIlFgvSmlUoolQhjsy1
 yT+zlor1hZ8qVhk7tqgof6pvAKXmw9y/xIYL9atCGjodnA5wpJNac37409LF55a/BRGk
 XinEeuhDEr4vomMdGV9a69ZOMjyahuCbFbIUKOE2Bsn3sbxxfXcshq+/iduGIYG2rbQT
 0MvthOxWMmF26drpTmdX/SMViWoQUu3E8w/IyvVB1TNAmm7UfINwJhj0s+EV0LaGoOLe
 Qi8H66LFD/YRT+88EEnrwKlPjtvduyqFdoVmOzcujuRw9Kz60f/9tgfqzCfZvMH+48/M
 pkMw==
X-Gm-Message-State: AOJu0Yx5khrgkl7YQZl8lVct7F2LFfwXcl3w+XdKB1yO3/EnGcV4/a67
 PeaPbmabAE4VOEpUdAbxQmv7h0qvAW2EUnOVg9EzR7Em+RXysjzyynFT6VmzIb47uOzQm8vFfIb
 FIGsyt8yx7Pza6SO18E/GPCe4Yr4mxLTu6OtQOofZF5uMLiM=
X-Gm-Gg: ASbGncsb4UwCYOnVOyhco9YHvakgL3wP2JhPvuE2o/SaRY/Z+d6C1StrvD7NsdRYQ1x
 8Am3meTQmfHL6U3moHEG5uQqc5Xb1XC3O
X-Google-Smtp-Source: AGHT+IG1vyJSe/NsW4u3BC4McIYap1PD5/u5Hnf6iqxGTC2fmfQJfbLv9QMfLaaUGcTj5xa0+2Zi0HQCjA2wiw8x2zE=
X-Received: by 2002:a17:90b:1a86:b0:2ee:c291:7674 with SMTP id
 98e67ed59e1d1-2ef69b3594amr6984228a91.14.1733512871170; Fri, 06 Dec 2024
 11:21:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
In-Reply-To: <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:20:52 -0700
Message-ID: <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>
> Calling empty function when BINMAN_FDT is adding +64B for nothing which is
> not helping on size sensitive configurations as Xilinx mini configurations.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - new patch
>
> From my perspective there is no reason to call empty function. It is just
> increase footprint for nothing and we are not far from that limit now.
>
> ---
>  common/board_r.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

This is a bit odd, though. Do you have LTO enabled?




>
> diff --git a/common/board_r.c b/common/board_r.c
> index 62228a723e12..ff9bce88dc93 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -287,13 +287,10 @@ static int initr_announce(void)
>         return 0;
>  }
>
> -static int initr_binman(void)
> +static int __maybe_unused initr_binman(void)
>  {
>         int ret;
>
> -       if (!CONFIG_IS_ENABLED(BINMAN_FDT))
> -               return 0;
> -
>         ret = binman_init();
>         if (ret)
>                 printf("binman_init failed:%d\n", ret);
> @@ -635,7 +632,9 @@ static init_fnc_t init_sequence_r[] = {
>  #ifdef CONFIG_EFI_LOADER
>         efi_memory_init,
>  #endif
> +#ifdef CONFIG_BINMAN_FDT
>         initr_binman,
> +#endif
>  #ifdef CONFIG_FSP_VERSION2
>         arch_fsp_init_r,
>  #endif
> --
> 2.43.0
>
