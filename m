Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B435C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11CA780EC0;
	Thu, 20 Feb 2025 14:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xYtb2rHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CFB8007D; Thu, 20 Feb 2025 14:50:53 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC34380F53
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5dcc3b0c77so863757276.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059450; x=1740664250; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aIPXTg/Q9EOtBP45ea5d3FXh440Q8dfli1Ni5+1MLbs=;
 b=xYtb2rHV5PJmnQLAtlQ4wVnGhImi1AK6TyjIEQTLTUVZS30S8edJ6YiZpbKW6CTR+Q
 GLpPe5lHFXAtCV4RRhf7UAupophGH64aqTXf/0R2ZxCxyDYUEvMGdEukTkeO+SqmLJrr
 SOC9c33DrT5k5K1P91ya0MRqCvbJnsmE4rW+3aEc6U+KozsyPYDbfnSmW92uhVuZHFcE
 QaD6B6uxAtOSP3ibz4tEVFBEiHeE2sxFLo8UnTVwAMKGxnJN99J/IhRajqiBNqnjKfFR
 0jRZ+KiV400MgNpuc6Nop2FnC1mNdzyd1l7d2KtvCaIYJCGu3REShC3VxP7iTGuv4cYs
 kcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059450; x=1740664250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aIPXTg/Q9EOtBP45ea5d3FXh440Q8dfli1Ni5+1MLbs=;
 b=izEUTbRaeSZRMRb8Inskn3csJORAGdSxibu2spkx70fpkJLs8aHxswQMNthrxH0e8L
 NV7x0ywch69CjXnF2bz9+OPI7dgkFxtOCiWsa1I+iWZKVayhIe2lC2omhK3s9itULYmI
 UNi3d0HnArhRpWk1aBNv1uq1wSCKFMamf/HEJobpoe19zsfEGu05xy2tOv+ZNJabQiiA
 ABdyOyejXxOs1+h6veMneGmPWst5j4X+ans5jrosRmZTjOXl1wSLjuqKtLvJPanF4nhl
 qFteVNCEqpChZtOA/lX/uDILzIP2I/rOA69elkvQhZ4lP345pp2RXdQiOjawkNF+44De
 4WBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQgJ210Buw82ItedBlnJZN/mpozDJ98YgmRP7uPFCz0a8/DXidIE4/+C/mjKIbu7H6iqrBc6I=@lists.denx.de
X-Gm-Message-State: AOJu0YysCwjiBuQwvlPcXro0iOvh7aopNegEBFsNQi6sRAYcbw2qyX7S
 Md2N1gZjkFUp4jsozurkkSuB6RQKlrB3bzAYgrXWKRsHdAT2L4N9lWYb5O9MeYtG9drNugkBnsR
 PaFNkh/+wNNvucmKMTPPJ9F39NLnls0SrkcXfyA==
X-Gm-Gg: ASbGncu6Qli0CXrxeg0rhKeJj/zFXVBqkUEXT29KSFCO10vdkn+fzKnOj4CzC27Fb3b
 FewL5RHoZDDiAPmvE0Gwbn3A4E8Y8CIrTb1VbX8OsoJ5KB1w2pdrLH7CUDM9qZ2l9OjySXxjmZw
 ==
X-Google-Smtp-Source: AGHT+IHlbO9vVHUL2ft3tQX/JcGkQ0hf/BRX874/V/6kO/2CUA5x5h7G8dEcPImBfcdUB71Dke2tqtCFYuxiPeTpuIw=
X-Received: by 2002:a05:6902:18d1:b0:e5d:eba5:b87f with SMTP id
 3f1490d57ef6-e5e0a13fd80mr5970591276.41.1740059449141; Thu, 20 Feb 2025
 05:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20250210160727.30993-1-pkochanowski@sii.pl>
 <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
 <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
 <CAFLszTizFrZnRA49VoGrtgxmWiMSuL7Rip8Yk7tEAZVeNMcpwg@mail.gmail.com>
In-Reply-To: <CAFLszTizFrZnRA49VoGrtgxmWiMSuL7Rip8Yk7tEAZVeNMcpwg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 15:50:13 +0200
X-Gm-Features: AWEUYZlBCLSXKfMeU2Nz5d0znJG_ngwxzzWzPfln9r8sWZUtOavABsTG_dwdaQ8
Message-ID: <CAC_iWjL-Af-R6k8Pi3UECTja-FYa72B_td_yi5fy9aOmxs-i-w@mail.gmail.com>
Subject: Re: [PATCH] efi: Make FDT extra space configurable
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pawel Kochanowski <pkochanowski@sii.pl>, u-boot@lists.denx.de, 
 Gabriel Nesteruk <gnesteruk@sii.pl>
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

On Thu, 20 Feb 2025 at 15:31, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Thu, 20 Feb 2025 at 01:21, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 2/20/25 07:58, Ilias Apalodimas wrote:
> > > On Mon, 10 Feb 2025 at 18:07, Pawel Kochanowski <pkochanowski@sii.pl> wrote:
> > >>
> > >> From: Gabriel Nesteruk <gnesteruk@sii.pl>
> > >>
> > >> U-Boot currently reserves only 0x3000 bytes when copying the FDT
> > >> in `copy_fdt()`, which may not be sufficient if additional nodes
> > >> (such as FMAN firmware) are added later.
> > >>
> > >> This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
> > >> to allow users to define the amount of extra space reserved for FDT
> > >> expansion. The default remains 0x3000.
> > >>
> > >> This change prevents potential corruption when resizing FDT after
> > >> EFI boot, especially when firmware like FMAN requires additional
> > >> space.
> > >>
> > >> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> > >> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> > >> ---
> > >>   lib/efi_loader/Kconfig      | 9 +++++++++
> > >>   lib/efi_loader/efi_helper.c | 2 +-
> > >>   2 files changed, 10 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > >> index d4f6b56afaa..bd2cbe995c9 100644
> > >> --- a/lib/efi_loader/Kconfig
> > >> +++ b/lib/efi_loader/Kconfig
> > >> @@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
> > >>            No additional space will be required in the resulting U-Boot binary
> > >>            when this option is enabled.
> > >>
> > >> +config EFI_FDT_EXTRA_SPACE
> > >> +    hex "Extra space to allocate for FDT expansion"
> >
> > Hello Pawel,
> >
> > Is this problem really EFI specific? Wouldn't you have a similar problem
> > when booting via booti?
> >
> > >> +    default 0x3000
> > >> +    help
> > >> +      Defines additional space (in bytes) reserved for expanding the
> > >> +      Flattened Device Tree (FDT) when passed to the EFI system.
> > >> +      Increase this value if your firmware (e.g., FMAN) needs to add
> > >> +      more data to the device tree after U-Boot relocation.
> > >> +
> > >>   endif
> > >>
> > >>   source "lib/efi/Kconfig"
> > >> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > >> index 04b2efc4a3b..91b2a5b8653 100644
> > >> --- a/lib/efi_loader/efi_helper.c
> > >> +++ b/lib/efi_loader/efi_helper.c
> > >> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
> > >>           * needs to be expanded later.
> > >>           */
> > >>          fdt = *fdtp;
> > >> -       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> > >> +       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_EFI_FDT_EXTRA_SPACE);
> >
> > This is not the only place where the configuration value needs to be
> > considered:
> >
> > lib/efi_loader/efi_dt_fixup.c:171:
> >                                0x3000;
> >
> > Could you, please, send a new revision of your patch.
> >
> > Best regards
> >
> > Heinrich
> >
> > >>          fdt_size = fdt_pages << EFI_PAGE_SHIFT;
> > >>
> > >>          ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > >> --
> > >> 2.43.0
> > >>
> > >
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
>
> Let's do this instead, as it is generic:
>
> https://lore.kernel.org/u-boot/20241206131113.2865416-3-sjg@chromium.org/
>
> I believe the copy_fdt() function can just be removed, as the FDT is
> already in reserved memory. Putting it in the ACPI_RECLAIM region is
> wrong, too, as it is not an ACPI region.

That's not true. The EFI specification explicitly requests is as such.
ACPI_RECLAIM is a bit of an unfortunate misnomer, but it's memory the
OS can reclaim if it wants. IIRC Linux doesn't currently

/Ilias
>
> Regards,
> Simon
