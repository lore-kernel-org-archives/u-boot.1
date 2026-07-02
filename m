Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CB3C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C32384A20;
	Thu,  2 Jul 2026 22:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z/kPixTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE57784A3C; Thu,  2 Jul 2026 22:04:51 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DE0849F0
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so3913071a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022688; cv=none;
 d=google.com; s=arc-20260327;
 b=KacpcfakjaRQMEsVMnc7HblKAHvxnZbQ35xza9ewS2Z7l5LDICiD9mFkSyI6Fon9dN
 4FIzFXaJcpLBItfk/XfAsQ6MOtUmaUQKr8Z0xJ7DFEhk2QrVOhubTtA3BApzJ4xvI/gC
 j2yNINzyf2pal1wHfrKm/WF7Q3PWaYkBSBoIQOndyvgiT11x6WqGwa3UwJrDr7TXhKBN
 SfwYcCYTv9e8glbuKWkO1YtHQ1fnu3LPkE+rhCIy8s04iEDmD7PwxOH1pcpKXPkWiRzd
 4zl755YFajx2w5i1rxG/hfvvtlUkXDGtWRBic/0dw3b3rvIk5ElyhuPGfKblwXOMbJCH
 SulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zfXu/GhuPxstyKjJ94COV7eXw3SLeucdn+7Bah97naI=;
 fh=6vrd56uqUSvkH8lVFDnxOtCC8M+lXhrqtHH7qSgvXpA=;
 b=AIZK+aPb5lrV0ycJgfTITG1Xtucok1mL1nEtnUMR6iyebax42q/gD2XGc7bnJSP3ch
 Zj8pDYqmrYtvMwX/4AzGAY0J5l1ymf1Y4z2KFfd7VNQkw4R2jmbx9jlZFiSjfPINYeyM
 Bt8OLsjN01G7q9AnlFNxWtT2YhUO3jdu69wCAoh0acpCh542eaJDSiS7c95tKxLVfxiC
 HZdpXOFMbsfgiwrvxm6XnyHB05fNO3STY3TU27hEc1Y5eUaYzRumjErm3uQ9ozpiz/Hp
 qPkXZKmrCndXm5Wt0CuevtK9EkD5rZmG0pUR6SSECSCA55gbvCZ7Cc2TBehVxOm1yWy+
 DxcQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022688; x=1783627488; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zfXu/GhuPxstyKjJ94COV7eXw3SLeucdn+7Bah97naI=;
 b=Z/kPixTpNLhxIz4UfSF78BgLHmjHk6zW0cUm67k6wJwjuv6gC3prsju9EXG2tSjCNw
 tHxj71e+5Nnpf77fbHvQZNI8ch7qXLgvj1HDR9MT5FevlpwARnIHjUaidk2R7LvJL8Zb
 9nmfLcBsNg5+2ThqW+Y9rYW5A9DTlacmvgAs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022688; x=1783627488;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zfXu/GhuPxstyKjJ94COV7eXw3SLeucdn+7Bah97naI=;
 b=eW9c5K32gBGyglk3a1oXIDCls/j/Dps43PqYZ+SYjiecTC6Ji18LoGBwkRJidggyRA
 r+Y9l/1D5OidwXqsTbaUtV7BTbyiOdK8EqGp7sLpzUjGkcBUD/h5WfetHsVWrIOhiJ4y
 FieFx1ICwKSkP5kqIOT0gPT4G0nrDGFj8qCAoLWj/ulLdiCXw0E6dL1+4Loel1jf1N7h
 hLeluuB+zzWbWUpED8dSbm6qcEJqjZwMydcPQEbUaHZh+EP7DXOXZbLIRJWrRyxzru9k
 BcP/OyCIyo11Xfv4lSYUVB5P9JV9dHN5CjbFvOLzRcpmiSEhD6s56rwf/TUQ4XoVX1sD
 hYAg==
X-Gm-Message-State: AOJu0YzAGYeJ2KJJMNKcpgrsmY8xJ+LY3fJE2pXpn3lXx2gMFlVtgTtz
 /IFm1NC2DzBz4Q1NtGoDz8QkF0+LdT4zqzpDZULvtX6lrUaYBlMr0PVCOZQponIfT26keVUrJvL
 aR0cgLgYmZnXt3JafAztF9IU35aFgEGrjIetbKHI4
X-Gm-Gg: AfdE7cldV/hcjqeJiBhXzV7uAn+YS5UQkwRFKUx5nt0774qtkJNP6MPAJJGL0nxg+nz
 Ecrcb+ZdL5BXi2KcvLlAUGj4Yo9ub+sm5h90vd56Ja5ZqvMHA/TGXAsBRXbCEYfYTESIJHGB4PM
 hqRoCTaqD3ZZXJA6TdLjf7+xq+IPpC33Ruk5K8HJYKn1gjNpik+qvHc8ZmxOC1krd0dh2cgTkJt
 aqvdEtaU0QZo0AQ105Iw+JF3OuH5bP8I3tbowkIVQaDXgpcQ7no7mj/w22rniOkhX1pPkx4cA==
X-Received: by 2002:a05:6402:1946:b0:698:3b7c:3b39 with SMTP id
 4fb4d7f45d1cf-698a2cf92fbmr3186139a12.37.1783022688633; Thu, 02 Jul 2026
 13:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
 <20260702014724.1534351-9-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-9-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:04:36 +0100
X-Gm-Features: AVVi8CegdSM1Zwe6BzwoV8v42fmkTgdijlthrzWNA3p7bhRB54tuVE8fHDv4PFg
Message-ID: <CAFLszTiLV0KLpyu-_K_nsc9gOKWxqo8ZWj0O+9+k9BkDoKEuUQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] crypto: allwinner: add sun8i-ce hash driver
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>
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

Hi James,

On 2026-07-02T01:46:51, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: allwinner: add sun8i-ce hash driver
>
> The Allwinner sun8i Crypto Engine includes hardware hash methods. Add a
> UCLASS_HASH child for the sun8i-ce parent so FIT hash verification can use
> the accelerator from U-Boot proper and SPL.
>
> Support MD5, SHA1, SHA256, SHA384 and SHA512 using the CE one-shot task
> interface. Build the final hash padding in the driver and bounce
> cache-unaligned input so FIT data with short or unaligned tails can be
> hashed directly.
>
> H6 and H616 use bit-sized hash task lengths. In SPL, only advertise hash
> algorithms selected for that phase so SRAM-constrained builds do not accept
> wider algorithms unless requested.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/allwinner/sun8i-ce/Kconfig         |  26 ++
>  drivers/crypto/allwinner/sun8i-ce/Makefile        |   1 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  11 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 300 ++++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |   7 +
>  5 files changed, 345 insertions(+)

> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
> @@ -0,0 +1,300 @@
> +     struct sunxi_ce_task *task = &job->task;
> +     u32 total_len = src_len + pad_len;
> ...
> +     task->t_dlen = ce->variant->hash_t_dlen_in_bits ?
> +                    total_len * 8 : total_len / sizeof(u32);

Since both H6 and H616 set hash_t_dlen_in_bits, this u32 multiply
overflows for inputs of 512 MiB or more, so t_dlen wraps and the CE
produces a wrong digest with no error. The whole input is submitted as
a single one-shot task, unlike the AES driver which chunks at 128 KiB,
so nothing else limits the size. Please can you reject over-limit
lengths in sunxi_hash_digest() with -EINVAL so this fails cleanly?

> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
> @@ -0,0 +1,300 @@
> +     if (src_len && !IS_ALIGNED((ulong)ibuf, ARCH_DMA_MINALIGN)) {
> +             src_buf = memalign(ARCH_DMA_MINALIGN,
> +                                ALIGN(src_len, ARCH_DMA_MINALIGN));

This bounces the entire input in one allocation, so an unaligned FIT
image of a few MiB needs an equally large bounce buffer, which may
well fail in SPL where the heap is small. Since the source mapping is
DMA_TO_DEVICE and only flushes the cache, a misaligned start is not
destructive; my understanding is the hardware only needs word
alignment (the H616 word-addressed descriptors imply 4-byte
alignment). Could the bounce be limited to buffers that are not 4-byte
aligned, with the flush rounded outwards as sunxi_ce_flush() already
does? What do you think?

> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
> @@ -0,0 +1,300 @@
> +     ret = sunxi_hash_digest(dev, algo, ibuf, ilen, obuf);
> +     if (!ret && chunk_sz)
> +             schedule();

The point of hash_digest_wd() is to keep the watchdog fed while a long
hash runs, but here schedule() is only called after the operation has
completed, which does not help. The wait loops in sunxi_ce_run_task()
use readl_poll_timeout() with a 3-second timeout and never call
schedule(), so a slow hash of a large image could trigger the
watchdog. I suggest feeding the watchdog inside the core polling loop
(e.g. readl_poll_sleep_timeout() with a schedule() call, or an
explicit loop) and dropping the call here.

Regards,
Simon
