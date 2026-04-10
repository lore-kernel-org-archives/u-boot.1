Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69795F36BAA
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 05:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0432383DC9;
	Fri, 10 Apr 2026 07:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D1MW3XYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E56AE84120; Fri, 10 Apr 2026 07:21:45 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D648416F
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 07:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6501547d7edso1798455d50.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 22:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775798502; cv=none;
 d=google.com; s=arc-20240605;
 b=fpLkOzZEru82jZAThdnmZ0KlQQU1PnPtoZ+wrTXDeRD7XFhEZTCu5oKC/KbP4oigK1
 DzNikEJhwrFe3zX/JDR+80f7lTAPgJjyu7IOC8BxMd/jZccAbq8sfjY0AMlyGQseJpMM
 8HHRCvjfFbmAGziGNBbEtfbNpCJB3UDd5wuFxNgMd1gxhN3QBToE1vU+RdI1v+EW1dN3
 1aIMniTOI16v5IZdvDBSYT7U2Gfb0A2vlLdaTEHuNjQpNYOAC5bEQIXoSARa4mg4nEal
 vh0syEOH1OafTLBziXUbX3KRhYgQSUIbeOBJcopxGsP1B0WfcOvW2BhV/OQ46zI8w/S2
 qtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rMzunL8HE2XVTpSz1MxGo6s0HNe6D7ba/sKiTM960RU=;
 fh=hLmPBTHaEnf80OfkARA/pwNotZ+wHmOIjI3a2+MIzUA=;
 b=Ym+RVCMLbS4dFB7gnJo87UdxBvch2SUfdz2kGhdSabixHa4uCSPbYcPF4FrbpdYmJl
 SPB1G3gT4iCU3nnb8/Lzq42tNrwYOkBhflMhFY8lNh/TcQHSWvvy2eQFrmYaQH0hjvBm
 NtgzSTxkucAx6HKexQvaE1lbMIxuRDu3HV4JQDIasOZjLqS8BhbQowwEx6Xh1t2Ts93b
 ZqH/ycNCjsf7uv9PxSxeKU/nichtMrGxUt+Ogz7sajlzUfW15IVbgsZbHiEjYbjMolrk
 qQCDL04bu+NSEGzaNwpMf+44F45/BQm+RCAxvwg7m+1P9NVG158vinKNBd3pjEC+7aMi
 KXnA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775798502; x=1776403302; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rMzunL8HE2XVTpSz1MxGo6s0HNe6D7ba/sKiTM960RU=;
 b=D1MW3XYIVTeZy4fYHagKhk27Jo6XicSp+mWazrqtY9pkVOQXcZuj2SCtw5Imsl7phA
 knEBh+Aq5bvIL0TnVXqKYTSTRc/0IR+k6furOGkNos4tqQQAMlvewV9hdHLDtkzth/6H
 poJsxPLcaWVw8DrKVNbXk+VkUkqEbxgAaxGVAJHC834c/WE0Q9F35VKzs41H0e+HEVL5
 CXD64Z+BUUDEx2sJ7fc8G66URoL7mfh0YbsdPqlQ63ngv7rV5XKmU+RTf7P8VfwoGWV0
 xkIBgkLlIrTHWLXDFdP+6ndahR2y3JXgfpXYYz7xhxwtvk/cpPDukrn3FBRq4m+3MvFB
 iZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775798502; x=1776403302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMzunL8HE2XVTpSz1MxGo6s0HNe6D7ba/sKiTM960RU=;
 b=YY6Yw8mGlYGqJR56wgxlrgNfkMFpPGv9aRpCXi/qCVLT63Pwh2qR9fj8plROK+zTGo
 xxcNnKtQaKIAosYG2Ju6wP0hsZy6G+tuk7qgOC3SmFXvqaFWso/+YriV9Vv2uLY0I6FP
 k5iTyU9rZ/Q/eveFnaD2zZCJtaRGkwTgXs9ZQZ4e8fimvn6E1R92DgEdjmtnYv7utnF+
 k+AmE6W5hp2j8ztv82IWfDXMtYLVPOlMca9FvE44WA3mWOMZ85RZ8SRCKoALA7GcvG/g
 1eX1EhaJgW6P0OC7Mr5N6ICPtKFZnZ0xMAaRY56up4TSox7Hd+53nISnFgmAfSK0Nho7
 rzMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMvRr6MZMGpOPiB3U2mR0Rv7NQGMnhgBY6+u62PpL8TBrGqcMhyotrl+LBQJugqLoh4NHtlEI=@lists.denx.de
X-Gm-Message-State: AOJu0YwLgyi0UTpmtoARCfY03KIRUJW0132UsqO6TytGIV6NRz0LQEbc
 7iMH93nwqKz+szETGCCgLOHGPVET3bLXXbnOcyVWXFKq+3wSeAAEjNP9kc7MpBG/5YSdkZ5pAZp
 ByTPqikZKdl4L4cDK/c5DFEXD4KeM9mAleqFsgDAkja83aKtzrs4Sg/0=
X-Gm-Gg: AeBDieu8XxyC1BgdsJmq6rRUYLO7V7WCn2Oaj+ArEFQvIaBmVIXBVpJdG2kwioMetGg
 +nfFYNWgtmTChmyEXbYFQulm4pbtPcu4T9ZnKsY4xXbTgKcAYLLjN82GBAi22FRDeK8DLJ1MgVz
 20CmwVvaIcqZujc4pEhcKheVZGt1tpf9UgkabCev0OiPgx4QDP6kXnCjPtGfe3JE7hFi+/mEJPl
 tNlp+dCjJuO2dph1Gu+acUBz088zioncf6x5pLmBQV0mUYN3BODYQ/5QmePh3WVPPp6xHvCTDFp
 gN9dA+rjYCIKDkoa7D6e7V7v/d5vU95j4mdsgtFkpBqYThFoJmES4vRzMbXKulltwvwTM4fw3l0
 AME1qYsbuqSa5U/EFYzIVV/t973iYZWO/OIalnyEIfoQLMbg/ZsHbOwDcrtxyy7DCVMa1hzgDBa
 vkpk5p7vy802VUfb59q+3jB5PJDCx2Ozlr5WPknnXR/IQrsWBodiij4dDnE5KHZ+N7dnpQuLRCR
 rkEj1RA7iQ/YH3O0hbFL68Ncr0AQEADK8Oqgal3dqI/fU+uPFuQfY/7u1u0gP5VIakv1wHdFWFu
 GtkTtz8JLg1oMboXzdb8gVzu3uybZycSwsfksRulUgM=
X-Received: by 2002:a05:690e:190d:b0:650:1aa5:8594 with SMTP id
 956f58d0204a3-65198bb02fdmr1732214d50.49.1775798502509; Thu, 09 Apr 2026
 22:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
 <CAFLszThg53tcrR7TDsk-de7e-7ZbcLixkij3QQW5m8Fmgy1Pmg@mail.gmail.com>
In-Reply-To: <CAFLszThg53tcrR7TDsk-de7e-7ZbcLixkij3QQW5m8Fmgy1Pmg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Apr 2026 08:21:06 +0300
X-Gm-Features: AQROBzBm15yNgPk8GpUB72wqbFNpVxHS1QEjTRnr1uZJPhiJdX_iWST0nk9cuVI
Message-ID: <CAC_iWj+YhWqN138Bik+yNWZ_t3KOhy6ag_J_fDePHyOMqi0OMA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] common: Add an optionto relocate on ram top
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

Hi Simon

[...]

> >
> > Also add a Kconfig option and allow the common code to relocate U-Boot
> > [...]
>
> > diff --git a/Kconfig b/Kconfig
> > @@ -491,6 +491,14 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
> > +config RELOC_ADDR_TOP
> > +     bool "Relocate to the topmost memory address"
> > +     help
> > +       When U-Boot relocates, it chooses the end of the first memory bank.
>
> Adding an explicit "depends on EXPERT" would be clearer, even though
> the surrounding menu structure implies it.

Fair enough, in the future we might not even need since I plan to fix
the 32 bit DMA issue.
Ideally we want this to be the default.

> Please can you add a
> warning in the help text that this should only be used if all devices
> can DMA to high memory?
>

Sure

> > diff --git a/common/board_f.c b/common/board_f.c
> > @@ -353,8 +357,19 @@ static int setup_ram_config(void)
> > +#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
> > +     for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > +             if (gd->ram_top <= gd->bi_dram[bank].start)
> > +                     gd->ram_top = gd->bi_dram[bank].start +
> > +                                     gd->bi_dram[bank].size;
> > +             total_size += gd->bi_dram[bank].size;
> > +     }
> > +
> > +     gd->ram_size = total_size;
> > +#else
> > +     gd->ram_top = gd->ram_base + get_effective_memsize();
> > +     gd->ram_top = board_get_usable_ram_top(gd->mon_len);
> > +#endif
>
> The RELOC_ADDR_TOP path does not call board_get_usable_ram_top()
>
> Some boards override this to keep ram_top below 4 GiB for DMA reasons
> (see arch/arm/mach-tegra/board2.c). Bypassing it means those
> constraints are silently ignored. Should board_get_usable_ram_top() be
> called after the loop?

I plan to fix the 32bit DMA. Calling board_get_usable_ram_top()
basically behaves as if RELOC_ADDR_TOP was not selected. So I prefer
leaving it as is. The commit message also hints about the fact that
board_get_usable_ram_top() will be skipped. If it's unclear I'd rather
tweak the Kconfig description.

Thanks
/Ilias
>
> Regards,
> Simon
