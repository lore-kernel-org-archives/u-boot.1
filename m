Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260B5FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE5D846EC;
	Wed, 29 Apr 2026 08:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ynLHZxvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6104846F2; Wed, 29 Apr 2026 08:13:30 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AED8846EA
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79ab3e26cceso114135937b3.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 23:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777443207; cv=none;
 d=google.com; s=arc-20240605;
 b=HSdZBN5kYtkDBo8e44tVkSWf+zhGH6+kWwd++r8nfKyxv0lIGg5hClq2o4j7GatgdI
 znNaMK8aQFQyW3KxMAecT+ka9iGg7Glh2RXSA93BzL/KSAurhzK9/Eq0FdAbkB8maQZ4
 1XcZAOBW96yBm0k70V5gUdi2Kp3icmOVchIt2/h6hJwc9PUF5SRN+8SRfcFUlnJ7c/G1
 QuTlj3DviCqrWQ/JgvCfbA0ppJ3dzxcmekm47N4wrjMyXAYccg7r53K5/DO0kBeVCWz8
 d4HxqzIoUsbVwy1QB/q7isQD4+ML1JIWjafyB7BY/YHo9Tvf7ToLSmNCeurl34Rh7DVM
 /OXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2bCOir8IqyCRi6eKxnYCzqHeFUC2II8rDv2IwBMXY2c=;
 fh=swnq02U0yjRZV0Ti2weiEBTikZRbUBIOgunT1kmShFE=;
 b=fMW968Omrqlc8fMX5V4hlYuAxyWKKO+6/WZOvQ1+dtHstyXh+WCmZ3kkU7kaDgCW+n
 CHWSCyTqwApj9qKyW1Zrv8YvS3Orf3jsQ9xc65zVL5s0FijnT0fjqgkf5Vrgh/oIz/dp
 4xm40M0lnTvyUNqEl6dfb2R415BPbq1yXZA0bX+i3oalEtZVeCISgPEqpyhOg8se/Aph
 S8auxrp4u9T8t2PWlMwH1ZuquAx8GOHgR/jTKIdLhwdp8OY/M4gOcS0WE2kSXiMGm2+S
 xek49yfnpI+XprgfxieIBmtRuf2kWSNiA0FEoyA6bE6QNYfoklN1OMEgBxGNc+Vm9Rnj
 nyYg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777443207; x=1778048007; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2bCOir8IqyCRi6eKxnYCzqHeFUC2II8rDv2IwBMXY2c=;
 b=ynLHZxvxY6+yHp9VyRVBuiOkF8F0VcRE2WoHi8Z+38aOyopWMRxRoS8il9xrrpgyZz
 5rvKolhBgy4dUSr2HX8Vjon7Fl/E7OXsPOEZlbLNOyX9IItmeh+1xmtLMUclR6QVO7+G
 8r83t6+PduDQVhWJGSkKgQ5iIt3h7CFfU+RhqR2NVY8OmNaNzMUwC6Yp+FqWN4GE4wjo
 1NeFCDpK7wKiPaHP0+SYUCiu8SRqAnc4rZmRXmPHuurLjhGxo7e/fVUeUo/crXVnk6qy
 gZU2enyQne77rLHAGINFPyMdbhwZwKIeHrzItr+W4crw5N3dB306p1XwGSkuYGnahO6G
 00PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777443207; x=1778048007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bCOir8IqyCRi6eKxnYCzqHeFUC2II8rDv2IwBMXY2c=;
 b=OFRWDZI8tHFIkW+OHvwZfH3026sa3W02lfyuCzgrI+40wdvmXsQqx5Vtenl4pMGVt5
 fajyxb6Bj1LBnZg+VvNpTqzqI8kEg3ZE/D28Xn0ww1frrwFXQ24uqjb4fZKKKgff/CTL
 Usme4ewwYidvyoXoil/NVLuJqm3a/VrEwqHQrL6LaQGB5aVS65VX/bx3JJRpWg7k9MgO
 +HRX1KsZJvF3Hps0qyW6NmBwY9yppJteCLjCBPduVtv3dHYw3jaWZQmL9fz7Am9oFm6J
 i/KB0jq4PfGOdwguMAX1GtGGPN6y5rNQspPWdU8k0+h7bXiE0vjITgTtXu2xrv5KPBpb
 kpUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BoRUX6/Ds0we0yG89UM6wXlem+g8/kXyJMmPnYAl+9GsAhRoGgFJY1CSVWsmVBx25/1qX8DQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7FVDxoTC/9g1rixN7zj6/qklm0kdWWpfZkXUR8B6Krek9mn9Q
 12ciJHEm+sEjLNLjiffCclmi0UWV8L40OMewrZG9TxD5RcjNEtiC8aX8UZc+aJw4ipmATwEbxYx
 QzYT4T6ceB1E8GtsD13o6qiI4rDv2SvLhJy+wsUcNqhId5VhAphQ6
X-Gm-Gg: AeBDietiaifDp30Gg8sSDqRZ/YKeoy3zjFfwu7vmGevJtdJLHIH7US6W/C3l0PLANqN
 PU9++Gl75M0b3uBBURKo1yB9JcOoApP7bGNjqLPRRDra62TsuUa7y3gHXIqdUZgdVGpDAF9zD9b
 UuqmmZh1hKLt23XQ3EnSLUpoP3SrCTVftdudjvXgcEJ8UmM7FYVrKa7nqcYrYpTi6meb99SgT/N
 sJyq2ofDhWJNaBmJeCQkKzrAYLqvncvRZoAnE+tjAodSDJiFLtTmnYwJt9vMzYlNbLMih8otx1R
 dF3C3vLDFXFNJCx9HJyqpI0EkGwoAa+6/xJxZA4YOoDNd0k6rPfKalu5LmiKM5uIM0se656Wri1
 ODkuCD67p3680U2vpbsBfZO9f0LbSTZp7egN+q9ToU7R6RcTvKZxT6Ilnb4UkDpgk+krZXG1bje
 CS5Bt7FsKEalMsZZObVqg1fRf0YsQB2ROL3zaQJeLynFZ0iSbB5tgHmPgzpE2Iy3jm6dhlE0qKp
 ZsELHvxEUJub/JLc/vUw1+1X/rs8c9ZSvnfAkrXtmebpXnKfwz5Pg9W5mWDCvBkQwYVzR6rquIK
 KxOXGfx664p96pTel8c3xVk+cLhReGZRtcaaHLtVHVA9zPHmcY8OwrusvmiUrPAIGQYaMVnogsk
 24K4dGDDOdO9qQJDx
X-Received: by 2002:a53:d341:0:b0:657:e42c:f25 with SMTP id
 956f58d0204a3-65bfb70637bmr1870881d50.49.1777443206764; Tue, 28 Apr 2026
 23:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
 <20260427100832.581887-7-ilias.apalodimas@linaro.org>
 <CAFLszThyTj9FKQrWHkegH8hrbpca=Jf4ZY04V8yRTNyuGFGM-A@mail.gmail.com>
In-Reply-To: <CAFLszThyTj9FKQrWHkegH8hrbpca=Jf4ZY04V8yRTNyuGFGM-A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Apr 2026 09:12:50 +0300
X-Gm-Features: AVHnY4JGkwyOjROKGqkOK0SXMyT_iQleu1G7HUqquK6tqwJhdKXTZtnjpPJw4rg
Message-ID: <CAC_iWjKE5VgR-HhWLqV6mtQeyVcP_+iRa-SpcwR27i73Beg2Bg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] common: Add an option to relocate on ram top
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, u-boot@lists.denx.de
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

Hi Simon,

On Tue, 28 Apr 2026 at 20:49, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On 2026-04-27T10:08:21, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > common: Add an option to relocate on ram top
> >
> > Right now we only relocate u-boot to the top of the first
> > memory bank unless the board specific code overwrites it.
> > This is problematic when loading big binaries as it
> > fragments the contiguous memory space for no apparent reason.
> >
> > On certain platforms, it is currently not possible to relocate U-Boot
> > above the 32bit boundary, due to various dependencies on content located
> > below the 32bit boundary. One such example is ethernet, where the packet
> > buffer built into U-Boot binary is placed below the 32bit boundary and
> > allows loading of data via ethernet even above 32bit boundary due to
> > memory copy from the packet buffer to the destination location.
> >
> > A previous patch moves the bi_dram[] info from bd to gd and make
> > the memory bank information available early. So move the
> > dram_init_banksize() INITCALL before the relocation address calculation
> > and use it to derive the address.
> >
> > Also add a Kconfig option and allow the common code to relocate U-Boot
> > [...]
> >
> > Kconfig          | 12 ++++++++++++
> >  common/board_f.c | 32 ++++++++++++++++++++++++++------
> >  2 files changed, 38 insertions(+), 6 deletions(-)
>
> > diff --git a/Kconfig b/Kconfig
> > @@ -491,6 +491,18 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
> > +config RELOC_ADDR_TOP
> > +     bool "Relocate to the topmost memory address"
> > +     depends on EXPERT
> > +     help
> > +       When U-Boot relocates, it chooses the end of the first memory bank.
> > +       Enable this if you have multiple banks and want U-Boot to relocate
> > +       to the topmost memory address. This will use the information of the
> > +       board memory banks configured with dram_init_banksize() to calculate
> > +       the relocation address.
> > +       Use this if you are certain all of the devices can access memory
> > +       above the 32bit boundary.
>
> The help text mentions the 32-bit boundary as the hazard but never
> explains why. Please spell out the DMA aspect, e.g. something like
> 'devices that can only DMA below 4GiB will misbehave because their
> buffers may be allocated above the 32-bit boundary after relocation'
>
> > diff --git a/common/board_f.c b/common/board_f.c
> > @@ -339,7 +340,28 @@ static int setup_ram_base(void)
> > +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> > +             int bank;
> > +             phys_size_t total_size = 0;
> > +             phys_addr_t top;
> > +
> > +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > +                     if (gd->ram_top <= gd->dram[bank].start)
> > +                             gd->ram_top = gd->dram[bank].start +
> > +                                             gd->dram[bank].size;
> > +                     total_size += gd->dram[bank].size;
> > +             }
> > +             gd->ram_size = total_size;
> > +
> > +             top = get_mem_top(gd->ram_base, gd->ram_size, 0, (void *)gd->fdt_blob);
> > +             if (top)
> > +                     gd->ram_top = top;
>
> A few things to figure out here:
>
> First, the loop only updates ram_top when gd->ram_top <=
> gd->dram[bank].start - that assumes banks are populated in ascending
> order of start address. Is that, guaranteed?

I did have the same concern and as far as I looked they were populated
in ascending order.

> If so, we should indicate
> this somewhere. Or maybe use gd->ram_top = max(gd->ram_top,
> gd->dram[bank].start + gd->dram[bank].size) ?

The latter. I think it's fine for now but relying on that assumption
is dangerous. I'll just switch to max(...)

>
> Second, summing gd->dram[bank].size into total_size and then calling
> get_mem_top(gd->ram_base, gd->ram_size, 0, ...) presents the banks as
> a single contiguous region from ram_base of length total_size, but if
> the banks are not contiguous (the main motivation for this feature?),
> holes between banks are now treated as usable RAM.
>  See common/memtop.c
> - get_mem_top() does a single add_mem_region(&free_mem, ram_start,
> ram_size)

It does, and in the general case that won't be a problem. It will be
however if you have two non-contiguous banks and the DT somehow
reserves the second bank. You might end up relocating on a
non-existent address.

>
> Third, the cover letter says "Use get_mem_top() instead ... That
> function will account for the reserved memory regions and exclude
> them". It does not seem to do that here. With size=0, find_ram_top()
> computes base = rgnbase + rgnsize - size (the byte past the last RAM
> byte) and region_overlap_check() with size=0 reduces to whether
> rgnbase_res < base && base <= r_end, which is false for every reserved
> region within the RAM extent. The call ends up being a no-op for
> reserved-memory exclusion, i.e. gd->ram_top ends up at the very end of
> the topmost bank regardless of /reserved-memory or /memreserve. For
> exclusion you need a non-zero size - see board/xilinx/common/board.c
> for example.

Yep good catch, thanks.

>
> Lastly (as Marek mentioned) this path skips board_get_usable_ram_top()
> entirely. Boards that override it to carve off secure-world regions,
> framebuffer etc. will have those silently ignored when RELOC_ADDR_TOP
> is enabled. After a bit more thought, we really should support it,
> e.g. look at board_get_usable_ram_top() and only override if it
> returns the unmodified value. Or perhaps change its function signature
> so it returns an error code indicating whether anything changed.

Yea, I'll add that. I just wanted to verify we got a usecase we
actually need it.

Thanks
/Ilias
>
> Regards,
> Simon
