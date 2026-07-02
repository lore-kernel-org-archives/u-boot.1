Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B037FC43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 594D584A48;
	Thu,  2 Jul 2026 12:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IRm5vQxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD2184A49; Thu,  2 Jul 2026 12:27:21 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12AC984A47
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698aa75d15dso1133933a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988038; cv=none;
 d=google.com; s=arc-20260327;
 b=Iq9n1JGmnPcVjW+NrH/BYqZef4562Y5Hm3FVaU5DO2H+3/F6EaZMUNaheA2rIsEb6l
 /psW9i+SL9GGXd2aDOxKqqOSW82PiEveYene86Jq3RoIysfcGFawUsuwtX29HhuIqVUj
 LmfSV3eAs3vm1pTlMdhZcpPIeY2xhM0I2ktDbEuTASXwhM99Tn1z3NEXLXI/whA5hl1L
 bsuKabi2La0K2K8L2wbSXyU6sXb7Z0ccvpKNfxpLHzcUJC537FBTmbx6ZsDgYxfwDyQQ
 CklMiBZ4O8J4jLbigNCR63KTHsT5ri/59H66lohrvMTqp70vr9Ohc6J+XbwMPHRlq1RJ
 6ZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QIdHzXVak+F2TsdyyaiZ+Zc6AKTzdbzXoTXQS0s0f2w=;
 fh=qH82zY4jYGbtq/sqaj0IKRYOiMNkPSgJiyBhAIUj2bQ=;
 b=Z2yaUjD661YrhxK69eNHXi0AxHLJULx5xU+Q7HBPRq3L7+t6lz6q9jPaBEtXpv0OfK
 32HkNyp288l0tpvCH4x1nx3pfqr+5ZUx1BvlrNG+zIKHuxHBIAyK9+nQFKpoASlY1Jyb
 G9ulCMweJJye5uC0Nf4E4QG1H/ersdD4qqOalXlHWtLOO4I5x4jq9fO4zLRrMacjuEzG
 yBlYrZobpbO9kUG0nPIv324+RpQc2OzklOaPOR/bapgFY1LcydSFjq2rPRz1OszAfv+G
 h/OWoaIPKpDcNc8eUKMZv4soRW7Fr8MUXw9zMWSo943sAhfvqieE1VkyuCNwl48vrs8W
 21Yw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988038; x=1783592838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QIdHzXVak+F2TsdyyaiZ+Zc6AKTzdbzXoTXQS0s0f2w=;
 b=IRm5vQxfq38SHpkHJBPrcg5Dek3iO8n290p9QXeLTsBvmX12yre88IyCy6Y6KR4ucr
 2uxAtOSW+zoeBpvW+MFu6Lc8ntX7oTGAIDf17xWX6ZUW8Jy4P0O+OzZbsQllOLZfTn9k
 nx6Z/gwm9I1mDDw1QjmTm/S0hCsiBcoyM/qUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988038; x=1783592838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIdHzXVak+F2TsdyyaiZ+Zc6AKTzdbzXoTXQS0s0f2w=;
 b=ALEa/gFVjV3SVioukTQ3dKsCo4dY1MEzF8RomYoHdtqA5i9a2infJrcCFwRzYtW/QX
 RcJuT1Slnrk1X22SJNxf1grBStUvF3jGJxyu3MqaHO7WL5ggyIdgmYeWZki+/mxiefqz
 bDcsJraPO5RkaffvkM7ERXOw/QcbAmE0e8y66Du/qzPADJ3M99lift7vVJXCBCjGxMRE
 fjIVnWvkdCkUpaiKMPQjT4sUMArsx/zKeVG+oME+QuiLur58EmItRDz8fpShzKPQMYgK
 +ofUlqKdwEPUkYM2zcAAfEQXQ1SYCJ7xn5z8RAHmefZBNgQvFsTK04OZfPqorDJAsQF5
 wv/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoooW2VbnZ3f+miO9zaVB8cx5lkvFnLXhCT8TDHa2hOnGtjuMe0/sB9+sFoD2M5Y7lnLwM0uv8=@lists.denx.de
X-Gm-Message-State: AOJu0YyZWIRc5U+AWHaVU6Njo0xb9XVPxUF7+sc1WMJ/DJTYZ7sIUzMU
 Y6uiGOfHQxMvfv7Eg9H5yWx+TUQUM2ml7SJ1BB4UR3ldTxwdXxs4CFGQJS8AtKBQ/b9vrFl1TvH
 yVZa1BwivCp6DMH/skvb7wqbxm2mPi2MrGDLkE7Zt
X-Gm-Gg: AfdE7cl0ZsDWHRHKG9dSuxDneCPkl9KpdQdadOzEV1yry7Tso8mIS9kV/bG3UvVXzFc
 jQgDS0LiDSw703Qa0DgscijRK+lF8qC5HGuLDq0NxX85nVF7cvyBePxwrTe0+bfOudbdxgoPSdv
 vj5LcTYeCgJzq6DpxN/0+8W6fIUO1FrqafTJLuD1q05nKroGr3zMcWu5ojCp1qGaIWvhoNW9d3U
 uU9GjNyHbks3mltF/a157WoTwHMEurKW7Mj0VWvSG8dRJ4JsHD6ZoK0lPK2M9X8ETU2A6EprQ==
X-Received: by 2002:a05:6402:a6d3:20b0:698:b25b:8de with SMTP id
 4fb4d7f45d1cf-698b25b09f2mr411553a12.27.1782988038496; Thu, 02 Jul 2026
 03:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-14-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-14-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:27:04 +0100
X-Gm-Features: AVVi8CdmckaZZLrQ9YeFc1jfpAhWbQ_jpaGoDlQ4UlDyrdzh5u7LWZVjnqNgRSM
Message-ID: <CAFLszTjRDnny3uqxHHbcg_h4pgF80c6_cy-8N_itADwNfEHLcQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] timer: Add loongarch_timer driver
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
> timer: Add loongarch_timer driver
>
> Implement a timer driver for LoongArch architecture driver.
>
> It's synced in hardware for every core in a system, and frequency
> information can be gathered from CPUCFG instruction.
>
> It is not described in fdt, thus I have to declare a DRVINFO
> for it.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> drivers/timer/Kconfig           |   8 +++
>  drivers/timer/Makefile          |   1 +
>  drivers/timer/loongarch_timer.c | 112 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)

> diff --git a/drivers/timer/loongarch_timer.c b/drivers/timer/loongarch_timer.c
> @@ -0,0 +1,112 @@
> +#include <dm.h>
> +#include <errno.h>
> +#include <timer.h>
> +#include <asm/loongarch.h>

lldiv() is used below but div64.h is not included. Please add it
(see riscv_timer.c).

> diff --git a/drivers/timer/loongarch_timer.c b/drivers/timer/loongarch_timer.c
> @@ -0,0 +1,112 @@
> +static int loongarch_timer_bind(struct udevice *dev)
> +{
> +     struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +     u32 rate;
> +
> +     rate = loongarch_timer_get_freq_cpucfg();
> +     uc_priv->clock_rate = rate;
> +
> +     return 0;
> +}

This is wired up as .probe below, so please rename to
loongarch_timer_probe(). Also, if loongarch_timer_get_freq_cpucfg()
returns 0 (LLFTP not present, or CPUCFG5 reads back zero) the driver
still probes with clock_rate=0, which then trips a divide-by-zero
in timer_get_boot_us(). Perhaps return -EINVAL in that case?

> diff --git a/drivers/timer/loongarch_timer.c b/drivers/timer/loongarch_timer.c
> @@ -0,0 +1,112 @@
> +     /* Below is converted from time(us) = (tick / rate) * 10000000 */
> +     return lldiv(ticks * 1000, (rate / 1000));

This comment is copied from riscv_timer.c and has the same typo -
us is 10^6, not 10^7. Worth fixing here (or factoring the helper
out so both architectures share it).

Regards,
Simon
