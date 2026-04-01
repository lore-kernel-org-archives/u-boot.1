Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B17CD35144
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E7C84088;
	Wed,  1 Apr 2026 08:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="skv5w5dP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B977584088; Wed,  1 Apr 2026 08:55:02 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EE1D83F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-650152687c8so6682354d50.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 23:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775026499; cv=none;
 d=google.com; s=arc-20240605;
 b=cggF7QJiwnd9h67ns3cV91fChnkYTiFFonoq+r7fpxoFLV8F23bb5dME+47Bhbjfzr
 FVXP7SvUp95pqF8ItKlRUDirw1zMhACmjUoDOh1Wc9ga04/UOEUFtdnB1fJibqngvsjW
 9xsClaiagMGlmYM4BI48VR00MbbdhOl/V+9o4bpsTbM4YRC9OkRz9V2gT3IrORoRStez
 Se+xmDz++d8DNwD4zmbE1QXlEM+nOfqcat9bTK4hAa2HOMYQkFjZassOfbtUYiSBWiSo
 G/HxdVcqEuSkUhmy0UIxfVpHvxjXr3S5d8JC0ZfUb72khbglN4Tgt8K2Eqlq/jsuuijm
 Mppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g82abaO1wMfnRcne8vrdCxE0Mbgbo7B8o4B7Ddkojyw=;
 fh=2ibWQVyoTIcT5x7DRiI6oaZGaFtgcskYqk41ek10tN8=;
 b=k/qIY+UmPgPMdjswTa6faqd+2EUMCo1WWYYWcD2sg0YhyZGw4U6/pTKl22+B48YakS
 YaPSI6kO8/Np762sf58LXVg/WDHxCOYg422iULebWXaUKpR0gbatB+SauSzjIHeJRnz/
 /cqrU1kjICvkbVlGiKFGRTLvHYRsEA4dqSEUJ+4wuU8nkKae+VyvqY+vSMI7w56smaaQ
 AZjhHeEtSbjOSAB/UZnxr2qlYx1gNVdMgdKMArCsPk5d3pMYQyVUr+4xakptDqP9IOTq
 u/xLvsR3k39kvbUieHfY9qulOmWlzRFBMJMPqyNlThuv1P9OMgxJUARtZ6/YqbV0xMqA
 s+1Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775026499; x=1775631299; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g82abaO1wMfnRcne8vrdCxE0Mbgbo7B8o4B7Ddkojyw=;
 b=skv5w5dPWfl1Ej+oQLYUp6dsw+P+Xy1ggfmwW4Xj4Yv1a35ht6U7Qqw97e//euQai0
 4H+3rdr2D3hgtOR7ZRgoAuP5jvql4gV7VoShqghWgSqkHETht8wf9jcSl961qksVlCaI
 jIAYQ/OuZlZKlaXo9oo0Mt2K+IRnm0XX6R1QBEDgVw1GXpVKfR/Wk5n/PpMKhA2sep8r
 vd1H1x/2E/sFNpmDf1lUsEXpWbbpLpYl1Z/qs2VNfD3B246+RVs+YVKqAom94s1OnoIb
 nKCQkzfNTKeVbtxQT0HVcMGIlTK+hPuMcdBRqdA6fVWH19g4lyZQEVQ8woeBpr40HXFh
 vq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775026499; x=1775631299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g82abaO1wMfnRcne8vrdCxE0Mbgbo7B8o4B7Ddkojyw=;
 b=BRZ/c34bFYASuAZdtXYUwxE+uz6ktGvG/6IieapyPp2yKare20edXzEY13HocPxNf2
 z69waeEFwGqSfJnqZ+4d5u7rdhqoxr5L8m33lI8ZsCbuLcrgzSKS9Q2vOplgha90xXgR
 UeUCSlnOyB9Uc4ttMbqFLGGkgkihCfLH/kXTIcw9nZEGOtN4TcbFqjHijD1fz+ObJY9l
 VKca6+iOB1rCM6KjmKpBG/QT4ihcmVv1Z2hzK9dEMDmrCysM7fO1kZQ4NDqjaLZAkrRG
 fB0/Px3OAS3HZWM4TNBlXIPF5EhdVXcat4kVbySaxZCo09WzwOLmlVJFl8hgI4vGKOwj
 MAew==
X-Gm-Message-State: AOJu0Yx3YQYZp2r+8kZD2eysSe1+vekR4xJZfEgRJRDfomOwcIj0nfjw
 Mju1ZlVlle0Cr/mqVzRlHM4x28OHlmgpYNj7rsvP10y2RG7zRscxhlXTIuClhzEIi2yFNh4UP9j
 CSmbhh/e0RWlb5ClECd6EhgWv65Y/X+c9tQ55JMp6Eg==
X-Gm-Gg: ATEYQzzVqPADCQGHaCLgXaAmiJxYELSBEoqKMVkqt21wI04kYwWOyc4S64Zmkb7FTfv
 aEQilj58K2IV5kwxm+7gkzEEakGK33znjByP83BfcbNuRimLfCyfu4jtGnpf+BfxCAOUBnVyXlu
 sscI105uyqxY/C990sav2vMW5hn+tmuo7349fXVtGOrnugEVj/KWvfhS1ONf2oE0/harOeJevga
 MKQb9fuKSc6WiZ0ydDbX/CkvQmFUE4bORijv+KkpIUl/yPeDCeYlj/dfd0utRFu+EfaNm8IT7s1
 cJ5zhorQoHosBGNlyDk8lEsydgmYFH37WK193Rmo+VnzTOug70+xRTruH6a/1Ob/Me4gZ3ykuFX
 AClnsT+O/kAMxKPu0+Vn4aY4s+gKqy7MTbQ2+bSJFdbMVAf/WUpiRxlc7fYR4WUbQsYjWph1Csr
 ALRdQuwHQsVnH+HXZvvIYDTRd/G+HZSTvGV0yQJJDdEpFULg+jrYrwSkWqjXF4244F2cBcID0D5
 LO5obWmw/Cq+nCRbIXU5RcGgjcVJBTpUzT8QOHRVnpk04L0zG4EQwyM9Kodf9quTz8brkMdwWte
 qEMituTfCHL2TGC2aZk7nFnv0q6FVDc0rLV/WCfsiE3Y
X-Received: by 2002:a05:690e:1349:b0:650:8c3:8df2 with SMTP id
 956f58d0204a3-6502feb288cmr2524455d50.62.1775026499176; Tue, 31 Mar 2026
 23:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775023421.git.michal.simek@amd.com>
 <ae0079a2839dceef08f3324714d45fb48d5d7100.1775023421.git.michal.simek@amd.com>
In-Reply-To: <ae0079a2839dceef08f3324714d45fb48d5d7100.1775023421.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 09:54:23 +0300
X-Gm-Features: AQROBzDyf1j19USkuW4g0B2Ni8DZi1igTnoKUJwRUYcVE5wGttKJVW7tG0SbC5E
Message-ID: <CAC_iWjLnXfmS-Eg+MVg0UbeLA4mMj29t3zJ+eGn+5j1zCCUAxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] event: Introduce EVT_POST_PREBOOT event
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, sjg@chromium.org, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 1 Apr 2026 at 09:04, Michal Simek <michal.simek@amd.com> wrote:
>
> Add a new EVT_POST_PREBOOT event type which is fired in main_loop()
> after the preboot command has been executed.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
> Changes in v3:
> - add missing type_name extension
>
> Changes in v2:
> - check return value
>
>  common/event.c  | 3 +++
>  common/main.c   | 4 ++++
>  include/event.h | 9 +++++++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/common/event.c b/common/event.c
> index 8d7513eb10b6..398e713d2f82 100644
> --- a/common/event.c
> +++ b/common/event.c
> @@ -49,6 +49,9 @@ const char *const type_name[] = {
>         /* main loop events */
>         "main_loop",
>
> +       /* post preboot events */
> +       "post_preboot",
> +
>         /* livetree has been built */
>         "of_live_init",
>  };
> diff --git a/common/main.c b/common/main.c
> index b0b6e74f5d3d..4b4504557f6e 100644
> --- a/common/main.c
> +++ b/common/main.c
> @@ -19,6 +19,7 @@
>  #include <net.h>
>  #include <version_string.h>
>  #include <efi_loader.h>
> +#include <event.h>
>
>  static void run_preboot_environment_command(void)
>  {
> @@ -53,6 +54,9 @@ void main_loop(void)
>         if (IS_ENABLED(CONFIG_USE_PREBOOT))
>                 run_preboot_environment_command();
>
> +       if (event_notify_null(EVT_POST_PREBOOT))
> +               return;
> +
>         if (IS_ENABLED(CONFIG_UPDATE_TFTP))
>                 update_tftp(0UL, NULL, NULL);
>
> diff --git a/include/event.h b/include/event.h
> index 1d267f1d1054..3ce5f992b04e 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -153,6 +153,15 @@ enum event_t {
>          */
>         EVT_MAIN_LOOP,
>
> +       /**
> +        * @EVT_POST_PREBOOT:
> +        * This event is triggered in main_loop() after the preboot command
> +        * has run, so that devices initialised by preboot (e.g. USB, UFS)
> +        * are available to event handlers. Its parameter is NULL.
> +        * A non-zero return value causes the boot to fail.
> +        */
> +       EVT_POST_PREBOOT,
> +
>         /**
>          * @EVT_OF_LIVE_BUILT:
>          * This event is triggered immediately after the live device tree has been
> --
> 2.43.0
>
