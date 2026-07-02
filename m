Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA5FC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2EF584CC1;
	Thu,  2 Jul 2026 10:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g8dFNEd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD4C84CC3; Thu,  2 Jul 2026 10:30:19 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D39F846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6986578d8c0so2640921a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:30:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981017; cv=none;
 d=google.com; s=arc-20260327;
 b=KSZZFSNLn/PxvOhnk0qZzknpkthmumqPbmez2SCqZcDcc6E1A4jaoBU5MRFe1qARTI
 q9JoHdm1YCmDm2tG7qIqftGqbVaL1l1kz5EzgzRHC2bxUp+hsW4l2D9dCSnkhlCld1LO
 V8o1B/7l+BJuuq5vITbTqSLR94SPtgF+P+fCbAbvfaXmUIckgBR86M6jnVVtRRyZljij
 +hg+P+zkyM+MNzgHAiluH3T3GZc0zgRCBCZiQ/bGZXGM02bwI9+fTtKg2+GpTnzOGyAG
 I03ER0rikEYYv1BKIDlfn2SjZnoz3BAAC4dgFSoFWcpUb32Gx6xz6JDTIpoaYO4b6XXO
 r6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aN160ae7WBQ1Ni44gd/zQw1tvqqi8a34/XUta7WCANU=;
 fh=MhAo4QPuXEC/Rh971JORz4rq3nvFSJ8p5JStjvc7R4U=;
 b=NZBI/wkxEZLI8UuXno0J1rOzq+Je6IqDRoI5ssV77WNLyzLd7rtrY5bKpYn33APCy0
 h5TrYnit+iI41GrQw5f1adju4aOcjdKaimrx87f0mCOpwcu4wPu/auoFg9RxQhR+uzV8
 8ATmeVerPHTM0ipV5NzTA9hTTNC2LDSx8BABqozXrhWxDpqD5ww+urQLxY4kvb0OBKQn
 /CM0S4F5yMktPuWrUHfXHSVvwsph76U2rHSoEt8cNzVYNRstzU9nRVO3N3VLYrg7qMA2
 pdMFhlMLe9Y44p3CudGM8t3fQYyNMKq2cggZP58Gf6dloNqG3Zq4dAHBdL+bLQi3ccIe
 ncCw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981017; x=1783585817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aN160ae7WBQ1Ni44gd/zQw1tvqqi8a34/XUta7WCANU=;
 b=g8dFNEd7hbFr0XJWtIWbO7L9ylBS+2I/w1uf6v6f8d+mSXtKEijC/cqwkXpf5TqUSv
 pWNUt1277LUaixj6k7sYuxl7U3DhZ4RSM1J34GZbpogJ/GtM2BzDSNl7MXI04vn6RAo/
 +MCz4bHm6tg1GRaAfrGzR6CPyj8Ris3qlu4d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981017; x=1783585817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aN160ae7WBQ1Ni44gd/zQw1tvqqi8a34/XUta7WCANU=;
 b=l1c80lK1cLzurD/hRf9bAyrxXZ2Zkq3p4Tyq23kaFG0O7fznFMlS5g4WofbP10vREc
 9JSH1ejidAum3Jai4sxQoGg9gEf20sPWnDjjsdYs3qszqGE36XhMCjjx+/cp0nmpPXe8
 Tvvv/l3IblYWq2v+z51i48mCYNLRJKPhFHoMVFjmHZ909Gym2/59aCQSuAw80rBXVT1I
 erLBuAELG6uN+ZIwUr4Ohf5i4PgCLMep3SKwvyK+rYxJcoBw9d4HJTBriYqJmPx/LWrp
 mvpBvMEHZZtAm5VcqNXeToMo5exOtYo8NMw+c+bL/c9qTt2/PMJpNAt01FqwunSJlbNs
 Magw==
X-Gm-Message-State: AOJu0YzNMX2UwIQZ+7GFOZUVY0+UTwrFcLmGiO0d0GUqDWnWn/0JhPmG
 6kbAF9+2bsk+qpIvB72NZ6Z6s2B3yXwkEaewNvZJbAmDB97/nAj6GE8h/SLGlmBpU3LepCWrdNR
 anpsbgMMOR0yZLw/rMapM6AOg4Re9MXl0fBen8AtN
X-Gm-Gg: AfdE7cmHgzSGDVbQTREpdFqbx8odgpAQ/BuoU1tF/UGOi1fun5lVklz4ZduVQUL4EUo
 1KziTG1XAq/QHfSqOTPddOs7X/RpDemOF1Ou41BlJ4ILA0UWemXOSafeZkXdVRtrJ8BH6YujPGL
 sdKtDzaPmAvPNRJEm5imv74z2IV/Lf/8zgqQUl/cEG57yf1FZWg9lw5yEST6ynzTyvCol+gWQ6x
 my6pGWj2RSpjgkSQ7dYV2R8XYIjXnn4xuChZwhHbjpBKXtBjaE+bDzRm2LgaBFQSzq7pUg+dw==
X-Received: by 2002:a05:6402:5484:b0:698:52b4:c2c9 with SMTP id
 4fb4d7f45d1cf-6989f35a418mr2298550a12.31.1782981016562; Thu, 02 Jul 2026
 01:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-2-rv@rasmusvillemoes.dk>
In-Reply-To: <20260701171535.906272-2-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:29:58 +0100
X-Gm-Features: AVVi8CcUrj9pmhlFYAHMiNXZZZvOLgBT92JfE8QI7hwmHeglCHf3KnFuNII7nUg
Message-ID: <CAFLszTh6N34zAf8_UvnJz47L6cugQcb9bdvUj6P+1NtMVHtdWw@mail.gmail.com>
Subject: Re: [PATCH 1/8] sh: clean up asm/string.h
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
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

On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> sh: clean up asm/string.h
>
> First, remove the !__KERNEL__ block, since U-Boot is always compiled
> with -D__KERNEL__.
>
> Second, remove the mention of the non-existing file
> arch/sh/lib/strcasecmp.c and the redundant declaration of strcasecmp()
> If sh did have a strcasecmp.c file, presumably the header would have
> had to #define __HAVE_ARCH_STRCASECMP.
>
> Third, remove the explicit #undefs of various __HAVE_ARCH_* and
> redundant declarations of standard functions, which are anyway
> declared in linux/string.h. In the linux source tree, those are all
> #defines, and indeed linux does have asm implementations of those functions.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> arch/sh/include/asm/string.h | 51 --------------------------------------------
>  1 file changed, 51 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
