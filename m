Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C51C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4911F84A67;
	Thu,  2 Jul 2026 12:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FJVTgGXD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DDC584A6B; Thu,  2 Jul 2026 12:28:22 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4E484A47
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so2445459a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988100; cv=none;
 d=google.com; s=arc-20260327;
 b=mj1NgIvJgGgxTvljafGWUCAaRCRMVaSh6YFXksrsEkfdWL3yAZjFhrZbIBc4EyFzFc
 z2nepQ/j+lLGhr4zaipd9bvAhNN3/VK6jfjvl1e3B0Ea73q9x5m+PLOsrymDXT0KYxHT
 1HQJT8YInRX66S59WaECYDQHfXctK72RfIbDUKo/k9rxDCaowGP1r3hyI7C4QsG8o8Gr
 mOl4cdYrK9zn9VlwT17dt94Td80y4Z5sJ0KMDHCJXHLvWoLFDNKQQMXzIjMFEaYffFua
 buuY+GQpoMaaHnITo6ig5/YOX79hQ73ASXSyToDpkplkYnIzXzH+72swOqfCVMH6HNnq
 gzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6wozH4AhDioYhafsi8z1EcB7QXn63u9eKczT9uB5o3Q=;
 fh=pDtjfAaf7vbJaF9C5cMkYP5kjK5SrMXIYajLtk/LYQk=;
 b=S47i7YyVvGdI3PfrrjFr1hRR50KqCztqs/E2KU3QpOYdGaeJltxyLaXkadvHobedhv
 NOLa7SdKT3M/Ong/4bF43+qm5Ps0Wd72sgdFds38rGMSScLUYcuO+cGT/ik9KXEmnEVN
 EUvCQ1HqMd/wfQOF8xWfh6580uV3OxWn0VGpIoFT8sQ4AMmjed5n+8kvYnV46ydiNkds
 zSLFrY3Hgz/SHj3ZQ7l1lP+IWfhBg6gkG0wxvOLO1dLr5Q5PJCOOYtyD7VkEupHXUktK
 tR7nk8uY2ye9vPoinKAsEjpL6+Z0yeVn3NQ9bsD4GopvW/+9OfNy2n95Ybdiqocb/4dX
 Om2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988100; x=1783592900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6wozH4AhDioYhafsi8z1EcB7QXn63u9eKczT9uB5o3Q=;
 b=FJVTgGXDOQz9eo+DLU0yLUQ+Uy45XPzQdyBAn9jbdTHolnUff/P4HviqOEcrFMmlkY
 84eUPvpWQBvk9u1MlnVNfLg9VnAl0ijJpoA2wA6rNqqW5jqJlbIy/Y9cHI8WRL7Vnia+
 Zo4ksVJ2ieWFXKidQbbFqRfNx0hvkcuaVIPTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988100; x=1783592900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wozH4AhDioYhafsi8z1EcB7QXn63u9eKczT9uB5o3Q=;
 b=quG+Y7Z/s6941TRLWU1agdTeB/dSatDh3MchVOjG3wT/A77PLnSEXuyg0RM4GCWKxh
 KRD9odLZd6ip6kVRMyX61MhBujPpsvgazWSSEyUtwYZ6J/X19SyJzOcxQOmDA0zUE93Z
 FyPJldcyLogCXyueD4WfN/rsFR4mQirQDKKk4WeFtLix9pGs1s0S+KDKqkO5cGeN0Pkl
 fuajMP9DpFsIXEchZ9HA9ygup/Ib/6lA4235vGBpFckqBOYycZX+MqFrvALpxWVn+mXg
 Uiqj/D2im2IF3i8sBs5UzQ3r2Y63Jko8Dxr68bz5Jp2egfXU7uBsH/qI0CYyQHpuMO1A
 d2eQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRZ9ZjiA7fSRyF7JqdiIoSPISkJWZOGWi9udyhE0Knp6n5HcWo0fYYIc97+WskcOXMnszJbTU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8jC7hCT0YcLHdwy4V9TeyF2TjDp/Fx+vgLTv8KmU/LuV+3g7x
 O/im8htFGTuwJ14aw2rjXZsgzzLZuCjI78frdxM7jsm+s6E+qlR1Q+F7eL2qy+lPDWo0zsZEY2q
 XrUsp5iCXaKyTVDeORBZecdBKfPL6y0Gzj3s1lwsN
X-Gm-Gg: AfdE7clVATFaLSGX6jt6qKeW26yh5kQquho1Heh+jqEqCMvEhn+ZVaOc46QbJw9s70l
 UaVnejh2QVwCPkbFzN4byK2fyzTkgncKf+B4vr+Cz7/veyO3D5ABL2idyxA1IhrwTbiu9mQi0H5
 H5Nnk7wMGrNcXXj+eEDg3OdnnXadT+zdS/xNRnRqnmhf4n5ch65YEzwVlpPuRl+aiSkPy4g8qgW
 zQBzMKeaRszptH1ocAWPajkTjKFpnEF5zPWsiM58Q9lle7nO3n6X19SbOpyJhva0XolNEFhGw==
X-Received: by 2002:a05:6402:2483:b0:687:7fa4:faa0 with SMTP id
 4fb4d7f45d1cf-698a2cd157cmr2284434a12.23.1782988099827; Thu, 02 Jul 2026
 03:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-8-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-8-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:28:08 +0100
X-Gm-Features: AVVi8CehN5dvG6Xk0P-diAvq5vZcnth1LfzFy1oyjwNRfKS7iu3ZvaHq_H-a_E4
Message-ID: <CAFLszThSQPzj4NpjM+AUbovZv4oZBZR3yfjhk0rfLanTsXe8fw@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] LoongArch: lib: General routines
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
> LoongArch: lib: General routines
>
> Add some common library routines for the architecture.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> arch/loongarch/include/asm/cache.h       |  10 ++
>  arch/loongarch/include/asm/global_data.h |   7 +
>  arch/loongarch/lib/Makefile              |   7 +
>  arch/loongarch/lib/asm-offsets.c         |  66 ++++++++++
>  arch/loongarch/lib/boot.c                |  14 ++
>  arch/loongarch/lib/cache.c               | 213 +++++++++++++++++++++++++++++++
>  arch/loongarch/lib/reset.c               |  14 ++
>  arch/loongarch/lib/setjmp.S              |  52 ++++++++
>  8 files changed, 383 insertions(+)

> Add some common library routines for the architecture.

Please expand the commit message: list what the routines are
(cache maintenance, setjmp/longjmp, asm-offsets, do_go_exec,
do_reset) and note that cache handling probes the hierarchy via
CPUCFG.

> diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
> @@ -0,0 +1,213 @@
> +static inline void flush_cache_line_index(unsigned int index,
> +                                       unsigned long addr)
> +{
> +#define do_flush(index)                                                      \
> +     case index:                                                     \
> +             cache_op(FIELD_PREP(CACHE_OP, CACHE_INDEX_INVWB) |      \
> +                      FIELD_PREP(CACHE_INDEX, index),                \
> +                      index);                                        \
> +             break;
> +
> +     switch (index) {
> +             do_flush(0);
> +             do_flush(1);
> +             do_flush(2);
> +             do_flush(3);
> +             do_flush(4);
> +             do_flush(5);
> +     }
> +
> +#undef do_flush
> +}

addr is silently dropped. Inside do_flush() the token index
resolves to the macro parameter (0..5, the cache identifier), so
cache_op() always gets the small constant as its address operand.
The way/set offset that flush_dcache_level_all() computes never
reaches the CACOP instruction, so this hammers way 0 / set 0 of
the selected cache repeatedly instead of walking it. Please pass
addr through (rename the macro parameter to avoid the shadow), and
confirm with a real by-index flush test.

> diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
> @@ -0,0 +1,213 @@
> +void probe_caches(void)
> +{
> +     unsigned int level = 0, index = 0;
> +     u32 cfg = read_cpucfg(LOONGARCH_CPUCFG16);
> +
> +     if (cfg & CPUCFG16_L1_IUPRE) {
> +             if (cfg & CPUCFG16_L1_IUUNIFY) {
> +                     gd->arch.dcache_index[level] = index;
> +                     populate_dcache_properties(cfg, level++,
> +                                                LOONGARCH_CPUCFG17);
> +             }
> +
> +             index++;
> +     }
> +
> +     if (cfg & CPUCFG16_L1_DPRE) {
> +             gd->arch.dcache_index[level] = index++;
> +             populate_dcache_properties(cfg, level++, LOONGARCH_CPUCFG18);
> +     }
> +
> +     cfg >>= 3;
> +
> +     for (; level < 3; level++) {

Please use CACHE_MAX_LEVEL rather than the bare 3.
populate_dcache_properties() also sets dcache_inclusive from cfg
whenever level != 0, but on the L1D path cfg is still CPUCFG16 -
the L1 inclusive bit describes L1I vs L1D, not L1D vs L2, so this
looks incorrect. Please double-check.

> diff --git a/arch/loongarch/include/asm/cache.h b/arch/loongarch/include/asm/cache.h
> @@ -15,6 +18,13 @@ void cache_flush(void);
> +#define CACHE_MAX_LEVEL              3
> +#define CACHE_MAX_INDEX              6

A short comment on what these two bounds represent (max dcache
levels tracked vs. max hardware cache-id encoded in CACOP) would
help - they are easy to confuse.

> diff --git a/arch/loongarch/lib/setjmp.S b/arch/loongarch/lib/setjmp.S
> @@ -0,0 +1,52 @@
> +ENTRY(setjmp)
> +     LONG_S          s0, a0, 0
> +     LONG_S          s1, a0, (1 * LONGSIZE)

Stray space after LONG_S here (and in longjmp). Please clean up.

Regards,
Simon
