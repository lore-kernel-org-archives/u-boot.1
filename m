Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9A6C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 09:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378F080657;
	Wed, 15 Jan 2025 10:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jG+if1XH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B53880214; Wed, 15 Jan 2025 10:35:33 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86435806D4
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 10:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso10139035276.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 01:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736933729; x=1737538529; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W/ae25WIGqEOlh3H+5WnxJKJkAswrqzCm+mW9rJykOw=;
 b=jG+if1XHwTbNcdi7aBT9owdUroAtJJ9vQc/xnNUYUfgPo9uGWAWJQT3WXy+MtJB5mA
 vdWMD5hfjV3luL/ZcMLiEUr3tJcRVEA4XAMQS3yl3Qk1uI6icS4UiBfRY7yGflbiOVdz
 AL7fvy59PDT2p7MvpZplOYa8lkUgXIjr1wCO8igSjzIXZ821EPc/iU0Wcbl2fbZucGP3
 TP6Dr79mZ49WNkaXmx3PX/ge8yCKs9lXidYzbiLHqIRqRXX/AQSUzp2/+qDjAsJkyyun
 Zc1Rp1nemAY5upAYxwRWe6Dt3+HkcvO92HzZAPzIHp+a9sPDKZpg0V5gQ8MnR5b4hK22
 E4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736933729; x=1737538529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/ae25WIGqEOlh3H+5WnxJKJkAswrqzCm+mW9rJykOw=;
 b=iV7jUTQ3RrtcJwyVWWYpvu2oJVEB4i2hujwy8mK6bawiJLyJLnY340WCh7/HQnFX/J
 5ITJTSa/5UqE41YPFWlnlOJQtrtRpuNKV5eFQuEMrlinTATNyaKeImuY+Wzvwvtd+hQ+
 93EdBOo3clu2LaaFSiMtBFOYZeLjsMG2EUFaJ+Yk0V2xoAVWywJ2KAj7zNLwxad1xaBB
 E8006wa1sNgj8NiVgZuTejqaCFOf2j+P4/4wFvHhVTCZ/ejLscrg1ORAMrlQfnYdrFQo
 tFI+spDry3HdO7AsVdfM2UnBYgHdJZAoleZjFunfoCe5n+DNfpXgwfe8wesayuLhQfWW
 jdCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNkvdA2sYl10nt/xCcgqKBoIjsL0A6a+0PntXmf57Ct+xyG1OEaJaJUfry7dYIoq6/DXT4G68=@lists.denx.de
X-Gm-Message-State: AOJu0YyVSZ7Y+Tt5DDyFNzWUO2nDbCoCSuEgb55IYbZNclr0sU1O2z8X
 2TjFhLypzSn9JKLjlWIn9RFKMbtCXfw/I/+xDQNY49bJdfuvTq2cOVzc0y649/gqRFux3fpLcMv
 RU7el6xG4971wtJzgcJWIbaTOzsZCAhacAAxuIQ==
X-Gm-Gg: ASbGncsvMX62hBreyE8M1cSo+FGOIAv3d+krfIy9vcNkZkSB0+1UYMnPahzxfy2xL25
 5LizNvqfTGcwl2JFq8xnAhFq4QtHhXinawxLTSw==
X-Google-Smtp-Source: AGHT+IHuRDR3AusEW1InM4oBEPXFnPBFAiraKPnl7KFGuVIRAFYVVVHmGCfDdRIXdx/r07gHGzYmO/zRmOd0EuF98sI=
X-Received: by 2002:a05:690c:74c3:b0:6f5:241f:2725 with SMTP id
 00721157ae682-6f53121d675mr232617007b3.18.1736933729337; Wed, 15 Jan 2025
 01:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
 <20250114102953.64381-5-heinrich.schuchardt@canonical.com>
 <CAC_iWjJdT_pn89aq3m1RaZesQSiKRGEqz4dVhoN6ntz4=2xqPg@mail.gmail.com>
 <0b2d844f-3719-4b9e-a3b2-28c6cfe33ebe@canonical.com>
In-Reply-To: <0b2d844f-3719-4b9e-a3b2-28c6cfe33ebe@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 15 Jan 2025 11:34:53 +0200
X-Gm-Features: AbW1kvYyKg33iewTWfGvk3-c4cQ3_5O-5BlWo3C8wbx5HjZyhAU9UwUTzKq9BQE
Message-ID: <CAC_iWj+OR+-WdED-o=-W02NhVPvVWOoQe9mRQou2U7pjGRB6vA@mail.gmail.com>
Subject: Re: [PATCH 4/4] efi_loader: use include in ARM EFI linker script
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 15 Jan 2025 at 10:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 15.01.25 09:06, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> >
> > On Tue, 14 Jan 2025 at 12:30, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Use the same include as arm64 for the linker script.
> >>
> >> Adjust the 32-bit ARM PE-COFF header accordingly and harmonize it with the
> >> 64-bit ARM header.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   arch/arm/lib/crt0_arm_efi.S  | 37 ++++++++++---------
> >>   arch/arm/lib/elf_arm_efi.lds | 71 +-----------------------------------
> >>   2 files changed, 20 insertions(+), 88 deletions(-)
> >>
> >> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> >> index b5dfd4e3819..590fcf515da 100644
> >> --- a/arch/arm/lib/crt0_arm_efi.S
> >> +++ b/arch/arm/lib/crt0_arm_efi.S
> >> @@ -14,11 +14,11 @@
> >>          /*
> >>           * Magic "MZ" signature for PE/COFF
> >>           */
> >> -       .globl  image_base
> >> -image_base:
> >> +       .globl  ImageBase
> >> +ImageBase:
> >>          .short  IMAGE_DOS_SIGNATURE             /* 'MZ' */
> >>          .skip   58                              /* 'MZ' + pad + offset == 64 */
> >> -       .long   pe_header - image_base          /* Offset to the PE header */
> >> +       .long   pe_header - ImageBase           /* Offset to the PE header */
> >>   pe_header:
> >>          .long   IMAGE_NT_SIGNATURE              /* 'PE' */
> >>   coff_header:
> >> @@ -38,16 +38,16 @@ optional_header:
> >>          .short  IMAGE_NT_OPTIONAL_HDR32_MAGIC   /* PE32 format */
> >>          .byte   0x02                            /* MajorLinkerVersion */
> >>          .byte   0x14                            /* MinorLinkerVersion */
> >> -       .long   _edata - _start                 /* SizeOfCode */
> >> +       .long   _etext - _start                 /* SizeOfCode */
> >
> > Was that an error all along? Or the boundaries changed by using the
> > include file?
>
> According to https://learn.microsoft.com/en-us/windows/win32/debug/pe-format
>
> SizeOfCode:
> "The size of the code (text) section, or the sum of all code sections if
> there are multiple sections."
>
> We only have one code section.
>
> Looking at EDK2's Shell.efi SizeOfCode equals the VirtualSize of the
> .text section. It does not include the .data section.
>

Hmm that's interesting. gnu-efi includes .data AFAICT.
Looking at the pe/coff spec there's SizeOfCode and
SizeOfInitializedData (for .data) and SizeOfUninitializedData (for
.bss).
But in both gnu-efi and U-Boot we define those two as 0 though. So I
think we should either keep SizeOfData as is, or define it as you
propose and also define SizeOfInitializedData and
SizeOfUninitializedData correctly -- and I don't know if the latter
will have any implication on loaders.

Cheers
/Ilias
> Best regards
>
> Heinrich
>
> >
> >>          .long   0                               /* SizeOfInitializedData */
> >>          .long   0                               /* SizeOfUninitializedData */
> >> -       .long   _start - image_base             /* AddressOfEntryPoint */
> >> -       .long   _start - image_base             /* BaseOfCode */
> >> +       .long   _start - ImageBase              /* AddressOfEntryPoint */
> >> +       .long   _start - ImageBase              /* BaseOfCode */
> >>          .long   0                               /* BaseOfData */
> > [...]
> >
> > Other than that it looks ok
> >
> > Thanks for cleaning this up!
> > /Ilias
>
