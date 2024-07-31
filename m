Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD58C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E067F88A7B;
	Wed, 31 Jul 2024 16:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HRfvOh5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2BB88955; Wed, 31 Jul 2024 16:39:46 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9EA888A10
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b797fb1c4aso39558166d6.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436783; x=1723041583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5rskcoWI6sLfQLKMGbsU0b55RFV0+/1ucF2fEdd2Xu0=;
 b=HRfvOh5tRql+7H6NxWS7BmezV36S0c+XMT3u913BdtQA+fhKFAgt6+NN2D+Knj83Nl
 cl2h1PvfvFmFE/diiC0bUp/6ClCoTmemdMjLzwTzKRQLW/vpUdiWX5yLoFD/E6Zzzz7h
 wVnNzsagDp1RPrugSLB14ZUEQqqRcujSSVxF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436783; x=1723041583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rskcoWI6sLfQLKMGbsU0b55RFV0+/1ucF2fEdd2Xu0=;
 b=mMHWQ8eaYBdEKP9D9gyziXctJCtKcG3W8bYRfHPHOyoVJRXPT8tHqm3ivRInpxnRVq
 Rcjl86Xi1Yn1tzvkz0salCmc00CCig1P4rN242Awy+NcUf3UDQScQTevJMcZ81egYtMt
 31HjXcvKOA7me+aTAvPs4pFS+G4ayDLG1mgsGrNzkdFgMZ7T6dgH1o1T/pFfbrlZ/vGj
 Ab0yXb7uttK6M8vEzDKeIM3vgTbBSX2z3DdV7Zcr9XkqlU9Z/KBpZ7VUl9KCqjH5H0z6
 LcciCBQwvOoIMbcc47Y6x8aLakoIU0iIqgSBUfMm105BNMKKF8BBhT2RBg1MGzKDsyKj
 In/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8u11IkbDuReKPx4anthsXu+WewlpcpJO/j5JP0VtAb1fwfLe89+p5vK7FTFa6Q/8kdYibx6lbjR7s3ljJXLO08U0rtg==
X-Gm-Message-State: AOJu0YzvqUTHH3ktt6F1TUx3HKBZgRZcd3Xj0iSwU4s1RyfjZ1ix0ez7
 E9oqOOoqv+j5MJ/0G3gihnTay1ARgFWcYD+6zEyEanjxeVA1pt00pTDNbfoKVrLdbImTQd767u4
 Wys39IPEvSA3QvudSYccXFi3hkmupMhM3aMyg
X-Google-Smtp-Source: AGHT+IEAxh7tstlWQzV0FTNFLn4g5Wx7KHp+JIb//U4delZhmJY0AfFSvVrvHi4xjk7asTTADJfr4P/acuk5GOvxu28=
X-Received: by 2002:a05:6214:1943:b0:6b7:9401:bb7d with SMTP id
 6a1803df08f44-6bb55ab9ea9mr223756306d6.37.1722436783581; Wed, 31 Jul 2024
 07:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240731132233.45744-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240731132233.45744-1-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:39:33 -0600
Message-ID: <CAFLszTg_yz0mBxMAu2O-iK=E=Ov6=B07=BcJWg-SjzKFKzvEDQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: led: fix led command usage for the LED_SW_BLINK
 enabled case
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 31 Jul 2024 at 07:22, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>

(please add commit message here)

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/led.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

With that:

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/cmd/led.c b/cmd/led.c
> index 2f786f34c67..91fb856ee59 100644
> --- a/cmd/led.c
> +++ b/cmd/led.c
> @@ -118,7 +118,7 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         return 0;
>  }
>
> -#ifdef CONFIG_LED_BLINK
> +#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
>  #define BLINK "|blink [blink-freq in ms]"
>  #else
>  #define BLINK ""
> --
> 2.39.2
>
