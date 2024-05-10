Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E0C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 16:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4007B87FD7;
	Fri, 10 May 2024 18:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kt0WI7X5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A16587CF1; Fri, 10 May 2024 18:32:28 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934AF87C75
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 18:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2b5f3e20615so2012163a91.1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715358744; x=1715963544; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WVtAleKso6FF1LvRJxWPE1AI84qBZ6cenOTn5ZaXugc=;
 b=Kt0WI7X5Ny9J4ZqEB4KGFsSWoES0IOSsx7WhvwGbU1IWyhQAdmv7OAoUNWEfx35fMn
 9sn5/Sbuu1zhhQAi2+DZoQLRGxGDC0HJcCfjDS2YCm0YR7G3+HN+gohSRHI/R2Y8npEJ
 A6e5q/MWf4ATRGXfudBVpybJzA+7wgue6IiB0gJPJx/ZD0gIHfq+Fu6EGCiEOLFqz1bT
 ls+ZLYI+w0Tm2D9jtRvIjk133jHMUJZ+HUDohjnSQ6eCRIORZNAPERPU3d+2H/sUYOjT
 2Vg8yLYoAftBB9mhkjZHiVlVrzl77oObE2loUTp79Eu10rcctoy8qPOY9eUxioSyLqQP
 OSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715358744; x=1715963544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WVtAleKso6FF1LvRJxWPE1AI84qBZ6cenOTn5ZaXugc=;
 b=DpdXSIBRsPi4WaZRgvFQJFGUBcu0Ogwu1a6MmNdPi7KgPRpoxCM+82++VDpiIYvh2p
 qESIsfl6y0lxUocu049+Sj0tjCBNXJLAW3St5Af8zEKKIE7KFc0MU8SXNLkiCq1wM3SX
 fC5Gy/foqqEQvf45QRusjrPdJd7Gr9CNimv4w5QmidZiMCBpZ28zu3zz7P2ANtvuTe6e
 jBts26+ZqUs2KHa3gnECOzyubwuquUoOlRgESAANSnSeC7jnnE1h2jlNJr0V8lyUPudW
 lDEI7nm7+56wYonD5zA/d7zOmJnQ3MZFgEfl4pjYMwoVomVWrEtJ+CjOLolLsC+dKDNb
 DNNA==
X-Gm-Message-State: AOJu0Yz7L+fWFBgEp+HyV5eNYNCv8IkH9acH+CZLklYh53XGdodZIWWx
 Kt6yCugC2j+6TDN+/bPcpeH1pXZBBznnM3O+H0QYQ27tAs4WOfe4iOERFh84xfZJjeQckKd5Bj1
 nsZQibXHcFTQGyccdKwJp2XvsQ9osYJ1/6aNDuQ==
X-Google-Smtp-Source: AGHT+IGrQeSwiVjROQszz73ooqXpDAZpm83MtQ+GaLCdphQh8KVXTiGOi+JCB7C9sraLgjkMV41OwH9rJwTom6Iaf7o=
X-Received: by 2002:a17:90a:9601:b0:2ac:9baf:25b5 with SMTP id
 98e67ed59e1d1-2b6cc76f70emr2822977a91.25.1715358743966; Fri, 10 May 2024
 09:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
 <20240509143743.1496210-5-raymond.mao@linaro.org>
 <CAC_iWjL+kbQLG=QwBGfrcRpFU3bhCCcyXLCtwxdY86JcC=0Kmg@mail.gmail.com>
In-Reply-To: <CAC_iWjL+kbQLG=QwBGfrcRpFU3bhCCcyXLCtwxdY86JcC=0Kmg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 10 May 2024 12:32:12 -0400
Message-ID: <CAEfUkUJC7S+cwebJqh+TvbjYE6nEnczKwYELHYeN5iXBxoCpMw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm: EFI linker script text section alignment
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 9 May 2024 at 14:15, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> Try not to post the same patches without the fixes that were asked
> [0], at least not without an explanation.
>
> On Thu, 9 May 2024 at 17:38, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add text section alignment to fix sbsign signing warning
> > 'gaps in the section table may result in different checksums'
> > which causes a failure of efi_image_verify_diges()
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  arch/arm/lib/elf_aarch64_efi.lds | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/lib/elf_aarch64_efi.lds
> b/arch/arm/lib/elf_aarch64_efi.lds
> > index 5dd98091698..bffd9a0447a 100644
> > --- a/arch/arm/lib/elf_aarch64_efi.lds
> > +++ b/arch/arm/lib/elf_aarch64_efi.lds
> > @@ -28,6 +28,7 @@ SECTIONS
> >                 *(.dynamic);
> >                 . = ALIGN(512);
> >         }
> > +       . = ALIGN(4096);
>
> This is not what you want. There's already an ALIGN a few lines below
> and you must include the symbols for _etext and _text_size.
> You have to move the rela.* sections after the alignment. IIRC those
> were inspired by [1], so you can look for guidance there.
> On top of that riscv will need similar fixes (and any other
> architecture that uses those)
>
> In practice, I have to add  ALIGN(4096) for both `.rela.*` and `.data`,
otherwise it always prompts warning when signing the EFI image as
below and finally leads a failure when calling function
`efi_image_verify_digest()`.

```
warning: gap in section table:
    .text   : 0x00001000 - 0x00001c00,
    .data   : 0x00002000 - 0x00002200,
gaps in the section table may result in different checksums
warning: data remaining[7680 vs 12720]: gaps between PE/COFF sections?
```

I am not sure if RISC-V is working, never tried to build with that.
But arm32, x86 should be fine - they don't have the `.rela.*` sections and
text and data sections are well aligned.


> >         .rela.dyn : { *(.rela.dyn) }
> >         .rela.plt : { *(.rela.plt) }
> >         .rela.got : { *(.rela.got) }
> > --
> > 2.25.1
> >
>
> [0]
> https://lore.kernel.org/u-boot/CAC_iWjK+14L6mEi8GQN-McF-SChvhnjJ79nE1tWLV+kgWZKVew@mail.gmail.com/
> [1] https://git.code.sf.net/p/gnu-efi/code
>
>
Regards,
Raymond
