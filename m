Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F065FC021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 09:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03334801CF;
	Wed, 26 Feb 2025 10:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nw2+wG/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED77801DE; Wed, 26 Feb 2025 10:52:32 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3158004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6efe4e3d698so60450577b3.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 01:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740563548; x=1741168348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lpI+TwTVw2HZybuMeFN1IcXa8dcd1HBuyxxfb2WdWbc=;
 b=Nw2+wG/H3BmtmNFIhcxqMwg2EIMT6PFtx2DYkRhf+e2qIzRuNgPGS7TFXvSKDN+Izk
 aKV2bNwPJhEVnc1X9puQbfEX2cTQrCUNmT7znVJDGN/JFumysTGv5BIfIM3iTeW8/+6v
 ejgA+dtpuHzLXH28ais6zZL6rM6AVNa+F5uuvS5MAapvQVOOiRbP/K708Y7YA2v422Kc
 J4kphG/w3aYwt9OMIQ4ge4vm9ezR2UsdToeSpuwIXTvUj+RuNfAAMrynQGE26cNhj1x2
 /gDD7j+/K0DbjyDOZpO2ZnX+1V5K1WBxEk6NhYPcOE3OkAY6sVsuTv36hEeY3pJqbyYM
 phVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740563548; x=1741168348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpI+TwTVw2HZybuMeFN1IcXa8dcd1HBuyxxfb2WdWbc=;
 b=PERJeRiAFt/PXbVGF1apuReX2l95qOHIVbRZFjfrBJx6cc7zjlpumw5jEXOlu0w2hG
 L0qpihL9Je87iCMnADNT6dre1iOzRMUN680zNDc5qqOiwB9sIqwKlz2BRE3TpJ3DshVu
 bkmeNmpEJccAxO8ofE3yDjodGMXF+UYQsE8QQBTi+hPNnIS2Ca7gCQTK8/NjRTWV/e3D
 xtits/rP+mBXvudxak+35DaEOJsRHCjsf8tUx19gW7Xqi5lv4nKdi6UbX4maB+SUAVbi
 OCbdG6SXtt8LwP6D3sdGYoGCglJEjdaUzFKA1vnoJcSYEM/xtHe9y15ISoqsbgrpDUp/
 LfnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIcY4EwL0WvmsbaIV6mpnMi9iBlBbbzYjZwS0KK022Go3YL4JPNclK0cZyoiAWaoPfcUlJ7Ks=@lists.denx.de
X-Gm-Message-State: AOJu0YznIVvQxUIdRTnrYuYI7w1PKJV7XuFOQQ/bgzzNN9u+zmYkwrve
 /AAtrRwS1oPP7mvlu8/MfAfGecVFqUZbfKD+juR1oFoVWPZE4ffu3X+ImzTucdFvXcyxi96kL3X
 dLNCc/+dTMgmHDpYetmNrGjumCoJbaHi7eB9zBQ==
X-Gm-Gg: ASbGncv3GrxoSTLaDOa1tHQs5k0u3uC3JMZq+zDgG2zt+45BEvLV9QBgVxG45E7NtVc
 oNxzbnOmQqDQAtSnZFbS52WfaASRvwm9P+fE0tOo0o8kmf5L/1/PBHRpL9oE4CRF1HF+0++zPB0
 pFCHszXOmC
X-Google-Smtp-Source: AGHT+IG1a8I9BgK/t6SVX33nl33FPctnR0HqCpNVrdTjUTisUZzHtpLZ/TThpBVzlIg8/qTSYB5UpXRtMAX2vJAMPB0=
X-Received: by 2002:a05:6902:10cb:b0:e60:5d76:f7a8 with SMTP id
 3f1490d57ef6-e608a7e3daamr2245247276.43.1740563548655; Wed, 26 Feb 2025
 01:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-15-CFSworks@gmail.com>
In-Reply-To: <20250224055524.1334929-15-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Feb 2025 11:51:52 +0200
X-Gm-Features: AWEUYZm-EsdB5g6vh6w3zbnD8lI_OyOFbYfeSnNnQ8-uqs2dzK9KnVoHI5dwvg0
Message-ID: <CAC_iWjKWxp=cXO7LshEAP4BsZHMLt1LyBq0hW76GJWMnfv7hqA@mail.gmail.com>
Subject: Re: [PATCH 14/17] makefile: Add READELF command variable
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 07:56, Sam Edwards <cfsworks@gmail.com> wrote:
>
> This allows setting READELF=llvm-readelf in order to use the LLVM
> version of the readelf utility. It also aligns with the practice of not
> using $(CROSS_COMPILE) in any build recipes directly, reducing the
> number of places where $(CROSS_COMPILE) is used.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c869b5c55fa..c1749e78d6f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -406,6 +406,7 @@ LDR         = $(CROSS_COMPILE)ldr
>  STRIP          = $(CROSS_COMPILE)strip
>  OBJCOPY                = $(CROSS_COMPILE)objcopy
>  OBJDUMP                = $(CROSS_COMPILE)objdump
> +READELF                = $(CROSS_COMPILE)readelf
>  LEX            = flex
>  YACC           = bison
>  AWK            = awk
> @@ -2177,7 +2178,7 @@ System.map:       u-boot
>  # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
>  # R_AARCH64_RELATIVE (64-bit).
>  checkarmreloc: u-boot
> -       @RELOC="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
> +       @RELOC="`$(READELF) -r -W $< | cut -d ' ' -f 4 | \
>                 grep R_A | sort -u`"; \
>         if test "$$RELOC" != "R_ARM_RELATIVE" -a \
>                  "$$RELOC" != "R_AARCH64_RELATIVE"; then \
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
