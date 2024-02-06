Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC2C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 14:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A628798B;
	Tue,  6 Feb 2024 15:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sl/KW5PN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5CE87BB5; Tue,  6 Feb 2024 15:44:49 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E6B87B6C
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 15:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a30e445602cso143656766b.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 06:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707230685; x=1707835485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TV+puZlDVgVS0cqhUi5Kakymaj2W/LQM0xUU4Oa54ME=;
 b=Sl/KW5PNmqGro6nlA/QZ/sFo/N1017EBnIZmRI+gkL/G7LR4GC8CW6B8xmTxX2P8b1
 UUuZuL+nwcrvwEW7lDEc1IyPnDX4pm99onKW3S5DWVr4VP+dE8lvCiO5zpiTNR6Hw5so
 QvWMCN8cevV69YgvPWMIkAHp0tvzOYfxEDxijBr9YrfOPKIdwldp1yJGIo71cmRD6HvZ
 4icV97dx0sOeREr2aCjavxQc09fhuOf+8prfOCBO6CRc7iOYonk0SmK2s+2AxxkjYiFD
 27zU29am2x0H6s+H4SuDsFhIkMYJcYC41CrRkBI8mJVomhONJsE0jV+hpsVrkOkCjzbL
 WY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707230685; x=1707835485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TV+puZlDVgVS0cqhUi5Kakymaj2W/LQM0xUU4Oa54ME=;
 b=I4GoIZMB+luQKd3byeAtfAqzAKEFVQr211YP6SQXNyojDz9u7ANGFqfbLzyJzFPT77
 1l0p03jJ10XzC2tXgyLcOkMcK+uyOp7A3K8CopPV4inBloaMAaeDYFe+naWkKG8p9jY8
 Ipmy7LUkQ8Sk4N1JQjZA7yLnYuRFduRBLXEAn4fWQo9fhSDWkrTwDRDd1oqCCLSXDFxO
 4r2EsJBV5UR4HFP+TLl2K570NsFgDkqgVuj0Es5tUtXJhSkkIer7iQfZDYpzyR/Q9xxb
 PgoksmtVTuI7MHzizH+7NjJSgwklvwgHu7CHxC6qaVRR8FO8k479QxO2E9DfMZDSNprf
 +lCw==
X-Gm-Message-State: AOJu0YyNF6/PNNOvOxTbTB57JeYPVdUPwwAXmI7f1IhL2EAHAoElHAi/
 HETuK9JZT82GOK5RCQZyMwp3ul4t5DvopRs/c7xDaCuB81BIJGOCzNoBG/RSP4kzlHTVSgS+rp8
 R
X-Google-Smtp-Source: AGHT+IH5R1AvuFpYcZD27FugLdZkb7wkPnA3qqOmdoPUIKPOKFXjA/dvAYoklsvlIYI7qkz3Sx5w1Q==
X-Received: by 2002:a17:906:48d:b0:a38:4fb5:c440 with SMTP id
 f13-20020a170906048d00b00a384fb5c440mr298680eja.37.1707230684664; 
 Tue, 06 Feb 2024 06:44:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUXVH6FboMPxOp7wVlHYCCkF6F0SdQfo3f2RTdhckB7OAnQOJ8BmzALv9ReQQnv//cbjNyTzTiEUKXvUgEk9UjaZlIYnJyJPC6jxplVXRkJDJygDCY=
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 rg14-20020a1709076b8e00b00a382ba97f95sm737160ejc.143.2024.02.06.06.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 06:44:44 -0800 (PST)
Date: Tue, 6 Feb 2024 16:44:42 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] arm: Add OVERLAY command to BSS section on ARM64
Message-ID: <ZcJF2uGIMj-jxT3M@hera>
References: <20231217003347.194657-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217003347.194657-1-marek.vasut+renesas@mailbox.org>
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

Hi Marek,

On Sun, Dec 17, 2023 at 01:33:39AM +0100, Marek Vasut wrote:
> Avoid allocating and loading the BSS section.
>

Can we elaborate a bit more on why we need this? AFAICT there's no code
loading those segments in memory and swapping them, so why do we need the
OVERLAY? On top of that the ALLOC flag seems to be missing? The .bss
section doesn't need to be loaded indeed, since we can memset it to 0, but
it does need proper backing memory.

another thing I noticed is the bss_start and end are defined as sections of
their own and a bit of git history led me to 3ebd1cbc49f00050. But the
linker script will emit absolute addresses only if the symbol is defined
outside a section. IOW applying this makes the value expressed as a fixed
offset from the base of the section and the bss_start/end sections go away

--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -151,17 +151,11 @@ SECTIONS

        . = ALIGN(8);

-       .bss_start : {
-               KEEP(*(.__bss_start));
-       }
-
        .bss : {
+               .bss_start = .;
                *(.bss*)
                 . = ALIGN(8);
-       }
-
-       .bss_end : {
-               KEEP(*(.__bss_end));
+               .bss_end = .;
        }

        /DISCARD/ : { *(.dynsym) }


leads to this:

 11 .bss          000090b0  0000000000102b00  0000000000102b00  00112aa0  2**7
                  ALLOC

P.S: I am playing around with rewriting the linker script and mapping
u-boot with proper permissions at least for armv8. If this patch is neeeded
*now* can someone explain why? Otherwise I'll clean it up once I test my
patches enough

Thanks
/Ilias

> $ aarch64-linux-gnu-objdump -Sh u-boot
>
> Before:
>   10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>   11 .bss          000068f8  00000000000f2200  00000000000f2200  001021d8  2**6
>                    ALLOC
>   12 .bss_end      00000000  00000000000f8af8  00000000000f8af8  00108af8  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>
> After:
>   10 .bss_start    00000000  00000000000bf990  00000000000bf990  001021e0  2**0
>                    CONTENTS
>   11 .bss          000068e8  00000000000bf990  00000000000bf990  001021e0  2**4
>                    CONTENTS
>   12 .bss_end      00000000  00000000000c6278  00000000000c6278  00108ac8  2**0
>                    CONTENTS
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> V2: Replicate arch/arm/cpu/u-boot.lds BSS part verbatim
> ---
>  arch/arm/cpu/armv8/u-boot.lds | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index fb6a30c922f..ebdc079552d 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -151,16 +151,18 @@ SECTIONS
>
>  	. = ALIGN(8);
>
> -	.bss_start : {
> +	.bss_start __rel_dyn_start (OVERLAY) : {
>  		KEEP(*(.__bss_start));
> +		__bss_base = .;
>  	}
>
> -	.bss : {
> +	.bss __bss_base (OVERLAY) : {
>  		*(.bss*)
>  		 . = ALIGN(8);
> +		 __bss_limit = .;
>  	}
>
> -	.bss_end : {
> +	.bss_end __bss_limit (OVERLAY) : {
>  		KEEP(*(.__bss_end));
>  	}
>
> --
> 2.43.0
>
