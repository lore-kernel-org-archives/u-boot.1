Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C88CC02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFEF380762;
	Wed,  5 Feb 2025 18:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mvRTDFBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC20807A7; Wed,  5 Feb 2025 18:35:03 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90CCB8070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5b1c4d14f2so7114276.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738776899; x=1739381699; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jhz+O8bVF8zfb8D5ZxKDkeE0esWVZXuykCbeYin4ABw=;
 b=mvRTDFBsjcgyyuFZpy+E0s9p98IjLOgQVX0CqI06W0odIjlum+oj4oyYK14VXVDIsm
 vwkg6gjwoYZVyeOSmgo6kCV0cBewfwUpA5CRaHy+FCNInb9ZMqDPrDFeHy0Qc7zLp/+u
 KjdNBhZgTHENWxS/4q5h7S7QjOXoeLfEWtjcfza4zULmbP312+OVDzLBOT9DOSTgU86M
 xy/J0El5qONsPZmLj2T9UmIEZsI3DeIE0cimlFo8jNwXz0PcyeD+D7pMCS8pSTOwIeUA
 g9HjZnB2lV/cBOL0BDVEQnZKgy104kNZ+gMyh0u/fsSRteCGRFka8x7E7GJetvgAG2M2
 pXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776899; x=1739381699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jhz+O8bVF8zfb8D5ZxKDkeE0esWVZXuykCbeYin4ABw=;
 b=cFeDaJyGs+TK+9XaDJyxZEBk3UL9K5rdb7iMGf2EK8TPGZId5rSZnX8WBdhsZRzJn9
 vMyABLEHKvD1iAQm9QhZx8YR8DjDKZwryfstAMy2RPZdsbzYhKRBaleeltghHE3wmVyv
 BCNkPFUbCATUKzaBshJAXi++LB5JveT3mXyxFNj3NRQizFl9IienJ3vw0Eujf+JHqi59
 brfr5tRffA4TwC3WxpX2xkGI5E765ODdtsYPxhkF5byAUJHJCuBwDg3Fvz29PjZaLKpn
 81AyOBB0ziKHic2UAKCL7TDmUzHZuVBPgSrUtGh3lLiom2J7iiprWTKAPt69Oeod6kwl
 121w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+xqy37Z2x43S5i7tY38BFB8BUjXmJ73GNv5ecUBu7vezHLq/3x/dcckhKqr5F82ClF+PexyA=@lists.denx.de
X-Gm-Message-State: AOJu0YybZfDjFPRExcY4KO0191EOVb9PdEgF7VvVfWlqAudsLFffoz8T
 sW9BFTocBQTVHs5Xju+1zh1+21ud9J9iIBN60Q0fUj4aAb3d3o8DLiN0TYdk+jj/qk977DI0Mqm
 BDvC3/xU8U4RV+kP9lzuPunSzcCZW+XVLfE//Tw==
X-Gm-Gg: ASbGncuCD1+ZH+SK8wKxrzgH2uO1KFa4Wpg8NxeyH5BwChEAdyQ/gO2i+gd+o/637qt
 pYo7W0Pl1/lhlRhy84TmKXGE19kOpYF09XotGujy2dVW3iJ/nyTVMsExPvVmGufeWjn075xWY
X-Google-Smtp-Source: AGHT+IHvzXFs8ER1SdAgeiHuLZyXdZRLiJTfvWuQE5AFH9GHlF/2+8NFc6zriV6ynh94bSfojcxztWLa4F8c45SlGyg=
X-Received: by 2002:a05:6902:2588:b0:e5b:2363:f8b7 with SMTP id
 3f1490d57ef6-e5b25a0a512mr2880126276.16.1738776899373; Wed, 05 Feb 2025
 09:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
 <6fbe4223-d478-4e72-b9a0-81aad67a6b43@linaro.org>
In-Reply-To: <6fbe4223-d478-4e72-b9a0-81aad67a6b43@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 19:34:23 +0200
X-Gm-Features: AWEUYZmPJApAicUCrMIHIJFEKcI-fqFWuxoL5NBlcwjCXWo0XOcpmUNie72nyxg
Message-ID: <CAC_iWj+5H_yaxdeKimN+b_Et=HeF6_B86okCBGQE_kD7pgCi4g@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, uboot-snps-arc@synopsys.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Richard,

On Wed, 5 Feb 2025 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/4/25 23:16, Ilias Apalodimas wrote:
> > @@ -98,18 +101,20 @@ SECTIONS
> >       }
> >   #endif
> >
> > -     . = ALIGN(8);
> > -     .rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> > +     .rodata ALIGN(4096): {
> > +         __start_rodata = .;
> > +         *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> > +         . = ALIGN(4096);
> > +         __end_rodata = .;
> > +     }
> >
> > -     . = ALIGN(8);
> > -     .data : {
> > +     .data ALIGN(4096) : {
> > +         __start_data = .;
> >               *(.data*)
> > +         . = ALIGN(4096);
> > +         __end_data = .;
> >       }
> >
> > -     . = ALIGN(8);
> > -
> > -     . = .;
> > -
> >       . = ALIGN(8);
> >       __u_boot_list : {
> >               KEEP(*(SORT(__u_boot_list*)));
> > @@ -136,10 +141,10 @@ SECTIONS
> >       /*
> >        * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
> >        */
> > -     .bss ALIGN(8) : {
> > +     .bss ALIGN(4096) : {
> >               __bss_start = .;
> >               *(.bss*)
> > -             . = ALIGN(8);
> > +             . = ALIGN(4096);
> >               __bss_end = .;
> >       }
>
> You don't need to align .bss because it normally immediately follows .data, and they have
> the same page permissions.
>
> You've got __u_boot_list, .efi_runtime_rel and .rela.dyn in between.  Consider if any of
> that ought to be moved around to become read-only.

That's a good idea and I just realized I am not setting the .bss to RW
in later patches.
I can move .bss right after data and rela.dyn after .rodata. That will
probably same me ~2 pages due to alignment. I am not sure about
__u_boot_list, but if that's read-only I can group it as well.

The .efi_runtime_rel is a bit weird. This is where the UEFI runtime
services live and it contains executable code. However, when an OS
boots up it can call SetVirtualAddressMap. That call relocates the
runtime code to the new VA mapping the OS choose. This means I have to
initially set it to RX and later when we leave the firmware land
switch it RWX so the OS can relocate it... I've left that part out on
purpose but I can move the runtime services as the last segment and
fix up weird logic on relocation in later patches

Thanks!
/Ilias
>
>
> r~
