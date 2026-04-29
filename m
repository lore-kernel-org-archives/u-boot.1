Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E379EFF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190428489C;
	Thu, 30 Apr 2026 01:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BG8CZhq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2DAF848A9; Thu, 30 Apr 2026 01:31:30 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D33A84897
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-671ae79e617so426504a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777505488; cv=none;
 d=google.com; s=arc-20240605;
 b=JA6m3VCl+zwgXL+v6K8V+U2PPtjvgC8oWtaxKke1I+tDbv2STUtEEq9HWfP8UFv7Bm
 j9QUR2Nh4shzhaSjLZIa2YFok74l1HbGQyc4jKUEJ7/Fpj+hFw3emV3fZgQKS/0a/XOM
 QyrvzF3SWEyE6YyntPxd9o0XUhqcL/5jrHcvJxiXcY0gBG1TEQ3quMkG7HiYfhjOKIap
 d96hTmyZyQYgviWLxw/3uJEgsDl0LH3kB0QZJqK8UF18hzShdjt5VAaoZiOJxPy/ggxc
 uq4IAmJ7TWnx/sm5C/LFhHcHOp9tA0s+HDwnzajpvJ8rsGiWpdiP+mTWqLnf42xs2Xtc
 DWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c/osFKZzZjTjzr6srPjdVZOJYpVsnGLc1mDVHKubtT4=;
 fh=GFtqIEznSwga3/zTDU8b/K+pEMbp7MIejEXpelmufKU=;
 b=CBP5vaxf89Mt5SgrUu7+dUb/pXbtqDc+QxsOxMzbTQVjdT3GYoKEpYNSJat5YOA1hW
 mTZbKvKnq5vaHtPBSmvcje0g4I6hvcHWFEeM0Wew6Xd4bX03fXl4SkCsb/xxo0eVQKLB
 yahAl7lKNNWz8znmZcbCKD5dfZMv29zV8+LLkmYylm2wFLgkf/NdWXwyKSHrYE8Z8slW
 sLkSoE9mBpwE6e70flFam8SzeRQizw+Y0PRWdItCNUN6Cst+s5MIiIK/UbClUO0dXa2Y
 JzuZbnIDZePFOXUUt3rfjZNrxDDgm2JMzXFQHDYAn5m4fzBy5bJcSLUXithcIiR3XQsW
 wSXw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777505488; x=1778110288; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c/osFKZzZjTjzr6srPjdVZOJYpVsnGLc1mDVHKubtT4=;
 b=BG8CZhq1V2BXRMSCk+3Y41w5X9IbSOxdC5jK1lRN3yzke8vLfLvw8F4ETdV6Zbtc/0
 hcQeqGs35U6/laEgZVC4s24AoNf5w0RR8RUSeH+6CrDcjoKzsHTPr0iwz80dAfo8at0H
 g2FmPJ3eBMaAySjbtYgIUw4RuKsY3yEeZa6kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777505488; x=1778110288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/osFKZzZjTjzr6srPjdVZOJYpVsnGLc1mDVHKubtT4=;
 b=pUu/NN7q8dwYqfSJFc8ESmOo6ivMxvxPtTreyiU3ZvGzV7qeOWc5jCUjOp/TyT4FWY
 aJUmPvEOKeGdAzKqjNZMEcfcmYoupb3h8yJGpjDDghizJJermupE4rlpH1HLpwCqs4Ub
 JvB8eL9dCKtM1hZAZeiPF1RxRgG/10XLzIFZhPXxy0/qv86pvQoNuUA/oU0l3r8NYJ/7
 kLZzgOoqq0Ir7H4bXOMCaiinvLdXaXLZOOFwScFBWnMzU8Ziamv7vaXGTWYW5txvg/I4
 OdKT7XHS4fV0udP4dwFLfJArNhe/Fi1rgGDnNVZJE+Ga0dKNEZ+40Dmpu/xeWylRoU9O
 6siQ==
X-Gm-Message-State: AOJu0YziXRsz+OrJ1EpiO+e4VqXx7nkZEVP1UhBRH3j8VFjgQmyMszny
 +AdptwIB2P/tZwSqFsoEBiF2VsmrClvvWY3Ug/qY3j5ziSIVlqE4mtViGurGaJffahIsURqygBX
 OtPdXTBKn7J8Bgg6Xl0pcyTlsW1duEnOsJwAHjE0o
X-Gm-Gg: AeBDietI32BiovltSqaoCew2uT2piPfggHpTR52IH7jTCWqqjkYSp6boC6LjGmMYM5w
 uDAAIrbSZ2KvL+akKJWOkAhiZoX/hXDERYSBd0UTHmQMIGXyQ2uuFoHEJ4npN6VODuWpr5C4PWK
 PIIPxb1aHbzOEe8IDAXaZ5P2lpAki+TKhT+VD7ZvAfyZyrranaU8NkOh6DjdvQjwk1BbLVG9Ybi
 D8Ck0AVCnDlnQzuHY2sSCmLQOat8mG+mRqgU6VMcGUO1gjkxTwKZ5HsGCTTgnH0HiqQz/u4Q0m+
 UDKOihBQHOYSDAvN
X-Received: by 2002:a17:907:8e0e:b0:bb7:dbd6:b401 with SMTP id
 a640c23a62f3a-bbac7298ef3mr43082966b.31.1777505487816; Wed, 29 Apr 2026
 16:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:31:16 -0600
X-Gm-Features: AVHnY4JMYGJzSqgxAovlXaavLAGQHktkFstVlE_5IPynd5qq5pi38aqpkntOnF8
Message-ID: <CAFLszTh2DQoNKvMEBaArMhmrN87Sjo8Wnp00AQUEN3XMnCa1mA@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Marek, Mark,

On Tue, 27 Jan 2026 at 16:49, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> same bank"). These are based on incorrect premise of the first commit, that
> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
> not and should not use memory above ram_top, user can perfectly well use
> that memory from the U-Boot shell, for example to load content in there.
>
> Currently, attempt to use that memory to load large image using TFTP ends
> with "TFTP error: trying to overwrite reserved memory...". With this change
> in place, the memory can be used again.
>
> Fixes: eb052cbb896f ("lmb: add and reserve memory above ram_top")
> Fixes: 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
> Reported-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jonas Karlman <jonas@kwiboo.se>,
> Cc: Mark Kettenis <kettenis@openbsd.org>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  lib/lmb.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index e2d9fe86c14..8f12c6ad8e5 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -611,7 +611,6 @@ static __maybe_unused void lmb_reserve_common_spl(void)
>  static void lmb_add_memory(void)
>  {
>         int i;
> -       phys_addr_t bank_end;
>         phys_size_t size;
>         u64 ram_top = gd->ram_top;
>         struct bd_info *bd = gd->bd;
> @@ -625,23 +624,9 @@ static void lmb_add_memory(void)
>
>         for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>                 size = bd->bi_dram[i].size;
> -               bank_end = bd->bi_dram[i].start + size;
>
> -               if (size) {
> +               if (size)
>                         lmb_add(bd->bi_dram[i].start, size);
> -
> -                       /*
> -                        * Reserve memory above ram_top as
> -                        * no-overwrite so that it cannot be
> -                        * allocated
> -                        */
> -                       if (bd->bi_dram[i].start >= ram_top)
> -                               lmb_reserve(bd->bi_dram[i].start, size,
> -                                           LMB_NOOVERWRITE);
> -                       else if (bank_end > ram_top)
> -                               lmb_reserve(ram_top, bank_end - ram_top,
> -                                           LMB_NOOVERWRITE);
> -               }
>         }
>  }
>
> --
> 2.51.0
>

A bit late, but this seems to break rpi5 for me - the board in my lab
has only 2G of memory.

Has anyone else noticed this? I can send a patch if not.

Regards,
Simon
