Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049D5D6AB09
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 20:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C3183D8A;
	Thu,  2 Apr 2026 22:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KbJEXU19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80BB083DC9; Thu,  2 Apr 2026 22:24:44 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8255980212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 22:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so207914566b.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 13:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775161482; cv=none;
 d=google.com; s=arc-20240605;
 b=i5Ej4wq5ZyEsSPmaOn3kXzKMMnquBuAh33NTwBtRDFizQ9qij2qiZFnELDiyBvkRMP
 VB7iWpA6/rHShJuzqcqAYreGA7CfuLbRwP/LNG7Kvq5howylsYCCtHTznqrBm75wGPH1
 rK4LIzPBMGOPl1Qlf3FN44B7LXrQ9qdB3f5OM0DVr3PkqHbD9W5qRTqgj4JERX8vuWdK
 zYguHUYONYobwPZP2Nqq3AybPSX+7o6bUp8XZ0wqa8rriDZ9plG7TC9Q9re0DECJAHke
 pCQu7DeK492kAz3jP18+ttU+44KXAKQ0STJ20ZgJ7cJu+fll6GHCsg/Lc6kqQe7ubjUP
 KXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A/IVzdy4KnUfxB8L61O3vChwtKLyw3gQPvNXVcR2uWc=;
 fh=OvkrsbZBeB/Exy9J8o1bIukOuopxQoc+fHCwVReHlG8=;
 b=JY0RdhW+W5UBA1j03HTFyKY4caDOQsXGiZbhDkHw5nXYizUgBQo7i3yP9IPqFwcrG8
 mgW5BrN4K5B9msxgimwAs1/XEXm4YfDpiypCxXVb2VFjFoQBB+iQ1ivoa7FjPxvkwKwt
 Mi045mdd73/mj/zdhC3BIufn0koJObHxqIG1dcNV5/1Hznfqr8CvPlWrjtnSSaZrR6/S
 PXWkYU3s2g82H7bMEZ+l6conmHVZYhSwb4BpnpfG/iJcSKw9WOyIbcP5+cKQuxDR5pgI
 AN4TAA2+k2IrvjmvmsiF9ScjWSWjDenyXPwSSVCxKpJmLvXC7+aWJ++VeTSDULIwq0uf
 RdWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775161482; x=1775766282; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A/IVzdy4KnUfxB8L61O3vChwtKLyw3gQPvNXVcR2uWc=;
 b=KbJEXU19STxN/L70hTeVYDjHZiJGxhwFd0Ct39Jzy6ZgcCfJ7qtx+klAZoJMIIH3BJ
 xz2nkE0Rz5tNDGfR8w97+EB9BCHPSCnEqszhcAY1BnnRCwg/alDGPOH8KOYm729I9u14
 TsEw1CnwuxxdQwr7oFQm840v6Qily748rvvEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775161482; x=1775766282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/IVzdy4KnUfxB8L61O3vChwtKLyw3gQPvNXVcR2uWc=;
 b=a6Sr7GyPEuIrkD7RYAJWAUw4cH5mfPtNE3UuHaGRlI30TjD/ITTcgYhci89gSHT9tR
 M+F4yH7kkvLPQjljgVAq/gM4LAYhl2SFilSYbYtsZJ6OJIWA8hrdtU6HvjPa962kdSEB
 u0r74D7cy5LUS01Am/M1IGr+147hsoZkAfR1LZVakn87DIv+NAbBvKsQL7E8YLJDV1bd
 TEatO/oetfHnpsZ4mi+qVhMtO2mob80mu4XzkxaCjJfe6OGszoWq8MZCvQ6sbP3gBa8Q
 bm45XOt/8buMPMay+FrraJ2S1elC2tcIwl9y/SC0LbU+5FPc4FzE4Zs2hDa5dTZQ8orY
 YsvQ==
X-Gm-Message-State: AOJu0YxvbOaII26o5Bw7QE9omM6aN6s700KXc1dstXNADotIzVrhh78A
 nke1OyAPM/4wenbteLN143LKW0hoyw+aVPVWyqcjd1iwX/YAJnqqoUlIL7L4I2wsVmm1wjnN6aO
 qHGebLV3+P1+sccl/j4smTaHEq5+5hrueXTil5iFW
X-Gm-Gg: AeBDieszWFqfzgRFEgpc44pNK5qfrMC2eiJWW6fOshGe2KeApwAabqxhLdkhypEI8Lx
 LXMDRv6goG0BTADDeoB0bBpl3GACQBCN0iXxiie6Hf3SrnHbseGMnpsT9nSULghziOc+nvHnHpO
 fM6vnuDQaI09ZKdDxhGEJBzWi5KODCwIWfSa3oIT7JiMZGtu2j9m4JxeeHD9vJG517lwPBfp+EI
 vc1taXaEeYWrmLIO4k5wQxywr5BvvQnhwhT6L+G1ekOBlMqAd9tMi/+NSeCTt0sP7q44bllx4O9
 zWcCiA==
X-Received: by 2002:a17:907:3f90:b0:b96:d904:9616 with SMTP id
 a640c23a62f3a-b9c679f0458mr13694166b.40.1775161481664; Thu, 02 Apr 2026
 13:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260323083928.1928856-1-ravi@prevas.dk>
In-Reply-To: <20260323083928.1928856-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 14:24:28 -0600
X-Gm-Features: AQROBzBrV1PpswE_btYkEbiYB1NqUqBFuztBj5yDC2SHUkg1jV1uXjRLtLnrjfc
Message-ID: <CAFLszTjR7sAcgDH_bOZ-zV42PESY9vhe3PRDGeHKXnvOfJk6jw@mail.gmail.com>
Subject: Re: [PATCH] linker_lists.h: drop never used ll_start, ll_end macros
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
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

On 2026-03-23T08:39:28, Rasmus Villemoes <ravi@prevas.dk> wrote:
> linker_lists.h: drop never used ll_start, ll_end macros
> linker_lists.h: drop never used ll_start, ll_end macros
>
> These macros have AFAICT never been used at all. It's also far from
> clear what purpose it could serve - for one thing, what _type would
> one pass, other than void perhaps? The example using "struct
> my_sub_cmd" seems misplaced, as how could one know that the first
> linker list consists of those, and moreover, how would one know how
> many there are?
>
> The linker list concept is fragile enough on its own, there is no need
> to have unused functionality lying around that may or may not bitrot
> and certainly will confuse readers of linker_lists.h.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> include/linker_lists.h | 50 --------------------------------------------------
>  1 file changed, 50 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
