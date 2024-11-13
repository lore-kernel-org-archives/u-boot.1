Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9885DD41C33
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 11:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD3C8905E;
	Wed, 13 Nov 2024 12:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gbkac4ZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5541A8905E; Wed, 13 Nov 2024 12:29:11 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1ECD8904C
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 12:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso6138110b3a.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 03:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731497347; x=1732102147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=91W9iX7UAyvG/MbT31rKAJzSjCQxpaJYJ5GJfihoSFM=;
 b=gbkac4ZT9d+o1tFN8AqmtIRS1+HDFmsuDiaYse2XVQQIojB9+PJzEwpmM09Sv275D9
 ra/U/HHHcdLDjVo/KJPb99YtoCirqy76DWFdq1oULM3bvwHZtD028iVysJuc1loxGnVU
 UvY7EOXYVxat+AzPvukxJOQogd1XsaIA0OeVPz5Q+nEjwiq0729X4fp4RiLlz2Dz/RMe
 +9K/innUbVC3Iz2h482QG6EhJN+idIOOn5fmMW5Kbq76ia8t8ZTVtQmb5JoOLfGhwXHo
 f1tBpEKKRqvZk5f+IO4OzhY485VGdkxcRPnlmn6P41+21VQJnq5URRPJ9p0wUe+FgvpP
 +GJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731497347; x=1732102147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=91W9iX7UAyvG/MbT31rKAJzSjCQxpaJYJ5GJfihoSFM=;
 b=G28zZOeXILoRpNcXDOzWs/JOFQD6dWBhMhsq4oa/G8LgL9/xi76izaUGDqI16v670B
 SpTtVLeezsn9wW3Cb4OIEwypQ77E1RgoKtLQ1OMccye3fEkxobdKDNJMVkHUKsMKTfXx
 k2nxbqLW5G+oHxZsxbTBC7/XXoTt0Xb8DIenDcGXGHjNmH3VGfNGt5r6pIaKG8cWvusI
 JBay2AS9osK1tetF7ed4AdkANYtp0YjBEjFCwbdN7EIzgN+nEpoRdkI/OgAb1ImSkDg/
 vaVIW76/GTAzxH21mtvQ2r6iNdKivhujQbEnjKq5bsGKhi7p6Cdz0HYSRRfJVn7cvtyr
 8UNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlpY8tjT6hr1Lr+oHEsk2hTxPw4VRC3z/n/C+hfZFP795Ydn/tzgKkVQgVYdR5HTrQl0Cp21M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1Nmnk0izqFrnS0vrWKtbw4qu/luMN3SEWyXYSMCwlMu48wK7X
 T9rAm5pubAm+UqWQHct1aTCou5ov2NFuxwm9QUjg1qa/pWsH2p8I3DmWoGoqyiQTDsMgtexBb5W
 6TCkRF9hg7TFegssR0hcGPc8+cwdgMQaUrBQ+pA==
X-Google-Smtp-Source: AGHT+IE2fY2YolCFyTzeiR92s94q8IPDr3a4Zyy2E0BUH39rDf+QrrwaLsXaF2oDY9iJrC0uZM96LhPfq1Wgas912iI=
X-Received: by 2002:a17:90b:1a8c:b0:2e2:cef9:4d98 with SMTP id
 98e67ed59e1d1-2e9b177bad9mr26384571a91.25.1731497347491; Wed, 13 Nov 2024
 03:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
 <CADg8p949qx=irjZKgf9-B4wtCYx1pDj29LFH86YR4T1zyKtAvg@mail.gmail.com>
In-Reply-To: <CADg8p949qx=irjZKgf9-B4wtCYx1pDj29LFH86YR4T1zyKtAvg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 13:28:31 +0200
Message-ID: <CAC_iWj+U945S96mE4E3d_bLxQ-9iQhErXBaJW0WCpLB1X=VVqQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Sughosh

On Tue, 12 Nov 2024 at 20:46, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> > patch. I am not sure how to investigate it.
> >
> > The boot hangs at some point during booting of the install image, before
> > the Ubuntu logo appears.
> >
> > I will sent a series with a script showing how it is run.
> >
> > This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>
> This seems to be an issue specific to the x86 architecture. The
> installation works on arm64 and riscv (confirmed by Heinrich)
> architectures. I checked the output of the EFI memory map with the
> above commit against the master branch, and the only difference is
> that with this revert, the EFI memory map has the u-boot memory region
> marked as EFI_BOOT_SERVICES_CODE, whereas without this commit, that
> region is marked as reserved.

Hmm why? LMB is adding this with EFI_BOOT_SERVICES_CODE  in
lmb_map_update_notify(). Who's switching it to reserved?
This is a pretty big change since the memory switches from reusable to
reserved for the OS.

> I need to look into this in more detail,
> but it would seem like the x86 kernel (or some efi stub code ?) is
> expecting some region of memory marked as EFI_BOOT_SERVICES_CODE,
> which is not the case for other architectures.

Not EFI_BOOT_SERVICES_CODE explicitly, probably just a reusable type of memory.

Cheers
/Ilias



>
> -sughosh
>
> >
> >  lib/efi_loader/efi_memory.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index d2f5d563f2a..c7400ec9854 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -809,6 +809,16 @@ static void add_u_boot_and_runtime(void)
> >  {
> >         unsigned long runtime_start, runtime_end, runtime_pages;
> >         unsigned long runtime_mask = EFI_PAGE_MASK;
> > +       unsigned long uboot_start, uboot_pages;
> > +       unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
> > +
> > +       /* Add U-Boot */
> > +       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> > +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> > +       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> > +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> > +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> > +                             false);
> >
> >  #if defined(__aarch64__)
> >         /*
> > --
> > 2.34.1
> >
