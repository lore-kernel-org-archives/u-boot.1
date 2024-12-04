Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40758E7716E
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 15:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD748967E;
	Wed,  4 Dec 2024 16:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cuhnCWx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C48F989346; Wed,  4 Dec 2024 16:13:33 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F3F896F5
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 16:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-724fc1aaa91so6297202b3a.3
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 07:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733325208; x=1733930008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ckiCSsnBeVE5WApKxrhhaG1v6H5msjlRnbYrJzc5rbM=;
 b=cuhnCWx+FfZM5gZQ3I1fNi+x0NDldYKvqNXJs+ZuEsL8Ec1/W/ADD9MaT0uS6j9Yan
 PAxyuIrPM7Y/SVqoJXKFh9MPgXr6y0Rd4CkDoTuum0MnLr0N1bDeRr7wtlNbzNbhJimu
 6RsIBi0JKjzzLNH3llzZmR6FJXX6A4lS8VPsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733325208; x=1733930008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ckiCSsnBeVE5WApKxrhhaG1v6H5msjlRnbYrJzc5rbM=;
 b=MkokRJ8V6bdPixI1l5xs2hQmCKQ/38qGlQvATxXxjtYV69xMIH4Ksid5SRMJ05CUvv
 0LvQyQjq/tFv65wJ7p39ul6BN8jV9WzPkjllh8cbmInOOdZYmjIl7AEkIUaa+MLLwivp
 6JL0oiLlTbGiDsqrd0WqPrcuHmBKNuAVLK3NgmutE91dr1S+qnaBiCYhmCckCExJMOhR
 vDr1dhV69McYJXR/PVikcqpU2+g7doO9tQrXYSu9EE7m8eIcLNlbT/PKKSVVnuJ/TVv0
 nF66Jk1K3WQHruPCgzpJX4g+XN1miP+7U3LKPCSmjA53Rorclp4JqGbaGW5deIkImlmr
 vDXA==
X-Gm-Message-State: AOJu0YxmkkoOLyLjEHNvDbj7yAH+67D8wP7psu42ZL0Qt93K1XjKGNfG
 fTXjLt2vsJPBL1rMuv9G/qgTs4I+R6zD+Ek2gsEjwMj250unUvJr+jhIDjWplcW2NSMvVbJo8Sz
 tVETk0KJnvA4DujhRlpathjff5VeoWharSj0K
X-Gm-Gg: ASbGncsX2U58ICCVi7rkZaTPI0BOs0CboNyqfnT3CFut2l4oiNuu6lNOPO+50TeuMRv
 y9XuZFv6WbgHckBVjOP4auILgndQi8J8p
X-Google-Smtp-Source: AGHT+IGAjlulrRifHcEIFljL0rwCFAHUcIofyH7UTokpIQXLY18S3qgiD0QMZKw/ldzHH07xzGJwUU2gixw2GcphqMY=
X-Received: by 2002:a17:90b:4fc1:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2ef0125b0ccmr10463386a91.29.1733325207597; Wed, 04 Dec 2024
 07:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org> <Z1BrTaDcP0Aqk0Ym@hera>
In-Reply-To: <Z1BrTaDcP0Aqk0Ym@hera>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Dec 2024 08:13:10 -0700
Message-ID: <CAFLszTiAG2-bSPPy0iQ14bWwGpde2m=ExjQrZcg9Wnmc=KPXWg@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] efi: Tidy up confusion between pointers and
 addresses
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Janne Grunau <j@jannau.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Matthias Brugger <mbrugger@suse.com>, Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Wed, 4 Dec 2024 at 07:46, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Sun, Dec 01, 2024 at 08:24:19AM -0700, Simon Glass wrote:
> > The EFI-loader implementation converts things back and forth between
> > addresses and pointers, with not much consistency in how this is done.
> >
> > Within most of U-Boot a pointer is a void * and an address is a ulong
> >
> > This convention is very helpful, since it is obvious in common code as
> > to whether you need to call map_sysmem() and friends, or not.
> >
> > As part of cleaning up the EFI memory-management, I found it almost
> > impossible to know in some cases whether something is an address or a
> > pointer. I decided to give up on that and come back to it when this is
> > resolved.
> >
> > This series starts applying the normal ulong/void * convention to the
> > EFI_loader code, so making things easier to follow. For now, u64 is
> > often used instead of ulong, but the effect is the same.
> >
> > The main changes are:
> > - Rather than using the external struct efi_mem_desc data-structure for
> >   internal bookkeeping, create a new one, so it can have different
> >   semantics
> > - Within efi_memory.c addresses are used, rather than addresses
> >   masquerading as pointers. The conversions are done in efi_boottime
> >
> > Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/
>
> In v3 I did ask you to run SCT and spent some time on IRC to explain how to
> run it.
> The existing code passes all tests related to memory allocations.
> This patch introduced 99 failures in MemoryAllocationServicesTest.
> Apart from all the other feedback, SCT must pass.

Hmm I must be doing something wrong, as it passed for me. I'll try again.

Regards,
Simon
