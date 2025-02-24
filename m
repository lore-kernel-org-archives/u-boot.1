Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53168C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 07:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A81380079;
	Mon, 24 Feb 2025 08:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Gm8XDXIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE86280207; Mon, 24 Feb 2025 08:34:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83FC80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 08:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 204FB3F6B8
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 07:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740382454;
 bh=Y1WC8YXeRm0afhSOg9zWG3nqPHwrrMbOithDjD3UiZU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=Gm8XDXIztXTXzwowMu1yNC53/rYC1ewKEjtOmf40mhpz8gpqRn866sVjy+CvGt1GF
 d2xmZiShlCHbMM2DcJwg1slOva3CuxknqKkAu9Sljs3KFh+UrJK68GfMROtd9tHsy3
 Z5r981Z3BW7o9YRta/V53YT4R6jDxAd3NMeO8HNMnoZ5sFJnAWKsYHZNDTQBhTwnzX
 3Yij88n0LAAW6WI/jlWnO/2gLFZyxl3gfpW30WBTsqWE/xCHzW+nw7UrFLsbSS/7sP
 Nv9NQ99A5UyH5rDajf6vw50oWl//7MJhcE8QMoSF0hdOZHVzvejGKUl3QjhH+odX+g
 cbR3kLwGTJinQ==
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc46431885so13621768a91.2
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 23:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740382452; x=1740987252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y1WC8YXeRm0afhSOg9zWG3nqPHwrrMbOithDjD3UiZU=;
 b=X+aUZQw6rPNEylwKtX9buBykTLNq8iN5hlJzZqMNN9kEQ5pSpTQ5os/qwAHF5cGWMB
 xNoP3MHiWlI9qSXZi9fGyMMKoBY837vJGWCD7TNymoyEJmNLSr7jseOaLobC3AYIOjzy
 m7+0sUEdVPRorAxFBJF4Y7Avh04So31p5zsJQM0EMRlPfr4jzpOJzpKPPeXLkk432AEu
 CiCdV7Fg/cVMqa2c3y8prgebbAeb9QsWqsA/YeSadBZou/6oegjVkOQeZOFYoCVqfCqK
 xDdEobCD9SsLV+35lbTOLn0EREIZu3zgAelcn5QWuQmdACEr8B3jUYVRTIHy21K7yuYa
 Fgig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkhzseBCbJtlcjgfV1/vlITAI6rFHnRxEX2qcuXUWAraC9Od4Y2aaQ3EPLcyUWtv0WXkWBRGA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4iSyUaZjrR5kUYCRf7stAyvPFkgHmuynjqH7orY+LEDnnFym2
 50ltRA+ED4+iTK/5VCj8xwjkV/Fvf/kuuy6FUs4ZwJOwaiZ40Z/xkejjBQUDF8LNryOK04euKJw
 VolQELVRl6zYJWZ0wMzsg8KPQkuuifNh1ZRIVUg7cc2Qn12rODQMUs1+qjHnnYuAmly6ZoyJxJn
 JtUKlAVXINS4SvDgh49F/t/e0UmWAkBZ4VZF7X20R1ww==
X-Gm-Gg: ASbGncu28KP9RpH5TcQWn4aoZwPWs040kN/R7BwRhrANolIFHnst6+7tXUIgPxjTEdn
 LfvV/nt3CSp28mBuu+E++29ZFWhfCkVUHwINrjjwwCdQn9LEkA3dVoCXjKg7z67HYAne76g==
X-Received: by 2002:a17:90b:4f4e:b0:2f9:c56b:6ec8 with SMTP id
 98e67ed59e1d1-2fce86adf4emr21418408a91.10.1740382452576; 
 Sun, 23 Feb 2025 23:34:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8khNzV/PdNSO29nM1N7rAcCpP/YO3xEgQHQq1sDFnRzcLEZ5HiIAH3mnSQxvtMWPygSrtV4fOAJmX8z67QrU=
X-Received: by 2002:a17:90b:4f4e:b0:2f9:c56b:6ec8 with SMTP id
 98e67ed59e1d1-2fce86adf4emr21418369a91.10.1740382452205; Sun, 23 Feb 2025
 23:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-17-CFSworks@gmail.com>
In-Reply-To: <20250224055524.1334929-17-CFSworks@gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Mon, 24 Feb 2025 08:34:00 +0100
X-Gm-Features: AWEUYZlrlnDF-Z7Lq3fIJXMMIborBYQPQ5XHPPUBTTgaXCOyjTtmg4BBy64NZ74
Message-ID: <CAM=mAOkE6A9XnYxW4Y-n88H9rVDP4wkQVeMNqXuxot1i0hs0hA@mail.gmail.com>
Subject: Re: [PATCH 16/17] efi_loader: Move .dynamic out of .text in EFI
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Sam Edwards <cfsworks@gmail.com> schrieb am Mo., 24. Feb. 2025, 06:56:

> This was not proper: A .text section is SHT_PROGBITS, while the .dynamic
> section is SHT_DYNAMIC. Attempting to combine them like this creates a
> section type mismatch.
>
> It seems that while GNU ld does not complain, LLVM's lld considers this
> an error.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/elf_efi.ldsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
> index dc4d1a3660e..acf02eba4d6 100644
> --- a/lib/efi_loader/elf_efi.ldsi
> +++ b/lib/efi_loader/elf_efi.ldsi
> @@ -20,10 +20,10 @@ SECTIONS
>                 *(.gnu.linkonce.t.*)
>                 *(.srodata)
>                 *(.rodata*)
> -               . = ALIGN(16);
> -               *(.dynamic);
> -               . = ALIGN(512);
>         }
> +       . = ALIGN(16);
> +       .dynamic : { *(.dynamic) }
>

.dynamic is related to dynamic linking of libraries.

Under which circumstances would we have content in .dynamic? Why would it
be needed for executing an EFI application?

Best regards

Heinrich


+       . = ALIGN(512);
>         .rela.dyn : { *(.rela.dyn) }
>         .rela.plt : { *(.rela.plt) }
>         .rela.got : { *(.rela.got) }
> --
> 2.45.2
>
>
