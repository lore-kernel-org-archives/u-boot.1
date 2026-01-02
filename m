Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2986AEEB57A
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 07:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3002A83A94;
	Fri,  2 Jan 2026 08:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IxnAVKyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE58A83AED; Fri,  2 Jan 2026 08:13:32 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F8683A8E
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 08:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fb7ab7562so86516727b3.2
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 23:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767338008; x=1767942808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o1/7uDKtJLnQgjAhnT1H6yhTTnmAEB62Rc3k+HWa0Nw=;
 b=IxnAVKyI0X2tC9dvxkrIikzUt2bQ417T743a4vgVW7kdGibOIVFXfnpZu3NnHpu8+3
 4nnWWzHd8UyhzLbz0jWSyzTkmlvW2Ctn3dofON84oVcv0hRAXJ130LeqZ+xsunzwwn9B
 /ldHK4QjpE1I0N2ajCfGd7PL07H37u/XJ01/b5p1QKR8nKSeTrT4pDFK7qPjKzXyA92e
 kFHH4D8C7WvPL1GKPtP9tNXO0v4i0AVMpOxqMtA04FOHDhlqUb4CPW7HLbi/EFvZ2/SQ
 Dy0T3HcxmXvkgqlN0Eilxzt8Elj/xcDaphnTAvXM3ZGbt133e+XnnZQo86QjL/zjsEcL
 V4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767338008; x=1767942808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1/7uDKtJLnQgjAhnT1H6yhTTnmAEB62Rc3k+HWa0Nw=;
 b=ndc39oXjpJcDFgJaJ50Q5pLDd4PP9B0qK6hs5zTSMvifk1PtLFUg17sXpYlb9oshFj
 iq3lQEhyOnMhcAgcd1HrHkgtTYJARZ+apmLiMqlJOc9CbYbm2gA5RhZ+oOT3xL/sWBzD
 woLPd3PaQWbV05/nv9WNEenGPVQHU3dzcJiOzvFnCQETtqfD8oekU9Q6Ck+OGgo4aiZT
 9KaY+5IlB+kRG+7AvcpmMUNCiXpFPFvg8gHlXLrgo4dkpXB1P0HctvoCNGTIHpRcUhg5
 JF8I0tQxxgwcdpjKbiGdVBlPnB2x9JSW2me+HavdLXUH5g/jQ83gSCg/f/jq5tRdOdda
 ylXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP61ILJSyaF9NNhnAVMcv13RS5Jape3Lf+S3f6U6ZyMHrmNGyKuRsBihdLihYimV3VF3IOXM4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0nujmKH0pT1vGvIohqZL9ZkBHY900d8PDFHtXMwReFct0JBb/
 Yh587CZ04UvqD/T6COgFgaRXxqOEd+qLi1sifm+E3DNzdSQrJ0YHTqaQpRAQ+p6ckTD8VGh+B+B
 8kJ0GT3nKZHIqV36L7xnbptvJyprSebuNgGwnfieOEg==
X-Gm-Gg: AY/fxX7jwRGO6mKTcArfRh6RlAJSe9wTAQznzD8qPSE+AxzrW+25mYCWPSKHi9f20lD
 aEXH+VoDVqi6y4gEmTvsry5pwNEdEFIh2m4Vivc093yO7oG2l0uMB9RQJxv+nTgB0ZV26XJ+SPb
 IiplzQfXxQVHDJwwo2FPvECFOOKnBs/uUNwk2EDBXMkKg+U737lcMHoxdw7nwNdjieqt/Q1NXv4
 nZrrAG0bpWOdU93ue3Hd8KxDpCEupnwWcs9F5gAgeo0HkJZ/XVAunLOPBvKt1JEi/t4oNxGy3JY
 H9GLnKRshR9gPdo/lyeM1sFV07b78kucj6FBEIexlTR2/wAvg94h/DxcrXmFkOoCZe5we0yKsEZ
 HRxncqRhng5WNPnc23xuJ++N1Pfeh2bOAhDOCLeQgi+JONmBYjKvmPWL0OCj8WOqjRgIFuwJswz
 0fmvrHqHPx/IfJSQK+sDBl6+cWeWpuz0DAXhmZwi0Q3WcDLd7hKEbndU+5Rdg/SsXq+v8MyB8K9
 Wk6EMQVdoViP57fKxtCG5PDq8QvWoSpcOWLHeS71AsjtA87dmIbvypMKiLHBi+AfPIvc4OhF3mW
 3rROLg6T1o2uaEMd9nuk94gwM4zUSw8=
X-Google-Smtp-Source: AGHT+IHDGqjLAOTdo5SUeu2a7iCrhrMPpoalKhYAyi3X3ZnsAFcnGhVdHIR+iCC/wizm05gBAfCrPYe9L+q6/a24Zd0=
X-Received: by 2002:a05:690c:c4f2:b0:78c:2857:7e78 with SMTP id
 00721157ae682-78fb3f71029mr684305207b3.31.1767338008471; Thu, 01 Jan 2026
 23:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
 <20251231191054.247270-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251231191054.247270-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Jan 2026 09:12:52 +0200
X-Gm-Features: AQt7F2pt7MNWAu_qAFZMWe7Nhjy2dj94e10eYcW_ADKm0W9iZCV79K4Ps1gTQf0
Message-ID: <CAC_iWj+VHVyOv43pMxfdUr=0e+9bjp+Gz4nzuweX1uSibObrXg@mail.gmail.com>
Subject: Re: [PATCH 1/4] Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 31 Dec 2025 at 21:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Since commit 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> CONFIG_CC_OPTIMIZE_FOR_DEBUG has no effect on the non-host code.
>
> This patch reestablishes the prior logic to add
>
>     -Og -Wno-maybe-uninitialized
>
> to KBUILD_CFLAGS.
>
> Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 6b5c5ee019e..2a972af4906 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -869,6 +869,11 @@ endif
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS  += -Os
> +else ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
> +-KBUILD_CFLAGS  += -Og
> +# Avoid false positives -Wmaybe-uninitialized
> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78394
> +KBUILD_CFLAGS  += -Wno-maybe-uninitialized
>  else

There's a ifdev CONFIG_CC_OPTIMIZE_FOR_DEBUG a few lines above.
Wouldn't it be better to move the HOSTCFLAGS under the new ifdef as
well?

Cheers
/Ilias
>  KBUILD_CFLAGS   += -O2
>  endif
> --
> 2.51.0
>
