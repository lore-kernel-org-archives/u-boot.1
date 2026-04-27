Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76266FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 06:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BF180433;
	Mon, 27 Apr 2026 08:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JQmdZ6mM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C22183693; Mon, 27 Apr 2026 08:21:33 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCD080077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 08:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-656d749109cso1122915d50.3
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 23:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777270888; cv=none;
 d=google.com; s=arc-20240605;
 b=JDL2UxB884aTPRHnw18qLAKFs7VICSJdkxs8TYw8Nblq/p5CtwAPRUdb3tt4huU6/w
 9c/I1A5VK7DMd0nn3bvbUB6BLVrq4VGsgJONGicdSwDR0PAbgZQxN50i+O/ul3m1RDrS
 9DGa5QzDgJ4L5XqRdgMUTeoHBqtVT3txyYktN+FGfcn6eyZfQoXNvgqk2LvBDiyO8Myp
 mocjNQ7hTWux1uw/vgYfbXoapd5jfU5G0MZjRpsFvpjGUeDFiNQiPuO56+XxayfiAYep
 AMMUnrJYI434MeP5E5c/Ru2Y9EV2vJT1YvRFrSnf/4OA0C4+TyrJ/GRC+xJ7MJEv33D4
 fIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WBEy0yibVSgfkxKZVuaLnGBDMKFaSP3r4PBqiOv/S0s=;
 fh=K6enBat9UrJALC3ipcbY3vo5VFPEQmwc5buMiUNLkMQ=;
 b=ZxJ7ykFbD4O701mhlEJUdhvzwZvnuO9VqLn5N8Wkah3MTxAgaFEacDIZSUMFWcQbSE
 YvZHtGTu/Glfab571oxjPP5aquhgIqJT/DtC9MzQHR0Zuev+JEi0rP9HFdDGI7Cw9xUo
 k1qAeispx9Dh0QT6JBMtTr4lYm/WzMEFDJfDWFOe7fj5GjtDZNdrjmMKyQlPWG8U22Yx
 ElFmMLtqBQZqbj93tWyzuY2kKXU/gibntOpKTkwB0aFuPlJQXPOIsEPdqoIE5gy123rS
 yeCrESv/zmgi0hftMt55YgR9OO5KD9T3nannjWKCpieLHjh5MvAdYvDjfRCWKGIVunOp
 rhlg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777270888; x=1777875688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WBEy0yibVSgfkxKZVuaLnGBDMKFaSP3r4PBqiOv/S0s=;
 b=JQmdZ6mMCp6t/qq9SwMHKi7CM+tbvLJRCGRl6WtBQBIZ8lTdZdan2nt00h8XCA5GP/
 I3Hk0oOvqBKZO+qp3loMS/4FnXarDUqUmdawWFZQCwyD/Z4oNbFj61Tn301F6ulwTjVe
 ZIY/4g64PEyy1WiEi+JHpQOUix9NMiZiVIEt560/zdkgQQ4M7vASWLRXPDrnJFCcSe9I
 +tDfpQKb6gfiMb+Pkcn11nBS+2OD9IP12BMNBz4R5jLyfOAB2QNL5g5IFVRE3wslfKnW
 4mpEXR+TYDjfSucZd+q/uShrfCEMDb7Gqu98wjqPjkpEDRcwd7K927gezK8th2ENPDZY
 qnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270888; x=1777875688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBEy0yibVSgfkxKZVuaLnGBDMKFaSP3r4PBqiOv/S0s=;
 b=OSyIiS7+CgtEuHc/i4oQ39cnsVdh+96JV1JhMqNvQTHMLE8CXGNV7jYZoDcKBTCkCW
 cQVePKN6IWP1tQiONooJ9XiCtzBlTlwDq7SeQlyplkXV5Fl4AwZIHcSrgV73Lj4SEVzx
 VYIfU5VC2FPuhi87fUM7arfvR+irxdelun9zUG6x2DLXjj08mepeDnp/QseBiw2cFMqS
 w5ciImW7WxxI22LJ5vDZGnxrkWPCRZZ8ILaN6lZzN2rqS6y+Sf55h9udkpsE1nSHXlwB
 V1Wf+kxTakXDBeRuJdp66s3QY1WSuG9e3hWahO2jqzpe1JKMnHGUAHkT0oeiKdwazTzy
 4E2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ98ET0ZVqH7DHOwWYnU86iGy5wwrVtGfy+28Hr3r5VBnMWuFgtzelaPAipeEl4D6eZM30CLCdo=@lists.denx.de
X-Gm-Message-State: AOJu0YxHxDnO+H0GQAM0Z/d++bW/jHZd5IJ0+OP7zwFwOBXSirtnVpga
 5K/GKupqSNqUwWQU/PdwRz3xdsvluu8ipwpy5t7P2GbR0+CuEcXjBpxi7qPVz1IOWwr0YtxJfAJ
 y9ZxPodF+n15NwidB6+8jQz8o0OcJXTwfrxLrDS1bcQ==
X-Gm-Gg: AeBDiesVothSFvCOV2+WgVfyXKwQGHs1HZzn+kROknd2Sm5uxZSq9nJLALim+BQLwG+
 WYWNwWLtQP5DEMI5+4fD288Q+EQ3QCSvd9rnNoxyaW8M1FUgiqdKdhhV+C4AANOUKdRC4sp0sDO
 C3mWiBfuh/rqy6jkdDVrkwxZ2qpxHi8in6mhBCDIUvhWGAktsqE/hlClZsfzL9YLUXYMhEVQLqF
 +l7ldm4P54PDbs23SjU5F44OIpO3lPagrrxDEocMmwGMKpV/uD5WNgeKKsCjUfHpezUSNMnyoz3
 x1wvY5SCfTIAgdCxCPIk3O1iUagaNwyvXMA9xfSohljuMRF/GFbS/1+9Drg6IYIjcSuy3NBRkMx
 t9c/nMxvTpkyQBD7NVL2yaJFvSMUpqPTaYKa5yo1ixBCuvojSMd/xia4Z1np9sfcGj0piu37w3b
 lWjr18c1CgbI7mm1Fr4uZNb7rMz1IrDuuY+rOhvq0g4mFg4YpS5uH+wrQess0CRK4shOn68YEjK
 pPB70+r8PONcP5eLW9RgPc4QSxxpqrvBzbrQOFPtDVRM5STppi28l4Y8VthdLqw0d8d4HKGAi2S
 8daM6io4poIUtIMOqP0fM7JVSCqMc5Hs/up36tlBslls4B85EOaxY+ftPZ4CxPmqgnlfv2yAtWW
 jUX4dYlyCVmNdFM9B
X-Received: by 2002:a05:690e:4191:b0:650:21bd:e0e7 with SMTP id
 956f58d0204a3-65310a4db10mr34326323d50.44.1777270887761; Sun, 26 Apr 2026
 23:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
 <6944f28f-131f-4a08-9ef9-aae812926f4b@mailbox.org>
In-Reply-To: <6944f28f-131f-4a08-9ef9-aae812926f4b@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Apr 2026 09:20:51 +0300
X-Gm-Features: AQROBzAKVMJgg-xjy2794HBk60rtIWcSEBSqZCI_fsTwlP_hJ0QP6gNHshda7Gs
Message-ID: <CAC_iWj+ufWdroVDCh9qNAYfsjON5r_pdfOUgyB=h=b2b_rMVKg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] common: Add an option to relocate on ram top
To: Marek Vasut <marek.vasut@mailbox.org>
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

Hi Marek,

On Sun, 26 Apr 2026 at 19:35, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/16/26 7:59 AM, Ilias Apalodimas wrote:
> > Right now we only relocate u-boot to the top of the first
> > memory bank unless the board specific code overwrites it.
> > This is problematic when loading big binaries as it
> > fragments the contiguous memory space for no apparent reason.
> >
> > It's worth noting that there are cases where we must not relocate
> > above the 4GiB boundary (64bit hardware with 32bit only capable
> > DMA). E.g This will break platforms, if the ethernet
> > controller cannot DMA above 4 GiB, and once U-Boot does
> > get relocated above 4 GiB, the packet buffer which is built
> > into the U-Boot binary is also relocated above 4 GiB.
>
> On certain platforms, it is currently not possible to relocate U-Boot
> above the 32bit boundary, due to various dependencies on content located
> below the 32bit boundary. One such example is ethernet, where the packet
> buffer built into U-Boot binary is placed below the 32bit boundary and
> allows loading of data via ethernet even above 32bit boundary due to
> memory copy from the packet buffer to the destination location.
>
> > A previous patch moves the bi_dram[] info from bd to gd and make
> > the memory bank information available early. So move the
> > dram_init_banksize() INITCALL before the relocation address calculation
> > and use it to derive the address.
> >
> > Also add a Kconfig option and allow the common code to relocate U-Boot
> > to the top of the last discovered bank.
> >

[...]

>
> > +
> >   endif # EXPERT
> >
> >   config PHYS_64BIT
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 4ac22dca9e7c..f95e789257ad 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -339,7 +339,22 @@ static int setup_ram_base(void)
> >   static int setup_ram_config(void)
> >   {
> >       debug("Monitor len: %08x\n", gd->mon_len);
> > -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> > +
> > +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> > +             int bank;
> > +             phys_size_t total_size = 0;
> > +
> > +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > +                     if (gd->ram_top <= gd->bi_dram[bank].start)
> > +                             gd->ram_top = gd->bi_dram[bank].start +
> > +                                             gd->bi_dram[bank].size;
> > +                     total_size += gd->bi_dram[bank].size;
> > +             }
> > +             gd->ram_size = total_size;
>
> Shouldn't this also apply board_get_usable_ram_top() to be consistent ?

Simon asked the same thing. I'd rather keep this option strict for now
and always relocate to the upper memory boundary fnor now. Once I do
further cleanups, I can either add it or remove the function entirely
since dram_init_banksize() (which hs also board specific) runs really
early now.

>
> > +     } else {
> > +             gd->ram_top = gd->ram_base + get_effective_memsize();
> > +             gd->ram_top = board_get_usable_ram_top(gd->mon_len);
>
> Should this really use gd->mon_len as a parameter, or gd->ram_top?

I haven't really thought about thism since it's what we currently do.
In any case that's a change that needs to go on another patch.

>
> [...]
