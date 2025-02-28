Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AC8C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B5E5810F6;
	Fri, 28 Feb 2025 14:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="licDkUBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737DB80FF2; Fri, 28 Feb 2025 14:39:03 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1811C809D4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e5dc299deb4so1840876276.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740749940; x=1741354740; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LhR1xu2nRPMg9ua1m8+3hxjl94LENe0aGZ60D7Zej9U=;
 b=licDkUBATgpWlrv2Yxo0tfoN9NnTvDzyLA8YeOLmjhdskSJiDMACfB9NpDFj0G/7QB
 PzbrZs+G3jKRSpqkiLk9g3ieC1ibKBpBhoEzC27a/rSCDgYH0C8pd9imnsxNoAMA+7YA
 Yo1alFeVT2ytFH8GJqwzlZHFoNJUFLFJyta8j+ScoWSOea47j7UDYGugAja51PiL+pQx
 5KzmILBXffm5P2bNYwbpg5FaqphCQAxcCxvZceRMoAjn1rHGUyaNItUr2EgJcRkGe/Z4
 FT2O0ZndS1u9kk0ZQ12i/KAMwNU/wtJ87lhV7qGuLJLH25bNj4r8IvZDXG4W2d0VZPn7
 eYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740749940; x=1741354740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhR1xu2nRPMg9ua1m8+3hxjl94LENe0aGZ60D7Zej9U=;
 b=N0AGIkIsrYR0CQ+iUjAWuaioBpmgh+WqxMmO4a5FkX2pKeNKw+hZPqirdIwb5NZ+ci
 gu2g15U8GFBEf1ZbwN53fiqk+T8VomKqhlLB7LW6qPzKX1GwvLxiG6Ovbx/5eNO46t98
 hfZOQRyKgzst8v9mSjqptvvOMI9D/aAXNtlA6p2mv/RjhDmkc7YFqBCTQC/on9bQxXxW
 BF3ENB1DpNZ01rSmdnwzN1NWL7fCDd0q8QQ02Rpb6Idas59vfDxg3VYHO+l38kq6C3Di
 /2OIOVj/p+d56NENNLai0XnICV4rQp9YhGASt6wDn69EGzyoB0bHQal3RyRCjK5vN5j4
 TY0A==
X-Gm-Message-State: AOJu0YygwYRgI+bQdtb+rqoixG9PBL7pc4TTclV5/lab360BAiJs/a71
 CRkLvfZvxVwCE6d9hXAK71CDNrBgAsgV9Cc11lnEVrEffPk9wJgRNYmXjzjsaKRWDaBXus9iItf
 Y0kTS8ohTl9npTXvjSsM3ULCsEEll3XqI0uaj1A==
X-Gm-Gg: ASbGnct++rvaN0CgC1LSYmr9a36it6CsSoH96zZyLcvt3+lBRag/XBihBhUshm7UUld
 kD9q4ai4mCPcHsPdjTSIMCCA4Od1t3pe+SCeH18DkUhswk745LrlJ3/WStpp3jYsY5WQNhBBgds
 u5tLV8RC/Cl+mz8ozT7XUz1Iwr91KCo4ttr9xCUnI=
X-Google-Smtp-Source: AGHT+IGqJgOuHkkYHEM2aycpxhLkbDNdx34zXnH43jyOQPNPJcBEyQFjS5NYmxhVg3m3PRgrKHYKABjL6gTvHB9ibsk=
X-Received: by 2002:a05:6902:2310:b0:e5e:2428:fa56 with SMTP id
 3f1490d57ef6-e60b2f78181mr3457213276.41.1740749939885; Fri, 28 Feb 2025
 05:38:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <f9568a6c5140b99cbd5b48de21f4d5b12a76d92e.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <f9568a6c5140b99cbd5b48de21f4d5b12a76d92e.1740499185.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 15:38:22 +0200
X-Gm-Features: AQ5f1JqaS5WAah_rLQPQY-7oLQHUHZ3H7DQU_VEeAvDPnmyzw6vGLAfzni-SGOU
Message-ID: <CAC_iWjLtTzCAqR_aq6Q1kBEn=E3oQoCDuvxWAnfrT6R=KCgSeQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] lib: time: hook uthread_schedule() into udelay()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Jerome,

On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
> is enabled. This means that any uthread calling into udelay() may yield
> to uthread and be scheduled again later.
>
> While not strictly necessary since uthread_schedule() is already called
> by schedule(),
> tests show that it is desirable to call it in a tight
> loop instead of calling __usleep(). It gives more opportunities for
> other threads to make progress and results in better performances.

Some examples of timing gains would be nice.

>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  lib/time.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/lib/time.c b/lib/time.c
> index d88edafb196..d1a1a66f301 100644
> --- a/lib/time.c
> +++ b/lib/time.c
> @@ -17,6 +17,7 @@
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <linux/delay.h>
> +#include <uthread.h>
>
>  #ifndef CFG_WD_PERIOD
>  # define CFG_WD_PERIOD (10 * 1000 * 1000)      /* 10 seconds default */
> @@ -197,7 +198,14 @@ void udelay(unsigned long usec)
>         do {
>                 schedule();
>                 kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
> -               __udelay(kv);
> +               if (CONFIG_IS_ENABLED(UTHREAD)) {
> +                       ulong t0 = timer_get_us();
> +                       while (timer_get_us() < t0 + kv)

Do we make progress by constantly scheduling new tasks? Perhaps we
should at least leave the task running for some time?

Thanks
/Ilias

> +                               uthread_schedule();
> +               } else {
> +                       __udelay(kv);
> +               }
>                 usec -= kv;
>         } while(usec);
> +
>  }
> --
> 2.43.0
>
