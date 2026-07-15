Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0524DC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05ACC84C53;
	Wed, 15 Jul 2026 20:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PXgvtmW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C05284C53; Wed, 15 Jul 2026 20:38:32 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 945DE84C42
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cea3004256so63487135ad.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140708; cv=none;
 d=google.com; s=arc-20260327;
 b=I6toKwyBieDj1xzyz3GByI8DRshH6p2uUCb80DVEBsN5gpZaR3MMPYpDqVUGYhW3Aw
 +dcSzgNj/3t9rvIqHmeKZkZoL0gpfDw5qFpuduiSlDrWphQkZu0eMWkDwkX1131AMkRC
 M8yAekMJflz/LVilgi017Vzd/owXISFssVhYLMNbOP89SADeRJvEiIR3It8Rlgdy1FF5
 tCQ3Or3su1s7MgOhlXcSuZ8ltoRK1dKoa2cSVuA+ojsX/TfKSxbzQVPnnI8tHF4FuTyB
 sYZfn1Iahhojq6X9ANxIKaVhE6TNUApcQMkIOJP5r7QigUhsdS1HrnvarUfKRnZ8Zoke
 LQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vcCZoPmlqKitRFN/ypHBzeuLzQsGhcewImlbs+G1fqU=;
 fh=iJRW8VB93FX08DrH3y1pKDG0/UVKiIyyGubq8HI//Y8=;
 b=VbIgkLTWLZbXVxI1AnLu0fcuXk89jZitFI4FgV7mRmxqhqbDrdCv4X8bbwrzbkxq7F
 MBYi6hDWGaMgKhSdApefvItDWd/AkuhpoMZxwytA0LliKfsRJxwJLvKA/yrZH0fXJnXs
 0yIZr9MSNo9PQiPEjxXDolQ/libQloZ0xJXLgxIDmINEoq8dats6ElG6A8HmEL+KLWzo
 HFU6wRaBwzssJnFlWaaLezpSxZvQm8XCmVt6B2efu3tROVAbH+mJe3mQnpppaHNYsDqF
 oXY4dT2sDfaRVNXbs15v0p0ZfcXtRUr7s7y/K3gCkBFdg0uttMB4NL0ApBBtPouapoKQ
 JTog==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140708; x=1784745508; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vcCZoPmlqKitRFN/ypHBzeuLzQsGhcewImlbs+G1fqU=;
 b=PXgvtmW1vobUX5ZMLsBKxyBdumlfNh502bJvu9NOTApKsfRU/rf8ATPpf0ODLec2hg
 GyGhztj3pOYtoCezHm37/zLyqKZSKJwwjz7pMVcgiA6589AnCLF9KT1uqqRXP/1WiSrA
 m5vcozCGEfz/hEtPdchVf7OwUP8yAcCYlnahw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140708; x=1784745508;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vcCZoPmlqKitRFN/ypHBzeuLzQsGhcewImlbs+G1fqU=;
 b=db7d+hODlfc8Gwrq1FX1Lcc2DNa2klLmQFrMrazyxvvVyhmqTZyzFfxAoYe+n4aVN/
 jRmG3778jeiTD+NrgIQpMblqyC4y/Y4DdZEWI6TBoUru5Fs7Ci4ciGZ+CeOaN3ZMT7uL
 8zScXi27MxGdDzyjH5nvCbPJEm0s8kUFlUjqEtq/kHb8orlA1KT57DaZsrfeJZAlmLmt
 cm0G6bW2LuI4ctAKdb6EHD3pg6b8/OEzKA5YU6/OvgyPUI1ONoUyz8OOFsLLCaTA32/g
 hX8FOwRixpVZwBkKsmqYtIEDrq7Xn26M5ARBsfDAKd3F6PpuOX3pRK7ckRlXoANw4ABd
 aNJQ==
X-Gm-Message-State: AOJu0Yxvb8BPXSnj9QwnVFBKdJDY++8UbCBUwXpW0AoYyj2d3/BBledA
 zqoNpzq2O3KJee01OcsewlvdQjWBFK0AVOw4ORshQc5ptC68oJMN4DwKYUKn5sI+ruoM4/OehQE
 E1PCb5jftrFJJn3dycZnvxNitOQs9CFtvSfmdM6KY
X-Gm-Gg: AfdE7clbzwO57iwhmn0KmiBdka+EB4t04Za3dHat/U9edYBDkIbRUT1WoP3+ygHBzl/
 1rrvNWVSJdGuYlo5Igg7Yk7bsrvEKcjX2EcYpgwlH9kyLa8WdqdO8HAn6Lca1nlUZCStCZjQHoE
 X+8T1bbVOv2zilTcmjEhdXo/8LQUwx4fI/zGai3j/CFpsu/w175T/fHVM8LkC6xKg0I89PBCDH+
 KZ19vPalMC+RQ3b7t/bCmXfxw4VmAVqkPauSYi/z1xuHGGglO/u9XuTZY3J9jFgBgnGY/I=
X-Received: by 2002:a17:902:d4c2:b0:2c9:e9db:8167 with SMTP id
 d9443c01a7336-2cef12e8f00mr75738785ad.7.1784140707764; Wed, 15 Jul 2026
 11:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
 <20260710-rinta-watchdog-gettime-v1-1-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-1-9a982fb93f49@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:38:10 -0600
X-Gm-Features: AUfX_mwotqnNDsHms7Duamfg1ldqpm1wwZAWpFBBGqbZphYsEHOg_7ZYOWNp6sk
Message-ID: <CAFLszThP7wTW6h8__pwnK2t5vgU0fB4_M43y7F+TK_adKiyFbA@mail.gmail.com>
Subject: Re: [PATCH 1/6] watchdog: wdt-uclass: add get_timeout operation and
 helper
To: juuso.rinta@nokia.com
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
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

Hi Juuso,

On 2026-07-10T04:51:17, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: wdt-uclass: add get_timeout operation and helper
>
> The wdt_start function may be called with a timeout greater
> than the hardware-supported maximum. This in turn can result
> to bogus print, e.g.
> Started <watchdog@> with servicing every 1000ms (60s timeout)
>
> Add a uclass get_timeout operation and helper so drivers can
> report the effective timeout. When available, the startup
> print now shows both actual and requested timeout values, e.g.
> Started <watchdog@> with servicing every 1000ms (10s timeout, requested 60s)
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> drivers/watchdog/wdt-uclass.c | 35 +++++++++++++++++++++++++++++++++--
>  include/wdt.h                 | 22 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 2 deletions(-)

Assuming this is a static value, it might be more efficient (code size
and simplicity) to add a max_timeout_ms (max timeout in milliseconds)
uint to the per-device uclass-plat data - 0 could mean no limit, thus
allowing existing drivers to not set it.

If you are OK with that, then a lot of my comments might become less relevant.

> The wdt_start function may be called with a timeout greater
> than the hardware-supported maximum. This in turn can result
> to bogus print, e.g.

'can result in a bogus print'. Also please use () when referring
to functions, i.e. wdt_start()

> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> @@ -143,9 +161,22 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>       const struct wdt_ops *ops = device_get_ops(dev);
>       int ret;
> +     u64 effective_timeout = timeout_ms;
> +     char requested_timeout[32];

These are only used in the success path, so please can you move them
into the if (!ret) block, next to the existing 'str' declaration?
Also 'requested_timeout' holds a message suffix rather than a timeout
value, so something like 'req_str' would be clearer.

> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> @@ -143,9 +161,22 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +             /* Get the effective timeout from driver if supported */
> +             memset(requested_timeout, 0, 32);
> +             if (wdt_get_timeout(dev, &effective_timeout) == 0) {
> +                     u32 effective_s = (u32)lldiv(effective_timeout, 1000);
> +                     u32 requested_s = (u32)lldiv(timeout_ms, 1000);
> +
> +                     if (effective_s != requested_s) {
> +                             snprintf(requested_timeout, 32, ", requested %ds",
> +                                      requested_s);
> +                     }
> +             }

There is no need to clear the whole buffer - snprintf() terminates the
string, so requested_timeout[0] = '\0' is enough. Either way, please
use sizeof(requested_timeout) rather than repeating the magic 32 here
and in the snprintf() call.

The comparison is done in whole seconds, so a request of 1500ms clamped
to 1000ms prints just '1s timeout' with no note. I suspect that is
intentional, to avoid noise from sub-second rounding, but a brief
comment saying so would help.

> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> @@ -116,10 +116,28 @@ int initr_watchdog(void)
> +     ret = ops->get_timeout(dev, &tout_val);
> +     if (ret == 0)
> +             *timeout_ms = tout_val;
> +
> +     return ret;

The 'tout_val' intermediate exists only to guarantee the 'unchanged on
error' behaviour documented in the header. Since you control all the
driver implementations in this series, it would be simpler to pass
timeout_ms straight through and document that drivers must only write
it on success. What do you think?

> diff --git a/include/wdt.h b/include/wdt.h
> @@ -74,6 +74,19 @@ int wdt_expire_now(struct udevice *dev, ulong flags);
> + * @dev: WDT device
> + * @timeout_ms: A pointer where the effective timeout in milliseconds
> + * is returned to. On error, the value is left unchanged.
> + * @return 0 if OK -ve on error

Please match the format used elsewhere in this file: '@return: 0 if
OK, -ve on error'. The @timeout_ms description could be tightened too,
e.g. 'Returns the effective timeout in milliseconds; unchanged on
error'

Regards,
Simon
