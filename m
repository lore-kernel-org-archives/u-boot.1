Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127F7C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 20:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7241388763;
	Wed,  1 May 2024 22:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cTL+uaTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0F888774; Wed,  1 May 2024 22:26:04 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49EA88592
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 22:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-572af0b12b8so803570a12.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714595162; x=1715199962; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuFWY9kNszPdVsnbv0a2hs6PN49/2CXfFH3b/4pQN8Y=;
 b=cTL+uaTqy5QVZmORztO/hWnF21dEYYOY6Ak6084p+2v7Xq0PpMg1tQi0iITT66FRjR
 lAYfJVq7k5kzViG/avvAsrhE6Nh7u/4wKday2Dp9MfgodYzU73nL/yzA+0GB2qKV0p1j
 sXYS320YYh0UE4AmiSuFo7aIlEQSWd18xbgO7jEMs0r4a0VwuZNQVABfuRe5LQ8c8DJ2
 h4Pm9E1nCSMmQTvmiGlnZmkKqp1osSvvENBN2qPDM4Q4GIyCifUpOou/pIcUVzLB/KaE
 WKCXSjsHMbcOWW5NS9nYOL3ZURsx/cr2Z63dnmrgUsf83R/Re1aYMUeAFuOC3hOFlul9
 yK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714595162; x=1715199962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MuFWY9kNszPdVsnbv0a2hs6PN49/2CXfFH3b/4pQN8Y=;
 b=sJNgBVdKBohAP++mHUC8WRpvkceJf7EJFfvprJv5ix5x90romZOPU48xmdQq9a2RB1
 LlTkYPThRNrYif6ovGEiYJlz5z+709O+SW7yECpV9D/fxuwMedJThFOIG0xocPYSeCmB
 VKYTwvSf/DxAfYv6O75dBcGzNq8rsN+ZMHKvswevIY9QNefIFg0WSUyIiAREBUsgo/qp
 DnJP1rzGiAAjYb0MoMahrMe6PM894/XITgQiag79Cg5YaMBjqgMQ1mavJZo4o9TeUTVQ
 5GLZiwsezG2iF8ztJLT94KjEkLOSAPCSbvYG38l9IKwetaZ/pa77ephDbd5OWABaocop
 +wqQ==
X-Gm-Message-State: AOJu0Yy5DHS7Lpli1SaNgGT4iK+Y83acOh8LSz8nm3w+DuZPOYICzZ7I
 ml6kVndLA4dWz9jwTCDKL6FIeBW1IepnoWaAnDXqQkYS6ggUF6dPijFQsELsfUYsmYQ7/t/zoZz
 LB1nsL4M9tmPRMpxUe5cykr0wFZE=
X-Google-Smtp-Source: AGHT+IECGbriAeyU92ErvJyD2BcIjMYbUNWYHYBCTQr6I3Z6PyaaM+fpRBTx2E6B+ffU1kXFHDHBlA9WUhikFx4m1LE=
X-Received: by 2002:a50:d741:0:b0:570:1ea8:c50a with SMTP id
 i1-20020a50d741000000b005701ea8c50amr2649555edj.6.1714595161944; Wed, 01 May
 2024 13:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-75-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-75-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 1 May 2024 13:25:46 -0700
Message-ID: <CAJaLiFwVB98+i73t_eWTb=iUy+vmghcf7CpWWRQZ7AVQC16McA@mail.gmail.com>
Subject: Re: [PATCH 075/149] board: iomega: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Luka Perkov <luka@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 30, 2024 at 7:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tony Dinh <mibodhi@gmail.com>
> Cc: Luka Perkov <luka@openwrt.org>

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

> ---
>  board/iomega/iconnect/iconnect.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/board/iomega/iconnect/iconnect.c b/board/iomega/iconnect/ico=
nnect.c
> index 038716020019..00b08987e9e8 100644
> --- a/board/iomega/iconnect/iconnect.c
> +++ b/board/iomega/iconnect/iconnect.c
> @@ -6,7 +6,6 @@
>   * Luka Perkov <luka@openwrt.org>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <netdev.h>
>  #include <asm/arch/cpu.h>
> --
> 2.34.1
>
