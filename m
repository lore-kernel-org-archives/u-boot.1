Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC2FCD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 18:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8749840ED;
	Sun,  7 Jun 2026 20:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XcyRRSez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7F7840ED; Sun,  7 Jun 2026 20:19:39 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EDC84715
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 20:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2bf237e1433so41088675ad.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 11:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780856375; cv=none;
 d=google.com; s=arc-20240605;
 b=eUh8Zz5dTR2BZ2Ms0EP+uMVubD+L0EZGl/dUjR21AhPJpNfakW3xJ2FU1yedU3sAh3
 yxAJ3kXvyC+o0sZaUd2jkKKxcTeOwRrfufhK5do7c1W3LEkRdLKBm3wC2gk/h4re2SPG
 Uo18ZbpIMIrojKCb8jttB2yTW1SmUJQnFg5Tbi7Da8vhUgeR8K7JB6cRtYIbOnphFPQ3
 sB46nOelw+BMKkBJR54/ZG5Q9Ivzr1uY8sAcsh0RAQqY6nGX3E69uw/33BILyYjxnJyW
 tgWARnzrWbzyyA4iD8wX+VPTaFSCiuJYhVMtxKtWftmeuvChuoNJ136GOYK+P1/TkqfI
 zbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L72D3G1nnbgdrbSBUmbwjVqOerSbEID158YQGvWU4/E=;
 fh=x2HiCw+T2IBeMZUxac0rIu6S1BxLn5g86yOYMMh0hWU=;
 b=cpB3hMpG/QWj4CDOZFa/642a6IZGRcFwz6weECrrlG4bomtVZnK5Xp30lepE/BjPXY
 pFdH41R2AMNOEpFqciVhAODULeK+vgn0wns9SQf8fmbyobwugCx9BxTGLotstGIagg+J
 py8SRMKSqBpmNsO0JgpuQSWovYQWTiBjYuvVNoSgpkfndPXCY4Ua4/vUwbzRy+5qIRG7
 M2d2GFT79n2jDgXX1HHkjNrzgvSohzCtsBj7ZKGXh79jf0xWLkPr9N9OtD5zgxMp/oEE
 OeQwxH1dYNnpSOIujsio9mAaDwc+gaphtzq2LbJkAoBMFqGlB4ATGU9AiGE1MZEF5n49
 b+kQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780856375; x=1781461175; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L72D3G1nnbgdrbSBUmbwjVqOerSbEID158YQGvWU4/E=;
 b=XcyRRSezVgS25rakq9Ov3QG1Qu+N7nfg/mpncZ62fLwYfyeAJfFTcFTWHqzNtKIicW
 zEaefdnC3Ikg9G6bUhOFfAlKhu8+MoqDwfq9+bsSjbJSOVZTRUaPUJTvjw1IfaXQbzVE
 vGwAdhWk6a36j7AN9TdOZDzhCQXe7Tpyvf0jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780856375; x=1781461175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L72D3G1nnbgdrbSBUmbwjVqOerSbEID158YQGvWU4/E=;
 b=EAUKcQeRbKVyxHDg+m/ytp4sdglfX+mFX0mOlpfitbAX2vdIql4v2kdvFRdZaDxAOm
 mn6IQtH+Fbo9BEmXfFA+d9DHHML1IXT3+vIefbLL6lH/O8fk5fK5dKGnTHg26vpIryHI
 nhJDW27kFCmTsYkZLV8PQigI2qS+AnKG7eeo8EPLG3f4vmCftyDD6o+P9p3zyhTbKnRj
 09ZvfNIeMIv1US+WI7fDVjfKhcoYwYOBm1JlVgQ7kc8xyoqBUs/wJHMnbvlYzMQLDRvC
 gQ1co5xXJlbJXwuIpEWcPnbSICYJS0q7fLNOY9rhC5z8GjLLNM5e9t3xnxwGSnOQj7Np
 tCZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q2sDwtJUFQNAEkNWBHyuhkGiVkFnqiL55pSvCHmhtXIUSFBBm3zGHOfcAMu5Blfkj8OhaYPk=@lists.denx.de
X-Gm-Message-State: AOJu0YyE33lnYoMFFuu77LMYcDeaQFY7t81kjnPmBBtjfCqXPTqPTr4d
 wxQ0b0d2n6kc7o2EqdumWhVSAHPM6slPfLz56D6VGwb7nU0h09chTFqzTu2Uf7PuMvHXNgB2H7P
 UcyU6S6G8nhEtz2JX3Nn3NRjhHO2tMXeHrfvBbUUYDcvGO0xAhTQ=
X-Gm-Gg: Acq92OG3fcF70CuAxOw6mnTO9TMPioL5hatOAkrHsDGuQpFUYq9FpI5d9Apbm60jhmY
 /KTE1Ogp26mTjgsky6r19fmRAqkxpcSAYcCSOKMZMimNvnHVRUJWwgNwqfDo8fXIrdaMDGqBYlR
 uDIZIVWoGDzlmmGNH9/WWlhFscdLHcxYBJb31R9uq+fETXs6+ICzGhMw/gzzGPiIODWWRzePLlo
 8N1LDsKKeAAkI/jd6EiPpBKDAO4p/HyXzCaVK3Nmh/mRkCr6ptsv1kIRY+an8pmnX0YiV1MMqNF
 UkIvsH838fMxy6gc
X-Received: by 2002:a17:903:41c7:b0:2c1:77cd:fb0b with SMTP id
 d9443c01a7336-2c1e85e04bbmr135428485ad.37.1780856375374; Sun, 07 Jun 2026
 11:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-6-ilias.apalodimas@linaro.org>
In-Reply-To: <20260604073719.48723-6-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 7 Jun 2026 12:19:12 -0600
X-Gm-Features: AVVi8CcpM-ZnidO7oqnbs-Nzrv2Gk5SeIv683fsBlix5QjYmRsswXCAulxN4kaY
Message-ID: <CAFLszThLAkMcDnMurD639y_Cck-n4DkW7VOC+Xzy+k+Xk_ryzw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] common: Add an option to relocate on ram top
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ilias,

On 2026-06-04T07:37:05, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrot=
e:
> common: Add an option to relocate on ram top
>
> Right now we only relocate u-boot to the top of the first
> memory bank unless the board specific code overwrites it.
> This is problematic when loading big binaries as it
> fragments the contiguous memory space for no apparent reason.
>
> On certain platforms, it is currently not possible to relocate U-Boot
> above the 32bit boundary, due to various dependencies on content located
> below the 32bit boundary. One such example is ethernet, where the packet
> buffer built into U-Boot binary is placed below the 32bit boundary and
> allows loading of data via ethernet even above 32bit boundary due to
> memory copy from the packet buffer to the destination location.
>
> A previous patch moves the bi_dram[] info from bd to gd and make
> the memory bank information available early. So move the
> dram_init_banksize() INITCALL before the relocation address calculation
> and use it to derive the address.
>
> Also add a Kconfig option and allow the common code to relocate U-Boot
> [...]
>
> Kconfig          | 14 ++++++++++++++
>  common/board_f.c | 29 +++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)

I'm just a bit concerned about what this changes...see below.

> diff --git a/common/board_f.c b/common/board_f.c
> @@ -339,7 +344,24 @@ static int setup_ram_base(void)
>  static int setup_ram_config(void)
>  {
>       debug("Monitor len: %08x\n", gd->mon_len);
> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> +
> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> +             int i;
> +             phys_addr_t top;
> +
> +             gd->ram_size =3D 0;
> +             for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +                     top =3D get_mem_top(gd->dram[i].start, gd->dram[i].=
size,
> +                                       ALIGN(gd->mon_len, SZ_1M),
> +                                       (void *)gd->fdt_blob);
> +                     gd->ram_top =3D max(top, gd->ram_top);
> +                     gd->ram_size +=3D gd->dram[i].size;
> +             }
> +             gd->ram_top =3D board_get_usable_ram_top(gd->ram_size);
> +     } else {
> +             gd->ram_top =3D gd->ram_base + get_effective_memsize();
> +             gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);
> +     }
>       /*
>        * Subtract specified amount of memory to hide so that it won't
>        * get 'touched' at all by U-Boot. By fixing up gd->ram_size
> @@ -350,10 +372,9 @@ static int setup_ram_config(void)
>        * memory size from the SDRAM controller setup will have to
>        * get fixed.
>        */
> +#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
>       gd->ram_size -=3D CONFIG_SYS_MEM_TOP_HIDE;
>  #endif
> -     gd->ram_top =3D gd->ram_base + get_effective_memsize();
> -     gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);

This reorders SYS_MEM_TOP_HIDE relative to the ram_top calculation in
the non-RELOC_ADDR_TOP path. Previously gd->ram_size was reduced first
and get_effective_memsize() (which reads gd->ram_size) then yielded a
ram_top below the hidden region.

After this patch ram_top is computed from the full size and the
subtraction happens afterwards, so ram_top (and hence relocaddr) now
lands inside the region SYS_MEM_TOP_HIDE is meant to keep U-Boot out
of.

Quite a few defconfigs still set CONFIG_SYS_MEM_TOP_HIDE (e.g. odroid)
and look like they would regress here. Please keep the old ordering
for the else branch, or do the subtraction up front and feed the
reduced size to both branches.

> diff --git a/common/board_f.c b/common/board_f.c
> @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> +             gd->ram_top =3D board_get_usable_ram_top(gd->ram_size);
> +     } else {
> +             gd->ram_top =3D gd->ram_base + get_effective_memsize();
> +             gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);
> +     }

The total_size argument to board_get_usable_ram_top() has always been
gd->mon_len in tree =E2=80=94 that is what the ~40 board overrides expect
(they typically use it as the minimum headroom needed for the
relocated monitor). Passing gd->ram_size in the RELOC_ADDR_TOP path
silently changes the contract for any board that both overrides
board_get_usable_ram_top() and turns the new option on. I'd keep
mon_len here, or rename the parameter and check callers if this is
intended.

> diff --git a/common/board_f.c b/common/board_f.c
> @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> +                     top =3D get_mem_top(gd->dram[i].start, gd->dram[i].=
size,
> +                                       ALIGN(gd->mon_len, SZ_1M),
> +                                       (void *)gd->fdt_blob);

Perhaps a follow-up but we should be able to avoid the cast by making
the fdt argument const.

Regards,
Simon
