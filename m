Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AA5C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA038310F;
	Fri, 23 May 2025 15:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBMxPayy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC53583249; Fri, 23 May 2025 15:19:21 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F852830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so1653888766b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006359; x=1748611159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tCE09mlgrZknXOtMCUah7/rjptLI1BRqLtOhyDizAos=;
 b=SBMxPayytHWJAhCtA/7KjjebRu9j9QrbKiqjGRg8dhYJuoQqFjvVr5fOfA7l6pvUVO
 s5XQdBm0zi7rOyVam7Onqldd+CAj+nrxwvZVwBlQRh3HuRF9PU9dTqjgEfqI+fblJ2zW
 hMU9sY/AjtyOIDLw1AsZStYY1S5fGJRTkXsLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006359; x=1748611159;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tCE09mlgrZknXOtMCUah7/rjptLI1BRqLtOhyDizAos=;
 b=rqZEJ4ji6A+4ezsbZNhH6JvueQp8sg6mB0vtXFm37MeLyKuam80euBk5MPClLeYlfu
 mbbB/4wL+djISeVBPZU+bPKamFi0EayjrB0XboAyLjYnLrNxvv2cu2DIVxlzCio6jV5v
 mfuI+b47lbmbZf/CdBevH7qADEjU7xezcrOrwKiuSqRuO6ajLVo1aaoFvGudcRU1Imyr
 sNjK3bIOGQYMmiqs6FutsEcMeLtwMvCj4Cqi9BOK3JqEe9HBpih3G8McoX9L2C3mP/eF
 2KM21HKqxDgquoOO7T6AVxcES1IJUyRoDVERjJvSs5gtbD0uZeucEfhHO51navM685xH
 /hHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsbQn9Bg1KFaGPR0Dgy3EMnYmBHoyvrdSa8r9JUL2LbOwLHlhdlx287u+rfK6k5cPC/GuFY4w=@lists.denx.de
X-Gm-Message-State: AOJu0Yz99E/FU7XlEVf9kHIhfr2TT/fBCkN0Tsd3hE1z1FdA81Ni1DJN
 jogbtQ7lTONZTAPePyW3VlCUuQhEwK9SrzEUwrbvL0P3zfGjB5dfsWCNF6BMzg9dch5e0u32VBH
 xkjg3Ik1Uc/Rnat9zlY7M+CTzJBRTqOYYGwH6p/wh
X-Gm-Gg: ASbGncu6rlyRjHlskhI9FuiK7Ue+HJc05tr4imWVyAR1+bvydbLvTymEodWiYK8azSG
 DPxJtpxOtkillbYAfaBYPFooC2B3s7oeQH8payO2NEfm1t09MwFo12Gyjj0UgnXPPYMbErbHTRi
 sBclald9eCaFmj1LHzc6lbbWHa2GbxK5Yyael2gn/kejaP
X-Google-Smtp-Source: AGHT+IHfz11F4rNWAYYl0t968dnfTS0Wzmee75EPU6WfmOQ74EeNwRuw+63taFKymb2QhcEs/hJZjrzU2ACw0oXpYTg=
X-Received: by 2002:a17:907:8e97:b0:ad4:d335:d35d with SMTP id
 a640c23a62f3a-ad52d45ae47mr2765726566b.4.1748006359452; Fri, 23 May 2025
 06:19:19 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:17 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:17 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-7-sjg@chromium.org>
References: <20250504132356.2317305-7-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:17 -0500
X-Google-Sender-Auth: ggkz4G340xY5DNbNy2IPF_LoZnI
X-Gm-Features: AX0GCFtKO_ecx2SZhXOlJbiAvWJUI3d_x33uqmDDD7iwTSUmfa4NtE-oKfGzsX8
Message-ID: <CAFLszTh-ay3O-kj3FaV1sqibBcuixa9rsSDE9RX0YK7efeDsGA@mail.gmail.com>
Subject: Re: [PATCH v2 06/30] u_boot_pylib: Add a pager
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

It is useful to have a pager when outputting a lot of text. Add support
for this in the terminal library, making use of a context manager.

Also add a function to indicate whether the output device is a terminal
or not, while we are here, to avoid duplicating this code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/terminal.py | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

Applied to sjg/master, thanks!
