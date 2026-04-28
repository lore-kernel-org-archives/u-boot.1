Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C725FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 17:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A05845E3;
	Tue, 28 Apr 2026 19:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hUYuixzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027A78460E; Tue, 28 Apr 2026 19:49:03 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFEA1845C8
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 19:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba51e69988aso1600372466b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777398539; cv=none;
 d=google.com; s=arc-20240605;
 b=PvnfKMEV8KWAOmDBp5gMHERGN8EUQQFwXqupuM106uOZxymCMCPcOEx1YM8AQr8TxI
 0N9MHd/lH0ysd4fSSsP9dKanIPtxdcfER6gHwcS1XIcj2V92QqZPdMUfNIQuqjGXz7Yl
 JKNGV5vEjRN1V+7zNK1lxe/hgz0kApnNB2kxFTOJeB0sM4lFruamC9Sbs+ywpKNZO2mk
 Le463ZJN3p+tg23x9ne+S7xqUZCgecZB7NmmERvVXCnhkOZDj6oxpdWsroX4j71hdTRU
 5JVYf6Tav1Fp9XsKCTspKPTNZdxnEohy7OCqIN+/J7qsl5uLgfUh6Oejy5A0n4hWicor
 Deqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XYrqYE/OWNLExYq5rzq4iK9feJcUNno4vgBQa7tvaJI=;
 fh=PHYpmq63auI3PadAP5qlNh68HzX/hvBt3gD/xOLyMGY=;
 b=QbBaYj1CRI7q/21gBdLYpblT8i7XXb2Rgr/ducmQOvqZLdl+ztA0Sv6nmhjS628FCE
 IzXOh9Dnk93FXvEqg0Iw63z4xeeuHfvACUw5lNCaIbSE19JXYurKFIJcCNgoZWU2S6Kx
 pV85ifFx8tCUGw97fqTmi8wr4SEjcApVim+5I/cRQ1SvhQuwUPeA6o1FUuE8Og+iUUNG
 XsvSv97GmmQhafU9GiMDz+jDwssZSRqI2hHxoMv4xDj4+5T4wDIpv4bxMD2odCvnacyF
 o59iC0b27xU2rspXw5a0BClVi9IOsZq9BnkvQOAbN/5qugY8udiFYpsIFpjOFEUjhxxZ
 RAbA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777398539; x=1778003339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XYrqYE/OWNLExYq5rzq4iK9feJcUNno4vgBQa7tvaJI=;
 b=hUYuixzcIRNOfg0yGQmJ9k1770cGbld6Rte9Xa21sR+uRyFYxauYi0ctWA7FbqtJ98
 ZL/Jqrf0+m5J9eGjRAo06pAwc5dKrfKP8FTufLrtF16FQ1ak0vBjJH3U1jT8NVBXUtoF
 O9Jk0lCndYCUS1bDF7cnUJQLFkzge9fu5V340=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777398539; x=1778003339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYrqYE/OWNLExYq5rzq4iK9feJcUNno4vgBQa7tvaJI=;
 b=oaWEnM/m6iP5fgPy9uotE1tmnb/UlYjI8NUerr0PuEKw/bBAHIvhB9i9ZzTQzKhEu5
 L7e/cFGVduQSTHSH+eq4p6MwdMXvwwLi58N33juX7UDDBH6D43h2625bWFJe5EOWZb/P
 B8ZKazwrn0BNgN1FTHFzbvCF8aZjPjrKBKeMlfBpIM1HZyhnftrhpDOSHPLnDqJrSOqY
 Qz61T3KYLRojjug7OcEU6clbFex6uPs84AhiPxpyNtiApYFsx+PijXReEGv+nRNAmEjD
 gFRphDqDNbwSfAeJKfn8m0ANLtZWEeqpho97QmNd1QHv4IoIpAkZkztaCSL9pwzTSi7V
 tUIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yTu8LKavfs0eKP6I78qwXMsrVuDFhL185SSQruG0S4/poGGULr68owIusCaxLb1Atw7+Rw6Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwiWWzr0dcIpixEAAYHPJgCYsTBAEy1SovXEXd0UG9t4JbSbMQD
 Kw04D1Lsg7RvtHYHE1e14PxYPlTfKDkoI/siMQaWGLEPxK9fZ5MmpaCrlpmUd5oX2kaQO1PPClF
 dzdIUEbvWQoZKEl/KZR3q6TxmYB4tn5ZMLWwn+EKN
X-Gm-Gg: AeBDievHR+9Fh5mz163QZq22MIUEpMo87yW666aZxFBbTO6x+UcMSPBVVji0VCkR31J
 DaneBldWmqzqUO8K4dlfyxNTei3Tz+muJd8VXC27t9kZEm0eX5QvllwtzvJ9paJ8BjNuJ8UUrpe
 NSNCqxtUZO9WXFkSyCgkrCi5OUoJQuZdUNBSGElJMakj6zH7oMs4K7P1wyugKjGNMdWApvvaBLV
 CUtms2OZlig/ZOLmu+q//TsK9aAuQHhdBtEiGlDMTdsUYy++pakeRVahZCoTN3uCPaYkJJuZxm5
 EEU8JOdwPO2Cq+9L
X-Received: by 2002:a17:906:f598:b0:ba8:28de:697 with SMTP id
 a640c23a62f3a-bb801dd5b2emr263888666b.9.1777398539148; Tue, 28 Apr 2026
 10:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
 <20260427100832.581887-7-ilias.apalodimas@linaro.org>
In-Reply-To: <20260427100832.581887-7-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 11:48:47 -0600
X-Gm-Features: AVHnY4K16IyFiNC-_45aVJpV-LyWEfBzWuC0OWCM6WRx_Bn8ubaKmm3Is7ZM17M
Message-ID: <CAFLszThyTj9FKQrWHkegH8hrbpca=Jf4ZY04V8yRTNyuGFGM-A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] common: Add an option to relocate on ram top
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Ilias,

On 2026-04-27T10:08:21, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
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
> Kconfig          | 12 ++++++++++++
>  common/board_f.c | 32 ++++++++++++++++++++++++++------
>  2 files changed, 38 insertions(+), 6 deletions(-)

> diff --git a/Kconfig b/Kconfig
> @@ -491,6 +491,18 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
> +config RELOC_ADDR_TOP
> +     bool "Relocate to the topmost memory address"
> +     depends on EXPERT
> +     help
> +       When U-Boot relocates, it chooses the end of the first memory bank.
> +       Enable this if you have multiple banks and want U-Boot to relocate
> +       to the topmost memory address. This will use the information of the
> +       board memory banks configured with dram_init_banksize() to calculate
> +       the relocation address.
> +       Use this if you are certain all of the devices can access memory
> +       above the 32bit boundary.

The help text mentions the 32-bit boundary as the hazard but never
explains why. Please spell out the DMA aspect, e.g. something like
'devices that can only DMA below 4GiB will misbehave because their
buffers may be allocated above the 32-bit boundary after relocation'

> diff --git a/common/board_f.c b/common/board_f.c
> @@ -339,7 +340,28 @@ static int setup_ram_base(void)
> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> +             int bank;
> +             phys_size_t total_size = 0;
> +             phys_addr_t top;
> +
> +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +                     if (gd->ram_top <= gd->dram[bank].start)
> +                             gd->ram_top = gd->dram[bank].start +
> +                                             gd->dram[bank].size;
> +                     total_size += gd->dram[bank].size;
> +             }
> +             gd->ram_size = total_size;
> +
> +             top = get_mem_top(gd->ram_base, gd->ram_size, 0, (void *)gd->fdt_blob);
> +             if (top)
> +                     gd->ram_top = top;

A few things to figure out here:

First, the loop only updates ram_top when gd->ram_top <=
gd->dram[bank].start - that assumes banks are populated in ascending
order of start address. Is that, guaranteed? If so, we should indicate
this somewhere. Or maybe use gd->ram_top = max(gd->ram_top,
gd->dram[bank].start + gd->dram[bank].size) ?

Second, summing gd->dram[bank].size into total_size and then calling
get_mem_top(gd->ram_base, gd->ram_size, 0, ...) presents the banks as
a single contiguous region from ram_base of length total_size, but if
the banks are not contiguous (the main motivation for this feature?),
holes between banks are now treated as usable RAM. See common/memtop.c
- get_mem_top() does a single add_mem_region(&free_mem, ram_start,
ram_size)

Third, the cover letter says "Use get_mem_top() instead ... That
function will account for the reserved memory regions and exclude
them". It does not seem to do that here. With size=0, find_ram_top()
computes base = rgnbase + rgnsize - size (the byte past the last RAM
byte) and region_overlap_check() with size=0 reduces to whether
rgnbase_res < base && base <= r_end, which is false for every reserved
region within the RAM extent. The call ends up being a no-op for
reserved-memory exclusion, i.e. gd->ram_top ends up at the very end of
the topmost bank regardless of /reserved-memory or /memreserve. For
exclusion you need a non-zero size - see board/xilinx/common/board.c
for example.

Lastly (as Marek mentioned) this path skips board_get_usable_ram_top()
entirely. Boards that override it to carve off secure-world regions,
framebuffer etc. will have those silently ignored when RELOC_ADDR_TOP
is enabled. After a bit more thought, we really should support it,
e.g. look at board_get_usable_ram_top() and only override if it
returns the unmodified value. Or perhaps change its function signature
so it returns an error code indicating whether anything changed.

Regards,
Simon
