Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B2C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40CD84A26;
	Thu,  2 Jul 2026 12:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bpQ14CXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5511684A26; Thu,  2 Jul 2026 12:26:53 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6270D84987
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso3515442a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988011; cv=none;
 d=google.com; s=arc-20260327;
 b=KdS+XWAFop814RiStUZrdjmq2WQcoyDx7VUAvpL0lr92EzEsu3iBawTdBVZ1T9OUqZ
 kzdcvetx3cmicZ0SZZTRYWj5oOTCp0U1XQydAlw7jYmJj8eQ+UdRiJJkBZ5UPyEd0u9b
 P0IRsjSf+nx4nEzhlbhIyzu9kCqUI8NNhnFfy6ccffULrLfeP33qSH8PoXkdkNikpyWT
 rI/nky14lbI9PcT0ulMgBFbH3g5xgzCVG2R4DKyd1NVlNXB4zF0UTgb4Blx2VS4K8EuY
 h/ghaDgTUbzqaSOH/JJecG29ZPR6On90rCeOzq24NBxuinbsVUC4rh6GtZeh0Zi0+Xtu
 zsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QndjOw7xc/dgwV7e4kEqXp8WssUhv38I5+RfTqQuCTo=;
 fh=9NfA68LAqcpGcYrROkz0wENxuTnZESnd9c79gwXm0do=;
 b=FrcaU1KwQR7bTuV/W6k03l/h9rmwe1KQuu7AD/lZwjqm3u5mgcGe5goCIEw7QZ8/nH
 ekjSHarwyMluSlemcwSwdmD1n3Fl2Q/de3PhZ4Jo6grzHdMWjArKC+TXhekWJN0lid9D
 ZQ5teSv8TNM1dTvXyucqS0W5BEBuBG/KVPO9YIu0XYR8IQWRKEMYegMoMOAEtZSHR9os
 XMI5Yp0q8q0DPv1OtjBO5CGsoOktEbvoKgFkgWMqj5FYF4N8Ig7ITkcshZIiotAQFbq9
 olMAuJQxMCl3xLhxjfEG0jN/wgnW/B/6eZpTfy1W8fTf6IGTkrMl+MQcsUiYkBqwhv91
 zqgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988011; x=1783592811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QndjOw7xc/dgwV7e4kEqXp8WssUhv38I5+RfTqQuCTo=;
 b=bpQ14CXfq4VuEPNRd8hRIrHvoeAqItTEUpERGFmjuAH0lwCOS2CFOSTHuRMMNq/Ia5
 E/ld9Zrh6n39vJN2QQh6e5XhjbMf5Iy7dn5qXAwdbAANXyszjaXF+CLlahySlFFW+tVy
 TIBkBq57KJofSYk2L+AkYVCA9xNNSRt6qJ0L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988011; x=1783592811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QndjOw7xc/dgwV7e4kEqXp8WssUhv38I5+RfTqQuCTo=;
 b=XR1ahU6q7hj94GobM5JCOph0YtZu04BFoJ2c3SBR+TTY4bR/KI8j/CKrxZvpWMfC88
 JYPT8cVsw1UiVP1e2xD9dAcMlqjpQKk6tMmVkNa7r+RMMJ6C6pfYp/Z3imr/J6183lox
 fhbOJ2hH2uapCYApxpCS87vgd6Mf2uannqk7cZYa00ZGuo/5hhMx4OTCHmJ2M/H55lIA
 aHhiYXW1kHdO1hJs1MtLYVwCE+vzui3abRlnohhJGzRcEirmHTtIIWSyfz77czquMjTF
 qKzWCe3uAf6NvwtVimjtAw4w5Ts0iSB6d+/Zn93BQGEPjP/fs/0StJxf4KCf/cfUsoUL
 mjbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKFyS4BPzz5gt13PHhj5RCJjXgLUBzEYsp75wmil79L3eNTxSGe0Uir9rrOecWy4h3KJ8Rl1g=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2fkA4b23W2sxzFYEQu4ShL0KjRYn8Ay18MEq2eahd3ADv9O6v
 Tb451ZJ4T36uWW9Xo7qHdKrhSiI/nQZZOnIgz3EM3TcCbqYJlDPJFokHQMVntf5jaPYgAzCf5nY
 2NHuqKq0kVt/XXIy3tL8hMrNqhI2c+luBheaIa7qN
X-Gm-Gg: AfdE7ckyXXyihIGr8wa/VDXf8QtAtsYBNIJgiAH7e6AKI/c8mDr8V9SYbCh6VEzDhm9
 oMMYbt12NQFwdlpDxnObkfhZ4Q9qkQLA9rxIDGynVDR71uo3dKAv1e1itzWjNA4gvEvtvLRhIxP
 wFly9vr1SzzGDEBbcOSZg7yDAq1U/QY80HQpOUwsf7WaZP9ylJLfhoHiYHotre0U9ocvp6pXDrC
 b7nRtTpIcmLEIkHGrV72jarrmAdxYguQd7Yt9I0R78grLdoWPeZ5GdPQ2FPdNVIt/RX1UTaWZmp
 Jbl9K42N
X-Received: by 2002:a05:6402:4316:b0:698:81ab:c936 with SMTP id
 4fb4d7f45d1cf-698a2cd827bmr2333792a12.23.1782988010232; Thu, 02 Jul 2026
 03:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-12-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-12-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:26:35 +0100
X-Gm-Features: AVVi8CfmWxF3lktSk8P5kYphhwcnjRr1NeTPtf-EwGvEvhMO_O93LxUJpiBQczs
Message-ID: <CAFLszTibBNFc91tGMv3xQzLTCBOXRxBfA+aLzUuhgPLN6rTb5g@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] LoongArch: Generic CPU type
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: Generic CPU type
>
> Provide a generic CPU type with some common routines
> that expected to be implemented at CPU level.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
>  arch/loongarch/cpu/generic/Makefile |  7 +++++++
>  arch/loongarch/cpu/generic/cpu.c    | 22 ++++++++++++++++++++++
>  arch/loongarch/cpu/generic/dram.c   | 21 +++++++++++++++++++++
>  5 files changed, 64 insertions(+)

> LoongArch: Generic CPU type

'generic CPU type' isn't quite right - this adds the 'generic'
platform (common cleanup/DRAM code) rather than a CPU type. Please
reword and fix the grammar of the second sentence ('some common
routines that are expected to be implemented at the CPU level'). A
short note on what falls under this bucket vs. the actual CPU driver
(patch 12) would help.

> diff --git a/arch/loongarch/cpu/generic/cpu.c b/arch/loongarch/cpu/generic/cpu.c
> @@ -0,0 +1,22 @@
> +/*
> + * cleanup_before_linux() is called just before we call linux
> + * it prepares the processor for linux
> + *
> + * we disable interrupt and caches.
> + */
> +int cleanup_before_linux(void)
> +{
> +     disable_interrupts();
> +
> +     cache_flush();
> +
> +     return 0;
> +}

The comment says 'we disable interrupt and caches' but the code
only disables interrupts and flushes the caches. Please fix the
comment to match (or, if disabling the caches was intended, add
that). Also, 'Linux' should be capitalised.

> diff --git a/arch/loongarch/cpu/generic/dram.c b/arch/loongarch/cpu/generic/dram.c
> @@ -0,0 +1,21 @@
> +#include <fdtdec.h>
> +#include <init.h>
> +#include <asm/global_data.h>
> +#include <linux/sizes.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;

Neither gd nor anything from linux/sizes.h or asm/global_data.h is
used here. Please drop the unused includes and DECLARE_GLOBAL_DATA_PTR.
Compare arch/riscv/cpu/generic/dram.c which keeps this to just
fdtdec.h and init.h.

Regards,
Simon
