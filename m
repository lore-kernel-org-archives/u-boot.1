Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EABC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF43784A72;
	Thu,  2 Jul 2026 12:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aXGQl5XP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D2B84A76; Thu,  2 Jul 2026 12:28:38 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE53784A47
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so2841160a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988116; cv=none;
 d=google.com; s=arc-20260327;
 b=IF4AUA1WNq5b3bxhEiKz5cMrEoHWigiG45FyPfvFKIoCFpxaVfcESObOK8Szn5h6x4
 Y9vAlZPL5PRF1K/LBojSI8ISBSNZYxRmrvbgFXb6I8qE267Nx6ikbyXPRmI3bRqHM3g7
 NkB7cpImvpdUQtg0JpsA08wWDie83G0hSndFOTzLIt0kCZ3l3QzRZ2UoLY076N+jD1Gq
 zFxGENGnoGuARMAq1DNOy5oRNJdhD9SNjXuZ3hiJvo0rwfAEX7KKpOnaNyA6QFgchSl2
 wtqD/mHA0XPEvkonDt9+UOBgdzhSofkJbvowujSFsPkJu0+KHdc3VF50jVIjCElisgVV
 xXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fn0UxZSMdIjUHPGPTJCO/jFjimdqQ3pyX3Uy0PM125A=;
 fh=hDNHvCnVSJ97ty9EY4ihD2gxuR4KRRZarrBRrYHjWKA=;
 b=OTjVOld5Ur9hOfJxtu4pWryTY++3QhyF40xxa6r17PkHv8r8/SvW6N/G6DXKhYcYj3
 HVJWAgw+C6yfjOZkKHQDQbTurWYDdwUNWf3th1V6Cj8ojIa65F9P3kDPpWjGkBuu9bnZ
 uTCvJfuyklLl3vhAO1KEktRCCUbx0tedkPXvLeEbtf0lHUnCv1RBwZm+cYRILlYHl36y
 EMM5E7OUKpZvS+LM/oza7CDxxjJkT0A50LNNjSm3Al6wq2GPnZC9UvlQ0Nkk7fqW8xqX
 3lvoOxLIy0AeQ8IZ8qrDAgXxbr4Y/1/8a2WPePtQOzBrHWLJ4yV3U6vQFZrHQQzUnkfg
 k4QQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988116; x=1783592916; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fn0UxZSMdIjUHPGPTJCO/jFjimdqQ3pyX3Uy0PM125A=;
 b=aXGQl5XPLxxHwi1i9ipyKXbA4xcsoMibsXDKobg0b5iGKxnoQ1WyCxZQIChrarfzt1
 XxBiDtCW1PE+Bj/lguOfhW++JP0Rxz+iA3k2er7zj8UEgIQjMIBgIc7iXllWvoaMyMie
 sfzG5LzylEotuhodCR8gzn7hgSwEDvdcIrqdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988116; x=1783592916;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fn0UxZSMdIjUHPGPTJCO/jFjimdqQ3pyX3Uy0PM125A=;
 b=sQf6O13ww/sAvzOpazsisL+zORThm+AeVJqRNlJSOGpm1iZO6GUb/M+qN3zC03N7rs
 9HVm5Rlty8E0l5nmJpNrwu+TtaWBc14hMIpTA/kw2AkULqnf05FpJfKVXmuC03TAl+j8
 ESCHrBgHtBEv9ISQip2e2s/GJxpDI/371yUlXovIETKLJm22rLXkpoRV9P+e5JGl4Pvn
 /+zLQi9FL2gf3M/cYhp9e2Jw3+ac4Mgnqlk43JjrkJu3MApXSaFq9z/flneYrNqyov6o
 PjFxwAhIQOLOC3V7lmwOSL+WnvHyNvb4O0Jiv4ypOpn/cmtqGkvcHvZ9Fr0TAz9913CX
 8mMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRGTWEJyIeaqXWdv7tfnLqs/TXZ5I3o3DNgLhUS6cTno4jovlQuTduliCSuCeHtsl2FkFIlXQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxbnk+dU9PlvbR6mszvCmgouPkdzuUoHRJnJotHYxDKckKj5aq8
 ugDNMizg4l2Em3Nt4ClpghMdS/tVbv8pWuzE0l9Yy5EsIGEdLkwkpATGNIYQm+ehEJiBFkvx+xR
 4wDDp4I7KzXjoH7yBSt7LYuzvHvm14pXMT4ePCwBj
X-Gm-Gg: AfdE7cmJd4TqQCJX+CjnceifRWz3BhJdcDoaky2f0F/ry7ff5/QEalo76Um6WKcsScC
 MOrPgFn4Kf5Tf+spFggx4gNCet9rOlkgPCY7Vz2V0dmfljyvJ3m2G/HorVFZuqJAWfTdgEbvAEx
 mFcq1P/WGKY6nAEYNxDpyTOLkcgHyaSQ4x8I1jEhze0YSBaH1O86SUAWp+i+ZhP/0iTOc+bSd5C
 HD4EbAS6zCK6haer30ifPqPkxMWZtnUXl1KMFyTZD0Vzm3A6F7K4O8oRvCjWjcBwTaAsEYMyQ==
X-Received: by 2002:a05:6402:26d3:b0:698:870b:ac8c with SMTP id
 4fb4d7f45d1cf-698a2cf920amr2134393a12.36.1782988116121; Thu, 02 Jul 2026
 03:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-7-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-7-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:28:23 +0100
X-Gm-Features: AVVi8CdpSC12L79vQuKhWb9JGGCBAPlxNqpJDY7X2ScbYhckWmPlOdKowGJQrw8
Message-ID: <CAFLszTitRPvZe3Z5aCXwLogJVjjWJEV-5HmhZeG2rfudOJLOMA@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] LoongArch: skeleton and headers
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Jiaxun,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: skeleton and headers
>
> Commit for directories, Kconfig, Makefile and headers
>
> Some of them are copied from linux, some of them are derived
> from other architectures, the rest are wriiten on my own.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>

> Some of them are copied from linux, some of them are derived
> from other architectures, the rest are wriiten on my own.

Typo: wriiten -> written. Please also expand this into a proper
motivation paragraph - what LoongArch is, which ISA variant this
covers, and where the imported headers came from.

> diff --git a/arch/loongarch/include/asm/asm.h b/arch/loongarch/include/asm/asm.h
> @@ -0,0 +1,186 @@
> +/*
> + * Size of a register
> + */
> +#if defined(__loongarch__) && __loongarch_grlen == 64
> +#define SZREG        4
> +#else
> +#define SZREG        8
> +#endif

This is inverted - on 64-bit LoongArch a register is 8 bytes, not
4. The result is that REG_L/REG_S resolve to ld.w/st.w on the only
ISA this series supports. Linux seems to use __loongarch64, BTW.

> diff --git a/arch/loongarch/include/asm/system.h b/arch/loongarch/include/asm/system.h
> @@ -0,0 +1,74 @@
> +#define local_irq_save(__flags)                                 \
> +     do {                                                        \
> +             __flags = arch_local_irq_save(CSR_SSTATUS, SR_SIE) & SR_SIE; \
> +     } while (0)

This is leftover RISC-V code - arch_local_irq_save() above takes
no arguments, and CSR_SSTATUS/SR_SIE are not defined for LoongArch.
It compiles today because nothing invokes local_irq_save(), but
will break the moment anyone does. Please rewrite to call the
LoongArch save/restore helpers, matching the enable/disable pattern
above.

> diff --git a/arch/loongarch/include/asm/types.h b/arch/loongarch/include/asm/types.h
> @@ -0,0 +1,37 @@
> +#ifdef __KERNEL__
> +
> +#define BITS_PER_LONG _LOONGARCH_SZLONG

_LOONGARCH_SZLONG is never defined anywhere in the tree, so this
expands to an empty token. Please either define it (e.g. 64 for LA64)
or drop this and rely on asm-generic/bitsperlong.h like other arches.

> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> @@ -0,0 +1,19 @@
> +ARCH_FLAGS = -march=loongarch64 -mabi=lp64s -msoft-float

Since LA32 is on the TODO list, please gate this on CONFIG_ARCH_LA64
(or whatever the final symbol is) rather than hard-coding
loongarch64/lp64s.

Regards,
Simon
