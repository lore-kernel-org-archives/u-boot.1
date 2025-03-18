Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40612C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 11:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92C6380107;
	Tue, 18 Mar 2025 12:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D2LweXNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F3280548; Tue, 18 Mar 2025 12:16:57 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74D7C800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 12:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e63c3a53a4cso4513814276.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742296614; x=1742901414; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2IrpOPMGZmZm5pEZzrIai4jKD8mMahizqMoIl2Qxcxs=;
 b=D2LweXNvoeyEhSeJy0YyshKI6U8Rrpf+Ht8c9qYXgaYI1S2BCnlprEx754rdO3U+at
 waPCQe97Ti2Qc6QVkWvkPbsjYn1HJmxxguWe1/GwhYHBeOvOOenyBgFPPsvbZqbmyItt
 GgrTgTWjVYn+LM0fS8/52mCYB3xABHDXHJhKmEOB8QKDHMeFC8wO3d/bb0EiDQaz34gn
 8BIho5xhNDY/oVtf5t2VOzAMJZlNQUGgQRHjCCQXEEMrhwYqCUPPdVeG2pILo4Foj4iA
 zrbVDPlU8FhfCz1z2bhjdA4G9IcyZaxCbTc3Q0XtTr7mZGV73Bl3cQLKIlP7NpcbKsoV
 0b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742296614; x=1742901414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2IrpOPMGZmZm5pEZzrIai4jKD8mMahizqMoIl2Qxcxs=;
 b=eJwkxZP5ELlCvNjZ1uIOeo+LFO8XK2AneO5DamkczfKPv/tWrirYSFirkvRrrT8ZXn
 1OLVGpW8t5U+3HuBAwp3+WfJuQa4zrpSGScnXqngCjirefSId4Ia0E52H0fU3W8opR7f
 WROWG/YxUrG9tGn21zFTDk41I4OimEBh94OpARO+5ZRLLh3UB0qg+2/g1gdkbbaNNTxS
 XpDy0yf7xBcYHBdQ4tCr5VwayKmaf6LSt6PlrTTasR+6PUqIKYug83L2slnTQUbWXnR1
 /38sNqRt2ROyfReHnEmNRNO9FjdDEC/hHxeg6xK4vL8yJhbbSKYCaGtN9RuvLuTq0V5B
 j6zg==
X-Gm-Message-State: AOJu0Yzylh9dRHDebyPkQ64ThwSTCxDxiZ67oREM/0uVTQ1Np65tMl94
 x+4gHBztcEMxHDsooFD8SUhx8orRHP65CRyO53XsdMumFE0BwNDjRrDvoQh3Uw6Xb1NRNIicJET
 qQoCPmjtMv0t/JSdXdURzYZj/tXqR2pXZ3TkBkg==
X-Gm-Gg: ASbGncsE3e0PI3dpNZurWuyHJcrUtMwmYx2S3v5mPGb8crk9fBi7D1OCVsAgV2558wl
 D7toyg9zxjTpWKQ8C3gz0mMAeLj8V1I7Rx4Xl3iMpdEbAS/pp7mUQy0b/J+Ukl6JGtZAGI0+zvh
 lIPIAckOwO1TlC+P7bfTwy94cF+07Qf+ObJAF8cA==
X-Google-Smtp-Source: AGHT+IFEreW/rz/tTC/AX6wV6LZRj5roSsr/dKosM2dp3USqMj8vYmfoqBL7/GEEeTsiSfn9U4sMfJFJQQ0S6bmBsJ8=
X-Received: by 2002:a05:6902:2013:b0:e5b:34cb:ebb2 with SMTP id
 3f1490d57ef6-e63f64f69fbmr21285769276.19.1742296614362; Tue, 18 Mar 2025
 04:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-9-jerome.forissier@linaro.org>
In-Reply-To: <20250318104659.1114340-9-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Mar 2025 13:16:18 +0200
X-Gm-Features: AQ5f1Jq0VNvb1OVQDP6ovzUQrRn1fTKL1WN_r4-Ij_w989vCHIFN0Hb8DJ7o-1k
Message-ID: <CAC_iWjKzZRVPSxBQ2b_4wqB1rvsvy-6GyopvwGtTh8YnycjYvA@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] lib: time: hook uthread_schedule() into udelay()
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

On Tue, 18 Mar 2025 at 12:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
> is enabled. This means that any uthread calling into udelay() may yield
> to uthread and be scheduled again later. There is no delay in the
> scheduling loop because tests have shown that such a delay can have a
> detrimental effect on the console (input drops characters).
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  lib/time.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/lib/time.c b/lib/time.c
> index d88edafb196..0e9b079f9cf 100644
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
> @@ -197,7 +198,13 @@ void udelay(unsigned long usec)
>         do {
>                 schedule();
>                 kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
> -               __udelay(kv);
> +               if (CONFIG_IS_ENABLED(UTHREAD)) {
> +                       ulong t0 = timer_get_us();
> +                       while (timer_get_us() - t0 < kv)
> +                               uthread_schedule();
> +               } else {
> +                       __udelay(kv);
> +               }
>                 usec -= kv;
>         } while(usec);
>  }
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
